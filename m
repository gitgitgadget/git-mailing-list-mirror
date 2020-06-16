Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49243C433E3
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355EA206F1
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgFPOJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:09:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:33270 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbgFPOJd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 10:09:33 -0400
Received: (qmail 22562 invoked by uid 109); 16 Jun 2020 14:09:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 14:09:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13302 invoked by uid 111); 16 Jun 2020 14:09:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 10:09:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 10:09:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default
 branch
Message-ID: <20200616140932.GK666057@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <875zbrcpgh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875zbrcpgh.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 11:47:10AM +0200, Ævar Arnfjörð Bjarmason wrote:

> But I do have purely technical concerns about where this is going.
> 
> The part where we just make it easier to do what you could do all along
> with sed(1) or whatever to rename the branch after "git init" is
> obviously correct (or close enough). That part's easy enough.
> 
> The parts I'm concerned about is the behavior of how we make the branch
> name persistent, which is new "while we're at it" behavior in git
> unrelated to the convenience of allowing a configuration of the main
> branch name without "git init --template" or after the fact sed(1)
> munging.

I've read the whole thing and left some specific comments, but your
thinking more or less matches mine, with a few notes below.

> Specifically:
> 
>  1. The special case in fmt-merge-msg we always had for "master" sucked
>     in terms of producing more verbose merge messages for those of us
>     who had repos where the main branch wasn't "master", but at least it
>     was consistent.
> 
>     Now we've created a situation where a user's local config impacts
>     what we put in the machine-generated commit messages.
> 
>     Now, these messages were never "plumbing", and other users could use
>     different git frontends than "core git" etc, but it's a really
>     useful property we've tried to maintain that a user's local
>     configuration doesn't change what we put in these messages. It's why
>     we've left them out of the i18n mechanism.

I'm actually tempted to say that "master" should stop being special.
It's a little nice, I guess, if merges back to the main branch are a
little more terse in their message. But I actually think consistently
saying:

  Merge branch 'jk/foo' into main

_even if it's the main branch_ is actually pretty sane. It conveys more
information about what happened that could be useful later, and I don't
think it makes the result less readable.

>  2. The whole core.mainBranch thing rubs me the wrong way. So now if we
>     rename a branch we munge it, but if you've got an older git version
>     or whatever you get different results and the config isn't carried
>     forward.
> 
>     I'd *really* like to avoid having what's essentially a refstore
>     side-value if we can.

I think it's necessary if we're going to have parts of the code that say
"this is the special branch in this repo". Because we must leave the
unconfigured state as "master is the special branch" in order to avoid
regressing existing repositories. It _could_ be a flag that says "I was
configured using init.mainBranch, so use that value". But I don't think
that solves your fundamental concerns.

However, I wonder if we can get away with saying "there is no special
branch" entirely. The things that care about the special branch are:

 - guessing HEAD; but this is guessing what the _remote_ side wants
   anyway, so it really has nothing to do with your local
   core.mainBranch (plus that guess shouldn't even be used much with
   modern git anyway).

 - the default branch for submodules; this is basically the same boat,
   and really ought to just be using the remote HEAD anyway.

 - slightly shorter merge messages. See above.

 - various "perhaps you should specify a branch such as master"
   messages. These could be reworded to avoid mentioning a specific
   branch, or could pick a real branch name.

 - fast-export anonymization. We could probably use HEAD as "ref0"
   instead (or do the output-map thing I mentioned, which is a much
   better solution anyway).

I think with that, we could ditch core.mainBranch entirely, with no
notion at all of "this branch is special in this repo". We use HEAD
where appropriate, and otherwise avoid any specialness.

>  3. Whatever we do with the submodule guess-a-name functionality, I
>     think it's the wrong path to make it proceed in lockstep with
>     MAIN_BRANCH_FOR_INIT.
> 
>     When you decide to change your branch names != when the rest of the
>     world does it.

Yeah, this was my main concern for the whole series: what will break in
a world of mixed main-branch names. Thankfully very little, it seems.
But as much as possible we should be not just choosing our preferred
value, but trying to match possible states. I think teaching the
HEAD-guessing to try a few names, plus using HEAD for submodules, will
pretty much do it (see my replies to individual patches for more
details).

-Peff
