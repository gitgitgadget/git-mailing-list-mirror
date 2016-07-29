Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08F401F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbcG2SjQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:39:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:51282 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751283AbcG2SjP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:39:15 -0400
Received: (qmail 7304 invoked by uid 102); 29 Jul 2016 18:39:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:39:15 -0400
Received: (qmail 4525 invoked by uid 107); 29 Jul 2016 18:39:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:39:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 14:39:12 -0400
Date:	Fri, 29 Jul 2016 14:39:12 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Dakota Hawkins <dakotahawkins@gmail.com>, git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" +
 "pull.rebase = preserve" - "user.email"
Message-ID: <20160729183911.GA10268@sigill.intra.peff.net>
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
 <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
 <20160729181121.GB14953@sigill.intra.peff.net>
 <xmqq60ronvlj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60ronvlj.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 11:32:40AM -0700, Junio C Hamano wrote:

> > Wouldn't it be wrong to create a commit with non-config ident when
> > user.useConfigOnly is set, though?
> 
> That is exactly what I was getting at.

Ah, OK, I thought you were trying to explore the opposite direction.

> > If the user is doing a one-off thing where they do not care if their
> > crappy, fake ident makes it into a commit object, then the right thing
> > is:
> >
> >   git -c user.useConfigOnly=false pull --rebase
> >
> > or even:
> >
> >   git -c user.email=fake-but-ok@example.com pull --rebase
> 
> Hmm, I somehow had an impression that these git commands are not
> what the end-user runs from the command line, but wrapper tools like
> "go get" has a hardcoded invocation of "git pull".

Yeah, the right person or entity to set those options is the one who
knows "the operation I am doing is OK even with bogus ident". I had
assumed if "go get" fell under that category, that it should be the one
to tell it to git (via the config above).

But I am not really sure that is the case. In general "go get" shouldn't
make commits if you aren't doing active work on the repo (AFAIK), and it
should just work.

From my limited testing, "git pull --rebase" is perfectly fine. The
culprit is "--rebase=preverse", which complains even if it would be a
fast-forward.

-Peff
