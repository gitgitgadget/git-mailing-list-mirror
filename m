Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393E6C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 18:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F7420728
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 18:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgKFSSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:18:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:50158 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbgKFSSF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 13:18:05 -0500
Received: (qmail 20207 invoked by uid 109); 6 Nov 2020 18:18:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Nov 2020 18:18:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2893 invoked by uid 111); 6 Nov 2020 18:18:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Nov 2020 13:18:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Nov 2020 13:18:04 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] Documentation/Makefile: conditionally include
 ../GIT-VERSION-FILE
Message-ID: <20201106181804.GA183267@coredump.intra.peff.net>
References: <32b7e1dc-8cc3-2236-08b8-4d268bbf8c0b@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32b7e1dc-8cc3-2236-08b8-4d268bbf8c0b@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 05, 2020 at 09:03:49PM +0000, Ramsay Jones wrote:

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 652d57a1b6..5c680024eb 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -272,7 +272,9 @@ install-html: html
>  ../GIT-VERSION-FILE: FORCE
>  	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
>  
> +ifneq ($(MAKECMDGOALS),clean)
>  -include ../GIT-VERSION-FILE
> +endif

Calling out "clean" here specially feels somewhat backwards to me, in
terms of Makefile design. In an ideal world we provide all of the
dependencies to "make", and based on the targets we are building, it
decides what needs to be done.

This works with normal targets, obviously, but also with variables. If
we do:

  FOO = $(shell do-the-thing)

then we execute that command only when $(FOO) is needed[1].

But "include" here is tricky. It is loaded regardless of whether the
values it contains are needed or not. I wonder if we could do better by
giving make more information about what we're expecting to get from it.
I.e., if we wrote:

  GIT_VERSION = $(shell awk '{print $3}' GIT-VERSION-FILE)

Then "make clean", not needing the value of $(GIT_VERSION), wouldn't run
that shell snippet at all. Of course there's a catch; we are also
relying on the include to trigger the dependency. So it is really more
like:

  GIT_VERSION = $(shell make GIT-VERSION-FILE && awk '{print $3}' GIT-VERSION-FILE)

I'm not sure how bad that is. Re-invoking make seems like it could get
expensive, especially for the common case that we're building actual
binaries and we _do_ need the version. But we could probably cut "make"
out of the loop entirely. Generating GIT-VERSION-FILE is already a FORCE
target, so really:

  GIT_VERSION = $(shell ./GIT-VERSION-GEN)

would be equivalent-ish (with some output changes, and possibly we'd
want to stash the value in a file for any other scripts to make use of).

This is all just stuff I've written in my editor and not tried. I won't
be surprised if there are some gotchas. But it at least seems like a
conceptually cleaner path.

-Peff

[1] Variable assignment actually has a slight problem in the opposite
    direction: it wants to run the shell snippet every time the variable
    is referenced. There's a trick to get around that described in
    0573831950 (Makefile: avoid running curl-config unnecessarily,
    2020-04-04).

    It's built around evals. In fact, I suspect you could build a
    function around eval that actually works similar to include, but
    lazy-loads the file only when one of its stubs is referenced. I.e.,
    something like:

      GIT_VERSION = $(eval include GIT-VERSION-FILE)

    would probably work (and for other includes, multiple variables
    could mention the same file; as soon as it gets included, it
    overwrites the stubs).
