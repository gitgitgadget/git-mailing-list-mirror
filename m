Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02C2C4332F
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 08:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A367604D2
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 08:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhJLIlu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 04:41:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:37440 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235009AbhJLIll (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 04:41:41 -0400
Received: (qmail 31801 invoked by uid 109); 12 Oct 2021 08:39:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 08:39:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2677 invoked by uid 111); 12 Oct 2021 08:39:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Oct 2021 04:39:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Oct 2021 04:39:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [External Mail]Re: why git is so slow for a tiny git push?
Message-ID: <YWVJyRJhRTdg39tX@coredump.intra.peff.net>
References: <c5a8595658d6416684c2bbd317494c49@xiaomi.com>
 <5a6f3e8f29f74c93bf3af5da636df973@xiaomi.com>
 <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
 <YWRr9g32cMlIc37V@coredump.intra.peff.net>
 <ef2aa0d3ea8a4d98b910abdfd55191d0@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef2aa0d3ea8a4d98b910abdfd55191d0@xiaomi.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 08:04:44AM +0000, 程洋 wrote:

> I have bitmap indeed because my master server also serves as download server.
> However I'm using git 2.17.0, and I didn't set repack.writeBitmaps

On that version and without the config, then perhaps you (or somebody)
passed "-b" to git-repack.

> But why bitmaps can cause push to be slow? Do you mean that if
> writeBitmaps is true, every push will regenerate bitmap file? If
> that's what you mean, what I see is the only bitmap file in my repo
> didn't change across time (the modify time is one month ago, long
> before I run the experiment)

No, it is not regenerating the on-disk bitmaps. But when deciding the
set of objects to send, pack-objects will generate an internal bitmap
which is the set difference of objects reachable from the pushed refs,
minus objects reachable from the refs the other the other side told us
they had.

It uses the on-disk bitmaps as much as possible, but there may be
commits not covered by bitmaps (either because they were pushed since
the last repack which built bitmaps, or simply because it's too
expensive to put a bitmap on every commit, so we sprinkle them
throughout the commit history). In those cases we have to traverse parts
of the object graph by walking commits and opening up trees. This can be
expensive, and is where your time is going.

Reachability bitmaps _usually_ make things faster, but they have some
cases where they make things worse (especially if you have a ton of
refs, or haven't repacked recently).

If bitmaps are causing a problem for your push, they are likely to be
causing problems for fetches, too. But if you want to keep them to serve
fetches, but not use them for push, you should be able to do:

  git -c pack.usebitmaps=false push

-Peff
