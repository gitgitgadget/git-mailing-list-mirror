Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CE2C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9458722795
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 20:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbhAMUXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 15:23:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:55108 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbhAMUXX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 15:23:23 -0500
Received: (qmail 26250 invoked by uid 109); 13 Jan 2021 20:22:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Jan 2021 20:22:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2129 invoked by uid 111); 13 Jan 2021 20:22:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Jan 2021 15:22:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Jan 2021 15:22:41 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <X/9WkdHzSW9jAJ3k@coredump.intra.peff.net>
References: <cover.1610129796.git.me@ttaylorr.com>
 <xmqqk0shznvf.fsf@gitster.c.googlers.com>
 <X/5ER+ml/MhDjROA@nand.local>
 <xmqqft35ziog.fsf@gitster.c.googlers.com>
 <X/5nsw6uqKDCHGql@nand.local>
 <xmqq4kjlz1qf.fsf@gitster.c.googlers.com>
 <X/7yFdqUmSmRE8A0@coredump.intra.peff.net>
 <X/8THO3ck3bjJH+K@nand.local>
 <xmqqft34y53j.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft34y53j.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 12:06:08PM -0800, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> >> > That way, the bottom part can be merged sooner to 'next' than the
> >> > rest.  It always is cumbersome to have some part of the series in
> >> > 'next' and remainder in 'seen', so at that point, the lower half
> >> > would naturally gain a different name before it gets merged to
> >> > 'next', I would think.
> >>
> >> That seems to me like it ends up being _more_ work than just making them
> >> into two branches in the first place.
> 
> More work to contributors?  How?

The quoted part is from me, so I'll respond: I didn't mean contributors,
but it seems like more work to you. I.e., you are ending up with the
same multi-branch config _and_ you have to split the branches yourself
later after seeing review.

But reading what you wrote below, the advantage is that if this does not
happen until the first part hits "next", then there is no chance of it
being rebased at that point (and thus getting rewritten out from under
the second topic).

> The worst case that happened in the past was that a quite minor
> tweak was made to a bottom topic that was depended on another topic,
> so I just queued the new iteration of the bottom topic again,
> without realizing that the other one needed to be rebased.  We ended
> up two copies of the bottom topic commits in 'pu' (these days we
> call it 'seen') as the tweak was so minor that the two topics
> cleanly merged into 'pu' without causing conflict.  The next bad
> case was a similar situation with larger rewrite of the bottom
> topic, which caused me to look at quite a big conflict and waste my
> time until I realized that I was missing an updated top half.

I somehow assumed you had more automation there. On my end, since I
rebase my topics aggressively, it is just a matter of pointing the
branch upstream in the right place. But of course that is not your
workflow at all.

I know you do have the "this branches uses" logic in your what's cooking
emails. In theory it could remind you of the situation, but I'm not sure
where in the workflow you'd insert it (by the time you run the WC
script, it is hard to realize the rebasing that _should_ have been done
earlier, unless you collate patch-ids, and even that is not 100%).

I do wonder if setting the dependent branch's @{upstream} would be
helpful here. You do not rebase all of your topics, but the ones with a
local-branch @{u} would be candidates for doing so.

All that said, I am also sensitive that my armchair "you could do it
like this..." suggesting may not be fully informed. So take it as idle
thoughts, not necessarily arguments. :)

> >> So I guess I remain skeptical that ad-hoc splitting of longer series is
> >> easier than doing so up front.
> 
> Nobody suggested ad-hoc splitting.  I was saying that splitting
> would naturally grow out of reviews toward stabilization.

This quote is me again. By "ad-hoc" I meant exactly this "after we see
some reviews" (as opposed to drawing a line up front).

-Peff
