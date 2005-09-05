From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 3/4] Rewrite read-tree
Date: Mon, 5 Sep 2005 02:04:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509050204230.23242@iabervon.org>
References: <Pine.LNX.4.63.0509050151240.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 08:02:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECA2O-0003zh-4L
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 08:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVIEGA5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 02:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVIEGA5
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 02:00:57 -0400
Received: from iabervon.org ([66.92.72.58]:34066 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932223AbVIEGA4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 02:00:56 -0400
Received: (qmail 22880 invoked by uid 1000); 5 Sep 2005 02:04:48 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Sep 2005 02:04:48 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0509050151240.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8087>

Adds support for multiple ancestors, removes --emu23, much simplification.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 read-tree.c                       |  811 +++++++++++++++++++------------------
 t/t1005-read-tree-m-2way-emu23.sh |  422 -------------------
 2 files changed, 425 insertions(+), 808 deletions(-)
 delete mode 100755 t/t1005-read-tree-m-2way-emu23.sh

f196469bec156947038f1d3d00c899c9044334ca
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -5,73 +5,291 @@
  */
 #include "cache.h"
 
-static int stage = 0;
+#include "object.h"
+#include "tree.h"
+
+static int merge = 0;
 static int update = 0;
 
-static int unpack_tree(unsigned char *sha1)
-{
-	void *buffer;
-	unsigned long size;
-	int ret;
+static int head_idx = -1;
+static int merge_size = 0;
 
-	buffer = read_object_with_reference(sha1, "tree", &size, NULL);
-	if (!buffer)
-		return -1;
-	ret = read_tree(buffer, size, stage, NULL);
-	free(buffer);
+static struct object_list *trees = NULL;
+
+static struct cache_entry df_conflict_entry = { 
+};
+
+static struct tree_entry_list df_conflict_list = {
+	.name = NULL,
+	.next = &df_conflict_list
+};
+
+typedef int (*merge_fn_t)(struct cache_entry **src);
+
+static int entcmp(char *name1, int dir1, char *name2, int dir2)
+{
+	int len1 = strlen(name1);
+	int len2 = strlen(name2);
+	int len = len1 < len2 ? len1 : len2;
+	int ret = memcmp(name1, name2, len);
+	unsigned char c1, c2;
+	if (ret)
+		return ret;
+	c1 = name1[len];
+	c2 = name2[len];
+	if (!c1 && dir1)
+		c1 = '/';
+	if (!c2 && dir2)
+		c2 = '/';
+	ret = (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
+	if (c1 && c2 && !ret)
+		ret = len1 - len2;
 	return ret;
 }
 
-static int path_matches(struct cache_entry *a, struct cache_entry *b)
+static int unpack_trees_rec(struct tree_entry_list **posns, int len,
+			    const char *base, merge_fn_t fn, int *indpos)
 {
-	int len = ce_namelen(a);
-	return ce_namelen(b) == len &&
-		!memcmp(a->name, b->name, len);
+	int baselen = strlen(base);
+	int src_size = len + 1;
+	do {
+		int i;
+		char *first;
+		int firstdir = 0;
+		int pathlen;
+		unsigned ce_size;
+		struct tree_entry_list **subposns;
+		struct cache_entry **src;
+		int any_files = 0;
+		int any_dirs = 0;
+		char *cache_name;
+		int ce_stage;
+
+		/* Find the first name in the input. */
+
+		first = NULL;
+		cache_name = NULL;
+
+		/* Check the cache */
+		if (merge && *indpos < active_nr) {
+			/* This is a bit tricky: */
+			/* If the index has a subdirectory (with
+			 * contents) as the first name, it'll get a
+			 * filename like "foo/bar". But that's after
+			 * "foo", so the entry in trees will get
+			 * handled first, at which point we'll go into
+			 * "foo", and deal with "bar" from the index,
+			 * because the base will be "foo/". The only
+			 * way we can actually have "foo/bar" first of
+			 * all the things is if the trees don't
+			 * contain "foo" at all, in which case we'll
+			 * handle "foo/bar" without going into the
+			 * directory, but that's fine (and will return
+			 * an error anyway, with the added unknown
+			 * file case.
+			 */
+
+			cache_name = active_cache[*indpos]->name;
+			if (strlen(cache_name) > baselen &&
+			    !memcmp(cache_name, base, baselen)) {
+				cache_name += baselen;
+				first = cache_name;
+			} else {
+				cache_name = NULL;
+			}
+		}
+
+		if (first)
+			printf("index %s\n", first);
+
+		for (i = 0; i < len; i++) {
+			if (!posns[i] || posns[i] == &df_conflict_list)
+				continue;
+			printf("%d %s\n", i + 1, posns[i]->name);
+			if (!first || entcmp(first, firstdir,
+					     posns[i]->name, 
+					     posns[i]->directory) > 0) {
+				first = posns[i]->name;
+				firstdir = posns[i]->directory;
+			}
+		}
+		/* No name means we're done */
+		if (!first)
+			return 0;
+
+		pathlen = strlen(first);
+		ce_size = cache_entry_size(baselen + pathlen);
+
+		src = xmalloc(sizeof(struct cache_entry *) * src_size);
+		memset(src, 0, sizeof(struct cache_entry *) * src_size);
+
+		subposns = xmalloc(sizeof(struct tree_list_entry *) * len);
+		memset(subposns, 0, sizeof(struct tree_list_entry *) * len);
+
+		if (cache_name && !strcmp(cache_name, first)) {
+			any_files = 1;
+			src[0] = active_cache[*indpos];
+			remove_cache_entry_at(*indpos);
+		}
+
+		for (i = 0; i < len; i++) {
+			struct cache_entry *ce;
+
+			if (!posns[i] ||
+			    (posns[i] != &df_conflict_list &&
+			     strcmp(first, posns[i]->name))) {
+				continue;
+			}
+
+			if (posns[i] == &df_conflict_list) {
+				src[i + merge] = &df_conflict_entry;
+				continue;
+			}
+
+			if (posns[i]->directory) {
+				any_dirs = 1;
+				parse_tree(posns[i]->item.tree);
+				subposns[i] = posns[i]->item.tree->entries;
+				posns[i] = posns[i]->next;
+				src[i + merge] = &df_conflict_entry;
+				continue;
+			}
+
+			if (!merge)
+				ce_stage = 0;
+			else if (i + 1 < head_idx)
+				ce_stage = 1;
+			else if (i + 1 > head_idx)
+				ce_stage = 3;
+			else
+				ce_stage = 2;
+
+			ce = xmalloc(ce_size);
+			memset(ce, 0, ce_size);
+			ce->ce_mode = create_ce_mode(posns[i]->mode);
+			ce->ce_flags = create_ce_flags(baselen + pathlen,
+						       ce_stage);
+			memcpy(ce->name, base, baselen);
+			memcpy(ce->name + baselen, first, pathlen + 1);
+
+			any_files = 1;
+
+			memcpy(ce->sha1, posns[i]->item.any->sha1, 20);
+			src[i + merge] = ce;
+			subposns[i] = &df_conflict_list;
+			posns[i] = posns[i]->next;
+		}
+		if (any_files) {
+			if (merge) {
+				int ret;
+
+				printf("%s:\n", first);
+				for (i = 0; i < src_size; i++) {
+					printf(" %d ", i);
+					if (src[i])
+						printf("%s\n", sha1_to_hex(src[i]->sha1));
+					else
+						printf("\n");
+				}
+
+				ret = fn(src);
+				
+				printf("Added %d entries\n", ret);
+
+				*indpos += ret;
+			} else {
+				for (i = 0; i < src_size; i++) {
+					if (src[i]) {
+						add_cache_entry(src[i], ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
+					}
+				}
+			}
+		}
+		if (any_dirs) {
+			char *newbase = xmalloc(baselen + 2 + pathlen);
+			memcpy(newbase, base, baselen);
+			memcpy(newbase + baselen, first, pathlen);
+			newbase[baselen + pathlen] = '/';
+			newbase[baselen + pathlen + 1] = '\0';
+			if (unpack_trees_rec(subposns, len, newbase, fn,
+					     indpos))
+				return -1;
+		}
+		free(subposns);
+		free(src);
+	} while (1);
 }
 
-static int same(struct cache_entry *a, struct cache_entry *b)
+static void reject_merge(struct cache_entry *ce)
 {
-	return a->ce_mode == b->ce_mode && 
-		!memcmp(a->sha1, b->sha1, 20);
+	die("Entry '%s' would be overwritten by merge. Cannot merge.", 
+	    ce->name);
 }
 
+static void check_updates(struct cache_entry **src, int nr)
+{
+	static struct checkout state = {
+		.base_dir = "",
+		.force = 1,
+		.quiet = 1,
+		.refresh_cache = 1,
+	};
+	unsigned short mask = htons(CE_UPDATE);
+	while (nr--) {
+		struct cache_entry *ce = *src++;
+		if (!ce->ce_mode) {
+			if (update)
+				unlink(ce->name);
+			continue;
+		}
+		if (ce->ce_flags & mask) {
+			ce->ce_flags &= ~mask;
+			if (update)
+				checkout_entry(ce, &state);
+		}
+	}
+}
 
-/*
- * This removes all trivial merges that don't change the tree
- * and collapses them to state 0.
- */
-static struct cache_entry *merge_entries(struct cache_entry *a,
-					 struct cache_entry *b,
-					 struct cache_entry *c)
+static int unpack_trees(merge_fn_t fn)
 {
-	/*
-	 * Ok, all three entries describe the same
-	 * filename, but maybe the contents or file
-	 * mode have changed?
-	 *
-	 * The trivial cases end up being the ones where two
-	 * out of three files are the same:
-	 *  - both destinations the same, trivially take either
-	 *  - one of the destination versions hasn't changed,
-	 *    take the other.
-	 *
-	 * The "all entries exactly the same" case falls out as
-	 * a special case of any of the "two same" cases.
-	 *
-	 * Here "a" is "original", and "b" and "c" are the two
-	 * trees we are merging.
-	 */
-	if (a && b && c) {
-		if (same(b,c))
-			return c;
-		if (same(a,b))
-			return c;
-		if (same(a,c))
-			return b;
+	int indpos = 0;
+	unsigned len = object_list_length(trees);
+	struct tree_entry_list **posns = 
+		xmalloc(len * sizeof(struct tree_entry_list *));
+	int i;
+	struct object_list *posn = trees;
+	merge_size = len;
+	for (i = 0; i < len; i++) {
+		posns[i] = ((struct tree *) posn->item)->entries;
+		posn = posn->next;
 	}
-	return NULL;
+	if (unpack_trees_rec(posns, len, "", fn, &indpos))
+		return -1;
+
+	check_updates(active_cache, active_nr);
+	return 0;
 }
 
+static int list_tree(unsigned char *sha1)
+{
+	struct tree *tree = parse_tree_indirect(sha1);
+	if (!tree)
+		return -1;
+	object_list_append(&tree->object, &trees);
+	return 0;
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
 /*
  * When a CE gets turned into an unmerged entry, we
  * want it to be up-to-date
@@ -91,18 +309,7 @@ static void verify_uptodate(struct cache
 	die("Entry '%s' not uptodate. Cannot merge.", ce->name);
 }
 
-/*
- * If the old tree contained a CE that isn't even in the
- * result, that's always a problem, regardless of whether
- * it's up-to-date or not (ie it can be a file that we
- * have updated but not committed yet).
- */
-static void reject_merge(struct cache_entry *ce)
-{
-	die("Entry '%s' would be overwritten by merge. Cannot merge.", ce->name);
-}
-
-static int merged_entry_internal(struct cache_entry *merge, struct cache_entry *old, struct cache_entry **dst, int allow_dirty)
+static int merged_entry(struct cache_entry *merge, struct cache_entry *old)
 {
 	merge->ce_flags |= htons(CE_UPDATE);
 	if (old) {
@@ -115,195 +322,129 @@ static int merged_entry_internal(struct 
 		 */
 		if (same(old, merge)) {
 			*merge = *old;
-		} else if (!allow_dirty) {
+		} else {
 			verify_uptodate(old);
 		}
 	}
 	merge->ce_flags &= ~htons(CE_STAGEMASK);
-	*dst++ = merge;
+	add_cache_entry(merge, ADD_CACHE_OK_TO_ADD);
 	return 1;
 }
 
-static int merged_entry_allow_dirty(struct cache_entry *merge, struct cache_entry *old, struct cache_entry **dst)
-{
-	return merged_entry_internal(merge, old, dst, 1);
-}
-
-static int merged_entry(struct cache_entry *merge, struct cache_entry *old, struct cache_entry **dst)
-{
-	return merged_entry_internal(merge, old, dst, 0);
-}
-
-static int deleted_entry(struct cache_entry *ce, struct cache_entry *old, struct cache_entry **dst)
+static int deleted_entry(struct cache_entry *ce, struct cache_entry *old)
 {
 	if (old)
 		verify_uptodate(old);
 	ce->ce_mode = 0;
-	*dst++ = ce;
+	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD);
 	return 1;
 }
 
-static int causes_df_conflict(struct cache_entry *ce, int stage,
-			      struct cache_entry **dst_,
-			      struct cache_entry **next_,
-			      int tail)
-{
-	/* This is called during the merge operation and walking
-	 * the active_cache[] array is messy, because it is in the
-	 * middle of overlapping copy operation.  The invariants
-	 * are:
-	 * (1) active_cache points at the first (zeroth) entry.
-	 * (2) up to dst pointer are resolved entries.
-	 * (3) from the next pointer (head-inclusive) to the tail
-	 *     of the active_cache array have the remaining paths
-	 *     to be processed.  There can be a gap between dst
-	 *     and next.  Note that next is called "src" in the
-	 *     merge_cache() function, and tail is the original
-	 *     end of active_cache array when merge_cache() started.
-	 * (4) the path corresponding to *ce is not found in (2)
-	 *     or (3).  It is in the gap.
-	 *
-	 *  active_cache -----......+++++++++++++.
-	 *                    ^dst  ^next        ^tail
-	 */
-	int i, next, dst;
-	const char *path = ce->name;
-	int namelen = ce_namelen(ce);
-
-	next = next_ - active_cache;
-	dst = dst_ - active_cache;
-
-	for (i = 0; i < tail; i++) {
-		int entlen, len;
-		const char *one, *two;
-		if (dst <= i && i < next)
-			continue;
-		ce = active_cache[i];
-		if (ce_stage(ce) != stage)
-			continue;
-		/* If ce->name is a prefix of path, then path is a file
-		 * that hangs underneath ce->name, which is bad.
-		 * If path is a prefix of ce->name, then it is the
-		 * other way around which also is bad.
-		 */
-		entlen = ce_namelen(ce);
-		if (namelen == entlen)
-			continue;
-		if (namelen < entlen) {
-			len = namelen;
-			one = path;
-			two = ce->name;
-		} else {
-			len = entlen;
-			one = ce->name;
-			two = path;
-		}
-		if (memcmp(one, two, len))
-			continue;
-		if (two[len] == '/')
-			return 1;
-	}
-	return 0;
+static int keep_entry(struct cache_entry *ce)
+{
+	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD);
+	return 1;
 }
 
-static int threeway_merge(struct cache_entry *stages[4],
-			  struct cache_entry **dst,
-			  struct cache_entry **next, int tail)
-{
-	struct cache_entry *old = stages[0];
-	struct cache_entry *a = stages[1], *b = stages[2], *c = stages[3];
-	struct cache_entry *merge;
+static int threeway_merge(struct cache_entry **stages)
+{
+	struct cache_entry *index;
+	struct cache_entry *head; 
+	struct cache_entry *remote = stages[head_idx + 1];
 	int count;
+	int head_match = 0;
+	int remote_match = 0;
 
-	/* #5ALT */
-	if (!a && b && c && same(b, c)) {
-		if (old && !same(b, old))
-			return -1;
-		return merged_entry_allow_dirty(b, old, dst);
+	int df_conflict_head = 0;
+	int df_conflict_remote = 0;
+
+	int any_anc_missing = 0;
+	int i;
+
+	for (i = 1; i < head_idx; i++) {
+		if (!stages[i])
+			any_anc_missing = 1;
 	}
-	/* #2ALT and #3ALT */
-	if (!a && (!!b != !!c)) {
-		/*
-		 * The reason we need to worry about directory/file
-		 * conflicts only in #2ALT and #3ALT case is this:
-		 *
-		 * (1) For all other cases that read-tree internally
-		 *     resolves a path, we always have such a path in
-		 *     *both* stage2 and stage3 when we begin.
-		 *     Traditionally, the behaviour has been even
-		 *     stricter and we did not resolve a path without
-		 *     initially being in all of stage1, 2, and 3.
-		 *
-		 * (2) When read-tree finishes, all resolved paths (i.e.
-		 *     the paths that are in stage0) must have come from
-		 *     either stage2 or stage3.  It is not possible to
-		 *     have a stage0 path as a result of a merge if
-		 *     neither stage2 nor stage3 had that path.
-		 *
-		 * (3) It is guaranteed that just after reading the
-		 *     stages, each stage cannot have directory/file
-		 *     conflicts on its own, because they are populated
-		 *     by reading hierarchy of a tree.  Combined with
-		 *     (1) and (2) above, this means that no matter what
-		 *     combination of paths we take from stage2 and
-		 *     stage3 as a result of a merge, they cannot cause
-		 *     a directory/file conflict situation (otherwise
-		 *     the "guilty" path would have already had such a
-		 *     conflict in the original stage, either stage2
-		 *     or stage3).  Although its stage2 is synthesized
-		 *     by overlaying the current index on top of "our
-		 *     head" tree, --emu23 case also has this guarantee,
-		 *     by calling add_cache_entry() to create such stage2
-		 *     entries.
-		 *
-		 * (4) Only #2ALT and #3ALT lack the guarantee (1).
-		 *     They resolve paths that exist only in stage2
-		 *     or stage3.  The stage2 tree may have a file DF
-		 *     while stage3 tree may have a file DF/DF.  If
-		 *     #2ALT and #3ALT rules happen to apply to both
-		 *     of them, we would end up having DF (coming from
-		 *     stage2) and DF/DF (from stage3) in the result.
-		 *     When we attempt to resolve a path that exists
-		 *     only in stage2, we need to make sure there is
-		 *     no path that would conflict with it in stage3
-		 *     and vice versa.
-		 */
-		if (c) { /* #2ALT */
-			if (!causes_df_conflict(c, 2, dst, next, tail) &&
-			    (!old || same(c, old)))
-				return merged_entry_allow_dirty(c, old, dst);
-		}
-		else { /* #3ALT */
-			if (!causes_df_conflict(b, 3, dst, next, tail) &&
-			    (!old || same(b, old)))
-				return merged_entry_allow_dirty(b, old, dst);
-		}
-		/* otherwise we will apply the original rule */
-	}
-	/* #14ALT */
-	if (a && b && c && same(a, b) && !same(a, c)) {
-		if (old && same(old, c))
-			return merged_entry_allow_dirty(c, old, dst);
-		/* otherwise the regular rule applies */
+
+	index = stages[0];
+	head = stages[head_idx];
+
+	if (head == &df_conflict_entry) {
+		df_conflict_head = 1;
+		head = NULL;
+	}
+
+	if (remote == &df_conflict_entry) {
+		df_conflict_remote = 1;
+		remote = NULL;
+	}
+
+	/* First, if there's a #16 situation, note that to prevent #13
+	 * and #14. 
+	 */
+	if (!same(remote, head)) {
+		for (i = 1; i < head_idx; i++) {
+			if (same(stages[i], head)) {
+				head_match = 1;
+			}
+			if (same(stages[i], remote)) {
+				remote_match = 1;
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
+		return merged_entry(remote, index);
 	}
 	/*
-	 * If we have an entry in the index cache ("old"), then we want
-	 * to make sure that it matches any entries in stage 2 ("first
-	 * branch", aka "b").
+	 * If we have an entry in the index cache, then we want to
+	 * make sure that it matches head.
 	 */
-	if (old) {
-		if (!b || !same(old, b))
-			return -1;
+	if (index && !same(index, head)) {
+		reject_merge(index);
 	}
-	merge = merge_entries(a, b, c);
-	if (merge)
-		return merged_entry(merge, old, dst);
-	if (old)
-		verify_uptodate(old);
+
+	if (head) {
+		/* #5ALT, #15 */
+		if (same(head, remote))
+			return merged_entry(head, index);
+		/* #13, #3ALT */
+		if (!df_conflict_remote && remote_match && !head_match)
+			return merged_entry(head, index);
+	}
+
+	/* #1 */
+	if (!head && !remote && any_anc_missing)
+		return 0;
+
+	/* Below are "no merge" cases, which require that the index be
+	 * up-to-date to avoid the files getting overwritten with
+	 * conflict resolution files. 
+	 */
+	if (index) {
+		verify_uptodate(index);
+	}
+
+	/* #2, #3, #4, #6, #7, #9, #11. */
 	count = 0;
-	if (a) { *dst++ = a; count++; }
-	if (b) { *dst++ = b; count++; }
-	if (c) { *dst++ = c; count++; }
+	if (!head_match || !remote_match) {
+		for (i = 1; i < head_idx; i++) {
+			if (stages[i]) {
+				keep_entry(stages[i]);
+				count++;
+				break;
+			}
+		}
+	}
+	if (head) { count += keep_entry(head); }
+	if (remote) { count += keep_entry(remote); }
 	return count;
 }
 
@@ -316,14 +457,14 @@ static int threeway_merge(struct cache_e
  * "carry forward" rule, please see <Documentation/git-read-tree.txt>.
  *
  */
-static int twoway_merge(struct cache_entry **src, struct cache_entry **dst,
-			struct cache_entry **next, int tail)
+static int twoway_merge(struct cache_entry **src)
 {
 	struct cache_entry *current = src[0];
 	struct cache_entry *oldtree = src[1], *newtree = src[2];
 
-	if (src[3])
-		return -1;
+	if (merge_size != 2)
+		return error("Cannot do a twoway merge of %d trees\n",
+			     merge_size);
 
 	if (current) {
 		if ((!oldtree && !newtree) || /* 4 and 5 */
@@ -334,78 +475,32 @@ static int twoway_merge(struct cache_ent
 		    (oldtree && newtree &&
 		     !same(oldtree, newtree) && /* 18 and 19*/
 		     same(current, newtree))) {
-			*dst++ = current;
-			return 1;
+			return keep_entry(current);
 		}
 		else if (oldtree && !newtree && same(current, oldtree)) {
 			/* 10 or 11 */
-			return deleted_entry(oldtree, current, dst);
+			return deleted_entry(oldtree, current);
 		}
 		else if (oldtree && newtree &&
 			 same(current, oldtree) && !same(current, newtree)) {
 			/* 20 or 21 */
-			return merged_entry(newtree, current, dst);
+			return merged_entry(newtree, current);
 		}
-		else
+		else {
 			/* all other failures */
+			if (oldtree)
+				reject_merge(oldtree);
+			if (current)
+				reject_merge(current);
+			if (newtree)
+				reject_merge(newtree);
 			return -1;
+		}
 	}
 	else if (newtree)
-		return merged_entry(newtree, current, dst);
+		return merged_entry(newtree, current);
 	else
-		return deleted_entry(oldtree, current, dst);
-}
-
-/*
- * Two-way merge emulated with three-way merge.
- *
- * This treats "read-tree -m H M" by transforming it internally
- * into "read-tree -m H I+H M", where I+H is a tree that would
- * contain the contents of the current index file, overlayed on
- * top of H.  Unlike the traditional two-way merge, this leaves
- * the stages in the resulting index file and lets the user resolve
- * the merge conflicts using standard tools for three-way merge.
- *
- * This function is just to set-up such an arrangement, and the
- * actual merge uses threeway_merge() function.
- */
-static void setup_emu23(void)
-{
-	/* stage0 contains I, stage1 H, stage2 M.
-	 * move stage2 to stage3, and create stage2 entries
-	 * by scanning stage0 and stage1 entries.
-	 */
-	int i, namelen, size;
-	struct cache_entry *ce, *stage2;
-
-	for (i = 0; i < active_nr; i++) {
-		ce = active_cache[i];
-		if (ce_stage(ce) != 2)
-			continue;
-		/* hoist them up to stage 3 */
-		namelen = ce_namelen(ce);
-		ce->ce_flags = create_ce_flags(namelen, 3);
-	}
-
-	for (i = 0; i < active_nr; i++) {
-		ce = active_cache[i];
-		if (ce_stage(ce) > 1)
-			continue;
-		namelen = ce_namelen(ce);
-		size = cache_entry_size(namelen);
-		stage2 = xmalloc(size);
-		memcpy(stage2, ce, size);
-		stage2->ce_flags = create_ce_flags(namelen, 2);
-		if (add_cache_entry(stage2, ADD_CACHE_OK_TO_ADD) < 0)
-			die("cannot merge index and our head tree");
-
-		/* We are done with this name, so skip to next name */
-		while (i < active_nr &&
-		       ce_namelen(active_cache[i]) == namelen &&
-		       !memcmp(active_cache[i]->name, ce->name, namelen))
-			i++;
-		i--; /* compensate for the loop control */
-	}
+		return deleted_entry(oldtree, current);
 }
 
 /*
@@ -414,78 +509,21 @@ static void setup_emu23(void)
  * The rule is:
  * - take the stat information from stage0, take the data from stage1
  */
-static int oneway_merge(struct cache_entry **src, struct cache_entry **dst,
-			struct cache_entry **next, int tail)
+static int oneway_merge(struct cache_entry **src)
 {
 	struct cache_entry *old = src[0];
 	struct cache_entry *a = src[1];
 
-	if (src[2] || src[3])
-		return -1;
+	if (merge_size != 1)
+		return error("Cannot do a oneway merge of %d trees\n",
+			     merge_size);
 
 	if (!a)
 		return 0;
 	if (old && same(old, a)) {
-		*dst++ = old;
-		return 1;
-	}
-	return merged_entry(a, NULL, dst);
-}
-
-static void check_updates(struct cache_entry **src, int nr)
-{
-	static struct checkout state = {
-		.base_dir = "",
-		.force = 1,
-		.quiet = 1,
-		.refresh_cache = 1,
-	};
-	unsigned short mask = htons(CE_UPDATE);
-	while (nr--) {
-		struct cache_entry *ce = *src++;
-		if (!ce->ce_mode) {
-			if (update)
-				unlink(ce->name);
-			continue;
-		}
-		if (ce->ce_flags & mask) {
-			ce->ce_flags &= ~mask;
-			if (update)
-				checkout_entry(ce, &state);
-		}
-	}
-}
-
-typedef int (*merge_fn_t)(struct cache_entry **, struct cache_entry **, struct cache_entry **, int);
-
-static void merge_cache(struct cache_entry **src, int nr, merge_fn_t fn)
-{
-	struct cache_entry **dst = src;
-	int tail = nr;
-
-	while (nr) {
-		int entries;
-		struct cache_entry *name, *ce, *stages[4] = { NULL, };
-
-		name = ce = *src;
-		for (;;) {
-			int stage = ce_stage(ce);
-			stages[stage] = ce;
-			ce = *++src;
-			active_nr--;
-			if (!--nr)
-				break;
-			if (!path_matches(ce, name))
-				break;
-		}
-
-		entries = fn(stages, dst, src, tail);
-		if (entries < 0)
-			reject_merge(name);
-		dst += entries;
-		active_nr += entries;
+		return keep_entry(old);
 	}
-	check_updates(active_cache, active_nr);
+	return merged_entry(a, NULL);
 }
 
 static int read_cache_unmerged(void)
@@ -516,8 +554,9 @@ static struct cache_file cache_file;
 
 int main(int argc, char **argv)
 {
-	int i, newfd, merge, reset, emu23;
+	int i, newfd, reset, stage = 0;
 	unsigned char sha1[20];
+	merge_fn_t fn = NULL;
 
 	newfd = hold_index_file_for_update(&cache_file, get_index_file());
 	if (newfd < 0)
@@ -525,7 +564,6 @@ int main(int argc, char **argv)
 
 	merge = 0;
 	reset = 0;
-	emu23 = 0;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
@@ -537,7 +575,7 @@ int main(int argc, char **argv)
 
 		/* This differs from "-m" in that we'll silently ignore unmerged entries */
 		if (!strcmp(arg, "--reset")) {
-			if (stage || merge || emu23)
+			if (stage || merge)
 				usage(read_tree_usage);
 			reset = 1;
 			merge = 1;
@@ -546,9 +584,14 @@ int main(int argc, char **argv)
 			continue;
 		}
 
+		if (!strcmp(arg, "--head")) {
+			head_idx = stage - 1;
+			fn = threeway_merge;
+		}
+
 		/* "-m" stands for "merge", meaning we start in stage 1 */
 		if (!strcmp(arg, "-m")) {
-			if (stage || merge || emu23)
+			if (stage || merge)
 				usage(read_tree_usage);
 			if (read_cache_unmerged())
 				die("you need to resolve your current index first");
@@ -557,45 +600,41 @@ int main(int argc, char **argv)
 			continue;
 		}
 
-		/* "-emu23" uses 3-way merge logic to perform fast-forward */
-		if (!strcmp(arg, "--emu23")) {
-			if (stage || merge || emu23)
-				usage(read_tree_usage);
-			if (read_cache_unmerged())
-				die("you need to resolve your current index first");
-			merge = emu23 = stage = 1;
-			continue;
-		}
-
 		if (get_sha1(arg, sha1) < 0)
 			usage(read_tree_usage);
-		if (stage > 3)
-			usage(read_tree_usage);
-		if (unpack_tree(sha1) < 0)
+		if (list_tree(sha1) < 0)
 			die("failed to unpack tree object %s", arg);
 		stage++;
 	}
 	if (update && !merge)
 		usage(read_tree_usage);
-	if (merge) {
-		static const merge_fn_t merge_function[] = {
-			[1] = oneway_merge,
-			[2] = twoway_merge,
-			[3] = threeway_merge,
-		};
-		merge_fn_t fn;
-
-		if (stage < 2 || stage > 4)
+	if (merge && !fn) {
+		if (stage < 2)
 			die("just how do you expect me to merge %d trees?", stage-1);
-		if (emu23 && stage != 3)
-			die("--emu23 takes only two trees");
-		fn = merge_function[stage-1];
-		if (stage == 3 && emu23) { 
-			setup_emu23();
-			fn = merge_function[3];
+		switch (stage - 1) {
+		case 1:
+			fn = oneway_merge;
+			break;
+		case 2:
+			fn = twoway_merge;
+			break;
+		case 3:
+			fn = threeway_merge;
+			break;
+		default:
+			fn = threeway_merge;
+			break;
 		}
-		merge_cache(active_cache, active_nr, fn);
 	}
+
+	if (head_idx < 0) {
+		if (stage - 1 >= 3)
+			head_idx = stage - 2;
+		else
+			head_idx = 1;
+	}
+
+	unpack_trees(fn);
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_index_file(&cache_file))
 		die("unable to write new index file");
diff --git a/t/t1005-read-tree-m-2way-emu23.sh b/t/t1005-read-tree-m-2way-emu23.sh
deleted file mode 100755
--- a/t/t1005-read-tree-m-2way-emu23.sh
+++ /dev/null
@@ -1,422 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Junio C Hamano
-#
-
-test_description='Two way merge with read-tree --emu23 $H $M
-
-This test tries two-way merge (aka fast forward with carry forward).
-
-There is the head (called H) and another commit (called M), which is
-simply ahead of H.  The index and the work tree contains a state that
-is derived from H, but may also have local changes.  This test checks
-all the combinations described in the two-tree merge "carry forward"
-rules, found in <Documentation/git-rev-tree.txt>.
-
-In the test, these paths are used:
-        bozbar  - in H, stays in M, modified from bozbar to gnusto
-        frotz   - not in H added in M
-        nitfol  - in H, stays in M unmodified
-        rezrov  - in H, deleted in M
-        yomin   - not in H nor M
-'
-. ./test-lib.sh
-
-read_tree_twoway () {
-    git-read-tree --emu23 "$1" "$2" &&
-    git-ls-files --stage &&
-    git-merge-cache git-merge-one-file-script -a &&
-    git-ls-files --stage
-}
-
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
-compare_change () {
-	sed -n >current \
-	    -e '/^--- /d; /^+++ /d; /^@@ /d;' \
-	    -e 's/^\([-+][0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /p' \
-	    "$1"
-	diff -u expected current
-}
-
-check_cache_at () {
-	clean_if_empty=`git-diff-files "$1"`
-	case "$clean_if_empty" in
-	'')  echo "$1: clean" ;;
-	?*)  echo "$1: dirty" ;;
-	esac
-	case "$2,$clean_if_empty" in
-	clean,)		:     ;;
-	clean,?*)	false ;;
-	dirty,)		false ;;
-	dirty,?*)	:     ;;
-	esac
-}
-
-check_stages () {
-    cat >expected_stages
-    git-ls-files --stage | sed -e "s/ $_x40 / X /" >current_stages
-    diff -u expected_stages current_stages
-}
-
-cat >bozbar-old <<\EOF
-This is a sample file used in two-way fast forward merge
-tests.  Its second line ends with a magic word bozbar
-which will be modified by the merged head to gnusto.
-It has some extra lines so that external tools can
-successfully merge independent changes made to later
-lines (such as this one), avoiding line conflicts.
-EOF
-
-sed -e 's/bozbar/gnusto (earlier bozbar)/' bozbar-old >bozbar-new
-
-test_expect_success \
-    setup \
-    'echo frotz >frotz &&
-     echo nitfol >nitfol &&
-     cat bozbar-old >bozbar &&
-     echo rezrov >rezrov &&
-     echo yomin >yomin &&
-     git-update-cache --add nitfol bozbar rezrov &&
-     treeH=`git-write-tree` &&
-     echo treeH $treeH &&
-     git-ls-tree $treeH &&
-
-     cat bozbar-new >bozbar &&
-     git-update-cache --add frotz bozbar --force-remove rezrov &&
-     git-ls-files --stage >M.out &&
-     treeM=`git-write-tree` &&
-     echo treeM $treeM &&
-     git-ls-tree $treeM &&
-     git-diff-tree $treeH $treeM'
-
-# "read-tree -m H I+H M" but I is empty so this is "read-tree -m H H M".
-#
-# bozbar [O && A && B && O==A && O!=B (#14) ==> B] take M by read-tree
-# frotz  [!O && !A && B (#2) ==> B]                take M by read-tree
-# nitfol [O && A && B && O==A && O==B (#15) ==> B] take M by read-tree
-# rezrov [O && A && !B && O==A (#10) ==> no merge] removed by script
-#
-# Earlier one did not have #2ALT so taking M was done by the script,
-# which also updated the work tree and making frotz clean.  With #2ALT,
-# this is resolved by read-tree itself and the path is left dirty
-# because we are not testing "read-tree -u --emu23".
-test_expect_success \
-    '1, 2, 3 - no carry forward' \
-    'rm -f .git/index &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >1-3.out &&
-     diff -u M.out 1-3.out &&
-     check_cache_at bozbar dirty &&
-     check_cache_at frotz dirty && # same as pure 2-way again.
-     check_cache_at nitfol dirty'
-
-echo '+100644 X 0	yomin' >expected
-
-test_expect_success \
-    '4 - carry forward local addition.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     git-update-cache --add yomin &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >4.out || return 1
-     diff -u M.out 4.out >4diff.out
-     compare_change 4diff.out expected &&
-     check_cache_at yomin clean'
-
-# "read-tree -m H I+H M" where !H && !M; so (I+H) not being up-to-date
-# should not matter.  Thanks to #3ALT, this is now possible.
-test_expect_success \
-    '5 - carry forward local addition.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo yomin >yomin &&
-     git-update-cache --add yomin &&
-     echo yomin yomin >yomin &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >5.out || return 1
-     diff -u M.out 5.out >5diff.out
-     compare_change 5diff.out expected &&
-     check_cache_at yomin dirty'
-
-# "read-tree -m H I+H M" where !H && M && (I+H) == M, so this should
-# succeed (even the entry is clean), now thanks to #5ALT.
-test_expect_success \
-    '6 - local addition already has the same.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     git-update-cache --add frotz &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >6.out &&
-     diff -u M.out 6.out &&
-     check_cache_at frotz clean'
-
-# Exactly the same pattern as above but with dirty cache.  This also
-# should succeed, now thanks to #5ALT.
-test_expect_success \
-    '7 - local addition already has the same.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo frotz >frotz &&
-     git-update-cache --add frotz &&
-     echo frotz frotz >frotz &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >7.out &&
-     diff -u M.out 7.out &&
-     check_cache_at frotz dirty'
-
-test_expect_success \
-    '8 - conflicting addition.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo frotz frotz >frotz &&
-     git-update-cache --add frotz &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '9 - conflicting addition.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo frotz frotz >frotz &&
-     git-update-cache --add frotz &&
-     echo frotz >frotz &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '10 - path removed.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo rezrov >rezrov &&
-     git-update-cache --add rezrov &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >10.out &&
-     diff -u M.out 10.out'
-
-test_expect_success \
-    '11 - dirty path removed.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo rezrov >rezrov &&
-     git-update-cache --add rezrov &&
-     echo rezrov rezrov >rezrov &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '12 - unmatching local changes being removed.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo rezrov rezrov >rezrov &&
-     git-update-cache --add rezrov &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '13 - unmatching local changes being removed.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo rezrov rezrov >rezrov &&
-     git-update-cache --add rezrov &&
-     echo rezrov >rezrov &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-cat >expected <<EOF
--100644 X 0	nitfol
-+100644 X 0	nitfol
-EOF
-
-test_expect_success \
-    '14 - unchanged in two heads.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo nitfol nitfol >nitfol &&
-     git-update-cache --add nitfol &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >14.out || return 1
-     diff -u M.out 14.out >14diff.out
-     compare_change 14diff.out expected &&
-     check_cache_at nitfol clean'
-
-test_expect_success \
-    '15 - unchanged in two heads.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo nitfol nitfol >nitfol &&
-     git-update-cache --add nitfol &&
-     echo nitfol nitfol nitfol >nitfol &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >15.out || return 1
-     diff -u M.out 15.out >15diff.out
-     compare_change 15diff.out expected &&
-     check_cache_at nitfol dirty'
-
-# This is different from straight 2-way merge in that it leaves
-# three stages of bozbar in the index file without failing, so
-# the user can run git-diff-stages to examine the situation.
-# With #2ALT, frotz is resolved internally.
-test_expect_success \
-    '16 - conflicting local change.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo bozbar bozbar >bozbar &&
-     git-update-cache --add bozbar &&
-     git-read-tree --emu23 $treeH $treeM &&
-     check_stages' <<\EOF
-100644 X 1	bozbar
-100644 X 2	bozbar
-100644 X 3	bozbar
-100644 X 0	frotz
-100644 X 0	nitfol
-100644 X 1	rezrov
-100644 X 2	rezrov
-EOF
-
-test_expect_success \
-    '17 - conflicting local change.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     echo bozbar bozbar >bozbar &&
-     git-update-cache --add bozbar &&
-     echo bozbar bozbar bozbar >bozbar &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-test_expect_success \
-    '18 - local change already having a good result.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     cat bozbar-new >bozbar &&
-     git-update-cache --add bozbar &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >18.out &&
-     diff -u M.out 18.out &&
-     check_cache_at bozbar clean'
-
-test_expect_success \
-    '19 - local change already having a good result, further modified.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     cat bozbar-new >bozbar &&
-     git-update-cache --add bozbar &&
-     echo gnusto gnusto >bozbar &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >19.out &&
-     diff -u M.out 19.out &&
-     check_cache_at bozbar dirty'
-
-test_expect_success \
-    '20 - no local change, use new tree.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     cat bozbar-old >bozbar &&
-     git-update-cache --add bozbar &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >20.out &&
-     diff -u M.out 20.out &&
-     check_cache_at bozbar dirty'
-
-test_expect_success \
-    '21 - no local change, dirty cache.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     cat bozbar-old >bozbar &&
-     git-update-cache --add bozbar &&
-     echo gnusto gnusto >bozbar &&
-     if read_tree_twoway $treeH $treeM; then false; else :; fi'
-
-echo '-100644 X 0	bozbar
-+100644 X 0	bozbar' >expected
-
-# This fails with straight two-way fast forward, but emu23
-# can merge them.
-test_expect_success \
-    '22 - local change cache updated.' \
-    'rm -f .git/index &&
-     git-read-tree $treeH &&
-     git-checkout-cache -u -f -q -a &&
-     sed -e "s/such as/SUCH AS/" bozbar-old >bozbar &&
-     git-update-cache --add bozbar &&
-     read_tree_twoway $treeH $treeM &&
-     git-ls-files --stage >22.out || return 1
-     diff -u M.out 22.out >22diff.out
-     compare_change 22diff.out &&
-     check_cache_at bozbar clean'
-
-# Also make sure we did not break DF vs DF/DF case.
-test_expect_success \
-    'DF vs DF/DF case setup.' \
-    'rm -f .git/index &&
-     echo DF >DF &&
-     git-update-cache --add DF &&
-     treeDF=`git-write-tree` &&
-     echo treeDF $treeDF &&
-     git-ls-tree $treeDF &&
-     git-ls-files --stage >DF.out
-
-     rm -f DF &&
-     mkdir DF &&
-     echo DF/DF >DF/DF &&
-     git-update-cache --add --remove DF DF/DF &&
-     treeDFDF=`git-write-tree` &&
-     echo treeDFDF $treeDFDF &&
-     git-ls-tree $treeDFDF &&
-     git-ls-files --stage >DFDF.out'
-
-test_expect_success \
-    'DF vs DF/DF case test (#1)' \
-    'rm -f .git/index &&
-     rm -fr DF &&
-     echo DF >DF &&
-     git-update-cache --add DF &&
-     read_tree_twoway $treeDF $treeDFDF &&
-     git-ls-files --stage >DFDFcheck.out &&
-     diff -u DFDF.out DFDFcheck.out &&
-     check_cache_at DF/DF clean && # different from pure 2-way
-     :'
-
-# The other way around
-test_expect_success \
-    'DF vs DF/DF case test (#2)' \
-    'rm -f .git/index &&
-     rm -fr DF &&
-     mkdir DF &&
-     echo DF/DF >DF/DF &&
-     git-update-cache --add DF/DF &&
-     read_tree_twoway $treeDFDF $treeDF &&
-     git-ls-files --stage >DFDFcheck.out &&
-     diff -u DF.out DFDFcheck.out &&
-     check_cache_at DF clean && # different from pure 2-way
-     :'
-
-# Emu23 can grok I having more than H.  Make sure we did not
-# botch the conflict tests (fixed).
-test_expect_success \
-    'DF vs DF/DF case test (#3).' \
-    'rm -f .git/index &&
-     rm -fr DF &&
-     mkdir DF &&
-     echo DF/DF >DF/DF &&
-     git-update-cache --add DF/DF &&
-     # This should fail because I and H have a conflict
-     # at DF.
-     if git-read-tree --emu23 $treeDF $treeDFDF
-     then false
-     else true
-     fi'
-
-test_done
