From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/9] Allow callers of unpack_trees() to handle failure
Date: Mon, 4 Feb 2008 13:35:35 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802041334450.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 19:36:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM6As-0006FZ-3x
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 19:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbYBDSfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 13:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbYBDSfh
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 13:35:37 -0500
Received: from iabervon.org ([66.92.72.58]:51144 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753840AbYBDSfh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 13:35:37 -0500
Received: (qmail 2931 invoked by uid 1000); 4 Feb 2008 18:35:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Feb 2008 18:35:35 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72542>

Return an error from unpack_trees() instead of calling die(), and exit
with an error in read-tree and builtin-commit. merge-recursive already
expected an error return from unpack_trees, so it doesn't need to be
changed. The merge function can return negative to abort.

This will be used in builtin-checkout -m.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-commit.c    |    3 +-
 builtin-read-tree.c |    3 +-
 unpack-trees.c      |   85 ++++++++++++++++++++++++++++----------------------
 3 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 2ffca40..6c817ea 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -204,7 +204,8 @@ static void create_base_index(void)
 		die("failed to unpack HEAD tree object");
 	parse_tree(tree);
 	init_tree_desc(&t, tree->buffer, tree->size);
-	unpack_trees(1, &t, &opts);
+	if (unpack_trees(1, &t, &opts))
+		exit(128); /* We've already reported the error, finish dying */
 }
 
 static char *prepare_index(int argc, const char **argv, const char *prefix)
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 5785401..1d9d125 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -268,7 +268,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		parse_tree(tree);
 		init_tree_desc(t+i, tree->buffer, tree->size);
 	}
-	unpack_trees(nr_trees, t, &opts);
+	if (unpack_trees(nr_trees, t, &opts))
+		return 128;
 
 	/*
 	 * When reading only one tree (either the most basic form,
diff --git a/unpack-trees.c b/unpack-trees.c
index ff46fd6..9e6587f 100644
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
@@ -359,7 +361,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	}
 
 	if (o->trivial_merges_only && o->nontrivial_merge)
-		die("Merge requires file-level merging");
+		return error("Merge requires file-level merging");
 
 	check_updates(active_cache, active_nr, o);
 	return 0;
@@ -367,10 +369,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
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
@@ -388,18 +390,18 @@ static int same(struct cache_entry *a, struct cache_entry *b)
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
@@ -408,12 +410,12 @@ static void verify_uptodate(struct cache_entry *ce,
 		 * checked out.
 		 */
 		if (S_ISGITLINK(ce->ce_mode))
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
@@ -479,7 +481,8 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 		 * ce->name is an entry in the subdirectory.
 		 */
 		if (!ce_stage(ce)) {
-			verify_uptodate(ce, o);
+			if (verify_uptodate(ce, o))
+				return -1;
 			ce->ce_flags |= CE_REMOVE;
 		}
 		cnt++;
@@ -498,8 +501,8 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
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
@@ -508,16 +511,16 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
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
@@ -527,7 +530,7 @@ static void verify_absent(struct cache_entry *ce, const char *action,
 			 * ce->name is explicitly excluded, so it is Ok to
 			 * overwrite it.
 			 */
-			return;
+			return 0;
 		if (S_ISDIR(st.st_mode)) {
 			/*
 			 * We are checking out path "foo" and
@@ -556,7 +559,7 @@ static void verify_absent(struct cache_entry *ce, const char *action,
 			 * deleted entries here.
 			 */
 			o->pos += cnt;
-			return;
+			return 0;
 		}
 
 		/*
@@ -568,12 +571,13 @@ static void verify_absent(struct cache_entry *ce, const char *action,
 		if (0 <= cnt) {
 			struct cache_entry *ce = active_cache[cnt];
 			if (ce->ce_flags & CE_REMOVE)
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
@@ -591,12 +595,14 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		if (same(old, merge)) {
 			memcpy(merge, old, offsetof(struct cache_entry, name));
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
 
@@ -608,10 +614,12 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
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
 	ce->ce_flags |= CE_REMOVE;
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 	invalidate_ce_path(ce);
@@ -699,7 +707,7 @@ int threeway_merge(struct cache_entry **stages,
 	/* #14, #14ALT, #2ALT */
 	if (remote && !df_conflict_head && head_match && !remote_match) {
 		if (index && !same(index, remote) && !same(index, head))
-			reject_merge(index);
+			return reject_merge(index);
 		return merged_entry(remote, index, o);
 	}
 	/*
@@ -707,7 +715,7 @@ int threeway_merge(struct cache_entry **stages,
 	 * make sure that it matches head.
 	 */
 	if (index && !same(index, head)) {
-		reject_merge(index);
+		return reject_merge(index);
 	}
 
 	if (head) {
@@ -758,8 +766,10 @@ int threeway_merge(struct cache_entry **stages,
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
@@ -775,7 +785,8 @@ int threeway_merge(struct cache_entry **stages,
 	 * conflict resolution files.
 	 */
 	if (index) {
-		verify_uptodate(index, o);
+		if (verify_uptodate(index, o))
+			return -1;
 	}
 
 	remove_entry(remove);
@@ -855,11 +866,11 @@ int twoway_merge(struct cache_entry **src,
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
@@ -886,7 +897,7 @@ int bind_merge(struct cache_entry **src,
 		return error("Cannot do a bind merge of %d trees\n",
 			     o->merge_size);
 	if (a && old)
-		die("Entry '%s' overlaps.  Cannot bind.", a->name);
+		return error("Entry '%s' overlaps.  Cannot bind.", a->name);
 	if (!a)
 		return keep_entry(old, o);
 	else
-- 
1.5.4
