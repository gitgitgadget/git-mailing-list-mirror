Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A88BC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbhK3VMM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:12:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:40516 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236111AbhK3VMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:12:09 -0500
Received: (qmail 14037 invoked by uid 109); 30 Nov 2021 21:08:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Nov 2021 21:08:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30362 invoked by uid 111); 30 Nov 2021 21:08:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Nov 2021 16:08:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Nov 2021 16:08:48 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] test-lib.sh: have all tests pass under "-x", remove
 BASH_XTRACEFD
Message-ID: <YaaS4Idhdyo2wZ9q@coredump.intra.peff.net>
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
 <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-9f735bd0d49-20211129T200950Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 09:13:23PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Once that's been removed we can dig deeper and see that we only have
> "BASH_XTRACEFD" due to an earlier attempt to work around the same
> issue. See d88785e424a (test-lib: set BASH_XTRACEFD automatically,
> 2016-05-11) and the 90c8a1db9d6 (test-lib: silence "-x" cleanup under
> bash, 2017-12-08) follow-up.
>
> I.e. we had redirection in "test_eval_" to get more relevant trace
> output under bash, which in turn was only needed because
> BASH_XTRACEFD=1 was set, which in turn was trying to work around test
> failures under "set -x".
> 
> It's better if our test suite works the same way on all shells, rather
> than getting a passing run under "bash", only to have it fail with
> "-x" under say "dash". As the deleted code shows this is much simpler
> to implement across our supported POSIX shells.

I'm mildly negative on dropping BASH_XTRACEFD. IMHO it is not worth the
maintenance headache to have to remain vigilant against any shell
function's stderr being examined, when there is single-line solution
that fixes everything. Yes, the cost of using bash is high on some
platforms, but "-x" is an optional feature (though I am sympathetic to
people who are _surprised_ when "-x" breaks things, because it really is
a subtle thing, and knowing "you should try using bash" is not
immediately obvious).

Some folks (like Gábor) disagree and have done the work so far to make
sure that we pass even with "-x". But it feels like this is committing
the whole project to that maintenance. I dunno.

-Peff
