From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] read-tree: move merge functions to the library
Date: Sun, 30 Jul 2006 20:26:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607302025370.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jul 30 20:26:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Fzb-0002WI-Az
	for gcvg-git@gmane.org; Sun, 30 Jul 2006 20:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWG3S0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 14:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWG3S0T
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 14:26:19 -0400
Received: from mail.gmx.net ([213.165.64.21]:23247 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932412AbWG3S0R (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 14:26:17 -0400
Received: (qmail invoked by alias); 30 Jul 2006 18:26:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 30 Jul 2006 20:26:16 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24466>


This will allow merge-recursive to use the read-tree functionality
without exec()ing git-read-tree.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Like the first patch, this is mainly a big code move.

 builtin-read-tree.c |  398 --------------------------------------------------
 unpack-trees.c      |  402 +++++++++++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.h      |    5 +
 3 files changed, 408 insertions(+), 397 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index a9852c7..8869ced 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -3,10 +3,8 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#define DBRT_DEBUG 1
 
 #include "cache.h"
-
 #include "object.h"
 #include "tree.h"
 #include "tree-walk.h"
@@ -16,12 +14,6 @@ #include "builtin.h"
 
 static struct object_list *trees = NULL;
 
-static void reject_merge(struct cache_entry *ce)
-{
-	die("Entry '%s' would be overwritten by merge. Cannot merge.", 
-	    ce->name);
-}
-
 static int list_tree(unsigned char *sha1)
 {
 	struct tree *tree = parse_tree_indirect(sha1);
@@ -31,394 +23,6 @@ static int list_tree(unsigned char *sha1
 	return 0;
 }
 
-static int same(struct cache_entry *a, struct cache_entry *b)
-{
-	if (!!a != !!b)
-		return 0;
-	if (!a && !b)
-		return 1;
-	return a->ce_mode == b->ce_mode && 
-		!memcmp(a->sha1, b->sha1, 20);
-}
-
-
-/*
- * When a CE gets turned into an unmerged entry, we
- * want it to be up-to-date
- */
-static void verify_uptodate(struct cache_entry *ce,
-		struct unpack_trees_options *o)
-{
-	struct stat st;
-
-	if (o->index_only || o->reset)
-		return;
-
-	if (!lstat(ce->name, &st)) {
-		unsigned changed = ce_match_stat(ce, &st, 1);
-		if (!changed)
-			return;
-		errno = 0;
-	}
-	if (o->reset) {
-		ce->ce_flags |= htons(CE_UPDATE);
-		return;
-	}
-	if (errno == ENOENT)
-		return;
-	die("Entry '%s' not uptodate. Cannot merge.", ce->name);
-}
-
-static void invalidate_ce_path(struct cache_entry *ce)
-{
-	if (ce)
-		cache_tree_invalidate_path(active_cache_tree, ce->name);
-}
-
-/*
- * We do not want to remove or overwrite a working tree file that
- * is not tracked.
- */
-static void verify_absent(const char *path, const char *action,
-		struct unpack_trees_options *o)
-{
-	struct stat st;
-
-	if (o->index_only || o->reset || !o->update)
-		return;
-	if (!lstat(path, &st))
-		die("Untracked working tree file '%s' "
-		    "would be %s by merge.", path, action);
-}
-
-static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
-		struct unpack_trees_options *o)
-{
-	merge->ce_flags |= htons(CE_UPDATE);
-	if (old) {
-		/*
-		 * See if we can re-use the old CE directly?
-		 * That way we get the uptodate stat info.
-		 *
-		 * This also removes the UPDATE flag on
-		 * a match.
-		 */
-		if (same(old, merge)) {
-			*merge = *old;
-		} else {
-			verify_uptodate(old, o);
-			invalidate_ce_path(old);
-		}
-	}
-	else {
-		verify_absent(merge->name, "overwritten", o);
-		invalidate_ce_path(merge);
-	}
-
-	merge->ce_flags &= ~htons(CE_STAGEMASK);
-	add_cache_entry(merge, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
-	return 1;
-}
-
-static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
-		struct unpack_trees_options *o)
-{
-	if (old)
-		verify_uptodate(old, o);
-	else
-		verify_absent(ce->name, "removed", o);
-	ce->ce_mode = 0;
-	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
-	invalidate_ce_path(ce);
-	return 1;
-}
-
-static int keep_entry(struct cache_entry *ce)
-{
-	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD);
-	return 1;
-}
-
-#if DBRT_DEBUG
-static void show_stage_entry(FILE *o,
-			     const char *label, const struct cache_entry *ce)
-{
-	if (!ce)
-		fprintf(o, "%s (missing)\n", label);
-	else
-		fprintf(o, "%s%06o %s %d\t%s\n",
-			label,
-			ntohl(ce->ce_mode),
-			sha1_to_hex(ce->sha1),
-			ce_stage(ce),
-			ce->name);
-}
-#endif
-
-static int threeway_merge(struct cache_entry **stages,
-		struct unpack_trees_options *o)
-{
-	struct cache_entry *index;
-	struct cache_entry *head; 
-	struct cache_entry *remote = stages[o->head_idx + 1];
-	int count;
-	int head_match = 0;
-	int remote_match = 0;
-	const char *path = NULL;
-
-	int df_conflict_head = 0;
-	int df_conflict_remote = 0;
-
-	int any_anc_missing = 0;
-	int no_anc_exists = 1;
-	int i;
-
-	for (i = 1; i < o->head_idx; i++) {
-		if (!stages[i])
-			any_anc_missing = 1;
-		else {
-			if (!path)
-				path = stages[i]->name;
-			no_anc_exists = 0;
-		}
-	}
-
-	index = stages[0];
-	head = stages[o->head_idx];
-
-	if (head == &o->df_conflict_entry) {
-		df_conflict_head = 1;
-		head = NULL;
-	}
-
-	if (remote == &o->df_conflict_entry) {
-		df_conflict_remote = 1;
-		remote = NULL;
-	}
-
-	if (!path && index)
-		path = index->name;
-	if (!path && head)
-		path = head->name;
-	if (!path && remote)
-		path = remote->name;
-
-	/* First, if there's a #16 situation, note that to prevent #13
-	 * and #14.
-	 */
-	if (!same(remote, head)) {
-		for (i = 1; i < o->head_idx; i++) {
-			if (same(stages[i], head)) {
-				head_match = i;
-			}
-			if (same(stages[i], remote)) {
-				remote_match = i;
-			}
-		}
-	}
-
-	/* We start with cases where the index is allowed to match
-	 * something other than the head: #14(ALT) and #2ALT, where it
-	 * is permitted to match the result instead.
-	 */
-	/* #14, #14ALT, #2ALT */
-	if (remote && !df_conflict_head && head_match && !remote_match) {
-		if (index && !same(index, remote) && !same(index, head))
-			reject_merge(index);
-		return merged_entry(remote, index, o);
-	}
-	/*
-	 * If we have an entry in the index cache, then we want to
-	 * make sure that it matches head.
-	 */
-	if (index && !same(index, head)) {
-		reject_merge(index);
-	}
-
-	if (head) {
-		/* #5ALT, #15 */
-		if (same(head, remote))
-			return merged_entry(head, index, o);
-		/* #13, #3ALT */
-		if (!df_conflict_remote && remote_match && !head_match)
-			return merged_entry(head, index, o);
-	}
-
-	/* #1 */
-	if (!head && !remote && any_anc_missing)
-		return 0;
-
-	/* Under the new "aggressive" rule, we resolve mostly trivial
-	 * cases that we historically had git-merge-one-file resolve.
-	 */
-	if (o->aggressive) {
-		int head_deleted = !head && !df_conflict_head;
-		int remote_deleted = !remote && !df_conflict_remote;
-		/*
-		 * Deleted in both.
-		 * Deleted in one and unchanged in the other.
-		 */
-		if ((head_deleted && remote_deleted) ||
-		    (head_deleted && remote && remote_match) ||
-		    (remote_deleted && head && head_match)) {
-			if (index)
-				return deleted_entry(index, index, o);
-			else if (path)
-				verify_absent(path, "removed", o);
-			return 0;
-		}
-		/*
-		 * Added in both, identically.
-		 */
-		if (no_anc_exists && head && remote && same(head, remote))
-			return merged_entry(head, index, o);
-
-	}
-
-	/* Below are "no merge" cases, which require that the index be
-	 * up-to-date to avoid the files getting overwritten with
-	 * conflict resolution files. 
-	 */
-	if (index) {
-		verify_uptodate(index, o);
-	}
-	else if (path)
-		verify_absent(path, "overwritten", o);
-
-	o->nontrivial_merge = 1;
-
-	/* #2, #3, #4, #6, #7, #9, #11. */
-	count = 0;
-	if (!head_match || !remote_match) {
-		for (i = 1; i < o->head_idx; i++) {
-			if (stages[i]) {
-				keep_entry(stages[i]);
-				count++;
-				break;
-			}
-		}
-	}
-#if DBRT_DEBUG
-	else {
-		fprintf(stderr, "read-tree: warning #16 detected\n");
-		show_stage_entry(stderr, "head   ", stages[head_match]);
-		show_stage_entry(stderr, "remote ", stages[remote_match]);
-	}
-#endif
-	if (head) { count += keep_entry(head); }
-	if (remote) { count += keep_entry(remote); }
-	return count;
-}
-
-/*
- * Two-way merge.
- *
- * The rule is to "carry forward" what is in the index without losing
- * information across a "fast forward", favoring a successful merge
- * over a merge failure when it makes sense.  For details of the
- * "carry forward" rule, please see <Documentation/git-read-tree.txt>.
- *
- */
-static int twoway_merge(struct cache_entry **src,
-		struct unpack_trees_options *o)
-{
-	struct cache_entry *current = src[0];
-	struct cache_entry *oldtree = src[1], *newtree = src[2];
-
-	if (o->merge_size != 2)
-		return error("Cannot do a twoway merge of %d trees",
-			     o->merge_size);
-
-	if (current) {
-		if ((!oldtree && !newtree) || /* 4 and 5 */
-		    (!oldtree && newtree &&
-		     same(current, newtree)) || /* 6 and 7 */
-		    (oldtree && newtree &&
-		     same(oldtree, newtree)) || /* 14 and 15 */
-		    (oldtree && newtree &&
-		     !same(oldtree, newtree) && /* 18 and 19*/
-		     same(current, newtree))) {
-			return keep_entry(current);
-		}
-		else if (oldtree && !newtree && same(current, oldtree)) {
-			/* 10 or 11 */
-			return deleted_entry(oldtree, current, o);
-		}
-		else if (oldtree && newtree &&
-			 same(current, oldtree) && !same(current, newtree)) {
-			/* 20 or 21 */
-			return merged_entry(newtree, current, o);
-		}
-		else {
-			/* all other failures */
-			if (oldtree)
-				reject_merge(oldtree);
-			if (current)
-				reject_merge(current);
-			if (newtree)
-				reject_merge(newtree);
-			return -1;
-		}
-	}
-	else if (newtree)
-		return merged_entry(newtree, current, o);
-	else
-		return deleted_entry(oldtree, current, o);
-}
-
-/*
- * Bind merge.
- *
- * Keep the index entries at stage0, collapse stage1 but make sure
- * stage0 does not have anything there.
- */
-static int bind_merge(struct cache_entry **src,
-		struct unpack_trees_options *o)
-{
-	struct cache_entry *old = src[0];
-	struct cache_entry *a = src[1];
-
-	if (o->merge_size != 1)
-		return error("Cannot do a bind merge of %d trees\n",
-			     o->merge_size);
-	if (a && old)
-		die("Entry '%s' overlaps.  Cannot bind.", a->name);
-	if (!a)
-		return keep_entry(old);
-	else
-		return merged_entry(a, NULL, o);
-}
-
-/*
- * One-way merge.
- *
- * The rule is:
- * - take the stat information from stage0, take the data from stage1
- */
-static int oneway_merge(struct cache_entry **src,
-		struct unpack_trees_options *o)
-{
-	struct cache_entry *old = src[0];
-	struct cache_entry *a = src[1];
-
-	if (o->merge_size != 1)
-		return error("Cannot do a oneway merge of %d trees",
-			     o->merge_size);
-
-	if (!a)
-		return deleted_entry(old, old, o);
-	if (old && same(old, a)) {
-		if (o->reset) {
-			struct stat st;
-			if (lstat(old->name, &st) ||
-			    ce_match_stat(old, &st, 1))
-				old->ce_flags |= htons(CE_UPDATE);
-		}
-		return keep_entry(old);
-	}
-	return merged_entry(a, old, o);
-}
-
 static int read_cache_unmerged(void)
 {
 	int i;
@@ -432,7 +36,7 @@ static int read_cache_unmerged(void)
 		if (ce_stage(ce)) {
 			if (last && !strcmp(ce->name, last->name))
 				continue;
-			invalidate_ce_path(ce);
+			cache_tree_invalidate_path(active_cache_tree, ce->name);
 			last = ce;
 			ce->ce_mode = 0;
 			ce->ce_flags &= ~htons(CE_STAGEMASK);
diff --git a/unpack-trees.c b/unpack-trees.c
index ecff92d..b8a355f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -3,8 +3,11 @@ #include <sys/time.h>
 #include "cache.h"
 #include "tree.h"
 #include "tree-walk.h"
+#include "cache-tree.h"
 #include "unpack-trees.h"
 
+#define DBRT_DEBUG 1
+
 struct tree_entry_list {
 	struct tree_entry_list *next;
 	unsigned directory : 1;
@@ -22,6 +25,9 @@ static struct tree_entry_list *create_tr
 	struct tree_entry_list *ret = NULL;
 	struct tree_entry_list **list_p = &ret;
 
+	if (!tree->object.parsed)
+		parse_tree(tree);
+
 	desc.buf = tree->buffer;
 	desc.size = tree->size;
 
@@ -365,7 +371,9 @@ int unpack_trees(struct object_list *tre
 	struct object_list *posn = trees;
 	struct tree_entry_list df_conflict_list;
 
+	memset(&df_conflict_list, 0, sizeof(df_conflict_list));
 	df_conflict_list.next = &df_conflict_list;
+	memset(&state, 0, sizeof(state));
 	state.base_dir = "";
 	state.force = 1;
 	state.quiet = 1;
@@ -391,4 +399,398 @@ int unpack_trees(struct object_list *tre
 	return 0;
 }
 
+/* Here come the merge functions */
+
+static void reject_merge(struct cache_entry *ce)
+{
+	die("Entry '%s' would be overwritten by merge. Cannot merge.", 
+	    ce->name);
+}
+
+static int same(struct cache_entry *a, struct cache_entry *b)
+{
+	if (!!a != !!b)
+		return 0;
+	if (!a && !b)
+		return 1;
+	return a->ce_mode == b->ce_mode && 
+		!memcmp(a->sha1, b->sha1, 20);
+}
+
+
+/*
+ * When a CE gets turned into an unmerged entry, we
+ * want it to be up-to-date
+ */
+static void verify_uptodate(struct cache_entry *ce,
+		struct unpack_trees_options *o)
+{
+	struct stat st;
+
+	if (o->index_only || o->reset)
+		return;
+
+	if (!lstat(ce->name, &st)) {
+		unsigned changed = ce_match_stat(ce, &st, 1);
+		if (!changed)
+			return;
+		errno = 0;
+	}
+	if (o->reset) {
+		ce->ce_flags |= htons(CE_UPDATE);
+		return;
+	}
+	if (errno == ENOENT)
+		return;
+	die("Entry '%s' not uptodate. Cannot merge.", ce->name);
+}
+
+static void invalidate_ce_path(struct cache_entry *ce)
+{
+	if (ce)
+		cache_tree_invalidate_path(active_cache_tree, ce->name);
+}
+
+/*
+ * We do not want to remove or overwrite a working tree file that
+ * is not tracked.
+ */
+static void verify_absent(const char *path, const char *action,
+		struct unpack_trees_options *o)
+{
+	struct stat st;
+
+	if (o->index_only || o->reset || !o->update)
+		return;
+	if (!lstat(path, &st))
+		die("Untracked working tree file '%s' "
+		    "would be %s by merge.", path, action);
+}
+
+static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
+		struct unpack_trees_options *o)
+{
+	merge->ce_flags |= htons(CE_UPDATE);
+	if (old) {
+		/*
+		 * See if we can re-use the old CE directly?
+		 * That way we get the uptodate stat info.
+		 *
+		 * This also removes the UPDATE flag on
+		 * a match.
+		 */
+		if (same(old, merge)) {
+			*merge = *old;
+		} else {
+			verify_uptodate(old, o);
+			invalidate_ce_path(old);
+		}
+	}
+	else {
+		verify_absent(merge->name, "overwritten", o);
+		invalidate_ce_path(merge);
+	}
+
+	merge->ce_flags &= ~htons(CE_STAGEMASK);
+	add_cache_entry(merge, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+	return 1;
+}
+
+static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
+		struct unpack_trees_options *o)
+{
+	if (old)
+		verify_uptodate(old, o);
+	else
+		verify_absent(ce->name, "removed", o);
+	ce->ce_mode = 0;
+	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+	invalidate_ce_path(ce);
+	return 1;
+}
+
+static int keep_entry(struct cache_entry *ce)
+{
+	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD);
+	return 1;
+}
+
+#if DBRT_DEBUG
+static void show_stage_entry(FILE *o,
+			     const char *label, const struct cache_entry *ce)
+{
+	if (!ce)
+		fprintf(o, "%s (missing)\n", label);
+	else
+		fprintf(o, "%s%06o %s %d\t%s\n",
+			label,
+			ntohl(ce->ce_mode),
+			sha1_to_hex(ce->sha1),
+			ce_stage(ce),
+			ce->name);
+}
+#endif
+
+int threeway_merge(struct cache_entry **stages,
+		struct unpack_trees_options *o)
+{
+	struct cache_entry *index;
+	struct cache_entry *head; 
+	struct cache_entry *remote = stages[o->head_idx + 1];
+	int count;
+	int head_match = 0;
+	int remote_match = 0;
+	const char *path = NULL;
+
+	int df_conflict_head = 0;
+	int df_conflict_remote = 0;
+
+	int any_anc_missing = 0;
+	int no_anc_exists = 1;
+	int i;
 
+	for (i = 1; i < o->head_idx; i++) {
+		if (!stages[i])
+			any_anc_missing = 1;
+		else {
+			if (!path)
+				path = stages[i]->name;
+			no_anc_exists = 0;
+		}
+	}
+
+	index = stages[0];
+	head = stages[o->head_idx];
+
+	if (head == &o->df_conflict_entry) {
+		df_conflict_head = 1;
+		head = NULL;
+	}
+
+	if (remote == &o->df_conflict_entry) {
+		df_conflict_remote = 1;
+		remote = NULL;
+	}
+
+	if (!path && index)
+		path = index->name;
+	if (!path && head)
+		path = head->name;
+	if (!path && remote)
+		path = remote->name;
+
+	/* First, if there's a #16 situation, note that to prevent #13
+	 * and #14.
+	 */
+	if (!same(remote, head)) {
+		for (i = 1; i < o->head_idx; i++) {
+			if (same(stages[i], head)) {
+				head_match = i;
+			}
+			if (same(stages[i], remote)) {
+				remote_match = i;
+			}
+		}
+	}
+
+	/* We start with cases where the index is allowed to match
+	 * something other than the head: #14(ALT) and #2ALT, where it
+	 * is permitted to match the result instead.
+	 */
+	/* #14, #14ALT, #2ALT */
+	if (remote && !df_conflict_head && head_match && !remote_match) {
+		if (index && !same(index, remote) && !same(index, head))
+			reject_merge(index);
+		return merged_entry(remote, index, o);
+	}
+	/*
+	 * If we have an entry in the index cache, then we want to
+	 * make sure that it matches head.
+	 */
+	if (index && !same(index, head)) {
+		reject_merge(index);
+	}
+
+	if (head) {
+		/* #5ALT, #15 */
+		if (same(head, remote))
+			return merged_entry(head, index, o);
+		/* #13, #3ALT */
+		if (!df_conflict_remote && remote_match && !head_match)
+			return merged_entry(head, index, o);
+	}
+
+	/* #1 */
+	if (!head && !remote && any_anc_missing)
+		return 0;
+
+	/* Under the new "aggressive" rule, we resolve mostly trivial
+	 * cases that we historically had git-merge-one-file resolve.
+	 */
+	if (o->aggressive) {
+		int head_deleted = !head && !df_conflict_head;
+		int remote_deleted = !remote && !df_conflict_remote;
+		/*
+		 * Deleted in both.
+		 * Deleted in one and unchanged in the other.
+		 */
+		if ((head_deleted && remote_deleted) ||
+		    (head_deleted && remote && remote_match) ||
+		    (remote_deleted && head && head_match)) {
+			if (index)
+				return deleted_entry(index, index, o);
+			else if (path)
+				verify_absent(path, "removed", o);
+			return 0;
+		}
+		/*
+		 * Added in both, identically.
+		 */
+		if (no_anc_exists && head && remote && same(head, remote))
+			return merged_entry(head, index, o);
+
+	}
+
+	/* Below are "no merge" cases, which require that the index be
+	 * up-to-date to avoid the files getting overwritten with
+	 * conflict resolution files. 
+	 */
+	if (index) {
+		verify_uptodate(index, o);
+	}
+	else if (path)
+		verify_absent(path, "overwritten", o);
+
+	o->nontrivial_merge = 1;
+
+	/* #2, #3, #4, #6, #7, #9, #11. */
+	count = 0;
+	if (!head_match || !remote_match) {
+		for (i = 1; i < o->head_idx; i++) {
+			if (stages[i]) {
+				keep_entry(stages[i]);
+				count++;
+				break;
+			}
+		}
+	}
+#if DBRT_DEBUG
+	else {
+		fprintf(stderr, "read-tree: warning #16 detected\n");
+		show_stage_entry(stderr, "head   ", stages[head_match]);
+		show_stage_entry(stderr, "remote ", stages[remote_match]);
+	}
+#endif
+	if (head) { count += keep_entry(head); }
+	if (remote) { count += keep_entry(remote); }
+	return count;
+}
+
+/*
+ * Two-way merge.
+ *
+ * The rule is to "carry forward" what is in the index without losing
+ * information across a "fast forward", favoring a successful merge
+ * over a merge failure when it makes sense.  For details of the
+ * "carry forward" rule, please see <Documentation/git-read-tree.txt>.
+ *
+ */
+int twoway_merge(struct cache_entry **src,
+		struct unpack_trees_options *o)
+{
+	struct cache_entry *current = src[0];
+	struct cache_entry *oldtree = src[1], *newtree = src[2];
+
+	if (o->merge_size != 2)
+		return error("Cannot do a twoway merge of %d trees",
+			     o->merge_size);
+
+	if (current) {
+		if ((!oldtree && !newtree) || /* 4 and 5 */
+		    (!oldtree && newtree &&
+		     same(current, newtree)) || /* 6 and 7 */
+		    (oldtree && newtree &&
+		     same(oldtree, newtree)) || /* 14 and 15 */
+		    (oldtree && newtree &&
+		     !same(oldtree, newtree) && /* 18 and 19*/
+		     same(current, newtree))) {
+			return keep_entry(current);
+		}
+		else if (oldtree && !newtree && same(current, oldtree)) {
+			/* 10 or 11 */
+			return deleted_entry(oldtree, current, o);
+		}
+		else if (oldtree && newtree &&
+			 same(current, oldtree) && !same(current, newtree)) {
+			/* 20 or 21 */
+			return merged_entry(newtree, current, o);
+		}
+		else {
+			/* all other failures */
+			if (oldtree)
+				reject_merge(oldtree);
+			if (current)
+				reject_merge(current);
+			if (newtree)
+				reject_merge(newtree);
+			return -1;
+		}
+	}
+	else if (newtree)
+		return merged_entry(newtree, current, o);
+	else
+		return deleted_entry(oldtree, current, o);
+}
+
+/*
+ * Bind merge.
+ *
+ * Keep the index entries at stage0, collapse stage1 but make sure
+ * stage0 does not have anything there.
+ */
+int bind_merge(struct cache_entry **src,
+		struct unpack_trees_options *o)
+{
+	struct cache_entry *old = src[0];
+	struct cache_entry *a = src[1];
+
+	if (o->merge_size != 1)
+		return error("Cannot do a bind merge of %d trees\n",
+			     o->merge_size);
+	if (a && old)
+		die("Entry '%s' overlaps.  Cannot bind.", a->name);
+	if (!a)
+		return keep_entry(old);
+	else
+		return merged_entry(a, NULL, o);
+}
+
+/*
+ * One-way merge.
+ *
+ * The rule is:
+ * - take the stat information from stage0, take the data from stage1
+ */
+int oneway_merge(struct cache_entry **src,
+		struct unpack_trees_options *o)
+{
+	struct cache_entry *old = src[0];
+	struct cache_entry *a = src[1];
+
+	if (o->merge_size != 1)
+		return error("Cannot do a oneway merge of %d trees",
+			     o->merge_size);
+
+	if (!a)
+		return deleted_entry(old, old, o);
+	if (old && same(old, a)) {
+		if (o->reset) {
+			struct stat st;
+			if (lstat(old->name, &st) ||
+			    ce_match_stat(old, &st, 1))
+				old->ce_flags |= htons(CE_UPDATE);
+		}
+		return keep_entry(old);
+	}
+	return merged_entry(a, old, o);
+}
diff --git a/unpack-trees.h b/unpack-trees.h
index babfcd7..826b263 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -27,4 +27,9 @@ struct unpack_trees_options {
 extern int unpack_trees(struct object_list *trees,
 		struct unpack_trees_options *options);
 
+int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o);
+int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o);
+int bind_merge(struct cache_entry **src, struct unpack_trees_options *o);
+int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o);
+
 #endif
-- 
1.4.2.rc2.g76b2-dirty
