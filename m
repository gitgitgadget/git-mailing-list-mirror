Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A010BC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7428A6140D
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 21:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhGAVp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:45:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:39316 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhGAVp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 17:45:56 -0400
Received: (qmail 29050 invoked by uid 109); 1 Jul 2021 21:43:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 21:43:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19488 invoked by uid 111); 1 Jul 2021 21:43:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 17:43:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 17:43:23 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: git log exclude pathspec from file - supported? plans?
Message-ID: <YN42+1dN8bML3tQ8@coredump.intra.peff.net>
References: <CACPiFCLtj5QF6_Goc5UYh9KHWgkrKtjApL-cCH04S5gdTFyk7Q@mail.gmail.com>
 <CACPiFCLXxwaWOuR6sy8H4hCG-H0ZFvVYma7COfDq3zxoUt=VtA@mail.gmail.com>
 <YNywsEbFcrQFeH91@coredump.intra.peff.net>
 <87sg0zdx7z.fsf@evledraar.gmail.com>
 <YN4zKVK7gvuIZ0vK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YN4zKVK7gvuIZ0vK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 01, 2021 at 05:27:05PM -0400, Jeff King wrote:

> > One of the PCREv2 experiments I had very early WIP work towards was to
> > create a search index for commit messages, contents etc. and stick it in
> > something similar to the --changed-paths part of the commit-graph.
> 
> Yeah, to some degree --change-paths may mitigate this, since for a
> series of simple pathspecs we'd generate the bloom filter once and then
> get O(1) matching per commit.

The timings for "git rev-list" I shared earlier were with commit-graphs,
but not with changed-path filters. They don't seem to help much, though.

I suspect the reason is that they can never give a definite answer. They
can only say "probably, yes, this commit is worth looking at". And then
we have to do the same slow, linear pathspec match on that commit. And
if your pathspec contains virtually every path in the first place, then
the answer from the bloom filters will always be "probably, yes".

So I guess they are not really a silver bullet here.

-Peff
