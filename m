Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 968A61F453
	for <e@80x24.org>; Wed, 17 Oct 2018 18:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeJRCTv (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 22:19:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:43728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727672AbeJRCTv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 22:19:51 -0400
Received: (qmail 7358 invoked by uid 109); 17 Oct 2018 18:22:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Oct 2018 18:22:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21775 invoked by uid 111); 17 Oct 2018 18:22:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Oct 2018 14:22:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2018 14:22:56 -0400
Date:   Wed, 17 Oct 2018 14:22:56 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Ben Peart <peartben@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v1 1/2] reset: don't compute unstaged changes after reset
 when --quiet
Message-ID: <20181017182255.GC28326@sigill.intra.peff.net>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181017164021.15204-2-peartben@gmail.com>
 <CAPig+cSiE-M9QMch4WE7y4cib1FBUNiaR2pGGtbDuqiz6juhaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSiE-M9QMch4WE7y4cib1FBUNiaR2pGGtbDuqiz6juhaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 02:14:32PM -0400, Eric Sunshine wrote:

> > diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> > @@ -95,7 +95,9 @@ OPTIONS
> >  --quiet::
> > -       Be quiet, only report errors.
> > +       Be quiet, only report errors.  Can optimize the performance of reset
> > +       by avoiding scaning all files in the repo looking for additional
> > +       unstaged changes.
> 
> s/scaning/scanning/
> 
> However, I'm not convinced that this should be documented here or at
> least in this fashion. When I read this new documentation before
> reading the commit message, I was baffled by what it was trying to say
> since --quiet'ness is a superficial quality, not an optimizer. My
> knee-jerk reaction is that it doesn't belong in end-user documentation
> at all since it's an implementation detail, however, I can see that
> such knowledge could be handy for people in situations which would be
> helped by this. That said, if you do document it, this doesn't feel
> like the correct place to do so; it should be in a "Discussion"
> section or something. (Who would expect to find --quiet documentation
> talking about optimizations? Likely, nobody.)

Yeah, I had the same thought. You'd probably choose --quiet because you
want it, you know, quiet.

Whereas for the new config variable, you'd probably set it not because
you want it quiet all the time, but because you want to get some time
savings. So there it does make sense to me to explain.

Other than that, this seems like an obvious and easy win. It does feel a
little hacky (you're really losing something in the output, and ideally
we'd just be able to give that answer quickly), but this may be OK as a
hack in the interim.

The sad thing is just that it's user-facing, so we have to respect it
forever. I almost wonder if there should be a global core.optimizeMessages
or something that tries to tradeoff less information for speed in all
commands, but makes no promises about which. Then a user with a big repo
who sets it once will get the benefit as more areas are identified (I
think "status" already has a similar case with ahead/behind)? And vice
versa, as some messages get faster to produce, they can be dropped from
that option.

I dunno. Maybe that is a stupid idea, and people really do want to
control it on a per-message basis.

-Peff
