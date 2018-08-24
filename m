Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31AD31F404
	for <e@80x24.org>; Fri, 24 Aug 2018 06:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeHXKPn (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 06:15:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:54288 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726198AbeHXKPn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 06:15:43 -0400
Received: (qmail 13788 invoked by uid 109); 24 Aug 2018 06:42:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 Aug 2018 06:42:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24172 invoked by uid 111); 24 Aug 2018 06:42:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 Aug 2018 02:42:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2018 02:42:29 -0400
Date:   Fri, 24 Aug 2018 02:42:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org, cocci@systeme.lip6.fr
Subject: excluding a function from coccinelle transformation
Message-ID: <20180824064228.GA3183@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git's Coccinelle patches, we sometimes want to suppress a
transformation inside a particular function. For example, in finding
conversions of hashcmp() to oidcmp(), we should not convert the call in
oidcmp() itself, since that would cause infinite recursion. We write the
semantic patch like this:

  @@
  identifier f != oidcmp;
  expression E1, E2;
  @@
    f(...) {...
  - hashcmp(E1->hash, E2->hash)
  + oidcmp(E1, E2)
    ...}

This catches some cases, but not all. For instance, there's one case in
sequencer.c which it does not convert. Now here's where it gets weird.
If I instead use the angle-bracket form of ellipses, like this:

  @@
  identifier f != oidcmp;
  expression E1, E2;
  @@
    f(...) {<...
  - hashcmp(E1->hash, E2->hash)
  + oidcmp(E1, E2)
    ...>}

then we do generate the expected diff! Here's a much more cut-down
source file that demonstrates the same behavior:

  int foo(void)
  {
    if (1)
      if (!hashcmp(x, y))
        return 1;
    return 0;
  }

If I remove the initial "if (1)" then a diff is generated with either
semantic patch (and the particulars of the "if" are not important; the
same thing happens if it's a while-loop. The key thing seems to be that
the code is not in the top-level block of the function).

And here's some double-weirdness. I get those results with spatch 1.0.4,
which is what's in Debian unstable. If I then upgrade to 1.0.6 from
Debian experimental, then _neither_ patch produces any results! Instead
I get:

  init_defs_builtins: /usr/lib/coccinelle/standard.h
  (ONCE) Expected tokens oidcmp hashcmp hash
  Skipping:foo.c

(whereas before, even the failing case said "HANDLING: foo.c").

And then one final check: I built coccinelle from the current tip of
https://github.com/coccinelle/coccinelle (1.0.7-00504-g670b2243).
With my cut-down case, that version generates a diff with either
semantic patch. But for the full-blown case in sequencer.c, it still
only works with the angle brackets.

So my questions are:

  - is this a bug in coccinelle? Or I not understand how "..." is
    supposed to work here?

    (It does seem like there was possibly a separate bug introduced in
    1.0.6 that was later fixed; we can probably ignore that and just
    focus on the behavior in the current tip of master).

  - is there a better way to represent this kind of "transform this
    everywhere _except_ in this function" semantic patch? (preferably
    one that does not tickle this bug, if it is indeed a bug ;) ).

-Peff
