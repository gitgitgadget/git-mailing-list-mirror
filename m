Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 401811F731
	for <e@80x24.org>; Wed, 31 Jul 2019 04:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbfGaEiY (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 00:38:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:56520 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728243AbfGaEiY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 00:38:24 -0400
Received: (qmail 11376 invoked by uid 109); 31 Jul 2019 04:38:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 04:38:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13624 invoked by uid 111); 31 Jul 2019 04:40:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 00:40:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 00:38:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] tree-walk: add a strbuf wrapper for make_traverse_path()
Message-ID: <20190731043822.GE27170@sigill.intra.peff.net>
References: <20190731043659.GA27028@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731043659.GA27028@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All but one of the callers of make_traverse_path() allocate a new heap
buffer to store the path. Let's give them an easy way to write to a
strbuf, which saves them from computing the length themselves (which is
especially tricky when they want to add to the path). It will also make
it easier for us to change the make_traverse_path() interface in a
future patch to improve its bounds-checking.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-tree-walking.txt |  4 ++++
 builtin/merge-tree.c                         |  5 +++--
 tree-walk.c                                  | 21 ++++++++++++++------
 tree-walk.h                                  |  3 +++
 unpack-trees.c                               | 16 +++++++--------
 5 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/Documentation/technical/api-tree-walking.txt b/Documentation/technical/api-tree-walking.txt
index 59d78e0362..7962e32854 100644
--- a/Documentation/technical/api-tree-walking.txt
+++ b/Documentation/technical/api-tree-walking.txt
@@ -138,6 +138,10 @@ same in the next callback invocation.
 	This utilizes the memory structure of a tree entry to avoid the
 	overhead of using a generic strlen().
 
+`strbuf_make_traverse_path`::
+
+	Convenience wrapper to `make_traverse_path` into a strbuf.
+
 Authors
 -------
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 225460fe13..e72714a5a8 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -180,8 +180,9 @@ static struct merge_list *create_entry(unsigned stage, unsigned mode, const stru
 
 static char *traverse_path(const struct traverse_info *info, const struct name_entry *n)
 {
-	char *path = xmallocz(traverse_path_len(info, tree_entry_len(n)));
-	return make_traverse_path(path, info, n->path, n->pathlen);
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_make_traverse_path(&buf, info, n->path, n->pathlen);
+	return strbuf_detach(&buf, NULL);
 }
 
 static void resolve(const struct traverse_info *info, struct name_entry *ours, struct name_entry *result)
diff --git a/tree-walk.c b/tree-walk.c
index cf5af6a46b..313780f40c 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -202,6 +202,17 @@ char *make_traverse_path(char *path, const struct traverse_info *info,
 	return path;
 }
 
+void strbuf_make_traverse_path(struct strbuf *out,
+			       const struct traverse_info *info,
+			       const char *name, size_t namelen)
+{
+	size_t len = traverse_path_len(info, namelen);
+
+	strbuf_grow(out, len);
+	make_traverse_path(out->buf + out->len, info, name, namelen);
+	strbuf_setlen(out, out->len + len);
+}
+
 struct tree_desc_skip {
 	struct tree_desc_skip *prev;
 	const void *ptr;
@@ -398,12 +409,10 @@ int traverse_trees(struct index_state *istate,
 		tx[i].d = t[i];
 
 	if (info->prev) {
-		strbuf_grow(&base, info->pathlen);
-		make_traverse_path(base.buf, info->prev, info->name,
-				   info->namelen);
-		base.buf[info->pathlen-1] = '/';
-		strbuf_setlen(&base, info->pathlen);
-		traverse_path = xstrndup(base.buf, info->pathlen);
+		strbuf_make_traverse_path(&base, info->prev,
+					  info->name, info->namelen);
+		strbuf_addch(&base, '/');
+		traverse_path = xstrndup(base.buf, base.len);
 	} else {
 		traverse_path = xstrndup(info->name, info->pathlen);
 	}
diff --git a/tree-walk.h b/tree-walk.h
index 98580a6f0b..43b56fd8ff 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -74,6 +74,9 @@ struct traverse_info {
 int get_tree_entry(struct repository *, const struct object_id *, const char *, struct object_id *, unsigned short *);
 char *make_traverse_path(char *path, const struct traverse_info *info,
 			 const char *name, size_t namelen);
+void strbuf_make_traverse_path(struct strbuf *out,
+			       const struct traverse_info *info,
+			       const char *name, size_t namelen);
 void setup_traverse_info(struct traverse_info *info, const char *base);
 
 static inline size_t traverse_path_len(const struct traverse_info *info,
diff --git a/unpack-trees.c b/unpack-trees.c
index 88e4e55a73..b154f09547 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -686,21 +686,19 @@ static int index_pos_by_traverse_info(struct name_entry *names,
 				      struct traverse_info *info)
 {
 	struct unpack_trees_options *o = info->data;
-	size_t len = traverse_path_len(info, tree_entry_len(names));
-	char *name = xmalloc(len + 1 /* slash */ + 1 /* NUL */);
+	struct strbuf name = STRBUF_INIT;
 	int pos;
 
-	make_traverse_path(name, info, names->path, names->pathlen);
-	name[len++] = '/';
-	name[len] = '\0';
-	pos = index_name_pos(o->src_index, name, len);
+	strbuf_make_traverse_path(&name, info, names->path, names->pathlen);
+	strbuf_addch(&name, '/');
+	pos = index_name_pos(o->src_index, name.buf, name.len);
 	if (pos >= 0)
 		BUG("This is a directory and should not exist in index");
 	pos = -pos - 1;
-	if (!starts_with(o->src_index->cache[pos]->name, name) ||
-	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name)))
+	if (!starts_with(o->src_index->cache[pos]->name, name.buf) ||
+	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))
 		BUG("pos must point at the first entry in this directory");
-	free(name);
+	strbuf_release(&name);
 	return pos;
 }
 
-- 
2.23.0.rc0.426.gbdee707ba7

