From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/2 (resend)] Change read-tree to merge before using the
 index.
Date: Wed, 31 Aug 2005 12:57:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508311257040.23242@iabervon.org>
References: <Pine.LNX.4.63.0508302317380.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Aug 31 18:55:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAVqX-0000rL-E7
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 18:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbVHaQxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 12:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbVHaQxy
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 12:53:54 -0400
Received: from iabervon.org ([66.92.72.58]:44047 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964876AbVHaQxx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Aug 2005 12:53:53 -0400
Received: (qmail 6500 invoked by uid 1000); 31 Aug 2005 12:57:38 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Aug 2005 12:57:38 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0508302317380.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7979>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

---

 read-tree.c |  522 ++++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 297 insertions(+), 225 deletions(-)

d0f45ad81db2e133c49c23bd09c5615da344bb5c
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -5,28 +5,280 @@
  */
 #include "cache.h"
 
-static int stage = 0;
+#include "object.h"
+#include "tree.h"
+
+static int merge = 0;
+static int emu23 = 0;
 static int update = 0;
 
-static int unpack_tree(unsigned char *sha1)
+static struct object_list *trees = NULL;
+
+typedef int (*merge_fn_t)(struct cache_entry **src, 
+			  struct cache_entry **dest, 
+			  int df_conflicts_2,
+			  int df_conflicts_3);
+
+static int unpack_trees_rec(struct tree_entry_list **posns, int len,
+			    const char *base, merge_fn_t fn, 
+			    int file2, int file3, int *indpos)
+{
+	int baselen = strlen(base);
+	int src_size = len + 1;
+	if (emu23)
+		src_size++;
+	if (src_size > 4)
+		src_size = 4;
+	do {
+		int i;
+		char *first = NULL;
+		int pathlen;
+		unsigned ce_size;
+		int dir2 = 0;
+		int dir3 = 0;
+		int subfile2 = file2;
+		int subfile3 = file3;
+		struct tree_entry_list **subposns = NULL;
+		struct cache_entry **src = NULL;
+		char *cache_name = NULL;
+
+		/* Find the first name in the input. */
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
+		for (i = 0; i < len; i++) {
+			if (!posns[i])
+				continue;
+			if (!first || strcmp(first, posns[i]->name) > 0)
+				first = posns[i]->name;
+		}
+		/* No name means we're done */
+		if (!first)
+			return 0;
+
+		pathlen = strlen(first);
+		ce_size = cache_entry_size(baselen + pathlen);
+
+		if (cache_name && !strcmp(cache_name, first)) {
+			src = xmalloc(sizeof(struct cache_entry *) * 
+				      src_size);
+			memset(src, 0,
+			       sizeof(struct cache_entry *) * 
+			       src_size);
+			src[0] = active_cache[*indpos];
+			remove_cache_entry_at(*indpos);
+			if (emu23) {
+				// we need this in stage 2 as well as stage 0
+				struct cache_entry *copy =
+					xmalloc(ce_size);
+				memcpy(copy, src[0], ce_size);
+				copy->ce_flags = 
+					create_ce_flags(baselen + pathlen, 2);
+				if (dir2 || file2) {
+					die("cannot merge index and our head tree");
+				}
+				src[2] = copy;
+				subfile2 = 1;
+			}
+		}
+
+		for (i = 0; i < len; i++) {
+			struct cache_entry *ce;
+			int ce_stage;
+			if (!posns[i] ||
+			    strcmp(first, posns[i]->name)) {
+				continue;
+			}
+
+			if (len > 3) {
+				if (i - len + 3 >= 0)
+					ce_stage = i - len + 3 + merge;
+				else
+					ce_stage = merge;
+			} else {
+				ce_stage = i + merge;
+			}
+			if (emu23 && ce_stage == 2)
+				ce_stage = 3;
+
+			if (posns[i]->directory) {
+				if (!subposns) {
+					int posnlen = sizeof(struct tree_list_entry *) * len;
+					subposns = xmalloc(posnlen);
+					memset(subposns, 0, posnlen);
+				}
+				parse_tree(posns[i]->item.tree);
+				subposns[i] = posns[i]->item.tree->entries;
+				posns[i] = posns[i]->next;
+				if (emu23 && ce_stage == 1)
+					dir2 = 1;
+				if (ce_stage == 2)
+					dir2 = 1;
+				if (ce_stage == 3)
+					dir3 = 1;
+				continue;
+			}
+
+			if (ce_stage == 2)
+				subfile2 = 1;
+			if (ce_stage == 3)
+				subfile3 = 1;
+
+			ce = xmalloc(ce_size);
+			memset(ce, 0, ce_size);
+			ce->ce_mode = create_ce_mode(posns[i]->mode);
+			ce->ce_flags = create_ce_flags(baselen + pathlen,
+						       ce_stage);
+			memcpy(ce->name, base, baselen);
+			memcpy(ce->name + baselen, first, pathlen + 1);
+
+			if (!src) {
+				src = xmalloc(sizeof(struct cache_entry *) * 
+					      src_size);
+				memset(src, 0,
+				       sizeof(struct cache_entry *) * 
+				       src_size);
+			}
+
+			memcpy(ce->sha1, posns[i]->item.any->sha1, 20);
+			if (ce_stage == 1 && emu23 && !src[2]) {
+				// we need this in stage 2 as well as stage 1
+				struct cache_entry *copy =
+					xmalloc(ce_size);
+				memcpy(copy, ce, ce_size);
+				copy->ce_flags = 
+					create_ce_flags(baselen + pathlen, 2);
+				if (dir2 || file2) {
+					die("cannot merge index and our head tree");
+				}
+				src[2] = copy;
+				subfile2 = 1;
+			}
+			src[ce_stage] = ce;
+			posns[i] = posns[i]->next;
+		}
+		if (src) {
+			if (fn) {
+				int ret;
+				/*
+				printf("%s:\n", first);
+				for (i = 0; i < src_size; i++) {
+					printf(" %d ", i);
+					if (src[i])
+						printf("%s\n", sha1_to_hex(src[i]->sha1));
+					else
+						printf("\n");
+				}
+				*/
+				ret = fn(src, NULL,
+					 (file2 || dir2),
+					 (file3 || dir3));
+				/*printf("Added %d entries\n", ret);*/
+				*indpos += ret;
+			} else {
+				for (i = 0; i < src_size; i++) {
+					if (src[i]) {
+						add_cache_entry(src[i], ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
+					}
+				}
+			}
+		}
+		if (subposns) {
+			char *newbase = xmalloc(baselen + 2 + pathlen);
+			memcpy(newbase, base, baselen);
+			memcpy(newbase + baselen, first, pathlen);
+			newbase[baselen + pathlen] = '/';
+			newbase[baselen + pathlen + 1] = '\0';
+			if (unpack_trees_rec(subposns, len, newbase, fn,
+					     subfile2, subfile3, indpos))
+				return -1;
+		}
+	} while (1);
+}
+
+static void reject_merge(struct cache_entry *ce)
+{
+	die("Entry '%s' would be overwritten by merge. Cannot merge.", 
+	    ce->name);
+}
+
+static void check_updates(struct cache_entry **src, int nr)
 {
-	void *buffer;
-	unsigned long size;
-	int ret;
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
 
-	buffer = read_object_with_reference(sha1, "tree", &size, NULL);
-	if (!buffer)
+static int unpack_trees(merge_fn_t fn)
+{
+	int indpos = 0;
+	unsigned len = object_list_length(trees);
+	struct tree_entry_list **posns = 
+		xmalloc(len * sizeof(struct tree_entry_list *));
+	int i;
+	struct object_list *posn = trees;
+	for (i = 0; i < len; i++) {
+		posns[i] = ((struct tree *) posn->item)->entries;
+		posn = posn->next;
+	}
+	if (unpack_trees_rec(posns, len, "", fn, 0, 0, &indpos))
 		return -1;
-	ret = read_tree(buffer, size, stage, NULL);
-	free(buffer);
-	return ret;
+
+	check_updates(active_cache, active_nr);
+	return 0;
 }
 
-static int path_matches(struct cache_entry *a, struct cache_entry *b)
+static int list_tree(unsigned char *sha1)
 {
-	int len = ce_namelen(a);
-	return ce_namelen(b) == len &&
-		!memcmp(a->name, b->name, len);
+	struct tree *tree = parse_tree_indirect(sha1);
+	if (!tree)
+		return -1;
+	object_list_append(&tree->object, &trees);
+	return 0;
 }
 
 static int same(struct cache_entry *a, struct cache_entry *b)
@@ -91,17 +343,6 @@ static void verify_uptodate(struct cache
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
 static int merged_entry_internal(struct cache_entry *merge, struct cache_entry *old, struct cache_entry **dst, int allow_dirty)
 {
 	merge->ce_flags |= htons(CE_UPDATE);
@@ -120,7 +361,7 @@ static int merged_entry_internal(struct 
 		}
 	}
 	merge->ce_flags &= ~htons(CE_STAGEMASK);
-	*dst++ = merge;
+	add_cache_entry(merge, ADD_CACHE_OK_TO_ADD);
 	return 1;
 }
 
@@ -139,76 +380,19 @@ static int deleted_entry(struct cache_en
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
+static int keep_entry(struct cache_entry *ce, struct cache_entry **dst)
+{
+	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD);
+	return 1;
 }
 
 static int threeway_merge(struct cache_entry *stages[4],
 			  struct cache_entry **dst,
-			  struct cache_entry **next, int tail)
+			  int df_conflict_2, int df_conflict_3)
 {
 	struct cache_entry *old = stages[0];
 	struct cache_entry *a = stages[1], *b = stages[2], *c = stages[3];
@@ -218,7 +402,7 @@ static int threeway_merge(struct cache_e
 	/* #5ALT */
 	if (!a && b && c && same(b, c)) {
 		if (old && !same(b, old))
-			return -1;
+			reject_merge(old);
 		return merged_entry_allow_dirty(b, old, dst);
 	}
 	/* #2ALT and #3ALT */
@@ -269,12 +453,12 @@ static int threeway_merge(struct cache_e
 		 *     and vice versa.
 		 */
 		if (c) { /* #2ALT */
-			if (!causes_df_conflict(c, 2, dst, next, tail) &&
+			if (!df_conflict_2 &&
 			    (!old || same(c, old)))
 				return merged_entry_allow_dirty(c, old, dst);
 		}
 		else { /* #3ALT */
-			if (!causes_df_conflict(b, 3, dst, next, tail) &&
+			if (!df_conflict_3 &&
 			    (!old || same(b, old)))
 				return merged_entry_allow_dirty(b, old, dst);
 		}
@@ -293,7 +477,7 @@ static int threeway_merge(struct cache_e
 	 */
 	if (old) {
 		if (!b || !same(old, b))
-			return -1;
+			reject_merge(old);
 	}
 	merge = merge_entries(a, b, c);
 	if (merge)
@@ -301,9 +485,9 @@ static int threeway_merge(struct cache_e
 	if (old)
 		verify_uptodate(old);
 	count = 0;
-	if (a) { *dst++ = a; count++; }
-	if (b) { *dst++ = b; count++; }
-	if (c) { *dst++ = c; count++; }
+	if (a) { count += keep_entry(a, dst + count); }
+	if (b) { count += keep_entry(b, dst + count); }
+	if (c) { count += keep_entry(c, dst + count); }
 	return count;
 }
 
@@ -317,14 +501,11 @@ static int threeway_merge(struct cache_e
  *
  */
 static int twoway_merge(struct cache_entry **src, struct cache_entry **dst,
-			struct cache_entry **next, int tail)
+			int df23, int df32)
 {
 	struct cache_entry *current = src[0];
 	struct cache_entry *oldtree = src[1], *newtree = src[2];
 
-	if (src[3])
-		return -1;
-
 	if (current) {
 		if ((!oldtree && !newtree) || /* 4 and 5 */
 		    (!oldtree && newtree &&
@@ -334,8 +515,7 @@ static int twoway_merge(struct cache_ent
 		    (oldtree && newtree &&
 		     !same(oldtree, newtree) && /* 18 and 19*/
 		     same(current, newtree))) {
-			*dst++ = current;
-			return 1;
+			return keep_entry(current, dst);
 		}
 		else if (oldtree && !newtree && same(current, oldtree)) {
 			/* 10 or 11 */
@@ -346,9 +526,16 @@ static int twoway_merge(struct cache_ent
 			/* 20 or 21 */
 			return merged_entry(newtree, current, dst);
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
 		return merged_entry(newtree, current, dst);
@@ -357,137 +544,25 @@ static int twoway_merge(struct cache_ent
 }
 
 /*
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
-}
-
-/*
  * One-way merge.
  *
  * The rule is:
  * - take the stat information from stage0, take the data from stage1
  */
 static int oneway_merge(struct cache_entry **src, struct cache_entry **dst,
-			struct cache_entry **next, int tail)
+			int df23, int df32)
 {
 	struct cache_entry *old = src[0];
 	struct cache_entry *a = src[1];
 
-	if (src[2] || src[3])
-		return -1;
-
 	if (!a)
 		return 0;
 	if (old && same(old, a)) {
-		*dst++ = old;
-		return 1;
+		return keep_entry(old, dst);
 	}
 	return merged_entry(a, NULL, dst);
 }
 
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
-	}
-	check_updates(active_cache, active_nr);
-}
-
 static int read_cache_unmerged(void)
 {
 	int i, deleted;
@@ -516,8 +591,9 @@ static struct cache_file cache_file;
 
 int main(int argc, char **argv)
 {
-	int i, newfd, merge, reset, emu23;
+	int i, newfd, reset, stage = 0;
 	unsigned char sha1[20];
+	merge_fn_t fn = NULL;
 
 	newfd = hold_index_file_for_update(&cache_file, get_index_file());
 	if (newfd < 0)
@@ -569,9 +645,7 @@ int main(int argc, char **argv)
 
 		if (get_sha1(arg, sha1) < 0)
 			usage(read_tree_usage);
-		if (stage > 3)
-			usage(read_tree_usage);
-		if (unpack_tree(sha1) < 0)
+		if (list_tree(sha1) < 0)
 			die("failed to unpack tree object %s", arg);
 		stage++;
 	}
@@ -583,19 +657,17 @@ int main(int argc, char **argv)
 			[2] = twoway_merge,
 			[3] = threeway_merge,
 		};
-		merge_fn_t fn;
 
-		if (stage < 2 || stage > 4)
+		if (stage < 2)
 			die("just how do you expect me to merge %d trees?", stage-1);
 		if (emu23 && stage != 3)
 			die("--emu23 takes only two trees");
 		fn = merge_function[stage-1];
 		if (stage == 3 && emu23) { 
-			setup_emu23();
 			fn = merge_function[3];
 		}
-		merge_cache(active_cache, active_nr, fn);
 	}
+	unpack_trees(fn);
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_index_file(&cache_file))
 		die("unable to write new index file");
