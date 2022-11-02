Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7C4C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 08:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiKBImS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 04:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiKBImQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 04:42:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692624954
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 01:42:14 -0700 (PDT)
Received: (qmail 9713 invoked by uid 109); 2 Nov 2022 08:42:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Nov 2022 08:42:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3593 invoked by uid 111); 2 Nov 2022 08:42:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Nov 2022 04:42:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Nov 2022 04:42:13 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 2/2] t5551: be less strict about the number of credential
 warnings
Message-ID: <Y2ItZWx+kBmTreGQ@coredump.intra.peff.net>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
 <221101.86a65b5q9q.gmgdl@evledraar.gmail.com>
 <Y2GHjnuyuwGpY3II@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2GHjnuyuwGpY3II@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 04:54:38PM -0400, Taylor Blau wrote:

> > The tests aren't just asserting the bad behavior, they're also ensuring
> > that it doesn't get worse. 1 warning is ideal, 2-3 is bad, but
> > tolerable, but if we start emitting 500 of these it would be nice to
> > know.
> 
> I admit that this kind of argument does not sway me.
> 
> Is it likely that we would suddenly start spewing 500 such warnings? If
> we did, are there no other tests that would catch it? And even if *that*
> were the case, would nobody happen to notice it in the meantime either
> during development or when we queue an affected topic onto 'next' for
> wider testing?
> 
> I guess the answer is that it's possible that we'd miss such a
> regression in all of those above places, but to me it seems extremely
> unlikely that we'd let such a regression through without noticing.

Like you, I don't find much value in asserting "2 or 3, but not 500".
But it is easy enough to at least only loosen the few cases that need
it.

So here's a replacement for 2/2 that does the minimal thing. I rewrote
the commit message to explain my view (incidentally, it also fixes the
subject line, which mentioned the wrong test number after the rebase).

As I said, I had tried to mostly leave patch 2 alone to avoid derailing
Dscho's attempt to fix things. But somehow things got derailed anyway,
so maybe we can just all agree on this patch and move on with our lives?
I can't over-emphasize how little I care about this credentialsInUrl
feature in the first place, and somehow it has consumed hours of my life
now.

-- >8 --
Subject: t5551: be less strict about the number of credential warnings

It is unclear as to _why_, but under certain circumstances the warning
about credentials being passed as part of the URL seems to be swallowed
by the `git remote-https` helper in the Windows jobs of Git's CI builds.

This causes the tests to fail, because they assert that in a few cases
we should print the warning 2 or even 3 times. The reason for that is
given in 6dcbdc0d66 (remote: create fetch.credentialsInUrl config,
2022-06-06), which is that multiple processes are involved, and each
warns.

In an ideal world, the user would just see the message once per logical
operation; they don't care how many underlying processes are involved.
And we may fix that eventually. But in the meantime, let's loosen the
tests to just assert that the user sees the message _at least_ once.

This won't catch a case where we accidentally start producing it 500
times, but that's not a likely regression. A more likely thing is that
we'd start producing it four times because the underlying code changes
to use a new process. But that's exactly the kind of thing we'd prefer
to be ignoring in the tests.

Note that the tests for the "die" mode don't need adjusted. They die
immediately in the first process that sees the problem, so they
consistently show the error once. It's only the "warn" mode which must
be loose. If we eventually fix it, then we can tighten its assertion. In
the meantime, this works around the CI issues.

Based on a patch by Johannes Schindelin.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index bbe3d5721f..4f559722f4 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -597,7 +597,7 @@ test_expect_success 'clone warns or fails when using username:password' '
 	git -c transfer.credentialsInUrl=warn \
 		clone $url_userpass attempt2 2>err &&
 	grep "warning: $message" err >warnings &&
-	test_line_count = 2 warnings &&
+	test_line_count -ge 1 warnings &&
 
 	test_must_fail git -c transfer.credentialsInUrl=die \
 		clone $url_userpass attempt3 2>err &&
@@ -630,7 +630,7 @@ test_expect_success 'fetch warns or fails when using username:password' '
 
 	git -c transfer.credentialsInUrl=warn fetch $url_userpass 2>err &&
 	grep "warning: $message" err >warnings &&
-	test_line_count = 3 warnings &&
+	test_line_count -ge 1 warnings &&
 
 	test_must_fail git -c transfer.credentialsInUrl=die \
 		fetch $url_userpass 2>err &&
-- 
2.38.1.677.g9b1428ac2e

