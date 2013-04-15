From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v2 13/14] dir.c: git-status --ignored: don't scan the work
 tree three times
Date: Mon, 15 Apr 2013 21:14:22 +0200
Message-ID: <516C518E.1000405@gmail.com>
References: <514778E4.1040607@gmail.com> <516C4F27.30203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Adam Spiers <git@adamspiers.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 15 21:14:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URorF-0000Gf-TB
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 21:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933036Ab3DOTOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 15:14:25 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:33232 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075Ab3DOTOY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 15:14:24 -0400
Received: by mail-ee0-f41.google.com with SMTP id c1so2363580eek.14
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=91XVOb+ABhC+swYDgLr2VErg4xgCbH+H4+0R/oz5uAc=;
        b=wcFkZUNfbOf7OMkIH2SzhKMhPi7RJdPGUUtX21UHtqEFpU0xtpYxUD/W1XGHQgsDkx
         8/wRTsanw8x9IfOiRTuVg4R2glni1RD5XrCnqQUUw3moNWW0ceF5o8jxODEOWJB4cK7W
         M23uEBJWL0MBdFP6bY4VTSVUh7snyDxMFQLCL2GOh5Tj4K2p0OJ6py99DERZsusT/r+F
         WsNkdqyaPeftyRCCj3mTURm164DjUfyejtMVpIeVho2oRxp4ewpLMMNVdx+jv5vHd5Ar
         UNPzgbY+vbR8+T5+HhGU0tXRMJH3vd96Nax1XiKglFGHa2M097L5TxQT16b8Ajl6ycWo
         ocVA==
X-Received: by 10.15.98.66 with SMTP id bi42mr43973476eeb.39.1366053262977;
        Mon, 15 Apr 2013 12:14:22 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id bk42sm28418517eeb.3.2013.04.15.12.14.21
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 12:14:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516C4F27.30203@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221303>

'git-status --ignored' recursively scans directories up to three times:

 1. To collect untracked files.

 2. To collect ignored files.

 3. When collecting ignored files, to check that an untracked directory
    that potentially contains ignored files doesn't also contain untracked
    files (i.e. isn't already listed as untracked).

Let's get rid of case 3 first.

Currently, read_directory_recursive returns a boolean whether a directory
contains the requested files or not (actually, it returns the number of
files, but no caller actually needs that), and DIR_SHOW_IGNORED specifies
what we're looking for.

To be able to test for both untracked and ignored files in a single scan,
we need to return a bit more info, and the result must be independent of
the DIR_SHOW_IGNORED flag.

Reuse the path_treatment enum as return value of read_directory_recursive.
Split path_handled in two separate values path_excluded and path_untracked
that don't change their meaning with the DIR_SHOW_IGNORED flag. We don't
need an extra value path_untracked_and_excluded, as directories with both
untracked and ignored files should be listed as untracked.

Rename path_ignored to path_none for clarity (i.e. "don't treat that path"
in contrast to "the path is ignored and should be treated according to
DIR_SHOW_IGNORED").

Replace enum directory_treatment with path_treatment. That's just another
enum with the same meaning, no need to translate back and forth.

In treat_directory, get rid of the extra read_directory_recursive call and
all the DIR_SHOW_IGNORED-specific code.

In read_directory_recursive, decide whether to dir_add_name path_excluded
or path_untracked paths based on the DIR_SHOW_IGNORED flag.

The return value of read_directory_recursive is the maximum path_treatment
of all files and sub-directories. In the check_only case, abort when we've
reached the most significant value (path_untracked).

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 dir.c | 146 +++++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 72 insertions(+), 74 deletions(-)

diff --git a/dir.c b/dir.c
index 5ae5722..5770ed4 100644
--- a/dir.c
+++ b/dir.c
@@ -17,7 +17,21 @@ struct path_simplify {
 	const char *path;
 };
 
-static int read_directory_recursive(struct dir_struct *dir, const char *path, int len,
+/*
+ * Tells read_directory_recursive how a file or directory should be treated.
+ * Values are ordered by significance, e.g. if a directory contains both
+ * excluded and untracked files, it is listed as untracked because
+ * path_untracked > path_excluded.
+ */
+enum path_treatment {
+	path_none = 0,
+	path_recurse,
+	path_excluded,
+	path_untracked
+};
+
+static enum path_treatment read_directory_recursive(struct dir_struct *dir,
+	const char *path, int len,
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
 
@@ -958,35 +972,26 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
  *
  *  (a) if "show_other_directories" is true, we show it as
  *      just a directory, unless "hide_empty_directories" is
- *      also true and the directory is empty, in which case
- *      we just ignore it entirely.
- *      if we are looking for ignored directories, look if it
- *      contains only ignored files to decide if it must be shown as
- *      ignored or not.
+ *      also true, in which case we need to check if it contains any
+ *      untracked and / or ignored files.
  *  (b) if it looks like a git directory, and we don't have
  *      'no_gitlinks' set we treat it as a gitlink, and show it
  *      as a directory.
  *  (c) otherwise, we recurse into it.
  */
-enum directory_treatment {
-	show_directory,
-	ignore_directory,
-	recurse_into_directory
-};
-
-static enum directory_treatment treat_directory(struct dir_struct *dir,
+static enum path_treatment treat_directory(struct dir_struct *dir,
 	const char *dirname, int len, int exclude,
 	const struct path_simplify *simplify)
 {
 	/* The "len-1" is to strip the final '/' */
 	switch (directory_exists_in_index(dirname, len-1)) {
 	case index_directory:
-		return recurse_into_directory;
+		return path_recurse;
 
 	case index_gitdir:
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
-			return ignore_directory;
-		return show_directory;
+			return path_none;
+		return path_untracked;
 
 	case index_nonexistent:
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
@@ -994,32 +999,17 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 		if (!(dir->flags & DIR_NO_GITLINKS)) {
 			unsigned char sha1[20];
 			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
-				return show_directory;
+				return path_untracked;
 		}
-		return recurse_into_directory;
+		return path_recurse;
 	}
 
 	/* This is the "show_other_directories" case */
 
-	/*
-	 * We are looking for ignored files and our directory is not ignored,
-	 * check if it contains untracked files (i.e. is listed as untracked)
-	 */
-	if ((dir->flags & DIR_SHOW_IGNORED) && !exclude) {
-		int ignored;
-		dir->flags &= ~DIR_SHOW_IGNORED;
-		ignored = read_directory_recursive(dir, dirname, len, 1, simplify);
-		dir->flags |= DIR_SHOW_IGNORED;
-
-		if (ignored)
-			return ignore_directory;
-	}
-
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
-		return show_directory;
-	if (!read_directory_recursive(dir, dirname, len, 1, simplify))
-		return ignore_directory;
-	return show_directory;
+		return exclude ? path_excluded : path_untracked;
+
+	return read_directory_recursive(dir, dirname, len, 1, simplify);
 }
 
 /*
@@ -1134,12 +1124,6 @@ static int get_dtype(struct dirent *de, const char *path, int len)
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
@@ -1152,7 +1136,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	/* Always exclude indexed files */
 	if (dtype != DT_DIR &&
 	    cache_name_exists(path->buf, path->len, ignore_case))
-		return path_ignored;
+		return path_none;
 
 	exclude = is_excluded(dir, path->buf, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
@@ -1164,29 +1148,19 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	 * ignored files, ignore it
 	 */
 	if (exclude && !(dir->flags & DIR_SHOW_IGNORED))
-		return path_ignored;
+		return path_excluded;
 
 	switch (dtype) {
 	default:
-		return path_ignored;
+		return path_none;
 	case DT_DIR:
 		strbuf_addch(path, '/');
-		switch (treat_directory(dir, path->buf, path->len, exclude, simplify)) {
-		case show_directory:
-			break;
-		case recurse_into_directory:
-			return path_recurse;
-		case ignore_directory:
-			return path_ignored;
-		}
-		break;
+		return treat_directory(dir, path->buf, path->len, exclude,
+			simplify);
 	case DT_REG:
 	case DT_LNK:
-		if (exclude == !(dir->flags & DIR_SHOW_IGNORED))
-			return path_ignored;
-		break;
+		return exclude ? path_excluded : path_untracked;
 	}
-	return path_handled;
 }
 
 static enum path_treatment treat_path(struct dir_struct *dir,
@@ -1198,11 +1172,11 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 	int dtype;
 
 	if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
-		return path_ignored;
+		return path_none;
 	strbuf_setlen(path, baselen);
 	strbuf_addstr(path, de->d_name);
 	if (simplify_away(path->buf, path->len, simplify))
-		return path_ignored;
+		return path_none;
 
 	dtype = DTYPE(de);
 	return treat_one_path(dir, path, simplify, dtype, de);
@@ -1216,14 +1190,16 @@ static enum path_treatment treat_path(struct dir_struct *dir,
  *
  * Also, we ignore the name ".git" (even if it is not a directory).
  * That likely will not change.
+ *
+ * Returns the most significant path_treatment value encountered in the scan.
  */
-static int read_directory_recursive(struct dir_struct *dir,
+static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 				    const char *base, int baselen,
 				    int check_only,
 				    const struct path_simplify *simplify)
 {
 	DIR *fdir;
-	int contents = 0;
+	enum path_treatment state, subdir_state, dir_state = path_none;
 	struct dirent *de;
 	struct strbuf path = STRBUF_INIT;
 
@@ -1234,26 +1210,48 @@ static int read_directory_recursive(struct dir_struct *dir,
 		goto out;
 
 	while ((de = readdir(fdir)) != NULL) {
-		switch (treat_path(dir, de, &path, baselen, simplify)) {
-		case path_recurse:
-			contents += read_directory_recursive(dir, path.buf,
+		/* check how the file or directory should be treated */
+		state = treat_path(dir, de, &path, baselen, simplify);
+		if (state > dir_state)
+			dir_state = state;
+
+		/* recurse into subdir if instructed by treat_path */
+		if (state == path_recurse) {
+			subdir_state = read_directory_recursive(dir, path.buf,
 				path.len, check_only, simplify);
+			if (subdir_state > dir_state)
+				dir_state = subdir_state;
+		}
+
+		if (check_only) {
+			/* abort early if maximum state has been reached */
+			if (dir_state == path_untracked)
+				break;
+			/* skip the dir_add_* part */
 			continue;
-		case path_ignored:
-			continue;
-		case path_handled:
-			break;
 		}
-		contents++;
-		if (check_only)
+
+		/* add the path to the appropriate result list */
+		switch (state) {
+		case path_excluded:
+			if (dir->flags & DIR_SHOW_IGNORED)
+				dir_add_name(dir, path.buf, path.len);
+			break;
+
+		case path_untracked:
+			if (!(dir->flags & DIR_SHOW_IGNORED))
+				dir_add_name(dir, path.buf, path.len);
 			break;
-		dir_add_name(dir, path.buf, path.len);
+
+		default:
+			break;
+		}
 	}
 	closedir(fdir);
  out:
 	strbuf_release(&path);
 
-	return contents;
+	return dir_state;
 }
 
 static int cmp_name(const void *p1, const void *p2)
@@ -1324,7 +1322,7 @@ static int treat_leading_path(struct dir_struct *dir,
 		if (simplify_away(sb.buf, sb.len, simplify))
 			break;
 		if (treat_one_path(dir, &sb, simplify,
-				   DT_DIR, NULL) == path_ignored)
+				   DT_DIR, NULL) == path_none)
 			break; /* do not recurse into it */
 		if (len <= baselen) {
 			rc = 1;
-- 
1.8.1.2.8026.g2b66448.dirty
