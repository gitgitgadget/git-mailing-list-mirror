Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 528B51FF40
	for <e@80x24.org>; Sun, 26 Jun 2016 23:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbcFZXtd (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 19:49:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:32978 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751695AbcFZXt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 19:49:28 -0400
Received: (qmail 18616 invoked by uid 102); 26 Jun 2016 23:49:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Jun 2016 19:49:27 -0400
Received: (qmail 4688 invoked by uid 107); 26 Jun 2016 23:49:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Jun 2016 19:49:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Jun 2016 19:49:25 -0400
Date:	Sun, 26 Jun 2016 19:49:25 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] xwrite: poll on non-blocking FDs
Message-ID: <20160626234925.GB21668@sigill.intra.peff.net>
References: <20160626232112.721-1-e@80x24.org>
 <20160626232112.721-3-e@80x24.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160626232112.721-3-e@80x24.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 26, 2016 at 11:21:12PM +0000, Eric Wong wrote:

> write(2) can hit the same EAGAIN/EWOULDBLOCK errors as read(2),
> so busy-looping on a non-blocking FD is a waste of resources.
> 
> Currently, I do not know of a way for this happen:
> 
> * the NonBlocking directive in systemd does not apply to stdin,
>   stdout, or stderr.
> 
> * xinetd provides no way to set the non-blocking flag at all
> 
> But theoretically, it's possible a careless C10K HTTP server
> could use pipe2(..., O_NONBLOCK) to setup a pipe for
> git-http-backend with only the intent to use non-blocking reads;
> but accidentally leave non-blocking set on the write end passed
> as stdout to git-upload-pack.
> 
> Followup-to: 1079c4be0b720 ("xread: poll on non blocking fds")

I think this is sensible. I don't know of a way for it to happen either,
but who knows what environments people will spawn git in (especially
http-backend, as we are at the mercy of the webserver).

So it's a good defensive measure, it shouldn't affect normal use at all
(because blocking descriptors would never return EAGAIN), and it can't
possibly hurt anybody expecting to use xwrite() non-blockingly to get
EAGAIN (because we already spin on it; this just converts the spin to a
poll).

-Peff
