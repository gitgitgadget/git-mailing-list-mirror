From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/4] sha1_file: reorder code in prepare_packed_git_one()
Date: Tue, 12 Feb 2013 16:27:55 +0700
Message-ID: <1360661277-17273-3-git-send-email-pclouds@gmail.com>
References: <1360661277-17273-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 10:27:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5C9b-0001qA-Gk
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 10:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933021Ab3BLJ13 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2013 04:27:29 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:58784 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933012Ab3BLJ1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 04:27:25 -0500
Received: by mail-pa0-f43.google.com with SMTP id bh2so3606945pad.30
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 01:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=1+P4oEB7Q/RvuWSjGuvML1itEWCOG9fcg2R6BaoFTK8=;
        b=LUsw6E5190Tq4vUTIVS7368QjDMUQwAj7EkLIJNfRa4cPp+0EYYtBaLkZMgKcbbJA2
         rZhFk8DvMykJvAakkIWPYvAEz7DcJKW+ZIpC7BGLV6E8KjT8tNH+SWcSwJgoNS409wwu
         WViwcbdUjU/jaa/V1cazKFaOwXy+jiWGEPQv6vPa/clHXiXgCRnNjRG/YCk2K0nl9mL+
         pD/nf2GW5vSa3B2nJdqizHKsMqId1RbPV9svBuNLKN6haRjVg6Cq5tI9Q3o0ZP0M8dbi
         FvYKxc9G5g3Q/dQtYwKY1wVEPMs/0GucY8hsqtS9g209h/3ZkAwaimgTOV5lCrR01cbW
         PgaA==
X-Received: by 10.66.82.226 with SMTP id l2mr49937791pay.64.1360661245208;
        Tue, 12 Feb 2013 01:27:25 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id g2sm17718020pav.2.2013.02.12.01.27.21
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 01:27:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Feb 2013 16:28:12 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1360661277-17273-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216124>

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
 sha1_file.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 40b2329..8d7da1d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1024,27 +1024,28 @@ static void prepare_packed_git_one(char *objdir=
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
+			if (p)
+				continue;
+			/*
+			 * See if it really is a valid .idx file with
+			 * corresponding .pack file that we can map.
+			 */
+			p =3D add_packed_git(path, len + namelen, local);
+			if (!p)
+				continue;
+			install_packed_git(p);
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
