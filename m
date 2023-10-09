Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3488CD612F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378196AbjJIVFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378144AbjJIVFR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:05:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FEF92
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:05:15 -0700 (PDT)
Received: (qmail 24371 invoked by uid 109); 9 Oct 2023 21:05:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:05:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18586 invoked by uid 111); 9 Oct 2023 21:05:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:05:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:05:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 07/20] midx: check size of pack names chunk
Message-ID: <20231009210514.GG3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We parse the pack-name chunk as a series of NUL-terminated strings. But
since we don't look at the chunk size, there's nothing to guarantee that
we don't parse off the end of the chunk (or even off the end of the
mapped file).

We can record the length, and then as we parse make sure that we never
walk past it.

The new test exercises the case, though note that it does not actually
segfault before this patch. It hits a NUL byte somewhere in one of the
other chunks, and comes up with a garbage pack name. You could construct
one that reads out-of-bounds (e.g., a PNAM chunk at the end of file),
but this case is simple and sufficient to check that we detect the
problem.

Signed-off-by: Jeff King <peff@peff.net>
---
 midx.c                      | 11 +++++++++--
 midx.h                      |  1 +
 t/t5319-multi-pack-index.sh | 11 +++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 62e4c03e79..ec585cae1b 100644
--- a/midx.c
+++ b/midx.c
@@ -157,7 +157,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 				   MIDX_HEADER_SIZE, m->num_chunks))
 		goto cleanup_fail;
 
-	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names))
+	if (pair_chunk(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names, &m->chunk_pack_names_len))
 		die(_("multi-pack-index required pack-name chunk missing or corrupted"));
 	if (read_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m))
 		die(_("multi-pack-index required OID fanout chunk missing or corrupted"));
@@ -176,9 +176,16 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 	cur_pack_name = (const char *)m->chunk_pack_names;
 	for (i = 0; i < m->num_packs; i++) {
+		const char *end;
+		size_t avail = m->chunk_pack_names_len -
+				(cur_pack_name - (const char *)m->chunk_pack_names);
+
 		m->pack_names[i] = cur_pack_name;
 
-		cur_pack_name += strlen(cur_pack_name) + 1;
+		end = memchr(cur_pack_name, '\0', avail);
+		if (!end)
+			die(_("multi-pack-index pack-name chunk is too short"));
+		cur_pack_name = end + 1;
 
 		if (i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0)
 			die(_("multi-pack-index pack names out of order: '%s' before '%s'"),
diff --git a/midx.h b/midx.h
index 5578cd7b83..5b2a7da043 100644
--- a/midx.h
+++ b/midx.h
@@ -32,6 +32,7 @@ struct multi_pack_index {
 	int local;
 
 	const unsigned char *chunk_pack_names;
+	size_t chunk_pack_names_len;
 	const uint32_t *chunk_oid_fanout;
 	const unsigned char *chunk_oid_lookup;
 	const unsigned char *chunk_object_offsets;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 2722e495b2..0a0ccec8a4 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1083,4 +1083,15 @@ test_expect_success 'reader notices too-small oid lookup chunk' '
 	test_cmp expect err
 '
 
+test_expect_success 'reader notices too-small pack names chunk' '
+	# There is no NUL to terminate the name here, so the
+	# chunk is too short.
+	corrupt_chunk PNAM clear 70656666 &&
+	test_must_fail git log 2>err &&
+	cat >expect <<-\EOF &&
+	fatal: multi-pack-index pack-name chunk is too short
+	EOF
+	test_cmp expect err
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

