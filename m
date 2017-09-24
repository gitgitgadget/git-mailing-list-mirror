Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0653920281
	for <e@80x24.org>; Sun, 24 Sep 2017 03:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbdIXDva (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 23:51:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:48376 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751878AbdIXDva (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 23:51:30 -0400
Received: (qmail 17708 invoked by uid 109); 24 Sep 2017 03:51:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 24 Sep 2017 03:51:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17133 invoked by uid 111); 24 Sep 2017 03:52:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 23:52:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Sep 2017 23:51:27 -0400
Date:   Sat, 23 Sep 2017 23:51:27 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        David Turner <David.Turner@twosigma.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v8 01/12] bswap: add 64 bit endianness helper get_be64
Message-ID: <20170924035127.cwh54bjbbisl2dqf@sigill.intra.peff.net>
References: <20170922163548.11288-2-benpeart@microsoft.com>
 <20170922233707.25414-1-martin.agren@gmail.com>
 <MWHPR21MB047887A575D5DFFB213092A1F4640@MWHPR21MB0478.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MWHPR21MB047887A575D5DFFB213092A1F4640@MWHPR21MB0478.namprd21.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2017 at 11:31:50PM +0000, Ben Peart wrote:

> > diff --git a/compat/bswap.h b/compat/bswap.h index 6b22c4621..9dc79bdf5
> > 100644
> > --- a/compat/bswap.h
> > +++ b/compat/bswap.h
> > @@ -183,8 +183,8 @@ static inline uint32_t get_be32(const void *ptr)  static
> > inline uint64_t get_be64(const void *ptr)  {
> >  	const unsigned char *p = ptr;
> > -	return	(uint64_t)get_be32(p[0]) << 32 |
> > -		(uint64_t)get_be32(p[4]) <<  0;
> > +	return	(uint64_t)get_be32(p + 0) << 32 |
> > +		(uint64_t)get_be32(p + 4) <<  0;
> 
> This is surprising.  Every other function in the file uses the p[x] syntax.  Just for
> consistency, is there a way to stick to that syntax but still make it work correctly?
> Is there a typecast that can make it work?

The other ones are accessing the byte values directly, but since you are
building on get_be32 here, you have to pass the pointer.  So:

  return (uint64_t)get_be32(&p[0]) << 32 |
         (uint64_t)get_be32(&p[4]) <<  0;

would work.  Or of course you could just spell it out like the others:

  return (uint64_t)p[0] << 56 |
         (uint64_t)p[1] << 48 |
         (uint64_t)p[2] << 40 |
	 (uint64_t)p[3] << 32 |
         (uint64_t)p[4] << 24 |
         (uint64_t)p[5] << 16 |
         (uint64_t)p[6] <<  8 |
         (uint64_t)p[7] <<  0;

I suspect compilers would end up with the same output either way (on
x86, "gcc -O2" actually turns the whole thing into a bswap instruction).

-Peff
