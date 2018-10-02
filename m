Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1A31F453
	for <e@80x24.org>; Tue,  2 Oct 2018 22:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeJCFUO (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 01:20:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:39210 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727361AbeJCFUO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 01:20:14 -0400
Received: (qmail 19706 invoked by uid 109); 2 Oct 2018 22:34:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Oct 2018 22:34:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7602 invoked by uid 111); 2 Oct 2018 22:34:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 18:34:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 18:34:35 -0400
Date:   Tue, 2 Oct 2018 18:34:35 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] commit-graph: clean up leaked memory during write
Message-ID: <20181002223434.GA5588@sigill.intra.peff.net>
References: <pull.42.git.gitgitgadget@gmail.com>
 <6906c25415eddf79cc3f71f905a77b140f2f66f0.1538492321.git.gitgitgadget@gmail.com>
 <CAN0heSomOen+mWg1CuPGUCJFgmDQUjGLtAdxpWLwrStRU4Me8g@mail.gmail.com>
 <CAGZ79kYtNnNPMv0=rB4ie=tOoYEPPZ=CmYFg4PG2_j96vjODeQ@mail.gmail.com>
 <CAN0heSqOjYDXRf4KE_C0GDnFW8r4qVfWnUVuW-Q+4D87nhFURQ@mail.gmail.com>
 <CAGZ79kb2pE3pFQx4A=oo-mYORjN1ubCgV6Gotc78i7d+BqZdBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kb2pE3pFQx4A=oo-mYORjN1ubCgV6Gotc78i7d+BqZdBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 02, 2018 at 12:44:09PM -0700, Stefan Beller wrote:

> > My worry is that one of these would seem to be true:
> >
> > * UNLEAK is unsuitable for the job. Whenever we have a `die()` as we do
> >   here, we can UNLEAK the variables we know of, but we can't do anything
> >   about the allocations we have made higher up the call-chain.
> 
> IMHO that is the issue of the functions higher up the call chain and ought
> to not affect this patch. By doing the right thing here locally the code base
> will approach a good state eventually.

But it's impossible. If I do this:

  foo = xstrdup(bar);
  subfunction(foo);

then I cannot protect myself from leaking "foo" when subfunction() calls
die(). It must be valid when I enter the function, and I have no
opportunity to run code when it leaves (because it never does).

> > * We add code with no purpose. In this case, we're not talking a lot of
> >   lines, but across the code base, if they bring no gain, they are bound
> >   to provide a negative net value given enough time.
> 
> I see. I did not estimate its negative impact to be high enough, as the
> UNLEAK near a die() call was obvious good thing (locally).
> 
> I don't know what the best way to proceed is in this case.

My preference is to avoid them in the name of simplicity. If you're
using "make SANITIZE=leak test" to check for leaks, it will skip these
cases. If you're using valgrind, I think these may be reported as
"reachable". But that number already isn't useful for finding real
leaks, because it includes cases like the "foo" above as well as
program-lifetime globals.

The only argument (IMHO) for such an UNLEAK() is that it annotates the
location for when somebody later changes the function to "return -1"
instead of dying. But if we are going to do such annotation, we may as
well actually call free(), which is what the "return" version will
ultimately have to do.

I'd actually be _more_ favorable to calling free() instead of UNLEAK()
there, but I'm still mildly negative, just because it may go stale (and
our leak-checking wouldn't usefully notice these cases). Anybody
converting that die() to a return needs to re-analyze the function for
what might need to be released (and that includes non-memory bits like
descriptors, too).

-Peff
