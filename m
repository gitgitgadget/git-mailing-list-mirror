From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/19] untracked cache: make a wrapper around {open,read,close}dir()
Date: Mon, 27 Oct 2014 19:10:32 +0700
Message-ID: <1414411846-4450-6-git-send-email-pclouds@gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 13:11:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xij8o-0002kJ-ER
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 13:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbaJ0MLN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2014 08:11:13 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:37588 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbaJ0MLL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 08:11:11 -0400
Received: by mail-pd0-f170.google.com with SMTP id z10so5576443pdj.1
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MjwY4Z/2dF/aWL/VMEhsCw0Hn7LGCVPzIBKmNRkHsh0=;
        b=PPir3a68NkIGMcq3Vm5GrjyTed1TNNlr2mehPjlxPPoWv1sWHbaiYzgs8g/ns6F+sm
         RR5Auuie867xHBPk2ksAFO/rub4h1EUNpEShDWWyUj3K9olgFfwnBuOc0jbv7pJcbvlt
         hhjfP+MZSR4Moz/CQzf2xzjvq0fB3k0cmLT9fsb7A+ZFucWT7e2lltr5Io7xmZ0DSYHF
         JFgDwE2rGwUOg7i8gIaxZ107PymfscU30hC05IkxyOWoZcZ3vAnSBeb+28d7OQePl45n
         7cjPznY/llRZq++/h+9JSMWb/nZsoDJK9pEY4MQ6atkyzh1lTjUVehM+CELfrfTcs5RN
         iYsg==
X-Received: by 10.66.97.39 with SMTP id dx7mr23908715pab.65.1414411871296;
        Mon, 27 Oct 2014 05:11:11 -0700 (PDT)
Received: from lanh ([115.73.192.230])
        by mx.google.com with ESMTPSA id f7sm10807023pdj.15.2014.10.27.05.11.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 05:11:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 27 Oct 2014 19:11:14 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows us to feed different info to read_directory_recursive()
based on untracked cache in the next patch.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index a0a0fa8..2793e57 100644
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
@@ -1411,12 +1420,13 @@ static enum path_treatment treat_one_path(struc=
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
@@ -1438,6 +1448,37 @@ static void add_untracked(struct untracked_cache=
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
+int read_cached_dir(struct cached_dir *cdir)
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
@@ -1454,23 +1495,21 @@ static enum path_treatment read_directory_recur=
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
@@ -1523,7 +1562,7 @@ static enum path_treatment read_directory_recursi=
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
2.1.0.rc0.78.gc0d8480
