From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/20] upload-pack: move shallow deepen code out of receive_needs()
Date: Tue, 29 Dec 2015 19:10:24 +0700
Message-ID: <1451391043-28093-2-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:11:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt7O-00060u-7q
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbbL2MLF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:11:05 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35649 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbbL2MLE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:11:04 -0500
Received: by mail-pa0-f47.google.com with SMTP id do7so4703355pab.2
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=D6LyKesQ2A7DxspjI34DYRj25UFrZPoRVDwp4qrdDUI=;
        b=BzzwUSfuVkYypvnzPomT8enUuQ3lNqqXANlwBi55BwAwIM0jDi3oNtNFImNRwnsJWG
         nE/QkTIKxrpbvKgbS0VsD/vyKoIIh6bjRvvAgYSgFCJ8Hzt5kMu6NynusCZM4DXgcHtK
         HMS03v4ZYurgoKRHjJ1yiUJU9ZT/9W/1AxZS4HtUnOQskfyG7mg3/ankTWkZ/DN2kbUx
         j7QBUfAo0OnkXP9iKkNXiObiXTQ2k3mEyayBNx195uQQ0zL60366oaXlNL6POCa/5o6Y
         nlljefYTO6MZZkOow5KQ85QndhFpaRc0y2cdlSAQr17MU3/GdqH+5MaV69EjhayxAufa
         Fyxw==
X-Received: by 10.66.140.39 with SMTP id rd7mr85532969pab.86.1451391062982;
        Tue, 29 Dec 2015 04:11:02 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id x3sm21093859pfi.21.2015.12.29.04.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:11:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:10:58 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283111>

This is a prep step for further refactoring. Besides reindentation and
s/shallows\./shallows->/g, no other changes are expected.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
2.3.0.rc1.137.g477eb31
