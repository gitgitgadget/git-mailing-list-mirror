Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E596CD6137
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378055AbjJIVCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377469AbjJIVCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:02:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670F89E
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:02:04 -0700 (PDT)
Received: (qmail 24348 invoked by uid 109); 9 Oct 2023 21:02:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:02:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18549 invoked by uid 111); 9 Oct 2023 21:02:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:02:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:02:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 05/20] midx: check size of oid lookup chunk
Message-ID: <20231009210203.GE3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reading an on-disk multi-pack-index, we take the number of objects
in the midx from the final value of the fanout table. But we just
blindly assume that the chunk containing the actual oid entries is the
correct size. This can lead to us reading out-of-bounds memory if the
lookup chunk is too small (or if the fanout is corrupted; when they
don't agree we cannot tell which one is wrong).

Note that we bump the assignment of m->num_objects into the fanout
parser callback, so that it's set when we parse the lookup table
(otherwise we'd have to manually record the lookup table size and check
it later).

Signed-off-by: Jeff King <peff@peff.net>
---
As an aside, the first hunk of the diff annoyingly slides the "return 0"
into the wrong spot. I thought this was our heuristics gone wrong, but I
suspect it's actually the shortest diff because of the one-line change
in midx_read_oid_fanout(), which would otherwise require extra context
to split.

 midx.c                      | 18 +++++++++++++++---
 t/t5319-multi-pack-index.sh | 10 ++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 21d7dd15ef..62e4c03e79 100644
--- a/midx.c
+++ b/midx.c
@@ -71,6 +71,20 @@ static int midx_read_oid_fanout(const unsigned char *chunk_start,
 		error(_("multi-pack-index OID fanout is of the wrong size"));
 		return 1;
 	}
+	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
+	return 0;
+}
+
+static int midx_read_oid_lookup(const unsigned char *chunk_start,
+				size_t chunk_size, void *data)
+{
+	struct multi_pack_index *m = data;
+	m->chunk_oid_lookup = chunk_start;
+
+	if (chunk_size != st_mult(m->hash_len, m->num_objects)) {
+		error(_("multi-pack-index OID lookup chunk is the wrong size"));
+		return 1;
+	}
 	return 0;
 }
 
@@ -147,7 +161,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 		die(_("multi-pack-index required pack-name chunk missing or corrupted"));
 	if (read_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m))
 		die(_("multi-pack-index required OID fanout chunk missing or corrupted"));
-	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_OIDLOOKUP, &m->chunk_oid_lookup))
+	if (read_chunk(cf, MIDX_CHUNKID_OIDLOOKUP, midx_read_oid_lookup, m))
 		die(_("multi-pack-index required OID lookup chunk missing or corrupted"));
 	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_OBJECTOFFSETS, &m->chunk_object_offsets))
 		die(_("multi-pack-index required object offsets chunk missing or corrupted"));
@@ -157,8 +171,6 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	if (git_env_bool("GIT_TEST_MIDX_READ_RIDX", 1))
 		pair_chunk_unsafe(cf, MIDX_CHUNKID_REVINDEX, &m->chunk_revindex);
 
-	m->num_objects = ntohl(m->chunk_oid_fanout[255]);
-
 	CALLOC_ARRAY(m->pack_names, m->num_packs);
 	CALLOC_ARRAY(m->packs, m->num_packs);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index b8fe85aeba..2722e495b2 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1073,4 +1073,14 @@ test_expect_success 'reader notices too-small oid fanout chunk' '
 	test_cmp expect err
 '
 
+test_expect_success 'reader notices too-small oid lookup chunk' '
+	corrupt_chunk OIDL clear 00000000 &&
+	test_must_fail git log 2>err &&
+	cat >expect <<-\EOF &&
+	error: multi-pack-index OID lookup chunk is the wrong size
+	fatal: multi-pack-index required OID lookup chunk missing or corrupted
+	EOF
+	test_cmp expect err
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

