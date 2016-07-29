Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4363B1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 15:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbcG2P5p (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 11:57:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:51066 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751695AbcG2P5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 11:57:43 -0400
Received: (qmail 30804 invoked by uid 102); 29 Jul 2016 15:57:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 11:57:43 -0400
Received: (qmail 2492 invoked by uid 107); 29 Jul 2016 15:58:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 11:58:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 11:57:40 -0400
Date:	Fri, 29 Jul 2016 11:57:40 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	mlbright@gmail.com,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>, e@80x24.org,
	ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 0/5] Git filter protocol
Message-ID: <20160729155740.GB29773@sigill.intra.peff.net>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <579906C5.1050809@gmail.com>
 <BFED7ED8-40DB-46B5-A1B7-4F49624D5A62@gmail.com>
 <20160728132906.GA21311@sigill.intra.peff.net>
 <579B087F.7090108@gmail.com>
 <31219A33-CA8A-44D1-9DE0-6448AA1A7571@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31219A33-CA8A-44D1-9DE0-6448AA1A7571@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 10:14:17AM +0200, Lars Schneider wrote:

> My current implementation supports only two cases. Either the filter
> knows the size and sends it back. Or the filter doesn't know the size
> and Git reads until the flush packet (your "unknown" case). "Approx" is 
> probably hard to do and fail shouldn't be part of the size, no?

Ah, OK, I missed that you could handle both cases. I think that is a
reasonable approach. It means the filter has to bother with pkt-lines,
but beyond that, it can choose the simple or streaming approach as
appropriate.

> That being said a "fail" response is a very good idea! This allows
> the filter to communicate to git that a non required filter process
> failed. I will add that to the protocol. Thanks :) 

Maybe just send "ok <size>", "ok -1" (for streaming), or "fail <reason>"
followed by the content? That is similar to other Git protocols, though
I am not sure they are good models for sanity or extensibility. :)

I don't know if you would want to leave room for other "headers" in the
response, but you could also do something more HTTP-like, with a status
code, and arbitrary headers. And presumably git would just ignore
headers it doesn't know about. I think that's what Jakub's example was
leaning towards. I'm just not sure what other headers are really useful,
but it does leave room for extensibility.

-Peff
