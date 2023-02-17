Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939EBC05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 20:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBQUmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 15:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjBQUmM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 15:42:12 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6325F838
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 12:42:07 -0800 (PST)
Received: (qmail 14795 invoked by uid 109); 17 Feb 2023 20:42:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Feb 2023 20:42:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23194 invoked by uid 111); 17 Feb 2023 20:42:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Feb 2023 15:42:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Feb 2023 15:42:06 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame-tree: add library and tests via "test-tool
 blame-tree"
Message-ID: <Y+/mnnJUz75yfWCN@coredump.intra.peff.net>
References: <patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 05, 2023 at 09:47:03PM +0100, Ævar Arnfjörð Bjarmason wrote:

> From: Jeff King <peff@peff.net>

I appreciate being credited, of course, but at some point I think this
becomes "Based-on-a-patch-by". And we may have crossed the line here.

> The "blame-tree" library allows for finding the most recent
> modification to paths in a tree. It does so by expanding the tree at a
> given commit, taking note of the current state of each path, and then
> walking backwards through history looking for commits where each path
> changed into its final sha1.
> 
> The "git blame-tree" command was first noted on the ML 2011[1], and
> over the years there have been mentions of it[2][3], and whether it
> could be upstreamed. The sources have been available at [4]'s
> "jk/blame-tree-wip" and "jk/faster-blame-tree-wip" branches.

Sort of. jk/blame-tree-wip probably matches what I sent to the list in
2011 (and that probably matches what was deployed at GitHub at the
time). And like all of my branches, I continually rebase it on git.git's
master branch. But like all branches in my repo with "-wip" in them, it
is not part of my daily driver, and I generally do not even build it
(and I would not be surprised if it does not build at all, or one of
those rebases introduced a horrible bug).

The jk/faster-blame-tree-wip was an experiment from 2014 to narrow the
pathspec as we found answers. But it was never deployed anywhere, and
likewise may or may not even build now. I think the general idea there
is sound (make pathspec lookups faster by using a trie, and then narrow
it), but I suspect it's not a full solution. In particular, I don't
think it does anything clever with merges. Since we are narrowing the
pathspec as we traverse, we can't rely on the usual pruning of side
branches that happens via limit_list(), as that is all up-front. So it
probably needs to look at each merge as we traverse and cull parents
based on TREESAME.

I believe GitHub later had patches to do that, but they didn't use the
pathspec machinery (because without the tries, it becomes accidentally
quadratic in the number of paths). I didn't work on those patches,
though (Stolee and Taylor did), and they're not anywhere in my
repository (and I no longer have access to the private github repo).

> This change attempts to start upstreaming this command, but rather
> than adding a command whose interface & semantics may be controversial
> starts by exposing & testing the core of its library through a new
> test helper.
> 
> An eventual "git blame-tree" command, or e.g. a new format for "git
> ls-tree" to show what a path "blames" to can then be implemented with
> this library.

OK. It's a little weird, as I do think the interface and semantics are
the more interesting part, but this certainly isn't hurting anybody to
go this route.

> * Removing the "--max-depth" changes to the diff code. We'll need
>   those eventually, but it's not required for a blame of a given list
>   of paths.
> 
>   As has been noted in previous on-list discussions the semantics of
>   the "max-depth" changes might be controversial, so it's worthwhile
>   to split those out so that they can be reviewed separately.

That's probably reasonable. The only two interesting "depths" are really
"recurse" and "don't recurse" (where "recurse" is probably what you'd
put in a user-facing tool, and "don't recurse" is what a site like
GitHub uses to do the blame for a single level of tree it's showing).
And that narrows the problem space quite a bit.

> * Made the "blame-tree" helper take "--" before any revision options,
>   for clarity. An eventual built-in command (if any) probably doesn't
>   want to enforce this, but it makes it clearer in the test helper
>   what's an argument for "blame-tree" itself, and what's an argument for
>   the revision machinery.

OK. Since this is just a test-helper, we don't care too much either way.

> * Minor updates for using C99 syntax, and "size_t" instead of "int"
>   when we're iterating over types whose "nr" is that size.

Reasonable.

> * Avoid sub-shelling in the tests, use "test-tool -C .." instead.

Yeah, the original code probably predates "-C". ;)

> The range-diff here is to peff's jk/blame-tree-wip. As noted above
> this is far from the full thing, but hopefully getting the basic bits
> of the library (sans the max-depth question) will make the review of
> subsequent bits easier.

I doubt this range-diff is useful to anybody. I'm probably the person
most likely to make sense of it, and it means nothing to me. It probably
makes sense conceptually to just treat this as a new topic that happens
to be based on older work.

But if you did want to base it on something, you probably ought to do so
on what GitHub is currently running in production (and again, talk to
Taylor or Stolee for that). Unless the intent is to use this as a base
for showing their changes. Though even then, I'm not sure the
intermediate state is all that interesting.

> [oodles of patch]

TBH, I didn't really look at this closely. It's been a decade, so even
for me reviewing this would basically be looking at it from scratch. And
as my Git time is a bit limited these days, I can't really promise
timely review of a big topic.

-Peff
