Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E075ECD6137
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjJIVFD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjJIVFB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:05:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61646A3
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:04:59 -0700 (PDT)
Received: (qmail 24362 invoked by uid 109); 9 Oct 2023 21:04:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:04:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18559 invoked by uid 111); 9 Oct 2023 21:05:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:05:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:04:58 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 06/20] commit-graph: check consistency of fanout table
Message-ID: <20231009210458.GF3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use bsearch_hash() to look up items in the oid index of a
commit-graph. It also has a fanout table to reduce the initial range in
which we'll search. But since the fanout comes from the on-disk file, a
corrupted or malicious file can cause us to look outside of the
allocated index memory.

One solution here would be to pass the total table size to
bsearch_hash(), which could then bounds check the values it reads from
the fanout. But there's an inexpensive up-front check we can do, and
it's the same one used by the midx and pack idx code (both of which
likewise have fanout tables and use bsearch_hash(), but are not affected
by this bug):

  1. We can check the value of the final fanout entry against the size
     of the table we got from the index chunk. These must always match,
     since the fanout is just slicing up the index.

       As a side note, the midx and pack idx code compute it the other
       way around: they use the final fanout value as the object count, and
       check the index size against it. Either is valid; if they
       disagree we cannot know which is wrong (a corrupted fanout value,
       or a too-small table of oids).

  2. We can quickly scan the fanout table to make sure it is
     monotonically increasing. If it is, then we know that every value
     is less than or equal to the final value, and therefore less than
     or equal to the table size.

     It would also be sufficient to just check that each fanout value is
     smaller than the final one, but the midx and pack idx code both do
     a full monotonicity check. It's the same cost, and it catches some
     other corruptions (though not all; the checks done by "commit-graph
     verify" are more complete but more expensive, and our goal here is
     to be fast and memory-safe).

There are two new tests. One just checks the final fanout value (this is
the mirror image of the "too small oid lookup" case added for the midx
in the previous commit; it's flipped here because commit-graph considers
the oid lookup chunk to be the source of truth).

The other actually creates a fanout with many out-of-bounds entries, and
prior to this patch, it does cause the segfault you'd expect. But note
that the error is not "your fanout entry is out-of-bounds", but rather
"fanout value out of order". That's because we leave the final fanout
value in place (to get past the table size check), making the index
non-monotonic (the second-to-last entry is big, but the last one must
remain small to match the actual table).

We need adjustments to a few existing tests, as well:

  - an earlier test in t5318 corrupts the fanout and runs "commit-graph
    verify". Its message is now changed, since we catch the problem
    earlier (during the load step, rather than the careful validation
    step).

  - in t5324, we test that "commit-graph verify --shallow" does not do
    expensive verification on the base file of the chain. But the
    corruption it uses (munging a byte at offset 1000) happens to be in
    the middle of the fanout table. And now we detect that problem in
    the cheaper checks that are performed for every part of the graph.
    We'll push this back to offset 1500, which is only caught by the
    more expensive checksum validation.

    Likewise, there's a later test in t5324 which munges an offset 100
    bytes into a file (also in the fanout table) that is referenced by
    an alternates file. So we now find that corruption during the load
    step, rather than the verification step. At the very least we need
    to change the error message (like the case above in t5318). But it
    is probably good to make sure we handle all parts of the
    verification even for alternate graph files. So let's likewise
    corrupt byte 1500 and make sure we found the invalid checksum.

Signed-off-by: Jeff King <peff@peff.net>
---
So I actually implemented the bsearch_hash() bounds checks and wrote
tests for midx and idx files before realizing how they handle this. ;)
Which makes sense, because the usual outcome for a corrupted idx file is
for it to say "non-monotonic index", which I have seen lead to user
confusion. Arguably we should have it say something about "hey, your idx
file seems to be corrupted, because...". But that can be its own topic.

 commit-graph.c                | 16 ++++++++++++++++
 t/t5318-commit-graph.sh       | 25 ++++++++++++++++++++++++-
 t/t5324-split-commit-graph.sh |  6 +++---
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 9b3b01da61..b217e19194 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -277,6 +277,8 @@ struct commit_graph *load_commit_graph_one_fd_st(struct repository *r,
 
 static int verify_commit_graph_lite(struct commit_graph *g)
 {
+	int i;
+
 	/*
 	 * Basic validation shared between parse_commit_graph()
 	 * which'll be called every time the graph is used, and the
@@ -302,6 +304,20 @@ static int verify_commit_graph_lite(struct commit_graph *g)
 		return 1;
 	}
 
+	for (i = 0; i < 255; i++) {
+		uint32_t oid_fanout1 = ntohl(g->chunk_oid_fanout[i]);
+		uint32_t oid_fanout2 = ntohl(g->chunk_oid_fanout[i + 1]);
+
+		if (oid_fanout1 > oid_fanout2) {
+			error("commit-graph fanout values out of order");
+			return 1;
+		}
+	}
+	if (ntohl(g->chunk_oid_fanout[255]) != g->num_commits) {
+		error("commit-graph oid table and fanout disagree on size");
+		return 1;
+	}
+
 	return 0;
 }
 
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d25bea3ec5..d10658de9e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -560,7 +560,7 @@ test_expect_success 'detect incorrect fanout' '
 
 test_expect_success 'detect incorrect fanout final value' '
 	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT2 "\01" \
-		"fanout value"
+		"oid table and fanout disagree on size"
 '
 
 test_expect_success 'detect incorrect OID order' '
@@ -847,4 +847,27 @@ test_expect_success 'reader notices too-small oid fanout chunk' '
 	test_cmp expect.err err
 '
 
+test_expect_success 'reader notices fanout/lookup table mismatch' '
+	check_corrupt_chunk OIDF 1020 "FFFFFFFF" &&
+	cat >expect.err <<-\EOF &&
+	error: commit-graph oid table and fanout disagree on size
+	EOF
+	test_cmp expect.err err
+'
+
+test_expect_success 'reader notices out-of-bounds fanout' '
+	# Rather than try to corrupt a specific hash, we will just
+	# wreck them all. But we cannot just set them all to 0xFFFFFFFF or
+	# similar, as they are used for hi/lo starts in a binary search (so if
+	# they are identical, that indicates that the search should abort
+	# immediately). Instead, we will give them high values that differ by
+	# 2^24, ensuring that any that are used would cause an out-of-bounds
+	# read.
+	check_corrupt_chunk OIDF 0 $(printf "%02x000000" $(test_seq 0 254)) &&
+	cat >expect.err <<-\EOF &&
+	error: commit-graph fanout values out of order
+	EOF
+	test_cmp expect.err err
+'
+
 test_done
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 06bb897f02..55b5765e2d 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -317,7 +317,7 @@ test_expect_success 'verify --shallow does not check base contents' '
 		cd verify-shallow &&
 		git commit-graph verify &&
 		base_file=$graphdir/graph-$(head -n 1 $graphdir/commit-graph-chain).graph &&
-		corrupt_file "$base_file" 1000 "\01" &&
+		corrupt_file "$base_file" 1500 "\01" &&
 		git commit-graph verify --shallow &&
 		test_must_fail git commit-graph verify 2>test_err &&
 		grep -v "^+" test_err >err &&
@@ -391,10 +391,10 @@ test_expect_success 'verify across alternates' '
 		test_commit extra &&
 		git commit-graph write --reachable --split &&
 		tip_file=$graphdir/graph-$(tail -n 1 $graphdir/commit-graph-chain).graph &&
-		corrupt_file "$tip_file" 100 "\01" &&
+		corrupt_file "$tip_file" 1500 "\01" &&
 		test_must_fail git commit-graph verify --shallow 2>test_err &&
 		grep -v "^+" test_err >err &&
-		test_i18ngrep "commit-graph has incorrect fanout value" err
+		test_i18ngrep "incorrect checksum" err
 	)
 '
 
-- 
2.42.0.884.g35e1fe1a6a

