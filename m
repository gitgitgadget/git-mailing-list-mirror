From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 03/25] upload-pack: move shallow deepen code out of receive_needs()
Date: Tue, 23 Feb 2016 20:44:41 +0700
Message-ID: <1456235103-26317-4-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:45:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDH7-0008CF-GX
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbcBWNpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:45:07 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35803 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbcBWNpF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:45:05 -0500
Received: by mail-pf0-f177.google.com with SMTP id c10so116375604pfc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9mHV3Ygh0cwmTB1UnISJg+Jo07oj9GOEYUBKA32OpXM=;
        b=JXE8uI53SV5J80oKg54hNyEg+oQC6y3z9tmYLlp67krd7NxGAwlBY1SaS9nkf5ZmeE
         ycG+cigrNYnKbt4x8nFkWofTqhfNtxEd4EgK+/N5YNs3veUSDwfGUEgTpG9Ir0o+WY1i
         HDI7ldj/uPzqr+RhB38pB1XvuLgtAePUPXeQbAN19hbAZoNGcl9y5M240ykuZ/GSUP9w
         3lMm/cP9riZcfy2xNEWEp1F+YC2zZnPcHxoM3Tgp67rIwVmzcztCu0y1CuwJVoYSg/Q1
         DxYpmcuEE4zx6IdsUVVXhTXFg8DJV19KltL/iIShYxuD9dFR4mg8tMD9UqMIMEKX7G2F
         fy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=9mHV3Ygh0cwmTB1UnISJg+Jo07oj9GOEYUBKA32OpXM=;
        b=KP27nK2+JcVLUhxmai+owoYED9Xi8h9PbX+sEUCcRjpn654w4/9XRlomek9gr1SQTc
         ayue5si5df+tShndhxXDV81/LVVMlHghwiFCAj9i3GMTuS1rYq0Q0LfLdDRYO33FtxtE
         Sa7CVmcayEiSE+3k3AYXQktsigPBZT7lodQE3vl97xmyekBwpOgtom1uiPl5EVSgYws8
         cdq9Ci5D59ohxOPzTkxGudwcc6lxK3Q3Z7tt25HQZIf6UXmM3+0SKyOUtlQ+ne023zgg
         yl41nxc6/qV7y2KfQBzLTFLySEcrqGisWqb/JAxODyO0h95q44UXBR9onf6ZuxrOppJW
         T05Q==
X-Gm-Message-State: AG10YOSMA9N61RC4Roj95gjkrk3qQORYPMR7WFxpFRH5tnXtDuXPjx8rQONL2CPZMICV6A==
X-Received: by 10.98.80.10 with SMTP id e10mr26719899pfb.141.1456235105171;
        Tue, 23 Feb 2016 05:45:05 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id ko9sm10228889pab.37.2016.02.23.05.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:45:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:45:34 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287055>

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
2.7.1.532.gd9e3aaa
