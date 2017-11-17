Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84BDD202AF
	for <e@80x24.org>; Fri, 17 Nov 2017 22:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936672AbdKQWMy (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 17:12:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:32986 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S936669AbdKQWMx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 17:12:53 -0500
Received: (qmail 9336 invoked by uid 109); 17 Nov 2017 22:12:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Nov 2017 22:12:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28922 invoked by uid 111); 17 Nov 2017 22:13:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 17 Nov 2017 17:13:07 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Nov 2017 17:12:51 -0500
Date:   Fri, 17 Nov 2017 17:12:51 -0500
From:   Jeff King <peff@peff.net>
To:     Gennady Kupava <gennady.kupava@gmail.com>
Cc:     git@vger.kernel.org, Gennady Kupava <gkupava@bloomberg.net>
Subject: Re: [PATCH] Reduce performance penalty for turned off traces
Message-ID: <20171117221251.sku6lqbemcddvlky@sigill.intra.peff.net>
References: <20171111192858.27255-1-gennady.kupava@gmail.com>
 <20171112141737.nmnsygm4wrhtkqwb@sigill.intra.peff.net>
 <CAPu-DQr0eRYiafF64=Mwm56xJgNPH0HVm+B4vKnzK0iAE4_xUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPu-DQr0eRYiafF64=Mwm56xJgNPH0HVm+B4vKnzK0iAE4_xUg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 11:24:11PM +0000, Gennady Kupava wrote:

> In reality, gcc didn't do that and I saw 3 function calls. I am pretty
> sure that compiler of the distant bright future will do that, and only
> problem would be to eliminate that single function call. Hopefully
> with -flto it will also eliminate this single functions call, at it
> will be able to see through translation units. Given that I actually
> like current implementation as it hides all details in .c file.

Yeah, I agree with your analysis that we are really just overriding what
could eventually be figured out by the compiler during LTO.

I do think this is worth pursuing in the meantime, though, because it's
not _too_ much work, and we don't know when that magical optimizing
compiler will appear. :) So this frees us up in the meantime to worry
less about the cost of tracing.

> Now, implementation you suggesting moves extra things into .h, so it
> is imperfect in terms above, while things I suggested moves only
> necessary bit of checking the necessity to do anything, which is only
> (interesting) part should be executed while traces are off, and the
> only part we really want to be inlined.

I only meant to suggest moving the necessary checking into the .h file.
It's just that we have to make it a static inline for cases where we
don't have variadic macros. Anyway, I'm OK with your original notion of
leaving the non-variadic-macro systems on the "slow" path, so we can
just go with the pure-macro thing you have.

> > So it is measurable, and we might expect that tracing a really big loop
> > (say over all of the objects in the repository) would benefit. OTOH, a
> > real loop would actually be doing other stuff, so the speedup would be
> > less dramatic. Still, it seems like an easy win.
> 
> I actually quite familiar with performance analysis and know how to
> use perf and similar tools a bit -
> so if there is something more measurable in TODO, I could try. But I
> guess this is interesting to many devs so such tasks probably already
> all done and bottlenecks are identified in git =)

There are lots of bottlenecks still to be found, I'm sure. If you want
to have a go at finding some with perf, be my guest. :)

-Peff
