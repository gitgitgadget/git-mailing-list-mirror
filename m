Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A02C28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9463B20757
	for <git@archiver.kernel.org>; Sun,  3 May 2020 09:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgECJgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 05:36:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:35018 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726445AbgECJgr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 May 2020 05:36:47 -0400
Received: (qmail 22050 invoked by uid 109); 3 May 2020 09:36:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 03 May 2020 09:36:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4870 invoked by uid 111); 3 May 2020 09:36:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 03 May 2020 05:36:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 3 May 2020 05:36:46 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: respect the [skip ci] convention in our GitHub
 workflow "CI/PR"
Message-ID: <20200503093646.GC170902@coredump.intra.peff.net>
References: <pull.776.git.git.1588432087854.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.776.git.git.1588432087854.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 02, 2020 at 03:08:07PM +0000, Johannes Schindelin via GitGitGadget wrote:

>     It was mentioned to me that it might not be totally helpful to run all 
>     the builds whenever an in-progress branch is pushed to GitHub. For
>     example, if a contributor has dozens of topic branches in flight, they
>     might not want to have all of them built whenever a new end-of-day push
>     happens.

As I was probably (one of) the mentioners here, thank you for looking
into this. This definitely _helps_, and if you don't want to go further
I could certainly make do with it[1].

But here are some thoughts on what a more ideal solution would look
like (to me, anyway).

What I'd _most_ like is a separately-maintained list of branches (or
branch patterns) on which to run CI.  I mostly care about just testing
my personal equivalent of "next" (which is really "next" plus my stable
topics), and I'd probably only list that branch. Plus potentially a
special CI branch that I'd use when chasing down a failure that I can't
reproduce locally.

But I don't think there's any good way to implement that via GitHub
Actions. I thought perhaps we could pull data from a different branch in
the same repo, but referring to external "Actions" seems to require a
full repo name (and obviously putting git/git in that name doesn't help
anybody who's trying to override something in a fork).

Another alternative: could we trigger CI based on branch-names? Locally,
I call my unstable branches "jk/something-wip", and I'd like to skip all
of the "-wip" branches. That's basically equivalent to "[skip ci]" in
that I could just amend the tip commit of the -wip branches to say "skip
ci". But what if we flipped the default to _not_ build? I.e.:

  - continue to build all pull requests; if you opened one, you're
    serious enough to have other people look and should get CI feedback

  - build branches with a few well-known names or patterns. Maybe
    names like "master"? Or maybe "refs/heads/build-ci/*"? Or maybe
    anything in "refs/heads/<initials>/*"? We'd have to decide on a
    convention as a community.

  - do not build anything else; we have no idea if somebody in a fork is
    just pushing up a work in progress or not, and they may be surprised
    to get a CI failure notification back.

I'm not sure whether we want to be building all of the individual topics
in gitster/git or not. In theory that provides more information, but I'm
not sure if anybody is looking at them (and all of the notifications
would go to Junio anyway).

My ideas aren't really developed, but I guess what I'm wondering
foremost is whether other people are thinking along the same lines.

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index fd4df939b50..0e4a280d309 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -7,6 +7,7 @@ env:
>  
>  jobs:
>    windows-build:
> +    if: "!contains(toJSON(github.event.commits.*.message), '[skip ci]') && !contains(toJSON(github.event.pull_request), '[skip pr]')"

It's unfortunate to have to repeat this in every job, as opposed to in
the "on" event block, but I don't think that block is flexible enough to
do what we want here.

I don't know very much about Actions, but the code looks correct to me.

-Peff

[1] My current workaround is even more horrendous: I've turned off
    Actions entirely in peff/git, and then I separately push branches I
    want CI on into a separate repository. But that repo can't be a fork
    of git/git, because I already have one! So I now have an extra
    "git-ci" repo that isn't connected to anything. Yuck.
