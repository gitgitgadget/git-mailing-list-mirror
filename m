Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DA8520A17
	for <e@80x24.org>; Mon, 16 Jan 2017 22:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbdAPWHd (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 17:07:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:39899 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751014AbdAPWHc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 17:07:32 -0500
Received: (qmail 22798 invoked by uid 109); 16 Jan 2017 22:00:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 22:00:17 +0000
Received: (qmail 12559 invoked by uid 111); 16 Jan 2017 22:01:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 17:01:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 17:00:14 -0500
Date:   Mon, 16 Jan 2017 17:00:14 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
Message-ID: <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net>
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
 <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
 <alpine.DEB.2.20.1701161251100.3469@virtualbox>
 <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701161746200.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701161746200.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2017 at 06:06:35PM +0100, Johannes Schindelin wrote:

> >      And I think that would apply to any input parameter we show via
> >      error(), etc, if it is connected to a newline (ideally we would
> >      show newlines as "?", too, but we cannot tell the difference
> >      between ones from parameters, and ones that are part of the error
> >      message).
> 
> I think it is doing users a really great disservice to munge up CR or LF
> into question marks. I *guarantee* you that it confuses users. And not
> because they are dumb, but because the code violates the Law of Least
> Surprise.

I'm not sure if you realize that with stock git, the example from your
test looks like this (at least in my terminal):

  $ git.v2.11.0 rev-parse --abbrev-ref "$(printf 'CR/LF\r\n')" >/dev/null
  ': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

The "\r" causes us to overwrite the rest of the message, including the
actual filename. With my patch it's:

  $ git rev-parse --abbrev-ref "$(printf 'CR/LF\r\n')" >/dev/null
  fatal: ambiguous argument 'CR/LF?': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

I am certainly sympathetic to the idea that the "?" is ugly and
potentially confusing. But I think it's at least a step forward for this
particular example.

I'll snip liberally from the rest of your response, because I think what
JSixt wrote covers it.

> > > While at it, let's lose the unnecessary curly braces.
> > 
> > Please don't. Obviously C treats the "if/else" as a single unit, but
> > IMHO it's less error-prone to include the braces any time there are
> > multiple visual lines. E.g., something like:
> > 
> >   while (foo)
> > 	if (bar)
> > 		one();
> > 	else
> > 		two();
> > 	three();
> > 
> > is much easier to spot as wrong when you would require braces either
> > way (and not relevant here, but I'd say that even an inner block with a
> > comment deserves braces for the same reason).
> 
> There is no documentation about the preferred coding style.

Documentation/CodingGuidelines says:

 - We avoid using braces unnecessarily.  I.e.

        if (bla) {
                x = 1;
        }

   is frowned upon.  A gray area is when the statement extends
   over a few lines, and/or you have a lengthy comment atop of
   it.  Also, like in the Linux kernel, if there is a long list
   of "else if" statements, it can make sense to add braces to
   single line blocks.

I think this is pretty clearly the "gray area" mentioned there. Which
yes, does not say "definitely do it this way", but I hope makes it clear
that you're supposed to use judgement about readability.

-Peff
