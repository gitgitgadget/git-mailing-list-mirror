Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1FEC49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 15:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED76613DC
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 15:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhFXPzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 11:55:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:59528 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232390AbhFXPzU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 11:55:20 -0400
Received: (qmail 12285 invoked by uid 109); 24 Jun 2021 15:53:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 15:53:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13632 invoked by uid 111); 24 Jun 2021 15:53:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jun 2021 11:53:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Jun 2021 11:52:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        szeder.dev@gmail.com, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: t5324-split-commit-graph.sh flaky due to assumptions about
 ulimit behavior
Message-ID: <YNSqW3G5Sc/gBWAs@coredump.intra.peff.net>
References: <cover.1587677671.git.me@ttaylorr.com>
 <2b8ee726690861405f41adede5582b96749e98c5.1587677671.git.me@ttaylorr.com>
 <87im231sj6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im231sj6.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 24, 2021 at 11:51:09AM +0200, Ævar Arnfjörð Bjarmason wrote:

> I.e. here we do an "ulimit -n 32" and then run a command, which makes a
> lot of assumptions about how git is compiled, starts up etc, a lot of
> which are outside of our control and up to the OS. It's not 32 files we
> open, but 32 everything. When I could reproduce this it was failing on
> opening some libpcre file or other, so maybe I linked to one too many
> libraries.
> 
> The one other test that uses this pattern seems like it could be
> similarly affected, but I haven't had that fail: d415ad022d8
> (update-ref: test handling large transactions properly, 2015-04-14)
> 
> Since I can't reproduce this anymore maybe I'm reporting a
> nothingburger. I just wonder if this can really work reliably in the
> general case, and whether a reliably version of this pattern doesn't
> need to be one/some of:
> 
>  1. Some GIT_TEST_* mode that sets the (unportable) ulimit itself in the
>     code, after we reach some point. This is how e.g. web-based REPLs
>     often work, load all your known libraries, forbid any file openings
>     (or just N number) after that.
> 
>  2. Ditto, but have the GIT_TEST_* print to stderr if we reach some
>     "checkpoint", have the test only run under limit N if we can reach
>     that point (i.e. binary search or brute force to find the exact N
>     limit).
> 
>  3. Maybe we can assume this would work reliably in cases of a really
>     high limit of N, i.e. the d415ad022d8 test doesn't do this, but my
>     understanding of it is that we're trying to guard against having all
>     loose refs opened at once. So if we create e.g. 2k refs and operate
>     on them we can set the limit to "1999".
> 
>     That's still assuming the same things about ulimit that make/made
>     this test flaky, but we can probably safely assume that just getting
>     to "git <something>" being invoked won't open >1k files, but maybe
>     not >32.

Yes, we could probably just set the "32" a bit higher. Something like
"128" may be more conservative. I'd be hesitant to go as high as
something like 1999; system defaults are often much lower than that
anyway and may get rejected. We may have to adjust the tests to match
the idea of what's "a lot of descriptors". (Likewise, the "ulimit -s"
stuff has to make the same guess).

The prereq also tries running with the lower ulimit, but it only runs
"true". Perhaps running something like "git version" would give us a
more realistic idea of the baseline for running a git command (in which
case the test would be auto-skipped if somehow 32 descriptors isn't
enough on some system). That's not foolproof, though (it might take 31
to run "git version", but 33 to run "update-ref" or something).

I'm willing to let it lie unless you have a current problem. This is all
known to be guesswork/heuristics, and the hope was that it simply
wouldn't come up. If it's causing even occasional pain we might need to
deal with it. But if it's an ephemeral thing that maybe went away, I'm
content to stick my fingers back in my ears. :)

-Peff
