From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/24] untracked cache: make a wrapper around {open,read,close}dir()
Date: Sun,  8 Feb 2015 15:55:29 +0700
Message-ID: <1423385748-19825-6-git-send-email-pclouds@gmail.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 09:56:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNfF-0002XP-K8
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 09:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbbBHI4V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 03:56:21 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34015 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbbBHI4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 03:56:20 -0500
Received: by pdjg10 with SMTP id g10so18200720pdj.1
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 00:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=qL+QQUxYB0Vgpao5CDU/6Tzd9WBq4Kq9z+lc3Zn8RY4=;
        b=nsLKZQH0lu4zaIwBKmJ6OFaSX/pzv2r3Hr3JuyTSfnC5uhcCmq8sWEZXUwXC7cL5g9
         bC2/V/oob535dd9Zoyc3pYZ8m1RMO2vn/6hVuBI9KrSDoNxKDD99j3ygJH0KZJVhI7tY
         0SUDr88JCDHMYhS80tVjcPX0+rKKhcqGbtod1AVeRgts58BzjLjctewI5BkCNEdWVZ5i
         ly0aoaS+WtT64sJjO4c5fEVVPVd9ugvoK0L8Zd1uqVqeKR2psMKdeZLGB4+/u8Z1ABrA
         jsRARCTLtDkPiK20RgVynfZshsypzqTx8zcfmXhIyz0SEvG1LLVVRYHoH0gghwvdCXy5
         XGDw==
X-Received: by 10.68.164.194 with SMTP id ys2mr19086847pbb.20.1423385780310;
        Sun, 08 Feb 2015 00:56:20 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id d11sm12959809pdk.26.2015.02.08.00.56.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 00:56:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 15:56:27 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263466>

This allows us to feed different info to read_directory_recursive()
based on untracked cache in the next patch.

Helped-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index 6e91315..fb6ed86 100644
--- a/dir.c
+++ b/dir.c
@@ -31,6 +31,15 @@ enum path_treatment {
 	path_untracked
 };
=20
+/*
+ * Support data structure for our opendir/readdir/closedir wrappers
+ */
+struct cached_dir {
+	DIR *fdir;
+	struct untracked_cache_dir *untracked;
+	struct dirent *de;
+};
+
 static enum path_treatment read_directory_recursive(struct dir_struct =
*dir,
 	const char *path, int len, struct untracked_cache_dir *untracked,
 	int check_only, const struct path_simplify *simplify);
@@ -1417,12 +1426,13 @@ static enum path_treatment treat_one_path(struc=
t dir_struct *dir,
=20
 static enum path_treatment treat_path(struct dir_struct *dir,
 				      struct untracked_cache_dir *untracked,
-				      struct dirent *de,
+				      struct cached_dir *cdir,
 				      struct strbuf *path,
 				      int baselen,
 				      const struct path_simplify *simplify)
 {
 	int dtype;
+	struct dirent *de =3D cdir->de;
=20
 	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
 		return path_none;
@@ -1444,6 +1454,37 @@ static void add_untracked(struct untracked_cache=
_dir *dir, const char *name)
 	dir->untracked[dir->untracked_nr++] =3D xstrdup(name);
 }
=20
+static int open_cached_dir(struct cached_dir *cdir,
+			   struct dir_struct *dir,
+			   struct untracked_cache_dir *untracked,
+			   struct strbuf *path,
+			   int check_only)
+{
+	memset(cdir, 0, sizeof(*cdir));
+	cdir->untracked =3D untracked;
+	cdir->fdir =3D opendir(path->len ? path->buf : ".");
+	if (!cdir->fdir)
+		return -1;
+	return 0;
+}
+
+static int read_cached_dir(struct cached_dir *cdir)
+{
+	if (cdir->fdir) {
+		cdir->de =3D readdir(cdir->fdir);
+		if (!cdir->de)
+			return -1;
+		return 0;
+	}
+	return -1;
+}
+
+static void close_cached_dir(struct cached_dir *cdir)
+{
+	if (cdir->fdir)
+		closedir(cdir->fdir);
+}
+
 /*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
@@ -1460,23 +1501,21 @@ static enum path_treatment read_directory_recur=
sive(struct dir_struct *dir,
 				    struct untracked_cache_dir *untracked, int check_only,
 				    const struct path_simplify *simplify)
 {
-	DIR *fdir;
+	struct cached_dir cdir;
 	enum path_treatment state, subdir_state, dir_state =3D path_none;
-	struct dirent *de;
 	struct strbuf path =3D STRBUF_INIT;
=20
 	strbuf_add(&path, base, baselen);
=20
-	fdir =3D opendir(path.len ? path.buf : ".");
-	if (!fdir)
+	if (open_cached_dir(&cdir, dir, untracked, &path, check_only))
 		goto out;
=20
 	if (untracked)
 		untracked->check_only =3D !!check_only;
=20
-	while ((de =3D readdir(fdir)) !=3D NULL) {
+	while (!read_cached_dir(&cdir)) {
 		/* check how the file or directory should be treated */
-		state =3D treat_path(dir, untracked, de, &path, baselen, simplify);
+		state =3D treat_path(dir, untracked, &cdir, &path, baselen, simplify=
);
=20
 		if (state > dir_state)
 			dir_state =3D state;
@@ -1529,7 +1568,7 @@ static enum path_treatment read_directory_recursi=
ve(struct dir_struct *dir,
 			break;
 		}
 	}
-	closedir(fdir);
+	close_cached_dir(&cdir);
  out:
 	strbuf_release(&path);
=20
--=20
2.3.0.rc1.137.g477eb31
