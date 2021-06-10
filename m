Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A8C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E9F61374
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 13:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhFJNkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:40:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:51288 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhFJNkT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:40:19 -0400
Received: (qmail 7743 invoked by uid 109); 10 Jun 2021 13:38:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 13:38:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30225 invoked by uid 111); 10 Jun 2021 13:38:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 09:38:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 09:38:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Andrzej Hunt <andrzej@ahunt.org>, git@vger.kernel.org,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: UNLEAK(), leak checking in the default tests etc.
Message-ID: <YMIVzYgNddsR4FSd@coredump.intra.peff.net>
References: <87czsv2idy.fsf@evledraar.gmail.com>
 <fcb0eaee-6ae1-f2cc-51d5-103eea64532a@ahunt.org>
 <87y2bi0vvl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2bi0vvl.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 12:56:55PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > More significantly: I get the impression it's easier to do leak
> > checking using LSAN, which requires recompiling git anyway - at which
> > point you get the flag for free - so how often will people actually
> > perform leak checking with Valgrind in the first place?
> 
> *Nod*, I didn't investigate the runtime penalty you and Jeff point
> out. In any case, it seems that can also be done with valgrind exclusion
> rules and/or manually ignoring these cases in the test wrapper.

I had trouble using valgrind's exclusions; there's more discussion in
0e5bba53af (add UNLEAK annotation for reducing leak false positives,
2017-09-08), but the gist of it is that it's awkward to annotate the
point of leak, rather than the point of allocation (so you have to
provide the complete callstack to the allocation, which is a maintenance
headache).

Of course, if you find ways to make useful annotations with valgrind,
I'm all for it. We have a few in t/valgrind already.

> But maybe it's not even worth pursuing. Have you (or anyone else) tried
> e.g. benchmarking git's tests or t/perf tests where free() is defined to
> be some noop stub? I'd expect it not to matter, but maybe I'm wrong...

I haven't. Even though I originated UNLEAK(), I'm not really all that
concerned about the cost of free() in general. My motivation for
introducing it (versus adding free() calls) was mostly about convenience
(complex data structures that don't have an easy free/release function,
but also the fact that you can still access data after marking it with
unleak).

The fact that it also preempts any arguments about the performance of
calling free() was just a bonus. ;)

To be clear, I could easily be convinced by real numbers that the cost
of free() at program end matters. I am just saying I am not one of the
people who is going to argue that position in the meantime.

> I didn't know how to set that up, that seems easy enough.
> 
> This works for me:
> 
>     make CC=clang SANITIZE=address,leak CFLAGS="-00 -g"
>     (cd t && make ASAN_OPTIONS="<what you said>" [...])
> 
> I.e. it's just SANITIZE & flags that's important at compile-time. You
> doubtless knew that, mainly for my own notes & others following along.

It should Just Work with:

  make SANITIZE=leak test

for both gcc and clang. You do need ASAN_OPTIONS if you're asking ASan
to do leak-checking (since we usually suppress that for the obvious
reason that almost every test fails). I'm not sure if using both ASan
and LSan together confuses LSan there (if so, it may be reasonable for
test-lib.sh to modify its ASAN_OPTIONS setting if LSan is enabled).

> I ran it, noted the failing tests, produced a giant GIT_SKIP_TESTS list
> and hacked ci/ to run that as a new linux-clang-SANITIZE job. That messy
> WIP code is currently running at:
> https://github.com/avar/git/runs/2793150092
> 
> Wouldn't it be a good idea to have such a job and slowly work on the
> exclusion list?
> 
> E.g. I saw that t0004 failed, which was trivially fixed with a single
> strbuf_release(), and we could guard against regressions.

I don't mind that. My intent was to get the whole suite clean
eventually, and then start worrying about regressions. But that may take
a while.

I do think it would be worth splitting out ASan from leak-checking. The
whole suite should run clean with regular ASan already, and we'd want to
find regressions there even in the tests that aren't leak-clean. I do
periodic ASan runs already; the main argument against doing it for every
CI run is just that's a lot more CPU. But maybe not enough to be
prohibitive? It's probably still way cheaper than running the test suite
on Windows.

-Peff
