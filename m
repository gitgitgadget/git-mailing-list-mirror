Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43B7A209FD
	for <e@80x24.org>; Thu, 25 May 2017 18:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942828AbdEYSWk (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 14:22:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:58006 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942906AbdEYSWg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 14:22:36 -0400
Received: (qmail 20657 invoked by uid 109); 25 May 2017 18:22:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 18:22:33 +0000
Received: (qmail 21984 invoked by uid 111); 25 May 2017 18:23:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 14:23:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 May 2017 14:22:31 -0400
Date:   Thu, 25 May 2017 14:22:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tyler Brazier <tylerbrazier@gmail.com>, git@vger.kernel.org
Subject: Re: `pull --rebase --autostash` fails when fast forward in dirty repo
Message-ID: <20170525182230.552dif62zqxuufk3@sigill.intra.peff.net>
References: <CAAZatrCaoB7EXVrCvC9RKmO02G5xcp8GPBaJefHfv7zAXVpL3Q@mail.gmail.com>
 <20170523131231.zqjkymypbilv6tyf@sigill.intra.peff.net>
 <xmqqa863jiyf.fsf@gitster.mtv.corp.google.com>
 <20170525180407.ni2oed5wk3qsd2ch@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170525180407.ni2oed5wk3qsd2ch@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 02:04:07PM -0400, Jeff King wrote:

> > ...that might be something worth thinking about---my gut feeling
> > tells me something but we should go by a measurement, not by gut
> > feeling of a random somebody.
> 
> Yeah, I'd agree. I had the impression the original change was motivated
> by gut feeling.

Hmph. On Linux, at least, I do not see that using "git merge" to
fast-forward is appreciably faster:

Here are timings for:

  git reset --hard HEAD~10 && git pull --rebase

in a git.git repo, using builds of git from various commits (all
best-of-five; the timings include the reset for simplicity, but
presumably it costs the same in each case):

  - 33b842a1e^ (just prior to the switch to git-merge)
    real  0m0.256s
    user  0m0.096s
    sys	  0m0.020s

  - 33b842a1e  (using git-merge)
    real  0m0.227s
    user  0m0.092s
    sys	  0m0.020s

So a little faster, but there seems to be 20-30ms of noise in my timings
anyway (the average for the "prior" case did seem to be higher, though).
It's possible that the difference would be more stark on Windows, where
the cost of the shell script would be higher.

The same test with the current master performs the same as 33b842a1e.
But if I then remove the optimization, as Tyler's patch did at the start
of this thread, the timings are similar to 33b842a1e^.

So I dunno. It does not seem appreciably faster, but what little speedup
it does provide is the same even with a more modern rebase. Which is
probably because that rebase isn't actually doing much in the first
place, so the optimized bits from Dscho's rebase--helper are not kicking
in yet.

Anyway. All this has shown me is that it's probably pointless to do this
timing at all on Linux. Somebody on Windows might get better results.

But regardless, we need to do something. Correctness must trump
optimizations, and the question is whether we can throw out the whole
conditional, or if we should just restrict when it kicks in.

-Peff
