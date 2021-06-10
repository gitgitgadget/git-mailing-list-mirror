Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5BDC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4642E61362
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhFJQiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:38:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:51582 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFJQiR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 12:38:17 -0400
Received: (qmail 8399 invoked by uid 109); 10 Jun 2021 16:36:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 16:36:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31890 invoked by uid 111); 10 Jun 2021 16:36:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 12:36:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 12:36:19 -0400
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: UNLEAK(), leak checking in the default tests etc.
Message-ID: <YMI/g1sHxJgb8/YD@coredump.intra.peff.net>
References: <87czsv2idy.fsf@evledraar.gmail.com>
 <fcb0eaee-6ae1-f2cc-51d5-103eea64532a@ahunt.org>
 <87y2bi0vvl.fsf@evledraar.gmail.com>
 <YMIVzYgNddsR4FSd@coredump.intra.peff.net>
 <bd212451-d8f0-e041-3460-bbbff57542d8@ahunt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd212451-d8f0-e041-3460-bbbff57542d8@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 05:32:41PM +0200, Andrzej Hunt wrote:

> > I do think it would be worth splitting out ASan from leak-checking. The
> > whole suite should run clean with regular ASan already, and we'd want to
> > find regressions there even in the tests that aren't leak-clean. I do
> > periodic ASan runs already; the main argument against doing it for every
> > CI run is just that's a lot more CPU. But maybe not enough to be
> > prohibitive? It's probably still way cheaper than running the test suite
> > on Windows.
> 
> I've been running tests with ASAN in the Github Actions environment, and a
> single run takes just over 30 minutes [1] - which I believe is similar to
> the normal test jobs (they do run the test suite twice in that time I
> think).
> 
> I've been doing the same with UBSAN, and that's even faster at 15-20 minutes
> [2]. However I get the impression that ASAN issues are both more common (at
> least on seen), and more impactful - so I would argue that ASAN should be
> prioritised if there's spare capacity. (I have no idea if ASAN+UBSAN can be
> combined, but I suspect that doing so would make the tests slower?)

I routinely do SANITIZE=address,undefined since they are both useful
(and we do not trigger either in the current test suite). I never
measured the time of their combined use versus just one, but surely it's
faster the two-at-once approach is faster than running the test suite
twice.

> I'm also running LSAN tests in CI to try and catch regressions, but I've
> only enabled a handful of tests so far. My much simpler approach was to
> specify the range of tests to run as 0-X, and as we make progress on fixing
> leaks, X will slowly approach 9999 (currently we're at something like X~=5,
> although I'm not too far off sending out some patches to boost that to 99).
> The skip-tests approach seems much more useful!

Depending how fine-grained you get with skip-tests, it can create a
hassle as individual tests are removed or reordered (and now somebody
has to maintain the skip list). Doing it with whole scripts (whether
saying "these ones are OK" or "these ones are known bad") seems like
less maintenance overall. The results aren't as fine-grained, but for
something that is meant to be a transitional step, I'm not sure it's
worth the trouble to get more specific.

-Peff
