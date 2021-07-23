Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4937EC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 08:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2224960E0C
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 08:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhGWIJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 04:09:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:55484 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234276AbhGWIJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 04:09:58 -0400
Received: (qmail 10801 invoked by uid 109); 23 Jul 2021 08:50:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Jul 2021 08:50:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23278 invoked by uid 111); 23 Jul 2021 08:50:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Jul 2021 04:50:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Jul 2021 04:50:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 09/24] midx: infer preferred pack when not given one
Message-ID: <YPqC19c2sFwuOCY9@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <9495f6869d792264c4366c9914fcf93d544caa6a.1624314293.git.me@ttaylorr.com>
 <YPf4MTDpbvinoIia@coredump.intra.peff.net>
 <YPiAhw2eP2MOksUF@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPiAhw2eP2MOksUF@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 04:16:07PM -0400, Taylor Blau wrote:

> > I dunno. Like I said, I was able to follow it, so maybe it is
> > sufficient. I'm just not sure others would be able to.
> 
> I think that others will follow it, too. But I agree that it is
> confusing, since we're fixing a bug that doesn't yet exist. In reality,
> I wrote this patch after sending v1, and then reordered its position to
> come before the implementation of MIDX bitmaps for that reason.
> 
> So in one sense, I prefer it this way because we don't ever introduce
> the bug.  But in another sense, it is very jarring to read about an
> interaction that has no basis in the code (yet).
> 
> I think that the best thing we could do without adding any significant
> reordering would be to just call out the situation we're in. I added
> this onto the end of the commit message which I think makes things a
> little clearer:
> 
>     (Note that multi-pack reachability bitmaps have yet to be
>     implemented; so in that sense this patch is fixing a bug which does
>     not yet exist.  But by having this patch beforehand, we can prevent
>     the bug from ever materializing.)

I do like fixing it up front. Here's my attempt at rewriting the commit
message. I tried to omit details about pack order, and instead refer to
the revindex code, and instead add more explanation of how this relates
to the pack-reuse code.

Something like:

  In 9218c6a40c (midx: allow marking a pack as preferred, 2021-03-30),
  the multi-pack index code learned how to select a pack which all
  duplicate objects are selected from. That is, if an object appears in
  multiple packs, select the copy in the preferred pack before using one
  from any other pack.

  Later in that same series, 38ff7cabb6 (pack-revindex: write multi-pack
  reverse indexes, 2021-03-30) learned to put the preferred pack at the
  start of the pack order when generating a midx ".rev" file. So far,
  that .rev ordering has not mattered. But it will be very important
  once we start using the .rev ordering for midx bitmaps.

  There is code in pack-objects to reuse pack bytes verbatim when
  bitmaps tell us a significant portion of the beginning of the code
  should be in the output. This code relies on the pack mentioned by the
  0th bit also being the pack that is preferred for duplicates (because
  we'd want to make sure both bases and deltas come from the same pack).
  For a pack .bitmap, this is trivially correct. For a midx bitmap, it
  is only true when some pack gets both duplicate-priority and is placed
  at the front of the .rev file. I.e., there must be _some_ preferred
  pack.

  So if the user did not specify a preferred pack, we pick one
  arbitrarily.

  There's no test here for a few reasons:

    - the midx bitmap feature does not yet exist; this is preemptively
      fixing a problem before introducing buggy code

    - whether things go wrong with the current rules depends on things
      like readdir() order, since that is used for some midx pack
      ordering. So any test might happen to succeed or fail based on
      factors outside of our control.

Thoughts?

-Peff
