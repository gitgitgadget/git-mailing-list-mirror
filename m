Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A0BC636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 21:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7568613C3
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 21:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhGOVJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:09:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:51282 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhGOVJR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 17:09:17 -0400
Received: (qmail 12606 invoked by uid 109); 15 Jul 2021 21:06:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jul 2021 21:06:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4857 invoked by uid 111); 15 Jul 2021 21:06:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jul 2021 17:06:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Jul 2021 17:06:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] tests: add a test mode for SANITIZE=leak, run it
 in CI
Message-ID: <YPCjTpumyh1P/DQj@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-1.4-0795436a24-20210714T172251Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.4-0795436a24-20210714T172251Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 07:23:51PM +0200, Ævar Arnfjörð Bjarmason wrote:

> While git can be compiled with SANITIZE=leak there has been no
> corresponding GIT_TEST_* mode for it, i.e. memory leaks have been
> fixed as one-offs without structured regression testing.

This opening puzzled me. I'm not sure I understand why we need a special
GIT_TEST_* mode for it.  If you do "make SANITIZE=leak test", then your
binaries will leak-check while running the tests.

I.e., there is nothing that test-lib.sh itself needs to do differently
to enable it.

What we _do_ need is some mechanism of annotating to tests to say "this
is known to leak", so that we can skip them for normal integration runs.

And that is part of what's going on in this patch, but I'm not sure it
is the simplest way to do it. The first question is: how do we want to
annotate the tests. By marking individual scripts or tests in the
test-files themselves? Or by using a separate list of "these scripts or
tests are known to pass"?

IMHO the latter is preferable. It keeps the annotations out of the way
of normal work (they are a temporary thing until we eventually pass the
whole suite leak free, but I expect they'll be with us for a while). The
downside is that the annotations may get out of sync with test numbers.
But if we are primarily annotating whole scripts (and not individual
tests), then that is generally pretty stable.

And with that in mind, can we just use an existing mechanism for picking
which tests to run, and drive it externally from the CI job?

We already have GIT_SKIP_TESTS and --run. Those are perhaps a bit
awkward for feeding huge lists to, and there is no environment
equivalent for --run (so you can't trigger it easily from "make test").
But what if we could do something like:

  GIT_TEST_RUN_FROM=t/leak-free make SANITIZE=leak test

and then t/leak-free contained the usual patterns like:

  t000*
  t1234.5

and so on. That requires two new features in test-lib.sh:

  - making a GIT_TEST_RUN variable that is the opposite of GIT_TEST_SKIP
    (instead of just the command-line --run).

  - adding GIT_TEST_{RUN,SKIP}_FROM variables to read the values from a
    file rather than the environment (I suppose the caller could just
    stuff the contents into the variable, but I expect that test-lib.sh
    may want to pare down the entries that do not even apply to the
    current script for the sake of efficiency in checking each test).

That infrastructure would then be applicable to other cases, too. Or
even just useful for using another list (or no list at all) when you
are looking at whether other tests are leak-free or not.

> This change add such a mode, we now have new
> linux-{clang,gcc}-sanitize-leak CI targets, these targets run the same
> tests as linux-{clang,gcc}, except that almost all of them are
> skipped.

I'm not clear on what we expect to get out of running it with both clang
and gcc. They should be producing identical results.

-Peff
