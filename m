From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH/RFC] dir.c: Make git-status --ignored even more consistent
Date: Mon, 25 Feb 2013 23:01:28 +0100
Message-ID: <512BDF38.5040400@gmail.com>
References: <1360937848-4426-1-git-send-email-pclouds@gmail.com> <1360999078-27196-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	kusmabite@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>, finnag@pvv.org,
	apelisse@gmail.com, peff@peff.net
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 23:01:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA67P-0000iR-1S
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 23:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758924Ab3BYWB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 17:01:29 -0500
Received: from mail-ee0-f66.google.com ([74.125.83.66]:33995 "EHLO
	mail-ee0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758391Ab3BYWB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 17:01:28 -0500
Received: by mail-ee0-f66.google.com with SMTP id b47so920410eek.9
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 14:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=hgyKpBGk64dpJPknlulaiumt+OotXUoFcRapR+qiLsg=;
        b=L6SxQC9ECnzlQ++aUFK0N8NbKuLu83qPDTfkig1gwh8A1Otwn5QOcH8jUvgDD1fyhO
         4V2UWrATjQdajYEw8rJr0yeGd7IjOD5Yyu5SonaJkTzIuWKqY8Tsdn2JsBSE1m0TEzsK
         cLK8EIgvaMj599mNouTzTfUKYgs0kbSQaL6wWaXIGMZgxMCo9ICV0qlLiQ9ODmVP7dva
         RVQXHvj4J4uNm6BR1wGqQkp1INI5Y2PW/Zy1ZVnoUAgHbXhwCNjszhTakMTR9kprLiD0
         SKBR0NN3SbCEZmVQf/QO0B9J81xdVSnOb3LF5nkwjkBKF/tR+ql5SLdrKPaMSm/7VO68
         /rjg==
X-Received: by 10.14.5.6 with SMTP id 6mr43086717eek.42.1361829687062;
        Mon, 25 Feb 2013 14:01:27 -0800 (PST)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id l8sm20453114een.10.2013.02.25.14.01.25
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 25 Feb 2013 14:01:26 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <1360999078-27196-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217111>

The new "git-status --ignored" handling introduced with 721ac4ed "dir.c:
Make git-status --ignored more consistent" and a45fb697 "status: always
report ignored tracked directories" still has a few flaws in the
"--untracked-files=normal" case:

 - It lists directories that match the exclude pattern, even if they are
   tracked, instead of the untracked files and directories that are
   _affected_ by the exclude pattern. This is inconsistent with the listing
   of untracked files and directories. Additionally, an entire (tracked)
   directory may be listed as ignored while contained files are listed as
   modified.

 - With an untracked directory between the ignored directory and files, the
   directory is dropped.

 - With a tracked directory between the ignored directory and files, both
   the directory and the individual files are listed as ignored.

Change "git-status --ignored --untracked-files=normal" so that it no longer
lists tracked directories. This is already in line with gitignore(5) and
api-directory-listing.txt, so we don't need to update documentation.

In the git-status case, always use is_path_excluded() instead of
is_excluded(). The latter doesn't check if one of the parent directories
is excluded, and we need the full picture when recursing into ignored
directories. As is_path_excluded() is even more complex, only do this for
untracked files and directories. Keep the original is_excluded() check in
the DIR_COLLECT_IGNORED case so that git-add is not affected.

In read_directory_recursive, pass along the check_only parameter when
recursing into sub directories, so that we don't accidentally call
dir_add_name in the check_only case.

Signed-off-by: Karsten Blees <blees@dcon.de>
---

See also: https://github.com/kblees/git/commits/kb/git-status-ignored

Revisiting dir.c, I noticed that the added complexity in .gitignore
processing was just recently introduced by these two changes:
- a45fb697 status: always report ignored tracked directories
- 721ac4ed dir.c: Make git-status --ignored more consistent

Instead of skipping gitignore checks under very special 'safe'
circumstances, this patch focuses on fixing pre-existing bugs
first. The correctness of lazy gitignore checks is then obvious (I
hope) by the very definition of gitignore(5):
"gitignore - Specifies intentionally *untracked* files to ignore"
[emphasis added].

There's still lots of room for improvement, e.g.:
- prevent "git-status --ignored" from scanning everything twice
- integrate struct path_exclude_check into struct dir_struct to
  save setup costs of is_path_excluded

Cheers,
Karsten



 dir.c                      | 138 ++++++++++++++++++++-------------------------
 t/t7061-wtstatus-ignore.sh |  65 +++++++++++++++++++--
 wt-status.c                |   2 +-
 3 files changed, 123 insertions(+), 82 deletions(-)

diff --git a/dir.c b/dir.c
index 57394e4..1a5440f 100644
--- a/dir.c
+++ b/dir.c
@@ -884,6 +884,17 @@ int is_path_excluded(struct path_exclude_check *check,
 	return 0;
 }
 
+static int check_path_excluded(struct dir_struct *dir,
+		  const char *name, int namelen, int *dtype)
+{
+	struct path_exclude_check check;
+	int excluded;
+	path_exclude_check_init(&check, dir);
+	excluded = is_path_excluded(&check, name, namelen, dtype);
+	path_exclude_check_clear(&check);
+	return excluded;
+}
+
 static struct dir_entry *dir_entry_new(const char *pathname, int len)
 {
 	struct dir_entry *ent;
@@ -897,8 +908,7 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 
 static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
 {
-	if (!(dir->flags & DIR_SHOW_IGNORED) &&
-	    cache_name_exists(pathname, len, ignore_case))
+	if (cache_name_exists(pathname, len, ignore_case))
 		return NULL;
 
 	ALLOC_GROW(dir->entries, dir->nr+1, dir->alloc);
@@ -1000,9 +1010,8 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
  * traversal routine.
  *
  * Case 1: If we *already* have entries in the index under that
- * directory name, we recurse into the directory to see all the files,
- * unless the directory is excluded and we want to show ignored
- * directories
+ * directory name, we always recurse into the directory to see
+ * all the files.
  *
  * Case 2: If we *already* have that directory name as a gitlink,
  * we always continue to see it as a gitlink, regardless of whether
@@ -1016,9 +1025,9 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
  *      just a directory, unless "hide_empty_directories" is
  *      also true and the directory is empty, in which case
  *      we just ignore it entirely.
- *      if we are looking for ignored directories, look if it
- *      contains only ignored files to decide if it must be shown as
- *      ignored or not.
+ *      if we are looking for ignored directories, we also hide
+ *      directories with untracked files (i.e. that are already
+ *      listed in the untracked section).
  *  (b) if it looks like a git directory, and we don't have
  *      'no_gitlinks' set we treat it as a gitlink, and show it
  *      as a directory.
@@ -1031,15 +1040,13 @@ enum directory_treatment {
 };
 
 static enum directory_treatment treat_directory(struct dir_struct *dir,
-	const char *dirname, int len, int exclude,
-	const struct path_simplify *simplify)
+	const char *dirname, int len, const struct path_simplify *simplify)
 {
+	int dt = DT_DIR, exclude;
+
 	/* The "len-1" is to strip the final '/' */
 	switch (directory_exists_in_index(dirname, len-1)) {
 	case index_directory:
-		if ((dir->flags & DIR_SHOW_OTHER_DIRECTORIES) && exclude)
-			break;
-
 		return recurse_into_directory;
 
 	case index_gitdir:
@@ -1060,65 +1067,61 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 
 	/* This is the "show_other_directories" case */
 
+	exclude = check_path_excluded(dir, dirname, len-1, &dt);
+
 	/*
 	 * We are looking for ignored files and our directory is not ignored,
 	 * check if it contains only ignored files
 	 */
 	if ((dir->flags & DIR_SHOW_IGNORED) && !exclude) {
-		int ignored;
-		dir->flags &= ~DIR_SHOW_IGNORED;
-		dir->flags |= DIR_HIDE_EMPTY_DIRECTORIES;
-		ignored = read_directory_recursive(dir, dirname, len, 1, simplify);
-		dir->flags &= ~DIR_HIDE_EMPTY_DIRECTORIES;
-		dir->flags |= DIR_SHOW_IGNORED;
-
-		return ignored ? ignore_directory : show_directory;
+		int untracked;
+		dir->flags &= ~(DIR_SHOW_IGNORED|DIR_SHOW_OTHER_DIRECTORIES);
+		untracked = read_directory_recursive(dir, dirname, len, 1, simplify);
+		dir->flags |= (DIR_SHOW_IGNORED|DIR_SHOW_OTHER_DIRECTORIES);
+
+		/*
+		 * Don't list the directory as ignored if it is already listed
+		 * as untracked.
+		 */
+		if (untracked)
+			return ignore_directory;
 	}
-	if (!(dir->flags & DIR_SHOW_IGNORED) &&
-	    !(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
+
+	if (!(dir->flags & DIR_SHOW_IGNORED) && exclude)
+		return ignore_directory;
+
+	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return show_directory;
 	if (!read_directory_recursive(dir, dirname, len, 1, simplify))
 		return ignore_directory;
 	return show_directory;
 }
 
+enum path_treatment {
+	path_ignored,
+	path_handled,
+	path_recurse
+};
+
 /*
  * Decide what to do when we find a file while traversing the
- * filesystem. Mostly two cases:
- *
- *  1. We are looking for ignored files
- *   (a) File is ignored, include it
- *   (b) File is in ignored path, include it
- *   (c) File is not ignored, exclude it
+ * filesystem.
  *
- *  2. Other scenarios, include the file if not excluded
+ * Case 1: The file is in the index: always ignore.
  *
- * Return 1 for exclude, 0 for include.
+ * Case 2: The file is not in the index: check if the file is excluded.
  */
-static int treat_file(struct dir_struct *dir, struct strbuf *path, int exclude, int *dtype)
+static enum path_treatment treat_file(struct dir_struct *dir,
+		struct strbuf *path, const struct path_simplify *simplify,
+		int *dtype)
 {
-	struct path_exclude_check check;
-	int exclude_file = 0;
-
-	if (exclude)
-		exclude_file = !(dir->flags & DIR_SHOW_IGNORED);
-	else if (dir->flags & DIR_SHOW_IGNORED) {
-		/* Always exclude indexed files */
-		struct cache_entry *ce = index_name_exists(&the_index,
-		    path->buf, path->len, ignore_case);
-
-		if (ce)
-			return 1;
-
-		path_exclude_check_init(&check, dir);
-
-		if (!is_path_excluded(&check, path->buf, path->len, dtype))
-			exclude_file = 1;
-
-		path_exclude_check_clear(&check);
-	}
+	if (cache_name_exists(path->buf, path->len, ignore_case))
+		return path_ignored;
 
-	return exclude_file;
+	if (check_path_excluded(dir, path->buf, path->len, dtype) !=
+	    !!(dir->flags & DIR_SHOW_IGNORED))
+		return path_ignored;
+	return path_handled;
 }
 
 /*
@@ -1233,29 +1236,16 @@ static int get_dtype(struct dirent *de, const char *path, int len)
 	return dtype;
 }
 
-enum path_treatment {
-	path_ignored,
-	path_handled,
-	path_recurse
-};
-
 static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct strbuf *path,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
 {
-	int exclude = is_excluded(dir, path->buf, &dtype);
-	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
+	if ((dir->flags & DIR_COLLECT_IGNORED)
+	    && is_excluded(dir, path->buf, &dtype)
 	    && exclude_matches_pathspec(path->buf, path->len, simplify))
 		dir_add_ignored(dir, path->buf, path->len);
 
-	/*
-	 * Excluded? If we don't explicitly want to show
-	 * ignored files, ignore it
-	 */
-	if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
-		return path_ignored;
-
 	if (dtype == DT_UNKNOWN)
 		dtype = get_dtype(de, path->buf, path->len);
 
@@ -1265,7 +1255,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	case DT_DIR:
 		strbuf_addch(path, '/');
 
-		switch (treat_directory(dir, path->buf, path->len, exclude, simplify)) {
+		switch (treat_directory(dir, path->buf, path->len, simplify)) {
 		case show_directory:
 			break;
 		case recurse_into_directory:
@@ -1276,12 +1266,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		break;
 	case DT_REG:
 	case DT_LNK:
-		switch (treat_file(dir, path, exclude, &dtype)) {
-		case 1:
-			return path_ignored;
-		default:
-			break;
-		}
+		return treat_file(dir, path, simplify, &dtype);
 	}
 	return path_handled;
 }
@@ -1334,8 +1319,7 @@ static int read_directory_recursive(struct dir_struct *dir,
 		switch (treat_path(dir, de, &path, baselen, simplify)) {
 		case path_recurse:
 			contents += read_directory_recursive(dir, path.buf,
-							     path.len, 0,
-							     simplify);
+					path.len, check_only, simplify);
 			continue;
 		case path_ignored:
 			continue;
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 0da1214..7a73448 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -96,7 +96,7 @@ cat >expected <<\EOF
 ?? expected
 EOF
 
-test_expect_success 'status ignored tracked directory with --ignore' '
+test_expect_success 'status tracked directory with --ignore' '
 	rm -rf untracked-ignored &&
 	mkdir tracked &&
 	: >tracked/committed &&
@@ -113,7 +113,7 @@ cat >expected <<\EOF
 ?? expected
 EOF
 
-test_expect_success 'status ignored tracked directory with --ignore -u' '
+test_expect_success 'status tracked directory with --ignore -u' '
 	git status --porcelain --ignored -u >actual &&
 	test_cmp expected actual
 '
@@ -122,10 +122,10 @@ cat >expected <<\EOF
 ?? .gitignore
 ?? actual
 ?? expected
-!! tracked/
+!! tracked/uncommitted
 EOF
 
-test_expect_success 'status ignored tracked directory and uncommitted file with --ignore' '
+test_expect_success 'status tracked directory and uncommitted file with --ignore' '
 	: >tracked/uncommitted &&
 	git status --porcelain --ignored >actual &&
 	test_cmp expected actual
@@ -138,6 +138,63 @@ cat >expected <<\EOF
 !! tracked/uncommitted
 EOF
 
+test_expect_success 'status tracked directory and uncommitted file with --ignore -u' '
+	git status --porcelain --ignored -u >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! tracked/untracked/
+EOF
+
+test_expect_success 'status ignored untracked directory and uncommitted file with --ignore' '
+	rm -rf tracked/uncommitted &&
+	mkdir tracked/untracked &&
+	: >tracked/untracked/uncommitted &&
+	git status --porcelain --ignored >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! tracked/untracked/uncommitted
+EOF
+
+test_expect_success 'status ignored untracked directory and uncommitted file with --ignore -u' '
+	git status --porcelain --ignored -u >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! tracked/tracked/uncommitted
+EOF
+
+test_expect_success 'status ignored tracked directory and uncommitted file with --ignore' '
+	rm -rf tracked/untracked &&
+	mkdir tracked/tracked &&
+	: >tracked/tracked/committed &&
+	: >tracked/tracked/uncommitted &&
+	git add -f tracked/tracked/committed &&
+	git commit -m. &&
+	git status --porcelain --ignored >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+?? .gitignore
+?? actual
+?? expected
+!! tracked/tracked/uncommitted
+EOF
+
 test_expect_success 'status ignored tracked directory and uncommitted file with --ignore -u' '
 	git status --porcelain --ignored -u >actual &&
 	test_cmp expected actual
diff --git a/wt-status.c b/wt-status.c
index ef405d0..79eb124 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -518,7 +518,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		dir.nr = 0;
 		dir.flags = DIR_SHOW_IGNORED;
 		if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
-			dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
+			dir.flags |= DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECTORIES;
 		fill_directory(&dir, s->pathspec);
 		for (i = 0; i < dir.nr; i++) {
 			struct dir_entry *ent = dir.entries[i];
-- 
1.8.1.2.7988.ge3e3ca2
