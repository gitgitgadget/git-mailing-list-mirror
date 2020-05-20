Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E90C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 04:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963E320756
	for <git@archiver.kernel.org>; Wed, 20 May 2020 04:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgETE2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 00:28:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:51508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725785AbgETE2j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 00:28:39 -0400
Received: (qmail 30829 invoked by uid 109); 20 May 2020 04:28:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 May 2020 04:28:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17319 invoked by uid 111); 20 May 2020 04:28:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 May 2020 00:28:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 May 2020 00:28:38 -0400
From:   Jeff King <peff@peff.net>
To:     "Daniel Richard G." <skunk@iSKUNK.ORG>
Cc:     git@vger.kernel.org
Subject: Re: Minor portability issues + fixes
Message-ID: <20200520042838.GA102274@coredump.intra.peff.net>
References: <7422404e-7fc8-4961-aae4-3f0adb71bb3a@www.fastmail.com>
 <20200519024945.GB70483@coredump.intra.peff.net>
 <40a42f1d-61bd-46fb-8946-5588df7b044b@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40a42f1d-61bd-46fb-8946-5588df7b044b@www.fastmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 19, 2020 at 12:22:00AM -0400, Daniel Richard G. wrote:

> > If so, then perhaps it should be added to the AIX defines in
> > config.mak.uname.
> 
> I've confirmed that this works. But would it not be safe to #include
> both inttypes.h and stdint.h explicitly if both are present, rather than
> cater to AIX specifically? I could see this similarly arising in, say,
> an old version of Solaris.

Yes, as long as we check that both are present, I think that would do
the right thing. And the autoconf check could cover that. I don't think
there's an easy way to have a general Makefile knob that can check which
files are present, though (and we generally consider the Makefile and
its knobs to be the primary mechanism; autoconf to turn those knobs is
generally implemented on top).

So probably we'd want something like (in this order):

  - NEEDS_EXPLICIT_STDINT gets passed from the Makefile into the
    compiler via -D, which then triggers stdint.h being included
    unconditionally in git-compat-util.h

  - optionally set that in config.mak.uname for AIX (checking uname_R
    since it sounds like only old versions need it)

  - add an autoconf rule that sets it, either strictly (when a
    test-program decides it's needed) or loosely (when we see that it's
    available at all)

Even just the first one would let you build by setting the knob
manually; the rest is gravy on top, if you or somebody else chooses to
do it.

> > I do wonder, though, if configure.ac could be extended for AIX to
> > support whatever syntax the system linker uses for setting the run-path.
> > I understand that you don't care either way about this feature, but this
> > might be a good opportunity to fix it.
> 
> This could be a bit complicated, I'm afraid.
> 
> The applicable value for CC_LD_DYNPATH on AIX is "-Wl,-blibpath:".
> However, have a look at the description for this option in the
> ld(1) man page:

OK, gross. :) I agree it's not worth going too far into this rabbit
hole. I do wonder if you could just be using GNU ld along with gcc, but
maybe that's not practical.

You should be able to build with:

  make CC_LD_DYNPATH=-L

as a workaround, but it would be nice if the Makefile handled this
correctly. It looks like CC_LD_DYNPATH gets used in a lot of places, so
I suspect we'd want a Makefile function to help out. Something like:


  # usage: $(call linker_lib,PATH)
  # Create linker args for looking for libraries in PATH at both link-time
  # and run-time.
  linker_lib = -L$1 $(if $(CC_LD_DYNPATH),$(CC_LD_DYNPATH)$1)

which would allow:

  EXTLIBS += $(call linker_lib,$(LIBPCREDIR)/$(lib))

etc. This would be our first foray into Makefile functions, but I think
we've determined that most platforms have a recent enough GNU make for
it to be OK (and we already require GNU make).

-Peff
