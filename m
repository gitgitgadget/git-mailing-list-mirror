From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Toy PATCH] Avoid spilling collided entries in object hash table
 to the next slots
Date: Fri, 29 Mar 2013 11:33:46 -0700
Message-ID: <7vsj3enjhx.fsf@alter.siamese.dyndns.org>
References: <1364568469-2250-1-git-send-email-pclouds@gmail.com>
 <7vd2uip1p4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 19:34:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULe83-0006NQ-3k
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 19:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab3C2Sdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 14:33:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33903 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756452Ab3C2Sdt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Mar 2013 14:33:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6664E295;
	Fri, 29 Mar 2013 18:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FRZVGhHzbHYY
	bv/my4V6ybdiEKg=; b=QwGhzHQPoYOCcrALor3XD6+nLIcn9MrxoMNdFg97J4Db
	Yo7c1Mi13+vYtA4kAagd4tzrcCX38+gXaMHgQLstZgrEGJBjhkJhmsCoYKZq0RDr
	zklYEHYixu6iHdsG/5+LGqrTAVq7G721iqCfHfKzjW+rnWGD11UQRG1Ajcuygjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EfVVsf
	/X2ybhyJJ8VvYTpv1Yj/OcPlFbjrLdqgMH8pGH1HoLXNO4tfJtUJ6c5TkRSaWTUG
	DDBAqO9589lwDEuVB7niYd4CN+mEp384CNaUNwYPwcgJhPeaPV/Jdq3/fCnV9jKq
	v/wSQ5fX/kg3m5DgQ0h4UxoYFnIUapUdxI+h0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE1D0E294;
	Fri, 29 Mar 2013 18:33:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6F26E293; Fri, 29 Mar 2013
 18:33:47 +0000 (UTC)
In-Reply-To: <7vd2uip1p4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 29 Mar 2013 10:15:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31EF695E-989F-11E2-88D5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219519>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> If a position in object hash table is taken, we currently check out
>> the next one. This could potentially create long object chains. We
>> could create linked lists instead and leave the next slot alone.
>
> In the current code, not just the logic in lookup_object(), but the
> logic to enforce load factor when create_object() decides to call
> grow_object_hash() and object enumeration implemented by
> get_max_object_index() and get_indexed_object() are closely tied to
> the open addressing scheme.  If you want to switch to any other
> method (e.g. separate chaining) these need to be updated quite a
> bit.
>
> I do not see get_max_object_index() and get_indexed_object() updated
> at all.  Do fsck, index-pack, name-rev and upload-pack still work?

You may want to start with a bit more abstraction around the
hashtable API.  Perhaps like this?

The idea is to let your object enumerator to be not just a simple
unsigned int into the flat hashtable, but be something like

	typedef struct {
        	unsigned int slot;
                struct obj_list *list;
	} object_enumerator;

You store the current index in obj_hash[] to enu.slot, and if that
is IS_LST(), the linked-list element you are looking at in enu.list.
When you "increment" the iterator in object_enumerator_next(), you
increment enu.slot only after you reach the tail of the enu.list.



 builtin/fsck.c       | 17 ++++++++++-------
 builtin/index-pack.c | 11 +++++++----
 builtin/name-rev.c   | 20 +++++++++++---------
 object.c             | 22 +++++++++++++++++++---
 object.h             |  8 ++++++--
 upload-pack.c        | 23 ++++++++++++++---------
 6 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index bb9a2cd..5688cad 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -270,22 +270,25 @@ static void check_object(struct object *obj)
=20
 static void check_connectivity(void)
 {
-	int i, max;
+	int max;
+	object_enumerator enu;
=20
 	/* Traverse the pending reachable objects */
 	traverse_reachable();
=20
 	/* Look up all the requirements, warn about missing objects.. */
-	max =3D get_max_object_index();
+	max =3D begin_object_enumeration(&enu);
 	if (verbose)
 		fprintf(stderr, "Checking connectivity (%d objects)\n", max);
=20
-	for (i =3D 0; i < max; i++) {
-		struct object *obj =3D get_indexed_object(i);
-
-		if (obj)
-			check_object(obj);
+	if (max) {
+		do {
+			struct object *obj =3D get_enumerated_object(&enu);
+			if (obj)
+				check_object(obj);
+		} while (object_enumeration_next(&enu));
 	}
+	end_object_enumeration(&enu);
 }
=20
 static int fsck_obj(struct object *obj)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ef62124..1d5b65c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -195,11 +195,14 @@ static void check_object(struct object *obj)
=20
 static void check_objects(void)
 {
-	unsigned i, max;
+	object_enumerator enu;
=20
-	max =3D get_max_object_index();
-	for (i =3D 0; i < max; i++)
-		check_object(get_indexed_object(i));
+	if (begin_object_enumeration(&enu)) {
+		do {
+			check_object(get_enumerated_object(&enu));
+		} while (object_enumeration_next(&enu));
+	}
+	end_object_enumeration(&enu);
 }
=20
=20
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 6238247..239c3ef 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -286,16 +286,18 @@ int cmd_name_rev(int argc, const char **argv, con=
st char *prefix)
 			name_rev_line(p, &data);
 		}
 	} else if (all) {
-		int i, max;
-
-		max =3D get_max_object_index();
-		for (i =3D 0; i < max; i++) {
-			struct object *obj =3D get_indexed_object(i);
-			if (!obj || obj->type !=3D OBJ_COMMIT)
-				continue;
-			show_name(obj, NULL,
-				  always, allow_undefined, data.name_only);
+		object_enumerator enu;
+
+		if (begin_object_enumeration(&enu)) {
+			do {
+				struct object *obj =3D get_enumerated_object(&enu);
+				if (!obj || obj->type !=3D OBJ_COMMIT)
+					continue;
+				show_name(obj, NULL,
+					  always, allow_undefined, data.name_only);
+			} while (object_enumeration_next(&enu));
 		}
+		end_object_enumeration(&enu);
 	} else {
 		int i;
 		for (i =3D 0; i < revs.nr; i++)
diff --git a/object.c b/object.c
index 20703f5..f5b754f 100644
--- a/object.c
+++ b/object.c
@@ -8,14 +8,30 @@
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
=20
-unsigned int get_max_object_index(void)
+unsigned int begin_object_enumeration(object_enumerator *enu)
 {
+	*enu =3D 0;
 	return obj_hash_size;
 }
=20
-struct object *get_indexed_object(unsigned int idx)
+struct object *get_enumerated_object(object_enumerator *enu)
 {
-	return obj_hash[idx];
+	int ix =3D *enu;
+
+	if (obj_hash_size <=3D ix)
+		die("BUG: get_enumerated_object() called beyond the end");
+	return obj_hash[*enu];
+}
+
+int object_enumeration_next(object_enumerator *enu)
+{
+	return ++*enu < obj_hash_size;
+}
+
+void end_object_enumeration(object_enumerator *enu)
+{
+	/* Nothing to free (yet) */
+	;
 }
=20
 static const char *object_type_strings[] =3D {
diff --git a/object.h b/object.h
index 97d384b..5435d58 100644
--- a/object.h
+++ b/object.h
@@ -35,8 +35,12 @@ struct object {
 extern const char *typename(unsigned int type);
 extern int type_from_string(const char *str);
=20
-extern unsigned int get_max_object_index(void);
-extern struct object *get_indexed_object(unsigned int);
+typedef unsigned int object_enumerator;
+
+extern unsigned int begin_object_enumeration(object_enumerator *);
+extern struct object *get_enumerated_object(object_enumerator *);
+extern int object_enumeration_next(object_enumerator *);
+extern void end_object_enumeration(object_enumerator *);
=20
 /*
  * This can be used to see if we have heard of the object before, but
diff --git a/upload-pack.c b/upload-pack.c
index f5673ee..618b211 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -502,6 +502,7 @@ static void check_non_tip(void)
 	struct object *o;
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 	int i;
+	object_enumerator enu;
=20
 	/* In the normal in-process case non-tip request can never happen */
 	if (!stateless_rpc)
@@ -525,16 +526,20 @@ static void check_non_tip(void)
=20
 	namebuf[0] =3D '^';
 	namebuf[41] =3D '\n';
-	for (i =3D get_max_object_index(); 0 < i; ) {
-		o =3D get_indexed_object(--i);
-		if (!o)
-			continue;
-		if (!is_our_ref(o))
-			continue;
-		memcpy(namebuf + 1, sha1_to_hex(o->sha1), 40);
-		if (write_in_full(cmd.in, namebuf, 42) < 0)
-			goto error;
+
+	if (begin_object_enumeration(&enu)) {
+		do {
+			o =3D get_enumerated_object(&enu);
+			if (!o)
+				continue;
+			if (!is_our_ref(o))
+				continue;
+			memcpy(namebuf + 1, sha1_to_hex(o->sha1), 40);
+			if (write_in_full(cmd.in, namebuf, 42) < 0)
+				goto error;
+		} while (object_enumeration_next(&enu));
 	}
+	end_object_enumeration(&enu);
 	namebuf[40] =3D '\n';
 	for (i =3D 0; i < want_obj.nr; i++) {
 		o =3D want_obj.objects[i].item;
