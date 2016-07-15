Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6452720195
	for <e@80x24.org>; Fri, 15 Jul 2016 13:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbcGONqN (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 09:46:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:45461 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752559AbcGONqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 09:46:12 -0400
Received: (qmail 26684 invoked by uid 102); 15 Jul 2016 13:46:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 09:46:11 -0400
Received: (qmail 16125 invoked by uid 107); 15 Jul 2016 13:46:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jul 2016 09:46:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2016 09:46:09 -0400
Date:	Fri, 15 Jul 2016 09:46:09 -0400
From:	Jeff King <peff@peff.net>
To:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:	Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
Message-ID: <20160715134608.GA22802@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090857.GB17463@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607141745420.6426@virtualbox>
 <19a2d02e-3918-3bc9-db34-66e12ab950e4@kdbg.org>
 <xmqqa8hkrvu5.fsf@gitster.mtv.corp.google.com>
 <3d71cf3a-44c7-0620-0375-fb7ecf2fac13@kdbg.org>
 <20160714213222.GA20645@sigill.intra.peff.net>
 <xmqqpoqfonrx.fsf@gitster.mtv.corp.google.com>
 <20160714223843.GA22196@sigill.intra.peff.net>
 <5b99a4bb-9b8e-e8c6-e214-e041209cb6e6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b99a4bb-9b8e-e8c6-e214-e041209cb6e6@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 03:37:32PM +0200, Torsten Bögershausen wrote:

> > So off_t is probably better. We do need to be careful, though, when
> > allocating objects. E.g., this:
> > 
> >   off_t size;
> >   struct git_istream *stream;
> >   void *buf;
> > 
> >   stream = open_istream(sha1, &type, &size, NULL);
> >   buf = xmalloc(size);
> >   while (1) {
> > 	/* read stream into buf */
> >   }
> > 
> > is a security hole when size_t is less than off_t (it gets truncated in
> > the call to xmalloc, which allocates too few bytes). This is a toy
> > example, obviously, but it's something to watch out for.
> > 
> That code is "illegal", it should be
>  buf = xmalloc(xsize_t(size));

Sure, I agree. The point is that it is easy to forget the extra
wrapper/check, and we should be aware of it. I don't think the compiler
will warn you (probably some static analyzers would, though).

> - Use the streaming interface to analyze if blobs are binary
>   (That is already on my list, the old "stream and early out"
>   from the olc 10/10, gmane/$293010 or so can be reused)

You might be interested in

  https://github.com/peff/git/commit/2fb07bc91f3ac6162c3dd5667d8167fc0bec6d99

I don't remember if it produced good results or not (ISTR that the cost
of setting up the streaming sometimes overwhelmed any benefit).

-Peff
