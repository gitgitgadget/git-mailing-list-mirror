Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8F0C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8ADC60F9B
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbhJZV45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:56:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:47460 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231655AbhJZV44 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:56:56 -0400
Received: (qmail 10719 invoked by uid 109); 26 Oct 2021 21:54:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Oct 2021 21:54:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14310 invoked by uid 111); 26 Oct 2021 21:54:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Oct 2021 17:54:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Oct 2021 17:54:30 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [External Mail]Re: why git is so slow for a tiny git push?
Message-ID: <YXh5FoeyfePqr1k3@coredump.intra.peff.net>
References: <c5a8595658d6416684c2bbd317494c49@xiaomi.com>
 <5a6f3e8f29f74c93bf3af5da636df973@xiaomi.com>
 <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
 <YWRr9g32cMlIc37V@coredump.intra.peff.net>
 <ef2aa0d3ea8a4d98b910abdfd55191d0@xiaomi.com>
 <YWVJyRJhRTdg39tX@coredump.intra.peff.net>
 <d8abab7fb5184a94a9e9e5b7c1f28695@xiaomi.com>
 <YWYAjRfLsDtc1Dkm@coredump.intra.peff.net>
 <5063751fd4b94ccca3987080c96370d8@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5063751fd4b94ccca3987080c96370d8@xiaomi.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 14, 2021 at 06:47:31AM +0000, 程洋 wrote:

> Seems that git receive-pack only takes 1 seconds.
> After that, git rev-list takes the most time, I don't know what is it doing

It's checking connectivity of what was sent (i.e., that the other side
sent us all the objects). If you have a ton of refs on the server side,
there are some known issues here, as just loading the "we already have
this" side of the traversal can be very expensive.

There's been some recent work to make this faster, like f559d6d45e
(revision: avoid hitting packfiles when commits are in commit-graph,
2021-08-09) and f45022dc2f (connected: do not sort input revisions,
2021-08-09), which will be in the upcoming release. I'm sure there are
more improvements that could be made on top, but those show the general
direction.

-Peff
