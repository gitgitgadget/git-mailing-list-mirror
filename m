Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C0AE8FDB2
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbjJCU15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjJCU14 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:27:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7056A6
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:27:53 -0700 (PDT)
Received: (qmail 14868 invoked by uid 109); 3 Oct 2023 20:27:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:27:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14922 invoked by uid 111); 3 Oct 2023 20:27:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:27:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:27:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/10] commit-graph: move slab-clearing to
 close_commit_graph()
Message-ID: <20231003202752.GD7812@coredump.intra.peff.net>
References: <20231003202504.GA7697@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202504.GA7697@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When closing and freeing a commit-graph, the main entry point is
close_commit_graph(), which then uses close_commit_graph_one() to
recurse through the base_graph links and free each one.

Commit 957ba814bf (commit-graph: when closing the graph, also release
the slab, 2021-09-08) put the call to clear the slab into the recursive
function, but this is pointless: there's only a single global slab
variable. It works OK in practice because clearing the slab is
idempotent, but it makes the code harder to reason about and refactor.

Move it into the parent function so it's only called once (and there are
no other direct callers of the recursive close_commit_graph_one(), so we
are not hurting them).

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 5e8a3a5085..dc54ef4776 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -728,13 +728,13 @@ static void close_commit_graph_one(struct commit_graph *g)
 	if (!g)
 		return;
 
-	clear_commit_graph_data_slab(&commit_graph_data_slab);
 	close_commit_graph_one(g->base_graph);
 	free_commit_graph(g);
 }
 
 void close_commit_graph(struct raw_object_store *o)
 {
+	clear_commit_graph_data_slab(&commit_graph_data_slab);
 	close_commit_graph_one(o->commit_graph);
 	o->commit_graph = NULL;
 }
-- 
2.42.0.810.gbc538a0ee6

