Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793C120196
	for <e@80x24.org>; Thu, 14 Jul 2016 18:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbcGNSYb (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 14:24:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:44781 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751155AbcGNSYa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 14:24:30 -0400
Received: (qmail 8818 invoked by uid 102); 14 Jul 2016 18:24:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 14:24:30 -0400
Received: (qmail 6804 invoked by uid 107); 14 Jul 2016 18:24:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jul 2016 14:24:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2016 14:24:27 -0400
Date:	Thu, 14 Jul 2016 14:24:27 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
Message-ID: <20160714182427.GC16497@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net>
 <20160630090857.GB17463@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607141745420.6426@virtualbox>
 <19a2d02e-3918-3bc9-db34-66e12ab950e4@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19a2d02e-3918-3bc9-db34-66e12ab950e4@kdbg.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 06:45:47PM +0200, Johannes Sixt wrote:

> Am 14.07.2016 um 17:47 schrieb Johannes Schindelin:
> > On Thu, 30 Jun 2016, Jeff King wrote:
> > > The ustar format only has room for 11 (or 12, depending on
> > > some implementations) octal digits for the size and mtime of
> > > each file. For values larger than this, we have to add pax
> > > extended headers to specify the real data, and git does not
> > > yet know how to do so.
> > > 
> > > [...]
> > >  t/t5000/19f9c8273ec45a8938e6999cb59b3ff66739902a | Bin 0 -> 2048 bytes
> > 
> > It appears that this blob cannot be read when sizeof(unsigned long) == 4.
> > This happens to break the t5000 test on Windows, where that comparison
> > holds true.
> 
> The problem occurs in parse_sha1_header_extended(), where the calculation of
> the size in the object header overflows our 32-bit unsigned long.

Yep, unsurprising.

I do think git is wrong to use "unsigned long" there. It really ought to
be "size_t". My understanding is that 64-bit Windows is LLP64, which
means that you cannot currently have blobs greater than 4GB there, even
though it would work correctly with size_t.

Switching all of the things that look at blob sizes to size_t will be a
big job, though.

-Peff
