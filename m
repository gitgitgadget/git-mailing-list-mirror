Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_20,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76DA1FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 20:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbcFXU7D (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 16:59:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:60059 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751652AbcFXU7B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 16:59:01 -0400
Received: (qmail 3684 invoked by uid 102); 24 Jun 2016 20:59:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 16:59:00 -0400
Received: (qmail 22791 invoked by uid 107); 24 Jun 2016 20:59:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jun 2016 16:59:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jun 2016 16:58:58 -0400
Date:	Fri, 24 Jun 2016 16:58:58 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 1/4] t5000: test tar files that overflow ustar headers
Message-ID: <20160624205858.GA23315@sigill.intra.peff.net>
References: <20160623231512.GA27683@sigill.intra.peff.net>
 <20160623232041.GA3668@sigill.intra.peff.net>
 <xmqq1t3mh0vg.fsf@gitster.mtv.corp.google.com>
 <20160624190744.GA32118@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160624190744.GA32118@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jun 24, 2016 at 03:07:44PM -0400, Jeff King wrote:

> > "dd bs=1 count=4096" is hopefully more portable.
> 
> Hmm. I always wonder whether dd is actually very portable, but we do use
> it already, at least.
> 
> Perhaps the perl monstrosity in t9300 could be replaced with that, too.

Hrm. So I wrote a patch for t9300 for this. But I wanted to flip the
order to:

  dd bs=4096 count=1

because otherwise, dd will call read() 4096 times, for 1 byte each.

But it's not safe to do that on a pipe. For example:

  {
	echo 1
	sleep 1
	echo 2
  } | dd bs=4 count=1

will copy only 2 bytes. So it's racily wrong, depending on how the
writer feeds the data to write().

The 1-byte reads do work (assuming blocking descriptors and that dd
restarts a read after a signal, which mine seems to). But yuck.

The difference in time between the two is measurable on my system, but
it's only a few milliseconds (for 4096 bytes). So maybe it's not worth
worrying about (though as a general technique, it does make me worry
that it's easy to get wrong in a way that will fail racily).

-Peff
