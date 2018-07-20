Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EDEB1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 01:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbeGTBxy (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 21:53:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:53550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727615AbeGTBxy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 21:53:54 -0400
Received: (qmail 18677 invoked by uid 109); 20 Jul 2018 01:08:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 01:08:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18631 invoked by uid 111); 20 Jul 2018 01:08:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 21:08:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 21:08:08 -0400
Date:   Thu, 19 Jul 2018 21:08:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
Message-ID: <20180720010808.GC2179@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <20180719203901.GA8079@sigill.intra.peff.net>
 <xmqqmuumdetr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmuumdetr.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 03:46:08PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > For enforcement, we can rely on the compiler and just
> > introduce code which breaks compilation when it sees these
> > functions. This has a few advantages:
> >
> >   1. We know it's run as part of a build cycle, so it's
> >      hard to ignore. Whereas an external linter is an extra
> >      step the developer needs to remember to do.
> >
> >   2. Likewise, it's basically free since the compiler is
> >      parsing the code anyway.
> >
> >   3. We know it's robust against false positives (unlike a
> >      grep-based linter).
> >
> > The one big disadvantage is that it will only check code
> > that is actually compiled, so it may miss code that isn't
> > triggered on your particular system. But since presumably
> > people don't add new code without compiling it (and if they
> > do, the banned function list is the least of their worries),
> > we really only care about failing to clean up old code when
> > adding new functions to the list. And that's easy enough to
> > address with a manual audit when adding a new function
> > (which is what I did for the functions here).
> >
> > That leaves only the question of how to trigger the
> > compilation error. The goals are:
> 
> I actually have another question, though.
> 
> Is it a downside that it is cumbersome to override?  This is not a
> rhetorical question.  I am not convinced there will not be a legit
> circumstance that calling strcpy (or whatever we are going to ban)
> is the best solution and it is safe.  By "best", what I mean is "you
> could instead use memcpy/strncpy/whatever" can legitimately be
> argued with "but still using memcpy/strncpy/whatever is inferior
> than using strcpy in this case for such and such reasons".

In my opinion, no, this is not a problem.

My plan is to only add functions which are truly worthless. So with
strcpy(), for example, you _can_ make sure the buffer is big enough
before calling strcpy. But to do so, you by definition must have just
called strlen(), at which point you may as well use memcpy(). It's more
obviously correct, and it's more efficient.

Ditto for sprintf, where you should _always_ be using at least xsnprintf
(or some better tool, depending on the situation).  And for strncpy,
strlcpy (or again, some better tool) is strictly an improvement.  If
these were our functions, I would literally delete them from our
codebase. This is the moral equivalent. ;)

Contrast this with memcpy(). This is on Microsoft's SDL banned list[1],
but I think it's silly for it to be. I would never add it to this list.

Likewise snprintf(). That is a function that _can_ be dangerous due to
unexpected truncation, and I think we should avoid it in general. But I
would not ban it, as it is the correct tool in a few situations (you
have a fixed buffer and returning a truncation error code is fine --
many of our syscall wrappers are in this exact situation). So I would
probably not add it to the ban list (but I feel less strongly than I do
about memcpy).

The nuclear option for overriding is "#undef that-function" in a
particular instance. That covers the rest of the translation unit, but I
think that's probably fine. If we have a function which is mostly
questionable, but we need it sometimes, then we ought to be putting a
sane wrapper around it. And _that_ wrapper can sit in its own file and
#undef as it pleases, keeping the unsafety contained within.

Don't get me wrong, if you have another suggestion that allows easier
one-off overrides, I'm happy to hear it. But I think building this into
the compilation step and having it on-by-default is a huge advantage in
simplicity and having people remember to run it. And I couldn't come up
with a better way to do that.

-Peff
