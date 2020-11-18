Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE60BC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 06:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9396A24655
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 06:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKRGyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 01:54:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:33548 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgKRGyi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 01:54:38 -0500
Received: (qmail 21480 invoked by uid 109); 18 Nov 2020 06:54:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Nov 2020 06:54:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9510 invoked by uid 111); 18 Nov 2020 06:54:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Nov 2020 01:54:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Nov 2020 01:54:37 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
Message-ID: <20201118065437.GA16996@coredump.intra.peff.net>
References: <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
 <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
 <20181005165157.GC11254@sigill.intra.peff.net>
 <dca35e44-a763-bcf0-f457-b8dab53815cf@web.de>
 <20181005190847.GC17482@sigill.intra.peff.net>
 <c05f192b-4e89-48b0-1c23-b43ec6fdb74b@web.de>
 <20181005194223.GA19428@sigill.intra.peff.net>
 <c141fb44-904f-e8b6-119f-7d2d6bcfd81a@web.de>
 <20181017083340.GB31932@sigill.intra.peff.net>
 <20201118021605.GB360414@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201118021605.GB360414@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 06:16:05PM -0800, Jonathan Nieder wrote:

> Since this came up in [1], I took a glance at this.
> 
> I also think it looks reasonable, though it's possible to do better if
> we're willing to (1) cast between pointers to function with different
> signatures, which is portable in practice but I don't believe the C
> standard speaks to and (2) conditionally make use of gcc extensions,
> for typechecking.

The C standard definitely is not OK with calling a function through a
wrong declaration or cast. I won't find chapter and verse, but here's a
practical example:

-- >8 --
#include <stdio.h>
#include <stdint.h>

void foo(uint32_t a, uint32_t b)
{
	printf("got a = %u\n", a);
	printf("got b = %u\n", b);
}

typedef void (*almost_foo)(uint64_t, uint64_t);

int main(void)
{
	almost_foo bar = (almost_foo)foo;

	printf("real call:\n");
	foo(1, 2);
	printf("via cast:\n");
	bar(3, 4);
	return 0;
}
-- >8 --

The caller thinks it's passing uint64_t integers, but the function
thinks it's getting uint32_t integers. The output will depend on your
calling conventions. If I compile it on my 64-bit Linux machine, it
produces what you'd expect:

  $ gcc foo.c
  $ ./a.out
  real call:
  got a = 1
  got b = 2
  via cast:
  got a = 3
  got b = 4

That's because we're using the System V AMD64 ABI convention, which
passes the first six parameters via registers. And even after that, each
parameter on the stack uses 8 bytes (even if it's smaller), so the two
representations are equivalent.

But if I compile it in 32-bit mode, it doesn't work:

  $ gcc -m32 foo.c
  $ ./a.out
  real call:
  got a = 1
  got b = 2
  via cast:
  got a = 3
  got b = 0

That's because it's using the cdecl convention, which puts everything on
the stack, and which uses a minimum of 4 bytes per parameter. So each
64-bit value results in two 32-bit pushes onto the stack (of 0, and 3).

Now in practice you're probably fine as long as the number and sizes of
the parameters are the same between the function definition and what the
caller casts to. And so if we're talking about casting individual
parameters between a void parameter and another pointer, that would
usually be fine (in practice; the standard only says that void can store
the type of anything, so it _could_ be larger than some other pointers.
I don't know of any modern systems where this is true, though).

Which is all a roundabout way of saying that yes, I think this kind of
cast is probably OK in practice.

I _think_ the ccan type-checking macro you pointed to would catch this
sufficiently on systems with typeof() that it would also protect systems
with different calling conventions. But I admit it's pretty dense.

So I dunno. The nice thing is that this puts the ugliness all inside of
QSORT(), which becomes magically type-safe. But it involves importing a
lot of tricky bits under the hood.

The downside of René's patch is that it hides the declaration of the
comparison function (and the typesafe wrapper) inside a macro. But the
resulting code is (IMHO) pretty easy to comprehend.

-Peff
