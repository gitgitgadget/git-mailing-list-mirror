Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EAA81F404
	for <e@80x24.org>; Fri, 24 Aug 2018 11:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeHXOjB (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 10:39:01 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:17677 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbeHXOjA (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Aug 2018 10:39:00 -0400
X-IronPort-AV: E=Sophos;i="5.53,281,1531778400"; 
   d="scan'208";a="343594119"
Received: from 71-219-20-84.chvl.qwest.net (HELO hadrien.PK5001Z) ([71.219.20.84])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Aug 2018 13:04:29 +0200
Date:   Fri, 24 Aug 2018 07:04:27 -0400 (EDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] excluding a function from coccinelle transformation
In-Reply-To: <20180824064228.GA3183@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1808240652370.2344@hadrien>
References: <20180824064228.GA3183@sigill.intra.peff.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Fri, 24 Aug 2018, Jeff King wrote:

> In Git's Coccinelle patches, we sometimes want to suppress a
> transformation inside a particular function. For example, in finding
> conversions of hashcmp() to oidcmp(), we should not convert the call in
> oidcmp() itself, since that would cause infinite recursion. We write the
> semantic patch like this:
>
>   @@
>   identifier f != oidcmp;
>   expression E1, E2;
>   @@
>     f(...) {...
>   - hashcmp(E1->hash, E2->hash)
>   + oidcmp(E1, E2)
>     ...}

The problem is with how how ... works.  For transformation, A ... B
requires that B occur on every execution path starting with A, unless that
execution path ends up in error handling code.
(eg, if (...) { ... return; }).  Here your A is the start if the function.
So you need a call to hashcmp on every path through the function, which
fails when you add ifs.

If you use * (searching) instead of - and + (transformation) it will only
require that a path exists.  * is mean for bug finding, where you often
want to find eg whether there exists a path that is missing a free.

If you want the exists behavior with a transformation rule, then you can
put exists at the top of the rule between the initial @@.  I don't suggest
this in general, as it can lead to inconsistencies.

What you want is what you ended up using, which is <... P ...> which
allows zero or more occurrences of P.

However, this can all be very expensive, because you are matching paths
through the function definition which you don't really care about.  All
you care about here is the name.  So another approach is

@@
position p : script:python() { p[0].current_element != "oldcmp" };
expression E1,E2;
@@

- hashcmp(E1->hash, E2->hash)
+ oidcmp(E1, E2)

(I assume that "not equals" is written != in python)

Another issue with A ... B is that by default A and B should not appear in
the matched region.  So your original rule matches only the case where
every execution path contains exactly one call to hashcmp, not more than
one.  So that was another problem with it.

julia

>
> This catches some cases, but not all. For instance, there's one case in
> sequencer.c which it does not convert. Now here's where it gets weird.
> If I instead use the angle-bracket form of ellipses, like this:
>
>   @@
>   identifier f != oidcmp;
>   expression E1, E2;
>   @@
>     f(...) {<...
>   - hashcmp(E1->hash, E2->hash)
>   + oidcmp(E1, E2)
>     ...>}
>
> then we do generate the expected diff! Here's a much more cut-down
> source file that demonstrates the same behavior:
>
>   int foo(void)
>   {
>     if (1)
>       if (!hashcmp(x, y))
>         return 1;
>     return 0;
>   }
>
> If I remove the initial "if (1)" then a diff is generated with either
> semantic patch (and the particulars of the "if" are not important; the
> same thing happens if it's a while-loop. The key thing seems to be that
> the code is not in the top-level block of the function).
>
> And here's some double-weirdness. I get those results with spatch 1.0.4,
> which is what's in Debian unstable. If I then upgrade to 1.0.6 from
> Debian experimental, then _neither_ patch produces any results! Instead
> I get:
>
>   init_defs_builtins: /usr/lib/coccinelle/standard.h
>   (ONCE) Expected tokens oidcmp hashcmp hash
>   Skipping:foo.c
>
> (whereas before, even the failing case said "HANDLING: foo.c").
>
> And then one final check: I built coccinelle from the current tip of
> https://github.com/coccinelle/coccinelle (1.0.7-00504-g670b2243).
> With my cut-down case, that version generates a diff with either
> semantic patch. But for the full-blown case in sequencer.c, it still
> only works with the angle brackets.
>
> So my questions are:
>
>   - is this a bug in coccinelle? Or I not understand how "..." is
>     supposed to work here?
>
>     (It does seem like there was possibly a separate bug introduced in
>     1.0.6 that was later fixed; we can probably ignore that and just
>     focus on the behavior in the current tip of master).
>
>   - is there a better way to represent this kind of "transform this
>     everywhere _except_ in this function" semantic patch? (preferably
>     one that does not tickle this bug, if it is indeed a bug ;) ).
>
> -Peff
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
