Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2F2CD6139
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378604AbjJIVFh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378221AbjJIVFf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:05:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5EFA9
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:05:31 -0700 (PDT)
Received: (qmail 24392 invoked by uid 109); 9 Oct 2023 21:05:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:05:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18598 invoked by uid 111); 9 Oct 2023 21:05:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:05:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:05:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 10/20] midx: bounds-check large offset chunk
Message-ID: <20231009210530.GJ3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we see a large offset bit in the regular midx offset table, we
use the entry as an index into a separate large offset table (just like
a pack idx does). But we don't bounds-check the access to that large
offset table (nor even record its size when we parse the chunk!).

The equivalent code for a regular pack idx is in check_pack_index_ptr().
But things are a bit simpler here because of the chunked format: we can
just check our array index directly.

As a bonus, we can get rid of the st_mult() here. If our array
bounds-check is successful, then we know that the result will fit in a
size_t (and the bounds check uses a division to avoid overflow
entirely).

Signed-off-by: Jeff King <peff@peff.net>
---
 midx.c                      |  8 +++++---
 midx.h                      |  1 +
 t/t5319-multi-pack-index.sh | 20 ++++++++++++++++++++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 7b1b45f381..3e768d0df0 100644
--- a/midx.c
+++ b/midx.c
@@ -180,7 +180,8 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	if (read_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, midx_read_object_offsets, m))
 		die(_("multi-pack-index required object offsets chunk missing or corrupted"));
 
-	pair_chunk_unsafe(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets);
+	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets,
+		   &m->chunk_large_offsets_len);
 
 	if (git_env_bool("GIT_TEST_MIDX_READ_RIDX", 1))
 		pair_chunk_unsafe(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex);
@@ -303,8 +304,9 @@ off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
 			die(_("multi-pack-index stores a 64-bit offset, but off_t is too small"));
 
 		offset32 ^= MIDX_LARGE_OFFSET_NEEDED;
-		return get_be64(m->chunk_large_offsets +
-				st_mult(sizeof(uint64_t), offset32));
+		if (offset32 >= m->chunk_large_offsets_len / sizeof(uint64_t))
+			die(_("multi-pack-index large offset out of bounds"));
+		return get_be64(m->chunk_large_offsets + sizeof(uint64_t) * offset32);
 	}
 
 	return offset32;
diff --git a/midx.h b/midx.h
index 5b2a7da043..e8e8884d16 100644
--- a/midx.h
+++ b/midx.h
@@ -37,6 +37,7 @@ struct multi_pack_index {
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_object_offsets;
 	const unsigned char *chunk_large_offsets;
+	size_t chunk_large_offsets_len;
 	const unsigned char *chunk_revindex;
 
 	const char **pack_names;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 30687d5452..16050f39d9 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1118,4 +1118,24 @@ test_expect_success 'reader notices too-small object offset chunk' '
 	test_cmp expect err
 '
 
+test_expect_success 'reader bounds-checks large offset table' '
+	# re-use the objects64 dir here to cheaply get access to a midx
+	# with large offsets.
+	git init repo &&
+	test_when_finished "rm -rf repo" &&
+	(
+		cd repo &&
+		(cd ../objects64 && pwd) >.git/objects/info/alternates &&
+		git multi-pack-index --object-dir=../objects64 write &&
+		midx=../objects64/pack/multi-pack-index &&
+		corrupt_chunk_file $midx LOFF clear &&
+		test_must_fail git cat-file \
+			--batch-check --batch-all-objects 2>err &&
+		cat >expect <<-\EOF &&
+		fatal: multi-pack-index large offset out of bounds
+		EOF
+		test_cmp expect err
+	)
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

