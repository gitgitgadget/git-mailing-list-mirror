Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD62A2082D
	for <e@80x24.org>; Thu,  7 Sep 2017 09:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932083AbdIGJRh (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 05:17:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:59460 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932078AbdIGJRh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 05:17:37 -0400
Received: (qmail 11705 invoked by uid 109); 7 Sep 2017 09:17:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 09:17:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29763 invoked by uid 111); 7 Sep 2017 09:18:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Sep 2017 05:18:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Sep 2017 05:17:35 -0400
Date:   Thu, 7 Sep 2017 05:17:35 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 10/10] add UNLEAK annotation for reducing leak false
 positives
Message-ID: <20170907091734.nsdpo2dpcgvf2zna@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net>
 <CAGZ79kYmZJ8k2=SVrx9vpEXoKhRBGwu8J=fS=cYiCLdKf+nDGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYmZJ8k2=SVrx9vpEXoKhRBGwu8J=fS=cYiCLdKf+nDGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2017 at 03:05:12PM -0700, Stefan Beller wrote:

> On Tue, Sep 5, 2017 at 6:05 AM, Jeff King <peff@peff.net> wrote:
> 
> >   int main(void)
> 
> nit of the day:
>   s/void/int argc, char *argv/ or in case we do not
>   want to emphasize the argument list s/void//
>   as that adds no uninteresting things.

That really is a nit. I chose not to provide argv because it's longer
than "void" and I wasn't going to use the arguments. And I chose not to
use an empty argument list because it violates our style (as well as
arguably the C standard, though it leaves room for implementations to
take other forms of main).

> > In other words, you can do:
> >
> >   int main(void)
> >   {
> >         char *p = some_function();
> >         printf("%s", p);
> >         UNLEAK(p);
> >         return 0;
> >   }
> >
> > to annotate "p" and suppress the leak report.
> 
> This sounds really cool so far.
> 
> After having a sneak peak at the implementation
> it is O(1) in runtime for each added element, and the
> space complexity is O(well).

I'm not sure if your "well" is "this does well" or "well, it could be
quite a lot". :)

It certainly has the potential to grow the heap without bound (since
after all, it's whole point is to make a giant list of variables that
are going out of scope). But in practice we'd sprinkle this over a
handful of variables just before program exit (and remember that it's
copying only what's on the stack already; so pointers get copied, not
whole heap-allocated blocks).

Plus it does nothing at all when not compiled with leak-checking. So I'm
not too worried about the extra memory usage or performance.

> >   1. It can be compiled conditionally. There's no need in
> >      normal runs to do this free(), and it just wastes time.
> >      By using a macro, we can get the benefit for leak-check
> >      builds with zero cost for normal builds (this patch
> >      uses a compile-time check, though we could clearly also
> >      make it a run-time check at very low cost).
> >
> >      Of course one could also hide free() behind a macro, so
> >      this is really just arguing for having UNLEAK(), not
> >      for its particular implementation.
> 
> This is only a real argument in combination with (2), or in other
> words you seem to hint at situations like these:

Well, the numbered list was meant to be a set of arguments, each of
which contributes to the overall conclusion. :) I agree that (1) is the
weakest. Since both you and Martin seemed to get hung up on it, I'll
re-organize it a bit for the re-roll.

>   5. It's not just about worrying if we can call UNLEAK
>       once (in 4), but we also do not have to worry about
>       calling it twice, or recursively. (This argument can be bad
>       for cargo cult programmers, but we don't have these ;-)

True. I didn't come across that case in any of the ones I converted. As
a more general rule, UNLEAK() doesn't access any pointed-to memory at
all. So it's fine with already-freed or even uninitialized memory (which
of course is technically wrong according to the standard, but in
practice would be fine, as we'd copy garbage that does not match a heap
block).

> > +#ifdef SUPPRESS_ANNOTATED_LEAKS
> > +extern void unleak_memory(const void *ptr, size_t len);
> > +#define UNLEAK(var) unleak_memory(&(var), sizeof(var));
> 
> As always with macros we have to be careful about its arguments.
> 
>   UNLEAK(a++)
>   UNLEAK(baz())
> 
> won't work as intended.

Yes, I intended this to be used only for actual variables. I couldn't
think of a way to enforce that at compile time with some kind of
BUILD_ASSERT (even requiring an lvalue isn't quite strict enough).

-Peff
