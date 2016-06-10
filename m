From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/27] upload-pack: move shallow deepen code out of receive_needs()
Date: Fri, 10 Jun 2016 19:26:50 +0700
Message-ID: <20160610122714.3341-4-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:29:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLXp-0000UD-Mr
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbcFJM2J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:28:09 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32840 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbcFJM2G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:28:06 -0400
Received: by mail-pa0-f68.google.com with SMTP id di3so5025842pab.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sovsKiQOiCn9/RBO76HCyqQHgctyGic1choKRUle/rE=;
        b=sdSM5o5j5gIHGCPn8gzcPaUpS711qJfVlw6J1nSllh+zzpcNrEdEcB/VHE0L67F/9g
         o6SLhxhzoI7PfzzWD2jE8VGmsWWgEvvY+CaHp0+INXHGVYd956Bb5E3sUXdwT+DtDdvm
         Eg974+6+WWUCOuDYj+4GuHUbOLWMpY46FXt4icTSw+jE0A85GrXURUBphF/h21RErd+C
         LcPWSz6fKdNB26A7HYquPzxEkg8PO8ru3ul4ndeO3i4GiXDxDsS7aR/73qlOtAovzO/F
         f/bjoJQnHTg3fRq5hz/DkU2C4q31LIYlCua6k4gyy0PsjkvMwqCruyynFJkPp5b53mkP
         ltlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sovsKiQOiCn9/RBO76HCyqQHgctyGic1choKRUle/rE=;
        b=JFDd9rHTOr5moSfGKq2uY849jD+VKNYV6HUUIrxvWZI4Q3N1EoFyI3O8lkTSiKWffA
         MZW+4qHk1KsCPNDvRB1vDzmnizj8lWcAjwCAMVsFipgUhMbLkspt7g4s2tGYE5RI/X/j
         wUC96pGh/mMHbN9NAezhLtK7nwvEqaSMoBOFhLdl6Tx7SvdUjNDpWM30/MKhC+O1Axxj
         Qxpp/Ewl7uNL9owRYetmeSx+0iH5D5O51WGF6XEUDOpLJyfrjmxv5tE9nC/8mgd3tx/L
         djQkPG6PlzCEt9f3hj/4S6QXLJ2i++KnzZMq/mv5M0mbIUKac+5RIT4sRrl5rie5jlYb
         HEyA==
X-Gm-Message-State: ALyK8tIgvLY0dHxEzgczYE174ZUbjNjIdakq4QCyFSOS536XRRgcpaWZBkSwQe6w4lfQ+Q==
X-Received: by 10.66.159.163 with SMTP id xd3mr2116220pab.23.1465561686149;
        Fri, 10 Jun 2016 05:28:06 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id s65sm4839938pfd.23.2016.06.10.05.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:28:05 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:28:01 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296981>

This is a prep step for further refactoring. Besides reindentation and
s/shallows\./shallows->/g, no other changes are expected.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 99 +++++++++++++++++++++++++++++++--------------------=
--------
 1 file changed, 52 insertions(+), 47 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index b3f6653..97ed620 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -538,6 +538,55 @@ error:
 	}
 }
=20
+static void deepen(int depth, const struct object_array *shallows)
+{
+	struct commit_list *result =3D NULL, *backup =3D NULL;
+	int i;
+	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
+		for (i =3D 0; i < shallows->nr; i++) {
+			struct object *object =3D shallows->objects[i].item;
+			object->flags |=3D NOT_SHALLOW;
+		}
+	else
+		backup =3D result =3D
+			get_shallow_commits(&want_obj, depth,
+					    SHALLOW, NOT_SHALLOW);
+	while (result) {
+		struct object *object =3D &result->item->object;
+		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
+			packet_write(1, "shallow %s",
+				     oid_to_hex(&object->oid));
+			register_shallow(object->oid.hash);
+			shallow_nr++;
+		}
+		result =3D result->next;
+	}
+	free_commit_list(backup);
+	for (i =3D 0; i < shallows->nr; i++) {
+		struct object *object =3D shallows->objects[i].item;
+		if (object->flags & NOT_SHALLOW) {
+			struct commit_list *parents;
+			packet_write(1, "unshallow %s",
+				     oid_to_hex(&object->oid));
+			object->flags &=3D ~CLIENT_SHALLOW;
+			/* make sure the real parents are parsed */
+			unregister_shallow(object->oid.hash);
+			object->parsed =3D 0;
+			parse_commit_or_die((struct commit *)object);
+			parents =3D ((struct commit *)object)->parents;
+			while (parents) {
+				add_object_array(&parents->item->object,
+						 NULL, &want_obj);
+				parents =3D parents->next;
+			}
+			add_object_array(object, NULL, &extra_edge_obj);
+		}
+		/* make sure commit traversal conforms to client */
+		register_shallow(object->oid.hash);
+	}
+	packet_flush(1);
+}
+
 static void receive_needs(void)
 {
 	struct object_array shallows =3D OBJECT_ARRAY_INIT;
@@ -630,53 +679,9 @@ static void receive_needs(void)
=20
 	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
 		return;
-	if (depth > 0) {
-		struct commit_list *result =3D NULL, *backup =3D NULL;
-		int i;
-		if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
-			for (i =3D 0; i < shallows.nr; i++) {
-				struct object *object =3D shallows.objects[i].item;
-				object->flags |=3D NOT_SHALLOW;
-			}
-		else
-			backup =3D result =3D
-				get_shallow_commits(&want_obj, depth,
-						    SHALLOW, NOT_SHALLOW);
-		while (result) {
-			struct object *object =3D &result->item->object;
-			if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
-				packet_write(1, "shallow %s",
-						oid_to_hex(&object->oid));
-				register_shallow(object->oid.hash);
-				shallow_nr++;
-			}
-			result =3D result->next;
-		}
-		free_commit_list(backup);
-		for (i =3D 0; i < shallows.nr; i++) {
-			struct object *object =3D shallows.objects[i].item;
-			if (object->flags & NOT_SHALLOW) {
-				struct commit_list *parents;
-				packet_write(1, "unshallow %s",
-					oid_to_hex(&object->oid));
-				object->flags &=3D ~CLIENT_SHALLOW;
-				/* make sure the real parents are parsed */
-				unregister_shallow(object->oid.hash);
-				object->parsed =3D 0;
-				parse_commit_or_die((struct commit *)object);
-				parents =3D ((struct commit *)object)->parents;
-				while (parents) {
-					add_object_array(&parents->item->object,
-							NULL, &want_obj);
-					parents =3D parents->next;
-				}
-				add_object_array(object, NULL, &extra_edge_obj);
-			}
-			/* make sure commit traversal conforms to client */
-			register_shallow(object->oid.hash);
-		}
-		packet_flush(1);
-	} else
+	if (depth > 0)
+		deepen(depth, &shallows);
+	else
 		if (shallows.nr > 0) {
 			int i;
 			for (i =3D 0; i < shallows.nr; i++)
--=20
2.8.2.524.g6ff3d78
