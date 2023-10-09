Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF99CD612F
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 20:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378131AbjJIU7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 16:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377082AbjJIU7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 16:59:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9309E
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 13:59:20 -0700 (PDT)
Received: (qmail 24316 invoked by uid 109); 9 Oct 2023 20:59:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 20:59:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18516 invoked by uid 111); 9 Oct 2023 20:59:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 16:59:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 16:59:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 03/20] midx: stop ignoring malformed oid fanout chunk
Message-ID: <20231009205919.GC3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we load the oid-fanout chunk, our callback checks that its size is
reasonable and returns an error if not. However, the caller only checks
our return value against CHUNK_NOT_FOUND, so we end up ignoring the
error completely! Using a too-small fanout table means we end up
accessing random memory for the fanout and segfault.

We can fix this by checking for any non-zero return value, rather than
just CHUNK_NOT_FOUND, and adjusting our error message to cover both
cases. We could handle each error code individually, but there's not
much point for such a rare case. The extra message produced in the
callback makes it clear what is going on.

The same pattern is used in the adjacent code. Those cases are actually
OK for now because they do not use a custom callback, so the only error
they can get is CHUNK_NOT_FOUND. But let's convert them, as this is an
accident waiting to happen (especially as we convert some of them away
from pair_chunk). The error messages are more verbose, but it should be
rare for a user to see these anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 midx.c                      | 16 ++++++++--------
 t/t5319-multi-pack-index.sh | 20 +++++++++++++++++++-
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/midx.c b/midx.c
index 3165218ab5..21d7dd15ef 100644
--- a/midx.c
+++ b/midx.c
@@ -143,14 +143,14 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 				   MIDX_HEADER_SIZE, m->num_chunks))
 		goto cleanup_fail;
 
-	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names) == CHUNK_NOT_FOUND)
-		die(_("multi-pack-index missing required pack-name chunk"));
-	if (read_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m) == CHUNK_NOT_FOUND)
-		die(_("multi-pack-index missing required OID fanout chunk"));
-	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_OIDLOOKUP, &m->chunk_oid_lookup) == CHUNK_NOT_FOUND)
-		die(_("multi-pack-index missing required OID lookup chunk"));
-	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_OBJECTOFFSETS, &m->chunk_object_offsets) == CHUNK_NOT_FOUND)
-		die(_("multi-pack-index missing required object offsets chunk"));
+	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_PACKNAMES, &m->chunk_pack_names))
+		die(_("multi-pack-index required pack-name chunk missing or corrupted"));
+	if (read_chunk(cf, MIDX_CHUNKID_OIDFANOUT, midx_read_oid_fanout, m))
+		die(_("multi-pack-index required OID fanout chunk missing or corrupted"));
+	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_OIDLOOKUP, &m->chunk_oid_lookup))
+		die(_("multi-pack-index required OID lookup chunk missing or corrupted"));
+	if (pair_chunk_unsafe(cf, MIDX_CHUNKID_OBJECTOFFSETS, &m->chunk_object_offsets))
+		die(_("multi-pack-index required object offsets chunk missing or corrupted"));
 
 	pair_chunk_unsafe(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets);
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 1bcc02004d..b8fe85aeba 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -2,6 +2,7 @@
 
 test_description='multi-pack-indexes'
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-chunk.sh
 
 GIT_TEST_MULTI_PACK_INDEX=0
 objdir=.git/objects
@@ -438,7 +439,7 @@ test_expect_success 'verify extended chunk count' '
 
 test_expect_success 'verify missing required chunk' '
 	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_ID "\01" $objdir \
-		"missing required"
+		"required pack-name chunk missing"
 '
 
 test_expect_success 'verify invalid chunk offset' '
@@ -1055,4 +1056,21 @@ test_expect_success 'repack with delta islands' '
 	)
 '
 
+corrupt_chunk () {
+	midx=.git/objects/pack/multi-pack-index &&
+	test_when_finished "rm -rf $midx" &&
+	git repack -ad --write-midx &&
+	corrupt_chunk_file $midx "$@"
+}
+
+test_expect_success 'reader notices too-small oid fanout chunk' '
+	corrupt_chunk OIDF clear 00000000 &&
+	test_must_fail git log 2>err &&
+	cat >expect <<-\EOF &&
+	error: multi-pack-index OID fanout is of the wrong size
+	fatal: multi-pack-index required OID fanout chunk missing or corrupted
+	EOF
+	test_cmp expect err
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

