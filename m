Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405FFE8FDB4
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 20:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbjJCUbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjJCUa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 16:30:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99500AD
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 13:30:56 -0700 (PDT)
Received: (qmail 14888 invoked by uid 109); 3 Oct 2023 20:30:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Oct 2023 20:30:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14968 invoked by uid 111); 3 Oct 2023 20:30:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Oct 2023 16:30:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 3 Oct 2023 16:30:55 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/10] commit-graph: free write-context entries before
 overwriting
Message-ID: <20231003203055.GH7812@coredump.intra.peff.net>
References: <20231003202504.GA7697@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202504.GA7697@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a split graph file, we replace the final element of the
commit_graph_hash_after and commit_graph_filenames_after arrays. But
since these are allocated strings, we need to free them before
overwriting to avoid leaking the old string.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/commit-graph.c b/commit-graph.c
index 4aa2f294f1..744b7eb1a3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2065,9 +2065,11 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 			free(graph_name);
 		}
 
+		free(ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
 		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] = xstrdup(hash_to_hex(file_hash));
 		final_graph_name = get_split_graph_filename(ctx->odb,
 					ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1]);
+		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1]);
 		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
 
 		result = rename(ctx->graph_name, final_graph_name);
-- 
2.42.0.810.gbc538a0ee6

