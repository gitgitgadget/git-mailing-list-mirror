From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/24] untracked cache: make a wrapper around {open,read,close}dir()
Date: Tue, 20 Jan 2015 20:03:14 +0700
Message-ID: <1421759013-8494-6-git-send-email-pclouds@gmail.com>
References: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 14:04:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDYTb-0003Rh-Mb
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 14:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbbATNEG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 08:04:06 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:49887 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505AbbATNEF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 08:04:05 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so3318109pdj.9
        for <git@vger.kernel.org>; Tue, 20 Jan 2015 05:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5dABMqYxkua7fsm6oldq80/QiYRoCxAWQm0fqoPkugc=;
        b=EFbh7n433yN9MJo4LEs2+Dyp4sAoeUSVNONq2vZHw0vBqCPVABMXwupSTkXMO/wfUE
         h3hX+1b6mhi65BM7JTwbUk+3MlhFake1zUiYyAV5OtfoL3AR1uY8xvTKl6aeYwBId4u3
         Oxz2zDYXrAm+SI5hUmyTZB/GbXgbJsrrnp14E7zrbuMwJdSqgFVgRVGJTUm1oU712jYj
         /LL8jkGEVuRfFzTnq/Gn0JpIDEwLPhpYSSYtRJN53NkXNP/x3JC4SwrcqvF129yzWKhZ
         /hluz1j+v3ir6bim0Q/Tk8pcsu2i08WgHuS0aMDhDnze10misCLp1zeHmklIXJuTJnnV
         c7EA==
X-Received: by 10.68.191.41 with SMTP id gv9mr52840084pbc.83.1421759044612;
        Tue, 20 Jan 2015 05:04:04 -0800 (PST)
Received: from lanh ([115.73.212.1])
        by mx.google.com with ESMTPSA id o10sm14559866pdr.96.2015.01.20.05.04.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2015 05:04:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 20 Jan 2015 20:04:13 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1421759013-8494-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262658>

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
2.2.0.84.ge9c7a8a
