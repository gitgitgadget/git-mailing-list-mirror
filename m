Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63647C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4864560F38
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 16:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhJKQzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:55:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:37076 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232606AbhJKQzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 12:55:11 -0400
Received: (qmail 29248 invoked by uid 109); 11 Oct 2021 16:53:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Oct 2021 16:53:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20440 invoked by uid 111); 11 Oct 2021 16:53:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Oct 2021 12:53:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Oct 2021 12:53:10 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: why git is so slow for a tiny git push?
Message-ID: <YWRr9g32cMlIc37V@coredump.intra.peff.net>
References: <c5a8595658d6416684c2bbd317494c49@xiaomi.com>
 <5a6f3e8f29f74c93bf3af5da636df973@xiaomi.com>
 <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 09, 2021 at 06:05:56PM +0000, 程洋 wrote:

> I have a really big repository which has 9m objects and maybe 300k refs.
> I noticed that git push is really slow for a tiny change. An example shows below
> 
> 3 objects which is only 7 kb takes 36 seconds to pack-objects (it's the time after i enable pack.usesparse)
> However if I manually call “pack-objects” with the exactly same objects SHA1. It only take less than 0.005 second
> What is really pass to “pack-objects” when I call “git push”?

Do you have an objects/pack/pack-*.bitmap file on the sending side?

The bitmap code is eager to produce an exact set difference between what
is being sent and what the other side has. If you have incomplete bitmap
coverage (which is almost a certainty if you have 300k refs), it may do
a lot of traversal filling in the "what the other side has" part of the
bitmap, even though it does not end up helping the final result in this
case.

Bitmaps are enabled by default on bare repos since Git v2.22.0. You can
override this with:

  git config repack.writeBitmaps false
  git gc

(or if you don't want to do the gc, you can safely remove the '.bitmap'
file).

I notice you used GIT_TRACE_PERFORMANCE below. Try GIT_TRACE2_PERF
instead, which goes into detail within particular processes. If this is
related to bitmaps, I'd expect the time to go to the "enumerate-objects"
region.

-Peff
