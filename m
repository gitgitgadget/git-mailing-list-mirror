From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 2/4] sha1_file: reorder code in prepare_packed_git_one()
Date: Wed, 13 Feb 2013 16:13:17 +0700
Message-ID: <1360746799-3668-3-git-send-email-pclouds@gmail.com>
References: <7va9r9igze.fsf@alter.siamese.dyndns.org>
 <1360746799-3668-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 10:13:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5YOw-0004dv-L9
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 10:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab3BMJMu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2013 04:12:50 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33169 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675Ab3BMJMs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 04:12:48 -0500
Received: by mail-pa0-f42.google.com with SMTP id kq12so608815pab.29
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 01:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=kJl6dMG2gipqWFytO11T6G4mLsw4Z/4jgonMl416i2c=;
        b=hbolUPpU9NGaS2S40FvY75c/AZMYUdHJL7RzTe8+phyDi8+XnmHjaqpHNmIHt4fOvB
         91qaVfg94XT0KzVEshWnteF8+aGOKyA9XM5giphA0GmcBQFYEoOcsFhoLWG9hXfAQqkE
         uluoKv9JOM5bsBi9SGBMWQnRz4d3TbfaRndsjilIwKKvW8O2DfpWmpJgw34zpDbyy/cE
         M7CeritLpyDEFttUB9YzzctsHsz2/cws6KiYLuaVsiAsH2c8JHxP7xab+D+7jBemUdZ4
         UKce7S+2SfvuQkRLcChza3scZS8zvEmHeulo3yy/8sMAzlp7t0Ro6kptyOrI7KzN5keA
         XBTw==
X-Received: by 10.66.82.67 with SMTP id g3mr61288034pay.58.1360746767934;
        Wed, 13 Feb 2013 01:12:47 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id m3sm81950249pav.4.2013.02.13.01.12.44
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 01:12:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Feb 2013 16:13:34 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1360746799-3668-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216241>

The current loop does

	while (...) {
		if (!not .idx file)
			continue;
		process .idx file;
	}

and is reordered to

	while (...) {
		if (!.idx file) {
			process .idx file;
		}
	}

This makes it easier to add new extension file processing.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 40b2329..239bee7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1024,27 +1024,25 @@ static void prepare_packed_git_one(char *objdir=
, int local)
 		int namelen =3D strlen(de->d_name);
 		struct packed_git *p;
=20
-		if (!has_extension(de->d_name, ".idx"))
-			continue;
-
 		if (len + namelen + 1 > sizeof(path))
 			continue;
=20
-		/* Don't reopen a pack we already have. */
 		strcpy(path + len, de->d_name);
-		for (p =3D packed_git; p; p =3D p->next) {
-			if (!memcmp(path, p->pack_name, len + namelen - 4))
-				break;
+
+		if (has_extension(de->d_name, ".idx")) {
+			/* Don't reopen a pack we already have. */
+			for (p =3D packed_git; p; p =3D p->next) {
+				if (!memcmp(path, p->pack_name, len + namelen - 4))
+					break;
+			}
+			if (p =3D=3D NULL &&
+			    /*
+			     * See if it really is a valid .idx file with
+			     * corresponding .pack file that we can map.
+			     */
+			    (p =3D add_packed_git(path, len + namelen, local)) !=3D NULL)
+				install_packed_git(p);
 		}
-		if (p)
-			continue;
-		/* See if it really is a valid .idx file with corresponding
-		 * .pack file that we can map.
-		 */
-		p =3D add_packed_git(path, len + namelen, local);
-		if (!p)
-			continue;
-		install_packed_git(p);
 	}
 	closedir(dir);
 }
--=20
1.8.1.2.536.gf441e6d
