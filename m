From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 10/13] read_directory: avoid invoking exclude machinery on tracked files
Date: Tue, 12 Mar 2013 20:04:57 +0700
Message-ID: <1363093500-16796-11-git-send-email-pclouds@gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 14:07:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFOvD-00086y-6R
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424Ab3CLNGf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:06:35 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:58358 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345Ab3CLNGc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:06:32 -0400
Received: by mail-pb0-f45.google.com with SMTP id ro8so4996746pbb.4
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=xPge7AKIjZ2gJVF9x8l44reDC1fA6NMgcyKe6XuwCMw=;
        b=sRvXkk2JUs3JSjRgsfUDONnWwzjME8V1FRUn7nry+8lFshVFNwmhTwRluBaB6DowWE
         VLUuyZn4bzynK87IlkXHwiG23bu+YzAz/U2EN/LM4904dP8qQhDjLTJw4uzUxL0eRK3y
         aV6GuGPsh6Ndl5WVCQBXOcWZ07+992JpgqVJAoE8hDkjZBkhTHYzFoeb3DIgIyBaxz1o
         BY5Lb4+v2CWmbQ/EJv57VHktYJRYw1s240f+E5A3UQgurQWuuxdhpMeU48Rfr6Q95EK5
         bdgFk/3SG4TU8tyf5jIB14Fh6S7pbqDyumHKxfbACxzJtCD4DXuBQdwEWEqlmi9AjsGO
         mxsQ==
X-Received: by 10.68.134.201 with SMTP id pm9mr29277639pbb.182.1363093592253;
        Tue, 12 Mar 2013 06:06:32 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id ol7sm25001773pbb.14.2013.03.12.06.06.28
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:06:31 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:06:21 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217959>

read_directory() (and its friendly wrapper fill_directory) collects
untracked/ignored files by traversing through the whole worktree,
feeding every entry to treat_one_path(), where each entry is checked
against .gitignore patterns.

One may see that tracked files can't be excluded and we do not need to
run them through exclude machinery. On repos where there are many
=2Egitignore patterns and/or a lot of tracked files, this unnecessary
processing can become expensive.

This patch avoids it mostly for normal cases. Directories are still
processed as before. DIR_SHOW_IGNORED and DIR_COLLECT_IGNORED are not
normally used unless some options are given (e.g. "checkout
--overwrite-ignore", "add -f"...)

treat_one_path's behavior changes when taking this shortcut. With
current code, when a non-directory path is not excluded,
treat_one_path calls treat_file, which returns the initial value of
exclude_file and causes treat_one_path to return path_handled. With
this patch, on the same conditions, treat_one_path returns
path_ignored.

read_directory_recursive() cares about this difference. Check out the
snippet:

	while (...) {
		switch (treat_path(...)) {
		case path_ignored:
			continue;
		case path_handled:
			break;
		}
		contents++;
		if (check_only)
			break;
		dir_add_name(dir, path.buf, path.len);
	}

If path_handled is returned, contents goes up. And if check_only is
true, the loop could be broken early. These will not happen when
treat_one_path (and its wrapper treat_path) returns
path_ignored. dir_add_name internally does a cache_name_exists() check
so it makes no difference.

To avoid this behavior change, treat_one_path is instructed to skip
the optimization when check_only or contents is used.

=46inally some numbers (best of 20 runs) that shows why it's worth all
the hassle:

git status   | webkit linux-2.6 libreoffice-core gentoo-x86
-------------+----------------------------------------------
before       | 1.097s    0.208s           0.399s     0.539s
after        | 0.736s    0.159s           0.248s     0.501s
nr. patterns |    89       376               19          0
nr. tracked  |   182k       40k              63k       101k

treat_leading_path:   0.000  0.000
read_directory:       2.879  1.299
+treat_one_path:      1.620  0.599
++is_excluded:        1.416  0.103
+++prep_exclude:      0.198  0.040
+++matching:          0.904  0.036
++dir_exist:          0.035  0.036
++index_name_exists:  0.289  0.291
lazy_init_name_hash:  0.257  0.257
+simplify_away:       0.085  0.082
+dir_add_name:        0.446  0.000

Tracked-down-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

---
 dir.c | 80 ++++++++++++++++++++++++++++++++++++++++++++---------------=
--------
 1 file changed, 53 insertions(+), 27 deletions(-)

diff --git a/dir.c b/dir.c
index c57bf06..6809dd2 100644
--- a/dir.c
+++ b/dir.c
@@ -43,8 +43,11 @@ struct path_simplify {
 	const char *path;
 };
=20
-static int read_directory_recursive(struct dir_struct *dir, const char=
 *path, int len,
-	int check_only, const struct path_simplify *simplify);
+static void read_directory_recursive(struct dir_struct *dir,
+				     const char *path, int len,
+				     int check_only,
+				     const struct path_simplify *simplify,
+				     int *contents);
 static int get_dtype(struct dirent *de, const char *path, int len);
=20
 static inline int memequal_icase(const char *a, const char *b, int n)
@@ -1184,7 +1187,7 @@ static enum directory_treatment treat_directory(s=
truct dir_struct *dir,
 	const char *dirname, int len, int exclude,
 	const struct path_simplify *simplify)
 {
-	int ret;
+	int contents =3D 0, ret;
 	START_CLOCK();
 	/* The "len-1" is to strip the final '/' */
 	ret =3D directory_exists_in_index(dirname, len-1);
@@ -1219,19 +1222,19 @@ static enum directory_treatment treat_directory=
(struct dir_struct *dir,
 	 * check if it contains only ignored files
 	 */
 	if ((dir->flags & DIR_SHOW_IGNORED) && !exclude) {
-		int ignored;
 		dir->flags &=3D ~DIR_SHOW_IGNORED;
 		dir->flags |=3D DIR_HIDE_EMPTY_DIRECTORIES;
-		ignored =3D read_directory_recursive(dir, dirname, len, 1, simplify)=
;
+		read_directory_recursive(dir, dirname, len, 1, simplify, &contents);
 		dir->flags &=3D ~DIR_HIDE_EMPTY_DIRECTORIES;
 		dir->flags |=3D DIR_SHOW_IGNORED;
=20
-		return ignored ? ignore_directory : show_directory;
+		return contents ? ignore_directory : show_directory;
 	}
 	if (!(dir->flags & DIR_SHOW_IGNORED) &&
 	    !(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return show_directory;
-	if (!read_directory_recursive(dir, dirname, len, 1, simplify))
+	read_directory_recursive(dir, dirname, len, 1, simplify, &contents);
+	if (!contents)
 		return ignore_directory;
 	return show_directory;
 }
@@ -1398,10 +1401,26 @@ enum path_treatment {
 static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct strbuf *path,
 					  const struct path_simplify *simplify,
-					  int dtype, struct dirent *de)
+					  int dtype, struct dirent *de,
+					  int exclude_shortcut_ok)
 {
 	int exclude;
=20
+	if (dtype =3D=3D DT_UNKNOWN)
+		dtype =3D get_dtype(de, path->buf, path->len);
+
+	if (exclude_shortcut_ok &&
+	    !(dir->flags & DIR_SHOW_IGNORED) &&
+	    !(dir->flags & DIR_COLLECT_IGNORED) &&
+	    dtype !=3D DT_DIR) {
+		struct cache_entry *ce;
+		START_CLOCK();
+		ce =3D cache_name_exists(path->buf, path->len, ignore_case);
+		STOP_CLOCK(tv_index_name_exists);
+		if (ce)
+			return path_ignored;
+	}
+
 	START_CLOCK();
 	exclude =3D is_excluded(dir, path->buf, path->len, &dtype);
 	STOP_CLOCK(tv_is_excluded);
@@ -1417,9 +1436,6 @@ static enum path_treatment treat_one_path(struct =
dir_struct *dir,
 	if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
 		return path_ignored;
=20
-	if (dtype =3D=3D DT_UNKNOWN)
-		dtype =3D get_dtype(de, path->buf, path->len);
-
 	switch (dtype) {
 	default:
 		return path_ignored;
@@ -1451,7 +1467,8 @@ static enum path_treatment treat_path(struct dir_=
struct *dir,
 				      struct dirent *de,
 				      struct strbuf *path,
 				      int baselen,
-				      const struct path_simplify *simplify)
+				      const struct path_simplify *simplify,
+				      int exclude_shortcut_ok)
 {
 	int dtype, ret;
=20
@@ -1467,7 +1484,7 @@ static enum path_treatment treat_path(struct dir_=
struct *dir,
=20
 	dtype =3D DTYPE(de);
 	START_CLOCK();
-	ret =3D treat_one_path(dir, path, simplify, dtype, de);
+	ret =3D treat_one_path(dir, path, simplify, dtype, de, exclude_shortc=
ut_ok);
 	STOP_CLOCK(tv_treat_one_path);
 	return ret;
 }
@@ -1481,13 +1498,13 @@ static enum path_treatment treat_path(struct di=
r_struct *dir,
  * Also, we ignore the name ".git" (even if it is not a directory).
  * That likely will not change.
  */
-static int read_directory_recursive(struct dir_struct *dir,
-				    const char *base, int baselen,
-				    int check_only,
-				    const struct path_simplify *simplify)
+static void read_directory_recursive(struct dir_struct *dir,
+				     const char *base, int baselen,
+				     int check_only,
+				     const struct path_simplify *simplify,
+				     int *contents)
 {
 	DIR *fdir;
-	int contents =3D 0;
 	struct dirent *de;
 	struct strbuf path =3D STRBUF_INIT;
=20
@@ -1499,18 +1516,29 @@ static int read_directory_recursive(struct dir_=
struct *dir,
=20
 	dir->exclude_prepared =3D 0;
 	while ((de =3D readdir(fdir)) !=3D NULL) {
-		switch (treat_path(dir, de, &path, baselen, simplify)) {
+		switch (treat_path(dir, de, &path, baselen,
+				   simplify,
+				   !check_only && !contents)) {
 		case path_recurse:
-			contents +=3D read_directory_recursive(dir, path.buf,
-							     path.len, 0,
-							     simplify);
+			read_directory_recursive(dir, path.buf,
+						 path.len, 0,
+						 simplify,
+						 contents);
 			continue;
 		case path_ignored:
 			continue;
 		case path_handled:
 			break;
 		}
-		contents++;
+		/*
+		 * Update the last argument to treat_path if anything
+		 * else is done after this point. This is because if
+		 * treat_path's exclude_shortcut_ok is true, it may
+		 * incorrectly return path_ignored (and never reaches
+		 * this part) instead of path_handled.
+		 */
+		if (contents)
+			(*contents)++;
 		if (check_only)
 			break;
 		START_CLOCK();
@@ -1521,8 +1549,6 @@ static int read_directory_recursive(struct dir_st=
ruct *dir,
  out:
 	dir->exclude_prepared =3D 0;
 	strbuf_release(&path);
-
-	return contents;
 }
=20
 static int cmp_name(const void *p1, const void *p2)
@@ -1593,7 +1619,7 @@ static int treat_leading_path(struct dir_struct *=
dir,
 			break;
 		dir->exclude_prepared =3D 0;
 		if (treat_one_path(dir, &sb, simplify,
-				   DT_DIR, NULL) =3D=3D path_ignored)
+				   DT_DIR, NULL, 0) =3D=3D path_ignored)
 			break; /* do not recurse into it */
 		if (len <=3D baselen) {
 			rc =3D 1;
@@ -1621,7 +1647,7 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const char
 		STOP_CLOCK(tv_lazy_init_name_hash);
 #endif
 		START_CLOCK();
-		read_directory_recursive(dir, path, len, 0, simplify);
+		read_directory_recursive(dir, path, len, 0, simplify, NULL);
 		STOP_CLOCK(tv_read_directory);
 	}
 #ifdef MEASURE_EXCLUDE
--=20
1.8.1.2.536.gf441e6d
