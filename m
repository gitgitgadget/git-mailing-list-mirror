Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8225BC35242
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D762187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 06:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgBNGum (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:50:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:43212 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725845AbgBNGum (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 01:50:42 -0500
Received: (qmail 19294 invoked by uid 109); 14 Feb 2020 06:50:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 06:50:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19370 invoked by uid 111); 14 Feb 2020 06:59:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 01:59:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 01:50:41 -0500
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Fix inet_ntop and inet_pton on Solaris
Message-ID: <20200214065041.GF605125@coredump.intra.peff.net>
References: <CAH8yC8kaWXbN+RYMJnM9em7KKW54+N07JtyS1MZk0qppD=m2BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8kaWXbN+RYMJnM9em7KKW54+N07JtyS1MZk0qppD=m2BA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 03, 2020 at 10:22:46AM -0500, Jeffrey Walton wrote:

> inet_ntop and inet_pton were not being detected properly on modern on
> Solaris. This patch revisits the the socket gear configuration on
> SunOS and brings it up to date for Solaris 11.
> 
> According to configure.ac, the three or four functions of interest
> include hstrerror, inet_ntop and inet_pton. The libraries of interest
> are -lresolv -lsocket -lnsl. The configure tests now look for
> inet_ntop and inet_pton in -lsocket -lnsl per the man page. If not
> found, the configure tests fall back to existing behavior by searching
> in -lresolv. And if not found in -lresolv, then NO_INET_NTOP and
> NO_INET_PTON are set.

This makes sense, and the patch looks plausibly correct (which is the
best I can say given my general lack of autoconf knowledge).

I was a little surprised by this hunk:

> diff --git a/Makefile b/Makefile
> index 09f98b777c..7166b19ab4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1461,15 +1461,15 @@ ifndef LIBC_CONTAINS_LIBINTL
>  	EXTLIBS += -lintl
>  endif
>  endif
> +ifdef NEEDS_RESOLV
> +	EXTLIBS += -lresolv
> +endif
>  ifdef NEEDS_SOCKET
>  	EXTLIBS += -lsocket
>  endif
>  ifdef NEEDS_NSL
>  	EXTLIBS += -lnsl
>  endif
> -ifdef NEEDS_RESOLV
> -	EXTLIBS += -lresolv
> -endif

But I guess it is trying to mimic the "-lresolv -lsocket -lnsl" order
you mentioned in the Solaris manpage. You should be able to test if
that's necessary by compiling with:

  make NEEDS_RESOLV=Yes NEEDS_SOCKET=Yes NEEDS_NSL=Yes

If so, that ordering switch could probably happen as a separate commit
before the configure.ac change.

> diff --git a/configure.ac b/configure.ac
> index 66aedb9288..b83a0e970d 100644
> --- a/configure.ac
> +++ b/configure.ac

The rest of it looks OK to me. Do you want to send it as a regular Git
patch with a commit message and your signoff (see SubmittingPatches)?

-Peff
