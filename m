Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF5DC05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 20:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjATUPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 15:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjATUPM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 15:15:12 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D236011EB1
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 12:15:11 -0800 (PST)
Received: (qmail 25438 invoked by uid 109); 20 Jan 2023 20:15:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Jan 2023 20:15:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13589 invoked by uid 111); 20 Jan 2023 20:15:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Jan 2023 15:15:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Jan 2023 15:15:10 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] Makefile: suppress annotated leaks with certain ASan
 options
Message-ID: <Y8r2Tn75g52YTIij@coredump.intra.peff.net>
References: <b1efe56ab5193d5505ccb9334f7d15e1795c27fb.1674240261.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1efe56ab5193d5505ccb9334f7d15e1795c27fb.1674240261.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2023 at 01:46:16PM -0500, Taylor Blau wrote:

> However, it is possible to use the leak sanitizer without
> `SANITIZE=leak`. This happens when building with `SANITIZE=address` and
> enabling the leak sanitizer via the `ASAN_OPTIONS` variable (by
> including the string "detect_leaks=1").
> 
> This renders `UNLEAK()` useless when doing `SANITIZE=address` builds
> which also use the leak checker.

Yeah. I focused on LSan when adding the sanitize/unleak infrastructure
just because it was faster than a full ASan run, which made iterating on
fixes easier. I do think in the long run, once the test suite is leak
free, we may want to support leak-checking via ASan for the simple
reason that it can be done for "free" during the existing ASan
build/test, rather than requiring an extra LSan job.

I do think there's some complexity here, though.

One problem UNLEAK() is that compile-time switch, but whether ASan does
leak detection is a run-time choice. So you are stuck with either:

  - you always turn on UNLEAK() for ASan builds, in which case test runs
    using the default ASAN_OPTIONS we set do the extra work even though
    they are not doing any leak detection. I doubt it's very measurable,
    though (it's just shoving a few bytes onto a linked list),
    especially compared to the overall slowness of ASan.

  - you predicate the build-time choice on ASAN_OPTIONS. But this means
    that:

      make SANITIZE=address
      cd t
      ASAN_OPTIONS=detect_leaks=1 ./t0000-*.sh

    will confusingly fail to use UNLEAK().

Your patch does the second one, but I think the first may be the
least-bad option.

The other issue I'd worry about is optimizations. Generally you want to
use -O2 with ASan, because it speeds things up (even more than just
regular -O2, I think, because it is optimizing the ASan instrumentation
code, too). I don't know offhand of any cases where it would find or not
find cases based on optimization level, though I could believe they
exist.

But for leak-checking, we've already seen real cases where using LSan
with higher optimization levels can lead to false positives (because the
optimizer drops a value that is still in scope but not used in a code
path that leads to exit()).

So it may be that we really do want to keep leak-checking to "-O0
-fsanitize=leak", and reserve "-O2 -fsanitize=address" for finding
address bugs.

> I found this while playing around with GitHub's ASan-enabled CI builds
> for our internal fork following a merge with v2.38.3.
> 
> The check-chainlint recipe in t/Makefile started using "git diff" via
> d00113ec34 (t/Makefile: apply chainlint.pl to existing self-tests,
> 2022-09-01), which triggered a leak in some of GitHub's custom code. I
> was surprised when marking the variable with UNLEAK() didn't do the
> trick, and ended up down this rabbit hole ;-).

Yes, but I'd ask why your ASan builds were checking for leaks in the
first place. There are presumably tons of leaks they'd detect, since the
test suite is far from leak-free.

-Peff
