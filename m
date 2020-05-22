Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F152C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 20:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E492078D
	for <git@archiver.kernel.org>; Fri, 22 May 2020 20:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbgEVUDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 16:03:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:54766 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730893AbgEVUDB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 16:03:01 -0400
Received: (qmail 23289 invoked by uid 109); 22 May 2020 20:03:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 May 2020 20:03:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9598 invoked by uid 111); 22 May 2020 20:03:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 May 2020 16:03:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 May 2020 16:03:00 -0400
From:   Jeff King <peff@peff.net>
To:     "Daniel Richard G." <skunk@iSKUNK.ORG>
Cc:     git@vger.kernel.org
Subject: Re: Minor portability issues + fixes
Message-ID: <20200522200300.GA2160187@coredump.intra.peff.net>
References: <7422404e-7fc8-4961-aae4-3f0adb71bb3a@www.fastmail.com>
 <20200519024945.GB70483@coredump.intra.peff.net>
 <40a42f1d-61bd-46fb-8946-5588df7b044b@www.fastmail.com>
 <20200520042838.GA102274@coredump.intra.peff.net>
 <86f751ac-b7c1-43fd-ada5-a8e2e9c4ebc9@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86f751ac-b7c1-43fd-ada5-a8e2e9c4ebc9@www.fastmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 12:29:18AM -0400, Daniel Richard G. wrote:

> > So probably we'd want something like (in this order):
> > 
> >   - NEEDS_EXPLICIT_STDINT gets passed from the Makefile into the
> >     compiler via -D, which then triggers stdint.h being included
> >     unconditionally in git-compat-util.h
> > 
> >   - optionally set that in config.mak.uname for AIX (checking uname_R
> >     since it sounds like only old versions need it)
> > 
> >   - add an autoconf rule that sets it, either strictly (when a
> >     test-program decides it's needed) or loosely (when we see that it's
> >     available at all)
> > 
> > Even just the first one would let you build by setting the knob
> > manually; the rest is gravy on top, if you or somebody else chooses to
> > do it.
> 
> Hmm... that's a fairly specific knob, which I would think is less than
> ideal. The rest is reasonable, but would have to be written in terms
> of the knob.

Yeah, it is. I do wonder if just setting the existing NO_INTTYPES_H is a
simpler solution for your case (since it sounds like that works). If you
want to tweak the knob for older AIX in config.mak.uname, that would be
fine (or if you think other people aren't likely to be building on the
platform, maybe tweak your own "make" invocation and let this
conversation serve to document for anybody else).

> > but it would be nice if the Makefile handled this correctly. It looks
> > like CC_LD_DYNPATH gets used in a lot of places, so I suspect we'd
> > want a Makefile function to help out. Something like:
> > 
> >   # usage: $(call linker_lib,PATH)
> >   # Create linker args for looking for libraries in PATH at both link-time
> >   # and run-time.
> >   linker_lib = -L$1 $(if $(CC_LD_DYNPATH),$(CC_LD_DYNPATH)$1)
> > 
> > which would allow:
> > 
> >   EXTLIBS += $(call linker_lib,$(LIBPCREDIR)/$(lib))
> > 
> > etc. This would be our first foray into Makefile functions, but I think
> > we've determined that most platforms have a recent enough GNU make for
> > it to be OK (and we already require GNU make).
> 
> Why not just a variable to wrap the conditional? Something like
> 
>     CC_LD_DYNPATH_flag = $(if $(CC_LD_DYNPATH),$(CC_LD_DYNPATH),-L)
> 
>     ...
> 
>     EXTLIBS += -L$(ZLIB_PATH)/$(lib) $(CC_LD_DYNPATH_flag)$(ZLIB_PATH)/$(lib)

I was trying to actually remove the argument, rather than turn it into a
duplicate "-L". But you're probably right that it's not worth the
effort.

I think we could just normalize an empty CC_LD_DYNPATH to "-L" in the
same variable, and then we wouldn't even have to change the sites which
reference it.

-Peff
