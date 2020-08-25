Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79A1C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 17:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D2020782
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 17:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgHYRmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:42:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:40240 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgHYRmT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 13:42:19 -0400
Received: (qmail 1506 invoked by uid 109); 25 Aug 2020 17:42:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 17:42:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30417 invoked by uid 111); 25 Aug 2020 17:42:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 13:42:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 13:42:18 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        git <git@vger.kernel.org>, dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825174218.GF1414394@coredump.intra.peff.net>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <CB6B70D3-5FC6-43FE-8460-33F6CFC123E6@gmail.com>
 <20200825144515.GB7671@syl.lan>
 <20200825164721.GA1414394@coredump.intra.peff.net>
 <45921233-ac6c-05f2-e108-0ab2aeb56104@gmail.com>
 <20200825172901.GD1414394@coredump.intra.peff.net>
 <20200825173425.GA16844@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825173425.GA16844@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 01:34:25PM -0400, Taylor Blau wrote:

> > I.e., drop step 2 above, and make step 3 just clear_midx_file(). Which
> > is roughly what the code does now, isn't it? Or is there some reason
> > that "expire" is more interesting than just clearing?
> 
> It's not clear to me whether you're talking about my patch, or what a
> more full integration with 'git repack' looks like.
> 
> If you are talking about my patch, I disagree: checking that the MIDX
> doesn't know about a pack we're dropping *is* useful even without
> all-in-one, because of '.keep' packs (as demonstrated by the new test in
> my patch).

I hadn't considered .keep. So all-in-one may still involve selectively
deleting some packs. It makes sense, then, for repack to consider
whether the midx is actually redundant or not rather than just always
clearing it (i.e., what your patch does).

In general I consider .keep packs kind of an awful feature that
introduces a lot of confusion and works against other features like
bitmaps. But I guess that they're the only thing that allows you to have
a gigantic Windows-like repo where you never fully pack it, but just
keep acquiring a string of big packs. Which is the exact case that the
midx is most useful for. So they're definitely worth considering and
supporting here.

> To me, this patch seems like an incremental step in the direction that
> we ultimately want to be going, but it's hard to untangle whether the
> ensuing discussion is targeted at my patch, or the ultimate goal.

I wasn't sure of the answer to that until we untangled more. I.e., it
wasn't clear to me if your incremental step was even in the right
direction if we weren't in fact ever selectively deleting packs in
git-repack. (And now it sounds like we aren't via "git repack -d", which
was my original question, but we are via .keep).

-Peff
