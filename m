Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF7DE8FDB4
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbjJCUat (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjJCUas (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:30:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D8DAB
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:30:45 -0700 (PDT)
Received: (qmail 14885 invoked by uid 109); 3 Oct 2023 20:30:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:30:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14965 invoked by uid 111); 3 Oct 2023 20:30:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:30:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:30:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/10] commit-graph: free graph struct that was not added to
 chain
Message-ID: <20231003203044.GG7812@coredump.intra.peff.net>
References: <20231003202504.GA7697@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202504.GA7697@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reading the graph chain file, we open (and allocate) each
individual slice it mentions and then add them to a linked-list chain.
But if adding to the chain fails (e.g., because the base-graph chunk it
contains didn't match what we expected), we leave the function without
freeing the graph struct that caused the failure, leaking it.

We can fix it by calling free_graph_commit().

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 2c72a554c2..4aa2f294f1 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -566,6 +566,8 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 				if (add_graph_to_chain(g, graph_chain, oids, i)) {
 					graph_chain = g;
 					valid = 1;
+				} else {
+					free_commit_graph(g);
 				}
 
 				break;
-- 
2.42.0.810.gbc538a0ee6

