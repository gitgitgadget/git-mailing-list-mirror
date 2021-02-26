Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C603C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92FA64EDB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 06:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBZGYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 01:24:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:45550 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhBZGYC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 01:24:02 -0500
Received: (qmail 11932 invoked by uid 109); 26 Feb 2021 06:23:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Feb 2021 06:23:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16506 invoked by uid 111); 26 Feb 2021 06:23:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Feb 2021 01:23:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Feb 2021 01:23:20 -0500
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH v4 0/8] repack: support repacking into a geometric
 sequence
Message-ID: <YDiT2KeTYKZPamz8@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <8347289.KuArlTWdtP@mfick-lnx>
 <YDV5UX6n2nZb9Tn2@coredump.intra.peff.net>
 <4678947.aH8v75nzy7@mfick-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4678947.aH8v75nzy7@mfick-lnx>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 11:13:53AM -0700, Martin Fick wrote:

> > The idea of the geometric repack is that by sorting by size and then
> > finding a "cutoff" within the size array, we can make sure that we roll
> > up a sufficiently small number of bytes in each roll-up that it ends up
> > linear in the size of the repo in the long run. But if we roll up
> > without regard to size, then our worst case is that the biggest pack is
> > the newest (imagine a repo with 10 small pushes and then one gigantic
> > one). So we roll that up with some small packs, doing effectively
> > O(size_of_repo) work.
> 
> This isn't quite a fair evaluation, it should be O(size_of_push) I think?

Sorry, I had a longer example, but then cut it down in the name of
simplicity. But I think I made it too simple. :)

You can imagine more pushes after the gigantic one, in which case we'd
roll them up with the gigantic push. So that gigantic one is part of
multiple sequential rollups, until it is itself rolled up further.

But...

> > And then in the next roll up we do it again, and so on. 
>  
> I should have clarified that the intent is to prevent this by specifying an 
> mtime after the last rollup so that this should only ever happen once for new 
> packfiles. It also means you probably need special logic to ensure this roll-up 
> doesn't happen if there would only be one file in the rollup, 

Yes, I agree that if you record a cut point, and then avoid rolling up
across it, then you'd only consider the single push once. You probably
want to record the actual pack set rather than just an mtime cutoff,
though, since Git will update the mtime on packs sometimes (to freshen
them whenever it optimizes out an object write for an object in the
pack).

One of the nice things about looking only at the pack sizes is that you
don't have to record that cut point. :) But it's possible you'd want to
for other reasons (e.g., you may spend extra work to find good deltas in
your on-disk packs, so you want to know what is old and what is new in
order to discard on-disk deltas from pushed-up packs).

-Peff
