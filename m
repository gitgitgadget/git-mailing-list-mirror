From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/20] upload-pack: move "shallow" sending code out of deepen()
Date: Tue, 29 Dec 2015 19:10:25 +0700
Message-ID: <1451391043-28093-3-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:11:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt7U-00064X-56
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbbL2MLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:11:11 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33167 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbbL2MLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:11:09 -0500
Received: by mail-pf0-f171.google.com with SMTP id q63so90962544pfb.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pO9GrwOQ4ndfcRi+3VN1ILBAuy8KZm1lYxJSXXLjJGk=;
        b=Op/URLCvRWrjs2YvNkrDh89ucUOUsiedVXf9tlTqJpIxigC//Jhz8fRnCHSfx2+Iq5
         TKWtsOswIq/jlyBz9gnzhKggJLKyzBapTtjTZJ0boAR/mj/mwc2brtl8xYhoc19+cf1z
         3/9e3NbE9cc1jHAJssudZzAoDMDQ6OzpJv/o/QUXwPX25t4MLreQbFLJBOBDYhCcgR8D
         HBbNhemZqKwbwUqiJvAOosJhHn1k6zOyu6JQ5ZV+p5w/MNx8bKo/TRwm9WHonV6M9tpq
         vTxlKVfKtPZXvR/kVvfj2Xl/3u3VQ5Wh1CGd/IGcHBDovbREim+WgeEZzl7gNyh5VEtz
         OuqQ==
X-Received: by 10.98.87.216 with SMTP id i85mr84674105pfj.90.1451391068578;
        Tue, 29 Dec 2015 04:11:08 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id ud10sm87864497pab.27.2015.12.29.04.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:11:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:11:03 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283112>

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
2.3.0.rc1.137.g477eb31
