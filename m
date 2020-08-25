Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F5CC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD89720782
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHYQrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:47:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:40100 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHYQrW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 12:47:22 -0400
Received: (qmail 980 invoked by uid 109); 25 Aug 2020 16:47:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Aug 2020 16:47:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29857 invoked by uid 111); 25 Aug 2020 16:47:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Aug 2020 12:47:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Aug 2020 12:47:21 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Son Luong Ngoc <sluongng@gmail.com>, git <git@vger.kernel.org>,
        dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825164721.GA1414394@coredump.intra.peff.net>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <CB6B70D3-5FC6-43FE-8460-33F6CFC123E6@gmail.com>
 <20200825144515.GB7671@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825144515.GB7671@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 10:45:15AM -0400, Taylor Blau wrote:

> > I wonder if its worth to trigger write_midx_file() to update the midx instead of
> > just removing MIDX?
> 
> There's no reason that we couldn't do this, but I don't think that it's
> a very good idea, especially if the new 'git maintenance' command will
> be able to do something like this by itself.
> 
> I'm hesitant to add yet another option to 'git repack', which I have
> always thought as a plumbing tool. That's important because callers
> (like 'git maintenance' or user scripts) can 'git multi-pack-index write
> ...' after their 'git repack' to generate a new MIDX if they want one.

It may be worth thinking a bit about atomicity here, though. Rather than
separate delete and write steps, would somebody want a sequence like:

  - we have a midx with packs A, B, C

  - we find out that pack C is redundant and want to drop it

  - we create a new midx with A and B in a tempfile

  - we atomically rename the new midx over the old

  - we delete pack C

A simultaneous reader always sees a consistent midx. Whereas in a
delete-then-rewrite scenario there is a moment where there is no midx,
and they'd fall back to reading the individual idx files.

It may not matter all that much, though, for two reasons:

  - reading individual idx files should still give a correct answer.
    It just may be a bit slower.

  - even with an atomic replacement, I think caching on the reader side
    may cause interesting effects. For instance, if a reader process
    opens the old midx, it will generally cache that knowledge in memory
    (including mmap the content). So even after the replacement and
    deletion of C, it may still try to use the old midx that references
    C.

If we do care, though, that implies some cooperation between the
deletion process and the midx code. Perhaps it even argues that repack
should refuse to delete such a single pack at all, since it _isn't_
redundant. It's part of a midx, and the caller should rewrite the midx
first itself, and _then_ look for redundant packs.

-Peff
