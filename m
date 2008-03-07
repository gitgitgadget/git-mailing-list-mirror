From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/4] Make 'unpack_trees()' have a separate source and destination index
Date: Thu, 6 Mar 2008 18:12:28 -0800
Message-ID: <8676ea8b0313abfc2e0946f45f636643e28aade8.1204856187.git.torvalds@linux-foundation.org>
References: <cover.1204856187.git.torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 03:23:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXSEl-0001nN-6E
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 03:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757884AbYCGCVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 21:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757617AbYCGCVv
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 21:21:51 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46089 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757712AbYCGCVt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 21:21:49 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m272LvmQ010946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Mar 2008 18:21:58 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m272LX3R032719;
	Thu, 6 Mar 2008 18:21:34 -0800
In-Reply-To: <cover.1204856187.git.torvalds@linux-foundation.org>
X-Spam-Status: No, hits=-4 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76457>

We will always unpack into our own internal index, but we will take the
source from wherever specified, and we will optionally write the result
to a specified index (optionally, because not everybody even _wants_ any
result: the index diffing really wants to just walk the tree and index
in parallel).

This ends up removing a fair number more lines than it adds, for the
simple reason that we can now skip all the crud that tried to be
oh-so-careful about maintaining our position in the index as we were
traversing and modifying it.  Since we don't actually modify the source
index any more, we can just update the 'o->pos' pointer without worrying
about whether an index entry got removed or replaced or added to.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin-checkout.c        |    9 ++-
 builtin-commit.c          |    3 +-
 builtin-merge-recursive.c |    3 +-
 builtin-read-tree.c       |   24 +-------
 diff-lib.c                |   49 +++------------
 unpack-trees.c            |  149 ++++++++++++++++++++++-----------------------
 unpack-trees.h            |   16 +++--
 7 files changed, 101 insertions(+), 152 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 9bdb623..7deb504 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -160,7 +160,8 @@ static int reset_to_new(struct tree *tree, int quiet)
 	opts.merge = 1;
 	opts.fn = oneway_merge;
 	opts.verbose_update = !quiet;
-	opts.index = &the_index;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	if (unpack_trees(1, &tree_desc, &opts))
@@ -180,7 +181,8 @@ static void reset_clean_to_new(struct tree *tree, int quiet)
 	opts.merge = 1;
 	opts.fn = oneway_merge;
 	opts.verbose_update = !quiet;
-	opts.index = &the_index;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	if (unpack_trees(1, &tree_desc, &opts))
@@ -231,7 +233,8 @@ static int merge_working_tree(struct checkout_opts *opts,
 
 		memset(&topts, 0, sizeof(topts));
 		topts.head_idx = -1;
-		topts.index = &the_index;
+		topts.src_index = &the_index;
+		topts.dst_index = &the_index;
 
 		refresh_cache(REFRESH_QUIET);
 
diff --git a/builtin-commit.c b/builtin-commit.c
index 38a5422..660a345 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -198,7 +198,8 @@ static void create_base_index(void)
 	opts.head_idx = 1;
 	opts.index_only = 1;
 	opts.merge = 1;
-	opts.index = &the_index;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
 
 	opts.fn = oneway_merge;
 	tree = parse_tree_indirect(head_sha1);
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 50b3896..fa02bb5 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -213,7 +213,8 @@ static int git_merge_trees(int index_only,
 	opts.merge = 1;
 	opts.head_idx = 2;
 	opts.fn = threeway_merge;
-	opts.index = &the_index;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
 
 	init_tree_desc_from_tree(t+0, common);
 	init_tree_desc_from_tree(t+1, head);
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index d004e90..160456d 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -102,7 +102,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
-	opts.index = &the_index;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
 
 	git_config(git_default_config);
 
@@ -221,27 +222,6 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	if ((opts.dir && !opts.update))
 		die("--exclude-per-directory is meaningless unless -u");
 
-	if (opts.prefix) {
-		int pfxlen = strlen(opts.prefix);
-		int pos;
-		if (opts.prefix[pfxlen-1] != '/')
-			die("prefix must end with /");
-		if (stage != 2)
-			die("binding merge takes only one tree");
-		pos = cache_name_pos(opts.prefix, pfxlen);
-		if (0 <= pos)
-			die("corrupt index file");
-		pos = -pos-1;
-		if (pos < active_nr &&
-		    !strncmp(active_cache[pos]->name, opts.prefix, pfxlen))
-			die("subdirectory '%s' already exists.", opts.prefix);
-		pos = cache_name_pos(opts.prefix, pfxlen-1);
-		if (0 <= pos)
-			die("file '%.*s' already exists.",
-					pfxlen-1, opts.prefix);
-		opts.pos = -1 - pos;
-	}
-
 	if (opts.merge) {
 		if (stage < 2)
 			die("just how do you expect me to merge %d trees?", stage-1);
diff --git a/diff-lib.c b/diff-lib.c
index e359058..9520773 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -600,8 +600,7 @@ static void mark_merge_entries(void)
  */
 static void do_oneway_diff(struct unpack_trees_options *o,
 	struct cache_entry *idx,
-	struct cache_entry *tree,
-	int idx_pos, int idx_nr)
+	struct cache_entry *tree)
 {
 	struct rev_info *revs = o->unpack_data;
 	int match_missing, cached;
@@ -643,34 +642,6 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 }
 
 /*
- * Count how many index entries go with the first one
- */
-static inline int count_skip(const struct cache_entry *src, int pos)
-{
-	int skip = 1;
-
-	/* We can only have multiple entries if the first one is not stage-0 */
-	if (ce_stage(src)) {
-		struct cache_entry **p = active_cache + pos;
-		int namelen = ce_namelen(src);
-
-		for (;;) {
-			const struct cache_entry *ce;
-			pos++;
-			if (pos >= active_nr)
-				break;
-			ce = *++p;
-			if (ce_namelen(ce) != namelen)
-				break;
-			if (memcmp(ce->name, src->name, namelen))
-				break;
-			skip++;
-		}
-	}
-	return skip;
-}
-
-/*
  * The unpack_trees() interface is designed for merging, so
  * the different source entries are designed primarily for
  * the source trees, with the old index being really mainly
@@ -685,18 +656,12 @@ static inline int count_skip(const struct cache_entry *src, int pos)
  * the fairly complex unpack_trees() semantic requirements, including
  * the skipping, the path matching, the type conflict cases etc.
  */
-static int oneway_diff(struct cache_entry **src,
-	struct unpack_trees_options *o,
-	int index_pos)
+static int oneway_diff(struct cache_entry **src, struct unpack_trees_options *o)
 {
-	int skip = 0;
 	struct cache_entry *idx = src[0];
 	struct cache_entry *tree = src[1];
 	struct rev_info *revs = o->unpack_data;
 
-	if (index_pos >= 0)
-		skip = count_skip(idx, index_pos);
-
 	/*
 	 * Unpack-trees generates a DF/conflict entry if
 	 * there was a directory in the index and a tree
@@ -707,9 +672,9 @@ static int oneway_diff(struct cache_entry **src,
 		tree = NULL;
 
 	if (ce_path_match(idx ? idx : tree, revs->prune_data))
-		do_oneway_diff(o, idx, tree, index_pos, skip);
+		do_oneway_diff(o, idx, tree);
 
-	return skip;
+	return 0;
 }
 
 int run_diff_index(struct rev_info *revs, int cached)
@@ -734,7 +699,8 @@ int run_diff_index(struct rev_info *revs, int cached)
 	opts.merge = 1;
 	opts.fn = oneway_diff;
 	opts.unpack_data = revs;
-	opts.index = &the_index;
+	opts.src_index = &the_index;
+	opts.dst_index = NULL;
 
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
@@ -788,7 +754,8 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	opts.merge = 1;
 	opts.fn = oneway_diff;
 	opts.unpack_data = &revs;
-	opts.index = &the_index;
+	opts.src_index = &the_index;
+	opts.dst_index = &the_index;
 
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts))
diff --git a/unpack-trees.c b/unpack-trees.c
index cb8f847..0cdf198 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -8,10 +8,18 @@
 #include "progress.h"
 #include "refs.h"
 
-static inline void remove_entry(int remove, struct unpack_trees_options *o)
+static void add_entry(struct unpack_trees_options *o, struct cache_entry *ce,
+	unsigned int set, unsigned int clear)
 {
-	if (remove >= 0)
-		remove_index_entry_at(o->index, remove);
+	unsigned int size = ce_size(ce);
+	struct cache_entry *new = xmalloc(size);
+
+	clear |= CE_HASHED | CE_UNHASHED;
+
+	memcpy(new, ce, size);
+	new->next = NULL;
+	new->ce_flags = (new->ce_flags & ~clear) | set;
+	add_index_entry(&o->result, new, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|ADD_CACHE_SKIP_DFCHECK);
 }
 
 /* Unlink the last component and attempt to remove leading
@@ -51,11 +59,12 @@ static void check_updates(struct unpack_trees_options *o)
 	unsigned cnt = 0, total = 0;
 	struct progress *progress = NULL;
 	char last_symlink[PATH_MAX];
+	struct index_state *index = &o->result;
 	int i;
 
 	if (o->update && o->verbose_update) {
-		for (total = cnt = 0; cnt < o->index->cache_nr; cnt++) {
-			struct cache_entry *ce = o->index->cache[cnt];
+		for (total = cnt = 0; cnt < index->cache_nr; cnt++) {
+			struct cache_entry *ce = index->cache[cnt];
 			if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
 				total++;
 		}
@@ -66,15 +75,15 @@ static void check_updates(struct unpack_trees_options *o)
 	}
 
 	*last_symlink = '\0';
-	for (i = 0; i < o->index->cache_nr; i++) {
-		struct cache_entry *ce = o->index->cache[i];
+	for (i = 0; i < index->cache_nr; i++) {
+		struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & (CE_UPDATE | CE_REMOVE))
 			display_progress(progress, ++cnt);
 		if (ce->ce_flags & CE_REMOVE) {
 			if (o->update)
 				unlink_entry(ce->name, last_symlink);
-			remove_index_entry_at(o->index, i);
+			remove_index_entry_at(&o->result, i);
 			i--;
 			continue;
 		}
@@ -89,28 +98,27 @@ static void check_updates(struct unpack_trees_options *o)
 	stop_progress(&progress);
 }
 
-static inline int call_unpack_fn(struct cache_entry **src, struct unpack_trees_options *o, int remove)
+static inline int call_unpack_fn(struct cache_entry **src, struct unpack_trees_options *o)
 {
-	int ret = o->fn(src, o, remove);
-	if (ret > 0) {
-		o->pos += ret;
+	int ret = o->fn(src, o);
+	if (ret > 0)
 		ret = 0;
-	}
 	return ret;
 }
 
 static int unpack_index_entry(struct cache_entry *ce, struct unpack_trees_options *o)
 {
 	struct cache_entry *src[5] = { ce, };
+
+	o->pos++;
 	if (ce_stage(ce)) {
 		if (o->skip_unmerged) {
-			o->pos++;
-		} else {
-			remove_entry(o->pos, o);
+			add_entry(o, ce, 0, 0);
+			return 0;
 		}
 		return 0;
 	}
-	return call_unpack_fn(src, o, o->pos);
+	return call_unpack_fn(src, o);
 }
 
 int traverse_trees_recursive(int n, unsigned long dirmask, unsigned long df_conflicts, struct name_entry *names, struct traverse_info *info)
@@ -200,7 +208,7 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info, con
 }
 
 static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmask, struct cache_entry *src[5],
-	const struct name_entry *names, const struct traverse_info *info, int remove)
+	const struct name_entry *names, const struct traverse_info *info)
 {
 	int i;
 	struct unpack_trees_options *o = info->data;
@@ -240,12 +248,11 @@ static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmas
 	}
 
 	if (o->merge)
-		return call_unpack_fn(src, o, remove);
+		return call_unpack_fn(src, o);
 
 	n += o->merge;
-	remove_entry(remove, o);
 	for (i = 0; i < n; i++)
-		add_index_entry(o->index, src[i], ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
+		add_entry(o, src[i], 0, 0);
 	return 0;
 }
 
@@ -253,7 +260,6 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 {
 	struct cache_entry *src[5] = { NULL, };
 	struct unpack_trees_options *o = info->data;
-	int remove = -1;
 	const struct name_entry *p = names;
 
 	/* Find first entry with a real name (we could use "mask" too) */
@@ -262,8 +268,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 
 	/* Are we supposed to look at the index too? */
 	if (o->merge) {
-		while (o->pos < o->index->cache_nr) {
-			struct cache_entry *ce = o->index->cache[o->pos];
+		while (o->pos < o->src_index->cache_nr) {
+			struct cache_entry *ce = o->src_index->cache[o->pos];
 			int cmp = compare_entry(ce, info, p);
 			if (cmp < 0) {
 				if (unpack_index_entry(ce, o) < 0)
@@ -271,24 +277,25 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 				continue;
 			}
 			if (!cmp) {
+				o->pos++;
 				if (ce_stage(ce)) {
 					/*
 					 * If we skip unmerged index entries, we'll skip this
 					 * entry *and* the tree entries associated with it!
 					 */
-					if (o->skip_unmerged)
+					if (o->skip_unmerged) {
+						add_entry(o, ce, 0, 0);
 						return mask;
-					remove_entry(o->pos, o);
+					}
 					continue;
 				}
 				src[0] = ce;
-				remove = o->pos;
 			}
 			break;
 		}
 	}
 
-	if (unpack_nondirectories(n, mask, dirmask, src, names, info, remove) < 0)
+	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
 		return -1;
 
 	/* Now handle any directories.. */
@@ -313,8 +320,6 @@ static int unpack_failed(struct unpack_trees_options *o, const char *message)
 			return error(message);
 		return -1;
 	}
-	discard_index(o->index);
-	read_index(o->index);
 	return -1;
 }
 
@@ -330,6 +335,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	state.quiet = 1;
 	state.refresh_cache = 1;
 
+	memset(&o->result, 0, sizeof(o->result));
 	o->merge_size = len;
 
 	if (!dfc)
@@ -350,8 +356,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 
 	/* Any left-over entries in the index? */
 	if (o->merge) {
-		while (o->pos < o->index->cache_nr) {
-			struct cache_entry *ce = o->index->cache[o->pos];
+		while (o->pos < o->src_index->cache_nr) {
+			struct cache_entry *ce = o->src_index->cache[o->pos];
 			if (unpack_index_entry(ce, o) < 0)
 				return unpack_failed(o, NULL);
 		}
@@ -360,7 +366,10 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->trivial_merges_only && o->nontrivial_merge)
 		return unpack_failed(o, "Merge requires file-level merging");
 
+	o->src_index = NULL;
 	check_updates(o);
+	if (o->dst_index)
+		*o->dst_index = o->result;
 	return 0;
 }
 
@@ -396,7 +405,7 @@ static int verify_uptodate(struct cache_entry *ce,
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
-		unsigned changed = ie_match_stat(o->index, ce, &st, CE_MATCH_IGNORE_VALID);
+		unsigned changed = ie_match_stat(o->src_index, ce, &st, CE_MATCH_IGNORE_VALID);
 		if (!changed)
 			return 0;
 		/*
@@ -419,7 +428,7 @@ static int verify_uptodate(struct cache_entry *ce,
 static void invalidate_ce_path(struct cache_entry *ce, struct unpack_trees_options *o)
 {
 	if (ce)
-		cache_tree_invalidate_path(o->index->cache_tree, ce->name);
+		cache_tree_invalidate_path(o->src_index->cache_tree, ce->name);
 }
 
 /*
@@ -464,12 +473,12 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	 * in that directory.
 	 */
 	namelen = strlen(ce->name);
-	pos = index_name_pos(o->index, ce->name, namelen);
+	pos = index_name_pos(o->src_index, ce->name, namelen);
 	if (0 <= pos)
 		return cnt; /* we have it as nondirectory */
 	pos = -pos - 1;
-	for (i = pos; i < o->index->cache_nr; i++) {
-		struct cache_entry *ce = o->index->cache[i];
+	for (i = pos; i < o->src_index->cache_nr; i++) {
+		struct cache_entry *ce = o->src_index->cache[i];
 		int len = ce_namelen(ce);
 		if (len < namelen ||
 		    strncmp(ce->name, ce->name, namelen) ||
@@ -481,7 +490,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 		if (!ce_stage(ce)) {
 			if (verify_uptodate(ce, o))
 				return -1;
-			ce->ce_flags |= CE_REMOVE;
+			add_entry(o, ce, CE_REMOVE, 0);
 		}
 		cnt++;
 	}
@@ -567,9 +576,9 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 		 * delete this path, which is in a subdirectory that
 		 * is being replaced with a blob.
 		 */
-		cnt = index_name_pos(o->index, ce->name, strlen(ce->name));
+		cnt = index_name_pos(&o->result, ce->name, strlen(ce->name));
 		if (0 <= cnt) {
-			struct cache_entry *ce = o->index->cache[cnt];
+			struct cache_entry *ce = o->result.cache[cnt];
 			if (ce->ce_flags & CE_REMOVE)
 				return 0;
 		}
@@ -584,7 +593,6 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		struct unpack_trees_options *o)
 {
-	merge->ce_flags |= CE_UPDATE;
 	if (old) {
 		/*
 		 * See if we can re-use the old CE directly?
@@ -607,29 +615,29 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
 		invalidate_ce_path(merge, o);
 	}
 
-	merge->ce_flags &= ~CE_STAGEMASK;
-	add_index_entry(o->index, merge, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+	add_entry(o, merge, CE_UPDATE, CE_STAGEMASK);
 	return 1;
 }
 
 static int deleted_entry(struct cache_entry *ce, struct cache_entry *old,
 		struct unpack_trees_options *o)
 {
-	if (old) {
-		if (verify_uptodate(old, o))
-			return -1;
-	} else
+	/* Did it exist in the index? */
+	if (!old) {
 		if (verify_absent(ce, "removed", o))
 			return -1;
-	ce->ce_flags |= CE_REMOVE;
-	add_index_entry(o->index, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+		return 0;
+	}
+	if (verify_uptodate(old, o))
+		return -1;
+	add_entry(o, ce, CE_REMOVE, 0);
 	invalidate_ce_path(ce, o);
 	return 1;
 }
 
 static int keep_entry(struct cache_entry *ce, struct unpack_trees_options *o)
 {
-	add_index_entry(o->index, ce, ADD_CACHE_OK_TO_ADD);
+	add_entry(o, ce, 0, 0);
 	return 1;
 }
 
@@ -649,9 +657,7 @@ static void show_stage_entry(FILE *o,
 }
 #endif
 
-int threeway_merge(struct cache_entry **stages,
-		struct unpack_trees_options *o,
-		int remove)
+int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o)
 {
 	struct cache_entry *index;
 	struct cache_entry *head;
@@ -728,10 +734,8 @@ int threeway_merge(struct cache_entry **stages,
 	}
 
 	/* #1 */
-	if (!head && !remote && any_anc_missing) {
-		remove_entry(remove, o);
+	if (!head && !remote && any_anc_missing)
 		return 0;
-	}
 
 	/* Under the new "aggressive" rule, we resolve mostly trivial
 	 * cases that we historically had git-merge-one-file resolve.
@@ -763,10 +767,9 @@ int threeway_merge(struct cache_entry **stages,
 		if ((head_deleted && remote_deleted) ||
 		    (head_deleted && remote && remote_match) ||
 		    (remote_deleted && head && head_match)) {
-			remove_entry(remove, o);
 			if (index)
 				return deleted_entry(index, index, o);
-			else if (ce && !head_deleted) {
+			if (ce && !head_deleted) {
 				if (verify_absent(ce, "removed", o))
 					return -1;
 			}
@@ -789,7 +792,6 @@ int threeway_merge(struct cache_entry **stages,
 			return -1;
 	}
 
-	remove_entry(remove, o);
 	o->nontrivial_merge = 1;
 
 	/* #2, #3, #4, #6, #7, #9, #10, #11. */
@@ -824,9 +826,7 @@ int threeway_merge(struct cache_entry **stages,
  * "carry forward" rule, please see <Documentation/git-read-tree.txt>.
  *
  */
-int twoway_merge(struct cache_entry **src,
-		struct unpack_trees_options *o,
-		int remove)
+int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 {
 	struct cache_entry *current = src[0];
 	struct cache_entry *oldtree = src[1];
@@ -854,7 +854,6 @@ int twoway_merge(struct cache_entry **src,
 		}
 		else if (oldtree && !newtree && same(current, oldtree)) {
 			/* 10 or 11 */
-			remove_entry(remove, o);
 			return deleted_entry(oldtree, current, o);
 		}
 		else if (oldtree && newtree &&
@@ -864,7 +863,6 @@ int twoway_merge(struct cache_entry **src,
 		}
 		else {
 			/* all other failures */
-			remove_entry(remove, o);
 			if (oldtree)
 				return o->gently ? -1 : reject_merge(oldtree);
 			if (current)
@@ -876,7 +874,6 @@ int twoway_merge(struct cache_entry **src,
 	}
 	else if (newtree)
 		return merged_entry(newtree, current, o);
-	remove_entry(remove, o);
 	return deleted_entry(oldtree, current, o);
 }
 
@@ -887,8 +884,7 @@ int twoway_merge(struct cache_entry **src,
  * stage0 does not have anything there.
  */
 int bind_merge(struct cache_entry **src,
-		struct unpack_trees_options *o,
-		int remove)
+		struct unpack_trees_options *o)
 {
 	struct cache_entry *old = src[0];
 	struct cache_entry *a = src[1];
@@ -898,7 +894,7 @@ int bind_merge(struct cache_entry **src,
 			     o->merge_size);
 	if (a && old)
 		return o->gently ? -1 :
-			error("Entry '%s' overlaps.  Cannot bind.", a->name);
+			error("Entry '%s' overlaps with '%s'.  Cannot bind.", a->name, old->name);
 	if (!a)
 		return keep_entry(old, o);
 	else
@@ -911,9 +907,7 @@ int bind_merge(struct cache_entry **src,
  * The rule is:
  * - take the stat information from stage0, take the data from stage1
  */
-int oneway_merge(struct cache_entry **src,
-		struct unpack_trees_options *o,
-		int remove)
+int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o)
 {
 	struct cache_entry *old = src[0];
 	struct cache_entry *a = src[1];
@@ -922,18 +916,19 @@ int oneway_merge(struct cache_entry **src,
 		return error("Cannot do a oneway merge of %d trees",
 			     o->merge_size);
 
-	if (!a) {
-		remove_entry(remove, o);
+	if (!a)
 		return deleted_entry(old, old, o);
-	}
+
 	if (old && same(old, a)) {
+		int update = 0;
 		if (o->reset) {
 			struct stat st;
 			if (lstat(old->name, &st) ||
-			    ie_match_stat(o->index, old, &st, CE_MATCH_IGNORE_VALID))
-				old->ce_flags |= CE_UPDATE;
+			    ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID))
+				update |= CE_UPDATE;
 		}
-		return keep_entry(old, o);
+		add_entry(o, old, update, 0);
+		return 0;
 	}
 	return merged_entry(a, old, o);
 }
diff --git a/unpack-trees.h b/unpack-trees.h
index 65add16..e8abbcd 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -4,8 +4,7 @@
 struct unpack_trees_options;
 
 typedef int (*merge_fn_t)(struct cache_entry **src,
-		struct unpack_trees_options *options,
-		int remove);
+		struct unpack_trees_options *options);
 
 struct unpack_trees_options {
 	int reset;
@@ -28,15 +27,18 @@ struct unpack_trees_options {
 
 	struct cache_entry *df_conflict_entry;
 	void *unpack_data;
-	struct index_state *index;
+
+	struct index_state *dst_index;
+	const struct index_state *src_index;
+	struct index_state result;
 };
 
 extern int unpack_trees(unsigned n, struct tree_desc *t,
 		struct unpack_trees_options *options);
 
-int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o, int);
-int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o, int);
-int bind_merge(struct cache_entry **src, struct unpack_trees_options *o, int);
-int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o, int);
+int threeway_merge(struct cache_entry **stages, struct unpack_trees_options *o);
+int twoway_merge(struct cache_entry **src, struct unpack_trees_options *o);
+int bind_merge(struct cache_entry **src, struct unpack_trees_options *o);
+int oneway_merge(struct cache_entry **src, struct unpack_trees_options *o);
 
 #endif
-- 
1.5.4.3.452.g67136

