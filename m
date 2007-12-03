From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/2] Allow callers of unpack_trees() to handle failure
Date: Mon, 3 Dec 2007 00:32:42 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712030032400.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 06:33:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz3vh-0008Me-VN
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 06:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbXLCFcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 00:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbXLCFcp
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 00:32:45 -0500
Received: from iabervon.org ([66.92.72.58]:46459 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbXLCFco (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 00:32:44 -0500
Received: (qmail 20078 invoked by uid 1000); 3 Dec 2007 05:32:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Dec 2007 05:32:42 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66866>

Return an error from unpack_trees() instead of calling die(), and exit
with an error in read-tree. The merge function can return negative to
abort.

This will be used in builtin-checkout -m.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-read-tree.c |    3 +-
 unpack-trees.c      |   85 ++++++++++++++++++++++++++++----------------------
 2 files changed, 50 insertions(+), 38 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 43cd56a..4f680c3 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -269,7 +269,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		parse_tree(tree);
 		init_tree_desc(t+i, tree->buffer, tree->size);
 	}
-	unpack_trees(nr_trees, t, &opts);
+	if (unpack_trees(nr_trees, t, &opts))
+		return 128;
 
 	/*
 	 * When reading only one tree (either the most basic form,
diff --git a/unpack-trees.c b/unpack-trees.c
index e9eb795..0958166 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -219,6 +219,8 @@ static int unpack_trees_rec(struct tree_entry_list **posns, int len,
 				}
 #endif
 				ret = o->fn(src, o, remove);
+				if (ret < 0)
+					return ret;
 
 #if DBRT_DEBUG > 1
 				printf("Added %d entries\n", ret);
@@ -360,7 +362,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	}
 
 	if (o->trivial_merges_only && o->nontrivial_merge)
-		die("Merge requires file-level merging");
+		return error("Merge requires file-level merging");
 
 	check_updates(active_cache, active_nr, o);
 	return 0;
@@ -368,10 +370,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 /* Here come the merge functions */
 
-static void reject_merge(struct cache_entry *ce)
+static int reject_merge(struct cache_entry *ce)
 {
-	die("Entry '%s' would be overwritten by merge. Cannot merge.",
-	    ce->name);
+	return error("Entry '%s' would be overwritten by merge. Cannot merge.",
+		     ce->name);
 }
 
 static int same(struct cache_entry *a, struct cache_entry *b)
@@ -389,18 +391,18 @@ static int same(struct cache_entry *a, struct cache_entry *b)
  * When a CE gets turned into an unmerged entry, we
  * want it to be up-to-date
  */
-static void verify_uptodate(struct cache_entry *ce,
+static int verify_uptodate(struct cache_entry *ce,
 		struct unpack_trees_options *o)
 {
 	struct stat st;
 
 	if (o->index_only || o->reset)
-		return;
+		return 0;
 
 	if (!lstat(ce->name, &st)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
 		if (!changed)
-			return;
+			return 0;
 		/*
 		 * NEEDSWORK: the current default policy is to allow
 		 * submodule to be out of sync wrt the supermodule
@@ -409,12 +411,12 @@ static void verify_uptodate(struct cache_entry *ce,
 		 * checked out.
 		 */
 		if (S_ISGITLINK(ntohl(ce->ce_mode)))
-			return;
+			return 0;
 		errno = 0;
 	}
 	if (errno == ENOENT)
-		return;
-	die("Entry '%s' not uptodate. Cannot merge.", ce->name);
+		return 0;
+	return error("Entry '%s' not uptodate. Cannot merge.", ce->name);
 }
 
 static void invalidate_ce_path(struct cache_entry *ce)
@@ -480,7 +482,8 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 		 * ce->name is an entry in the subdirectory.
 		 */
 		if (!ce_stage(ce)) {
-			verify_uptodate(ce, o);
+			if (verify_uptodate(ce, o))
+				return -1;
 			ce->ce_mode = 0;
 		}
 		cnt++;
@@ -499,8 +502,8 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 		d.exclude_per_dir = o->dir->exclude_per_dir;
 	i = read_directory(&d, ce->name, pathbuf, namelen+1, NULL);
 	if (i)
-		die("Updating '%s' would lose untracked files in it",
-		    ce->name);
+		return error("Updating '%s' would lose untracked files in it",
+			     ce->name);
 	free(pathbuf);
 	return cnt;
 }
@@ -509,16 +512,16 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
  */
-static void verify_absent(struct cache_entry *ce, const char *action,
-		struct unpack_trees_options *o)
+static int verify_absent(struct cache_entry *ce, const char *action,
+			 struct unpack_trees_options *o)
 {
 	struct stat st;
 
 	if (o->index_only || o->reset || !o->update)
-		return;
+		return 0;
 
 	if (has_symlink_leading_path(ce->name, NULL))
-		return;
+		return 0;
 
 	if (!lstat(ce->name, &st)) {
 		int cnt;
@@ -528,7 +531,7 @@ static void verify_absent(struct cache_entry *ce, const char *action,
 			 * ce->name is explicitly excluded, so it is Ok to
 			 * overwrite it.
 			 */
-			return;
+			return 0;
 		if (S_ISDIR(st.st_mode)) {
 			/*
 			 * We are checking out path "foo" and
@@ -557,7 +560,7 @@ static void verify_absent(struct cache_entry *ce, const char *action,
 			 * deleted entries here.
 			 */
 			o->pos += cnt;
-			return;
+			return 0;
 		}
 
 		/*
@@ -569,12 +572,13 @@ static void verify_absent(struct cache_entry *ce, const char *action,
 		if (0 <= cnt) {
 			struct cache_entry *ce = active_cache[cnt];
 			if (!ce_stage(ce) && !ce->ce_mode)
-				return;
+				return 0;
 		}
 
-		die("Untracked working tree file '%s' "
-		    "would be %s by merge.", ce->name, action);
+		return error("Untracked working tree file '%s' "
+			     "would be %s by merge.", ce->name, action);
 	}
+	return 0;
 }
 
 static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
@@ -592,12 +596,14 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		if (same(old, merge)) {
 			*merge = *old;
 		} else {
-			verify_uptodate(old, o);
+			if (verify_uptodate(old, o))
+				return -1;
 			invalidate_ce_path(old);
 		}
 	}
 	else {
-		verify_absent(merge, "overwritten", o);
+		if (verify_absent(merge, "overwritten", o))
+			return -1;
 		invalidate_ce_path(merge);
 	}
 
@@ -609,10 +615,12 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
 		struct unpack_trees_options *o)
 {
-	if (old)
-		verify_uptodate(old, o);
-	else
-		verify_absent(ce, "removed", o);
+	if (old) {
+		if (verify_uptodate(old, o))
+			return -1;
+	} else
+		if (verify_absent(ce, "removed", o))
+			return -1;
 	ce->ce_mode = 0;
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 	invalidate_ce_path(ce);
@@ -700,7 +708,7 @@ int threeway_merge(struct cache_entry **stages,
 	/* #14, #14ALT, #2ALT */
 	if (remote && !df_conflict_head && head_match && !remote_match) {
 		if (index && !same(index, remote) && !same(index, head))
-			reject_merge(index);
+			return reject_merge(index);
 		return merged_entry(remote, index, o);
 	}
 	/*
@@ -708,7 +716,7 @@ int threeway_merge(struct cache_entry **stages,
 	 * make sure that it matches head.
 	 */
 	if (index && !same(index, head)) {
-		reject_merge(index);
+		return reject_merge(index);
 	}
 
 	if (head) {
@@ -759,8 +767,10 @@ int threeway_merge(struct cache_entry **stages,
 			remove_entry(remove);
 			if (index)
 				return deleted_entry(index, index, o);
-			else if (ce && !head_deleted)
-				verify_absent(ce, "removed", o);
+			else if (ce && !head_deleted) {
+				if (verify_absent(ce, "removed", o))
+					return -1;
+			}
 			return 0;
 		}
 		/*
@@ -776,7 +786,8 @@ int threeway_merge(struct cache_entry **stages,
 	 * conflict resolution files.
 	 */
 	if (index) {
-		verify_uptodate(index, o);
+		if (verify_uptodate(index, o))
+			return -1;
 	}
 
 	remove_entry(remove);
@@ -856,11 +867,11 @@ int twoway_merge(struct cache_entry **src,
 			/* all other failures */
 			remove_entry(remove);
 			if (oldtree)
-				reject_merge(oldtree);
+				return reject_merge(oldtree);
 			if (current)
-				reject_merge(current);
+				return reject_merge(current);
 			if (newtree)
-				reject_merge(newtree);
+				return reject_merge(newtree);
 			return -1;
 		}
 	}
@@ -887,7 +898,7 @@ int bind_merge(struct cache_entry **src,
 		return error("Cannot do a bind merge of %d trees\n",
 			     o->merge_size);
 	if (a && old)
-		die("Entry '%s' overlaps.  Cannot bind.", a->name);
+		return error("Entry '%s' overlaps.  Cannot bind.", a->name);
 	if (!a)
 		return keep_entry(old, o);
 	else
-- 
1.5.3.6.886.gb204
