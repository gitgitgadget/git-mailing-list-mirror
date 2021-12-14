Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFA1C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 13:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhLNNQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 08:16:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:51358 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229952AbhLNNQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 08:16:27 -0500
Received: (qmail 13535 invoked by uid 109); 14 Dec 2021 13:16:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Dec 2021 13:16:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24237 invoked by uid 111); 14 Dec 2021 13:16:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Dec 2021 08:16:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Dec 2021 08:16:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
Message-ID: <YbiZKYFR8kilit+0@coredump.intra.peff.net>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
 <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
 <xmqq4k7nmksi.fsf@gitster.g>
 <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
 <xmqqh7bi27o9.fsf@gitster.g>
 <xmqq8rwu278d.fsf_-_@gitster.g>
 <nycvar.QRO.7.76.6.2112110003530.90@tvgsbejvaqbjf.bet>
 <xmqqh7bcgaki.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7bcgaki.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 12:42:37AM -0800, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Teach the main Makefile a "test-extra" target, which goes into each
> >> package in contrib/ whose Makefile has its own "test" target and
> >> runs "make test" there.  Add a "test-all" target to make it easy to
> >> drive both the primary tests and these contrib tests from CI and use
> >> it.
> >
> > That sends a strong message that the stuff in contrib/ is now fully under
> > your maintenance, i.e. first-class supported.
> 
> I do not think running tests on stuff in contrib/ sends any such
> message.  It primarily helps _us_ to catch more regressions than we
> may otherwise miss.  By the way, this is not limited to contrib/; if
> we had tests for gitk, we would have caught the recent regression in
> "diff -m" before it got inflicted on the general public, but that
> would not have been just to help "gitk", but to help keep "diff -m"
> sane and stable [*].

I'd actually be a lot more sympathetic to automatically running gitk
tests, because it's just consuming the public API of git (i.e., the
scriptable plumbing interface). If we accidentally break that, it is the
problem of the person who made the breaking change, and we would want
them to know it as soon as possible.

With something like scalar, though, it is adding new callers of the
private API. It might be useful for somebody doing tree-wide refactoring
to know they've broken something there. But it might also be a hassle,
because now they have to care about fixing it, if they are interested in
un-breaking their build (or un-breaking CI). The scalar code is now
their problem, even though it's "just" in contrib/.

In other words, it comes down to a question of where the burden for
fixing things lies. Of course it is nice if somebody doing tree-wide
refactoring fixes up scalar, too. But by making it optional to build
and/or test stuff in contrib/ (rather than tying it to "make all" or to
CI), it lets people decide how nice they want to be.

For other stuff in contrib/, I'm not sure to what degree it applies.
diff-highlight is pretty standalone for instance. I guess it _could_ be
broken by a public-API change in Git, but I find it pretty unlikely.

> Of course, you have to bear the burden of (A) changing the way
> scalar uses the API, or (B) participating in the design of the
> change to the API that may break scalar's use so that everybody
> including scalar would be happy, or both.  It's not like I am
> responsible for everything that happens in the tree, and it is our
> shared responsibility to maintain the health of the codebase.  It is
> not limited to stuff inside or outside contrib/.
> 
> There are projects that want to use libgit.a by binding us as a
> submodule and without interacting with us very much.  And they are
> on their own when we change the internals.  Do you mean that you
> want to make scalar into the same status as they are?

I kind of thought that final paragraph was the plan, at least to start
with.

-Peff
