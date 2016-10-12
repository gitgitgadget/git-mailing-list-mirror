Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B38207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 17:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755656AbcJLR03 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 13:26:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:56563 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754963AbcJLR00 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 13:26:26 -0400
Received: (qmail 16430 invoked by uid 109); 12 Oct 2016 17:26:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 17:26:08 +0000
Received: (qmail 22584 invoked by uid 111); 12 Oct 2016 17:26:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Oct 2016 13:26:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2016 13:26:06 -0400
Date:   Wed, 12 Oct 2016 13:26:06 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] trailer: use singly-linked list, not doubly
Message-ID: <20161012172605.tudfyg657cn4e5sj@sigill.intra.peff.net>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <8e12e0954f0a23d7c7905c58a3f7d8084d9338be.1476232683.git.jonathantanmy@google.com>
 <CAP8UFD03sOgVVb5-VEgHxHaXBBUPJ9UTB0=Y=th8YnUCk+Aa4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD03sOgVVb5-VEgHxHaXBBUPJ9UTB0=Y=th8YnUCk+Aa4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 05:38:14PM +0200, Christian Couder wrote:

> On Wed, Oct 12, 2016 at 3:23 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> > Use singly-linked lists (instead of doubly-linked lists) in trailer to
> > keep track of arguments (whether implicit from configuration or explicit
> > from the command line) and trailer items.
> >
> > This change significantly reduces the code length and simplifies the code.
> 
> It's true that the code can be simplified a lot by using a
> singly-linked list, but if we already had and used some generic
> functions or macros to handle doubly-linked list, I doubt there would
> be a significant simplification (as the generic code could not be
> deleted in this case).

We didn't have such generic macros when you wrote the trailer code
originally, but we do now, in list.h (they come from the kernel's
doubly-linked list implementation). I used them recently in a series and
found them pretty pleasant and complete.

Maybe it's worth trying the conversion here to see if it simplifies the
code.

> > There are now fewer pointers to be manipulated, but most trailer
> > manipulations now require seeking from beginning to end, so there might
> > be a slight net decrease in performance; however the number of trailers
> > is usually small (10 to 15 at the most) so this should not cause a big
> > impact.
> 
> By default we append new trailers at the end of the trailer list, so a
> singly-linked list is theoretically not well suited at all for
> handling trailer lists.
> 
> You say that at most there is a small number of trailers, and that may
> be true indeed for the Linux kernel and most projects these days, but
> I am not sure it is a good assumption to make in general.

I agree. As somebody who has fixed quite a number of accidentally
quadratic cases in the number of refs, width of the commit graph, etc,
over the years, these things have a way of creeping up or finding
pathological cases.

You _can_ append to a singly linked list in O(1) if you keep a tail
pointer, but I think using list.h would be even nicer.

-Peff
