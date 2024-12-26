extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 50

func _on_process(_delta : float) -> void:
    pass

func _on_physics_process(_delta : float) -> void:
    if player == null:
        print("Player is null in _on_physics_process")
        return

    var direction: Vector2 = GameInputEvents.movement_input()

    if direction == Vector2.UP:
        animated_sprite_2d.play("walk_back")
    elif direction == Vector2.RIGHT:
        animated_sprite_2d.play("walk_right")
    elif direction == Vector2.DOWN:
        animated_sprite_2d.play("walk_front")
    elif direction == Vector2.LEFT:
        animated_sprite_2d.play("walk_left")

    if direction != Vector2.ZERO:
        player.player_direction = direction

    player.velocity = direction * speed
    player.move_and_slide()

func _on_next_transitions() -> void:
    if player == null:
        print("Player is null in _on_next_transitions")
        return

    if !GameInputEvents.is_movement_input():
        transition.emit("Idle")

func _on_enter() -> void:
    print("Entering walk state")
    var parent = get_parent()
    print("Parent node: ", parent)
    player = parent.get_parent().get_node("/root/TestSceneTilemap/Player")
    if player == null:
        print("Player is null in _on_enter")
    else:
        print("Player initialized in _on_enter")

func _on_exit() -> void:
    pass