Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE1BCD6137
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378598AbjJIVFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378151AbjJIVFh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:05:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6E6BA
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:05:34 -0700 (PDT)
Received: (qmail 24398 invoked by uid 109); 9 Oct 2023 21:05:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:05:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18602 invoked by uid 111); 9 Oct 2023 21:05:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:05:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:05:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 11/20] midx: check size of revindex chunk
Message-ID: <20231009210533.GK3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we load a revindex from disk, we check the size of the file
compared to the number of objects we expect it to have. But when we use
a RIDX chunk stored directly in the midx, we just access the memory
directly. This can lead to out-of-bounds memory access for a corrupted
or malicious multi-pack-index file.

We can catch this by recording the RIDX chunk size, and then checking it
against the expected size when we "load" the revindex. Note that this
check is much simpler than the one that load_revindex_from_disk() does,
because we just have the data array with no header (so we do not need
to account for the header size, and nor do we need to bother validating
the header values).

The test confirms both that we catch this case, and that we continue the
process (the revindex is required to use the midx bitmaps, but we
fallback to a non-bitmap traversal).

Signed-off-by: Jeff King <peff@peff.net>
---
 midx.c                      |  3 ++-
 midx.h                      |  1 +
 pack-revindex.c             | 13 ++++++++++++-
 t/t5319-multi-pack-index.sh | 17 +++++++++++++++++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 3e768d0df0..2f3863c936 100644
--- a/midx.c
+++ b/midx.c
@@ -184,7 +184,8 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 		   &m->chunk_large_offsets_len);
 
 	if (git_env_bool("GIT_TEST_MIDX_READ_RIDX", 1))
-		pair_chunk_unsafe(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex);
+		pair_chunk(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex,
+			   &m->chunk_revindex_len);
 
 	CALLOC_ARRAY(m->pack_names, m->num_packs);
 	CALLOC_ARRAY(m->packs, m->num_packs);
diff --git a/midx.h b/midx.h
index e8e8884d16..a5d98919c8 100644
--- a/midx.h
+++ b/midx.h
@@ -39,6 +39,7 @@ struct multi_pack_index {
 	const unsigned char *chunk_large_offsets;
 	size_t chunk_large_offsets_len;
 	const unsigned char *chunk_revindex;
+	size_t chunk_revindex_len;
 
 	const char **pack_names;
 	struct packed_git **packs;
diff --git a/pack-revindex.c b/pack-revindex.c
index 7fffcad912..6d8fd3645a 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -343,6 +343,17 @@ int verify_pack_revindex(struct packed_git *p)
 	return res;
 }
 
+static int can_use_midx_ridx_chunk(struct multi_pack_index *m)
+{
+	if (!m->chunk_revindex)
+		return 0;
+	if (m->chunk_revindex_len != st_mult(sizeof(uint32_t), m->num_objects)) {
+		error(_("multi-pack-index reverse-index chunk is the wrong size"));
+		return 0;
+	}
+	return 1;
+}
+
 int load_midx_revindex(struct multi_pack_index *m)
 {
 	struct strbuf revindex_name = STRBUF_INIT;
@@ -351,7 +362,7 @@ int load_midx_revindex(struct multi_pack_index *m)
 	if (m->revindex_data)
 		return 0;
 
-	if (m->chunk_revindex) {
+	if (can_use_midx_ridx_chunk(m)) {
 		/*
 		 * If the MIDX `m` has a `RIDX` chunk, then use its contents for
 		 * the reverse index instead of trying to load a separate `.rev`
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 16050f39d9..2a11dd1af6 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1138,4 +1138,21 @@ test_expect_success 'reader bounds-checks large offset table' '
 	)
 '
 
+test_expect_success 'reader notices too-small revindex chunk' '
+	# We only get a revindex with bitmaps (and likewise only
+	# load it when they are asked for).
+	test_config repack.writeBitmaps true &&
+	corrupt_chunk RIDX clear 00000000 &&
+	git -c core.multipackIndex=false rev-list \
+		--all --use-bitmap-index >expect.out &&
+	git -c core.multipackIndex=true rev-list \
+		--all --use-bitmap-index >out 2>err &&
+	test_cmp expect.out out &&
+	cat >expect.err <<-\EOF &&
+	error: multi-pack-index reverse-index chunk is the wrong size
+	warning: multi-pack bitmap is missing required reverse index
+	EOF
+	test_cmp expect.err err
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

