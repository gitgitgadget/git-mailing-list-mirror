From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 04/25] upload-pack: move "shallow" sending code out of deepen()
Date: Tue, 23 Feb 2016 20:44:42 +0700
Message-ID: <1456235103-26317-5-git-send-email-pclouds@gmail.com>
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
	id 1aYDHF-0008HM-86
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:45:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbcBWNpN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:45:13 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36012 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbcBWNpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:45:11 -0500
Received: by mail-pa0-f41.google.com with SMTP id yy13so110642181pab.3
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=U5VlKG7MsdgaRDW5drf3jel3WHE0FAJxIPwem+R3QSU=;
        b=g55ywttYROGD+CJaBf0ynNRX8ycKVGgzOtA7RzmgsguSJe2dVghui65WxyosM/EX9H
         8rhRW6zX6Gb9oBCutQZmA8iaDwxkMKsf+WHxHqhmVzOA9+YoIYuLBlO9ED1JtQxaTNgi
         DW0sc7XTiErxH8Q1zdMgzSu51/H0x2VQ7kctSYZkH3y/th8flg8QuW5oZ07pSJ/607NZ
         u6Krx96fbM/vV4fPcL+0wS/Q4aFcF0KW9bXK7P7LElQ6mR6+POitcohwD1gtes2aF+9N
         uysvpTII6wVvXxKVTIK2QgxR4FdgULh3lyJ9kf29qwW+EIpquqMQdSBXF0O9CewxGyC9
         ZyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=U5VlKG7MsdgaRDW5drf3jel3WHE0FAJxIPwem+R3QSU=;
        b=UDMUGwS+JNeJzME53771RXEa9nppWJY1c0xkrERkx7St2r7MaXvFrmL5AZ73pExmon
         Dfy8tBJkFrW0tJ49Tv7DvGAIh1U3DvcnRcL9HoM8/hCW5PrLF6LK9OGjtMv4WXE/1oBJ
         UAWx04aXCPf0byy4uaiqRtVTBWT8gNyQph5m0l6fC41jtFIoqA0GxGvuvBSX9Rb6jn+w
         S38BN4iHymz8pDuQJBgGntuyjD2OuukGDQNx9RFpkKIeUpms30PWouaQXqNvpWLR4Jau
         v/tSDvXrG3I2qGBUG1UwmW/6VvcsETbLEYbEeWFFW9+xbJP81eVgaDHWqhYcXt0P/Ni6
         Yg9g==
X-Gm-Message-State: AG10YOSBdRkpI8DXTRgzUaUZe9R9+laQGN/jkJNsUv9nxjSZtaCpYDqmbAXPsFq1DG/euA==
X-Received: by 10.66.102.106 with SMTP id fn10mr46777082pab.60.1456235111323;
        Tue, 23 Feb 2016 05:45:11 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id g25sm44496784pfg.35.2016.02.23.05.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:45:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:45:40 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287056>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 97ed620..0eb9a0b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -538,6 +538,20 @@ error:
 	}
 }
=20
+static void send_shallow(struct commit_list *result)
+{
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
+}
+
 static void deepen(int depth, const struct object_array *shallows)
 {
 	struct commit_list *result =3D NULL, *backup =3D NULL;
@@ -551,16 +565,7 @@ static void deepen(int depth, const struct object_=
array *shallows)
 		backup =3D result =3D
 			get_shallow_commits(&want_obj, depth,
 					    SHALLOW, NOT_SHALLOW);
-	while (result) {
-		struct object *object =3D &result->item->object;
-		if (!(object->flags & (CLIENT_SHALLOW|NOT_SHALLOW))) {
-			packet_write(1, "shallow %s",
-				     oid_to_hex(&object->oid));
-			register_shallow(object->oid.hash);
-			shallow_nr++;
-		}
-		result =3D result->next;
-	}
+	send_shallow(result);
 	free_commit_list(backup);
 	for (i =3D 0; i < shallows->nr; i++) {
 		struct object *object =3D shallows->objects[i].item;
--=20
2.7.1.532.gd9e3aaa
