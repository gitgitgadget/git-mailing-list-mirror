Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2461F404
	for <e@80x24.org>; Fri, 19 Jan 2018 21:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756519AbeASVUt (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 16:20:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:50048 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756460AbeASVUq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 16:20:46 -0500
Received: (qmail 24388 invoked by uid 109); 19 Jan 2018 21:20:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Jan 2018 21:20:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24573 invoked by uid 111); 19 Jan 2018 21:21:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Jan 2018 16:21:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jan 2018 16:20:44 -0500
Date:   Fri, 19 Jan 2018 16:20:44 -0500
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     randall.s.becker@rogers.com, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/6] Bypass GCC attributes on NonStop platform where
 used.
Message-ID: <20180119212044.GA10303@sigill.intra.peff.net>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
 <20180119173406.13324-3-randall.s.becker@rogers.com>
 <86c7345f-814d-8d81-bb55-e91fe630e118@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86c7345f-814d-8d81-bb55-e91fe630e118@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 08:28:48PM +0000, Ramsay Jones wrote:

> > diff --git a/remote.c b/remote.c
> > index 4e93753e1..c18f9de7f 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -11,6 +11,10 @@
> >  #include "mergesort.h"
> >  #include "argv-array.h"
> >  
> > +#if defined (__TANDEM)
> > +#define __attribute(a)
> > +#endif
> > +
> 
> Hmm, the only use of __attribute() I can find is in compat/regex/.
> In particular, there is no use of __attribute() in regex.c.
> [__attribute__() is used in regex.c]
> 
> Is this an old patch which is no longer required?
> 
> puzzled.

I'm puzzled, too. The actual gcc thing is __attribute__(), and we
already turn that into a noop via macro expansion if __GNUC__ is not
defined (in git-compat-util.h, but see below).

__attribute(), without the trailing underscores, is used internally by
the regex compat code (but it also converts that into a noop on non-GNUC
platforms)>

However the logic in git-compat-util is weird:

  #if defined(__HP_cc) && (__HP_cc >= 61000)
  #define NORETURN __attribute__((noreturn))
  #define NORETURN_PTR
  #elif defined(__GNUC__) && !defined(NO_NORETURN)
  #define NORETURN __attribute__((__noreturn__))
  #define NORETURN_PTR __attribute__((__noreturn__))
  #elif defined(_MSC_VER)
  #define NORETURN __declspec(noreturn)
  #define NORETURN_PTR
  #else
  #define NORETURN
  #define NORETURN_PTR
  #ifndef __GNUC__
  #ifndef __attribute__
  #define __attribute__(x)
  #endif
  #endif
  #endif

Most of the conditional is dealing with NORETURN, but then we stick the
__attribute()__ handling in the "else" block. Is it possible that this
platform triggers __HP_cc, but doesn't actually understand
__attribute__?

-Peff
