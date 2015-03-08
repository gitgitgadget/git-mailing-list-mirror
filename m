From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/24] untracked cache: make a wrapper around {open,read,close}dir()
Date: Sun,  8 Mar 2015 17:12:28 +0700
Message-ID: <1425809567-25518-6-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:13:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYDM-0002iB-KB
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbbCHKNg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:13:36 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:38187 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbbCHKNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:13:35 -0400
Received: by pabrd3 with SMTP id rd3so40736139pab.5
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=V4T7ttmuD7MSYLtMGc4PTfc2BYZxbRstsp3qURg8I2I=;
        b=HYS92EYdwZxV0jFrNvVCXSugE7HXD0xySYEOv3PtghtqZXCfWJz97h3wZu5E5JXXiQ
         APHZNNe+Wic6dxkcfrPc20VG/jI8GwXY15BG8SF9xDhl0U6dX5i0b/BZjIKFCsFJk2Ac
         NRbg38Q39wuLhQU9m4JB/GIp/kxB806jpyP2hu7sqgrTcgvOtz0obgHp4j0qG1SRgAOu
         AKLRhiCQDsOyqE85QudsrpADCLHHtdt3D6Oh3Dp9wP/zAVAflzzKOs6dnrztVEyDxEed
         qMewWA6WiuJUCTdQsPfhAefw6GONUUyqIRyZ8bdHqxX6UVBlAQ9hwJM5AqcKL40DHjhL
         J0Uw==
X-Received: by 10.70.140.104 with SMTP id rf8mr41303007pdb.89.1425809615537;
        Sun, 08 Mar 2015 03:13:35 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id c17sm14350411pdl.79.2015.03.08.03.13.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:13:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:13:31 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265059>

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
index bfbd332..3ea920c 100644
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
@@ -1418,12 +1427,13 @@ static enum path_treatment treat_one_path(struc=
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
@@ -1445,6 +1455,37 @@ static void add_untracked(struct untracked_cache=
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
@@ -1461,23 +1502,21 @@ static enum path_treatment read_directory_recur=
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
@@ -1530,7 +1569,7 @@ static enum path_treatment read_directory_recursi=
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
