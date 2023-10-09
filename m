Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E52CD612F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378649AbjJIVFx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378603AbjJIVFr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:05:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF21D8
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:05:39 -0700 (PDT)
Received: (qmail 24417 invoked by uid 109); 9 Oct 2023 21:05:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:05:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18610 invoked by uid 111); 9 Oct 2023 21:05:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:05:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:05:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 13/20] commit-graph: detect out-of-bounds extra-edges pointers
Message-ID: <20231009210538.GM3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If an entry in a commit-graph file has more than 2 parents, the
fixed-size parent fields instead point to an offset within an "extra
edges" chunk. We blindly follow these, assuming that the chunk is
present and sufficiently large; this can lead to an out-of-bounds read
for a corrupt or malicious file.

We can fix this by recording the size of the chunk and adding a
bounds-check in fill_commit_in_graph(). There are a few tricky bits:

  1. We'll switch from working with a pointer to an offset. This makes
     some corner cases just fall out naturally:

      a. If we did not find an EDGE chunk at all, our size will
         correctly be zero (so everything is "out of bounds").

      b. Comparing "size / 4" lets us make sure we have at least 4 bytes
         to read, and we never compute a pointer more than one element
         past the end of the array (computing a larger pointer is
         probably OK in practice, but is technically undefined
         behavior).

      c. The current code casts to "uint32_t *". Replacing it with an
         offset avoids any comparison between different types of pointer
         (since the chunk is stored as "unsigned char *").

  2. This is the first case in which fill_commit_in_graph() may return
     anything but success. We need to make sure to roll back the
     "parsed" flag (and any parents we might have added before running
     out of buffer) so that the caller can cleanly fall back to
     loading the commit object itself.

     It's a little non-trivial to do this, and we might benefit from
     factoring it out. But we can wait on that until we actually see a
     second case where we return an error.

As a bonus, this lets us drop the st_mult() call. Since we've already
done a bounds check, we know there won't be any integer overflow (it
would imply our buffer is larger than a size_t can hold).

The included test does not actually segfault before this patch (though
you could construct a case where it does). Instead, it reads garbage
from the next chunk which results in it complaining about a bogus parent
id. This is sufficient for our needs, though (we care that the fallback
succeeds, and that stderr mentions the out-of-bounds read).

Signed-off-by: Jeff King <peff@peff.net>
---
 commit-graph.c          | 20 ++++++++++++++------
 commit-graph.h          |  1 +
 t/t5318-commit-graph.sh |  8 ++++++++
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9b80bbd75b..e4860841fc 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -433,7 +433,8 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	read_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, graph_read_oid_fanout, graph);
 	read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph);
 	read_chunk(cf, GRAPH_CHUNKID_DATA, graph_read_commit_data, graph);
-	pair_chunk_unsafe(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges);
+	pair_chunk(cf, GRAPH_CHUNKID_EXTRAEDGES, &graph->chunk_extra_edges,
+		   &graph->chunk_extra_edges_size);
 	pair_chunk_unsafe(cf, GRAPH_CHUNKID_BASE, &graph->chunk_base_graphs);
 
 	if (s->commit_graph_generation_version >= 2) {
@@ -899,7 +900,7 @@ static int fill_commit_in_graph(struct repository *r,
 				struct commit_graph *g, uint32_t pos)
 {
 	uint32_t edge_value;
-	uint32_t *parent_data_ptr;
+	uint32_t parent_data_pos;
 	struct commit_list **pptr;
 	const unsigned char *commit_data;
 	uint32_t lex_index;
@@ -931,14 +932,21 @@ static int fill_commit_in_graph(struct repository *r,
 		return 1;
 	}
 
-	parent_data_ptr = (uint32_t*)(g->chunk_extra_edges +
-			  st_mult(4, edge_value & GRAPH_EDGE_LAST_MASK));
+	parent_data_pos = edge_value & GRAPH_EDGE_LAST_MASK;
 	do {
-		edge_value = get_be32(parent_data_ptr);
+		if (g->chunk_extra_edges_size / sizeof(uint32_t) <= parent_data_pos) {
+			error("commit-graph extra-edges pointer out of bounds");
+			free_commit_list(item->parents);
+			item->parents = NULL;
+			item->object.parsed = 0;
+			return 0;
+		}
+		edge_value = get_be32(g->chunk_extra_edges +
+				      sizeof(uint32_t) * parent_data_pos);
 		pptr = insert_parent_or_die(r, g,
 					    edge_value & GRAPH_EDGE_LAST_MASK,
 					    pptr);
-		parent_data_ptr++;
+		parent_data_pos++;
 	} while (!(edge_value & GRAPH_LAST_EDGE));
 
 	return 1;
diff --git a/commit-graph.h b/commit-graph.h
index 20ada7e891..1f8a9de4fb 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -95,6 +95,7 @@ struct commit_graph {
 	const unsigned char *chunk_generation_data;
 	const unsigned char *chunk_generation_data_overflow;
 	const unsigned char *chunk_extra_edges;
+	size_t chunk_extra_edges_size;
 	const unsigned char *chunk_base_graphs;
 	const unsigned char *chunk_bloom_indexes;
 	const unsigned char *chunk_bloom_data;
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 492460157d..05bafcfe5f 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -879,4 +879,12 @@ test_expect_success 'reader notices too-small commit data chunk' '
 	test_cmp expect.err err
 '
 
+test_expect_success 'reader notices out-of-bounds extra edge' '
+	check_corrupt_chunk EDGE clear &&
+	cat >expect.err <<-\EOF &&
+	error: commit-graph extra-edges pointer out of bounds
+	EOF
+	test_cmp expect.err err
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

