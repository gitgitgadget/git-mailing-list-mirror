Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329991F731
	for <e@80x24.org>; Wed, 31 Jul 2019 04:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfGaEiW (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 00:38:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:56514 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726439AbfGaEiV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 00:38:21 -0400
Received: (qmail 11370 invoked by uid 109); 31 Jul 2019 04:38:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 04:38:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13608 invoked by uid 111); 31 Jul 2019 04:40:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 00:40:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 00:38:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] tree-walk: accept a raw length for traverse_path_len()
Message-ID: <20190731043820.GD27170@sigill.intra.peff.net>
References: <20190731043659.GA27028@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731043659.GA27028@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We take a "struct name_entry", but only care about the length of the
path name. Let's just take that length directly, making it easier to use
the function from callers that sometimes do not have a name_entry at
all.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge-tree.c | 2 +-
 tree-walk.h          | 5 +++--
 unpack-trees.c       | 6 +++---
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index d8ace972c7..225460fe13 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -180,7 +180,7 @@ static struct merge_list *create_entry(unsigned stage, unsigned mode, const stru
 
 static char *traverse_path(const struct traverse_info *info, const struct name_entry *n)
 {
-	char *path = xmallocz(traverse_path_len(info, n));
+	char *path = xmallocz(traverse_path_len(info, tree_entry_len(n)));
 	return make_traverse_path(path, info, n->path, n->pathlen);
 }
 
diff --git a/tree-walk.h b/tree-walk.h
index 95de0506c8..98580a6f0b 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -76,9 +76,10 @@ char *make_traverse_path(char *path, const struct traverse_info *info,
 			 const char *name, size_t namelen);
 void setup_traverse_info(struct traverse_info *info, const char *base);
 
-static inline size_t traverse_path_len(const struct traverse_info *info, const struct name_entry *n)
+static inline size_t traverse_path_len(const struct traverse_info *info,
+				       size_t namelen)
 {
-	return st_add(info->pathlen, tree_entry_len(n));
+	return st_add(info->pathlen, namelen);
 }
 
 /* in general, positive means "kind of interesting" */
diff --git a/unpack-trees.c b/unpack-trees.c
index a014ae9907..88e4e55a73 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -686,7 +686,7 @@ static int index_pos_by_traverse_info(struct name_entry *names,
 				      struct traverse_info *info)
 {
 	struct unpack_trees_options *o = info->data;
-	size_t len = traverse_path_len(info, names);
+	size_t len = traverse_path_len(info, tree_entry_len(names));
 	char *name = xmalloc(len + 1 /* slash */ + 1 /* NUL */);
 	int pos;
 
@@ -936,7 +936,7 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
 	 * Even if the beginning compared identically, the ce should
 	 * compare as bigger than a directory leading up to it!
 	 */
-	return ce_namelen(ce) > traverse_path_len(info, n);
+	return ce_namelen(ce) > traverse_path_len(info, tree_entry_len(n));
 }
 
 static int ce_in_traverse_path(const struct cache_entry *ce,
@@ -960,7 +960,7 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	struct index_state *istate,
 	int is_transient)
 {
-	size_t len = traverse_path_len(info, n);
+	size_t len = traverse_path_len(info, tree_entry_len(n));
 	struct cache_entry *ce =
 		is_transient ?
 		make_empty_transient_cache_entry(len) :
-- 
2.23.0.rc0.426.gbdee707ba7

