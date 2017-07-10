Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090FA20357
	for <e@80x24.org>; Mon, 10 Jul 2017 13:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754090AbdGJNYV (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 09:24:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:35378 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753839AbdGJNYV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 09:24:21 -0400
Received: (qmail 17804 invoked by uid 109); 10 Jul 2017 13:24:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 13:24:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5010 invoked by uid 111); 10 Jul 2017 13:24:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Jul 2017 09:24:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jul 2017 09:24:18 -0400
Date:   Mon, 10 Jul 2017 09:24:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/5] building git with clang/gcc address sanitizer
Message-ID: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I mentioned recently that I sometimes run the test suite with ASan, so
here are a few tweaks to make this easier (most of which I've been
carrying in my personal config.mak for a few years).

In my experience ASan does at least as well as valgrind at finding
memory bugs, and runs way faster. With this series, running:

  make SANITIZE=address test

takes about 4.5 minutes on my machine. A normal build+test is about 1.5
minutes on the same machine. I haven't timed a full run with --valgrind
recently, but I know that it is much much slower. :)

If you want to see it in action, you can do:

  make SANITIZE=address
  ./git log -g HEAD HEAD >/dev/null

which finds a bug I recently fixed (but the fix isn't in master yet).

There are other sanitizers, too. I _thought_ I had

  make SANITIZE=undefined test

running cleanly at one point, but it's definitely not clean now. Patch 5
helps a little by disabling unaligned loads in our get_be32() macros.
Once upon a time I had to set INTERNAL_QSORT, but it isn't necessary
anymore since everything goes through sane_qsort(). Most of the
remaining bugs are of a similar form, doing something like:

  memcpy(NULL, NULL, 0);

I don't know if it's worth having a sane_memcpy() there, or simply
tweaking the code to avoid the call (almost all of them are a single
call from apply.c:2870).

It looks like we also have a case of shifting off the left side of a
signed int, which is undefined.

You can also try:

  make SANITIZE=thread test

but it's not clean. I poked at some of the errors, and I don't think
there a problem in practice (though they may be worth cleaning up in the
name of code hygiene).

There's also:

  make SANITIZE=memory test

This is clang-only. It's supposed to find uses of uninitialized memory.
But it complains about writing out anything that zlib has touched. I
seem to recall that valgrind had a similar problem. I'm not sure what
zlib does to confuse these analyzers. For valgrind we were able to add a
suppression. We could probably do the same here, but I haven't looked
into it.

  [1/5]: test-lib: set ASAN_OPTIONS variable before we run git
  [2/5]: test-lib: turn on ASan abort_on_error by default
  [3/5]: Makefile: add helper for compiling with -fsanitize
  [4/5]: Makefile: turn off -fomit-frame-pointer with sanitizers
  [5/5]: Makefile: disable unaligned loads with UBSan

 Makefile      |  8 ++++++++
 t/test-lib.sh | 11 ++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

-Peff
