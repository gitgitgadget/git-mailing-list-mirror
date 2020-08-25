Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6596FC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 17:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4069E20706
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 17:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHYR3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:29:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:40182 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgHYR3C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 13:29:02 -0400
Received: (qmail 1357 invoked by uid 109); 25 Aug 2020 17:29:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 17:29:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30296 invoked by uid 111); 25 Aug 2020 17:29:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 13:29:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 13:29:01 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Son Luong Ngoc <sluongng@gmail.com>,
        git <git@vger.kernel.org>, dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825172901.GD1414394@coredump.intra.peff.net>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <CB6B70D3-5FC6-43FE-8460-33F6CFC123E6@gmail.com>
 <20200825144515.GB7671@syl.lan>
 <20200825164721.GA1414394@coredump.intra.peff.net>
 <45921233-ac6c-05f2-e108-0ab2aeb56104@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45921233-ac6c-05f2-e108-0ab2aeb56104@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 01:10:13PM -0400, Derrick Stolee wrote:

> > If we do care, though, that implies some cooperation between the
> > deletion process and the midx code. Perhaps it even argues that repack
> > should refuse to delete such a single pack at all, since it _isn't_
> > redundant. It's part of a midx, and the caller should rewrite the midx
> > first itself, and _then_ look for redundant packs.
> 
> It is worth noting that we _do_ have a way to integrate the delete and
> write code using 'git multi-pack-index expire'. One way to resolve this
> atomicity would be to do the following inside the repack command:
> 
>  1. Create and index the new pack.
>  2. git multi-pack-index write
>  3. git multi-pack-index expire

Given that discussion elsewhere points to git-repack only really
deleting packs in all-in-one mode (and not ever a single pack), it seems
like we can really be much simpler here. If we're not deleting packs via
all-in-one, there's no need to touch the midx at all. If we are, then
it's reasonable to delete the midx immediately (after having written our
new pack but before deleting) since our new single pack idx is as good
or better.

I.e., drop step 2 above, and make step 3 just clear_midx_file(). Which
is roughly what the code does now, isn't it? Or is there some reason
that "expire" is more interesting than just clearing?

And if anybody does want to drop single packs, etc, they can do so by
generating a sensible midx separately from the repack operation (and
probably doing so before dropping the packs for atomicity).

-Peff
