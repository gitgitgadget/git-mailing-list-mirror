Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C03CB20286
	for <e@80x24.org>; Wed, 13 Sep 2017 18:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbdIMShD (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 14:37:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:37414 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751148AbdIMShD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 14:37:03 -0400
Received: (qmail 28280 invoked by uid 109); 13 Sep 2017 18:37:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 18:37:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18505 invoked by uid 111); 13 Sep 2017 18:37:37 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 14:37:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 14:37:00 -0400
Date:   Wed, 13 Sep 2017 14:37:00 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/7] get-tar-commit-id: check write_in_full() return
 against 0
Message-ID: <20170913183700.amtrquhg66hjrbsp@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171127.ocnitq6wz57ivhrh@sigill.intra.peff.net>
 <20170913175357.GC27425@aiede.mtv.corp.google.com>
 <20170913180232.luxcnx7fbcpbt7bw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913180232.luxcnx7fbcpbt7bw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 02:02:32PM -0400, Jeff King wrote:

> > Does read_in_full need a similar treatment?
> 
> It might actually return fewer than the requested number of bytes, so it
> can't just use "< 0" in the same way (nor be adapted to return 0 on
> success).  But I think it's still a bug to do:
> 
>   char buf[20];
>   size_t len = sizeof(buf);
>   if (read_in_full(fd, buf, len) < len)
>           die(...);
> 
> since that will promote the -1 to a size_t. So it's probably worth
> auditing.

I looked it over and found one potentially buggy case. In
read-pack_header(), we do:

          if (read_in_full(fd, header, sizeof(*header)) < sizeof(*header))
                  /* "eof before pack header was fully read" */
                  return PH_ERROR_EOF;

which will treat a read error as a silent success. I don't think it's
harmful in practice because the next line checks that the header
matches the PACK signature (which yes, means we're reading uninitialized
bytes, but the chances are 1 in 2^32 that they match the signature.
Unless the buffer had an old PACK signature in it, of course ;) ).

There's one other harmless "< len" check. There are a bunch of "!="
checks which are OK as-is. Converting them to something equally short is
hard, though we could introduce a helper similar to your write_fully(),
like:

  int read_exactly(int fd, char *buf, size_t len)
  {
	ssize_t ret = read_in_full(fd, buf, len);
	if (ret < 0)
		return -1; /* real error */
	else if (ret < len)
		return -1; /* early eof */
	return 0;
  }

But the trouble is that a _good_ caller actually handles those cases
separately to provide better error messages (by doing that same
if-cascade themselves). If those if's were turned into error() or die()
calls, then we'd actually be improving the callsites. But of course not
all of them actually print an error or die. And when they do, they
usually say something specific about _what_ they were trying to read.

So it may not be worth trying to do a mass-cleanup in the same way here.

-Peff
