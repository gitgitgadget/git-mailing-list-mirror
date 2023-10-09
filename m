Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E673CD6137
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378544AbjJIVGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378663AbjJIVGK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:06:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C75D113
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:05:57 -0700 (PDT)
Received: (qmail 24470 invoked by uid 109); 9 Oct 2023 21:05:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Oct 2023 21:05:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18634 invoked by uid 111); 9 Oct 2023 21:05:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Oct 2023 17:05:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Oct 2023 17:05:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 19/20] commit-graph: detect out-of-order BIDX offsets
Message-ID: <20231009210556.GS3282181@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009205544.GA3281950@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The BIDX chunk tells us the offsets at which each commit's Bloom filters
can be found in the BDAT chunk. We compute the length of each filter by
checking the offsets of neighbors and subtracting them.

If the offsets are out of order, then we'll get a negative length, which
we then store as a very large unsigned value. This can cause us to read
out-of-bounds memory, as we access the hash data modulo "filter->len *
BITS_PER_WORD".

We can easily detect this case when loading the individual filters.

Signed-off-by: Jeff King <peff@peff.net>
---
 bloom.c              | 10 ++++++++++
 t/t4216-log-bloom.sh | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/bloom.c b/bloom.c
index 61abad7f8c..1474aa19fa 100644
--- a/bloom.c
+++ b/bloom.c
@@ -75,6 +75,16 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
 	    check_bloom_offset(g, lex_pos - 1, start_index) < 0)
 		return 0;
 
+	if (end_index < start_index) {
+		warning("ignoring decreasing changed-path index offsets"
+			" (%"PRIuMAX" > %"PRIuMAX") for positions"
+			" %"PRIuMAX" and %"PRIuMAX" of %s",
+			(uintmax_t)start_index, (uintmax_t)end_index,
+			(uintmax_t)(lex_pos-1), (uintmax_t)lex_pos,
+			g->filename);
+		return 0;
+	}
+
 	filter->len = end_index - start_index;
 	filter->data = (unsigned char *)(g->chunk_bloom_data +
 					sizeof(unsigned char) * start_index +
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index f6054cbb27..2ba0324a69 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -441,4 +441,17 @@ test_expect_success 'Bloom reader notices too-small index chunk' '
 	test_cmp expect.err err
 '
 
+test_expect_success 'Bloom reader notices out-of-order index offsets' '
+	# we do not know any real offsets, but we can pick
+	# something plausible; we should not get to the point of
+	# actually reading from the bogus offsets anyway.
+	corrupt_graph BIDX 4 0000000c00000005 &&
+	echo "warning: ignoring decreasing changed-path index offsets" \
+		"(12 > 5) for positions 1 and 2 of .git/objects/info/commit-graph" >expect.err &&
+	git -c core.commitGraph=false log -- A/B/file2 >expect.out &&
+	git -c core.commitGraph=true log -- A/B/file2 >out 2>err &&
+	test_cmp expect.out out &&
+	test_cmp expect.err err
+'
+
 test_done
-- 
2.42.0.884.g35e1fe1a6a

