Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1463F202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 20:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935316AbdCLUMm (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 16:12:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:42929 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934858AbdCLUMl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 16:12:41 -0400
Received: (qmail 25827 invoked by uid 109); 12 Mar 2017 20:12:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 20:12:39 +0000
Received: (qmail 14248 invoked by uid 111); 12 Mar 2017 20:12:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 12 Mar 2017 16:12:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Mar 2017 16:12:37 -0400
Date:   Sun, 12 Mar 2017 16:12:37 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header
 file
Message-ID: <20170312201237.wrstmhk5saiy52m4@sigill.intra.peff.net>
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
 <20170312130149.czir5hcbosqlmkhb@sigill.intra.peff.net>
 <20170312165119.3eokqse4uxdet6yd@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170312165119.3eokqse4uxdet6yd@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 12, 2017 at 04:51:19PM +0000, brian m. carlson wrote:

> Yeah, my goal was basically to pass -fsyntax-only, not to produce useful
> object files.  My patch does basically require that the user have
> OpenSSL installed, but I do, so it doesn't matter.
> 
> I considered after the fact that I might just do something like:
> 
>   #ifdef SHA1_HEADER
>   #include SHA1_HEADER
>   #else
>   #include "block-sha1/sha1.h"
>   #endif
> 
> That would be the smallest change, but probably not the best.

Yeah, if there is going to be a fallback it probably ought to be
the internal one.

> > Of course the sha1 header is just one of many such defines. It's the one
> > that is most visible because the result is syntactically valid without
> > it, but anything you compile without the Makefile's CFLAGS may be subtly
> > different than what the Makefile would produce. So arguably the Makefile
> > should be writing out a build-options.h with all of the values, and that
> > should get pulled in by git-compat-util.h.
> > 
> > I don't know if we want to go down that rabbit hole or not. I offer it
> > merely as an alternative. I'm OK with your patch as-is if you don't want
> > to dump any more time into it.
> 
> I'll take this patch for now and fix it up with the comment I mentioned
> below.  If someone wants to improve the situation down the line, then
> they can pick that up.
> 
> I assume I can apply your sign-off to the resulting patch?

Yes, it is OK to add my sign-off. The two things I was concerned about
with my patch were:

  1. It does introduce an extra shell invocation on every "make", even
     if the file does not need to be rebuilt (though it is just one of
     many; GIT-BUILD-OPTIONS, etc).

  2. I wasn't sure if the dependencies were quite right. I _thought_ we
     should pick it up as an auto-dependency, but I don't think that
     works because we do our header dependencies as a side effect of the
     compile.

     So "make" didn't actually know to build hash.h until I made it a
     dependency of help.o. Which feels weird and hacky. It's really a
     dependency of _anything_ that includes cache.h.

So you may want to dig into that second one to make sure the result is
sane, not racy, etc.

> > +hash.h:
> > +	$(QUIET_GEN)echo '#include $(SHA1_HEADER)' >$@+ && \
> > +	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; }
> 
> I think here we'd want to also "rm -f $@+", so that we don't leave an
> extra file behind if we're up-to-date (which is the common case), much
> like we do for GIT-BUILD-OPTIONS.

Yeah, I agree that would be an improvement.

-Peff
