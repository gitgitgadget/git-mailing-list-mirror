Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23511FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 11:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161844AbdD1LUG (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 07:20:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:41656 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967862AbdD1LUF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 07:20:05 -0400
Received: (qmail 13576 invoked by uid 109); 28 Apr 2017 11:20:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 11:20:04 +0000
Received: (qmail 18760 invoked by uid 111); 28 Apr 2017 11:20:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 07:20:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 07:20:02 -0400
Date:   Fri, 28 Apr 2017 07:20:02 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/26] Check for EOF while parsing mails
Message-ID: <20170428112002.tjkcjjdfqenl2aie@sigill.intra.peff.net>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
 <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de>
 <6cc5670f-2de3-33f2-3c85-5a6d99fcca12@kdbg.org>
 <alpine.DEB.2.20.1704281206500.3480@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704281206500.3480@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 12:41:02PM +0200, Johannes Schindelin wrote:

> > Why? isspace(EOF) is well-defined.
> 
> So let's look at the man page on Linux:
> 
> 	These functions check whether c,  which  must  have  the  value  of  an
> 	unsigned char or EOF, [...]
> 
> That is the only mention of it. I find it highly unobvious whether EOF
> should be treated as a space or not. So let's look at the MSDN page
> (https://msdn.microsoft.com/en-us/library/y13z34da.aspx) whether they talk
> more about EOF:
> 
> 	The behavior of isspace and _isspace_l is undefined if c is not
> 	EOF or in the range 0 through 0xFF, inclusive.
> 
> That's it. So I kind of *guess* that EOF is treated as not being a
> whitespace character (why does this make me think of politics now? Focus,
> Johannes, focus...). But the mathematician in me protests: why would we
> be able to decide the character class of a character that does not exist?

This behavior actually comes from the C standard. From C99, 7.4:

  1 The header <ctype.h> declares several functions useful for
    classifying and mapping characters. 166) In all cases the argument
    is an int, the value of which shall be representable as an unsigned
    char or shall equal the value of the macro EOF. If the argument has
    any other value, the behavior is undefined.

It doesn't explicitly say that EOF returns false for these functions,
but it does seem implied. For instance:

  The isspace function tests for any character that is a standard
  white-space character or is one of a locale-specific set of characters
  for which isalnum is false. The standard white-space characters are
  the following: space (' '), form feed ('\f'), new-line ('\n'),
  carriage return ('\r'), horizontal tab ('\t'), and vertical tab
  ('\v'). In the "C" locale, isspace returns true only for the standard
  white-space characters.

So I think it is a reasonable thing to depend on.  But as I said
elsewhere in the thread, we don't actually use the standard isspace()
anyway.

> But then, I guess I misunderstood what Coverity complained about: maybe
> the problem was not so much the isspace() call but that EOF is not being
> handled correctly. We pass it, unchecked, to ungetc().
> 
> It appears that I (or Coverity, if you will), missed another instance
> where we simply passed EOF unchecked to ungetc().

I think that is also fine according to the standard.

Do you happen to have the exact error from Coverity? I'm wondering if it
is complaining about some aspect of our custom isspace() when used with
EOF.

> The next iteration will have it completely reworked: I no longer guard the
> isspace() behind an `!= EOF` check, but rather handle an early EOF as I
> think it should be handled. Extra eyes very welcome (this is the fixup!
> patch):

I do think handling EOF explicitly is probably a better strategy anyway,
as it lets us tell when we have an empty patch.

-Peff
