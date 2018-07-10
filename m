Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC6C1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 04:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751119AbeGJEpD (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 00:45:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:53156 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751099AbeGJEo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 00:44:58 -0400
Received: (qmail 22696 invoked by uid 109); 10 Jul 2018 04:44:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Jul 2018 04:44:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19734 invoked by uid 111); 10 Jul 2018 04:44:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 10 Jul 2018 00:44:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jul 2018 00:44:56 -0400
Date:   Tue, 10 Jul 2018 00:44:56 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Add merge recursive testcases with undetected
 conflicts
Message-ID: <20180710044456.GA1870@sigill.intra.peff.net>
References: <xmqqr2kce1mw.fsf@gitster-ct.c.googlers.com>
 <20180709202229.10222-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180709202229.10222-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 09, 2018 at 01:22:29PM -0700, Elijah Newren wrote:

> Oh, I didn't know about test-lint.  Is there a place that documents
> the various checks you run, so I can avoid slowing you down?  Ones I
> know about:
> 
> Already documented:
>   * `make DEVELOPER=1` (from CodingGuidelines)
>   * running tests (from SubmittingPatches)
> 
> Stuff I've seen you mention in emails over time:
>   * linux/scripts/checkpatch.pl
>   * git grep -e '\<inline\>' --and --not -e 'static inline' -- \*.h
>   * make -C t/ test-lint

test-lint is supposed to be run automatically as part of "make test" (or
"make prove"), unless you've specifically disabled it by setting
TEST_LINT. And it does complain for me with your patches. If it doesn't
for you, then we have a bug to fix. :)

I won't be surprised, though, if you just ran "./t6036" manually before
sending, since your patches literally didn't touch any other files.

In theory we could push some of the linting down into the test scripts
themselves (some of it, like the &&-linter, is there already by
necessity). But it might also end up annoying, since usually dropping
down to manual single-test runs means you're trying to debug something,
and extra linting processes could get in the way.

> Are there others?

I like:

  make SANITIZE=address,undefined test

though it's pretty heavy-weight (but not nearly as much as valgrind).
You probably also need BLK_SHA1=Yes, since the default DC_SHA1 has some
unaligned loads that make UBSan complain. We should maybe teach the
Makefile to do that by default.

I've also been playing with clang's scan-build. It _did_ find a real bug
recently, but it has a bunch of false positives.

Stefan runs Coverity against pu periodically. IIRC It's a pain to run
yourself, but the shared results can be mailed to you, or you can poke
around at https://scan.coverity.com/projects/git. That _also_ has a ton
of false positives, but it's good about cataloguing them so the periodic
email usually just mentions the new ones.

-Peff
