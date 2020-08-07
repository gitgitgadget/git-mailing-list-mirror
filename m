Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC567C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7E22075A
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 22:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGWfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 18:35:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:52450 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHGWfX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 18:35:23 -0400
Received: (qmail 3149 invoked by uid 109); 7 Aug 2020 22:35:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 22:35:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19191 invoked by uid 111); 7 Aug 2020 22:35:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2020 18:35:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Aug 2020 18:35:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nuthan Munaiah <nm6061@rit.edu>, git@vger.kernel.org
Subject: Re: `git blame` Line Number Off-by-one
Message-ID: <20200807223522.GB3750245@coredump.intra.peff.net>
References: <emc6590292-832a-4a35-8815-d5707731d605@sanctum>
 <20200807212159.GA1871940@coredump.intra.peff.net>
 <20200807213349.GB1871940@coredump.intra.peff.net>
 <xmqq7duaf6xk.fsf@gitster.c.googlers.com>
 <20200807222630.GA3750245@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200807222630.GA3750245@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 07, 2020 at 06:26:30PM -0400, Jeff King wrote:

> On Fri, Aug 07, 2020 at 03:05:27PM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > Dropping it entirely, as below, doesn't break any tests. Junio, do you
> > > know of a case this is meant to improve?
> > 
> > I think the only conceivable case is that in the middle of a single
> > block of text in an ancient version, another block of lines gets
> > inserted during the evolution of the file, but in the end these
> > intermediate edits all go away and the same original text remains.
> > 
> > In such a case, without coalescing, we would not treat the original
> > single block of text as a single unit.
> 
> Yeah, that makes sense, and it should be possible to construct a case
> based on that.

It was even easier than I expected. :)

Try this:

  git init repo
  cd repo
  
  seq 20 >file
  git add file
  git commit -m base
  
  { seq 10; echo foo; seq 11 20; } >file
  git commit -am cruft
  
  seq 20 >file
  git commit -am revert

  git blame --root --porcelain file

With the coalescing, we get a single 20-line block:

  25d93ad4c4b27570ccd4b6412ccaa549ae6f9ff7 1 1 20
  author Jeff King
  ...
          1
  ...
  25d93ad4c4b27570ccd4b6412ccaa549ae6f9ff7 11 11
          11

and without it, we get two 10-line blocks:

  25d93ad4c4b27570ccd4b6412ccaa549ae6f9ff7 1 1 10
  author Jeff King
  ...
          1
  ...
  25d93ad4c4b27570ccd4b6412ccaa549ae6f9ff7 11 11 10
          11

I doubt it really matters all that much in practice, but it's possible
some consumer of --porcelain relies on us giving minimal blocks.

So that argues for fixing blame_coalesce() to make sure that we coalesce
only when the blocks are adjacent in both the source and the result.
Otherwise we're losing information.

-Peff
