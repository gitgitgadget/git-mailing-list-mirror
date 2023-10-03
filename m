Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11840E8FDB3
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbjJCUaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240954AbjJCUaI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:30:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67727AD
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:30:05 -0700 (PDT)
Received: (qmail 14880 invoked by uid 109); 3 Oct 2023 20:30:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:30:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14962 invoked by uid 111); 3 Oct 2023 20:30:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:30:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:30:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/10] commit-graph: delay base_graph assignment in
 add_graph_to_chain()
Message-ID: <20231003203004.GF7812@coredump.intra.peff.net>
References: <20231003202504.GA7697@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202504.GA7697@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When adding a graph to a chain, we do some consistency checks and then
if everything looks good, set g->base_graph to add a link to the chain.
But when we added a new consistency check in 209250ef38 (commit-graph.c:
prevent overflow in add_graph_to_chain(), 2023-07-12), it comes _after_
we've already set g->base_graph. So we might return failure, even though
we actually added to the chain.

This hasn't caused a bug yet, because after failing to add to the chain,
we discard the failed graph struct completely, leaking it. But in order
to fix that, it's important that the struct be in a consistent and
predictable state after the failure.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 2f75ecd9ae..2c72a554c2 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -498,8 +498,6 @@ static int add_graph_to_chain(struct commit_graph *g,
 		cur_g = cur_g->base_graph;
 	}
 
-	g->base_graph = chain;
-
 	if (chain) {
 		if (unsigned_add_overflows(chain->num_commits,
 					   chain->num_commits_in_base)) {
@@ -510,6 +508,8 @@ static int add_graph_to_chain(struct commit_graph *g,
 		g->num_commits_in_base = chain->num_commits + chain->num_commits_in_base;
 	}
 
+	g->base_graph = chain;
+
 	return 1;
 }
 
-- 
2.42.0.810.gbc538a0ee6

