Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8129D1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 06:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeJROf7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 10:35:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:44398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727328AbeJROf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 10:35:59 -0400
Received: (qmail 15433 invoked by uid 109); 18 Oct 2018 06:36:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Oct 2018 06:36:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27455 invoked by uid 111); 18 Oct 2018 06:35:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Oct 2018 02:35:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2018 02:36:29 -0400
Date:   Thu, 18 Oct 2018 02:36:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ben Peart <peartben@gmail.com>, Git List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v1 1/2] reset: don't compute unstaged changes after reset
 when --quiet
Message-ID: <20181018063628.GA23537@sigill.intra.peff.net>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181017164021.15204-2-peartben@gmail.com>
 <CAPig+cSiE-M9QMch4WE7y4cib1FBUNiaR2pGGtbDuqiz6juhaw@mail.gmail.com>
 <20181017182255.GC28326@sigill.intra.peff.net>
 <xmqqpnw7vs5b.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnw7vs5b.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 12:40:48PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Whereas for the new config variable, you'd probably set it not because
> > you want it quiet all the time, but because you want to get some time
> > savings. So there it does make sense to me to explain.
> >
> > Other than that, this seems like an obvious and easy win. It does feel a
> > little hacky (you're really losing something in the output, and ideally
> > we'd just be able to give that answer quickly), but this may be OK as a
> > hack in the interim.
> 
> After "git reset --quiet -- this/area/" with this change, any
> operation you'd do next that needs to learn if working tree files
> are different from what is recorded in the index outside that area
> will have to spend more cycles, because the refresh done by "reset"
> is now limited to the area.  So if your final goal is "make 'reset'
> as fast as possible", this is an obvious and easy win.  For other
> goals, i.e. "make the overall experience of using Git feel faster",
> it is not so obvious to me, though.
> 
> If we somehow know that it is much less important in your setup that
> the cached stat bits in the index is kept up to date (e.g. perhaps
> you are more heavily relying on fsmonitor and are happy with it),
> then I suspect that we could even skip the refreshing altogether and
> gain more performance, without sacrificing the "overall experience
> of using Git" at all, which would be even better.

Yeah, I assumed that Ben was using fsmonitor. I agree if we can just use
that to make this output faster, that would be the ideal. This is the
"later the message would get faster to produce" I hinted at in my
earlier message.

So I think we are in agreement. It just isn't clear to me how much work
it would take to get to the "ideal". If it's long enough, then this kind
of hackery may be useful in the meantime.

-Peff
