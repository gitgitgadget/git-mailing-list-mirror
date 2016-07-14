Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06FEA203BD
	for <e@80x24.org>; Thu, 14 Jul 2016 22:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbcGNWir (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 18:38:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:45086 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752092AbcGNWiq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 18:38:46 -0400
Received: (qmail 19865 invoked by uid 102); 14 Jul 2016 22:38:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 18:38:46 -0400
Received: (qmail 10647 invoked by uid 107); 14 Jul 2016 22:39:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 18:39:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 18:38:43 -0400
Date:	Thu, 14 Jul 2016 18:38:43 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
Message-ID: <20160714223843.GA22196@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090857.GB17463@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607141745420.6426@virtualbox>
 <19a2d02e-3918-3bc9-db34-66e12ab950e4@kdbg.org>
 <xmqqa8hkrvu5.fsf@gitster.mtv.corp.google.com>
 <3d71cf3a-44c7-0620-0375-fb7ecf2fac13@kdbg.org>
 <20160714213222.GA20645@sigill.intra.peff.net>
 <xmqqpoqfonrx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpoqfonrx.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 03:30:58PM -0700, Junio C Hamano wrote:

> > If we move to time_t everywhere, I think we'll need an extra
> > TIME_T_IS_64BIT, but we can cross that bridge when we come to it.
> >
> > Likewise I think we'll need SIZE_T_IS_64BIT eventually (for real 32-bit
> > systems; LLP64 systems like Windows will then be able to run the test).
> 
> I guess I wrote essentially the same thing before refreshing my
> Inbox.
> 
> I am a bit fuzzy between off_t and size_t; the former is for the
> size of things you see on the filesystem, while the latter is for
> you to give malloc(3).  I would have thought that off_t is the type
> we would want at the end of the raw object header, denoting the size
> of a blob object when deflated, which could be larger than the size
> of a region of memory we can get from malloc(3), in which case we
> would use the streaming interface.

Yeah, your understanding is right (s/deflated/inflated/). I agree that
off_t is probably a better size for blobs. Traditionally git assumed any
object could fit in memory. The streaming interface helps that somewhat,
but I think there are cases where we still must load a blob (e.g., if it
is stored as a delta). In theory that never happens because of
core.bigfilethreshold, but you may get a packfile from somebody with a
higher threshold than you.

I wouldn't be surprised if there are other cases that aren't smart
enough to use the streaming interface yet, but the solution there is to
make them smarter. :)

So off_t is probably better. We do need to be careful, though, when
allocating objects. E.g., this:

  off_t size;
  struct git_istream *stream;
  void *buf;

  stream = open_istream(sha1, &type, &size, NULL);
  buf = xmalloc(size);
  while (1) {
	/* read stream into buf */
  }

is a security hole when size_t is less than off_t (it gets truncated in
the call to xmalloc, which allocates too few bytes). This is a toy
example, obviously, but it's something to watch out for.

-Peff
