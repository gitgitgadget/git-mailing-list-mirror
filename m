From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] upload-pack: move "shallow" sending code out of deepen()
Date: Thu,  5 Mar 2015 17:28:11 +0700
Message-ID: <1425551295-28653-3-git-send-email-pclouds@gmail.com>
References: <70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
 <1425551295-28653-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: philipoakley@iee.org
X-From: git-owner@vger.kernel.org Thu Mar 05 11:29:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTT1X-0003UJ-LY
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 11:29:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbbCEK2v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2015 05:28:51 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34824 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396AbbCEK2t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 05:28:49 -0500
Received: by pdbfp1 with SMTP id fp1so14298103pdb.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 02:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oYk6ayrZcaLYgZZuYeaWSqT5CzvsYBaE+Q1BXeQQD2o=;
        b=LyBMgvnGQLlC0Ag3QHOr7dssk+AJbgGQQ3Ru2TTYd+zp1RLrhhXlgcisDq8bQbRpoI
         VFg2BEsc39FCCnaM/aPTFyxFc2sB0fuRrKch8vMBbpCE9VOuEsckewCNxwBojCkerN5s
         7wXREmNPMuEnYq2hemKz35+e4Q+mdhpRAN2IP1IUd0n7v0TPHnypmuhXXZkhQAokuxb/
         ytQKm+gypRA9lXzbpCK4wVNt2t4Dan7uvBhnI9gWEDtI1//has0hCQhcba2hl2oFPUqx
         /DWFdq8rFOzSyxkejNDqp6BfTb3BzeTFqnSSmFf7t+Un+C9Hgc4AWQuO7x1l2+igEwYU
         +/dA==
X-Received: by 10.70.37.202 with SMTP id a10mr14902672pdk.108.1425551329054;
        Thu, 05 Mar 2015 02:28:49 -0800 (PST)
Received: from lanh ([115.73.230.115])
        by mx.google.com with ESMTPSA id qz3sm6616197pab.13.2015.03.05.02.28.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2015 02:28:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Mar 2015 17:29:20 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425551295-28653-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264823>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 74f48f9..ea030f3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -531,6 +531,20 @@ error:
 	}
 }
=20
+static void send_shallow(struct commit_list *result)
+{
+	while (result) {
+		struct object *object =3D &result->item->object;
+		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
+			packet_write(1, "shallow %s",
+				     sha1_to_hex(object->sha1));
+			register_shallow(object->sha1);
+			shallow_nr++;
+		}
+		result =3D result->next;
+	}
+}
+
 static void deepen(int depth, const struct object_array *shallows)
 {
 	struct commit_list *result =3D NULL, *backup =3D NULL;
@@ -544,16 +558,7 @@ static void deepen(int depth, const struct object_=
array *shallows)
 		backup =3D result =3D
 			get_shallow_commits(&want_obj, depth,
 					    SHALLOW, NOT_SHALLOW);
-	while (result) {
-		struct object *object =3D &result->item->object;
-		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
-			packet_write(1, "shallow %s",
-				     sha1_to_hex(object->sha1));
-			register_shallow(object->sha1);
-			shallow_nr++;
-		}
-		result =3D result->next;
-	}
+	send_shallow(result);
 	free_commit_list(backup);
 	for (i =3D 0; i < shallows->nr; i++) {
 		struct object *object =3D shallows->objects[i].item;
--=20
2.3.0.rc1.137.g477eb31
