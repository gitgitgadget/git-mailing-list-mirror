Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15715C2BB55
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 17:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6012075E
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 17:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDGRox (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:44:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:36092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726277AbgDGRow (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 13:44:52 -0400
Received: (qmail 3092 invoked by uid 109); 7 Apr 2020 17:44:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Apr 2020 17:44:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30621 invoked by uid 111); 7 Apr 2020 17:55:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2020 13:55:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Apr 2020 13:44:49 -0400
From:   Jeff King <peff@peff.net>
To:     Joe Perches <joe@perches.com>
Cc:     Olaf Hering <olaf@aepfle.de>, linux-kernel@vger.kernel.org,
        git@vger.kernel.org
Subject: Re: get_maintainer.pl sends bogus addresses to git send-email
Message-ID: <20200407174449.GA1884106@coredump.intra.peff.net>
References: <20200407154046.GA15368@aepfle.de>
 <20200407170257.GA1844923@coredump.intra.peff.net>
 <2e6975d606846c834a387c07ee11cdce52356586.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e6975d606846c834a387c07ee11cdce52356586.camel@perches.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 07, 2020 at 10:18:41AM -0700, Joe Perches wrote:

> On Tue, 2020-04-07 at 13:02 -0400, Jeff King wrote:
> > On Tue, Apr 07, 2020 at 05:40:46PM +0200, Olaf Hering wrote:
> > 
> > > For me sending patches via git send-email fails because email address
> > > conversion is failing. Something appends a ')' to x86/lkml@kernel.org.
> > > I suspect the double '))' in MAINTAINERS is confusing the command.
> > > I tried to send the trivial patch from v5.0 and v5.6 tag.
> > > 
> > > Is this a failure in ./scripts/get_maintainer.pl,
> > > or is this something git does internally?
> > > I'm sure others use such command on a daily basis, so likely something on
> > > my end became broken at some point in the past.
> > 
> > It's a bug in send-email's hand-rolled address parser, which was fixed
> > in bd869f67b9 (send-email: add and use a local copy of Mail::Address,
> > 2018-01-05). Upgrade to Git v2.17.0 or newer.
> 
> Not really.
> You need to add --norolestats on the get_maintainer command line
> 
> git send-email expects bare email addresses, not ones annotated
> with additional content.

I agree that dropping them from the output is even better, if you'd
never want them to be sent.

Syntactically they are rfc822 comments, and send-email _should_ be able
to handle them (and does in recent versions).

> For instance:
> 
> $ ./scripts/get_maintainer.pl -f lib/vsprintf.c
> Petr Mladek <pmladek@suse.com> (maintainer:VSPRINTF)
> Steven Rostedt <rostedt@goodmis.org> (maintainer:VSPRINTF)
> Sergey Senozhatsky <sergey.senozhatsky@gmail.com> (maintainer:VSPRINTF)
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> (reviewer:VSPRINTF)
> Rasmus Villemoes <linux@rasmusvillemoes.dk> (reviewer:VSPRINTF)

In all of these cases send-email will drop the bit in parentheses.

> linux-kernel@vger.kernel.org (open list)

In this one, I think that the comment will be used as the name field,
since there isn't one.

-Peff
