Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB461F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbeHBVXL (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:23:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:40840 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728226AbeHBVXL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:23:11 -0400
Received: (qmail 24042 invoked by uid 109); 2 Aug 2018 19:30:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 19:30:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27343 invoked by uid 111); 2 Aug 2018 19:30:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 15:30:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 15:30:38 -0400
Date:   Thu, 2 Aug 2018 15:30:38 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] color: protect against out-of-bounds array
 access/assignment
Message-ID: <20180802193038.GB28962@sigill.intra.peff.net>
References: <20180802093208.27420-1-sunshine@sunshineco.com>
 <nycvar.QRO.7.76.6.1808021438460.71@tvgsbejvaqbjf.bet>
 <xmqqftzw3c21.fsf@gitster-ct.c.googlers.com>
 <CAPig+cQyYRvF5QkJRUi6W2LiOo_poxWyJw9dn+FOimb1ryX8Mg@mail.gmail.com>
 <xmqq8t5o1shl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8t5o1shl.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 02, 2018 at 12:24:54PM -0700, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Thu, Aug 2, 2018 at 1:37 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> > ACK!
> >>
> >> Did you write a buggy caller that would have been caught or helped
> >> with this change?  You did not write the callee that is made more
> >> defensive with this patch, so I am being curious as to where that
> >> Ack is coming from (I wouldn't have felt curious if this were
> >> a reviewed-by instead).
> >
> > The code being made more defensive with this patch was authored by Dscho[1].
> >
> > [1]: 295d949cfa (color: introduce support for colorizing stderr, 2018-04-21)
> 
> Ah, OK.  The original by Peff done long time ago didn't check three
> fds separately, but just did a single check_auto_color() implicitly
> only for the standard output.

Right. Technically Eric's check could go into the "if (...AUTO)"
conditional, since that was what was touched in 295d949cfa. But I doubt
it matters for performance (and if it did, we should probably be
coalescing all of these conditionals into a single cached int flag).

> Come to think of it, would want_color_fd(0, var) ever make sense?

No, it's just there because of 0-indexing. The BUG() check could
actually be "if (fd < 1 || ...)" to cover that (it "works", but it is
nonsensical).

Or we could even use "fd - 1" as the index. But it is probably not worth
the effort.

-Peff
