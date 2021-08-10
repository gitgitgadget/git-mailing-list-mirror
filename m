Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47327C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 01:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2531660EDF
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 01:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhHJBCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 21:02:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:42950 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231794AbhHJBCO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 21:02:14 -0400
Received: (qmail 4595 invoked by uid 109); 10 Aug 2021 01:01:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Aug 2021 01:01:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4052 invoked by uid 111); 10 Aug 2021 01:01:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Aug 2021 21:01:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Aug 2021 21:01:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Xingman Chen <xichixingman@gmail.com>
Subject: [PATCH] apply: keep buffer/size pair in sync when parsing binary
 hunks
Message-ID: <YRHQAFDXs5xvyDND@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We parse through binary hunks by looping through the buffer with code
like:

    llen = linelen(buffer, size);

    ...do something with the line...

    buffer += llen;
    size -= llen;

However, before we enter the loop, there is one call that increments
"buffer" but forgets to decrement "size". As a result, our "size" is off
by the length of that line, and subsequent calls to linelen() may look
past the end of the buffer for a newline.

The fix is easy: we just need to decrement size as we do elsewhere.

This bug goes all the way back to 0660626caf (binary diff: further
updates., 2006-05-05). Presumably nobody noticed because it only
triggers if the patch is corrupted, and even then we are often "saved"
by luck. We use a strbuf to store the incoming patch, so we overallocate
there, plus we add a 16-byte run of NULs as slop for memory comparisons.
So if this happened accidentally, the common case is that we'd just read
a few uninitialized bytes from the end of the strbuf before producing
the expected "this patch is corrupted" error complaint.

However, it is possible to carefully construct a case which reads off
the end of the buffer. The included test does so. It will pass both
before and after this patch when run normally, but using a tool like
ASan shows that we get an out-of-bounds read before this patch, but not
after.

Reported-by: Xingman Chen <xichixingman@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
This was reported to the security list, but I think the impact is small
enough to just take it as a normal fix.

I hate the test, as it is brittle and subject to bitrot if we do things
like change the default strbuf hint size. If that does happen, it will
still pass; it just won't do anything interesting. But I would like some
record of how to reproduce, and I prefer this to putting something
hard-to-run in the commit message.

 apply.c                 |  1 +
 t/t4103-apply-binary.sh | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/apply.c b/apply.c
index 44bc31d6eb..4ed4b27169 100644
--- a/apply.c
+++ b/apply.c
@@ -1917,6 +1917,7 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
 
 	state->linenr++;
 	buffer += llen;
+	size -= llen;
 	while (1) {
 		int byte_length, max_byte_length, newsize;
 		llen = linelen(buffer, size);
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index fad6d3f542..d370ecfe0d 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -158,4 +158,27 @@ test_expect_success 'apply binary -p0 diff' '
 	test -z "$(git diff --name-status binary -- file3)"
 '
 
+test_expect_success 'reject truncated binary diff' '
+	do_reset &&
+
+	# this length is calculated to get us very close to
+	# the 8192-byte strbuf we will use to read in the patch.
+	test-tool genrandom foo 6205 >file1 &&
+	git diff --binary >patch &&
+
+	# truncate the patch at the second "literal" line,
+	# but exclude the trailing newline. We must use perl
+	# for this, since tools like "sed" cannot reliably
+	# produce output without the trailing newline.
+	perl -pe "
+		if (/^literal/ && \$count++ >= 1) {
+			chomp;
+			print;
+			exit 0;
+		}
+	" <patch >patch.trunc &&
+
+	do_reset &&
+	test_must_fail git apply patch.trunc
+'
 test_done
-- 
2.33.0.rc1.475.g023efe0ae4
