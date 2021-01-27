Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE33C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B8160C40
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhA0XgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:36:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:41408 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233777AbhA0Xet (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 18:34:49 -0500
Received: (qmail 7508 invoked by uid 109); 27 Jan 2021 23:34:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Jan 2021 23:34:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21439 invoked by uid 111); 27 Jan 2021 23:34:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Jan 2021 18:34:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Jan 2021 18:34:07 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] rev-list: add --disk-usage option for calculating
 disk usage
Message-ID: <YBH4b04kZL8V6GFe@coredump.intra.peff.net>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YBHmY7vNxu2hqOa/@coredump.intra.peff.net>
 <YBHv0ZHZD4VMHLYR@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBHv0ZHZD4VMHLYR@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2021 at 05:57:21PM -0500, Taylor Blau wrote:

> > You can find that out by generating a list of objects, getting their
> > sizes from cat-file, and then summing them, like:
> >
> >     git rev-list --objects main..branch
> >     cut -d' ' -f1 |
> 
> I suspect that this is from the original commit message that you wrote a
> half-decade ago. Not that it really means much, but you could shave one
> process off of this example by passing '--no-object-names' to 'git
> rev-list'.

That, plus my muscle memory to do the cut. We should probably model the
better form here, and use it in the test, though (not worth a re-roll on
its own, but it looks like there are a few other minor bits).

> >   - not counting up all reachable objects (i.e., requiring --objects for
> >     this output, and omitting it just counts up commits). This could be
> >     handled in the bitmap case with some extra code (OR-ing with the
> >     type bitmaps).
> >
> >     But after 5 years of this patch, I've never wanted that once. The
> >     disk usage of just some of the objects isn't really that useful (and
> >     of course you can still get it by piping to cat-file).
> 
> Yeah. I think it's trivial to support it, but I'm in favor of a simpler
> interface.
> 
> That said, I worry about painting ourselves into a corner if the default
> implies --objects. If we wanted to change that, I'm pretty sure you'd
> have to write a rule that says "imply objects, unless --tags, --blobs or
> etc. are specified, and then only do that".
> 
> Maybe we'll never have to address that, but it's worth thinking about
> before committing to implying '--objects'.

Yeah, the one thing that gives me pause is that it would be hard to undo
later. I didn't write the code to handle it in the bitmap case, but I
don't think it would be _too_ bad. It is slightly annoying for the
all-objects case, because the existing code isn't set up well to iterate
either a specific type, or all types.

> I have no comments on the patch itself, which looks fine to me (and I
> have seen over and over again as it seems to regularly cause conflicts
> when merging new releases into GitHub's fork :-)).

You are exposing my ulterior motive. :)

-Peff
