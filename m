Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21041C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D139564EC3
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 21:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhBWVyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 16:54:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:42380 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232012AbhBWVyE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 16:54:04 -0500
Received: (qmail 27647 invoked by uid 109); 23 Feb 2021 21:53:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 21:53:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5230 invoked by uid 111); 23 Feb 2021 21:53:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 16:53:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 16:53:21 -0500
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH v4 0/8] repack: support repacking into a geometric
 sequence
Message-ID: <YDV5UX6n2nZb9Tn2@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <1724378.IzK8VI2DXP@mfick-lnx>
 <YDViUPT4JhGJLjji@coredump.intra.peff.net>
 <8347289.KuArlTWdtP@mfick-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8347289.KuArlTWdtP@mfick-lnx>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 02:41:09PM -0700, Martin Fick wrote:

> > > Would it make sense to somehow detect all new packs since the last rollup
> > > and always include them in the rollup no matter what their size? That is
> > > one thing that my git-exproll script did. One of the main reasons to do
> > > this was because newer packs tended to look big (I was using bytes to
> > > determine size), and newer packs were often bigger on disk compared to
> > > other packs with similar objects in them (I think you suggested this was
> > > due to the thickening of packs on receipt). Maybe roll up all packs with
> > > a timestamp "new enough", no matter how big they are?
> > 
> > That works against the "geometric" part of the strategy, which is trying
> > to roll up in a sequence that is amortized-linear. I.e., we are not
> > always rolling up everything outside of the base pack, but trying to
> > roll up little into medium, and then eventually medium into large. If
> > you roll up things that are "too big", then you end up rewriting the
> > bytes more often, and your amount of work becomes super-linear.
> 
> I'm not sure I follow, it would seem to me that it would stay linear, and be 
> at most rewriting each new packfile once more than previously? Are you 
> envisioning more work than that?

Maybe I don't understand what you're proposing.

The idea of the geometric repack is that by sorting by size and then
finding a "cutoff" within the size array, we can make sure that we roll
up a sufficiently small number of bytes in each roll-up that it ends up
linear in the size of the repo in the long run. But if we roll up
without regard to size, then our worst case is that the biggest pack is
the newest (imagine a repo with 10 small pushes and then one gigantic
one). So we roll that up with some small packs, doing effectively
O(size_of_repo) work. And then in the next roll up we do it again, and
so on. So we end up with O(size_of_repo * nr_rollups) total work. Which
is no better than having just done a full repack at each rollup.

Now I don't think we'd see that worst case in practice that much. And
depending on your definition of "new enough", you might keep nr_rollups
pretty small.

-Peff
