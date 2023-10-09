Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A4ECD6137
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378739AbjJIVGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378151AbjJIVGH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:06:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71AFEB
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:05:51 -0700 (PDT)
Received: (qmail 24458 invoked by uid 109); 9 Oct 2023 21:05:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:05:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18626 invoked by uid 111); 9 Oct 2023 21:05:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:05:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:05:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 17/20] commit-graph: check bounds when accessing BDAT chunk
Message-ID: <20231009210550.GQ3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When loading Bloom filters from a commit-graph file, we use the offset
values in the BIDX chunk to index into the memory mapped for the BDAT
chunk. But since we don't record how big the BDAT chunk is, we just
trust that the BIDX offsets won't cause us to read outside of the chunk
memory. A corrupted or malicious commit-graph file will cause us to
segfault (in practice this isn't a very interesting attack, since
commit-graph files are local-only, and the worst case is an
out-of-bounds read).

We can't fix this by checking the chunk size during parsing, since the
data in the BDAT chunk doesn't have a fixed size (that's why we need the
BIDX in the first place). So we'll fix it in two parts:

  1. Record the BDAT chunk size during parsing, and then later check
     that the BIDX offsets we look up are within bounds.

  2. Because the offsets are relative to the end of the BDAT header, we
     must also make sure that the BDAT chunk is at least as large as the
     expected header size. Otherwise, we overflow when trying to move
     past the header, even for an offset of "0". We can check this
     early, during the parsing stage.

The error messages are rather verbose, but since this is not something
you'd expect to see outside of severe bugs or corruption, it makes sense
to err on the side of too many details. Sadly we can't mention the
filename during the chunk-parsing stage, as we haven't set g->filename
at this point, nor passed it down through the stack.

Signed-off-by: Jeff King <peff@peff.net>
---
 bloom.c              | 24 ++++++++++++++++++++++++
 commit-graph.c       | 10 ++++++++++
 commit-graph.h       |  1 +
 t/t4216-log-bloom.sh | 28 ++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+)

diff --git a/bloom.c b/bloom.c
index aef6b5fea2..61abad7f8c 100644
--- a/bloom.c
+++ b/bloom.c
@@ -29,6 +29,26 @@ static inline unsigned char get_bitmask(uint32_t pos)
 	return ((unsigned char)1) << (pos & (BITS_PER_WORD - 1));
 }
 
+static int check_bloom_offset(struct commit_graph *g, uint32_t pos,
+			      uint32_t offset)
+{
+	/*
+	 * Note that we allow offsets equal to the data size, which would set
+	 * our pointers at one past the end of the chunk memory. This is
+	 * necessary because the on-disk index points to the end of the
+	 * entries (so we can compute size by comparing adjacent ones). And
+	 * naturally the final entry's end is one-past-the-end of the chunk.
+	 */
+	if (offset <= g->chunk_bloom_data_size - BLOOMDATA_CHUNK_HEADER_SIZE)
+		return 0;
+
+	warning("ignoring out-of-range offset (%"PRIuMAX") for changed-path"
+		" filter at pos %"PRIuMAX" of %s (chunk size: %"PRIuMAX")",
+		(uintmax_t)offset, (uintmax_t)pos,
+		g->filename, (uintmax_t)g->chunk_bloom_data_size);
+	return -1;
+}
+
 static int load_bloom_filter_from_graph(struct commit_graph *g,
 					struct bloom_filter *filter,
 					uint32_t graph_pos)
@@ -51,6 +71,10 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
 	else
 		start_index = 0;
 
+	if (check_bloom_offset(g, lex_pos, end_index) < 0 ||
+	    check_bloom_offset(g, lex_pos - 1, start_index) < 0)
+		return 0;
+
 	filter->len = end_index - start_index;
 	filter->data = (unsigned char *)(g->chunk_bloom_data +
 					sizeof(unsigned char) * start_index +
diff --git a/commit-graph.c b/commit-graph.c
index f446e76c28..f7a42be6d0 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -365,7 +365,17 @@ static int graph_read_bloom_data(const unsigned char *chunk_start,
 {
 	struct commit_graph *g = data;
 	uint32_t hash_version;
+
+	if (chunk_size < BLOOMDATA_CHUNK_HEADER_SIZE) {
+		warning("ignoring too-small changed-path chunk"
+			" (%"PRIuMAX" < %"PRIuMAX") in commit-graph file",
+			(uintmax_t)chunk_size,
+			(uintmax_t)BLOOMDATA_CHUNK_HEADER_SIZE);
+		return -1;
+	}
+
 	g->chunk_bloom_data = chunk_start;
+	g->chunk_bloom_data_size = chunk_size;
 	hash_version = get_be32(chunk_start);
 
 	if (hash_version != 1)
diff --git a/commit-graph.h b/commit-graph.h
index b373f15802..c6870274c5 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -101,6 +101,7 @@ struct commit_graph {
 	size_t chunk_base_graphs_size;
 	const unsigned char *chunk_bloom_indexes;
 	const unsigned char *chunk_bloom_data;
+	size_t chunk_bloom_data_size;
 
 	struct topo_level_slab *topo_levels;
 	struct bloom_filter_settings *bloom_filter_settings;
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facf..7a727bcddd 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -5,6 +5,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-chunk.sh
 
 GIT_TEST_COMMIT_GRAPH=0
 GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
@@ -404,4 +405,31 @@ test_expect_success 'Bloom generation backfills empty commits' '
 	)
 '
 
+corrupt_graph () {
+	graph=.git/objects/info/commit-graph &&
+	test_when_finished "rm -rf $graph" &&
+	git commit-graph write --reachable --changed-paths &&
+	corrupt_chunk_file $graph "$@"
+}
+
+check_corrupt_graph () {
+	corrupt_graph "$@" &&
+	git -c core.commitGraph=false log -- A/B/file2 >expect.out &&
+	git -c core.commitGraph=true log -- A/B/file2 >out 2>err &&
+	test_cmp expect.out out
+}
+
+test_expect_success 'Bloom reader notices too-small data chunk' '
+	check_corrupt_graph BDAT clear 00000000 &&
+	echo "warning: ignoring too-small changed-path chunk" \
+		"(4 < 12) in commit-graph file" >expect.err &&
+	test_cmp expect.err err
+'
+
+test_expect_success 'Bloom reader notices out-of-bounds filter offsets' '
+	check_corrupt_graph BIDX 12 FFFFFFFF &&
+	# use grep to avoid depending on exact chunk size
+	grep "warning: ignoring out-of-range offset (4294967295) for changed-path filter at pos 3 of .git/objects/info/commit-graph" err
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

