Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127791F858
	for <e@80x24.org>; Thu, 28 Jul 2016 13:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbcG1N3M (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 09:29:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:50353 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757478AbcG1N3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 09:29:10 -0400
Received: (qmail 17396 invoked by uid 102); 28 Jul 2016 13:29:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 09:29:09 -0400
Received: (qmail 25356 invoked by uid 107); 28 Jul 2016 13:29:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Jul 2016 09:29:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jul 2016 09:29:06 -0400
Date:	Thu, 28 Jul 2016 09:29:06 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	e@80x24.org, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 0/5] Git filter protocol
Message-ID: <20160728132906.GA21311@sigill.intra.peff.net>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160727000605.49982-1-larsxschneider@gmail.com>
 <579906C5.1050809@gmail.com>
 <BFED7ED8-40DB-46B5-A1B7-4F49624D5A62@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BFED7ED8-40DB-46B5-A1B7-4F49624D5A62@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 09:16:18AM +0200, Lars Schneider wrote:

> But Peff ($gmane/299902), Duy, and Eric, seemed to prefer the pkt-line
> solution (gmane is down - otherwise I would have given you the links).

FWIW, I think there are arguments for transmitting size + content
(namely, that it is simpler); the downside is that it doesn't allow
streaming.

So I think there are two viable alternatives:

  1. Total size of data in ASCII decimal, newline, then that many bytes
     of content.

  2. No size header, then a series of pkt-lines followed by a flush
     packet.

And you should choose between the two based on whether it's more
important to allow streaming, or more important to make the filter
implementations simple[1].

Any solution that is in between those (like sending a size header and
then using pktlines anyway) is sacrificing simplicity but not getting
the streaming benefits.

-Peff

[1] I haven't thought hard enough about it to have a real opinion. My
    gut says to go with the streaming, just because we've had to
    retrofit streaming in other areas when dealing with blobs, so I
    think we'll end up there eventually. So choosing a simpler protocol
    like (1) would probably mean eventually implementing a next-version
    protocol that does (2), and having to support both.

PS Jakub asked for links, but gmane is down. Here are the relevant threads:

   http://public-inbox.org/git/20160720134916.GB19359@sigill.intra.peff.net

   http://public-inbox.org/git/20160722154900.19477-1-larsxschneider%40gmail.com/t/#u
