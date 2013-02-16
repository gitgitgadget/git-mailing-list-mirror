From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] read_directory: avoid invoking exclude machinery on tracked files
Date: Sat, 16 Feb 2013 14:17:58 +0700
Message-ID: <1360999078-27196-1-git-send-email-pclouds@gmail.com>
References: <1360937848-4426-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>, kusmabite@gmail.com,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>, finnag@pvv.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 08:17:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6c1r-0006Cx-Q0
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 08:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871Ab3BPHRP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Feb 2013 02:17:15 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48914 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab3BPHRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2013 02:17:15 -0500
Received: by mail-pb0-f46.google.com with SMTP id uo15so912463pbc.33
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 23:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=MpWorQG1GrPuuMoMaGoKpEt+k4X2Y3Mo39nmS8XXPvc=;
        b=rl2gtG32thC/UN0reA+omV8As0ikxV1JxPyQwTWpgUuZHio29tGnfrnLTbFrgsyVeg
         xtO5rzOeJZ92qTxAk++IwUR/htAv8wOwkM8e3D0izucsRit5K5GcHpXXW8fxNjCFrsWF
         Lsq6tPJrq80AMMlKJLIUmAJX1H49Iptarguie4CQ71xwHFfGFI3Ykm4SUkWkJ8dptuYy
         oDeZGRVrC75v5XreaiFzlKjVbnzSZGe5g1gjzz1nqv2Bjfq/cvd4HjtBaUVPXNqoAIX1
         noTWwdfIVivlWqqPBeIun0sCQzCNNRiR7c1p1JrYutWv2lgDTSr0jS8qBbNkUYaFi+pz
         vv9Q==
X-Received: by 10.66.186.164 with SMTP id fl4mr18838301pac.51.1360999034485;
        Fri, 15 Feb 2013 23:17:14 -0800 (PST)
Received: from lanh ([115.74.55.130])
        by mx.google.com with ESMTPS id qb10sm7215420pbb.43.2013.02.15.23.17.08
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 15 Feb 2013 23:17:13 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 16 Feb 2013 14:17:59 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1360937848-4426-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216381>

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

Tracked-down-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Instead of relying on the surrounding code happening to not trigger
 the behavior change in treat_one_path, this round ensures such
 triggers will disable the optimization and fall back to normal code
 path.

 There are no big differences in measured numbers, which indicate
 incorrect triggers do not happen, at least in my tests.

 dir.c | 79 ++++++++++++++++++++++++++++++++++++++++++++---------------=
--------
 1 file changed, 52 insertions(+), 27 deletions(-)

diff --git a/dir.c b/dir.c
index 57394e4..a5fe0a0 100644
--- a/dir.c
+++ b/dir.c
@@ -17,8 +17,11 @@ struct path_simplify {
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
 /* helper string functions with support for the ignore_case flag */
@@ -1034,6 +1037,7 @@ static enum directory_treatment treat_directory(s=
truct dir_struct *dir,
 	const char *dirname, int len, int exclude,
 	const struct path_simplify *simplify)
 {
+	int contents =3D 0;
 	/* The "len-1" is to strip the final '/' */
 	switch (directory_exists_in_index(dirname, len-1)) {
 	case index_directory:
@@ -1065,19 +1069,19 @@ static enum directory_treatment treat_directory=
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
@@ -1242,9 +1246,23 @@ enum path_treatment {
 static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct strbuf *path,
 					  const struct path_simplify *simplify,
-					  int dtype, struct dirent *de)
+					  int dtype, struct dirent *de,
+					  int exclude_shortcut_ok)
 {
-	int exclude =3D is_excluded(dir, path->buf, &dtype);
+	int exclude;
+
+	if (dtype =3D=3D DT_UNKNOWN)
+		dtype =3D get_dtype(de, path->buf, path->len);
+
+	if (exclude_shortcut_ok &&
+	    !(dir->flags & DIR_SHOW_IGNORED) &&
+	    !(dir->flags & DIR_COLLECT_IGNORED) &&
+	    dtype !=3D DT_DIR &&
+	    cache_name_exists(path->buf, path->len, ignore_case))
+		return path_ignored;
+
+	exclude =3D is_excluded(dir, path->buf, &dtype);
+
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
 	    && exclude_matches_pathspec(path->buf, path->len, simplify))
 		dir_add_ignored(dir, path->buf, path->len);
@@ -1256,9 +1274,6 @@ static enum path_treatment treat_one_path(struct =
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
@@ -1290,7 +1305,8 @@ static enum path_treatment treat_path(struct dir_=
struct *dir,
 				      struct dirent *de,
 				      struct strbuf *path,
 				      int baselen,
-				      const struct path_simplify *simplify)
+				      const struct path_simplify *simplify,
+				      int exclude_shortcut_ok)
 {
 	int dtype;
=20
@@ -1302,7 +1318,7 @@ static enum path_treatment treat_path(struct dir_=
struct *dir,
 		return path_ignored;
=20
 	dtype =3D DTYPE(de);
-	return treat_one_path(dir, path, simplify, dtype, de);
+	return treat_one_path(dir, path, simplify, dtype, de, exclude_shortcu=
t_ok);
 }
=20
 /*
@@ -1314,13 +1330,13 @@ static enum path_treatment treat_path(struct di=
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
@@ -1331,18 +1347,29 @@ static int read_directory_recursive(struct dir_=
struct *dir,
 		goto out;
=20
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
 		dir_add_name(dir, path.buf, path.len);
@@ -1350,8 +1377,6 @@ static int read_directory_recursive(struct dir_st=
ruct *dir,
 	closedir(fdir);
  out:
 	strbuf_release(&path);
-
-	return contents;
 }
=20
 static int cmp_name(const void *p1, const void *p2)
@@ -1420,7 +1445,7 @@ static int treat_leading_path(struct dir_struct *=
dir,
 		if (simplify_away(sb.buf, sb.len, simplify))
 			break;
 		if (treat_one_path(dir, &sb, simplify,
-				   DT_DIR, NULL) =3D=3D path_ignored)
+				   DT_DIR, NULL, 0) =3D=3D path_ignored)
 			break; /* do not recurse into it */
 		if (len <=3D baselen) {
 			rc =3D 1;
@@ -1440,7 +1465,7 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const char
=20
 	simplify =3D create_simplify(pathspec);
 	if (!len || treat_leading_path(dir, path, len, simplify))
-		read_directory_recursive(dir, path, len, 0, simplify);
+		read_directory_recursive(dir, path, len, 0, simplify, NULL);
 	free_simplify(simplify);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	qsort(dir->ignored, dir->ignored_nr, sizeof(struct dir_entry *), cmp_=
name);
--=20
1.8.1.2.536.gf441e6d
