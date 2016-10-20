Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD82B20987
	for <e@80x24.org>; Thu, 20 Oct 2016 11:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755817AbcJTLjN (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 07:39:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:59979 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752975AbcJTLjM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 07:39:12 -0400
Received: (qmail 3922 invoked by uid 109); 20 Oct 2016 11:39:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 11:39:05 +0000
Received: (qmail 26089 invoked by uid 111); 20 Oct 2016 11:39:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Oct 2016 07:39:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2016 07:39:03 -0400
Date:   Thu, 20 Oct 2016 07:39:03 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Drastic jump in the time required for the test suite
Message-ID: <20161020113903.tx6aqkhc2g25ba3p@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610191049040.3847@virtualbox>
 <xmqqbmygmehv.fsf@gitster.mtv.corp.google.com>
 <20161019205638.m3ytxozzmeh47ml2@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610201218060.3264@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610201218060.3264@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 12:50:32PM +0200, Johannes Schindelin wrote:

> That reflects my findings, too. I want to add that I found preciously
> little difference between running slow-to-fast and running in numeric
> order, so I gave up on optimizing on that front.

Interesting. It makes a 10-15% difference here.

I also point "--root" at a ram disk. The tests are very I/O heavy and
sometimes fsync; even on a system with an SSD, this saves another ~10%.

I know that's small potatoes compared to the Windows vs Linux times, but
it might be worth exploring.

> Further, I found that the Subversion tests (which run at the end) are so
> close in their running time that running the tests in parallel with -j5
> does not result in any noticeable improvement when reordered.

I normally don't run the Subversion tests at all. Installing cvs, cvsps,
subversion, and libsvn-perl nearly doubles the runtime of the test suite
for me (I imagine adding p4 to the mix would bump it further). While
it's certainly possible to break them with a change in core git, it
doesn't seem like a good tradeoff if I'm not touching them often.

As the GfW maintainer, you probably should be running them, at least
before a release. But cutting them might be a good way to speed up your
day-to-day runs.

I also use -j16 on a quad-core (+hyperthreads) machine, which I arrived
at experimentally. At least on Linux, it's definitely worth having more
threads than processors, to keep the processors busy.

> I guess I will have to bite into the sour apple and try to profile, say,
> t3404 somehow, including all the shell scripting stuff, to identify where
> exactly all that time is lost. My guess is that it boils down to
> gazillions of calls to programs like expr.exe or merely subshells.

I'm not so sure it isn't gazillions of calls to git. It is testing
rebase, after all, which is itself a shell script. GIT_TRACE_PERFORMANCE
gives sort of a crude measure; it reports only builtins (so it will
underestimate the total time spent in git), but it also doesn't make
clear which programs call which, so some times are double-counted (if a
builtin shells out to another builtin). But:

  $ export GIT_TRACE_PERFORMANCE=/tmp/foo.out
  $ rm /tmp/foo.out
  $ time ./t3404-rebase-interactive.sh
  real    0m29.755s
  user    0m1.444s
  sys     0m2.268s

  $ perl -lne '
      /performance: ([0-9.]+)/ and $total += $1;
      END { print $total }
    ' /tmp/foo.out
  32.851352624

Clearly that's not 100% accurate, as it claims we spent longer in git
than the script actually took to run. Given the caveats above, I'm not
even sure if it is in the right ballpark. But there are 11,000 git
builtins run as part of that script. Even at 2ms each, that's still most
of the time going to git.

And obviously the fix involves converting git-rebase, which you're
already working on. But it's not clear to me that the test
infrastructure or shell scripts are the primary cause of the slowness in
this particular case.

-Peff
