Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5CAB20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 22:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbcF2WaM (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 18:30:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:38032 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751483AbcF2WaL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 18:30:11 -0400
Received: (qmail 3421 invoked by uid 102); 29 Jun 2016 22:30:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Jun 2016 18:30:11 -0400
Received: (qmail 31652 invoked by uid 107); 29 Jun 2016 22:30:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Jun 2016 18:30:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Jun 2016 18:30:07 -0400
Date:	Wed, 29 Jun 2016 18:30:07 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: topological index field for commit objects
Message-ID: <20160629223007.GA4726@sigill.intra.peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net>
 <5774426F.3090000@gmail.com>
 <20160629220049.GA4416@sigill.intra.peff.net>
 <xmqqlh1n1w84.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlh1n1w84.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 29, 2016 at 03:11:39PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes, though generation numbers can help with more questions (e.g., "what
> > is the merge base").
> 
> Hmm, how?  I have two commits, with generation number 38 and 47,
> respectively.  What generation number does the commit that is the
> merge base of these two commits?
> 
> I know we can say that 38 cannot possibly be a descendant of 47, but
> can we say anything else that is useful?

I don't think it can give you the answer immediately from those values,
but in general generation numbers help you bound actual traversals and
avoid walking down unproductive paths. So comparing 38 and 47 is not
nearly as useful as walking from 47 down to 37 and saying "I know that I
cannot possibly reach 38 by walking further".

I haven't thought hard specifically about merge bases computation, so
perhaps that is a case that isn't helped at all. It has been a while
since I've looked into this, but I recall there were some computations
that are hard to improve with bitmaps. I may also simply be
mis-remembering; in my patches generations were tightly tied to having a
packv4-style cache of commit properties that can be used rather than
inflating the commit object itself. That cache helps any time you walk
by speeding up the parse_commit() process. But it's a per-commit
speedup. It doesn't change the algorithmic complexity of what you're
doing.

-Peff
