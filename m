Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8B8A1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 21:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758378AbcHCVjZ (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 17:39:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:54248 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757411AbcHCVjY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 17:39:24 -0400
Received: (qmail 19199 invoked by uid 102); 3 Aug 2016 21:39:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 17:39:24 -0400
Received: (qmail 6207 invoked by uid 107); 3 Aug 2016 21:39:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 17:39:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 17:39:20 -0400
Date:	Wed, 3 Aug 2016 17:39:20 -0400
From:	Jeff King <peff@peff.net>
To:	larsxschneider@gmail.com
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 03/12] pkt-line: add packet_flush_gentle()
Message-ID: <20160803213920.jg3eshy57bsldqjh@sigill.intra.peff.net>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-4-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160803164225.46355-4-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 06:42:16PM +0200, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> packet_flush() would die in case of a write error even though for some callers
> an error would be acceptable. Add packet_flush_gentle() which writes a pkt-line
> flush packet and returns `0` for success and `1` for failure.

Our normal convention would be "0" for success, "-1" for failure.

I see write_or_whine_pipe(), which you use here, has a bizarre "0 for
failure, 1 for success", but that nobody actually checks it.

I actually think you probably don't want to use write_or_whine_pipe()
here. It does two things:

  1. It writes to stderr unconditionally. But if you are doing a
     "gently" form, then you probably don't want unconditional errors.
     Since the point of not dying is that you could presumably recover
     in some way, or do some other more intelligent action.

     The existing callers of write_or_whine_pipe() are all in the trace
     code. Their use is not "let's handle an error", but "we _would_ die
     except that this is low-priority debugging code that should not
     interrupt the normal flow". So there it at least makes sense to
     unconditionally complain to stderr, but not to die().

     For your series, I don't think that is true (and especially for
     most potential callers of a generic "gently flush the packet"
     function).

  2. It calls check_pipe(), which will turn EPIPE into death-by-SIGPIPE
     (in case you had for some reason ignored SIGPIPE).

     But I think that's the opposite of what you want. You know you're
     writing to a pipe, and I would think EPIPE is the most common
     reason that your writes would fail (i.e., the helper unexpectedly
     died while you were writing to it).

     So you would want to explicitly ignore SIGPIPE while talking to the
     helper, and then handle EPIPE just as any other error.

Thinking about (2), I'd go so far as to say that the trace actually
should just be using:

  if (write_in_full(...) < 0)
	warning("unable to write trace to ...: %s", strerror(errno));

and we should get rid of write_or_whine_pipe entirely.

-Peff
