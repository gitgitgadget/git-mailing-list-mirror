Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF7A1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 04:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbfGaEiS (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 00:38:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:56506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726439AbfGaEiS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 00:38:18 -0400
Received: (qmail 11361 invoked by uid 109); 31 Jul 2019 04:38:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 04:38:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13589 invoked by uid 111); 31 Jul 2019 04:40:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 00:40:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 00:38:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] tree-walk: drop oid from traverse_info
Message-ID: <20190731043815.GB27170@sigill.intra.peff.net>
References: <20190731043659.GA27028@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731043659.GA27028@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the previous commit shows, the presence of an oid in each level of
the traverse_info is confusing and ultimately not necessary. Let's drop
it to make it clear that it will not always be set (as well as convince
us that it's unused, and let the compiler catch any merges with other
branches that do add new uses).

Since the oid is part of name_entry, we'll actually stop embedding a
name_entry entirely, and instead just separately hold the pathname, its
length, and the mode.

This makes the resulting code slightly more verbose as we have to pass
those elements around individually. But it also makes it more clear what
each code path is going to use (and in most of the paths, we really only
care about the pathname itself).

A few of these conversions are noisier than they need to be, as they
also take the opportunity to rename "len" to "namelen" for clarity
(especially where we also have "pathlen" or "ce_len" alongside).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge-tree.c |  2 +-
 cache-tree.c         |  2 +-
 tree-walk.c          | 23 ++++++++++---------
 tree-walk.h          |  8 +++++--
 unpack-trees.c       | 53 ++++++++++++++++++++++++--------------------
 5 files changed, 49 insertions(+), 39 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index dccdaf7852..d8ace972c7 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -181,7 +181,7 @@ static struct merge_list *create_entry(unsigned stage, unsigned mode, const stru
 static char *traverse_path(const struct traverse_info *info, const struct name_entry *n)
 {
 	char *path = xmallocz(traverse_path_len(info, n));
-	return make_traverse_path(path, info, n);
+	return make_traverse_path(path, info, n->path, n->pathlen);
 }
 
 static void resolve(const struct traverse_info *info, struct name_entry *ours, struct name_entry *result)
diff --git a/cache-tree.c b/cache-tree.c
index 706ffcf188..c22161f987 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -713,7 +713,7 @@ static struct cache_tree *find_cache_tree_from_traversal(struct cache_tree *root
 	if (!info->prev)
 		return root;
 	our_parent = find_cache_tree_from_traversal(root, info->prev);
-	return cache_tree_find(our_parent, info->name.path);
+	return cache_tree_find(our_parent, info->name);
 }
 
 int cache_tree_matches_traversal(struct cache_tree *root,
diff --git a/tree-walk.c b/tree-walk.c
index 0de4d577bb..130d9f32f2 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -177,27 +177,27 @@ void setup_traverse_info(struct traverse_info *info, const char *base)
 	if (pathlen && base[pathlen-1] == '/')
 		pathlen--;
 	info->pathlen = pathlen ? pathlen + 1 : 0;
-	info->name.path = base;
-	info->name.pathlen = pathlen;
+	info->name = base;
+	info->namelen = pathlen;
 	if (pathlen)
 		info->prev = &dummy;
 }
 
-char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n)
+char *make_traverse_path(char *path, const struct traverse_info *info,
+			 const char *name, size_t namelen)
 {
-	int len = tree_entry_len(n);
 	int pathlen = info->pathlen;
 
-	path[pathlen + len] = 0;
+	path[pathlen + namelen] = 0;
 	for (;;) {
-		memcpy(path + pathlen, n->path, len);
+		memcpy(path + pathlen, name, namelen);
 		if (!pathlen)
 			break;
 		path[--pathlen] = '/';
-		n = &info->name;
-		len = tree_entry_len(n);
+		name = info->name;
+		namelen = info->namelen;
 		info = info->prev;
-		pathlen -= len;
+		pathlen -= namelen;
 	}
 	return path;
 }
@@ -399,12 +399,13 @@ int traverse_trees(struct index_state *istate,
 
 	if (info->prev) {
 		strbuf_grow(&base, info->pathlen);
-		make_traverse_path(base.buf, info->prev, &info->name);
+		make_traverse_path(base.buf, info->prev, info->name,
+				   info->namelen);
 		base.buf[info->pathlen-1] = '/';
 		strbuf_setlen(&base, info->pathlen);
 		traverse_path = xstrndup(base.buf, info->pathlen);
 	} else {
-		traverse_path = xstrndup(info->name.path, info->pathlen);
+		traverse_path = xstrndup(info->name, info->pathlen);
 	}
 	info->traverse_path = traverse_path;
 	for (;;) {
diff --git a/tree-walk.h b/tree-walk.h
index 2a5db29e8f..2c59caa38a 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -58,7 +58,10 @@ enum get_oid_result get_tree_entry_follow_symlinks(struct repository *r, struct
 struct traverse_info {
 	const char *traverse_path;
 	struct traverse_info *prev;
-	struct name_entry name;
+	const char *name;
+	size_t namelen;
+	unsigned mode;
+
 	int pathlen;
 	struct pathspec *pathspec;
 
@@ -69,7 +72,8 @@ struct traverse_info {
 };
 
 int get_tree_entry(struct repository *, const struct object_id *, const char *, struct object_id *, unsigned short *);
-char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n);
+char *make_traverse_path(char *path, const struct traverse_info *info,
+			 const char *name, size_t namelen);
 void setup_traverse_info(struct traverse_info *info, const char *base);
 
 static inline int traverse_path_len(const struct traverse_info *info, const struct name_entry *n)
diff --git a/unpack-trees.c b/unpack-trees.c
index 62276d4fef..63cbddead8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -632,7 +632,7 @@ static int unpack_index_entry(struct cache_entry *ce,
 	return ret;
 }
 
-static int find_cache_pos(struct traverse_info *, const struct name_entry *);
+static int find_cache_pos(struct traverse_info *, const char *p, size_t len);
 
 static void restore_cache_bottom(struct traverse_info *info, int bottom)
 {
@@ -651,7 +651,7 @@ static int switch_cache_bottom(struct traverse_info *info)
 	if (o->diff_index_cached)
 		return 0;
 	ret = o->cache_bottom;
-	pos = find_cache_pos(info->prev, &info->name);
+	pos = find_cache_pos(info->prev, info->name, info->namelen);
 
 	if (pos < -1)
 		o->cache_bottom = -2 - pos;
@@ -690,7 +690,7 @@ static int index_pos_by_traverse_info(struct name_entry *names,
 	char *name = xmalloc(len + 1 /* slash */ + 1 /* NUL */);
 	int pos;
 
-	make_traverse_path(name, info, names);
+	make_traverse_path(name, info, names->path, names->pathlen);
 	name[len++] = '/';
 	name[len] = '\0';
 	pos = index_name_pos(o->src_index, name, len);
@@ -811,7 +811,9 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	newinfo = *info;
 	newinfo.prev = info;
 	newinfo.pathspec = info->pathspec;
-	newinfo.name = *p;
+	newinfo.name = p->path;
+	newinfo.namelen = p->pathlen;
+	newinfo.mode = p->mode;
 	newinfo.pathlen += tree_entry_len(p) + 1;
 	newinfo.df_conflicts |= df_conflicts;
 
@@ -863,14 +865,18 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
  * itself - the caller needs to do the final check for the cache
  * entry having more data at the end!
  */
-static int do_compare_entry_piecewise(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
+static int do_compare_entry_piecewise(const struct cache_entry *ce,
+				      const struct traverse_info *info,
+				      const char *name, size_t namelen,
+				      unsigned mode)
 {
-	int len, pathlen, ce_len;
+	int pathlen, ce_len;
 	const char *ce_name;
 
 	if (info->prev) {
 		int cmp = do_compare_entry_piecewise(ce, info->prev,
-						     &info->name);
+						     info->name, info->namelen,
+						     info->mode);
 		if (cmp)
 			return cmp;
 	}
@@ -884,15 +890,15 @@ static int do_compare_entry_piecewise(const struct cache_entry *ce, const struct
 	ce_len -= pathlen;
 	ce_name = ce->name + pathlen;
 
-	len = tree_entry_len(n);
-	return df_name_compare(ce_name, ce_len, S_IFREG, n->path, len, n->mode);
+	return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
 }
 
 static int do_compare_entry(const struct cache_entry *ce,
 			    const struct traverse_info *info,
-			    const struct name_entry *n)
+			    const char *name, size_t namelen,
+			    unsigned mode)
 {
-	int len, pathlen, ce_len;
+	int pathlen, ce_len;
 	const char *ce_name;
 	int cmp;
 
@@ -902,7 +908,7 @@ static int do_compare_entry(const struct cache_entry *ce,
 	 * it is quicker to use the precomputed version.
 	 */
 	if (!info->traverse_path)
-		return do_compare_entry_piecewise(ce, info, n);
+		return do_compare_entry_piecewise(ce, info, name, namelen, mode);
 
 	cmp = strncmp(ce->name, info->traverse_path, info->pathlen);
 	if (cmp)
@@ -917,13 +923,12 @@ static int do_compare_entry(const struct cache_entry *ce,
 	ce_len -= pathlen;
 	ce_name = ce->name + pathlen;
 
-	len = tree_entry_len(n);
-	return df_name_compare(ce_name, ce_len, S_IFREG, n->path, len, n->mode);
+	return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
 }
 
 static int compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
 {
-	int cmp = do_compare_entry(ce, info, n);
+	int cmp = do_compare_entry(ce, info, n->path, n->pathlen, n->mode);
 	if (cmp)
 		return cmp;
 
@@ -939,7 +944,8 @@ static int ce_in_traverse_path(const struct cache_entry *ce,
 {
 	if (!info->prev)
 		return 1;
-	if (do_compare_entry(ce, info->prev, &info->name))
+	if (do_compare_entry(ce, info->prev,
+			     info->name, info->namelen, info->mode))
 		return 0;
 	/*
 	 * If ce (blob) is the same name as the path (which is a tree
@@ -964,7 +970,7 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	ce->ce_flags = create_ce_flags(stage);
 	ce->ce_namelen = len;
 	oidcpy(&ce->oid, &n->oid);
-	make_traverse_path(ce->name, info, n);
+	make_traverse_path(ce->name, info, n->path, n->pathlen);
 
 	return ce;
 }
@@ -1057,13 +1063,12 @@ static int unpack_failed(struct unpack_trees_options *o, const char *message)
  * the directory.
  */
 static int find_cache_pos(struct traverse_info *info,
-			  const struct name_entry *p)
+			  const char *p, size_t p_len)
 {
 	int pos;
 	struct unpack_trees_options *o = info->data;
 	struct index_state *index = o->src_index;
 	int pfxlen = info->pathlen;
-	int p_len = tree_entry_len(p);
 
 	for (pos = o->cache_bottom; pos < index->cache_nr; pos++) {
 		const struct cache_entry *ce = index->cache[pos];
@@ -1099,7 +1104,7 @@ static int find_cache_pos(struct traverse_info *info,
 			ce_len = ce_slash - ce_name;
 		else
 			ce_len = ce_namelen(ce) - pfxlen;
-		cmp = name_compare(p->path, p_len, ce_name, ce_len);
+		cmp = name_compare(p, p_len, ce_name, ce_len);
 		/*
 		 * Exact match; if we have a directory we need to
 		 * delay returning it.
@@ -1114,7 +1119,7 @@ static int find_cache_pos(struct traverse_info *info,
 		 * E.g.  ce_name == "t-i", and p->path == "t"; we may
 		 * have "t/a" in the index.
 		 */
-		if (p_len < ce_len && !memcmp(ce_name, p->path, p_len) &&
+		if (p_len < ce_len && !memcmp(ce_name, p, p_len) &&
 		    ce_name[p_len] < '/')
 			continue; /* keep looking */
 		break;
@@ -1125,7 +1130,7 @@ static int find_cache_pos(struct traverse_info *info,
 static struct cache_entry *find_cache_entry(struct traverse_info *info,
 					    const struct name_entry *p)
 {
-	int pos = find_cache_pos(info, p);
+	int pos = find_cache_pos(info, p->path, p->pathlen);
 	struct unpack_trees_options *o = info->data;
 
 	if (0 <= pos)
@@ -1138,10 +1143,10 @@ static void debug_path(struct traverse_info *info)
 {
 	if (info->prev) {
 		debug_path(info->prev);
-		if (*info->prev->name.path)
+		if (*info->prev->name)
 			putchar('/');
 	}
-	printf("%s", info->name.path);
+	printf("%s", info->name);
 }
 
 static void debug_name_entry(int i, struct name_entry *n)
-- 
2.23.0.rc0.426.gbdee707ba7

