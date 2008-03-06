From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/5] Move 'unpack_trees()' over to 'traverse_trees()' interface
Date: Wed, 5 Mar 2008 20:15:44 -0800
Message-ID: <fd4ed67d3e652e328ed066bbab72e49c362ae2ec.1204777699.git.torvalds@linux-foundation.org>
References: <cover.1204777699.git.torvalds@linux-foundation.org>
To: undisclosed-recipients:;
X-From: git-owner@vger.kernel.org Thu Mar 06 05:38:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX7rs-0003zU-BY
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 05:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756853AbYCFEh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 23:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756849AbYCFEh1
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 23:37:27 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59242 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756801AbYCFEhZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 23:37:25 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264baV8006358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Mar 2008 20:37:38 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m264bHAg008948;
	Wed, 5 Mar 2008 20:37:17 -0800
In-Reply-To: <cover.1204777699.git.torvalds@linux-foundation.org>
X-Spam-Status: No, hits=-3.911 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76325>

This not only deletes more code than it adds, it gets rid of a
singularly hard-to-understand function (unpack_trees_rec()), and
replaces it with a set of smaller and simpler functions that use the
generic tree traversal mechanism to walk over one or more git trees in
parallel.

It's still not the most wonderful interface, and by no means is the new
code easy to understand either, but it's at least a bit less opaque.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 unpack-trees.c |  530 ++++++++++++++++++++++++++------------------------------
 1 files changed, 249 insertions(+), 281 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3e448d8..ee9be29 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -7,270 +7,12 @@
 #include "progress.h"
 #include "refs.h"
 
-#define DBRT_DEBUG 1
-
-struct tree_entry_list {
-	struct tree_entry_list *next;
-	unsigned int mode;
-	const char *name;
-	const unsigned char *sha1;
-};
-
-static struct tree_entry_list *create_tree_entry_list(struct tree_desc *desc)
-{
-	struct name_entry one;
-	struct tree_entry_list *ret = NULL;
-	struct tree_entry_list **list_p = &ret;
-
-	while (tree_entry(desc, &one)) {
-		struct tree_entry_list *entry;
-
-		entry = xmalloc(sizeof(struct tree_entry_list));
-		entry->name = one.path;
-		entry->sha1 = one.sha1;
-		entry->mode = one.mode;
-		entry->next = NULL;
-
-		*list_p = entry;
-		list_p = &entry->next;
-	}
-	return ret;
-}
-
-static int entcmp(const char *name1, int dir1, const char *name2, int dir2)
-{
-	int len1 = strlen(name1);
-	int len2 = strlen(name2);
-	int len = len1 < len2 ? len1 : len2;
-	int ret = memcmp(name1, name2, len);
-	unsigned char c1, c2;
-	if (ret)
-		return ret;
-	c1 = name1[len];
-	c2 = name2[len];
-	if (!c1 && dir1)
-		c1 = '/';
-	if (!c2 && dir2)
-		c2 = '/';
-	ret = (c1 < c2) ? -1 : (c1 > c2) ? 1 : 0;
-	if (c1 && c2 && !ret)
-		ret = len1 - len2;
-	return ret;
-}
-
 static inline void remove_entry(int remove)
 {
 	if (remove >= 0)
 		remove_cache_entry_at(remove);
 }
 
-static int unpack_trees_rec(struct tree_entry_list **posns, int len,
-			    const char *base, struct unpack_trees_options *o,
-			    struct tree_entry_list *df_conflict_list)
-{
-	int remove;
-	int baselen = strlen(base);
-	int src_size = len + 1;
-	int retval = 0;
-
-	do {
-		int i;
-		const char *first;
-		int firstdir = 0;
-		int pathlen;
-		unsigned ce_size;
-		struct tree_entry_list **subposns;
-		struct cache_entry **src;
-		int any_files = 0;
-		int any_dirs = 0;
-		char *cache_name;
-		int ce_stage;
-		int skip_entry = 0;
-
-		/* Find the first name in the input. */
-
-		first = NULL;
-		cache_name = NULL;
-
-		/* Check the cache */
-		if (o->merge && o->pos < active_nr) {
-			/* This is a bit tricky: */
-			/* If the index has a subdirectory (with
-			 * contents) as the first name, it'll get a
-			 * filename like "foo/bar". But that's after
-			 * "foo", so the entry in trees will get
-			 * handled first, at which point we'll go into
-			 * "foo", and deal with "bar" from the index,
-			 * because the base will be "foo/". The only
-			 * way we can actually have "foo/bar" first of
-			 * all the things is if the trees don't
-			 * contain "foo" at all, in which case we'll
-			 * handle "foo/bar" without going into the
-			 * directory, but that's fine (and will return
-			 * an error anyway, with the added unknown
-			 * file case.
-			 */
-
-			cache_name = active_cache[o->pos]->name;
-			if (strlen(cache_name) > baselen &&
-			    !memcmp(cache_name, base, baselen)) {
-				cache_name += baselen;
-				first = cache_name;
-			} else {
-				cache_name = NULL;
-			}
-		}
-
-#if DBRT_DEBUG > 1
-		if (first)
-			fprintf(stderr, "index %s\n", first);
-#endif
-		for (i = 0; i < len; i++) {
-			if (!posns[i] || posns[i] == df_conflict_list)
-				continue;
-#if DBRT_DEBUG > 1
-			fprintf(stderr, "%d %s\n", i + 1, posns[i]->name);
-#endif
-			if (!first || entcmp(first, firstdir,
-					     posns[i]->name,
-					     S_ISDIR(posns[i]->mode)) > 0) {
-				first = posns[i]->name;
-				firstdir = S_ISDIR(posns[i]->mode);
-			}
-		}
-		/* No name means we're done */
-		if (!first)
-			goto leave_directory;
-
-		pathlen = strlen(first);
-		ce_size = cache_entry_size(baselen + pathlen);
-
-		src = xcalloc(src_size, sizeof(struct cache_entry *));
-
-		subposns = xcalloc(len, sizeof(struct tree_list_entry *));
-
-		remove = -1;
-		if (cache_name && !strcmp(cache_name, first)) {
-			any_files = 1;
-			src[0] = active_cache[o->pos];
-			remove = o->pos;
-			if (o->skip_unmerged && ce_stage(src[0]))
-				skip_entry = 1;
-		}
-
-		for (i = 0; i < len; i++) {
-			struct cache_entry *ce;
-
-			if (!posns[i] ||
-			    (posns[i] != df_conflict_list &&
-			     strcmp(first, posns[i]->name))) {
-				continue;
-			}
-
-			if (posns[i] == df_conflict_list) {
-				src[i + o->merge] = o->df_conflict_entry;
-				continue;
-			}
-
-			if (S_ISDIR(posns[i]->mode)) {
-				struct tree *tree = lookup_tree(posns[i]->sha1);
-				struct tree_desc t;
-				any_dirs = 1;
-				parse_tree(tree);
-				init_tree_desc(&t, tree->buffer, tree->size);
-				subposns[i] = create_tree_entry_list(&t);
-				posns[i] = posns[i]->next;
-				src[i + o->merge] = o->df_conflict_entry;
-				continue;
-			}
-
-			if (skip_entry) {
-				subposns[i] = df_conflict_list;
-				posns[i] = posns[i]->next;
-				continue;
-			}
-
-			if (!o->merge)
-				ce_stage = 0;
-			else if (i + 1 < o->head_idx)
-				ce_stage = 1;
-			else if (i + 1 > o->head_idx)
-				ce_stage = 3;
-			else
-				ce_stage = 2;
-
-			ce = xcalloc(1, ce_size);
-			ce->ce_mode = create_ce_mode(posns[i]->mode);
-			ce->ce_flags = create_ce_flags(baselen + pathlen,
-						       ce_stage);
-			memcpy(ce->name, base, baselen);
-			memcpy(ce->name + baselen, first, pathlen + 1);
-
-			any_files = 1;
-
-			hashcpy(ce->sha1, posns[i]->sha1);
-			src[i + o->merge] = ce;
-			subposns[i] = df_conflict_list;
-			posns[i] = posns[i]->next;
-		}
-		if (any_files) {
-			if (skip_entry) {
-				o->pos++;
-				while (o->pos < active_nr &&
-				       !strcmp(active_cache[o->pos]->name,
-					       src[0]->name))
-					o->pos++;
-			} else if (o->merge) {
-				int ret;
-
-#if DBRT_DEBUG > 1
-				fprintf(stderr, "%s:\n", first);
-				for (i = 0; i < src_size; i++) {
-					fprintf(stderr, " %d ", i);
-					if (src[i])
-						fprintf(stderr, "%06x %s\n", src[i]->ce_mode, sha1_to_hex(src[i]->sha1));
-					else
-						fprintf(stderr, "\n");
-				}
-#endif
-				ret = o->fn(src, o, remove);
-				if (ret < 0)
-					return ret;
-
-#if DBRT_DEBUG > 1
-				fprintf(stderr, "Added %d entries\n", ret);
-#endif
-				o->pos += ret;
-			} else {
-				remove_entry(remove);
-				for (i = 0; i < src_size; i++) {
-					if (src[i]) {
-						add_cache_entry(src[i], ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
-					}
-				}
-			}
-		}
-		if (any_dirs) {
-			char *newbase = xmalloc(baselen + 2 + pathlen);
-			memcpy(newbase, base, baselen);
-			memcpy(newbase + baselen, first, pathlen);
-			newbase[baselen + pathlen] = '/';
-			newbase[baselen + pathlen + 1] = '\0';
-			if (unpack_trees_rec(subposns, len, newbase, o,
-					     df_conflict_list)) {
-				retval = -1;
-				goto leave_directory;
-			}
-			free(newbase);
-		}
-		free(subposns);
-		free(src);
-	} while (1);
-
- leave_directory:
-	return retval;
-}
-
 /* Unlink the last component and attempt to remove leading
  * directories, in case this unlink is the removal of the
  * last entry in the directory -- empty directories are removed.
@@ -346,15 +88,241 @@ static void check_updates(struct unpack_trees_options *o)
 	stop_progress(&progress);
 }
 
-int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
+static inline int call_unpack_fn(struct cache_entry **src, struct unpack_trees_options *o, int remove)
+{
+	int ret = o->fn(src, o, remove);
+	if (ret > 0) {
+		o->pos += ret;
+		ret = 0;
+	}
+	return ret;
+}
+
+static int unpack_index_entry(struct cache_entry *ce, struct unpack_trees_options *o)
+{
+	struct cache_entry *src[5] = { ce, };
+	if (ce_stage(ce)) {
+		if (o->skip_unmerged) {
+			o->pos++;
+		} else {
+			remove_entry(o->pos);
+		}
+		return 0;
+	}
+	return call_unpack_fn(src, o, o->pos);
+}
+
+int traverse_trees_recursive(int n, unsigned long dirmask, unsigned long df_conflicts, struct name_entry *names, struct traverse_info *info)
+{
+	int i;
+	struct tree_desc t[3];
+	struct traverse_info newinfo;
+	struct name_entry *p;
+
+	p = names;
+	while (!p->mode)
+		p++;
+
+	newinfo = *info;
+	newinfo.prev = info;
+	newinfo.name = *p;
+	newinfo.pathlen += tree_entry_len(p->path, p->sha1) + 1;
+	newinfo.conflicts |= df_conflicts;
+
+	for (i = 0; i < n; i++, dirmask >>= 1) {
+		const unsigned char *sha1 = NULL;
+		if (dirmask & 1)
+			sha1 = names[i].sha1;
+		fill_tree_descriptor(t+i, sha1);
+	}
+	traverse_trees(n, t, &newinfo);
+	return 0;
+}
+
+/*
+ * Compare the traverse-path to the cache entry without actually
+ * having to generate the textual representation of the traverse
+ * path.
+ *
+ * NOTE! This *only* compares up to the size of the traverse path
+ * itself - the caller needs to do the final check for the cache
+ * entry having more data at the end!
+ */
+static int do_compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
+{
+	int len, pathlen, ce_len;
+	const char *ce_name;
+
+	if (info->prev) {
+		int cmp = do_compare_entry(ce, info->prev, &info->name);
+		if (cmp)
+			return cmp;
+	}
+	pathlen = info->pathlen;
+	ce_len = ce_namelen(ce);
+
+	/* If ce_len < pathlen then we must have previously hit "name == directory" entry */
+	if (ce_len < pathlen)
+		return -1;
+
+	ce_len -= pathlen;
+	ce_name = ce->name + pathlen;
+
+	len = tree_entry_len(n->path, n->sha1);
+	return df_name_compare(ce_name, ce_len, S_IFREG, n->path, len, n->mode);
+}
+
+static int compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
+{
+	int cmp = do_compare_entry(ce, info, n);
+	if (cmp)
+		return cmp;
+
+	/*
+	 * Even if the beginning compared identically, the ce should
+	 * compare as bigger than a directory leading up to it!
+	 */
+	return ce_namelen(ce) > traverse_path_len(info, n);
+}
+
+static struct cache_entry *create_ce_entry(const struct traverse_info *info, const struct name_entry *n, int stage)
+{
+	int len = traverse_path_len(info, n);
+	struct cache_entry *ce = xcalloc(1, cache_entry_size(len));
+
+	ce->ce_mode = create_ce_mode(n->mode);
+	ce->ce_flags = create_ce_flags(len, stage);
+	hashcpy(ce->sha1, n->sha1);
+	make_traverse_path(ce->name, info, n);
+
+	return ce;
+}
+
+static int unpack_nondirectories(int n, unsigned long mask, unsigned long dirmask, struct cache_entry *src[5],
+	const struct name_entry *names, const struct traverse_info *info, int remove)
 {
-	struct tree_entry_list **posns;
 	int i;
-	struct tree_entry_list df_conflict_list;
+	struct unpack_trees_options *o = info->data;
+	unsigned long conflicts;
+
+	/* Do we have *only* directories? Nothing to do */
+	if (mask == dirmask && !src[0])
+		return 0;
+
+	conflicts = info->conflicts;
+	if (o->merge)
+		conflicts >>= 1;
+	conflicts |= dirmask;
+
+	/*
+	 * Ok, we've filled in up to any potential index entry in src[0],
+	 * now do the rest.
+	 */
+	for (i = 0; i < n; i++) {
+		int stage;
+		unsigned int bit = 1ul << i;
+		if (conflicts & bit) {
+			src[i + o->merge] = o->df_conflict_entry;
+			continue;
+		}
+		if (!(mask & bit))
+			continue;
+		if (!o->merge)
+			stage = 0;
+		else if (i + 1 < o->head_idx)
+			stage = 1;
+		else if (i + 1 > o->head_idx)
+			stage = 3;
+		else
+			stage = 2;
+		src[i + o->merge] = create_ce_entry(info, names + i, stage);
+	}
+
+	if (o->merge)
+		return call_unpack_fn(src, o, remove);
+
+	n += o->merge;
+	remove_entry(remove);
+	for (i = 0; i < n; i++)
+		add_cache_entry(src[i], ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
+	return 0;
+}
+
+static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
+{
+	struct cache_entry *src[5] = { NULL, };
+	struct unpack_trees_options *o = info->data;
+	int remove = -1;
+	const struct name_entry *p = names;
+
+	/* Find first entry with a real name (we could use "mask" too) */
+	while (!p->mode)
+		p++;
+
+	/* Are we supposed to look at the index too? */
+	if (o->merge) {
+		while (o->pos < active_nr) {
+			struct cache_entry *ce = active_cache[o->pos];
+			int cmp = compare_entry(ce, info, p);
+			if (cmp < 0) {
+				if (unpack_index_entry(ce, o) < 0)
+					return -1;
+				continue;
+			}
+			if (!cmp) {
+				if (ce_stage(ce)) {
+					/*
+					 * If we skip unmerged index entries, we'll skip this
+					 * entry *and* the tree entries associated with it!
+					 */
+					if (o->skip_unmerged)
+						return mask;
+					remove_entry(o->pos);
+					continue;
+				}
+				src[0] = ce;
+				remove = o->pos;
+			}
+			break;
+		}
+	}
+
+	if (unpack_nondirectories(n, mask, dirmask, src, names, info, remove) < 0)
+		return -1;
+
+	/* Now handle any directories.. */
+	if (dirmask) {
+		unsigned long conflicts = mask & ~dirmask;
+		if (o->merge) {
+			conflicts <<= 1;
+			if (src[0])
+				conflicts |= 1;
+		}
+		traverse_trees_recursive(n, dirmask, conflicts, names, info);
+		return mask;
+	}
+
+	return mask;
+}
+
+static int unpack_failed(struct unpack_trees_options *o, const char *message)
+{
+	if (!o->gently) {
+		if (message)
+			return error(message);
+		return -1;
+	}
+	discard_cache();
+	read_cache();
+	return -1;
+}
+
+int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
+{
 	static struct cache_entry *dfc;
 
-	memset(&df_conflict_list, 0, sizeof(df_conflict_list));
-	df_conflict_list.next = &df_conflict_list;
+	if (len > 4)
+		die("unpack_trees takes at most four trees");
 	memset(&state, 0, sizeof(state));
 	state.base_dir = "";
 	state.force = 1;
@@ -368,29 +336,29 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->df_conflict_entry = dfc;
 
 	if (len) {
-		posns = xmalloc(len * sizeof(struct tree_entry_list *));
-		for (i = 0; i < len; i++)
-			posns[i] = create_tree_entry_list(t+i);
-
-		if (unpack_trees_rec(posns, len, o->prefix ? o->prefix : "",
-				     o, &df_conflict_list)) {
-			if (o->gently) {
-				discard_cache();
-				read_cache();
-			}
-			return -1;
-		}
+		const char *prefix = o->prefix ? o->prefix : "";
+		struct traverse_info info;
+
+		setup_traverse_info(&info, prefix);
+		info.fn = unpack_callback;
+		info.data = o;
+
+		if (traverse_trees(len, t, &info) < 0)
+			return unpack_failed(o, NULL);
 	}
 
-	if (o->trivial_merges_only && o->nontrivial_merge) {
-		if (o->gently) {
-			discard_cache();
-			read_cache();
+	/* Any left-over entries in the index? */
+	if (o->merge) {
+		while (o->pos < active_nr) {
+			struct cache_entry *ce = active_cache[o->pos];
+			if (unpack_index_entry(ce, o) < 0)
+				return unpack_failed(o, NULL);
 		}
-		return o->gently ? -1 :
-			error("Merge requires file-level merging");
 	}
 
+	if (o->trivial_merges_only && o->nontrivial_merge)
+		return unpack_failed(o, "Merge requires file-level merging");
+
 	check_updates(o);
 	return 0;
 }
-- 
1.5.4.3.452.g67136

