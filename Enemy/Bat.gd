extends KinematicBody2D

var player = null
onready var ray = $RayCast2D
export var speed = 250
export var looking_speed = 100
	
func _physics_process(_delta):
	var check = true
	for i in get_slide_count():
		if check:
			var collision = get_slide_collision(i)
			if collision.collider != null:
				if collision.collider.name == "Player":
					collision.collider.call("die")
					check = false
	if player == null:
		player = get_node("/root/Game/Player_Container/Player")
	else:
		ray.cast_to = ray.to_local(player.global_position)
		var c = ray.get_collider()
		if c:
			var velocity = ray.cast_to.normalized()*looking_speed
			if c.name == "Player":
				velocity = ray.cast_to.normalized()*speed
			move_and_slide(velocity, Vector2(0,0))

