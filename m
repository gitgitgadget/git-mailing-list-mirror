Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBD8C64E90
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 12:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510C02222A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 12:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387923AbgLBMo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 07:44:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:48694 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387557AbgLBMoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 07:44:25 -0500
Received: (qmail 32489 invoked by uid 109); 2 Dec 2020 12:43:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Dec 2020 12:43:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7071 invoked by uid 111); 2 Dec 2020 12:43:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Dec 2020 07:43:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Dec 2020 07:43:44 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 6/6] fixup! reftable: rest of library
Message-ID: <X8eMAI4703sDpTzM@coredump.intra.peff.net>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
 <ded8d502d97d3d48dc0e4397b6153f4b06fa319b.1606545878.git.gitgitgadget@gmail.com>
 <X8Ya24TJd87hRq7H@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2012011519340.54@tvgsbejvaqbjf.bet>
 <X8by+j24ccvt0F04@coredump.intra.peff.net>
 <CAFQ2z_P3WmSyBJvhCQi-rOQRvUwbK9RH6CGvS2Br0zW-=xwa4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_P3WmSyBJvhCQi-rOQRvUwbK9RH6CGvS2Br0zW-=xwa4A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 02, 2020 at 12:01:49PM +0100, Han-Wen Nienhuys wrote:

> > I'm not sure if the long-term goal is to have this opaque unit-test
> > program or not. If it is, I was likewise going to suggest that its
> > ad-hoc output be replaced with TAP. But it looks like on your branch
> > that "test-tool reftable" does not produce output at all. So I may be a
> > bit behind on what the current state and forward plans are...
> 
> The most important requirement is that something fails if the
> unittests don't work. I surmised that that meant running tests from
> test-helper in some way, so this is what happens now. Looking for
> "unit.?test" across the git codebase didn't turn up much info. Happy
> to explore other solutions if you can give me pointers.

Normally we do a combination of:

  - git plumbing exposes scriptable commands, and we make sure those
    work. This is a much coarser-grained unit than testing individual C
    functions, but produces resilient tests because that interface is
    user-visible and stable (and in fact seeing test breakages is often
    a sign that one will be breaking real users).

    These are obviously driven by shell script tests emulating what
    users might run.

  - for unit tests of individual data types where it's not appropriate
    to have a user-facing command, we often add a test-tool helper that
    exposes specific functions (e.g., t/helper/test-date.c exposes date
    parsing and formatting routines, test-oid-array.c exercises methods
    of that data type, etc).

    The C parts of these are usually generic, and then are driven by
    shell scripts providing the actual data in individual tests (and
    handling success/failure, skipping tests, etc).

    This is still coarser than you might get unit-testing inside C.
    E.g., you could not generally check the difference between passing
    an empty array vs NULL to a function. But our philosophy has
    generally been _not_ to test at that level. The C interfaces are
    internal, and Git is not that big a project. If there's a function
    whose caller does something unexpected, it's usually easier to fix
    the caller and add a test that triggers the caller's code path.

I agree that a test that simply runs a bunch of C code and either exits
with failure or success is better than nothing, in the sense of finding
tests. And wrapping that with a single test_expect_success does that.
But it's unfortunate that we get none of the fine-grained control that
the test suite provides, nor much support in debugging failing tests.

One middle ground would be for a battery of C tests to output
TAP-compatible output (outputting "ok 1 - foo works", and "not ok 2 -
bar does not work", etc). That at least gives more info on what fails,
and does it in a way that the rest of the test suite can interpret
(though not manipulate).

-Peff
