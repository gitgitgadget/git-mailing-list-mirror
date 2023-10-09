Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75E0CD612F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378686AbjJIVGY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378678AbjJIVGI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:06:08 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1702CBA
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:05:54 -0700 (PDT)
Received: (qmail 24464 invoked by uid 109); 9 Oct 2023 21:05:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:05:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18630 invoked by uid 111); 9 Oct 2023 21:05:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:05:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:05:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 18/20] commit-graph: check bounds when accessing BIDX chunk
Message-ID: <20231009210553.GR3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We load the bloom_filter_indexes chunk using pair_chunk(), so we have no
idea how big it is. This can lead to out-of-bounds reads if it is
smaller than expected, since we index it based on the number of commits
found elsewhere in the graph file.

We can check the chunk size up front, like we do for CDAT and other
chunks with one fixed-size record per commit.

The test case demonstrates the problem. It actually won't segfault,
because we end up reading random data from the follow-on chunk (BDAT in
this case), and the bounds checks added in the previous patch complain.
But this is by no means assured, and you can craft a commit-graph file
with BIDX at the end (or a smaller BDAT) that does segfault.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c       | 16 ++++++++++++++--
 t/t4216-log-bloom.sh |  9 +++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f7a42be6d0..1f334987b5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -360,6 +360,18 @@ static int graph_read_generation_data(const unsigned char *chunk_start,
 	return 0;
 }
 
+static int graph_read_bloom_index(const unsigned char *chunk_start,
+				  size_t chunk_size, void *data)
+{
+	struct commit_graph *g = data;
+	if (chunk_size != g->num_commits * 4) {
+		warning("commit-graph changed-path index chunk is too small");
+		return -1;
+	}
+	g->chunk_bloom_indexes = chunk_start;
+	return 0;
+}
+
 static int graph_read_bloom_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
@@ -470,8 +482,8 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	}
 
 	if (s->commit_graph_read_changed_paths) {
-		pair_chunk_unsafe(cf, GRAPH_CHUNKID_BLOOMINDEXES,
-			   &graph->chunk_bloom_indexes);
+		read_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
+			   graph_read_bloom_index, graph);
 		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
 			   graph_read_bloom_data, graph);
 	}
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 7a727bcddd..f6054cbb27 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -432,4 +432,13 @@ test_expect_success 'Bloom reader notices out-of-bounds filter offsets' '
 	grep "warning: ignoring out-of-range offset (4294967295) for changed-path filter at pos 3 of .git/objects/info/commit-graph" err
 '
 
+test_expect_success 'Bloom reader notices too-small index chunk' '
+	# replace the index with a single entry, making most
+	# lookups out-of-bounds
+	check_corrupt_graph BIDX clear 00000000 &&
+	echo "warning: commit-graph changed-path index chunk" \
+		"is too small" >expect.err &&
+	test_cmp expect.err err
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

