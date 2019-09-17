Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D819C1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 00:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfIQA7a (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 20:59:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:52292 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728364AbfIQA73 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 20:59:29 -0400
Received: (qmail 20400 invoked by uid 109); 17 Sep 2019 00:59:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Sep 2019 00:59:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12879 invoked by uid 111); 17 Sep 2019 01:01:37 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Sep 2019 21:01:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Sep 2019 20:59:28 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190917005928.GA27926@sigill.intra.peff.net>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
 <20190916214452.GC6190@szeder.dev>
 <20190916231348.GB67467@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190916231348.GB67467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 16, 2019 at 04:13:49PM -0700, Jonathan Nieder wrote:

> Most tests use "setup" or "set up" in the names of test assertions
> that are required by later tests.  It's very helpful for debugging and
> maintenance to be able to skip or reorder some tests, so I've been
> able to rely on this a bit.  Of course there's no automated checking
> in place for that, so there are plenty of test scripts that are
> exceptions to it.
> 
> If we introduce a test_setup helper, then we would not have to rely on
> convention any more.  A test_setup test assertion would represent a
> "barrier" that all later tests in the file can rely on.  We could
> introduce some automated checking that these semantics are respected,
> and then we get a maintainability improvement in every test script
> that uses test_setup.  (In scripts without any test_setup, treat all
> test assertions as barriers since they haven't been vetted.)
> 
> With such automated tests in place, we can then try updating all tests
> that say "setup" or "set up" to use test_setup and see what fails.
> 
> Some other tests cannot run in parallel for other reasons (e.g. HTTP
> tests).  These can be declared as such, and then we have the ability
> to run arbitrary individual tests in parallel.

This isn't quite the same, but couldn't we get most of the gain just by
splitting the tests into more scripts? As you note, we already run those
in parallel, so it increases the granularity of our parallelism. And you
don't have to worry about skipping tests 1 through 18 if they're in
another file; you just don't consider them at all. It also Just Works
with things like HTTP, which choose ports under the assumption that the
other tests are running simultaneously.

It doesn't help with the case that test 1 does setup, and then tests 2,
3, and 4 are logically independent (and some could be skipped or not).

If anybody is interested in splitting up scripts, the obvious ones to
look at are the ones that take the longest (t9001 takes 55s on my
system, though the whole suite runs in only 95s). Of course you can get
most of the parallelism benefit by using "prove --state=slow,save",
which ends up with lots of short scripts at the end (rather than one
slow one chewing one CPU while the rest sit idle).

> Most of the time in a test run involves multiple test scripts running
> in parallel already, so this isn't a huge win for the time to complete
> a normal test run.  It helps more with expensive runs like --valgrind.

Two easier suggestions than trying to make --valgrind faster:

  - use SANITIZE=address, which is way cheaper than valgrind (and
    catches more things!)

  - use --valgrind-only=17 to run everything else in "fast" mode, but
    check the test you care about

-Peff
