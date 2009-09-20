From: Junio C Hamano <gitster@pobox.com>
Subject: [WIP PATCH 5/6] unpack-trees.c: prepare for looking ahead in the
 index
Date: Sat, 19 Sep 2009 22:06:14 -0700
Message-ID: <1253423175-6339-6-git-send-email-gitster@pobox.com>
References: <1253423175-6339-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 07:06:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpEdJ-00044A-Dr
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 07:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbZITFGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 01:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbZITFGb
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 01:06:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbZITFG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 01:06:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C912391BE
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=88s4
	cuf4AdXUp8CIH/6PTpHsw5w=; b=wAzAc8+NGTslNcnsaRax8rtcAZCntN3r+0JB
	RHkZLAnUI1RHBSmd9G2yzGna0A4CeA+bDOuYtiEpErVBnkbx58v/CYTPc8DEwTWK
	ZQAWS6Q3TO9M15RrINrTH1SrQugBpauRrcO2dIK8mNPSYGVbhdQ72uoKxQ9Ps/Bt
	Z6887zU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=lgjq/8
	hZhvp6rZNV8E+X3UC3ZAUNsirflXvmIYcWjQe6dHZTwzgdxuWW5+zalG3YtCeQSA
	yhYowT6ZH3E/gVqkFrUiIKUIGiGwy8fog8UK2kWw+h4p5sEHa1HR4EaNvJtVEG2+
	hX/z/PAWNVm8ZnZrbgk7c0MbThBiFcg7le+no=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 88ADB391BD
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFC11391BC for
 <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:28 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc1.90.ga3b1b
In-Reply-To: <1253423175-6339-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5B27DE16-A5A3-11DE-B13B-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128842>

This prepares but does not yet implement a look-ahead in the index entries
when traverse-trees.c decides to give us tree entries in an order that
does not match what is in the index.

A case where a look-ahead in the index is necessary happens when merging
branch B into branch A while the index matches the current branch A, using
a tree O as their common ancestor, and these three trees looks like this:

   O        A       B
   t                t
   t-i      t-i     t-i
   t-j      t-j
            t/1
            t/2

The traverse_trees() function gets "t", "t-i" and "t" from trees O, A and
B first, and notices that A may have a matching "t" behind "t-i" and "t-j"
(indeed it does), and tells A to give that entry instead.  After unpacking
blob "t" from tree B (as it hasn't changed since O in B and A removed it,
it will result in its removal), it descends into directory "t/".

The side that walked index in parallel to the tree traversal used to be
implemented with one pointer, o->pos, that points at the next index entry
to be processed.  When this happens, the pointer o->pos still points at
"t-i" that is the first entry.  We should be able to skip "t-i" and "t-j"
and locate "t/1" from the index while the recursive invocation of
traverse_trees() walks and match entries found there, and later come back
to process "t-i".

While that look-ahead is not implemented yet, this adds a flag bit,
CE_UNPACKED, to mark the entries in the index that has already been
processed.  o->pos pointer has been renamed to o->cache_bottom and it
points at the first entry that may still need to be processed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * t6035 is still broken with this patch, although t7003 is fixed.

 cache.h        |    2 +
 diff-lib.c     |   18 -----
 unpack-trees.c |  214 ++++++++++++++++++++++++++++++++++++++++++--------------
 unpack-trees.h |    2 +-
 4 files changed, 164 insertions(+), 72 deletions(-)

diff --git a/cache.h b/cache.h
index 5fad24c..18a3e13 100644
--- a/cache.h
+++ b/cache.h
@@ -177,6 +177,8 @@ struct cache_entry {
 #define CE_HASHED    (0x100000)
 #define CE_UNHASHED  (0x200000)
 
+#define CE_UNPACKED  (0x400000)
+
 /*
  * Extended on-disk flags
  */
diff --git a/diff-lib.c b/diff-lib.c
index adf1c5f..f759917 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -359,21 +359,6 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	show_modified(revs, tree, idx, 1, cached, match_missing);
 }
 
-static inline void skip_same_name(struct cache_entry *ce, struct unpack_trees_options *o)
-{
-	int len = ce_namelen(ce);
-	const struct index_state *index = o->src_index;
-
-	while (o->pos < index->cache_nr) {
-		struct cache_entry *next = index->cache[o->pos];
-		if (len != ce_namelen(next))
-			break;
-		if (memcmp(ce->name, next->name, len))
-			break;
-		o->pos++;
-	}
-}
-
 /*
  * The unpack_trees() interface is designed for merging, so
  * the different source entries are designed primarily for
@@ -395,9 +380,6 @@ static int oneway_diff(struct cache_entry **src, struct unpack_trees_options *o)
 	struct cache_entry *tree = src[1];
 	struct rev_info *revs = o->unpack_data;
 
-	if (idx && ce_stage(idx))
-		skip_same_name(idx, o);
-
 	/*
 	 * Unpack-trees generates a DF/conflict entry if
 	 * there was a directory in the index and a tree
diff --git a/unpack-trees.c b/unpack-trees.c
index c424bab..a6f2187 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -126,18 +126,109 @@ static inline int call_unpack_fn(struct cache_entry **src, struct unpack_trees_o
 	return ret;
 }
 
-static int unpack_index_entry(struct cache_entry *ce, struct unpack_trees_options *o)
+static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
+{
+	ce->ce_flags |= CE_UNPACKED;
+
+	if (o->cache_bottom < o->src_index->cache_nr &&
+	    o->src_index->cache[o->cache_bottom] == ce) {
+		int bottom = o->cache_bottom;
+		while (bottom < o->src_index->cache_nr &&
+		       o->src_index->cache[bottom]->ce_flags & CE_UNPACKED)
+			bottom++;
+		o->cache_bottom = bottom;
+	}
+}
+
+static void mark_all_ce_unused(struct index_state *index)
+{
+	int i;
+	for (i = 0; i < index->cache_nr; i++)
+		index->cache[i]->ce_flags &= ~CE_UNPACKED;
+}
+
+static int locate_in_src_index(struct cache_entry *ce,
+			       struct unpack_trees_options *o)
+{
+	struct index_state *index = o->src_index;
+	int len = ce_namelen(ce);
+	int pos = index_name_pos(index, ce->name, len);
+	if (pos < 0)
+		pos = -1 - pos;
+	return pos;
+}
+
+/*
+ * We call unpack_index_entry() with an unmerged cache entry
+ * only in diff-index, and it wants a single callback.  Skip
+ * the other unmerged entry with the same name.
+ */
+static void mark_ce_used_same_name(struct cache_entry *ce,
+				   struct unpack_trees_options *o)
+{
+	struct index_state *index = o->src_index;
+	int len = ce_namelen(ce);
+	int pos;
+
+	for (pos = locate_in_src_index(ce, o); pos < index->cache_nr; pos++) {
+		struct cache_entry *next = index->cache[pos];
+		if (len != ce_namelen(next) ||
+		    memcmp(ce->name, next->name, len))
+			break;
+		mark_ce_used(next, o);
+	}
+}
+
+static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
+{
+	const struct index_state *index = o->src_index;
+	int pos = o->cache_bottom;
+
+	while (pos < index->cache_nr) {
+		struct cache_entry *ce = index->cache[pos];
+		if (!(ce->ce_flags & CE_UNPACKED))
+			return ce;
+		pos++;
+	}
+	return NULL;
+}
+
+static void add_same_unmerged(struct cache_entry *ce,
+			      struct unpack_trees_options *o)
+{
+	struct index_state *index = o->src_index;
+	int len = ce_namelen(ce);
+	int pos = index_name_pos(index, ce->name, len);
+
+	if (0 <= pos)
+		die("programming error in a caller of mark_ce_used_same_name");
+	for (pos = -pos - 1; pos < index->cache_nr; pos++) {
+		struct cache_entry *next = index->cache[pos];
+		if (len != ce_namelen(next) ||
+		    memcmp(ce->name, next->name, len))
+			break;
+		add_entry(o, next, 0, 0);
+		mark_ce_used(next, o);
+	}
+}
+
+static int unpack_index_entry(struct cache_entry *ce,
+			      struct unpack_trees_options *o)
 {
 	struct cache_entry *src[5] = { ce, NULL, };
+	int ret;
 
-	o->pos++;
+	mark_ce_used(ce, o);
 	if (ce_stage(ce)) {
 		if (o->skip_unmerged) {
 			add_entry(o, ce, 0, 0);
 			return 0;
 		}
 	}
-	return call_unpack_fn(src, o);
+	ret = call_unpack_fn(src, o);
+	if (ce_stage(ce))
+		mark_ce_used_same_name(ce, o);
+	return ret;
 }
 
 static int traverse_trees_recursive(int n, unsigned long dirmask, unsigned long df_conflicts, struct name_entry *names, struct traverse_info *info)
@@ -212,6 +303,20 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
 	return ce_namelen(ce) > traverse_path_len(info, n);
 }
 
+static int ce_in_traverse_path(const struct cache_entry *ce,
+			       const struct traverse_info *info)
+{
+	if (!info->prev)
+		return 1;
+	if (do_compare_entry(ce, info->prev, &info->name))
+		return 0;
+	/*
+	 * If ce (blob) is the same name as the path (which is a tree
+	 * we will be descending into), it won't be inside it.
+	 */
+	return (info->pathlen < ce_namelen(ce));
+}
+
 static struct cache_entry *create_ce_entry(const struct traverse_info *info, const struct name_entry *n, int stage)
 {
 	int len = traverse_path_len(info, n);
@@ -300,23 +405,27 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 
 	/* Are we supposed to look at the index too? */
 	if (o->merge) {
-		while (o->pos < o->src_index->cache_nr) {
-			struct cache_entry *ce = o->src_index->cache[o->pos];
-			int cmp = compare_entry(ce, info, p);
+		while (1) {
+			struct cache_entry *ce = next_cache_entry(o);
+			int cmp;
+			if (!ce)
+				break;
+			cmp = compare_entry(ce, info, p);
 			if (cmp < 0) {
 				if (unpack_index_entry(ce, o) < 0)
 					return unpack_failed(o, NULL);
 				continue;
 			}
 			if (!cmp) {
-				o->pos++;
 				if (ce_stage(ce)) {
 					/*
-					 * If we skip unmerged index entries, we'll skip this
-					 * entry *and* the tree entries associated with it!
+					 * If we skip unmerged index
+					 * entries, we'll skip this
+					 * entry *and* the tree
+					 * entries associated with it!
 					 */
 					if (o->skip_unmerged) {
-						add_entry(o, ce, 0, 0);
+						add_same_unmerged(ce, o);
 						return mask;
 					}
 				}
@@ -329,6 +438,13 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
 		return -1;
 
+	if (src[0]) {
+		if (ce_stage(src[0]))
+			mark_ce_used_same_name(src[0], o);
+		else
+			mark_ce_used(src[0], o);
+	}
+
 	/* Now handle any directories.. */
 	if (dirmask) {
 		unsigned long conflicts = mask & ~dirmask;
@@ -338,22 +454,6 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 				conflicts |= 1;
 		}
 
-		/* special case: "diff-index --cached" looking at a tree */
-		if (o->diff_index_cached &&
-		    n == 1 && dirmask == 1 && S_ISDIR(names->mode)) {
-			int matches;
-			matches = cache_tree_matches_traversal(o->src_index->cache_tree,
-							       names, info);
-			/*
-			 * Everything under the name matches.  Adjust o->pos to
-			 * skip the entire hierarchy.
-			 */
-			if (matches) {
-				o->pos += matches;
-				return mask;
-			}
-		}
-
 		if (traverse_trees_recursive(n, dirmask, conflicts,
 					     names, info) < 0)
 			return -1;
@@ -400,14 +500,33 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		info.fn = unpack_callback;
 		info.data = o;
 
+		if (o->prefix) {
+			/*
+			 * Unpack existing index entries that sort before the
+			 * prefix the tree is spliced into.  Note that o->merge
+			 * is always true in this case.
+			 */
+			while (1) {
+				struct cache_entry *ce = next_cache_entry(o);
+				if (!ce)
+					break;
+				if (ce_in_traverse_path(ce, &info))
+					break;
+				if (unpack_index_entry(ce, o) < 0)
+					return unpack_failed(o, NULL);
+			}
+		}
+
 		if (traverse_trees(len, t, &info) < 0)
 			return unpack_failed(o, NULL);
 	}
 
 	/* Any left-over entries in the index? */
 	if (o->merge) {
-		while (o->pos < o->src_index->cache_nr) {
-			struct cache_entry *ce = o->src_index->cache[o->pos];
+		while (1) {
+			struct cache_entry *ce = next_cache_entry(o);
+			if (!ce)
+				break;
 			if (unpack_index_entry(ce, o) < 0)
 				return unpack_failed(o, NULL);
 		}
@@ -416,6 +535,12 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (o->trivial_merges_only && o->nontrivial_merge)
 		return unpack_failed(o, "Merge requires file-level merging");
 
+	/*
+	 * some callers, most notably "git status -v" runs unpack_trees()
+	 * multiple times; clean everything up after us.
+	 */
+	mark_all_ce_unused(o->src_index);
+
 	o->src_index = NULL;
 	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index)
@@ -522,7 +647,9 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	 * in that directory.
 	 */
 	namelen = strlen(ce->name);
-	for (i = o->pos; i < o->src_index->cache_nr; i++) {
+	for (i = locate_in_src_index(ce, o);
+	     i < o->src_index->cache_nr;
+	     i++) {
 		struct cache_entry *ce2 = o->src_index->cache[i];
 		int len = ce_namelen(ce2);
 		if (len < namelen ||
@@ -530,12 +657,14 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 		    ce2->name[namelen] != '/')
 			break;
 		/*
-		 * ce2->name is an entry in the subdirectory.
+		 * ce2->name is an entry in the subdirectory to be
+		 * removed.
 		 */
 		if (!ce_stage(ce2)) {
 			if (verify_uptodate(ce2, o))
 				return -1;
 			add_entry(o, ce2, CE_REMOVE, 0);
+			mark_ce_used(ce2, o);
 		}
 		cnt++;
 	}
@@ -591,7 +720,6 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
-		int ret;
 		int dtype = ce_to_dtype(ce);
 		struct cache_entry *result;
 
@@ -619,28 +747,8 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 			 * files that are in "foo/" we would lose
 			 * them.
 			 */
-			ret = verify_clean_subdirectory(ce, action, o);
-			if (ret < 0)
-				return ret;
-
-			/*
-			 * If this removed entries from the index,
-			 * what that means is:
-			 *
-			 * (1) the caller unpack_callback() saw path/foo
-			 * in the index, and it has not removed it because
-			 * it thinks it is handling 'path' as blob with
-			 * D/F conflict;
-			 * (2) we will return "ok, we placed a merged entry
-			 * in the index" which would cause o->pos to be
-			 * incremented by one;
-			 * (3) however, original o->pos now has 'path/foo'
-			 * marked with "to be removed".
-			 *
-			 * We need to increment it by the number of
-			 * deleted entries here.
-			 */
-			o->pos += ret;
+			if (verify_clean_subdirectory(ce, action, o) < 0)
+				return -1;
 			return 0;
 		}
 
diff --git a/unpack-trees.h b/unpack-trees.h
index d19df44..9a0733e 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -30,7 +30,7 @@ struct unpack_trees_options {
 		     diff_index_cached,
 		     gently;
 	const char *prefix;
-	int pos;
+	int cache_bottom;
 	struct dir_struct *dir;
 	merge_fn_t fn;
 	struct unpack_trees_error_msgs msgs;
-- 
1.6.5.rc1.90.ga3b1b
