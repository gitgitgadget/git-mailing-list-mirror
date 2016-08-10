Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BBAE1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934512AbcHJTkU (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:40:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:53144 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935849AbcHJTkS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:40:18 -0400
Received: (qmail 23251 invoked by uid 109); 10 Aug 2016 12:32:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 12:32:03 +0000
Received: (qmail 31373 invoked by uid 111); 10 Aug 2016 12:32:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 08:32:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Aug 2016 08:32:02 -0400
Date:	Wed, 10 Aug 2016 08:32:02 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] http-backend: buffer headers before sending
Message-ID: <20160810123201.ylfsnzmubpmtyoaa@sigill.intra.peff.net>
References: <20160809234731.GA10310@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160809234731.GA10310@dcvr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 11:47:31PM +0000, Eric Wong wrote:

> Avoid waking up the readers for unnecessary context switches for
> each line of header data being written, as all the headers are
> written in short succession.
> 
> It is unlikely any HTTP/1.x server would want to read a CGI
> response one-line-at-a-time and trickle each to the client.
> Instead, I'd expect HTTP servers want to minimize syscall and
> TCP/IP framing overhead by trying to send all of its response
> headers in a single syscall or even combining the headers and
> first chunk of the body with MSG_MORE or writev.
> 
> Verified by strace-ing response parsing on the CGI side.

I don't think this is wrong to do, but it does feel like it makes the
code slightly more brittle (you have to pass around the strbuf and
remember to initialize it and end_headers() when you're done), for not
much benefit.

Using some kind of buffered I/O would be nicer, as then you would get
nice-sized chunks without having to impact the code. I wonder if just
using stdio here would be that bad. The place it usually sucks is in
complex error handling, but we don't care about that at all here (I
think we are basically happy to write until we get SIGPIPE).

I dunno. I suspect the performance improvement from your patch is
marginal, but it's not like the resulting code is all _that_ complex. So
I guess I am OK either way, just not enthused.

> ---
>   I admit I only noticed this because I was being lazy when
>   implementing the reader-side on an HTTP server by making
>   a single read(2) call :x

The trouble is that your HTTP server is still broken. Now it's just
broken in an unpredictable and racy way, because the OS may still split
the write at PIPE_BUF boundaries. (Though given that this is not in the
commit message, I suspect you know this patch is not an excuse not to
fix your HTTP server).

-Peff
