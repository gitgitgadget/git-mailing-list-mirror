Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C7831F453
	for <e@80x24.org>; Wed,  6 Feb 2019 21:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBFVOQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 16:14:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:35130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726379AbfBFVOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 16:14:16 -0500
Received: (qmail 22116 invoked by uid 109); 6 Feb 2019 21:14:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Feb 2019 21:14:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5775 invoked by uid 111); 6 Feb 2019 21:14:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 16:14:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 16:14:14 -0500
Date:   Wed, 6 Feb 2019 16:14:14 -0500
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] remote-curl: refactor smart-http discovery
Message-ID: <20190206211414.GA12737@sigill.intra.peff.net>
References: <20190206191657.GE10231@sigill.intra.peff.net>
 <20190206191848.GA10893@sigill.intra.peff.net>
 <20190206192903.GE72177@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190206192903.GE72177@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 11:29:03AM -0800, Josh Steadmon wrote:

> > +	packet_reader_init(&reader, -1, d->buf, d->len,
> > +			   PACKET_READ_CHOMP_NEWLINE |
> > +			   PACKET_READ_DIE_ON_ERR_PACKET);
> > +	if (packet_reader_read(&reader) != PACKET_READ_NORMAL)
> > +		die("invalid server response; expected service, got flush packet");
> 
> This can also trigger on an EOF or a delim packet, should we clarify the
> error message?

Maybe, though I'd prefer to do it as a patch on top; these lines were
moved straight from the existing code.

> > +	if (skip_prefix(reader.line, "# service=", &p) && !strcmp(p, service)) {
> > +		/*
> > +		 * The header can include additional metadata lines, up
> > +		 * until a packet flush marker.  Ignore these now, but
> > +		 * in the future we might start to scan them.
> > +		 */
> > +		for (;;) {
> > +			packet_reader_read(&reader);
> > +			if (reader.pktlen <= 0) {
> > +				break;
> > +			}
> > +		}
> 
> Could we make this loop cleaner as:
> 
> while (packet_reader_read(&reader) != PACKET_READ_NORMAL)
>   ;

Likewise here.

-Peff
