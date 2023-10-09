Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7B1CD6137
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378580AbjJIVFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378214AbjJIVFa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:05:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC7AA7
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:05:29 -0700 (PDT)
Received: (qmail 24384 invoked by uid 109); 9 Oct 2023 21:05:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:05:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18594 invoked by uid 111); 9 Oct 2023 21:05:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:05:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:05:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 09/20] midx: check size of object offset chunk
Message-ID: <20231009210527.GI3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The object offset chunk has one fixed-size entry for each object in the
midx. But since we don't check its size, we may access out-of-bounds
memory if we see a corrupt or malicious midx file.

Sine the entries are fixed-size, the total length can be known up-front,
and we can just check it while parsing the chunk (this is similar to
what we do when opening pack idx files, which contain a similar offset
table).

Signed-off-by: Jeff King <peff@peff.net>
---
 midx.c                      | 15 ++++++++++++++-
 t/t5319-multi-pack-index.sh | 10 ++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 98f84fbe61..7b1b45f381 100644
--- a/midx.c
+++ b/midx.c
@@ -88,6 +88,19 @@ static int midx_read_oid_lookup(const unsigned char *chunk_start,
 	return 0;
 }
 
+static int midx_read_object_offsets(const unsigned char *chunk_start,
+				    size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = data;
+	m->chunk_object_offsets = chunk_start;
+
+	if (chunk_size != st_mult(m->num_objects, MIDX_CHUNK_OFFSET_WIDTH)) {
+		error(_("multi-pack-index object offset chunk is the wrong size"));
+		return 1;
+	}
+	return 0;
+}
+
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local)
 {
 	struct multi_pack_index *m = NULL;
@@ -164,7 +177,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 		die(_("multi-pack-index required OID fanout chunk missing or corrupted"));
 	if (read_chunk(cf, MIDX_CHUNKID_OIDLOOKUP, midx_read_oid_lookup, m))
 		die(_("multi-pack-index required OID lookup chunk missing or corrupted"));
-	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_OBJECTOFFSETS, &m->chunk_object_offsets))
+	if (read_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS, midx_read_object_offsets, m))
 		die(_("multi-pack-index required object offsets chunk missing or corrupted"));
 
 	pair_chunk_unsafe(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 34f5944142..30687d5452 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1108,4 +1108,14 @@ test_expect_success 'reader handles unaligned chunks' '
 	test_cmp expect.err err
 '
 
+test_expect_success 'reader notices too-small object offset chunk' '
+	corrupt_chunk OOFF clear 00000000 &&
+	test_must_fail git log 2>err &&
+	cat >expect <<-\EOF &&
+	error: multi-pack-index object offset chunk is the wrong size
+	fatal: multi-pack-index required object offsets chunk missing or corrupted
+	EOF
+	test_cmp expect err
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

