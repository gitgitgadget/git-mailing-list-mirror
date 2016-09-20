Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328F01F4F8
	for <e@80x24.org>; Tue, 20 Sep 2016 03:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbcITD5P (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 23:57:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:45396 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751518AbcITD5O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 23:57:14 -0400
Received: (qmail 22171 invoked by uid 109); 20 Sep 2016 03:57:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Sep 2016 03:57:13 +0000
Received: (qmail 16786 invoked by uid 111); 20 Sep 2016 03:57:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Sep 2016 23:57:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2016 20:57:11 -0700
Date:   Mon, 19 Sep 2016 20:57:11 -0700
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, Swift Geek <swiftgeek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mailinfo: unescape quoted-pair in header fields
Message-ID: <20160920035710.qw2byl3qeqwih7t5@sigill.intra.peff.net>
References: <20160916210204.31282-1-me@ikke.info>
 <20160916222206.jz2d4gpaxxccia5p@sigill.intra.peff.net>
 <20160919105133.GA10901@ikke.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160919105133.GA10901@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 12:51:33PM +0200, Kevin Daudt wrote:

> > I didn't look in the RFC. Is:
> > 
> >   From: my \"name\" <foo@example.com>
> > 
> > really the same as:
> > 
> >   From: "my \\\"name\\\"" <foo@example.com>
> > 
> > ? That seems weird, but I think it may be that the former is simply
> > bogus (you are not supposed to use backslashes outside of the quoted
> > section at all).
> 
> Correct, the quoted-pair (escape sequence) can only occur in a quoted
> string or a comment. Even more so, the display name *needs* to be quoted
> when consisting of more then one word according to the RFC.

Hmm. So, I guess a follow-up question is: what would it be OK to do if
we see a quoted-pair outside of quotes? If the top one above violates
the RFC, it seems like stripping the backslashes would be a reasonable
outcome.

So if that's the case, do we actually need to care if we see any
parenthesized comments? I think we should just leave comments in place
either way, so syntactically they are only interesting insofar as we
replace quoted pairs or not.

IOW, I wonder if:

  while ((c = *in++)) {
	switch (c) {
	case '\\':
		if (!*in)
			return 0; /* ignore trailing backslash */
		/* quoted pair */
		strbuf_addch(out, *in++);
		break;
	case '"':
		/*
		 * This may be starting or ending a quoted section,
		 * but we do not care whether we are in such a section.
		 * We _do_ need to remove the quotes, though, as they
		 * are syntactic.
		 */
		break;
	default:
		/*
		 * Anything else is a normal character we keep. These
		 * _might_ be violating the RFC if they are magic
		 * characters outside of a quoted section, but we'd
		 * rather be liberal and pass them through.
		 */
		strbuf_addch(out, c);
		break;
	}
  }

would work. I certainly do not mind following the RFC more closely, but
AFAICT the very simple code above gives a pretty forgiving outcome.

> > This is obviously getting pretty silly, but if we are going to follow
> > the RFC, I think you actually have to do a recursive parse, and keep
> > track of an arbitrary depth of context.
> > 
> > I dunno. This method probably covers most cases in practice, and it's
> > easy to reason about.
> 
> The problem is, how do you differentiate between nested comments, and
> escaped braces within a comment after one run?

I'm not sure what you mean. Escaped characters are always handled first
in your loop. Can you give an example (although if you agree with what I
wrote above, it may not be worth discussing further)?

-Peff
