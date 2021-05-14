Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64E9C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 05:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D3161440
	for <git@archiver.kernel.org>; Fri, 14 May 2021 05:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhENFt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 01:49:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:54402 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230109AbhENFtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 01:49:25 -0400
Received: (qmail 16879 invoked by uid 109); 14 May 2021 05:48:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 May 2021 05:48:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30623 invoked by uid 111); 14 May 2021 05:48:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 May 2021 01:48:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 May 2021 01:48:13 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t: avoid sed-based chain-linting in some expensive cases
Message-ID: <YJ4PHbVoQ8+ubfBK@coredump.intra.peff.net>
References: <YJzGcZpZ+E9R0gYd@coredump.intra.peff.net>
 <CAN0heSp3mXQeqeC_Zd==bBoJCCWe-NzJsomuUf6MTxy7+WZ1wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSp3mXQeqeC_Zd==bBoJCCWe-NzJsomuUf6MTxy7+WZ1wA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 13, 2021 at 01:05:28PM +0200, Martin Ågren wrote:

> > +# Disable expensive chain-lint tests; all of the tests in this script
> > +# are variants of a few trivial test-tool invocations, and there are a lot of
> > +# them.
> > +GIT_TEST_CHAIN_LINT_HARDER_DEFAULT=0
> 
> Devil's advocate: Who do we expect to turn GIT_TEST_CHAIN_LINT_HARDER
> on, and when?  If no one ever does it then we might as well drop the
> "default" thing and just go "we won't bother linting these particular
> tests, ever". But as long as "someone" does it "sometimes", it's not
> like it's a very complex mechanism to carry around.

The answer is probably: people who suspect something is broken. We could
perhaps also turn it on for CI to be more complete there (and where 30
seconds of CPU time is relatively much smaller). It was also handy to
have while timing the impact, of course.

I'm not opposed to having it be less flexible, and in fact I wrote it
that way originally. But it doesn't actually make the code much simpler.
The assignments to _DEFAULT in the scripts become GIT_TEST_CHAIN_LINT_HARDER
and the read side has one less level of defaulting:

-test "${GIT_TEST_CHAIN_LINT_HARDER:-${GIT_TEST_CHAIN_LINT_HARDER_DEFAULT:-1}}" != 0 &&
+test "${GIT_TEST_CHAIN_LINT_HARDER:-1}" != 0 &&

I guess it's conceptually a little simpler, though. I dunno. I sort of
assumed it would just work and nobody would need to ever look at or
configure it either way. :)

> I seem to have 140 tests that haven't changed on disk since I did this
> particular clone in 2017. 235 haven't changed this calendar year. Maybe
> we could skip linting those tests that haven't been modified for several
> weeks on the basis that they can't reasonably have newly-introduced
> syntax mistakes. I guess it gets tricky where the t????-*.sh file
> doesn't change in a long time, but it sources tests from other places,
> such as a lib-foo.sh helper. We'd have to be a bit more clever there.
> That's all just thinking out loud, and definitely not something that
> should hold up your patch.

Yeah, I suspect that would work in general. But it seems like even more
complexity (now you have a cache of "I linted this script at time X and
it was good" that has to be written). It does increase the possible
savings though (up to perhaps 100 or so seconds of parallel CPU in my
case).

I think a bigger and better version of that is to actually see which
code paths are run by which scripts, and not even bother running scripts
that don't touch code which has changed. But that's a _lot_ more
complicated, and writing such a tool is probably at least worth a thesis
project. ;)

-Peff
