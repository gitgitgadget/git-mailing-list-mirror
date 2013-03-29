From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [Toy PATCH] Avoid spilling collided entries in object hash table to the next slots
Date: Fri, 29 Mar 2013 21:47:49 +0700
Message-ID: <1364568469-2250-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 29 15:48:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULabM-0003vV-Dl
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 15:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab3C2Orr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 10:47:47 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:34003 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab3C2Orq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 10:47:46 -0400
Received: by mail-pb0-f54.google.com with SMTP id rq13so285475pbb.13
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=DSN7dwrFvc0u2W6cLnH5X3Gt1LiLTPePnFt4oaFP1NM=;
        b=jHMUSrAFoJZ//6PlZYV003UPXD2LaL6lXqXHaJo+qQ3FWk1SWRCMUyKG7b9e2saoRs
         URamAYrpCuALP2Z2Re1TX0tNn14WAkjjuzt814bdfYfj42DFBdnOEhwWSUS0beTO48Gq
         WxvnybgcowtGMxpXNc2C/6FmmI7BmGX6tmkEF+3w8vxWGsKd/8lA1OZ/5eJciA5JhGUP
         xiWccsXSHiGEwBkhLKmxfOyWv/Xc7GWC0JNdSOt9wfErj4bvyS4UFYvzWno2pzDVDnqH
         Kd43bGXdBTCNko4EG1WiZPx10fUuR7W1Q7KQHVhYqypan2aPJXz76SH0bQKKBI09c0bR
         7DaQ==
X-Received: by 10.66.11.133 with SMTP id q5mr4827576pab.150.1364568465493;
        Fri, 29 Mar 2013 07:47:45 -0700 (PDT)
Received: from lanh ([115.74.55.89])
        by mx.google.com with ESMTPS id qb10sm3050309pbb.43.2013.03.29.07.47.42
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 29 Mar 2013 07:47:44 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 29 Mar 2013 21:47:50 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219500>

If a position in object hash table is taken, we currently check out
the next one. This could potentially create long object chains. We
could create linked lists instead and leave the next slot alone.

This patch relies on the fact that pointers are usually aligned more
than one byte and it uses the first bit as "object vs linked list"
indicator. Architectures that don't support this can fall back to
original implementation.

The saving is real, although not ground breaking. I'm just not sure it
is worth the ugliness that comes with this patch. Although we could
avoid the alignment problem by saving that bit in a separate bitmap.
"git rev-list --objects --all" on linux-2.6.git:

        before       after
real    0m33.407s    0m31.732s
user    0m32.926s    0m31.460s
sys     0m0.407s     0m0.202s

lookup_object() goes down from 30% to 27% in perf reports.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 object.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/object.c b/object.c
index bcfd2c6..7b013a0 100644
--- a/object.c
+++ b/object.c
@@ -8,6 +8,17 @@
 static struct object **obj_hash;
 static int nr_objs, obj_hash_size;
=20
+#ifdef USE_LINKED_LIST
+struct obj_list {
+	struct object *obj;
+	struct obj_list *next;
+};
+
+#define IS_LST(x) ((intptr_t)(x) & 1)
+#define MAKE_LST(x) (struct object *)((intptr_t)(x) | 1)
+#define GET_LST(x) (struct obj_list *)((intptr_t)(x) & ~1)
+#endif
+
 unsigned int get_max_object_index(void)
 {
 	return obj_hash_size;
@@ -53,13 +64,30 @@ static unsigned int hash_obj(struct object *obj, un=
signed int n)
 static void insert_obj_hash(struct object *obj, struct object **hash, =
unsigned int size)
 {
 	unsigned int j =3D hash_obj(obj, size);
+#ifdef USE_LINKED_LIST
+	struct obj_list *lst, *o;
+
+	if (!hash[j]) {
+		hash[j] =3D obj;
+		return;
+	}
=20
+	o =3D xmalloc(sizeof(*o));
+	o->obj =3D obj;
+
+	if (IS_LST(hash[j]))
+		o->next =3D GET_LST(hash[j]);
+	else
+		o->next =3D NULL;
+	hash[j] =3D MAKE_LST(o);
+#else
 	while (hash[j]) {
 		j++;
 		if (j >=3D size)
 			j =3D 0;
 	}
 	hash[j] =3D obj;
+#endif
 }
=20
 static unsigned int hashtable_index(const unsigned char *sha1)
@@ -78,6 +106,19 @@ struct object *lookup_object(const unsigned char *s=
ha1)
 		return NULL;
=20
 	i =3D hashtable_index(sha1);
+#ifdef USE_LINKED_LIST
+	if (IS_LST(obj_hash[i])) {
+		struct obj_list *lst;
+		for (lst =3D GET_LST(obj_hash[i]); lst; lst =3D lst->next) {
+			if (!hashcmp(lst->obj->sha1, sha1))
+				return lst->obj;
+		}
+		return NULL;
+	} else {
+		struct object *obj =3D obj_hash[i];
+		return obj && !hashcmp(sha1, obj->sha1) ? obj : NULL;
+	}
+#else
 	while ((obj =3D obj_hash[i]) !=3D NULL) {
 		if (!hashcmp(sha1, obj->sha1))
 			break;
@@ -86,6 +127,7 @@ struct object *lookup_object(const unsigned char *sh=
a1)
 			i =3D 0;
 	}
 	return obj;
+#endif
 }
=20
 void grow_object_hash_to(unsigned long nr)
--=20
1.8.2.83.gc99314b
