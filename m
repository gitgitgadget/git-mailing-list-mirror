Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62659C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D6B601FA
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhHPV7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:59:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:49186 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232067AbhHPV7i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:59:38 -0400
Received: (qmail 25625 invoked by uid 109); 16 Aug 2021 21:59:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 21:59:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19514 invoked by uid 111); 16 Aug 2021 21:59:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 17:59:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 17:59:05 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Max Kirillov <max@max630.net>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Message-ID: <YRrfqfzDibDegxin@coredump.intra.peff.net>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com>
 <YRaYnDR6RlgJRr/P@coredump.intra.peff.net>
 <01b401d792c9$c083e4b0$418bae10$@nexbridge.com>
 <YRqv30kTZqW9nMN0@coredump.intra.peff.net>
 <01b901d792d0$1e993950$5bcbabf0$@nexbridge.com>
 <YRretXfEfiVujSeO@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YRretXfEfiVujSeO@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 05:55:01PM -0400, Jeff King wrote:

> So ideally we'd have some way of atomically checking our flag and then
> sleeping only if it's not set. But I don't think that exists. The
> closest we can come is using a series of smaller sleeps and checks. And
> indeed, digging in the archive shows that Max already proposed such a
> patch:
> 
>   https://lore.kernel.org/git/20190218205028.32486-1-max@max630.net/
> 
> It looks like it feel through the cracks, though. Maybe now is a good
> time to resurrect it.

And here it is for convenience. I think this is worth doing, as it
avoids occasional 60-second hangs in the test suite (and I confirmed
that with the "fail if it takes more than 5 seconds" hack I showed
earlier).

-- >8 --
From: Max Kirillov <max@max630.net>
Subject: [PATCH] t5562: chunked sleep to avoid lost SIGCHILD

If was found during stress-test run that a test may hang by 60 seconds.
It supposedly happens because SIGCHILD was received before sleep has
started.

Fix by looping by smaller chunks, checking $exited after each of them.
Then lost SIGCHILD would not cause longer delay than 1 second.

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Max Kirillov <max@max630.net>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5562/invoke-with-content-length.pl | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t5562/invoke-with-content-length.pl b/t/t5562/invoke-with-content-length.pl
index 0943474af2..257e280e3b 100644
--- a/t/t5562/invoke-with-content-length.pl
+++ b/t/t5562/invoke-with-content-length.pl
@@ -29,7 +29,12 @@
 }
 print $out $body_data or die "Cannot write data: $!";
 
-sleep 60; # is interrupted by SIGCHLD
+my $counter = 0;
+while (not $exited and $counter < 60) {
+        sleep 1;
+        $counter = $counter + 1;
+}
+
 if (!$exited) {
         close($out);
         die "Command did not exit after reading whole body";
-- 
2.33.0.rc2.497.g375df73092

