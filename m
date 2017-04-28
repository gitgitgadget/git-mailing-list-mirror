Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85F0B207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 21:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2993427AbdD1Vtm (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 17:49:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:42035 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2993368AbdD1Vtk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 17:49:40 -0400
Received: (qmail 30089 invoked by uid 109); 28 Apr 2017 21:49:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 21:49:37 +0000
Received: (qmail 25585 invoked by uid 111); 28 Apr 2017 21:50:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 17:50:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 17:49:34 -0400
Date:   Fri, 28 Apr 2017 17:49:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] add SWAP macro
Message-ID: <20170428214934.tuqihgch6qeen3ni@sigill.intra.peff.net>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <20170424112928.rty5xejep4mnxph2@sigill.intra.peff.net>
 <070a4b85-98e0-12a4-6c9c-557f3dfa733c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <070a4b85-98e0-12a4-6c9c-557f3dfa733c@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 07:04:51PM +0200, René Scharfe wrote:

> > What should:
> > 
> >    SWAP(foo[i], foo[j]);
> > 
> > do when i == j? With this code, it ends up calling
> > 
> >    memcpy(&foo[i], &foo[j], ...);
> > 
> > which can cause valgrind to complain about overlapping memory. I suspect
> > in practice that noop copies are better off than partial overlaps, but I
> > think it does still violate the standard.
> > 
> > Is it worth comparing the pointers and bailing early?
> 
> Hmm, so swapping a value with itself can be a useful thing to do?
> Otherwise an assert would be more appropriate.

No, I doubt that it's useful, and it's probably a sign of a bug
elsewhere. But it's likely a _harmless_ bug, so it may be irritating to
die when we hit it rather than continuing.

I dunno. I could go either way. Or we could leave it as-is, and let
valgrind find the problem. That has zero run-time cost, but of course
nobody bothers to run valgrind outside of the test suite, so the inputs
are not usually very exotic.

> Swapping with *partial* overlap sounds tricky, or even evil.  If
> we want to support that for some reason we'd have to use memmove
> in the middle.  But that would still corrupt at least one of the
> objects, wouldn't it?

Yes, the overlap case is probably an actual bug. Detecting it is a bit
harder, but definitely possible. I hate to pay the run-time cost for it,
but I wonder if a compiler could optimize it out.

> The line in question is this one:
> 
> 	for (i = 0; i <= (j = (queue->nr - 1) - i); i++)
> 
> Assignment in the middle?  Hmm.  Why not do it like this?
> 
> 	for (i = 0, j = queue->nr - 1; i < j; i++, j--)
> 
> Looks less complicated to me.

Yes, see my other reply. :)

-Peff
