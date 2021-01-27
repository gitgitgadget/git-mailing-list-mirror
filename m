Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B32DC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1731A64DD1
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhA0XW0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:22:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:41390 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235766AbhA0XVy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 18:21:54 -0500
Received: (qmail 6884 invoked by uid 109); 27 Jan 2021 22:21:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Jan 2021 22:21:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20360 invoked by uid 111); 27 Jan 2021 22:21:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Jan 2021 17:21:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Jan 2021 17:21:11 -0500
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sunshine@sunshineco.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
Message-ID: <YBHnV80bBQOxZH1O@coredump.intra.peff.net>
References: <xmqqk0sevqlh.fsf@gitster.c.googlers.com>
 <YAH0G+Y4fIxoTeZa@coredump.intra.peff.net>
 <830a88ce-1728-a6a5-f60d-59328f85932c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <830a88ce-1728-a6a5-f60d-59328f85932c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 23, 2021 at 09:41:29PM -0500, Philippe Blain wrote:

> > So we could split the macos test out. It would probably involve
> > duplicating a little bit of the content, but we do something similar for
> > the dockerized builds. It might be that there is an option we can set to
> > say "keep building the others even if one of these fails", which would
> > give us the best of both.
> 
> Yes, a quick Google search pointed me to a blog post [1]
> that mentions using 'fail-fast: false' in the test matrix so that
> one failing job does not automatically cancel the rest of the jobs
> in the matrix (the default is 'true') [2].
> 
> If we apply that to all four matrices in the workflow file,
> (windows-test, vs-test, regular and dockerized), it would be
> something like this:

Thanks, that's exactly what I think we'd want.

The downside, of course, is that a failure that will happen on every
platform will mean wasted CPU to trigger the same failure over and over.
But:

  - I rarely see that myself, because I wouldn't bother pushing up to CI
    until "make test" passed locally. So usually I'm finding portability
    issues via CI. Other people might be different, though.

  - we already have the Windows tests in a separate matrix anyway, so a
    failure on Linux would run the whole Windows suite (which is an
    order of magnitude more expensive)

  - even within the Windows matrix, I think running the rest of the
    tests after a failure is still valuable. If there's a second
    failure, you save a round-trip to CI (so it doesn't reduce CPU, but
    it may help latency to reach a passing state).

-Peff
