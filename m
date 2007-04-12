From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Teach git-update-index about gitlinks
Date: Thu, 12 Apr 2007 12:29:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704121218130.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 21:31:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Hc51A-0005G5-JQ
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 21:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbXDLT3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 15:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbXDLT3u
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 15:29:50 -0400
Received: from smtp.osdl.org ([65.172.181.24]:56378 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbXDLT3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 15:29:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3CJTfIs022188
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Apr 2007 12:29:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3CJTe06008782;
	Thu, 12 Apr 2007 12:29:40 -0700
X-Spam-Status: No, hits=-3.345 required=5 tests=AWL,PATCH_UNIFIED_DIFF_OSDL,REMOVE_REMOVAL_NEAR
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44349>


I finally got around to looking at Alex' patch to teach update-index about 
gitlinks too, so that "git commit -a" along with any other explicit 
update-index scripts can work.

I don't think there was anything wrong with Alex' patch, but the code he 
patched I felt was just so ugly that the added cases just pushed it over 
the edge. Especially as I don't think that patch necessarily did the right 
thing for a gitlink entry that already existed in the index, but that 
wasn't actually a real git repository in the working tree (just an empty 
subdirectory or a non-git snapshot because it hadn't wanted to track that 
particular subproject).

So I ended up deciding to clean up the git-update-index handling the same 
way I tackled the directory traversal used by git-add earlier: by 
splitting the different cases up into multiple smaller functions, and just 
making the code easier to read (and adding more comments about the 
different cases).

So this replaces the old "process_file()" with a new "process_path()" 
function that then just calls out to different helper functions depending 
on what kind of path it is. Processing a nondirectory ends up being just 
one of the simpler cases.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Alex, I'd appreciate it if you gave this a look-over. I think the logic is 
fairly well-documented and the flow is fairly obvious (the patch is not 
quite as easy to read as the end result, but you can get the gist of it 
from the patch too if you're as used to unified diffs as I am..)

Junio - if you prefer Alex' patch instead, I won't be upset. This is 
definitely a bigger re-org, and while I think it makes sense as a patch 
even *aside* from the gitlink support, it's probably largely a matter of 
taste.

 builtin-update-index.c |  200 +++++++++++++++++++++++++++++++++---------------
 1 files changed, 138 insertions(+), 62 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 89aa0b0..022d5cc 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -9,6 +9,7 @@
 #include "cache-tree.h"
 #include "tree-walk.h"
 #include "builtin.h"
+#include "refs.h"
 
 /*
  * Default to not allowing changes to the list of files. The
@@ -60,78 +61,153 @@ static int mark_valid(const char *path)
 	return -1;
 }
 
-static int process_file(const char *path)
+static int remove_one_path(const char *path)
 {
-	int size, namelen, option, status;
-	struct cache_entry *ce;
-	struct stat st;
-
-	status = lstat(path, &st);
-
-	/* We probably want to do this in remove_file_from_cache() and
-	 * add_cache_entry() instead...
-	 */
-	cache_tree_invalidate_path(active_cache_tree, path);
+	if (!allow_remove)
+		return error("%s: does not exist and --remove not passed", path);
+	if (remove_file_from_cache(path))
+		return error("%s: cannot remove from the index", path);
+	return 0;
+}
 
-	if (status < 0 || S_ISDIR(st.st_mode)) {
-		/* When we used to have "path" and now we want to add
-		 * "path/file", we need a way to remove "path" before
-		 * being able to add "path/file".  However,
-		 * "git-update-index --remove path" would not work.
-		 * --force-remove can be used but this is more user
-		 * friendly, especially since we can do the opposite
-		 * case just fine without --force-remove.
-		 */
-		if (status == 0 || (errno == ENOENT || errno == ENOTDIR)) {
-			if (allow_remove) {
-				if (remove_file_from_cache(path))
-					return error("%s: cannot remove from the index",
-					             path);
-				else
-					return 0;
-			} else if (status < 0) {
-				return error("%s: does not exist and --remove not passed",
-				             path);
-			}
-		}
-		if (0 == status)
-			return error("%s: is a directory - add files inside instead",
-			             path);
-		else
-			return error("lstat(\"%s\"): %s", path,
-				     strerror(errno));
-	}
+/*
+ * Handle a path that couldn't be lstat'ed. It's either:
+ *  - missing file (ENOENT or ENOTDIR). That's ok if we're
+ *    supposed to be removing it and the removal actually
+ *    succeeds.
+ *  - permission error. That's never ok.
+ */
+static int process_lstat_error(const char *path, int err)
+{
+	if (err == ENOENT || err == ENOTDIR)
+		return remove_one_path(path);
+	return error("lstat(\"%s\"): %s", path, strerror(errno));
+}
 
-	namelen = strlen(path);
-	size = cache_entry_size(namelen);
-	ce = xcalloc(1, size);
-	memcpy(ce->name, path, namelen);
-	ce->ce_flags = htons(namelen);
-	fill_stat_cache_info(ce, &st);
-
-	if (trust_executable_bit && has_symlinks)
-		ce->ce_mode = create_ce_mode(st.st_mode);
-	else {
-		/* If there is an existing entry, pick the mode bits and type
-		 * from it, otherwise assume unexecutable regular file.
-		 */
-		struct cache_entry *ent;
-		int pos = cache_name_pos(path, namelen);
+static int add_one_path(struct cache_entry *old, const char *path, int len, struct stat *st)
+{
+	int option, size = cache_entry_size(len);
+	struct cache_entry *ce = xcalloc(1, size);
 
-		ent = (0 <= pos) ? active_cache[pos] : NULL;
-		ce->ce_mode = ce_mode_from_stat(ent, st.st_mode);
-	}
+	memcpy(ce->name, path, len);
+	ce->ce_flags = htons(len);
+	fill_stat_cache_info(ce, st);
+	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
-	if (index_path(ce->sha1, path, &st, !info_only))
+	if (index_path(ce->sha1, path, st, !info_only))
 		return -1;
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
 	if (add_cache_entry(ce, option))
-		return error("%s: cannot add to the index - missing --add option?",
-			     path);
+		return error("%s: cannot add to the index - missing --add option?", path);
 	return 0;
 }
 
+/*
+ * Handle a path that was a directory. Four cases:
+ *
+ *  - it's already a gitlink in the index, and we keep it that
+ *    way, and update it if we can (if we cannot find the HEAD,
+ *    we're going to keep it unchanged in the index!)
+ *
+ *  - it's a *file* in the index, in which case it should be
+ *    removed as a file if removal is allowed, since it doesn't
+ *    exist as such any more. If removal isn't allowed, it's
+ *    an error.
+ *
+ *    (NOTE! This is old and arguably fairly strange behaviour.
+ *    We might want to make this an error unconditionally, and
+ *    use "--force-remove" if you actually want to force removal).
+ *
+ *  - it used to exist as a subdirectory (ie multiple files with
+ *    this particular prefix) in the index, in which case it's wrong
+ *    to try to update it as a directory.
+ *
+ *  - it doesn't exist at all in the index, but it is a valid
+ *    git directory, and it should be *added* as a gitlink.
+ */
+static int process_directory(const char *path, int len, struct stat *st)
+{
+	unsigned char sha1[20];
+	int pos = cache_name_pos(path, len);
+
+	/* Exact match: file or existing gitlink */
+	if (pos >= 0) {
+		struct cache_entry *ce = active_cache[pos];
+		if (S_ISDIRLNK(ntohl(ce->ce_mode))) {
+
+			/* Do nothing to the index if there is no HEAD! */
+			if (resolve_gitlink_ref(path, "HEAD", sha1) < 0)
+				return 0;
+
+			return add_one_path(ce, path, len, st);
+		}
+		/* Should this be an unconditional error? */
+		return remove_one_path(path);
+	}
+
+	/* Inexact match: is there perhaps a subdirectory match? */
+	pos = -pos-1;
+	while (pos < active_nr) {
+		struct cache_entry *ce = active_cache[pos++];
+
+		if (strncmp(ce->name, path, len))
+			break;
+		if (ce->name[len] > '/')
+			break;
+		if (ce->name[len] < '/')
+			continue;
+
+		/* Subdirectory match - error out */
+		return error("%s: is a directory - add individual files instead", path);
+	}
+
+	/* No match - should we add it as a gitlink? */
+	if (!resolve_gitlink_ref(path, "HEAD", sha1))
+		return add_one_path(NULL, path, len, st);
+
+	/* Error out. */
+	return error("%s: is a directory - add files inside instead", path);
+}
+
+/*
+ * Process a regular file
+ */
+static int process_file(const char *path, int len, struct stat *st)
+{
+	int pos = cache_name_pos(path, len);
+	struct cache_entry *ce = pos < 0 ? NULL : active_cache[pos];
+
+	if (ce && S_ISDIRLNK(ntohl(ce->ce_mode)))
+		return error("%s is already a gitlink, not replacing", path);
+
+	return add_one_path(ce, path, len, st);	
+}
+
+static int process_path(const char *path)
+{
+	int len;
+	struct stat st;
+
+	/* We probably want to do this in remove_file_from_cache() and
+	 * add_cache_entry() instead...
+	 */
+	cache_tree_invalidate_path(active_cache_tree, path);
+
+	/*
+	 * First things first: get the stat information, to decide
+	 * what to do about the pathname!
+	 */
+	if (lstat(path, &st) < 0)
+		return process_lstat_error(path, errno);
+
+	len = strlen(path);
+	if (S_ISDIR(st.st_mode))
+		return process_directory(path, len, &st);
+
+	return process_file(path, len, &st);
+}
+
 static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 			 const char *path, int stage)
 {
@@ -210,8 +286,8 @@ static void update_one(const char *path, const char *prefix, int prefix_length)
 		report("remove '%s'", path);
 		goto free_return;
 	}
-	if (process_file(p))
-		die("Unable to process file %s", path);
+	if (process_path(p))
+		die("Unable to process path %s", path);
 	report("add '%s'", path);
  free_return:
 	if (p < path || p > path + strlen(path))
