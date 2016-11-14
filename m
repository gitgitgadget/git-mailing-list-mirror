Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519AF203C1
	for <e@80x24.org>; Mon, 14 Nov 2016 23:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938974AbcKNXsv (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 18:48:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:43129 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752354AbcKNXsu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 18:48:50 -0500
Received: (qmail 31356 invoked by uid 109); 14 Nov 2016 23:48:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 23:48:50 +0000
Received: (qmail 6621 invoked by uid 111); 14 Nov 2016 23:49:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 18:49:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2016 18:48:47 -0500
Date:   Mon, 14 Nov 2016 18:48:47 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "spearce@spearce.org" <spearce@spearce.org>
Subject: Re: [PATCH] remote-curl: don't hang when a server dies before any
 output
Message-ID: <20161114234847.2nexsgedpg7zvrr5@sigill.intra.peff.net>
References: <1478729910-26232-1-git-send-email-dturner@twosigma.com>
 <20161114182431.e7jjnq422c4xobdb@sigill.intra.peff.net>
 <20161114194049.mktpsvgdhex2f4zv@sigill.intra.peff.net>
 <a57cc9c4a0a840baab5b8123fac9388b@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a57cc9c4a0a840baab5b8123fac9388b@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2016 at 11:25:30PM +0000, David Turner wrote:

> > But it does seem to work. At least it doesn't seem to break anything
> > in the test suite, and it fixes the new tests you added. I'd worry
> > that there's some obscure case where the response isn't packetized
> > in the same way.
> 
> Overall, this looks good to me.  The state machine is pretty clean. I
> think I would have used a tiny buffer for the length field, and then I
> would have regretted it.  Your way looks nicer than my unwritten patch
> would have looked.

Heh, I started it that way but you end up dealing with the same states
(they're just implicit in your "how big is my temp buffer" field).

> > +#define READ_ONE_HEX(shift) do { \
> > +	int val = hexval(buf[0]); \
> > +	if (val < 0) { \
> > +		warning("error on %d", *buf); \
> > +		rpc->pktline_state = RPC_PKTLINE_ERROR; \
> > +		return; \
> > +	} \
> > +	rpc->pktline_len |= val << shift; \
> 
> Nit: parenthesize shift here, since it is a parameter to a macro.

Yeah, I'm often a bit slack on these one-off inside-a-function macros.
But it does not hurt to to be careful.

I'll make that change and then try to wrap this up with a commit
message. I plan to steal your tests, if that's OK.

-Peff
