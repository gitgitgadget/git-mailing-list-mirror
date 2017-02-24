Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4F5201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 18:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbdBXS57 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 13:57:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:33477 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbdBXS55 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 13:57:57 -0500
Received: (qmail 4578 invoked by uid 109); 24 Feb 2017 18:57:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 18:57:57 +0000
Received: (qmail 31810 invoked by uid 111); 24 Feb 2017 18:58:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 13:58:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 13:57:55 -0500
Date:   Fri, 24 Feb 2017 13:57:55 -0500
From:   Jeff King <peff@peff.net>
To:     HW42 <hw42@ipsumj.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] Makefile: add USE_SHA1DC knob
Message-ID: <20170224185754.bic37suvkiwtvyn5@sigill.intra.peff.net>
References: <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
 <20170223230621.43anex65ndoqbgnf@sigill.intra.peff.net>
 <16c6d843-a516-9265-d3e7-61b110acbdcf@ipsumj.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16c6d843-a516-9265-d3e7-61b110acbdcf@ipsumj.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 06:36:00PM +0000, HW42 wrote:

> > +ifdef USE_SHA1DC
> > +	SHA1_HEADER = "sha1dc/sha1.h"
> > +	LIB_OBJS += sha1dc/sha1.o
> > +	LIB_OBJS += sha1dc/ubc_check.o
> > +else
> >  ifdef BLK_SHA1
> >  	SHA1_HEADER = "block-sha1/sha1.h"
> >  	LIB_OBJS += block-sha1/sha1.o
> > @@ -1403,6 +1412,7 @@ else
> >  endif
> >  endif
> >  endif
> > +endif
> 
> This sets SHA1_MAX_BLOCK_SIZE and the compiler flags for Apple
> CommonCrypto even if the user selects USE_SHA1DC. The same happens for
> BLK_SHA1. Is this intended?

No, it's not. I suspect that setting BLK_SHA1 has the same problem in
the current code, then.

> > +void git_SHA1DCUpdate(SHA1_CTX *ctx, const void *vdata, unsigned long len)
> > +{
> > +	const char *data = vdata;
> > +	/* We expect an unsigned long, but sha1dc only takes an int */
> > +	while (len > INT_MAX) {
> > +		SHA1DCUpdate(ctx, data, INT_MAX);
> > +		data += INT_MAX;
> > +		len -= INT_MAX;
> > +	}
> > +	SHA1DCUpdate(ctx, data, len);
> > +}
> 
> I think you can simply change the len parameter from unsigned into
> size_t (or unsigned long) in SHA1DCUpdate().
> https://github.com/cr-marcstevens/sha1collisiondetection/pull/6

Yeah, I agree that is a cleaner solution. My focus was on changing the
(presumably tested) sha1dc code as little as possible.

-Peff
