Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D61C34022
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 03:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B788D206DB
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 03:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgBSD4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:56:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:47610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726439AbgBSD4v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 22:56:51 -0500
Received: (qmail 21582 invoked by uid 109); 19 Feb 2020 03:56:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Feb 2020 03:56:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24579 invoked by uid 111); 19 Feb 2020 04:05:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 23:05:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 22:56:50 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        rhi@pengutronix.de
Subject: Re: [PATCH] describe: output tag's ref instead of embedded name
Message-ID: <20200219035650.GA84414@coredump.intra.peff.net>
References: <xmqqd0ahp0na.fsf@gitster-ct.c.googlers.com>
 <fcf19a46b80322c5579142efe4ec681a4dcbdd28.1581802264.git.matheus.bernardino@usp.br>
 <20200216065101.GA2937208@coredump.intra.peff.net>
 <xmqqd0abk7zc.fsf@gitster-ct.c.googlers.com>
 <20200218195402.GA21586@coredump.intra.peff.net>
 <xmqq4kvnijim.fsf@gitster-ct.c.googlers.com>
 <xmqqzhdfh3vr.fsf@gitster-ct.c.googlers.com>
 <20200219015733.GA81560@coredump.intra.peff.net>
 <xmqqr1yrgt2d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1yrgt2d.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 07:22:02PM -0800, Junio C Hamano wrote:

> > Still, I'm not entirely convinced. As a decentralized system, I think
> > our first duty is to make things convenient and workable for the
> > preferences of the local repository, and second to facilitate
> > communication with other people's clones of the same repository.
> 
> Yes, and that can be done by either (1) locally moving a tag that is
> stored in a wrong location to where it wants to be, or (2) locally
> *creating* a tag that suits the preferences of the local repository,
> ignoring the tag obtained from outside world that is stored in a
> wrong place.  The latter would not help to facilitate communication,
> though.

I think a left a few things unsaid in my "v1.0-bob" example. I was
imagining that there are _two_ v1.0 tags floating around. One that you
consider "wrong", tagged by Bob, and one you like. You keep the latter
in refs/tags/v1.0.

I suppose that technically is your (1), as you renamed Bob's wrong tag
locally.

I think this is a steady-state that makes sense. Bob erroneously called
his tag "v1.0", but you want to hold on to it for talking to Bob, or
understanding Bob's world-view.

Now imagine you run "git describe", and it says:

  $ git describe HEAD
  warning: tag 'v1.0' is really 'v1.0-bob' here
  v1.0

Does that mean we found "v1.0-bob"? Or did we pass through looking at
Bob's v1.0 and eventually found our own "real" v1.0? (I'm actually not
sure if the "pass through" case would even generate such a warning).

But it seems like saying "we found v1.0-bob" unambiguously would make
the output more useful. Another way of thinking about it is that you can
only have one ref namespace locally, and therefore only one
refs/tags/foo; but you can have an infinite number of tags that claim to
be "foo".

> > If for whatever reason I chose to call my version of the global v1.0 tag
> > as "v1.0-bob", then it seems friendlier to me to report the name that
> > can actually be used with further local commands (and remind the user of
> > the global name) than the other way around.
> 
> That you can do with "git tag v1.0-bob <whatever object>" locally, no?

Not if you already have something else there, as above.

> > Though TBH the situation is rare enough that I kind of doubt it matters
> > all that much either way. It's been like this for over a decade, and
> > this is the first time I recall it being brought up.
> 
> Yeah, I do not think this is an often-arising concern.  It's merely
> what the expected and recommended direction to escape when it
> happens, and what the warning message should say to make the
> recommendation communicated better, I think.

Yeah, I'll be the first to admit that the example above is totally
contrived. I've never run into it myself.  But then, I've never seen
this warning in the wild either.  The usual resolution, I imagine, would
be "oops, I was trying to do some tricky with tags and screwed it up;
let me fix the name". And if we are going to give any advise() hint, I
think it would be that (and people who really do want a long-running
v1.0-bob would presumably want to disable that advice).

-Peff
