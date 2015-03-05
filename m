From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/6] upload-pack: move "unshallow" sending code out of deepen()
Date: Thu,  5 Mar 2015 17:28:13 +0700
Message-ID: <1425551295-28653-5-git-send-email-pclouds@gmail.com>
References: <70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
 <1425551295-28653-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: philipoakley@iee.org
X-From: git-owner@vger.kernel.org Thu Mar 05 11:29:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTT1j-0003fT-U1
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 11:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbbCEK3E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2015 05:29:04 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33469 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396AbbCEK3B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 05:29:01 -0500
Received: by pdev10 with SMTP id v10so18842959pde.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 02:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dfwH1/p6zM/BtdssPJG4ZjJE7cvp+/hcPJKKAdSZ5NI=;
        b=AEcge1CwuML7c48EnhvIRlCdkWPkAZoyqsMom7oBNMYi2OtmWFOj2CpJGXxde7AHZG
         10q/Ms6zJgSOfpSdSZ0zw4iQMUCnJ710Zt5Ec2xK4CwDj66z/65hcJrq5vMIZc/t255E
         sBefJEbzzYxdMFxB34MPQQYNm2s7CMxZUFq0SI3rCTRmshpQ6WHlT3Vlph4BVP+ldMSQ
         G/l2+qo/Zx0RegUyFcbc/EFdxXfWMfUpxHwrCVuMKIkVbekyRP9XqyWiQ24kGLwQ4Sum
         uYvyvhF4PK+p7FbF2h4T6CFc58JtiWnJp5n4KdVc8zhotkFMX2m6ZsEnRdoTalT9lJLz
         N3pQ==
X-Received: by 10.70.53.226 with SMTP id e2mr14594265pdp.25.1425551340995;
        Thu, 05 Mar 2015 02:29:00 -0800 (PST)
Received: from lanh ([115.73.230.115])
        by mx.google.com with ESMTPSA id bl2sm6612589pad.15.2015.03.05.02.28.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2015 02:29:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Mar 2015 17:29:32 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425551295-28653-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264824>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 79f5525..69a3828 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -545,21 +545,10 @@ static void send_shallow(struct commit_list *resu=
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
-		result =3D
-			get_shallow_commits(&want_obj, depth,
-					    SHALLOW, NOT_SHALLOW);
-	send_shallow(result);
-	free_commit_list(result);
+
 	for (i =3D 0; i < shallows->nr; i++) {
 		struct object *object =3D shallows->objects[i].item;
 		if (object->flags & NOT_SHALLOW) {
@@ -582,6 +571,24 @@ static void deepen(int depth, const struct object_=
array *shallows)
 		/* make sure commit traversal conforms to client */
 		register_shallow(object->sha1);
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
+		result =3D
+			get_shallow_commits(&want_obj, depth,
+					    SHALLOW, NOT_SHALLOW);
+	send_shallow(result);
+	free_commit_list(result);
+	send_unshallow(shallows);
 	packet_flush(1);
 }
=20
--=20
2.3.0.rc1.137.g477eb31
