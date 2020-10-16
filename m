Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08D0C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 00:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A6A207F7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 00:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbgJPARG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 20:17:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:33772 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgJPARG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 20:17:06 -0400
Received: (qmail 25692 invoked by uid 109); 16 Oct 2020 00:17:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Oct 2020 00:17:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2906 invoked by uid 111); 16 Oct 2020 00:17:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 20:17:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 20:17:04 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
Message-ID: <20201016001704.GA2937048@coredump.intra.peff.net>
References: <20200809060810.31370-1-sunshine@sunshineco.com>
 <20200809174209.15466-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200809174209.15466-1-sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 09, 2020 at 01:42:09PM -0400, Eric Sunshine wrote:

> Under normal circumstances, if a test author misspells a filename passed
> to test_cmp(), the error is quickly discovered when the test fails
> unexpectedly due to test_cmp() being unable to find the file. However,
> if the test is expected to fail, as with test_expect_failure(), a
> misspelled filename as argument to test_cmp() will go unnoticed since
> the test will indeed fail, but for the wrong reason. Make it easier for
> test authors to discover such problems early by sanity-checking the
> arguments to test_cmp(). To avoid penalizing all clients of test_cmp()
> in the general case, only check for missing files if the comparison
> fails.

This patch caused some interesting confusion for me today.

I was looking at the patch from [1] which causes a test failure (and I
wanted to see where it failed, etc). And I got:

  $ ./t5601-clone.sh
  ok 1 - setup
  ok 2 - clone with excess parameters (1)
  ok 3 - clone with excess parameters (2)
  ok 4 - output from clone
  ok 5 - clone does not keep pack
  ok 6 - clone checks out files
  ok 7 - clone respects GIT_WORK_TREE
  error: bug in the test script: test_cmp 'r2/.git/HEAD' missing

which was somewhat unhelpful (or at least less helpful than a regular
test failure). The test in question does this:

	test_cmp r0/.git/HEAD r2/.git/HEAD &&

and expects to fail if an earlier step didn't correctly create r2. Is it
a bug or misuse of test_cmp for it to do so? I could see an argument
that it is, but I'm also not sure if there's a convenient alternative.
The best I could come up with is:

  test_path_is_file r2/.git/HEAD &&
  test_cmp r0/.git/HEAD r2/.git/HEAD

which isn't that great.

-Peff

[1] https://lore.kernel.org/git/20200130102933.GE840531@coredump.intra.peff.net/
