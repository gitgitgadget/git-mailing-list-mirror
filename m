Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28FA01FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 15:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933062AbcGLPfa (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 11:35:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:43525 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932083AbcGLPf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 11:35:29 -0400
Received: (qmail 8212 invoked by uid 102); 12 Jul 2016 15:35:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 11:35:24 -0400
Received: (qmail 3647 invoked by uid 107); 12 Jul 2016 15:35:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jul 2016 11:35:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2016 11:35:20 -0400
Date:	Tue, 12 Jul 2016 11:35:20 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.9.1
Message-ID: <20160712153520.GG613@sigill.intra.peff.net>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com>
 <87lh17kgdy.fsf@linux-m68k.org>
 <20160711235417.GA26163@sigill.intra.peff.net>
 <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607120927410.6426@virtualbox>
 <xmqqpoqj6i3d.fsf@gitster.mtv.corp.google.com>
 <20160712151630.GE613@sigill.intra.peff.net>
 <CAPc5daWcb5bfgsxMP0vCrQ7gBdeYBgefzPNHztaaCKzqbCv2aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPc5daWcb5bfgsxMP0vCrQ7gBdeYBgefzPNHztaaCKzqbCv2aQ@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 08:25:51AM -0700, Junio C Hamano wrote:

> On Tue, Jul 12, 2016 at 8:16 AM, Jeff King <peff@peff.net> wrote:
> >>
> >> But moving the internal time representation used in various fields
> >> like commit->date to time_t is likely to be a wrong thing to do,
> >> because the first problem with "unsigned long", i.e. "may not be
> >> wide enough", is not limited to "not wide enough to hold time_t".
> >> It also includes "it may not be wide enough to hold time somebody
> >> else recorded in existing objects".
> >
> > But that's a problem no matter what size we choose.
> 
> Yes, if somebody's time_t is larger than my intmax_t, the problem
> cannot be solved for me, if that timestamp is too far in the future or
> in the past.

I am less worried about their time_t and more about whatever crap they
write in ascii into their objects. :)

> But that is not the problem I am pointing out. I heard earlier in the
> thread that time_t on one system was 32-bit (was it Linux?) but I think
> they have "long long". Choosing time_t is strictly inferior choice when
> we already know that a platform with not-wide-enough time_t need to
> be supported, and a type that is wider than that is available.

I am not certain that there is a modern system with 32-bit time_t. We
know there are systems with 32-bit unsigned long, and I think that is
what produced the results people saw. I'd expect even 32-bit systems to
use "int64_t" or similar for their time_t these days.

I'm also not convinced that we would be helping much to carry around a
wider gittime_t. Most of the display code ends up touching a system time
function one way or another, so I find it unlikely it would produce much
better output.

It would help for simple cases like commit->date where we really do just
parse it into a number and never do more with it. But...

> I was envisioning that we would have typedef <sometime> gittime_t
> with conversion helpers between it and time_t that allow us to do some
> range checks while at it.

I guess I am just willing to trust that time_t is basically that. And if
your platform has a grossly undersized time_t, then too bad, we clamp
everything it can't hold to 2038 or whatever, and hopefully your
terrible platform dies out or gets a clue sometime in the next 20 years.

-Peff
