Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3831F597
	for <e@80x24.org>; Thu, 19 Jul 2018 21:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbeGSWL6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 18:11:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:53310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730057AbeGSWL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 18:11:58 -0400
Received: (qmail 10823 invoked by uid 109); 19 Jul 2018 21:27:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 21:27:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17094 invoked by uid 111); 19 Jul 2018 21:27:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 17:27:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 17:27:00 -0400
Date:   Thu, 19 Jul 2018 17:27:00 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
Message-ID: <20180719212700.GA13151@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <20180719203901.GA8079@sigill.intra.peff.net>
 <CAPig+cSErDoZ5XFjfJsqfEKZ6PSKfOos=9HW-7FDXU1XEtuktA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSErDoZ5XFjfJsqfEKZ6PSKfOos=9HW-7FDXU1XEtuktA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 05:11:15PM -0400, Eric Sunshine wrote:

> On Thu, Jul 19, 2018 at 4:39 PM Jeff King <peff@peff.net> wrote:
> > [...]
> > Let's start by banning strcpy() and sprintf(). It's not
> > impossible to use these correctly, but it's easy to do so
> > incorrectly, and there's always a better option.
> > [...]
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/banned.h b/banned.h
> > @@ -0,0 +1,19 @@
> > +/*
> > + * This header lists functions that have been banned from our code base,
> > + * because they're too easy to misuse (and even if used correctly,
> > + * complicate audits). Including this header turns them into compile-time
> > + * errors.
> > + */
> 
> When the above talks about "including this header", the implication is
> that it must be included _after_ the system header(s) which declare
> the banned functions. I wonder if that requirement should be stated
> here explicitly.

Hmm, does it need to be? I had originally intended it to be included
before, actually, though in the end I put it later.

I guess it would yield declarations like strcpy_is_banned(), which would
cause _different_ errors (probably link-time ones).

> (Probably not worth a re-roll.)

Yeah, I doubt it matters much either way, since the inclusion is done
automatically in git-compat-util.h.

I had also originally imagined this to be triggered via DEVELOPER=1,
with something like "-include banned.h" in CFLAGS. But I think it
probably is appropriate for everybody to run it, since it shouldn't
cause any false positives or other compilation issues.

The one I brainstormed (but forgot to mention) is that it might be
possible for a platform to have strcpy as a macro already? In which case
we'd need to #undef it or risk a compilation error (even if the macro
isn't actually used).

-Peff
