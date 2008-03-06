From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/4] Make 'unpack_trees()' take the index to work on as an argument
Date: Thu, 6 Mar 2008 12:26:14 -0800
Message-ID: <58b39914e50e0cb91e026a6561803e9f039b8fa2.1204856187.git.torvalds@linux-foundation.org>
References: <cover.1204856187.git.torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 03:22:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXSDx-0001X7-Fj
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 03:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763476AbYCGCVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 21:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763460AbYCGCVi
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 21:21:38 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40949 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760122AbYCGCVg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 21:21:36 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m272Ln3S010938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Mar 2008 18:21:51 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m272LQmc032714;
	Thu, 6 Mar 2008 18:21:26 -0800
In-Reply-To: <cover.1204856187.git.torvalds@linux-foundation.org>
X-Spam-Status: No, hits=-4.009 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76456>

This is just a very mechanical conversion, and makes everybody set it to
'&the_index' before calling, but at least it makes it more explicit
where we work with the index.

The next stage would be to split that index usage up into a 'source' and
a 'destination' index, so that we can unpack into a different index than
we started out from.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin-checkout.c        |    6 +++
 builtin-commit.c          |    1 +
 builtin-merge-recursive.c |    1 +
 builtin-read-tree.c       |    1 +
 diff-lib.c                |    2 +
 unpack-trees.c            |   79 +++++++++++++++++++++++----------------------
 unpack-trees.h            |    1 +
 7 files changed, 52 insertions(+), 39 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 6b08016..9bdb623 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -152,6 +152,7 @@ static int reset_to_new(struct tree *tree, int quiet)
 {
 	struct unpack_trees_options opts;
 	struct tree_desc tree_desc;
+
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
 	opts.update = 1;
@@ -159,6 +160,7 @@ static int reset_to_new(struct tree *tree, int quiet)
 	opts.merge = 1;
 	opts.fn = oneway_merge;
 	opts.verbose_update = !quiet;
+	opts.index = &the_index;
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	if (unpack_trees(1, &tree_desc, &opts))
@@ -170,6 +172,7 @@ static void reset_clean_to_new(struct tree *tree, int quiet)
 {
 	struct unpack_trees_options opts;
 	struct tree_desc tree_desc;
+
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
 	opts.skip_unmerged = 1;
@@ -177,6 +180,7 @@ static void reset_clean_to_new(struct tree *tree, int quiet)
 	opts.merge = 1;
 	opts.fn = oneway_merge;
 	opts.verbose_update = !quiet;
+	opts.index = &the_index;
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	if (unpack_trees(1, &tree_desc, &opts))
@@ -224,8 +228,10 @@ static int merge_working_tree(struct checkout_opts *opts,
 		struct tree_desc trees[2];
 		struct tree *tree;
 		struct unpack_trees_options topts;
+
 		memset(&topts, 0, sizeof(topts));
 		topts.head_idx = -1;
+		topts.index = &the_index;
 
 		refresh_cache(REFRESH_QUIET);
 
diff --git a/builtin-commit.c b/builtin-commit.c
index f49c22e..38a5422 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -198,6 +198,7 @@ static void create_base_index(void)
 	opts.head_idx = 1;
 	opts.index_only = 1;
 	opts.merge = 1;
+	opts.index = &the_index;
 
 	opts.fn = oneway_merge;
 	tree = parse_tree_indirect(head_sha1);
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 6fe4102..50b3896 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -213,6 +213,7 @@ static int git_merge_trees(int index_only,
 	opts.merge = 1;
 	opts.head_idx = 2;
 	opts.fn = threeway_merge;
+	opts.index = &the_index;
 
 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 0138f5a..d004e90 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -102,6 +102,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
+	opts.index = &the_index;
 
 	git_config(git_default_config);
 
diff --git a/diff-lib.c b/diff-lib.c
index 4581b59..e359058 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -734,6 +734,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	opts.merge = 1;
 	opts.fn = oneway_diff;
 	opts.unpack_data = revs;
+	opts.index = &the_index;
 
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
@@ -787,6 +788,7 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	opts.merge = 1;
 	opts.fn = oneway_diff;
 	opts.unpack_data = &revs;
+	opts.index = &the_index;
 
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
diff --git a/unpack-trees.c b/unpack-trees.c
index ee9be29..cb8f847 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,3 +1,4 @@
+#define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
 #include "dir.h"
 #include "tree.h"
@@ -7,10 +8,10 @@
 #include "progress.h"
 #include "refs.h"
 
-static inline void remove_entry(int remove)
+static inline void remove_entry(int remove, struct unpack_trees_options *o)
 {
 	if (remove >= 0)
-		remove_cache_entry_at(remove);
+		remove_index_entry_at(o->index, remove);
 }
 
 /* Unlink the last component and attempt to remove leading
@@ -53,8 +54,8 @@ static void check_updates(struct unpack_trees_options *o)
 	int i;
 
 	if (o->update && o->verbose_update) {
-		for (total = cnt = 0; cnt < active_nr; cnt++) {
-			struct cache_entry *ce = active_cache[cnt];
+		for (total = cnt = 0; cnt < o->index->cache_nr; cnt++) {
+			struct cache_entry *ce = o->index->cache[cnt];
 			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
 				total++;
 		}
@@ -65,15 +66,15 @@ static void check_updates(struct unpack_trees_options *o)
 	}
 
 	*last_symlink = '\0';
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = 0; i < o->index->cache_nr; i++) {
+		struct cache_entry *ce = o->index->cache[i];
 
 		if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
 			display_progress(progress, ++cnt);
 		if (ce->ce_flags & CE_REMOVE) {
 			if (o->update)
 				unlink_entry(ce->name, last_symlink);
-			remove_cache_entry_at(i);
+			remove_index_entry_at(o->index, i);
 			i--;
 			continue;
 		}
@@ -105,7 +106,7 @@ static int unpack_index_entry(struct cache_entry *ce, struct unpack_trees_option
 		if (o->skip_unmerged) {
 			o->pos++;
 		} else {
-			remove_entry(o->pos);
+			remove_entry(o->pos, o);
 		}
 		return 0;
 	}
@@ -242,9 +243,9 @@ static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmas
 		return call_unpack_fn(src, o, remove);
 
 	n += o->merge;
-	remove_entry(remove);
+	remove_entry(remove, o);
 	for (i = 0; i < n; i++)
-		add_cache_entry(src[i], ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
+		add_index_entry(o->index, src[i], ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
 	return 0;
 }
 
@@ -261,8 +262,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 
 	/* Are we supposed to look at the index too? */
 	if (o->merge) {
-		while (o->pos < active_nr) {
-			struct cache_entry *ce = active_cache[o->pos];
+		while (o->pos < o->index->cache_nr) {
+			struct cache_entry *ce = o->index->cache[o->pos];
 			int cmp = compare_entry(ce, info, p);
 			if (cmp < 0) {
 				if (unpack_index_entry(ce, o) < 0)
@@ -277,7 +278,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 					 */
 					if (o->skip_unmerged)
 						return mask;
-					remove_entry(o->pos);
+					remove_entry(o->pos, o);
 					continue;
 				}
 				src[0] = ce;
@@ -312,8 +313,8 @@ static int unpack_failed(struct unpack_trees_options *o, const char *message)
 			return error(message);
 		return -1;
 	}
-	discard_cache();
-	read_cache();
+	discard_index(o->index);
+	read_index(o->index);
 	return -1;
 }
 
@@ -349,8 +350,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	/* Any left-over entries in the index? */
 	if (o->merge) {
-		while (o->pos < active_nr) {
-			struct cache_entry *ce = active_cache[o->pos];
+		while (o->pos < o->index->cache_nr) {
+			struct cache_entry *ce = o->index->cache[o->pos];
 			if (unpack_index_entry(ce, o) < 0)
 				return unpack_failed(o, NULL);
 		}
@@ -395,7 +396,7 @@ static int verify_uptodate(struct cache_entry *ce,
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
-		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID);
+		unsigned changed = ie_match_stat(o->index, ce, &st, CE_MATCH_IGNORE_VALID);
 		if (!changed)
 			return 0;
 		/*
@@ -415,10 +416,10 @@ static int verify_uptodate(struct cache_entry *ce,
 		error("Entry '%s' not uptodate. Cannot merge.", ce->name);
 }
 
-static void invalidate_ce_path(struct cache_entry *ce)
+static void invalidate_ce_path(struct cache_entry *ce, struct unpack_trees_options *o)
 {
 	if (ce)
-		cache_tree_invalidate_path(active_cache_tree, ce->name);
+		cache_tree_invalidate_path(o->index->cache_tree, ce->name);
 }
 
 /*
@@ -463,12 +464,12 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	 * in that directory.
 	 */
 	namelen = strlen(ce->name);
-	pos = cache_name_pos(ce->name, namelen);
+	pos = index_name_pos(o->index, ce->name, namelen);
 	if (0 <= pos)
 		return cnt; /* we have it as nondirectory */
 	pos = -pos - 1;
-	for (i = pos; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
+	for (i = pos; i < o->index->cache_nr; i++) {
+		struct cache_entry *ce = o->index->cache[i];
 		int len = ce_namelen(ce);
 		if (len < namelen ||
 		    strncmp(ce->name, ce->name, namelen) ||
@@ -566,9 +567,9 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 		 * delete this path, which is in a subdirectory that
 		 * is being replaced with a blob.
 		 */
-		cnt = cache_name_pos(ce->name, strlen(ce->name));
+		cnt = index_name_pos(o->index, ce->name, strlen(ce->name));
 		if (0 <= cnt) {
-			struct cache_entry *ce = active_cache[cnt];
+			struct cache_entry *ce = o->index->cache[cnt];
 			if (ce->ce_flags & CE_REMOVE)
 				return 0;
 		}
@@ -597,17 +598,17 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		} else {
 			if (verify_uptodate(old, o))
 				return -1;
-			invalidate_ce_path(old);
+			invalidate_ce_path(old, o);
 		}
 	}
 	else {
 		if (verify_absent(merge, "overwritten", o))
 			return -1;
-		invalidate_ce_path(merge);
+		invalidate_ce_path(merge, o);
 	}
 
 	merge->ce_flags &= ~CE_STAGEMASK;
-	add_cache_entry(merge, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+	add_index_entry(o->index, merge, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 	return 1;
 }
 
@@ -621,14 +622,14 @@ static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
 		if (verify_absent(ce, "removed", o))
 			return -1;
 	ce->ce_flags |= CE_REMOVE;
-	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
-	invalidate_ce_path(ce);
+	add_index_entry(o->index, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+	invalidate_ce_path(ce, o);
 	return 1;
 }
 
 static int keep_entry(struct cache_entry *ce, struct unpack_trees_options *o)
 {
-	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD);
+	add_index_entry(o->index, ce, ADD_CACHE_OK_TO_ADD);
 	return 1;
 }
 
@@ -728,7 +729,7 @@ int threeway_merge(struct cache_entry **stages,
 
 	/* #1 */
 	if (!head && !remote && any_anc_missing) {
-		remove_entry(remove);
+		remove_entry(remove, o);
 		return 0;
 	}
 
@@ -762,7 +763,7 @@ int threeway_merge(struct cache_entry **stages,
 		if ((head_deleted && remote_deleted) ||
 		    (head_deleted && remote && remote_match) ||
 		    (remote_deleted && head && head_match)) {
-			remove_entry(remove);
+			remove_entry(remove, o);
 			if (index)
 				return deleted_entry(index, index, o);
 			else if (ce && !head_deleted) {
@@ -788,7 +789,7 @@ int threeway_merge(struct cache_entry **stages,
 			return -1;
 	}
 
-	remove_entry(remove);
+	remove_entry(remove, o);
 	o->nontrivial_merge = 1;
 
 	/* #2, #3, #4, #6, #7, #9, #10, #11. */
@@ -853,7 +854,7 @@ int twoway_merge(struct cache_entry **src,
 		}
 		else if (oldtree && !newtree && same(current, oldtree)) {
 			/* 10 or 11 */
-			remove_entry(remove);
+			remove_entry(remove, o);
 			return deleted_entry(oldtree, current, o);
 		}
 		else if (oldtree && newtree &&
@@ -863,7 +864,7 @@ int twoway_merge(struct cache_entry **src,
 		}
 		else {
 			/* all other failures */
-			remove_entry(remove);
+			remove_entry(remove, o);
 			if (oldtree)
 				return o->gently ? -1 : reject_merge(oldtree);
 			if (current)
@@ -875,7 +876,7 @@ int twoway_merge(struct cache_entry **src,
 	}
 	else if (newtree)
 		return merged_entry(newtree, current, o);
-	remove_entry(remove);
+	remove_entry(remove, o);
 	return deleted_entry(oldtree, current, o);
 }
 
@@ -922,14 +923,14 @@ int oneway_merge(struct cache_entry **src,
 			     o->merge_size);
 
 	if (!a) {
-		remove_entry(remove);
+		remove_entry(remove, o);
 		return deleted_entry(old, old, o);
 	}
 	if (old && same(old, a)) {
 		if (o->reset) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
-			    ce_match_stat(old, &st, CE_MATCH_IGNORE_VALID))
+			    ie_match_stat(o->index, old, &st, CE_MATCH_IGNORE_VALID))
 				old->ce_flags |= CE_UPDATE;
 		}
 		return keep_entry(old, o);
diff --git a/unpack-trees.h b/unpack-trees.h
index a2df544..65add16 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -28,6 +28,7 @@ struct unpack_trees_options {
 
 	struct cache_entry *df_conflict_entry;
 	void *unpack_data;
+	struct index_state *index;
 };
 
 extern int unpack_trees(unsigned n, struct tree_desc *t,
-- 
1.5.4.3.452.g67136


