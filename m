From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 8/6] Teach directory traversal about subprojects
Date: Wed, 11 Apr 2007 14:49:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704111439210.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:49:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbkhO-0002YH-N2
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 23:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbXDKVtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbXDKVtv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 17:49:51 -0400
Received: from smtp.osdl.org ([65.172.181.24]:33961 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161223AbXDKVtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 17:49:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3BLnjVZ023690
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 14:49:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3BLniPU015329;
	Wed, 11 Apr 2007 14:49:44 -0700
X-Spam-Status: No, hits=-3.955 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44262>


This is the promised cleaned-up version of teaching directory traversal 
(ie the "read_directory()" logic) about subprojects. That makes "git add" 
understand to add/update subprojects.

It now knows to look at the index file to see if a directory is marked as 
a subproject, and use that as information as whether it should be recursed 
into or not. 

It also generally cleans up the handling of directory entries when 
traversing the working tree, by splitting up the decision-making process 
into small functions of their own, and adding a fair number of comments.

Finally, it teaches "add_file_to_cache()" that directory names can have 
slashes at the end, since the directory traversal adds them to make the 
difference between a file and a directory clear (it always did that, but 
my previous too-ugly-to-apply subproject patch had a totally different 
path for subproject directories and avoided the slash for that case).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Yes, this adds many more lines than it removes, but 40 of the added lines 
really are just added comments about what we're doing. And the end result 
really is more readable too even if ignoring the comments, I think.

PS. This does *not* obviate the need to fix git-update-index too, so that 
"git commit -a" works right. I have not yet had time to check out Alex' 
patch for that, so I don't have any comments on that yet. This is 
independent, and really just replaces the really ugly patch I sent out 
earlier. Unlike that ugly patch, I think this one can/should be applied.

 dir.c        |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 dir.h        |    3 +-
 read-cache.c |    4 ++
 3 files changed, 121 insertions(+), 19 deletions(-)

diff --git a/dir.c b/dir.c
index 4f5a224..7b91501 100644
--- a/dir.c
+++ b/dir.c
@@ -7,12 +7,17 @@
  */
 #include "cache.h"
 #include "dir.h"
+#include "refs.h"
 
 struct path_simplify {
 	int len;
 	const char *path;
 };
 
+static int read_directory_recursive(struct dir_struct *dir,
+	const char *path, const char *base, int baselen,
+	int check_only, const struct path_simplify *simplify);
+
 int common_prefix(const char **pathspec)
 {
 	const char *path, *slash, *next;
@@ -286,15 +291,109 @@ struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int
 	return ent;
 }
 
-static int dir_exists(const char *dirname, int len)
+enum exist_status {
+	index_nonexistent = 0,
+	index_directory,
+	index_gitdir,
+};
+
+/*
+ * The index sorts alphabetically by entry name, which
+ * means that a gitlink sorts as '\0' at the end, while
+ * a directory (which is defined not as an entry, but as
+ * the files it contains) will sort with the '/' at the
+ * end.
+ */
+static enum exist_status directory_exists_in_index(const char *dirname, int len)
 {
 	int pos = cache_name_pos(dirname, len);
-	if (pos >= 0)
-		return 1;
-	pos = -pos-1;
-	if (pos >= active_nr) /* can't */
-		return 0;
-	return !strncmp(active_cache[pos]->name, dirname, len);
+	if (pos < 0)
+		pos = -pos-1;
+	while (pos < active_nr) {
+		struct cache_entry *ce = active_cache[pos++];
+		unsigned char endchar;
+
+		if (strncmp(ce->name, dirname, len))
+			break;
+		endchar = ce->name[len];
+		if (endchar > '/')
+			break;
+		if (endchar == '/')
+			return index_directory;
+		if (!endchar && S_ISDIRLNK(ntohl(ce->ce_mode)))
+			return index_gitdir;
+	}
+	return index_nonexistent;
+}
+
+/*
+ * When we find a directory when traversing the filesystem, we
+ * have three distinct cases:
+ *
+ *  - ignore it
+ *  - see it as a directory
+ *  - recurse into it
+ *
+ * and which one we choose depends on a combination of existing
+ * git index contents and the flags passed into the directory
+ * traversal routine.
+ *
+ * Case 1: If we *already* have entries in the index under that
+ * directory name, we always recurse into the directory to see
+ * all the files.
+ *
+ * Case 2: If we *already* have that directory name as a gitlink,
+ * we always continue to see it as a gitlink, regardless of whether
+ * there is an actual git directory there or not (it might not
+ * be checked out as a subproject!)
+ *
+ * Case 3: if we didn't have it in the index previously, we
+ * have a few sub-cases:
+ *
+ *  (a) if "show_other_directories" is true, we show it as
+ *      just a directory, unless "hide_empty_directories" is
+ *      also true and the directory is empty, in which case
+ *      we just ignore it entirely.
+ *  (b) if it looks like a git directory, and we don't have
+ *      'no_dirlinks' set we treat it as a gitlink, and show it
+ *      as a directory.
+ *  (c) otherwise, we recurse into it.
+ */
+enum directory_treatment {
+	show_directory,
+	ignore_directory,
+	recurse_into_directory,
+};
+
+static enum directory_treatment treat_directory(struct dir_struct *dir,
+	const char *dirname, int len,
+	const struct path_simplify *simplify)
+{
+	/* The "len-1" is to strip the final '/' */
+	switch (directory_exists_in_index(dirname, len-1)) {
+	case index_directory:
+		return recurse_into_directory;
+
+	case index_gitdir:
+		return show_directory;
+
+	case index_nonexistent:
+		if (dir->show_other_directories)
+			break;
+		if (!dir->no_dirlinks) {
+			unsigned char sha1[20];
+			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
+				return show_directory;
+		}
+		return recurse_into_directory;
+	}
+
+	/* This is the "show_other_directories" case */
+	if (!dir->hide_empty_directories)
+		return show_directory;
+	if (!read_directory_recursive(dir, dirname, dirname, len, 1, simplify))
+		return ignore_directory;
+	return show_directory;
 }
 
 /*
@@ -380,19 +479,17 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, co
 			case DT_DIR:
 				memcpy(fullname + baselen + len, "/", 2);
 				len++;
-				if (dir->show_other_directories &&
-				    !dir_exists(fullname, baselen + len)) {
-					if (dir->hide_empty_directories &&
-					    !read_directory_recursive(dir,
-						    fullname, fullname,
-						    baselen + len, 1, simplify))
-						continue;
+				switch (treat_directory(dir, fullname, baselen + len, simplify)) {
+				case show_directory:
 					break;
+				case recurse_into_directory:
+					contents += read_directory_recursive(dir,
+						fullname, fullname, baselen + len, 0, simplify);
+					continue;
+				case ignore_directory:
+					continue;
 				}
-
-				contents += read_directory_recursive(dir,
-					fullname, fullname, baselen + len, 0, simplify);
-				continue;
+				break;
 			case DT_REG:
 			case DT_LNK:
 				break;
diff --git a/dir.h b/dir.h
index 33c31f2..1931609 100644
--- a/dir.h
+++ b/dir.h
@@ -33,7 +33,8 @@ struct dir_struct {
 	int nr, alloc;
 	unsigned int show_ignored:1,
 		     show_other_directories:1,
-		     hide_empty_directories:1;
+		     hide_empty_directories:1,
+		     no_dirlinks;
 	struct dir_entry **entries;
 
 	/* Exclude info */
diff --git a/read-cache.c b/read-cache.c
index 795fc5d..4040fac 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -368,6 +368,10 @@ int add_file_to_cache(const char *path, int verbose)
 		die("%s: can only add regular files, symbolic links or git-directories", path);
 
 	namelen = strlen(path);
+	if (S_ISDIR(st.st_mode)) {
+		while (namelen && path[namelen-1] == '/')
+			namelen--;
+	}
 	size = cache_entry_size(namelen);
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, namelen);
