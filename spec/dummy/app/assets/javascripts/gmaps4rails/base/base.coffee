
moduleKeywords = ['extended', 'included']

@Gmaps4Rails = {}

class @Gmaps4Rails.Base

  @extend: (obj) ->
    for key, value of obj when key not in moduleKeywords
      @[key] = value

    obj.extended?.apply(@)
    this

  @include: (obj) ->
    for key, value of obj when key not in moduleKeywords
      # Assign properties to the prototype
      @::[key] = value

    #console.log obj, this
    obj.included?.apply(@)
    this

  #//basic function to check existence of a variable
  exists : (var_name) ->
    return (var_name  != "" and typeof var_name != "undefined")

  #randomize
  randomize : (Lat0, Lng0) ->
    #distance in meters between 0 and max_random_distance (positive or negative)
    dx = @markers_conf.max_random_distance * @random()
    dy = @markers_conf.max_random_distance * @random()
    Lat = parseFloat(Lat0) + (180/Math.PI)*(dy/6378137)
    Lng = parseFloat(Lng0) + ( 90/Math.PI)*(dx/6378137)/Math.cos(Lat0)
    return [Lat, Lng]

  mergeObjectWithDefault : (object1, object2) ->
    copy_object1 = {}
    for key, value of object1
      copy_object1[key] = value

    for key, value of object2
      unless copy_object1[key]?
        copy_object1[key] = value
    return copy_object1

  mergeWithDefault : (objectName) ->
    default_object = @["default_" + objectName]
    object = @[objectName]
    @[objectName] = @mergeObjectWithDefault(object, default_object)
    return true

  #gives a value between -1 and 1
  random : -> return(Math.random() * 2 -1)

#window.Gmaps4Rails = Gmaps4Rails