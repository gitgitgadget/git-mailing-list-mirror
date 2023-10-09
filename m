Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4352CD612F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 20:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378144AbjJIU7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 16:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378065AbjJIU7y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 16:59:54 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF3A3
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 13:59:52 -0700 (PDT)
Received: (qmail 24327 invoked by uid 109); 9 Oct 2023 20:59:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 20:59:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18520 invoked by uid 111); 9 Oct 2023 20:59:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 16:59:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 16:59:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 04/20] commit-graph: check size of oid fanout chunk
Message-ID: <20231009205951.GD3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We load the oid fanout chunk with pair_chunk(), which means we never see
the size of the chunk. We just assume the on-disk file uses the
appropriate size, and if it's too small we'll access random memory.

It's easy to check this up-front; the fanout always consists of 256
uint32's, since it is a fanout of the first byte of the hash pointing
into the oid index. These parameters can't be changed without
introducing a new chunk type.

This matches the similar check in the midx OIDF chunk (but note that
rather than checking for the error immediately, the graph code just
leaves parts of the struct NULL and checks for required fields later).

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c          | 13 +++++++++++--
 t/t5318-commit-graph.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index a689a55b79..9b3b01da61 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -305,6 +305,16 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 	return 0;
 }
 
+static int graph_read_oid_fanout(const unsigned char *chunk_start,
+				 size_t chunk_size, void *data)
+{
+	struct commit_graph *g = data;
+	if (chunk_size != 256 * sizeof(uint32_t))
+		return error("commit-graph oid fanout chunk is wrong size");
+	g->chunk_oid_fanout = (const uint32_t *)chunk_start;
+	return 0;
+}
+
 static int graph_read_oid_lookup(const unsigned char *chunk_start,
 				 size_t chunk_size, void *data)
 {
@@ -394,8 +404,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 				   GRAPH_HEADER_SIZE, graph->num_chunks))
 		goto free_and_return;
 
-	pair_chunk_unsafe(cf, GRAPH_CHUNKID_OIDFANOUT,
-		   (const unsigned char **)&graph->chunk_oid_fanout);
+	read_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, graph_read_oid_fanout, graph);
 	read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);
 	pair_chunk_unsafe(cf, GRAPH_CHUNKID_DATA, &graph->chunk_commit_data);
 	pair_chunk_unsafe(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index ba65f17dd9..d25bea3ec5 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -2,6 +2,7 @@
 
 test_description='commit graph'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-chunk.sh
 
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
 
@@ -821,4 +822,29 @@ test_expect_success 'overflow during generation version upgrade' '
 	)
 '
 
+corrupt_chunk () {
+	graph=full/.git/objects/info/commit-graph &&
+	test_when_finished "rm -rf $graph" &&
+	git -C full commit-graph write --reachable &&
+	corrupt_chunk_file $graph "$@"
+}
+
+check_corrupt_chunk () {
+	corrupt_chunk "$@" &&
+	git -C full -c core.commitGraph=false log >expect.out &&
+	git -C full -c core.commitGraph=true log >out 2>err &&
+	test_cmp expect.out out
+}
+
+test_expect_success 'reader notices too-small oid fanout chunk' '
+	# make it big enough that the graph file is plausible,
+	# otherwise we hit an earlier check
+	check_corrupt_chunk OIDF clear $(printf "000000%02x" $(test_seq 250)) &&
+	cat >expect.err <<-\EOF &&
+	error: commit-graph oid fanout chunk is wrong size
+	error: commit-graph is missing the OID Fanout chunk
+	EOF
+	test_cmp expect.err err
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

