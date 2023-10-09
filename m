Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09F0CD612F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378636AbjJIVFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378621AbjJIVFp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:05:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05E3AF
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:05:37 -0700 (PDT)
Received: (qmail 24408 invoked by uid 109); 9 Oct 2023 21:05:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:05:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18606 invoked by uid 111); 9 Oct 2023 21:05:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:05:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:05:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 12/20] commit-graph: check size of commit data chunk
Message-ID: <20231009210536.GL3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We expect a commit-graph file to have a fixed-size data record for each
commit in the file (and we know the number of commits to expct from the
size of the lookup table). If we encounter a file where this is too
small, we'll look past the end of the chunk (and possibly even off the
mapped memory).

We can fix this by checking the size up front when we record the
pointer.

The included test doesn't segfault, since it ends up reading bytes
from another chunk. But it produces nonsense results, since the values
it reads are garbage. Our test notices this by comparing the output to a
non-corrupted run of the same command (and of course we also check that
the expected error is printed to stderr).

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c          | 12 +++++++++++-
 t/t5318-commit-graph.sh |  9 +++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 472332f603..9b80bbd75b 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -340,6 +340,16 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
 	return 0;
 }
 
+static int graph_read_commit_data(const unsigned char *chunk_start,
+				  size_t chunk_size, void *data)
+{
+	struct commit_graph *g = data;
+	if (chunk_size != g->num_commits * GRAPH_DATA_WIDTH)
+		return error("commit-graph commit data chunk is wrong size");
+	g->chunk_commit_data = chunk_start;
+	return 0;
+}
+
 static int graph_read_bloom_data(const unsigned char *chunk_start,
 				  size_t chunk_size, void *data)
 {
@@ -422,7 +432,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 
 	read_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, graph_read_oid_fanout, graph);
 	read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);
-	pair_chunk_unsafe(cf, GRAPH_CHUNKID_DATA, &graph->chunk_commit_data);
+	read_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_commit_data, graph);
 	pair_chunk_unsafe(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
 	pair_chunk_unsafe(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d10658de9e..492460157d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -870,4 +870,13 @@ test_expect_success 'reader notices out-of-bounds fanout' '
 	test_cmp expect.err err
 '
 
+test_expect_success 'reader notices too-small commit data chunk' '
+	check_corrupt_chunk CDAT clear 00000000 &&
+	cat >expect.err <<-\EOF &&
+	error: commit-graph commit data chunk is wrong size
+	error: commit-graph is missing the Commit Data chunk
+	EOF
+	test_cmp expect.err err
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

