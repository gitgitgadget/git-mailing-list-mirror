From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 1/2] dir.c: Make git-status --ignored more consistent
Date: Sun, 30 Dec 2012 15:39:00 +0100
Message-ID: <1356878341-12942-1-git-send-email-apelisse@gmail.com>
References: <20121229072249.GB15408@sigill.intra.peff.net>
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 15:40:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpK3Y-0001LV-0f
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 15:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab2L3Ojo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 09:39:44 -0500
Received: from mail-wi0-f170.google.com ([209.85.212.170]:54376 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464Ab2L3Ojm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 09:39:42 -0500
Received: by mail-wi0-f170.google.com with SMTP id hq7so5875832wib.5
        for <git@vger.kernel.org>; Sun, 30 Dec 2012 06:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=KagdcqqSbItXJIY3WLzBatiQPn0r44PJnkGFSmE5LwM=;
        b=YP/EM3U+yJIKdqF3igLtqrkmNsf9jIffK7ol21R4koi/yJn0fAUTKwRcyc1u7BtKmX
         wGdtKuLLKxutlSwhGO01ZDrjnxYDukmjny+Np6WnlNo/jCIFatBTK9AT3SJbdyro/VmD
         P+cxLRf8xOnPvChWSdKQW8bCrUGbhC1e6jCoKJFMswZX7GYpQirjQp5w1vOG3NjUEhSE
         7M2vESooMC+7J7aEo5u66SG8ISl9XepdORu6EJSbbeQECTvtifbxUpm+AkDKsd+Ojrcx
         heFsclyXTKyFxvxjsiYY0bhqYz3sHDlul6MEP9RHpl15yCJsnlkMTi4n9DRII/ZzBunk
         xWIg==
X-Received: by 10.180.100.163 with SMTP id ez3mr51603721wib.24.1356878380857;
        Sun, 30 Dec 2012 06:39:40 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id gz3sm71210191wib.2.2012.12.30.06.39.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 30 Dec 2012 06:39:39 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <20121229072249.GB15408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212331>

The current behavior of git-status is inconsistent and
misleading. Especially when used with --untracked-files=all option:

 - files ignored in untracked directories will be missing from status
 output.
 - untracked files in committed yet ignored directories are also
 missing.
 - with --untracked-files=normal, untracked directories that contains
 only ignored files are dropped too.

Make the behavior more consistent across all possible use cases:

 - "--ignored --untracked-files=normal" doesn't show each specific
 files but top directory.
 Shows untracked directories that only contains ignored files, and
 ignored tracked directories with untracked files.
 - "--ignored --untracked-files=all" shows all ignored files, either
 because it's in an ignored directory (tracked or untracked), or
 because the file is explicitly ignored.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 dir.c       |   98 +++++++++++++++++++++++++++++++++++++++++++++++------------
 wt-status.c |    4 ++-
 2 files changed, 81 insertions(+), 21 deletions(-)

diff --git a/dir.c b/dir.c
index 5a83aa7..d0c92dc 100644
--- a/dir.c
+++ b/dir.c
@@ -834,8 +834,9 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
  * traversal routine.
  *
  * Case 1: If we *already* have entries in the index under that
- * directory name, we always recurse into the directory to see
- * all the files.
+ * directory name, we recurse into the directory to see all the files,
+ * unless the directory is excluded and we want to show ignored
+ * directories
  *
  * Case 2: If we *already* have that directory name as a gitlink,
  * we always continue to see it as a gitlink, regardless of whether
@@ -849,6 +850,9 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
  *      just a directory, unless "hide_empty_directories" is
  *      also true and the directory is empty, in which case
  *      we just ignore it entirely.
+ *      if we are looking for ignored directories, look if it
+ *      contains only ignored files to decide if it must be shown as
+ *      ignored or not.
  *  (b) if it looks like a git directory, and we don't have
  *      'no_gitlinks' set we treat it as a gitlink, and show it
  *      as a directory.
@@ -861,12 +865,15 @@ enum directory_treatment {
 };
 
 static enum directory_treatment treat_directory(struct dir_struct *dir,
-	const char *dirname, int len,
+	const char *dirname, int len, int exclude,
 	const struct path_simplify *simplify)
 {
 	/* The "len-1" is to strip the final '/' */
 	switch (directory_exists_in_index(dirname, len-1)) {
 	case index_directory:
+		if ((dir->flags & DIR_SHOW_OTHER_DIRECTORIES) && exclude)
+			break;
+
 		return recurse_into_directory;
 
 	case index_gitdir:
@@ -886,7 +893,23 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 	}
 
 	/* This is the "show_other_directories" case */
-	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
+
+	/*
+	 * We are looking for ignored files and our directory is not ignored,
+	 * check if it contains only ignored files
+	 */
+	if ((dir->flags & DIR_SHOW_IGNORED) && !exclude) {
+		int ignored;
+		dir->flags &= ~DIR_SHOW_IGNORED;
+		dir->flags |= DIR_HIDE_EMPTY_DIRECTORIES;
+		ignored = read_directory_recursive(dir, dirname, len, 1, simplify);
+		dir->flags &= ~DIR_HIDE_EMPTY_DIRECTORIES;
+		dir->flags |= DIR_SHOW_IGNORED;
+
+		return ignored ? ignore_directory : show_directory;
+	}
+	if (!(dir->flags & DIR_SHOW_IGNORED) &&
+	    !(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return show_directory;
 	if (!read_directory_recursive(dir, dirname, len, 1, simplify))
 		return ignore_directory;
@@ -894,6 +917,49 @@ static enum directory_treatment treat_directory(struct dir_struct *dir,
 }
 
 /*
+ * Decide what to do when we find a file while traversing the
+ * filesystem. Mostly two cases:
+ *
+ *  1. We are looking for ignored files
+ *   (a) File is ignored, include it
+ *   (b) File is in ignored path, include it
+ *   (c) File is not ignored, exclude it
+ *
+ *  2. Other scenarios, include the file if not excluded
+ *
+ * Return 1 for exclude, 0 for include.
+ */
+static int treat_file(struct dir_struct *dir, struct strbuf *path, int exclude, int *dtype)
+{
+	struct path_exclude_check check;
+	int exclude_file = 0;
+
+	if (exclude)
+		exclude_file = !(dir->flags & DIR_SHOW_IGNORED);
+	else if (dir->flags & DIR_SHOW_IGNORED) {
+		/*
+		 * Optimization:
+		 * Don't spend time on indexed files, they won't be
+		 * added to the list anyway
+		 */
+		struct cache_entry *ce = index_name_exists(&the_index,
+		    path->buf, path->len, ignore_case);
+
+		if (ce)
+			return 1;
+
+		path_exclude_check_init(&check, dir);
+
+		if (!path_excluded(&check, path->buf, path->len, dtype))
+			exclude_file = 1;
+
+		path_exclude_check_clear(&check);
+	}
+
+	return exclude_file;
+}
+
+/*
  * This is an inexact early pruning of any recursive directory
  * reading - if the path cannot possibly be in the pathspec,
  * return true, and we'll skip it early.
@@ -1031,27 +1097,14 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	if (dtype == DT_UNKNOWN)
 		dtype = get_dtype(de, path->buf, path->len);
 
-	/*
-	 * Do we want to see just the ignored files?
-	 * We still need to recurse into directories,
-	 * even if we don't ignore them, since the
-	 * directory may contain files that we do..
-	 */
-	if (!exclude && (dir->flags & DIR_SHOW_IGNORED)) {
-		if (dtype != DT_DIR)
-			return path_ignored;
-	}
-
 	switch (dtype) {
 	default:
 		return path_ignored;
 	case DT_DIR:
 		strbuf_addch(path, '/');
-		switch (treat_directory(dir, path->buf, path->len, simplify)) {
+
+		switch (treat_directory(dir, path->buf, path->len, exclude, simplify)) {
 		case show_directory:
-			if (exclude != !!(dir->flags
-					  & DIR_SHOW_IGNORED))
-				return path_ignored;
 			break;
 		case recurse_into_directory:
 			return path_recurse;
@@ -1061,7 +1114,12 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		break;
 	case DT_REG:
 	case DT_LNK:
-		break;
+		switch(treat_file(dir, path, exclude, &dtype)) {
+		case 1:
+			return path_ignored;
+		default:
+			break;
+		}
 	}
 	return path_handled;
 }
diff --git a/wt-status.c b/wt-status.c
index 2a9658b..d7cfe8f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -516,7 +516,9 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 	if (s->show_ignored_files) {
 		dir.nr = 0;
-		dir.flags = DIR_SHOW_IGNORED | DIR_SHOW_OTHER_DIRECTORIES;
+		dir.flags = DIR_SHOW_IGNORED;
+		if (s->show_untracked_files != SHOW_ALL_UNTRACKED_FILES)
+			dir.flags |= DIR_SHOW_OTHER_DIRECTORIES;
 		fill_directory(&dir, s->pathspec);
 		for (i = 0; i < dir.nr; i++) {
 			struct dir_entry *ent = dir.entries[i];
-- 
1.7.9.5
