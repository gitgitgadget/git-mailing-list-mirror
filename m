Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B6DC83F1A
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 23:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241288AbjH2Xpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 19:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241276AbjH2XpV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 19:45:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0691B1
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 16:45:18 -0700 (PDT)
Received: (qmail 14817 invoked by uid 109); 29 Aug 2023 23:45:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Aug 2023 23:45:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19850 invoked by uid 111); 29 Aug 2023 23:45:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 19:45:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 19:45:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 06/22] commit-graph: mark unused data parameters in
 generation callbacks
Message-ID: <20230829234517.GD227214@coredump.intra.peff.net>
References: <20230829234305.GA226944@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829234305.GA226944@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The compute_generation_info code uses function pointers to abstract the
get/set generation operations. Some callers don't need the extra void
data pointer, which should be annotated to appease -Wunused-parameter.

Note that we can drop the assignment of the "data" parameter in
compute_generation_numbers(), as we've just shown that neither of the
callbacks it uses will access it. This matches the caller in
ensure_generations_valid(), which already does not bother to set "data".

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 0aa1640d15..e11f326097 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1568,12 +1568,14 @@ static void compute_topological_levels(struct write_commit_graph_context *ctx)
 	stop_progress(&ctx->progress);
 }
 
-static timestamp_t get_generation_from_graph_data(struct commit *c, void *data)
+static timestamp_t get_generation_from_graph_data(struct commit *c,
+						  void *data UNUSED)
 {
 	return commit_graph_data_at(c)->generation;
 }
 
-static void set_generation_v2(struct commit *c, timestamp_t t, void *data)
+static void set_generation_v2(struct commit *c, timestamp_t t,
+			      void *data UNUSED)
 {
 	struct commit_graph_data *g = commit_graph_data_at(c);
 	g->generation = t;
@@ -1587,7 +1589,6 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 		.commits = &ctx->commits,
 		.get_generation = get_generation_from_graph_data,
 		.set_generation = set_generation_v2,
-		.data = ctx,
 	};
 
 	if (ctx->report_progress)
@@ -1616,7 +1617,7 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 }
 
 static void set_generation_in_graph_data(struct commit *c, timestamp_t t,
-					 void *data)
+					 void *data UNUSED)
 {
 	commit_graph_data_at(c)->generation = t;
 }
-- 
2.42.0.528.g7950723a09

