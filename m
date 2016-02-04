From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/25] upload-pack: move "shallow" sending code out of deepen()
Date: Thu,  4 Feb 2016 16:03:41 +0700
Message-ID: <1454576641-29615-6-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:04:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFqS-0005jX-Vt
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965409AbcBDJEr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:04:47 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33828 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965400AbcBDJEl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:04:41 -0500
Received: by mail-pf0-f171.google.com with SMTP id o185so38400853pfb.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=V9lxJnZ5V0je+4TgE0ZU4qojoyb2rSwyjJ2aH8Wkv5w=;
        b=l2vSM54mnZ5D7OBFaGSpjenYUequSfiGvPqjuyzhq4v78O1dKtYzMNua2L+6SB4C+I
         jjiaOf1a0c23PdL7GxrtrjwGi9dcpu7eOhz9LgLtJVDDWQ9Xcw9BtOoeRboOZ6Ys4s5u
         WdtXRKPkdWVAfouqv5x+7N0B6z0YfG75kuiAhF0WTq1fjvRGtxs5JXyF91cJW/5zbxzV
         hTWPt2cr0iiBGsQIJCiXgm/MQlqLVUvDdCtzALTHxnsBZmaKTMKu8cFHr+J/WTdhELFm
         f7fo4yn/fTY9OFQWzggYjwAxf9gz2sx1rY5DJOJIflBy12ozwt+irIoBpnmuLUn3ZMVU
         cQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=V9lxJnZ5V0je+4TgE0ZU4qojoyb2rSwyjJ2aH8Wkv5w=;
        b=Mj07yisOikcXCkr7Bl2rFL5yJW9X7WD5b2jhSd3SRG3tMVUmV6J4Y0E0XWhBdj2Rza
         5M+IXepbFuM2gucKuSnMhBGlr4BtVIsohIg73TCk+fOCZiwVIBJiO4Uzo/mdHDesBnYf
         M4LHipKZX96nfxBdLVpK9hO+ivxMzFLjGnemLtsMGkH37lbEqWRU3z410ASucb9ikkd1
         N20oC1NYrurfk2bMoEFk9jy4duRwZU18pvuy45WMt4xr9mQlAXSGuiO+gNkwhsED0fEe
         I2Ntp1hGDNIisB89wYSHme3uTo6XpkCY8dmM4Q51Pft5bL/ucR4r9yhXgblOGl72Cuq1
         S/qg==
X-Gm-Message-State: AG10YOQS8hTBIABlvLOGU+Gh/8Ws9xx8KfJrPvbpJ50BsTxL8ww+qVkMK+O/A8v23jp6SA==
X-Received: by 10.66.101.3 with SMTP id fc3mr9400841pab.2.1454576681002;
        Thu, 04 Feb 2016 01:04:41 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id n2sm15425906pfj.16.2016.02.04.01.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:04:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:04:53 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285419>

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
2.7.0.377.g4cd97dd
