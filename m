Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25F4C1F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbcHFUOG (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:14:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:36331 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751554AbcHFUNz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:13:55 -0400
Received: (qmail 14971 invoked by uid 102); 5 Aug 2016 22:27:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 18:27:14 -0400
Received: (qmail 31822 invoked by uid 107); 5 Aug 2016 22:27:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 18:27:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2016 18:27:10 -0400
Date:	Fri, 5 Aug 2016 18:27:10 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	larsxschneider@gmail.com, git@vger.kernel.org, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org
Subject: Re: [PATCH v4 11/12] convert: add filter.<driver>.process option
Message-ID: <20160805222710.chefh5kiktyzketh@sigill.intra.peff.net>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-12-larsxschneider@gmail.com>
 <2e13c31c-5ee2-890d-1268-98fb67aba1ea@web.de>
 <xmqqfuqivpjv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqfuqivpjv.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 05, 2016 at 03:06:28PM -0700, Junio C Hamano wrote:

> Torsten Bögershausen <tboegi@web.de> writes:
> 
> > On 2016-08-03 18.42, larsxschneider@gmail.com wrote:
> >> The filter is expected to respond with the result content in zero
> >> or more pkt-line packets and a flush packet at the end. Finally, a
> >> "result=success" packet is expected if everything went well.
> >> ------------------------
> >> packet:          git< SMUDGED_CONTENT
> >> packet:          git< 0000
> >> packet:          git< result=success\n
> >> ------------------------
> > I would really send the diagnostics/return codes before the content.
> 
> I smell the assumption "by the time the filter starts output, it
> must have finished everything and knows both size and the status".
> 
> I'd prefer to have a protocol that allows us to do streaming I/O on
> both ends when possible, even if the initial version of the filters
> (and the code that sits on the Git side) hold everything in-core
> before starting to talk.

I think you really want to handle both cases:

  - the server says "no, I can't fulfill your request" (e.g., HTTP 404)

  - the server can abort an in-progress response to indicate that it
    could not be fulfilled completely (in HTTP chunked encoding, this
    requires hanging up before sending the final EOF chunk)

If we expect the second case to be rare, then hanging up before sending
the flush packet is probably OK. But we could also have a trailing error
code after the data to say "ignore that, we saw an error, but I can
still handle more requests".

It is true that you don't need the up-front status code in that case
(you can send an empty body and say "ignore that, we saw an error") but
that feels a little weird. And I expect it makes the lives of the client
easier to get a code up front, before it starts taking steps to handle
what it _thinks_ is probably a valid response.

-Peff

PS I haven't followed HTTP/2 development much, but I think it solves the
   "hangup" issue by putting each request/response in its own framed
   stream. I actually wonder if that is a direction we will want to go
   eventually, too, or the same reason that HTTP/2 did: multiple async
   requests across a single connection.

   We already have some precedent in the sideband protocol. So imagine,
   for example, that we could ask the filter to work on several files
   simultaneously, by sending

     git> \1[file1 content]
     git> \2[file2 content]
     git> \1[file1 content]

   and so on. I don't think this is something that needs to happen in
   the initial protocol (it's not like git can do parallel checkout
   right now anyway). If there's a capability negotiation at the front
   of the protocol, then an async feature can be worked out later. Just
   food for thought at this point.
