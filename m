Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846061F954
	for <e@80x24.org>; Thu, 23 Aug 2018 16:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeHWTmO (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 15:42:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:53398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726118AbeHWTmO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 15:42:14 -0400
Received: (qmail 13882 invoked by uid 109); 23 Aug 2018 16:11:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 16:11:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12384 invoked by uid 111); 23 Aug 2018 16:11:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 23 Aug 2018 12:11:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2018 12:11:51 -0400
Date:   Thu, 23 Aug 2018 12:11:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org
Subject: Re: [PATCH v2 1/2] tests: fix and add lint for non-portable head -c N
Message-ID: <20180823161150.GA29579@sigill.intra.peff.net>
References: <20180823091427.1756-1-avarab@gmail.com>
 <20180823152502.3886-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180823152502.3886-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 23, 2018 at 03:25:01PM +0000, Ævar Arnfjörð Bjarmason wrote:

> The "head -c BYTES" option is non-portable (not in POSIX[1]). Change
> such invocations to use the test_copy_bytes wrapper added in
> 48860819e8 ("t9300: factor out portable "head -c" replacement",
> 2016-06-30).
> 
> This fixes a test added in 9d2e330b17 ("ewah_read_mmap: bounds-check
> mmap reads", 2018-06-14), which has been breaking
> t5310-pack-bitmaps.sh on OpenBSD since 2.18.0. The OpenBSD ports
> already have a similar workaround after their upgrade to 2.18.0[2].

Heh, I even considered using this when writing that test. But the reason
I introduced test_copy_bytes is not because the target platform did not
have "head -c" at all, but because some tests need very specific
buffering guarantees when reading from a shared pipe.

That said, if OpenBSD's "head" doesn't have "-c" at all, I'm fine with
this as a fix (and it sounds like we know that IRIX lacks it, too).

> Also, change a valgrind-specific codepath in test-lib.sh to use this
> wrapper. Given where valgrind runs I don't think this would ever
> become a portability issue in practice, but it's easier to just use
> the wrapper than introduce some exception for the "make test-lint"
> check being added here.

When working on 9d2e330b17, I recall finding these other "head -c"
invocations in the test suite when I did 9d2e330b17 and took them as
evidence that it was OK to use in vanilla cases. So even if these sites
don't affect any platforms in practice, I think it's worth it to ban
"head -c" completely.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/check-non-portable-shell.pl | 1 +
>  t/t5310-pack-bitmaps.sh       | 2 +-
>  t/test-lib.sh                 | 4 ++--
>  3 files changed, 4 insertions(+), 3 deletions(-)

Patch itself looks good to me. Thanks.

-Peff
