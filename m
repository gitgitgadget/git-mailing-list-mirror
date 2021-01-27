Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271D8C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 05:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08F82070A
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 05:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhA0Fmo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 00:42:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:40270 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239228AbhA0Ee7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 23:34:59 -0500
Received: (qmail 30601 invoked by uid 109); 27 Jan 2021 04:34:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Jan 2021 04:34:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8250 invoked by uid 111); 27 Jan 2021 04:34:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Jan 2021 23:34:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Jan 2021 23:34:03 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] Makefile: micro-optimize light non-test builds
Message-ID: <YBDtO82x5sBAs/6L@coredump.intra.peff.net>
References: <20210126160708.20903-1-avarab@gmail.com>
 <YBCGtd9if0qtuQxx@coredump.intra.peff.net>
 <xmqq5z3jyxa7.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5z3jyxa7.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 05:38:08PM -0800, Junio C Hamano wrote:

> The steps 2/4 and 3/4 did look like a useful feature, but I wonder
> why we even need to introduce NO_TEST_TOOLS in the first place.
> Wouldn't it be more natural to arrange them to be built by making
> "test::" target depend on them?  IOW, why do we need to have "all::"
> (our default) target depend on them?

Hmm. That is definitely more logical, and giving "make" more information
to make a good decision about what is needed. I do wonder if it would be
annoying in two cases, though:

  - people trigger the tests in other ways besides "make test". For
    instance, "make && cd t && make" works, as does just
    "make && cd t && ./t1234". With a more clever Makefile, those would
    fail (or worse, run out-of-date versions of the helpers, producing
    confusing results).

  - during refactoring, I often compile-test as I go (i.e., run "make"
    to see which callers still need changed, then fix them, repeat).
    If that didn't catch test helpers, then I'd think I was done and get
    bit later by "make test" trying to build more code. Not the end of
    the world, but a minor annoyance.

So I think even though I'd argue that giving "make" that extra
dependency information is "more correct", we are fighting uphill against
existing behavior, as well as things that make doesn't know (like that I
expect to be ready to run tests as long as "make all" has finished).

-Peff
