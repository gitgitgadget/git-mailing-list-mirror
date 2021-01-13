Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1DAC433E6
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A27E22BEA
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbhAMUeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 15:34:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:55148 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbhAMUeh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 15:34:37 -0500
Received: (qmail 26368 invoked by uid 109); 13 Jan 2021 20:33:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jan 2021 20:33:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2287 invoked by uid 111); 13 Jan 2021 20:33:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jan 2021 15:33:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jan 2021 15:33:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Arnaud Morin <arnaud.morin@gmail.com>, git@vger.kernel.org,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] patch-ids: handle duplicate hashmap entries
Message-ID: <X/9ZNM9KxZaQ2it+@coredump.intra.peff.net>
References: <20210109162440.GM31701@sync>
 <X/2vgbnxWSmst5yB@coredump.intra.peff.net>
 <X/28IXBpse2dNZQH@coredump.intra.peff.net>
 <20210112153438.GC32482@sync>
 <X/3FwNPHqZqY+hv0@coredump.intra.peff.net>
 <xmqqy2gy3r5p.fsf@gitster.c.googlers.com>
 <20210113092448.GE32482@sync>
 <X/7ur/IcCg1AqTdZ@coredump.intra.peff.net>
 <xmqq7dogy4dx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7dogy4dx.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 12:21:30PM -0800, Junio C Hamano wrote:

> > I suspect for most operations we care less about "remove all
> > cherry-picks from both sides", but rather "give me one side, omitting
> > commits that are already on the other side" (because you want to rebase
> > or cherry-pick some subset).
> 
> Yes again.  It means "--cherry-pick" inherently is not symmetric.
> One side is the reference side (i.e. mainline), and the goal is to
> remove from the other side what is in the reference side.
> 
> What we are seeing in this discussion is that "--cherry-pick" and
> symmetric difference do not conceptually play well together.
> 
> But the behaviour with the patch makes the most sense when
> cherry-pick is applied to a symmetric difference (provided that
> doing so makes sense in the first place, that is).

I didn't realize --cherry-pick would work without a symmetric
difference. The documentation says:

  Omit any commit that introduces the same change as another commit on
  the “other side” when the set of commits are limited with symmetric
  difference.

And indeed, I think it silently does nothing with:

  git rev-list --cherry-pick A..B

(because there is nothing on the "other" side to match).

So you do need some symmetric difference in order to define the two
sets, but you might only want to see one of the sides.  And that is
basically what --cherry does. But having looked at the implementation of
cherry_pick_list(), it is quite happy to swap the sides internally. I
guess if we were going to make the output unsymmetric, the first thing
would be to stop doing that swap. :)

For the specifics of reverts and replays, though, I think the weirdness
has nothing to do with left/right, or showing one side. It's the
mismatched count. So if we were to make any change, it would be to keep
a count of how many times each commit appears on the other side, and
cancel them one for one.

I.e., this:

  o--M--W--M--o--
   \
    o--M--o---

might plausibly want to show "M" once on the upper branch. But:

  o--M--W--M--o--
   \
    o--M--W--M--o--

should never show M, I wouldn't think.

I'm not sure if that would be violating what existing callers expect
from "--cherry-pick", though (i.e., if it would need another name, or an
extra option to trigger).

-Peff
