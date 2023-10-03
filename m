Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F79E8FDB3
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbjJCU3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjJCU3e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:29:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB0AB
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:29:31 -0700 (PDT)
Received: (qmail 14875 invoked by uid 109); 3 Oct 2023 20:29:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:29:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14925 invoked by uid 111); 3 Oct 2023 20:29:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:29:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:29:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/10] commit-graph: free all elements of graph chain
Message-ID: <20231003202930.GE7812@coredump.intra.peff.net>
References: <20231003202504.GA7697@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202504.GA7697@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running "commit-graph verify", we call free_commit_graph(). That's
sufficient for the case of a single graph file, but if we loaded a chain
of split graph files, they form a linked list via the base_graph
pointers. We need to free all of them, or we leak all but the first
struct.

We can make this work by teaching free_commit_graph() to walk the
base_graph pointers and free each element. This in turn lets us simplify
close_commit_graph(), which does the same thing by recursion (we cannot
just use close_commit_graph() in "commit-graph verify", as the function
takes a pointer to an object store, and the verify command creates a
single one-off graph struct).

While indenting the code in free_commit_graph() for the loop, I noticed
that setting g->data to NULL is rather pointless, as we free the struct
a few lines later. So I cleaned that up while we're here.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index dc54ef4776..2f75ecd9ae 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -723,19 +723,10 @@ struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
 	return NULL;
 }
 
-static void close_commit_graph_one(struct commit_graph *g)
-{
-	if (!g)
-		return;
-
-	close_commit_graph_one(g->base_graph);
-	free_commit_graph(g);
-}
-
 void close_commit_graph(struct raw_object_store *o)
 {
 	clear_commit_graph_data_slab(&commit_graph_data_slab);
-	close_commit_graph_one(o->commit_graph);
+	free_commit_graph(o->commit_graph);
 	o->commit_graph = NULL;
 }
 
@@ -2753,15 +2744,17 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 
 void free_commit_graph(struct commit_graph *g)
 {
-	if (!g)
-		return;
-	if (g->data) {
-		munmap((void *)g->data, g->data_len);
-		g->data = NULL;
+	while (g) {
+		struct commit_graph *next = g->base_graph;
+
+		if (g->data)
+			munmap((void *)g->data, g->data_len);
+		free(g->filename);
+		free(g->bloom_filter_settings);
+		free(g);
+
+		g = next;
 	}
-	free(g->filename);
-	free(g->bloom_filter_settings);
-	free(g);
 }
 
 void disable_commit_graph(struct repository *r)
-- 
2.42.0.810.gbc538a0ee6

