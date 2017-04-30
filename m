Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4BE207EB
	for <e@80x24.org>; Sun, 30 Apr 2017 03:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3000565AbdD3DMA (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 23:12:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:42339 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2992510AbdD3DL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 23:11:58 -0400
Received: (qmail 7492 invoked by uid 109); 30 Apr 2017 03:11:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 30 Apr 2017 03:11:57 +0000
Received: (qmail 32343 invoked by uid 111); 30 Apr 2017 03:12:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 29 Apr 2017 23:12:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Apr 2017 23:11:55 -0400
Date:   Sat, 29 Apr 2017 23:11:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] add SWAP macro
Message-ID: <20170430031154.qurrbdb3wqrdxd37@sigill.intra.peff.net>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <20170424112928.rty5xejep4mnxph2@sigill.intra.peff.net>
 <070a4b85-98e0-12a4-6c9c-557f3dfa733c@web.de>
 <20170428214934.tuqihgch6qeen3ni@sigill.intra.peff.net>
 <11699799-6bdf-484d-5a1c-8e8fa7981594@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11699799-6bdf-484d-5a1c-8e8fa7981594@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 29, 2017 at 08:16:17PM +0200, René Scharfe wrote:

> > I dunno. I could go either way. Or we could leave it as-is, and let
> > valgrind find the problem. That has zero run-time cost, but of course
> > nobody bothers to run valgrind outside of the test suite, so the inputs
> > are not usually very exotic.
> 
> It would be  problematic on platforms where memcpy has to erase the
> destination before writing new values (I don't know any example).
> 
> We could use two temporary buffers.  The object code is the same with
> GCC around 5 and Clang 3.2 or higher -- at least for prio-queue.c.

Hmm, yeah, that's an easy solution that covers the overlap case, too. If
the generated code is the same, that seems like it might not be bad (I
am a little sad how complex this simple swap operation is getting,
though).

> > Yes, the overlap case is probably an actual bug. Detecting it is a bit
> > harder, but definitely possible. I hate to pay the run-time cost for it,
> > but I wonder if a compiler could optimize it out.
> 
> How is it possible to arrive at such a situation?  We'd need two objects
> of the same size (we check that in SWAP) and one of them would start
> inside of the other one, i.e. the pointer difference between them would
> be a fraction of 1.  So the type system would have to be tricked into
> it, right?

Yeah, I guess it would be pretty odd. I was thinking of swapping a
struct and one of its components, but that fail the size equality check.
And anyway that would be a silly thing to do in the first place, so it's
probably not worth thinking too much about.

> It may be my laziness speaking, but do we really need such a check?  If
> someone constructs interleaving objects then they'd need to implement
> the necessary checks themselves IMHO.

Yeah, I think we can live without it. I was mostly trying to think
through whether there were worse cases than the one we saw. But you've
convinced me that there probably aren't.

> > > The line in question is this one:
> > > 
> > > 	for (i = 0; i <= (j = (queue->nr - 1) - i); i++)
> > > 
> > > Assignment in the middle?  Hmm.  Why not do it like this?
> > > 
> > > 	for (i = 0, j = queue->nr - 1; i < j; i++, j--)
> > > 
> > > Looks less complicated to me.
> > 
> > Yes, see my other reply. :)
> 
> Ah, so that's where I stole it from. ;)  Perhaps my source amnesia was
> in part caused by confusion about your reasoning there: The code does A,
> B would be better, so let's do C.  Wait, what? :)

My reasoning was that there's a bug, and the patch does the minimal fix.
I don't mind making a readability improvement on top, but the two are
orthogonal. I.e., you could still write:

  for (i = 0, j = queue->nr - 1; i <= j; i++, j--)

which is more readable but still buggy. :)

-Peff
