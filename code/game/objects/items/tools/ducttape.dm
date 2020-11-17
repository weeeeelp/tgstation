/obj/item/ducttaperoll
	name = "duct tape"
	desc = "A roll of sticky tape. Possibly for taping ducks... or was that ducts?"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "taperoll"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ducttaperoll/attack(var/mob/living/carbon/human/H, var/mob/user)
	if(istype(H))
		if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
			if(!H.get_bodypart(BODY_ZONE_HEAD))
				to_chat(user, "<span class='warning'>\The [H] doesn't have a head.</span>")
				return
			if(!H.getorganslot(ORGAN_SLOT_EYES))
				to_chat(user, "<span class='warning'>\The [H] doesn't have any eyes.</span>")
				return
			if(H.glasses)
				to_chat(user, "<span class='warning'>\The [H] is already wearing something on their eyes.</span>")
				return
			if(H.head && (H.head.flags_cover & HEADCOVERSEYES))
				to_chat(user, "<span class='warning'>Remove their [H.head] first.</span>")
				return
			user.visible_message("<span class='danger'>\The [user] begins taping over \the [H]'s eyes!</span>")

			if(!do_after(user, 3 SECONDS, H))
				return

			// Repeat failure checks.
			if(!H || !src || !H.get_bodypart(BODY_ZONE_HEAD) || !H.getorganslot(ORGAN_SLOT_EYES) || H.glasses || (H.head && (H.head.flags_cover & HEADCOVERSEYES)))
				return

			playsound(src, 'sound/effects/tape.ogg',25)
			user.visible_message("<span class='danger'>\The [user] has taped up \the [H]'s eyes!</span>")
			H.equip_to_slot_or_del(new /obj/item/clothing/glasses/blindfold/tape(H), SLOT_GLASSES)

		else if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH || user.zone_selected == BODY_ZONE_HEAD)
			if(!H.get_bodypart(BODY_ZONE_HEAD))
				to_chat(user, "<span class='warning'>\The [H] doesn't have a head.</span>")
				return
			if(!H.has_mouth())
				to_chat(user, "<span class='warning'>\The [H] doesn't have a mouth.</span>")
				return
			if(H.wear_mask)
				to_chat(user, "<span class='warning'>\The [H] is already wearing a mask.</span>")
				return
			if(H.head && (H.head.flags_cover & HEADCOVERSMOUTH))
				to_chat(user, "<span class='warning'>Remove their [H.head] first.</span>")
				return
			playsound(src, 'sound/effects/tape.ogg',25)
			user.visible_message("<span class='danger'>\The [user] begins taping up \the [H]'s mouth!</span>")
			message_admins("yeah")
			var/jeden = H.get_bodypart(BODY_ZONE_HEAD)
			var/dwa = H.has_mouth()
			var/trzy = H.wear_mask
			var/cztery = H.head && (H.head.flags_cover & HEADCOVERSMOUTH)
			message_admins("1: [jeden] 2: [dwa]  3: [trzy] 4: [cztery] ")
			if(!do_after(user, 3 SECONDS, H))
				return

			// Repeat failure checks.

			if(!H || !src || !H.get_bodypart(BODY_ZONE_HEAD) || !H.has_mouth() || H.wear_mask || (H.head && (H.head.flags_cover & HEADCOVERSMOUTH)))
				return
			playsound(src, 'sound/effects/tape.ogg',25)
			user.visible_message("<span class='danger'>\The [user] has taped up \the [H]'s mouth!</span>")
			H.equip_to_slot_or_del(new /obj/item/clothing/mask/muzzle/tape(H), SLOT_WEAR_MASK)

		else if(user.zone_selected == BODY_ZONE_L_ARM || user.zone_selected == BODY_ZONE_R_ARM)
			playsound(src, 'sound/effects/tape.ogg',25)
			var/obj/item/restraints/handcuffs/tape/T = new(user)
			if(!T.attack(H, user))
				message_admins("doingcuffs")
				qdel(T)

		else
			return ..()
		return 1


/obj/item/ducttape
	name = "piece of tape"
	desc = "A piece of sticky tape."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "tape"
	w_class = WEIGHT_CLASS_TINY
	layer = ABOVE_OBJ_LAYER

	var/obj/item/weapon/stuck = null
