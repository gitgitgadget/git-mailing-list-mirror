From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 08/10] common_prefix/read_directory: treat PATHSPEC_ICASE like wildcards
Date: Sun, 13 Jan 2013 19:49:37 +0700
Message-ID: <1358081379-17752-9-git-send-email-pclouds@gmail.com>
References: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:50:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuN1U-0001M3-U8
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928Ab3AMMu0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:50:26 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:54847 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754905Ab3AMMuY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:50:24 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so1425933dad.10
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=usnvmV4n4G9dhlA6FQUC0cbkMUwdr+FPVY0zR3tC7FQ=;
        b=iJ16W1GKKI6LMVAv5AD8yBpDrK/xWxIl3S8gqSo/JUm0yMU9ngJV57pjwNp+xnmjRl
         oV5BpptGxC4haCzczTJLClHpGG9BR2uKR4eSA6kUnpYdmrYFdZHp1iSKNsJUI6bQDcse
         eKF1CJ7hyVauxCIdChu6Ta0SGv2oxS+1eAYL38oSaTT4my/qCdRH7PlLgKXuGf1qCHa0
         EpCeK0TVCuIHD9JKcbibn/DwyF0Blmk+wbucqiKKaTs/AJEQ3WPGsk6rt/U9neEE/njp
         +KUqzPVyypid4MG66j/Go8w3thyGjwTGPAffB6/4GTi4CHF1PoFmrkj97fFfGJyjKFps
         60Pg==
X-Received: by 10.68.238.39 with SMTP id vh7mr71175456pbc.6.1358081423668;
        Sun, 13 Jan 2013 04:50:23 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id p10sm6769173pax.27.2013.01.13.04.50.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:50:23 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:50:39 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358081379-17752-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213380>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 760b776..d0e7ca8 100644
--- a/dir.c
+++ b/dir.c
@@ -66,15 +66,22 @@ static size_t common_prefix_len(const struct pathsp=
ec *pathspec)
 	int n;
 	size_t max =3D 0;
=20
+	/*
+	 * ":(icase)path" is treated as a pathspec full of wildcard
+	 */
 	GUARD_PATHSPEC(pathspec,
 		       PATHSPEC_FROMTOP |
 		       PATHSPEC_LITERAL |
-		       PATHSPEC_GLOB);
+		       PATHSPEC_GLOB |
+		       PATHSPEC_ICASE);
=20
 	for (n =3D 0; n < pathspec->nr; n++) {
-		size_t i =3D 0, len =3D 0;
-		while (i < pathspec->items[n].nowildcard_len &&
-		       (n =3D=3D 0 || i < max)) {
+		size_t i =3D 0, len =3D 0, item_len;
+		if (pathspec->items[n].magic & PATHSPEC_ICASE)
+			item_len =3D pathspec->items[n].prefix;
+		else
+			item_len =3D pathspec->items[n].nowildcard_len;
+		while (i < item_len && (n =3D=3D 0 || i < max)) {
 			char c =3D pathspec->items[n].match[i];
 			if (c !=3D pathspec->items[0].match[i])
 				break;
@@ -1240,7 +1247,8 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const stru
 		GUARD_PATHSPEC(pathspec,
 			       PATHSPEC_FROMTOP |
 			       PATHSPEC_LITERAL |
-			       PATHSPEC_GLOB);
+			       PATHSPEC_GLOB |
+			       PATHSPEC_ICASE);
=20
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
--=20
1.8.0.rc2.23.g1fb49df
