Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA31CD6138
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378714AbjJIVGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378647AbjJIVFv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:05:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4F8CF
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:05:48 -0700 (PDT)
Received: (qmail 24449 invoked by uid 109); 9 Oct 2023 21:05:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:05:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18622 invoked by uid 111); 9 Oct 2023 21:05:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:05:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:05:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 16/20] commit-graph: bounds-check generation overflow chunk
Message-ID: <20231009210547.GP3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the generation entry in a commit-graph doesn't fit, we instead insert
an offset into a generation overflow chunk. But since we don't record
the size of the chunk, we may read outside the chunk if the offset we
find on disk is malicious or corrupted.

We can't check the size of the chunk up-front; it will vary based on how
many entries need overflow. So instead, we'll do a bounds-check before
accessing the chunk memory. Unfortunately there is no error-return from
this function, so we'll just have to die(), which is what it does for
other forms of corruption.

As with other cases, we can drop the st_mult() call, since we know our
bounds-checked value will fit within a size_t.

Before this patch, the test here actually "works" because we read
garbage data from the next chunk. And since that garbage data happens
not to provide a generation number which changes the output, it appears
to work. We could construct a case that actually segfaults or produces
wrong output, but it would be a bit tricky. For our purposes its
sufficient to check that we've detected the bounds error.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c                     | 10 +++++++---
 commit-graph.h                     |  1 +
 t/t5328-commit-graph-64bit-time.sh | 10 ++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index ca26870d1b..f446e76c28 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -451,8 +451,9 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	if (s->commit_graph_generation_version >= 2) {
 		read_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA,
 			   graph_read_generation_data, graph);
-		pair_chunk_unsafe(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
-			&graph->chunk_generation_data_overflow);
+		pair_chunk(cf, GRAPH_CHUNKID_GENERATION_DATA_OVERFLOW,
+			   &graph->chunk_generation_data_overflow,
+			   &graph->chunk_generation_data_overflow_size);
 
 		if (graph->chunk_generation_data)
 			graph->read_generation_data = 1;
@@ -896,7 +897,10 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 				die(_("commit-graph requires overflow generation data but has none"));
 
 			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
-			graph_data->generation = item->date + get_be64(g->chunk_generation_data_overflow + st_mult(8, offset_pos));
+			if (g->chunk_generation_data_overflow_size / sizeof(uint64_t) <= offset_pos)
+				die(_("commit-graph overflow generation data is too small"));
+			graph_data->generation = item->date +
+				get_be64(g->chunk_generation_data_overflow + sizeof(uint64_t) * offset_pos);
 		} else
 			graph_data->generation = item->date + offset;
 	} else
diff --git a/commit-graph.h b/commit-graph.h
index e4248ea05d..b373f15802 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -94,6 +94,7 @@ struct commit_graph {
 	const unsigned char *chunk_commit_data;
 	const unsigned char *chunk_generation_data;
 	const unsigned char *chunk_generation_data_overflow;
+	size_t chunk_generation_data_overflow_size;
 	const unsigned char *chunk_extra_edges;
 	size_t chunk_extra_edges_size;
 	const unsigned char *chunk_base_graphs;
diff --git a/t/t5328-commit-graph-64bit-time.sh b/t/t5328-commit-graph-64bit-time.sh
index e9c521c061..e5ff3e07ad 100755
--- a/t/t5328-commit-graph-64bit-time.sh
+++ b/t/t5328-commit-graph-64bit-time.sh
@@ -10,6 +10,7 @@ then
 fi
 
 . "$TEST_DIRECTORY"/lib-commit-graph.sh
+. "$TEST_DIRECTORY/lib-chunk.sh"
 
 UNIX_EPOCH_ZERO="@0 +0000"
 FUTURE_DATE="@4147483646 +0000"
@@ -72,4 +73,13 @@ test_expect_success 'single commit with generation data exceeding UINT32_MAX' '
 	git -C repo-uint32-max commit-graph verify
 '
 
+test_expect_success 'reader notices out-of-bounds generation overflow' '
+	graph=.git/objects/info/commit-graph &&
+	test_when_finished "rm -rf $graph" &&
+	git commit-graph write --reachable &&
+	corrupt_chunk_file $graph GDO2 clear &&
+	test_must_fail git log 2>err &&
+	grep "commit-graph overflow generation data is too small" err
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

