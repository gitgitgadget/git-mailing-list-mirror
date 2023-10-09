Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5179DCD6137
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378633AbjJIVF4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378151AbjJIVFs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:05:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33FFF1
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:05:42 -0700 (PDT)
Received: (qmail 24424 invoked by uid 109); 9 Oct 2023 21:05:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:05:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18614 invoked by uid 111); 9 Oct 2023 21:05:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:05:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:05:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 14/20] commit-graph: bounds-check base graphs chunk
Message-ID: <20231009210541.GN3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we are loading a commit-graph chain, we check that each slice of the
chain points to the appropriate set of base graphs via its BASE chunk.
But since we don't record the size of the chunk, we may access
out-of-bounds memory if the file is corrupted.

Since we know the number of entries we expect to find (based on the
position within the commit-graph-chain file), we can just check the size
up front.

In theory this would also let us drop the st_mult() call a few lines
later when we actually access the memory, since we know that the
computed offset will fit in a size_t. But because the operands
"g->hash_len" and "n" have types "unsigned char" and "int", we'd have to
cast to size_t first. Leaving the st_mult() does that cast, and makes it
more obvious that we don't have an overflow problem.

Note that the test does not actually segfault before this patch, since
it just reads garbage from the chunk after BASE (and indeed, it even
rejects the file because that garbage does not have the expected hash
value). You could construct a file with BASE at the end that did
segfault, but corrupting the existing one is easy, and we can check
stderr for the expected message.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c                |  8 +++++++-
 commit-graph.h                |  1 +
 t/t5324-split-commit-graph.sh | 14 ++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index e4860841fc..4377b547c8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -435,7 +435,8 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	read_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_commit_data, graph);
 	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges,
 		   &graph->chunk_extra_edges_size);
-	pair_chunk_unsafe(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);
+	pair_chunk(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs,
+		   &graph->chunk_base_graphs_size);
 
 	if (s->commit_graph_generation_version >= 2) {
 		pair_chunk_unsafe(cf, GRAPH_CHUNKID_GENERATION_DATA,
@@ -546,6 +547,11 @@ static int add_graph_to_chain(struct commit_graph *g,
 		return 0;
 	}
 
+	if (g->chunk_base_graphs_size / g->hash_len < n) {
+		warning(_("commit-graph base graphs chunk is too small"));
+		return 0;
+	}
+
 	while (n) {
 		n--;
 
diff --git a/commit-graph.h b/commit-graph.h
index 1f8a9de4fb..e4248ea05d 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -97,6 +97,7 @@ struct commit_graph {
 	const unsigned char *chunk_extra_edges;
 	size_t chunk_extra_edges_size;
 	const unsigned char *chunk_base_graphs;
+	size_t chunk_base_graphs_size;
 	const unsigned char *chunk_bloom_indexes;
 	const unsigned char *chunk_bloom_data;
 
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 55b5765e2d..3c8482d073 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -2,6 +2,7 @@
 
 test_description='split commit graph'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-chunk.sh
 
 GIT_TEST_COMMIT_GRAPH=0
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
@@ -398,6 +399,19 @@ test_expect_success 'verify across alternates' '
 	)
 '
 
+test_expect_success 'reader bounds-checks base-graph chunk' '
+	git clone --no-hardlinks . corrupt-base-chunk &&
+	(
+		cd corrupt-base-chunk &&
+		tip_file=$graphdir/graph-$(tail -n 1 $graphdir/commit-graph-chain).graph &&
+		corrupt_chunk_file "$tip_file" BASE clear 01020304 &&
+		git -c core.commitGraph=false log >expect.out &&
+		git -c core.commitGraph=true log >out 2>err &&
+		test_cmp expect.out out &&
+		grep "commit-graph base graphs chunk is too small" err
+	)
+'
+
 test_expect_success 'add octopus merge' '
 	git reset --hard commits/10 &&
 	git merge commits/3 commits/4 &&
-- 
2.42.0.884.g35e1fe1a6a

