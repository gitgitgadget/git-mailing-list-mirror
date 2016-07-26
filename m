Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E161D203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 13:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756383AbcGZNnf (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 09:43:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:49202 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756385AbcGZNnB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 09:43:01 -0400
Received: (qmail 25662 invoked by uid 102); 26 Jul 2016 13:43:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 09:43:00 -0400
Received: (qmail 2157 invoked by uid 107); 26 Jul 2016 13:43:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 26 Jul 2016 09:43:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jul 2016 09:42:57 -0400
Date:	Tue, 26 Jul 2016 09:42:57 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>, schacon@gmail.com
Subject: Re: LARGE_PACKET_MAX wrong?
Message-ID: <20160726134257.GB19277@sigill.intra.peff.net>
References: <077B805D-B618-41B2-84A6-BA2E3E5644F2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <077B805D-B618-41B2-84A6-BA2E3E5644F2@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 03:07:41PM +0200, Lars Schneider wrote:

> I am reading the pkt-line code and stumbled across this oddity:
> 
> LARGE_PACKET_MAX is defined as 65520
> https://github.com/git/git/blob/8c6d1f9807c67532e7fb545a944b064faff0f70b/pkt-line.h#L79
> 
> In `format_packet` we check that the 4 bytes of length data plus payload is not larger than LARGE_PACKET_MAX (= 65520)
> https://github.com/git/git/blob/8c6d1f9807c67532e7fb545a944b064faff0f70b/pkt-line.c#L111-L112
> 
> However, in the documentation we state that 4 bytes of length data plus payload must not exceed 65524
> https://github.com/git/git/blob/8c6d1f9807c67532e7fb545a944b064faff0f70b/Documentation/technical/protocol-common.txt#L70-L72
> 
> Who is right? Code or documentation? 

I think the documentation is wrong. Git's packet_read() will complain on
a 65524-byte incoming packet (it actually handles up to 65523, but that
is simply a quirk of the implementation).

The sending sides always include the 4-byte header in the
LARGE_PACKET_MAX calculations.

So I don't know what was intended once upon a time, but I think we have
to stick to what the code does, because there are many deployed
instances that we cannot break compatibility with.

-Peff
