Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F71620195
	for <e@80x24.org>; Sat, 16 Jul 2016 01:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbcGPB2A (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 21:28:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:45790 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751217AbcGPB17 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 21:27:59 -0400
Received: (qmail 23849 invoked by uid 102); 16 Jul 2016 01:28:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 21:28:00 -0400
Received: (qmail 20991 invoked by uid 107); 16 Jul 2016 01:28:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 21:28:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 21:27:56 -0400
Date:	Fri, 15 Jul 2016 21:27:56 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 05/12] check_connected: relay errors to alternate
 descriptor
Message-ID: <20160716012755.GC30820@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net>
 <20160715103203.GE19271@sigill.intra.peff.net>
 <xmqqbn1yn4r8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbn1yn4r8.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 11:19:23AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +	/*
> > +	 * If non-zero, send error messages to this descriptor rather
> > +	 * than stderr. The descriptor is closed before check_connected
> > +	 * returns.
> > +	 */
> > +	int err_fd;
> 
> Theoretically speaking it may be possible that a caller may want to
> write to fd#0 if it closed the standard input before creating the
> output channel for multiplexing into a sideband, but I think this
> design strikes a good balance between the theoretical correctness
> and usability.  Using err_fd == -1 as "no redirect" may allow the
> caller to redirect the errors to fd#0, but that forces normal users
> to explicitly set this field to -1.

Yep, I had all of those thoughts while writing it, but decided that "0"
was worth it to keep the initialization simple (though since we have
CHECK_CONNECTED_INIT, the "-1" would only have to appear there).

What decided me were two things:

  - directing to fd#0 really is theoretical; you'd have to close stdin,
    and you shouldn't do that. You should redirect it from /dev/null
    (and our sanitize_stdfds() makes sure that we're not surprised by
    any callers)

  - "struct child_process" uses a similar zero-initialization

-Peff
