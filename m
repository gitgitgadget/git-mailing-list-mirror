Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B5DD1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbcG2SL0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:11:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:51214 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753130AbcG2SLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:11:25 -0400
Received: (qmail 5905 invoked by uid 102); 29 Jul 2016 18:11:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:11:25 -0400
Received: (qmail 3888 invoked by uid 107); 29 Jul 2016 18:11:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:11:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 14:11:22 -0400
Date:	Fri, 29 Jul 2016 14:11:22 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Dakota Hawkins <dakotahawkins@gmail.com>, git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" +
 "pull.rebase = preserve" - "user.email"
Message-ID: <20160729181121.GB14953@sigill.intra.peff.net>
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
 <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 10:47:27AM -0700, Junio C Hamano wrote:

> > In those cases specifically, I never have local commits that differ
> > from the remote, so a "pull --ff-only" should leave me in the same
> > state as a "pull --rebase".
> >
> > Is this a case of rebase trying to make sure it has enough information
> > for me to be a committer before knowing whether I even need to rewrite
> > any commits, and could/should that be avoided?  Alternatively (or also)
> > could/should rebase detect that a fast-forward is possible and prefer
> > to do that instead?
> 
> I think that is a reasonable argument, but to solve this for a more
> general case, shouldn't we be discussing a solution that would also
> work when rebase _does_ need to create a new commit?  And when the
> latter is solved, I would imagine that "this rebase happens to be
> fast-forward, and not having an ident shouldn't be an issue for this
> special case" would become moot.

Wouldn't it be wrong to create a commit with non-config ident when
user.useConfigOnly is set, though? That is the exact point when it
should kick in, to tell the user "you thought it would not matter here,
but in this case we _do_ need your real ident; what should we do?"

If the user is doing a one-off thing where they do not care if their
crappy, fake ident makes it into a commit object, then the right thing
is:

  git -c user.useConfigOnly=false pull --rebase

or even:

  git -c user.email=fake-but-ok@example.com pull --rebase

And they can do that preemptively for commands like the golang example
here. They shouldn't _have_ to do that, though, if the command wouldn't
actually create a commit. So I do think there may be a bug to be fixed,
but it is simply commands being over-eager to make sure we have an
ident when they might not need it.

-Peff
