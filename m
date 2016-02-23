From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 06/25] upload-pack: move "unshallow" sending code out of deepen()
Date: Tue, 23 Feb 2016 20:44:44 +0700
Message-ID: <1456235103-26317-7-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:48:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDK0-0001z0-0i
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbcBWNry convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:47:54 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34935 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbcBWNpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:45:25 -0500
Received: by mail-pf0-f174.google.com with SMTP id c10so116379745pfc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FafuH2Uy03ke5z05O8eXiFqAbZ+sqHb2vd30GNJVRDg=;
        b=IlNp3OXYC/opnugsqwqf5AzwwqsNUi3aNH0+3hYIJldm1aEX864/j1HPlV88yBpV3g
         D2xy040IPLPG8f8xy2kqyUzbb0FCNXzqdzKx0Z09h8hvpDUR6dnPvW0hQjcW9IIHtQUq
         gMr81AC+TidfeX568MbEet5cIgkBMC28qqQTnVQkBCHzFO/urFhPgFGAe9Bwg+mU+R+U
         2G3vQQ8XQMxBbO3nqnHeolqqc1VlIu4ychj+orcAPhCOb0oK/I2VA7yDlwtyfZOhrWk0
         OpqC7zUqvLHRwS/30IjXZLNdtUmYqU/Xli833VfdyIf4ygLJ0YIDPLzE74CVt7hg17j0
         LcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=FafuH2Uy03ke5z05O8eXiFqAbZ+sqHb2vd30GNJVRDg=;
        b=KzPKWHhzZ5zRclmSykzaY65gIwwp2Uyd45oWYY6whuTB7+VgPDHZxvcXKf6TXUPgBr
         m8R/6WOb7O9Yuit1iHenODDpBhDaAZy4RkRzR7G9CtcOuP1fueDP/KaJhZ1XTzpoVJki
         XJuCfi9fdpBbaxjtBSSIhBeKS0NXJRMNRVV4nI3FGuTfnP43WdBTXcdq9IldLljL6j+a
         Wz/nPZmYaIyZuxG+LtVPqrmROTfiQ2xvVyUECFNuM1tYdqrooa2TlPmlmzLG28qDaK0m
         z0JVfaUxHJ7RXmVFw72Fb4IuovDOTuM4q7YCb5F/64QzQq3J4q5Yoi5VDsxSrJso5RJM
         PpUA==
X-Gm-Message-State: AG10YOSGrHN6/L12jyUsoEBRpMR2GJSO0KlKZsxOu8SwAdwW4AsbJ9RGUVPfe5skcMhm1g==
X-Received: by 10.98.70.211 with SMTP id o80mr45856337pfi.124.1456235124907;
        Tue, 23 Feb 2016 05:45:24 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id x12sm44398993pfi.88.2016.02.23.05.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:45:23 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:45:52 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287077>

Also add some more comments in this code because it takes too long to
understand what it does (to me, who should be familiar enough to
understand this code well!)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index ee5d20b..bfb7985 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -552,20 +552,10 @@ static void send_shallow(struct commit_list *resu=
lt)
 	}
 }
=20
-static void deepen(int depth, const struct object_array *shallows)
+static void send_unshallow(const struct object_array *shallows)
 {
-	struct commit_list *result =3D NULL;
 	int i;
-	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
-		for (i =3D 0; i < shallows->nr; i++) {
-			struct object *object =3D shallows->objects[i].item;
-			object->flags |=3D NOT_SHALLOW;
-		}
-	else
-		result =3D get_shallow_commits(&want_obj, depth,
-					     SHALLOW, NOT_SHALLOW);
-	send_shallow(result);
-	free_commit_list(result);
+
 	for (i =3D 0; i < shallows->nr; i++) {
 		struct object *object =3D shallows->objects[i].item;
 		if (object->flags & NOT_SHALLOW) {
@@ -573,7 +563,13 @@ static void deepen(int depth, const struct object_=
array *shallows)
 			packet_write(1, "unshallow %s",
 				     oid_to_hex(&object->oid));
 			object->flags &=3D ~CLIENT_SHALLOW;
-			/* make sure the real parents are parsed */
+			/*
+			 * We want to _register_ "object" as shallow, but we
+			 * also need to traverse object's parents to deepen a
+			 * shallow clone. Unregister it for now so we can
+			 * parse and add the parents to the want list, then
+			 * re-register it.
+			 */
 			unregister_shallow(object->oid.hash);
 			object->parsed =3D 0;
 			parse_commit_or_die((struct commit *)object);
@@ -588,6 +584,23 @@ static void deepen(int depth, const struct object_=
array *shallows)
 		/* make sure commit traversal conforms to client */
 		register_shallow(object->oid.hash);
 	}
+}
+
+static void deepen(int depth, const struct object_array *shallows)
+{
+	struct commit_list *result =3D NULL;
+	int i;
+	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
+		for (i =3D 0; i < shallows->nr; i++) {
+			struct object *object =3D shallows->objects[i].item;
+			object->flags |=3D NOT_SHALLOW;
+		}
+	else
+		result =3D get_shallow_commits(&want_obj, depth,
+					     SHALLOW, NOT_SHALLOW);
+	send_shallow(result);
+	free_commit_list(result);
+	send_unshallow(shallows);
 	packet_flush(1);
 }
=20
--=20
2.7.1.532.gd9e3aaa
