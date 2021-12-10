Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3ACC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 08:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbhLJIxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 03:53:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:48498 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238685AbhLJIxr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 03:53:47 -0500
Received: (qmail 17892 invoked by uid 109); 10 Dec 2021 08:50:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 08:50:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28172 invoked by uid 111); 10 Dec 2021 08:50:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 03:50:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 03:50:11 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Makefile: add test-all target
Message-ID: <YbMUw70vfxJ+hJW3@coredump.intra.peff.net>
References: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <pull.1005.v10.git.1638538470.gitgitgadget@gmail.com>
 <CABPp-BGpe9Q5k22Yu8a=1xwu=pZYSeNQoqEgf+DN07cU4EB1ew@mail.gmail.com>
 <xmqq4k7nmksi.fsf@gitster.g>
 <211207.86ilw0matb.gmgdl@evledraar.gmail.com>
 <xmqqh7bi27o9.fsf@gitster.g>
 <xmqq8rwu278d.fsf_-_@gitster.g>
 <211209.86fsr2l8vn.gmgdl@evledraar.gmail.com>
 <xmqq4k7htzpk.fsf@gitster.g>
 <211210.86a6h9duay.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211210.86a6h9duay.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 03:38:53AM +0100, Ævar Arnfjörð Bjarmason wrote:

> I just don't think it makes any sense that I edit say refs.[ch], run
> "make test" locally, but only see that something broke in scalar's
> specific use of libgit.a later when I look at GitHub CI.

I'm definitely sympathetic to this. Having been surprised by CI failure
on something that worked locally is annoying at best, and downright
frustrating when you can't easily reproduce the problem.

But isn't that already true for most of the value that CI provides?
While part of its purpose may be a back-stop for folks who don't run
"make test" locally, I think the biggest value is that it covers a much
wider variety of platforms and scenarios that you don't get out of "make
test" already.

In some of those cases you can reproduce the problem locally by tweaking
build or test knobs. But in others it can be quite a bit more
challenging (e.g., something that segfaults only on Windows). At least
in the proposed change here you'd only be a "make test-all" away from
reproducing the problem locally.

I dunno. I don't feel that strongly either way about whether scalar
tests should be part of "make test". Mostly just observing that this is
not exactly a new case.

> If I'm preparing patches for submission I'll need to get CI passing, so
> I'll need to fix those tests & behavior either way as it's
> in-tree. Knowing about the failures later-not-sooner wastes more time,
> not less.

I think there's probably a tradeoff here. How often you get a "late"
notification of a bug (and how much of your time that wastes) versus how
much time you spend locally running tests that you don't care about.

I do agree that CI presents a bit of a conundrum for stuff at the edge
of the project. It's become a de facto requirement for it to pass. In
general that's good. But it means that features which were introduced
under the notion of "the people who care about this area will tend to
its maintenance" slowly become _everybody's_ problem as soon as they
have any CI coverage. Another example here is the cmake stuff. Or the
recent discussion about "-x" and bash.

I wonder if there's a good way to make some CI results informational,
rather than "failing". I.e., run scalar tests via CI, but if you're not
working on scalar, you don't have to care. Folks who are interested in
the area would keep tabs on those results and make sure that Junio's
tree stays passing.

That view disagrees with the final paragraph here, though:

> The reason we do that with the completion is because some changes to
> e.g. tweak getopts will need to have a corresponding change to the
> completion.
> 
> The reason we've not done that with contrib/{subtree,mw-to-git}/ is
> because those are thoroughly in the category of only incidentally being
> in-tree.
> [...]
> Scalar is thoroughly on the "completion" side of that divide, not
> "subtree".

I haven't followed the discussion closely, but in my mind "scalar" was
still in the "it may live in-tree for convenience, but people who aren't
working on it don't necessarily need to care about it" camp. Maybe
that's not the plan, though.

-Peff
