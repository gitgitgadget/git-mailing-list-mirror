Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC51C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC34611CA
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhIOR0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 13:26:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:48222 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhIOR0M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 13:26:12 -0400
Received: (qmail 32605 invoked by uid 109); 15 Sep 2021 17:24:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 17:24:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25834 invoked by uid 111); 15 Sep 2021 17:24:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 13:24:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 13:24:52 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] t1400: avoid SIGPIPE race condition on fifo
Message-ID: <YUIsZCTqm56KfilP@coredump.intra.peff.net>
References: <1e9e62a2c5f74db91aaded83783076c28b757836.1630659922.git.ps@pks.im>
 <YUIptJNN5DxrkydV@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUIptJNN5DxrkydV@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 01:13:25PM -0400, Jeff King wrote:

> I think this test may be racy. I saw a strange failure from it in CI:
> 
>   https://github.com/peff/git/runs/3605506649?check_suite_focus=true#step:5:6734
> 
> I can't reproduce the problem locally with "--stress", but the failure
> there is on macOS (and likewise, a nearby run failed with a timeout just
> for macOS, which could be caused by a racy deadlock).

Ah, I just wasn't trying hard enough. Using --run=1,190 lets it run a
lot more tightly, and I got a failure pretty quickly. Here's the fix (on
top of ps/update-ref-batch-flush).

-- >8 --
Subject: [PATCH] t1400: avoid SIGPIPE race condition on fifo

t1400.190 sometimes fails or even hangs because of the way it uses
fifos. Our goal is to interactively read and write lines from
update-ref, so we have two fifos, in and out. We open a descriptor
connected to "in" and redirect output to that, so that update-ref does
not see EOF as it would if we opened and closed it for each "echo" call.

But we don't do the same for the output. This leads to a race where our
"read response <out" has not yet opened the fifo, but update-ref tries
to write to it and gets SIGPIPE. This can result in the test failing, or
worse, hanging as we wait forever for somebody to write to the pipe.

This is the same proble we fixed in 4783e7ea83 (t0008: avoid SIGPIPE
race condition on fifo, 2013-07-12), and we can fix it the same way, by
opening a second long-running descriptor.

Before this patch, running:

  ./t1400-update-ref.sh --run=1,190 --stress

failed or hung within a few dozen iterations. After it, I ran it for
several hundred without problems.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1400-update-ref.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 1e754e258f..0d4f73acaa 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1603,19 +1603,21 @@ test_expect_success PIPE 'transaction flushes status updates' '
 	(git update-ref --stdin <in >out &) &&
 
 	exec 9>in &&
+	exec 8<out &&
 	test_when_finished "exec 9>&-" &&
+	test_when_finished "exec 8<&-" &&
 
 	echo "start" >&9 &&
 	echo "start: ok" >expected &&
-	read line <out &&
+	read line <&8 &&
 	echo "$line" >actual &&
 	test_cmp expected actual &&
 
 	echo "create refs/heads/flush $A" >&9 &&
 
 	echo prepare >&9 &&
 	echo "prepare: ok" >expected &&
-	read line <out &&
+	read line <&8 &&
 	echo "$line" >actual &&
 	test_cmp expected actual &&
 
@@ -1625,7 +1627,7 @@ test_expect_success PIPE 'transaction flushes status updates' '
 
 	echo commit >&9 &&
 	echo "commit: ok" >expected &&
-	read line <out &&
+	read line <&8 &&
 	echo "$line" >actual &&
 	test_cmp expected actual
 '
-- 
2.33.0.917.g33ebf6a5f6

