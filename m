Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551DDCD612F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378205AbjJIVF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378212AbjJIVF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:05:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ED1A3
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:05:24 -0700 (PDT)
Received: (qmail 24378 invoked by uid 109); 9 Oct 2023 21:05:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:05:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18590 invoked by uid 111); 9 Oct 2023 21:05:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:05:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:05:23 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 08/20] midx: enforce chunk alignment on reading
Message-ID: <20231009210523.GH3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The midx reader assumes chunks are aligned to a 4-byte boundary: we
treat the fanout chunk as an array of uint32_t, indexing it to feed the
results to ntohl(). Without aligning the chunks, we may violate the
CPU's alignment constraints. Though many platforms allow this, some do
not. And certanily UBSan will complain, since it is undefined behavior.

Even though most chunks are naturally 4-byte-aligned (because they are
storing uint32_t or larger types), PNAM is not. It stores NUL-terminated
pack names, so you can have a valid chunk with any length. The writing
side handles this by 4-byte-aligning the chunk, introducing a few extra
NULs as necessary. But since we don't check this on the reading side, we
may end up with a misaligned fanout and trigger the undefined behavior.

We have two options here:

  1. Swap out ntohl(fanout[i]) for get_be32(fanout+i) everywhere. The
     latter handles alignment itself. It's possible that it's slightly
     slower (though in practice I'm not sure how true that is,
     especially for these code paths which then go on to do a binary
     search).

  2. Enforce the alignment when reading the chunks. This is easy to do,
     since the table-of-contents reader can check it in one spot.

I went with the second option here, just because it places less burden
on maintenance going forward (it is OK to continue using ntohl), and we
know it can't have any performance impact on the actual reads.

The commit-graph code uses the same chunk API. It's usually also 4-byte
aligned, but some chunks are not (like Bloom filter BDAT chunks). So
we'll pass "1" here to allow any alignment. It doesn't suffer from the
same problem as midx with its fanout because the fanout chunk is always
the first (and the rest of the format dictates that the first chunk will
start aligned).

The new test shows the effect on a midx with a misaligned PNAM chunk.
Note that the midx-reading code treats chunk-toc errors as soft, falling
back to the non-midx path rather than calling die(), as we do for other
parsing errors. Arguably we should make all of these behave the same,
but that's out of scope for this patch. For now the test just expects
the fallback behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 chunk-format.c              |  8 +++++++-
 chunk-format.h              |  3 ++-
 commit-graph.c              |  2 +-
 midx.c                      |  3 ++-
 t/t5319-multi-pack-index.sh | 14 ++++++++++++++
 5 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/chunk-format.c b/chunk-format.c
index 8d910e23f6..09ef86afa6 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -102,7 +102,8 @@ int read_table_of_contents(struct chunkfile *cf,
 			   const unsigned char *mfile,
 			   size_t mfile_size,
 			   uint64_t toc_offset,
-			   int toc_length)
+			   int toc_length,
+			   unsigned expected_alignment)
 {
 	int i;
 	uint32_t chunk_id;
@@ -120,6 +121,11 @@ int read_table_of_contents(struct chunkfile *cf,
 			error(_("terminating chunk id appears earlier than expected"));
 			return 1;
 		}
+		if (chunk_offset % expected_alignment != 0) {
+			error(_("chunk id %"PRIx32" not %d-byte aligned"),
+			      chunk_id, expected_alignment);
+			return 1;
+		}
 
 		table_of_contents += CHUNK_TOC_ENTRY_SIZE;
 		next_chunk_offset = get_be64(table_of_contents + 4);
diff --git a/chunk-format.h b/chunk-format.h
index 8dce7967f4..d608b8135c 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -36,7 +36,8 @@ int read_table_of_contents(struct chunkfile *cf,
 			   const unsigned char *mfile,
 			   size_t mfile_size,
 			   uint64_t toc_offset,
-			   int toc_length);
+			   int toc_length,
+			   unsigned expected_alignment);
 
 #define CHUNK_NOT_FOUND (-2)
 
diff --git a/commit-graph.c b/commit-graph.c
index b217e19194..472332f603 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -417,7 +417,7 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
 	cf = init_chunkfile(NULL);
 
 	if (read_table_of_contents(cf, graph->data, graph_size,
-				   GRAPH_HEADER_SIZE, graph->num_chunks))
+				   GRAPH_HEADER_SIZE, graph->num_chunks, 1))
 		goto free_and_return;
 
 	read_chunk(cf, GRAPH_CHUNKID_OIDFANOUT, graph_read_oid_fanout, graph);
diff --git a/midx.c b/midx.c
index ec585cae1b..98f84fbe61 100644
--- a/midx.c
+++ b/midx.c
@@ -154,7 +154,8 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	cf = init_chunkfile(NULL);
 
 	if (read_table_of_contents(cf, m->data, midx_size,
-				   MIDX_HEADER_SIZE, m->num_chunks))
+				   MIDX_HEADER_SIZE, m->num_chunks,
+				   MIDX_CHUNK_ALIGNMENT))
 		goto cleanup_fail;
 
 	if (pair_chunk(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names, &m->chunk_pack_names_len))
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 0a0ccec8a4..34f5944142 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1094,4 +1094,18 @@ test_expect_success 'reader notices too-small pack names chunk' '
 	test_cmp expect err
 '
 
+test_expect_success 'reader handles unaligned chunks' '
+	# A 9-byte PNAM means all of the subsequent chunks
+	# will no longer be 4-byte aligned, but it is still
+	# a valid one-pack chunk on its own (it is "foo.pack\0").
+	corrupt_chunk PNAM clear 666f6f2e7061636b00 &&
+	git -c core.multipackindex=false log >expect.out &&
+	git -c core.multipackindex=true log >out 2>err &&
+	test_cmp expect.out out &&
+	cat >expect.err <<-\EOF &&
+	error: chunk id 4f494446 not 4-byte aligned
+	EOF
+	test_cmp expect.err err
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

