Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B9BD1FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 11:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034269AbdD1LIc (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 07:08:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:41647 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032305AbdD1LIb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 07:08:31 -0400
Received: (qmail 12859 invoked by uid 109); 28 Apr 2017 11:08:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 11:08:29 +0000
Received: (qmail 18678 invoked by uid 111); 28 Apr 2017 11:08:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 07:08:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 07:08:27 -0400
Date:   Fri, 28 Apr 2017 07:08:27 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/26] Check for EOF while parsing mails
Message-ID: <20170428110827.7kiwidz7ks3o2d2o@sigill.intra.peff.net>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
 <1fb841cee32996ee9194c2bd33b9dfe74cc37726.1493237937.git.johannes.schindelin@gmx.de>
 <20170427062114.p367j6rojnw4aj5r@sigill.intra.peff.net>
 <alpine.DEB.2.20.1704281241260.3480@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704281241260.3480@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 12:44:52PM +0200, Johannes Schindelin wrote:

> > Also, what is the behavior of ungetc when we pass it EOF?
> 
> According to the documentation, it would cast EOF to an unsigned char and
> push that back. Definitely incorrect.
> 
> > It looks like POSIX does what we want (pushing EOF is a noop, and the
> > stream retains its feof() status), but I don't know if there are other
> > implementations to worry about.
> 
> That's not what my man page here says:
> 
> 	ungetc()  pushes  c  back to stream, cast to unsigned char, where
> 	it is available for subsequent read operations.  Pushed-back
> 	characters will be returned in reverse order; only one pushback is
> 	guaranteed.

POSIX covers this this case explicitly:

  If the value of c equals that of the macro EOF, the operation shall
  fail and the input stream shall be left unchanged.

That comes straight from C99, which says:

  If the value of c equals that of the macro EOF, the operation fails
  and the input stream is unchanged.

I don't have a copy of C89 handy, but I didn't see any mention of the
behavior in the "changes from the previous edition" section of C99.

So it's possible that there's an implementation that is unhappy with
ungetc(EOF), but unless we know of one specifically, it seems pretty
safe. Given that and the similar explicit rule for EOF via isspace(), I
think the original code actually behaves fine.

Of course, we do not use the standard isspace() anyway. Our
implementation will cast the EOF to an unsigned char. If it's "-1", that
ends up as 255, which matches no classes. But if the platform has an
oddball EOF like 288, that would confuse our isspace().

-Peff
