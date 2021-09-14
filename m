Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01785C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49156113B
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhINRRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:17:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:47186 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhINRRY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:17:24 -0400
Received: (qmail 24600 invoked by uid 109); 14 Sep 2021 17:16:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 17:16:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25545 invoked by uid 111); 14 Sep 2021 17:16:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 13:16:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 13:16:05 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 6/9] serve: drop "keys" strvec
Message-ID: <YUDY1UIFBxOjNA37@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUDAvjteb/JAtyNz@coredump.intra.peff.net>
 <YUDU5gE/AazOus+s@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUDU5gE/AazOus+s@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 12:59:18PM -0400, Taylor Blau wrote:

> On Tue, Sep 14, 2021 at 11:33:18AM -0400, Jeff King wrote:
> > We collect the set of capabilities the client sends us in a strvec.
> > While this is usually small, there's no limit to the number of
> > capabilities the client can send us (e.g., they could just send us
> > "agent" pkt-lines over and over, and we'd keep adding them to the list).
> >
> > Since all code has been converted away from using this list, let's get
> > rid of it. This avoids a potential attack where clients waste our
> > memory.
> 
> ...because now we only bother to tell capabilities about information the
> client sent as it happened, instead of accumulating an unbounded set of
> strings together into a single strvec.

Right. By the way, one thing I noticed while working on this (that is
unchanged by my series) is that some capabilities are ignored. That make
sense for "agent", where the primary goal is telling the client about
our version (and letting them speak their version, which might be
helpful for debug logs but doesn't impact the protocol itself). But we
do nothing at all with "server-option".

The client wouldn't send one by default, but we do support "git fetch
--server-option". So I assume that it would be a sort of "I'll tell you
this string, and you might feed it to hooks, etc" function, like
push-options. But we just throw it away (well, before my series we
stuffed it into a strvec that nobody looked at).

So possibly we could stop advertising it, but I wonder if any clients
would get unhappy.

I also wonder if jgit uses it. Grepping in jgit.git shows that it is
recorded but I don't see anybody doing anything useful with it; but
maybe some user of the library does.

> > @@ -263,10 +263,11 @@ static int process_request(void)
> >  			/* collect request; a sequence of keys and values */
> >  			if (parse_command(reader.line, &command) ||
> >  			    receive_client_capability(reader.line))
> > -				strvec_push(&keys, reader.line);
> > +				seen_capability_or_command = 1;
> >  			else
> >  				die("unknown capability '%s'", reader.line);
> >
> > +
> 
> Nit; unnecessary whitespace change (but obviously not worth a re-roll on
> its own).

Thanks. While this section ended up quite simple, it got rebased a whole
lot of times as I figured out all of quirks that led to the final
protocol-tightening patches. :)

I don't know how I missed the extra line on my final read-through.

-Peff
