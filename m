Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E97FC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 16:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35DA61BFB
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 16:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbhKQQt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 11:49:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:32996 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238908AbhKQQtv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 11:49:51 -0500
Received: (qmail 23920 invoked by uid 109); 17 Nov 2021 16:46:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Nov 2021 16:46:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15472 invoked by uid 111); 17 Nov 2021 16:46:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Nov 2021 11:46:51 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Nov 2021 11:46:50 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/3] diff histogram: intern strings
Message-ID: <YZUx+mzaUf/TgXrx@coredump.intra.peff.net>
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
 <38c771a74d2a348e6a752555f95b746de029b1d7.1637148025.git.gitgitgadget@gmail.com>
 <2b2bd380-540f-959b-b950-cfdc95cbff29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b2bd380-540f-959b-b950-cfdc95cbff29@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 10:55:02AM -0500, Derrick Stolee wrote:

> > diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
> > index e694bfd9e31..6c1c88a69a1 100644
> > --- a/xdiff/xhistogram.c
> > +++ b/xdiff/xhistogram.c
> > @@ -91,9 +91,8 @@ struct region {
> >  static int cmp_recs(xpparam_t const *xpp,
> >  	xrecord_t *r1, xrecord_t *r2)
> >  {
> > -	return r1->ha == r2->ha &&
> > -		xdl_recmatch(r1->ptr, r1->size, r2->ptr, r2->size,
> > -			    xpp->flags);
> > +	return r1->ha == r2->ha;
> > +
> 
> nit: stray newline.
> 
> The only meaningful change here is that you are relying entirely on
> the hash and not checking the content again. This means that hash
> collisions on this 32-bit hash could start introducing different
> results. Are we worried about that?

I had the same thought. But running "git log --histogram -p" on git.git
does not seem to produce any differences between the two. So perhaps
collisions are removed elsewhere. It would be nice to have a better
understanding of this before proceeding with this change.

Curiously, I got a much smaller improvement in my test, which did:

  git log --no-merges -p --histogram :^po

My assumption being that "po/" diffs are big and uninteresting and so
bloat the output. But that turned out to be interesting timing-wise.
Excluding "po/" means that patch produces only a 0.6% improvement in
speed. But _just_ running the diffs for po shows a 24% speedup!

I guess this is just because those files are much larger than average
(and changed in fewer commits), meaning that the time spent hashing and
comparing lines will show up as a larger percentage of the total work.

But I wondered...

> The existence of these conditions gave me pause, so I went to look for where they
> were inserted. They were made in 9f37c27 (xdiff/xprepare: skip classification,
> 2011-07-12) with the justification that 
> 
>     We don't need any of that in histogram diff, so we omit calls to these
>     functions. We also skip allocating memory to the hash table, rhash, as
>     it is no longer used.
> 
>     This gives us a small boost in performance.
> 
> But you are actually _using_ these preparation steps, which means you are
> re-adding the cost of hashing but overall improving because you use the
> data correctly. Excellent.

Are we making a tradeoff here based on the data patterns? That is, it
seems like we are spending extra time upfront to do classification in
order to get quicker comparisons later. Presumably the upfront work is
O(n) in the length of the file. How many comparisons do we expect to
save?  Is it also linear in the number of lines, or could it be
super- or sub-linear depending on the actual diff?

-Peff
