Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 502B820196
	for <e@80x24.org>; Thu, 14 Jul 2016 18:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbcGNSVN (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 14:21:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:44772 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751730AbcGNSVL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 14:21:11 -0400
Received: (qmail 8686 invoked by uid 102); 14 Jul 2016 18:21:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 14:21:11 -0400
Received: (qmail 6780 invoked by uid 107); 14 Jul 2016 18:21:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 14:21:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 14:21:08 -0400
Date:	Thu, 14 Jul 2016 14:21:08 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
Message-ID: <20160714182108.GB16497@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090857.GB17463@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607141745420.6426@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607141745420.6426@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 05:47:41PM +0200, Johannes Schindelin wrote:

> On Thu, 30 Jun 2016, Jeff King wrote:
> 
> > The ustar format only has room for 11 (or 12, depending on
> > some implementations) octal digits for the size and mtime of
> > each file. For values larger than this, we have to add pax
> > extended headers to specify the real data, and git does not
> > yet know how to do so.
> >
> > [...]
> >  t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a | Bin 0 -> 2048 bytes
> 
> It appears that this blob cannot be read when sizeof(unsigned long) == 4.
> This happens to break the t5000 test on Windows, where that comparison
> holds true.
> 
> I am sure that I missed some other discussion about this issue... could
> you point me to it?

There's tons of discussion in:

  http://thread.gmane.org/gmane.comp.version-control.git/297409

but frankly it is not worth your time to read it. These tests are about
overflowing the tar limits, which can only happen with times and sizes
greater than 32-bits. The right thing to do is to skip the tests
entirely on systems where sizeof(unsigned long) is less than 8 (the
actual value is 64GB+1, so technically a 37-bit system would work, but I
think it is OK for the test-skipping to be less specific).

-Peff
