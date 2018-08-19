Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C11BC1F954
	for <e@80x24.org>; Sun, 19 Aug 2018 20:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeHSXpi (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 19:45:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:60632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726171AbeHSXpi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 19:45:38 -0400
Received: (qmail 13427 invoked by uid 109); 19 Aug 2018 20:32:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 19 Aug 2018 20:32:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8168 invoked by uid 111); 19 Aug 2018 20:33:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 19 Aug 2018 16:33:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Aug 2018 16:32:53 -0400
Date:   Sun, 19 Aug 2018 16:32:53 -0400
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: fix bogus 'pack-objects to file can
 use bitmap' test
Message-ID: <20180819203253.GA5789@sigill.intra.peff.net>
References: <20180814114721.25577-1-szeder.dev@gmail.com>
 <4d6ffc81-a1e8-a60f-d53f-2ec159160fcd@gmail.com>
 <xmqqr2iyc526.fsf@gitster-ct.c.googlers.com>
 <CAM0VKjkT7fBJRie_3f4B13BHT9hp9MxRhuX5r1sogh2x7KQzbg@mail.gmail.com>
 <eeb04c94-50c1-13ee-880b-ea380031a685@gmail.com>
 <xmqq4lfsbvru.fsf@gitster-ct.c.googlers.com>
 <73346b91-6d19-651a-c361-1666a39681f0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73346b91-6d19-651a-c361-1666a39681f0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 19, 2018 at 07:50:42PM +0200, Andrei Rybak wrote:

> > I actually think the above gives way too confusing output, when the
> > actual output is empty and we are expecting some output.
> > 
> > The tester wants to hear from test_cmp "your 'git cmd' produced some
> > output when we are expecting none" as the primary message.  We are
> > trying to find bugs in "git" under development, and diagnosing iffy
> > tests is secondary.  But with your change, the first thing that is
> > checked is if 'expect' is an empty file and that is what we get
> > complaints about, without even looking at what is in 'actual'.
> 
> I came up with two solutions for this issue:
> 
>   1. Check both files at the same time (combination with Gábor's
>      function):
> 
> 	test_cmp () {
> 		if test "$1" != - &&
> 		   test "$2" != - &&
> 		   ! test -s "$1" && 
> 		   ! test -s "$2"
> 		then
> 			error "bug in test script: using test_cmp to check empty file; use test_must_be_empty instead"
> 		fi
> 		test_cmp_allow_empty "$@"
> 	}
> 
>      This will still be reporting to the developer clearly, but
>      will only catch cases exactly like the bogus test in t5310.

Doesn't that have the opposite issue? If we expect non-empty output but
the command produces empty output, we'd say "bug in the test script".
But that is not true at all; it's a failed test.

If we assume that "expect" is first (which is our convention but not
necessarily guaranteed), then I think the best logic is something like:

  if $1 is empty; then
    bug in the test script
  elif test_cmp_allow_empty "$@"
    test failure

We do not need to check $2 at all. An empty one is either irrelevant (if
the expectation is empty), or a test failure (because it would not match
the non-empty $1).

If we go that route, we should make sure that test_cmp's documentation
is updated to mention that the two sides are not symmetric (and possibly
update some callers, though I'd be OK leaving ones that aren't broken by
this, and just clean them up over time).

-Peff
