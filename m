Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA074201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 20:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbdCNUO3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 16:14:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:44148 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750787AbdCNUO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 16:14:28 -0400
Received: (qmail 30184 invoked by uid 109); 14 Mar 2017 20:14:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 20:14:27 +0000
Received: (qmail 5966 invoked by uid 111); 14 Mar 2017 20:14:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Mar 2017 16:14:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Mar 2017 16:14:24 -0400
Date:   Tue, 14 Mar 2017 16:14:24 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header
 file
Message-ID: <20170314201424.vccij5z2ortq4a4o@sigill.intra.peff.net>
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
 <20170314184126.GJ26789@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170314184126.GJ26789@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 14, 2017 at 11:41:26AM -0700, Jonathan Nieder wrote:

> brian m. carlson wrote:
> 
> [...]
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -10,8 +10,8 @@
> >  #include "trace.h"
> >  #include "string-list.h"
> >  #include "pack-revindex.h"
> > +#include "hash.h"
> >  
> > -#include SHA1_HEADER
> 
> For what it's worth, the bazel build tool doesn't like this
> '#include SHA1_HEADER' either.  Your fix looks like a straightforward
> fix and we never encouraged directly customizing SHA1_HEADER.

Hmm. I don't know how you're using bazel with git, but if it is doing
something like generating header dependencies, would that mean that it
potentially picks up the wrong dependency with brian's patch?

> The other approaches discussed may also work but they don't add
> anything for my application (nor yours, I'd think).  Conditional
> #includes are a pretty normal thing so I am fine with this more
> straightforward change.  So
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> That said, if someone is excited about one of the other approaches
> then I don't object to them.

My biggest complaint with the initial patch is that it repeats the
if-else chain of each type (once in the Makefile and once in hash.h). I
can live with having to touch two parts of the code (it's not like we
expect a huge number of alternative sha1 implementations), but I worried
that we were replicating the "which one is primary" logic in two places
(i.e., the Makefile prefers BLK_SHA1 above others, and I expect that
when we add USE_SHA1DC it may become the primary).

But I think it's probably OK in practice. The if-else inside hash.h is
checking the -D defines we set in the Makefile, and the Makefile logic
would set only one such define. So hash.h would have to follow whatever
the Makefile picked (unless you do something idiotic like "CFLAGS +=
-DBLK_SHA1" yourself, but then you deserve every bad thing that comes
your way).

So I'm OK with brian's patch as the simplest thing that covers
non-compilation use cases. It should probably default to BLK_SHA1 rather
than OpenSSL, as discussed earlier.

-Peff
