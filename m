Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED60C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 10:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6789022518
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 10:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbgLDKO0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 05:14:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:51278 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387586AbgLDKO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 05:14:26 -0500
Received: (qmail 25145 invoked by uid 109); 4 Dec 2020 10:13:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 10:13:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9693 invoked by uid 111); 4 Dec 2020 10:13:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 05:13:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 05:13:43 -0500
From:   Jeff King <peff@peff.net>
To:     Ben Denhartog <ben@sudoforge.com>
Cc:     git@vger.kernel.org
Subject: Re: Unexpected behavior with branch.*.{remote,pushremote,merge}
Message-ID: <X8oL190Vl03B0cQ/@coredump.intra.peff.net>
References: <a4ae4e1a-b457-4b35-878c-2714ebfc415f@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4ae4e1a-b457-4b35-878c-2714ebfc415f@www.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 03, 2020 at 06:26:15PM -0700, Ben Denhartog wrote:

> I have a few repositories on my system that exist primarily as local copies of remote repositories, in that I normally just want to track and follow the upstream project (however, I periodically contribute back upstream so they are technically forks -- origin is my remote, upstream is theirs).
> 
> In these repositories, I set the following configuration:
> 
> ```
> [remote "origin"]
>   url = https://git.foo.com/me/bar.git
>   fetch = +refs/heads/*:refs/remotes/origin/*
> [remote "upstream"]
>   url = https://git.foo.com/them/bar.git
>   fetch = +refs/heads/main:refs/remotes/upstream/main
>   tagopt = --no-tags
> [branch "main"]
>   remote = upstream
>   pushRemote = origin
>   merge = refs/heads/master
>   rebase = true
> ```

I use a similar setup myself, and it works well for this kind of
triangular flow. A few notes:

  - I assume you mean "merge = refs/heads/main" from your examples

  - instead of branch.*.pushremote, I usually set remote.pushdefault, so
    that it covers all branches (i.e., I'd never want to push to the
    upstream remote, which I do not even have access to).

  - in a workflow like this, I generally have push.default set to
    "current"

  - I make frequent use of @{push} to refer to the matching branch on my
    remote (e.g., after doing some local work, I might use "git
    range-diff upstream @{push} HEAD" to examine the changes before
    pushing them up).

> Based on my understanding of the branch configuration options, this
> should effectively force my local `main` branch to track against
> `upstream/main`, but push to `origin/main`. I notice what I believe to
> be odd behavior when fetching: that FETCH_HEAD doesn't resolve to
> `upstream/main` as I would expect:
> 
> ➜ git fetch --all
> Fetching origin
> Fetching upstream
> remote: Enumerating objects: 23, done.
> remote: Counting objects: 100% (23/23), done.
> remote: Total 32 (delta 23), reused 23 (delta 23), pack-reused 9
> Unpacking objects: 100% (32/32), 12.97 KiB | 949.00 KiB/s, done.
> From https://git.foo.com/them/bar
>    63f7159..e65b80e  main     -> upstream/main

The culprit here is using "git fetch --all". It triggers the sub-fetches
with --append, so they'll each add to FETCH_HEAD instead of overwriting
it.  We do truncate it before the first one, so after this completes it
should have the complete set of refs fetched from both remotes (even if
it was a noop to fetch one of them, anything mentioned in the refspecs
shows up in FETCH_HEAD).

Which is what you're seeing here:

> ➜ cat .git/FETCH_HEAD
> 23e6881719f661c37336d9fcf7a9005a7dfce0cf        not-for-merge   branch 'main' of https://git.foo.com/me/foo
> e65b80edd2a2162f67120a98e84bb489f15fcf97                branch 'main' of https://git.foo.com/them/foo

FETCH_HEAD is not just a ref, but contains some magic instructions that
get interpreted by git-pull. But when programs besides git-pull try to
resolve it to a single object, they just pick whichever value is first.

So I do think there's a bug there, or at least something not
well-thought-out in the way that "fetch --all" appends. Normally fetch
tries to put the merge branch (or branches) first in the file, exactly
so this naive "take the first one" lookup will do the most sensible
thing. But when running multiple fetches that all append, we get their
individual outputs in the order of fetch (which in turn is the same as
the order in the config file).

Perhaps the parent "git fetch --all" triggering the sub-fetches should
reorder FETCH_HEAD after they've all finished (to pull any merge heads
up to the top, regardless of which remote they came from).

But an obvious workaround, if you know you'll always be merging from
upstream, is to just reorder your config stanzas so that it's fetched
first (likewise you can run "git fetch --multiple upstream origin" to
specify the order manually, or define a group with remotes.<group>).

One reason I suspect nobody has come across this before is that there's
not much reason to use FETCH_HEAD in this setting. If you know you want
to rebase again upstream/main, then there are a number of ways you can
refer to that:

  - upstream/main

  - upstream, if your refs/remotes/upstream/HEAD is set up (if you
    didn't clone, you may want to run "git remote set-head upstream -a")

  - @{upstream}, if it's configured as your upstream (which it is here)

  - @{u}, a shorter synonym

  - nothing at all, since rebasing against the upstream is the default
    for git-rebase these days

  - you can say that (or even just "upstream", if your
    refs/remotes/origin/HEAD is set up)

> Curiously, `git rebase FETCH_HEAD` seems to think the local branch is
> up to date (erroneously),

That's what I'd expect, since it is doing the naive "what is the first
one in the file" lookup.

> however `git-pull --rebase=true` [works]

That is running a new git-fetch under the hood, which will overwrite
FETCH_HEAD (and will only fetch from upstream, since that's what's in
branch.main.remote).

> `git-merge FETCH_HEAD` both work as expected and merge/rebase with
> `upstream/main`.

I think git-merge, like git-pull, understands the magic FETCH_HEAD
format.

> Am I going about this incorrectly? The main purpose behind configuring
> my "mostly just a fork" repository is that it simplifies tracking
> against an upstream remote for projects which I do not work on
> actively. Of course, you might argue that I don't need to keep my
> remote around for this purpose and can just use a straightforward
> `git-clone` here -- but I'd rather not, and would prefer responses
> addressing the perceived bug rather than suggesting this particular
> alternative workflow.

I think your workflow is perfectly reasonable.

-Peff
