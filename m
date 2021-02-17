Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7DAC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446E464E45
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhBQT3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:29:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:36184 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232973AbhBQT3r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:29:47 -0500
Received: (qmail 19734 invoked by uid 109); 17 Feb 2021 19:29:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 19:29:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7714 invoked by uid 111); 17 Feb 2021 19:29:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Feb 2021 14:29:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Feb 2021 14:29:05 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 6/8] builtin/pack-objects.c: rewrite honor-pack-keep
 logic
Message-ID: <YC1ugXFk32xHY4k0@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <c3868c7df92484f0527ce500ad1156275be334e8.1612411124.git.me@ttaylorr.com>
 <YC0+wlRksoqm0xLO@coredump.intra.peff.net>
 <YC1tLzivHqnoV6U7@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC1tLzivHqnoV6U7@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 02:23:27PM -0500, Taylor Blau wrote:

> On Wed, Feb 17, 2021 at 11:05:22AM -0500, Jeff King wrote:
> > I think just bumping that:
> >
> >   if (local && !p->pack_local)
> > 	return 0;
> 
> > above the new code would fix it. Or to lay out the logic more fully, the
> > order of checks should be:
> 
> >   - does _this_ pack we found the object in disqualify it. If so, we can
> >     cheaply return 0. And that applies to both keep and local rules.
> >
> >   - otherwise, check all packs via has_object_kept_pack(), which is
> >     cheaper than continuing to iterate through all packs by returning
> >     -1.
> >
> >   - once we know definitively about keep-packs, then check any shortcuts
> >     related to local packs (like !have_non_local_packs)
> >
> >   - and then if no shortcuts, we return -1
> 
> I don't understand what you're suggesting. Is the (local &&
> !p->pack_local) a disqualifying condition? Reading the comment, I think
> it is, and so we could do something like:

That's exactly what I'm suggesting. If we have a non-local pack and were
given --local, then we can shortcut immediately without caring about
kept packs: we know that we do not want the object.

> [...]
> But your "check any shortcuts related to local packs" makes me think
> that we should leave the code as-is.

No, the "shortcuts" there is the opposite:

  if (!local || !have_non_local_packs)
	return 1;

If either of those is true, we can say "definitely include" but only
with respect to the --local requirement. So we _can't_ bump that up, but
must check it only after we've definitively resolved the keep-pack
requirement.

-Peff
