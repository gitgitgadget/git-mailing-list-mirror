Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80A0B20A10
	for <e@80x24.org>; Thu, 28 Sep 2017 22:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbdI1WTm (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 18:19:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:53934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751349AbdI1WTm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 18:19:42 -0400
Received: (qmail 1895 invoked by uid 109); 28 Sep 2017 22:19:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 22:19:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31580 invoked by uid 111); 28 Sep 2017 22:20:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 18:20:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Sep 2017 18:19:39 -0400
Date:   Thu, 28 Sep 2017 18:19:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH Outreachy] mru: use double-linked list from list.h
Message-ID: <20170928221939.zxssv7jlzes56tq7@sigill.intra.peff.net>
References: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
 <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <xmqq8tgz13x7.fsf@gitster.mtv.corp.google.com>
 <20170928204705.7ixxspiflmhsdh7d@sigill.intra.peff.net>
 <xmqq4lrm1o8j.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lrm1o8j.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 29, 2017 at 06:56:28AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But I also think this patch may be a stepping stone to dropping "struct
> > mru" entirely, and just pushing a "struct list_head mru" into the
> > packed_git object itself (or of course any object you like). At which
> > point we'd just directly use the list iterators anyway.
> 
> The endgame state implied by your statement would mean that we won't
> have mru_mark() and instead have these open-coded in terms of the
> two calls into the list API.  There only are two callers of it in
> the current system, so it is not the end of the world, so I guess I
> can agree that this is a good preparation step toward the longer
> term goal, which says "mru API is over-engineered and what it offers
> over the plain vanilla list API is almost never used except for a
> few callsite; let's remove it and use the bare list API instead".

Thanks, that last sentence is a good summary of my thinking (I think
what I find most silly about it is that it allocates a whole extra
struct per item, which is where most of the complication comes from).

I had envisioned leaving mru_mark() as a wrapper for "move to the front"
that could operate on any list. But seeing how Olga's patch takes it
down to two trivial lines, I'd also be fine with an endgame that just
eliminates it.

> > I'd make the same claims here as above (both that I agree your proposed
> > interface looks nicer, but also that I think we eventually do want to
> > expose that this is tightly coupled with list.h).
> 
> I agree.  I just do not yet know if I fully embrace the idea that we
> just should use bare list API, getting rid of the mru API.

Fair enough.

-Peff
