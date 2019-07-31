Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A2AE1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 04:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfGaEiU (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 00:38:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:56508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726439AbfGaEiT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 00:38:19 -0400
Received: (qmail 11364 invoked by uid 109); 31 Jul 2019 04:38:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 04:38:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13592 invoked by uid 111); 31 Jul 2019 04:40:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 00:40:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 00:38:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] tree-walk: use size_t consistently
Message-ID: <20190731043818.GC27170@sigill.intra.peff.net>
References: <20190731043659.GA27028@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731043659.GA27028@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We store and manipulate the cumulative traverse_info.pathlen as an
"int", which can overflow when we are fed ridiculously long pathnames
(e.g., ones at the edge of 2GB or 4GB, even if the individual tree entry
names are smaller than that). The results can be confusing, though
after some prodding I was not able to use this integer overflow to cause
an under-allocated buffer.

Let's consistently use size_t to generarate and store these, and make
sure our addition doesn't overflow.

Signed-off-by: Jeff King <peff@peff.net>
---
 tree-walk.c    | 4 ++--
 tree-walk.h    | 6 +++---
 unpack-trees.c | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 130d9f32f2..cf5af6a46b 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -170,7 +170,7 @@ int tree_entry_gently(struct tree_desc *desc, struct name_entry *entry)
 
 void setup_traverse_info(struct traverse_info *info, const char *base)
 {
-	int pathlen = strlen(base);
+	size_t pathlen = strlen(base);
 	static struct traverse_info dummy;
 
 	memset(info, 0, sizeof(*info));
@@ -186,7 +186,7 @@ void setup_traverse_info(struct traverse_info *info, const char *base)
 char *make_traverse_path(char *path, const struct traverse_info *info,
 			 const char *name, size_t namelen)
 {
-	int pathlen = info->pathlen;
+	size_t pathlen = info->pathlen;
 
 	path[pathlen + namelen] = 0;
 	for (;;) {
diff --git a/tree-walk.h b/tree-walk.h
index 2c59caa38a..95de0506c8 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -62,7 +62,7 @@ struct traverse_info {
 	size_t namelen;
 	unsigned mode;
 
-	int pathlen;
+	size_t pathlen;
 	struct pathspec *pathspec;
 
 	unsigned long df_conflicts;
@@ -76,9 +76,9 @@ char *make_traverse_path(char *path, const struct traverse_info *info,
 			 const char *name, size_t namelen);
 void setup_traverse_info(struct traverse_info *info, const char *base);
 
-static inline int traverse_path_len(const struct traverse_info *info, const struct name_entry *n)
+static inline size_t traverse_path_len(const struct traverse_info *info, const struct name_entry *n)
 {
-	return info->pathlen + tree_entry_len(n);
+	return st_add(info->pathlen, tree_entry_len(n));
 }
 
 /* in general, positive means "kind of interesting" */
diff --git a/unpack-trees.c b/unpack-trees.c
index 63cbddead8..a014ae9907 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -686,7 +686,7 @@ static int index_pos_by_traverse_info(struct name_entry *names,
 				      struct traverse_info *info)
 {
 	struct unpack_trees_options *o = info->data;
-	int len = traverse_path_len(info, names);
+	size_t len = traverse_path_len(info, names);
 	char *name = xmalloc(len + 1 /* slash */ + 1 /* NUL */);
 	int pos;
 
@@ -814,7 +814,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	newinfo.name = p->path;
 	newinfo.namelen = p->pathlen;
 	newinfo.mode = p->mode;
-	newinfo.pathlen += tree_entry_len(p) + 1;
+	newinfo.pathlen = st_add3(newinfo.pathlen, tree_entry_len(p), 1);
 	newinfo.df_conflicts |= df_conflicts;
 
 	/*
@@ -960,7 +960,7 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	struct index_state *istate,
 	int is_transient)
 {
-	int len = traverse_path_len(info, n);
+	size_t len = traverse_path_len(info, n);
 	struct cache_entry *ce =
 		is_transient ?
 		make_empty_transient_cache_entry(len) :
-- 
2.23.0.rc0.426.gbdee707ba7

