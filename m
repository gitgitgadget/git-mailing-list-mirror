Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDC6C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1945260F9F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 17:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhG0RiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 13:38:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:58868 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhG0RiP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 13:38:15 -0400
Received: (qmail 31068 invoked by uid 109); 27 Jul 2021 17:38:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jul 2021 17:38:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 964 invoked by uid 111); 27 Jul 2021 17:38:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jul 2021 13:38:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jul 2021 13:38:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [PATCH] test-lib.sh: use GIT_TEST_COLUMNS over COLUMNS
Message-ID: <YQBEhj/Y6m0pqOth@coredump.intra.peff.net>
References: <CAMMLpeT3bJcr7mRDpxmk32VqpAbNpN=fgPjmkcY+0zOBYruybQ@mail.gmail.com>
 <patch-1.1-f81f3911d5-20210726T235452Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-f81f3911d5-20210726T235452Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 01:57:09AM +0200, Ævar Arnfjörð Bjarmason wrote:

> In my c49a177beca (test-lib.sh: set COLUMNS=80 for --verbose
> repeatability, 2021-06-29) the test suite started breaking on recent
> versions of bash.
> 
> This is because it sets "shopt -s checkwinsize" starting with version
> 5.0, furthermore it started setting COLUMNS under "shopt -s
> checkwinsize" for non-interactive use around version 4.3.
> 
> A narrow fix for that issue would be to add this just above our
> setting of COLUMNS in test-lib.sh:
> 
> 	shopt -u checkwinsize >/dev/null 2>&1
> 
> But we'd then be at the mercy of the next shell or terminal that wants
> to be clever about COLUMNS.
> 
> Let's instead solve this more thoroughly. We'll now take
> GIT_TEST_COLUMNS over COLUMNS, and furthermore intentionally spoil the
> COLUMNS variable to break any tests that rely on it being set to a
> sane value.
> 
> If something breaks because we have a codepath that's not
> term_columns() checking COLUMNS we'd like to know about it, the narrow
> "shopt -u checkwinsize" fix won't give us that.

I guess people running with bash won't see the test breakage (because
bash will quietly "fix" the COLUMNS setting). But enough people run with
/bin/sh that we'll eventually notice.

> This approach does mean that any tests of ours that expected to test
> term_columns() behavior by setting COLUMNS will need to explicitly
> unset GIT_TEST_COLUMNS, or set it to the empty string. I'm doing the
> latter in all the tests changed here.

This is rather ugly, and I'm not in general a fan of adding more
test-only code into the bowels of Git itself. But it may be the least
bad solution.

The only alternative I could come up with is _not_ to set COLUMNS
everywhere, but instead insist on each individual test manually doing
"COLUMNS=80 git ...". Setting it as a one-shot seems to be reliable
enough. The downside is just that various tests will need to do so. We
already have quite a few that do, but I guess anything that uses the
progress meter is now subject to it.

-Peff
