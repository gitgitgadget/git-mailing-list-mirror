Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D1AECAAD3
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 05:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIOFIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 01:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIOFIP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 01:08:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1DD57573
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 22:08:12 -0700 (PDT)
Received: (qmail 8585 invoked by uid 109); 15 Sep 2022 05:08:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Sep 2022 05:08:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6561 invoked by uid 111); 15 Sep 2022 05:08:13 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Sep 2022 01:08:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Sep 2022 00:08:10 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Stopak <jacob@initialcommit.io>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Newbie contribution idea for 'git log --children': input
 requested
Message-ID: <YyKzOk5AQBz1pmAh@coredump.intra.peff.net>
References: <Yx5qjPhZ5AHkPHr7@MacBook-Pro-3.local>
 <xmqqillth1am.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqillth1am.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 11, 2022 at 05:41:21PM -0700, Junio C Hamano wrote:

> > But I'm wondering if it could be addressed by simply adding a
> > discrete check to see if any commits point to HEAD as a parent,
> > (only when the --children option is used of course), and if so,
> > populate those ids into the log message.
> 
> In a history where all commits and their parent-child relationship
> can be enumerated and the links can be reversed in-core, it would be
> trivial to implement.  The challenge is to make sure it works
> without wasting unusably large resources to do so in a real world
> project.  Having a commit-graph might help.

I talked a little with Jacob about this at the contributor summit. As
I don't think I've ever used --children myself, I was curious about the
use case. :)

I think it is that one might want to do something like:

   git log --children $some_old_oid

and get a better idea of what was going on around the commit, both
before and after. And there I think that yeah, enumerating all available
commits to build the reverse index would make sense.

I don't think it would be a strict fix for --children, though, for two
reasons:

  - the current --children is free-ish because we're marking the commits
    as we traverse, so no extra parsing is required (just some storage
    for the reverse index)

  - the semantics aren't quite the same. One obvious issue is that you
    might care more about children reachable from your starting tips
    than arbitrary (possibly unreachable) children in your object store.
    But another is that --children implies parent rewriting, so it's not
    a strict reversal of the parent-child links.

So we'd want to retain the existing --children, and this new mode might
become --children=all or something.

Just sketching out an implementation, I think it is kind of similar to
the "decorate" mechanism, where we build the commit->metadata mapping
ahead of time, and then add output to the commits that we show. So we'd
probably want to load it around the same time we call
load_ref_decorations().

The next question is: what do we put in it?

One idea is to just reverse all the commits we know about. I.e., use
for_each_loose_object() and for_each_packed_object(), similar to the way
"cat-file --batch-all-objects" works. Use lookup_commit_in_graph() to
use the commit-graph when we can, and check object types via
oid_object_info() before trying to parse them (so we can avoid loading
non-commits from disk entirely).

But another idea is to do a _separate_ traversal in order to decide
which commits to care about. Then we have to know which tips to start
that traversal from, and we may end up with something similar to
--decorate-refs in terms of expressing that traversal. But I suspect the
output here is more interesting to the user, because now you can ask
just about reachable children, or children reachable from release tags,
or from a specific branch, etc.

So you could do something like:

  git show --children=refs/heads/* $some_old_commit

and see where we went from $some_old_commit that eventually ended up on
a branch.

But getting back to the original use case, which is about providing
context for a commit: now we have the child commit id, but it's still a
bit of a pain to actually see what it's in it.

I usually solve this by doing a single traversal, and asking the pager
to jump straight to the commit of interest, at which point I can scroll
up and down to see the context. Like:

  git log --color | less +/$some_old_commit

I'm not 100% sure I understand the original use case. But if I do, and
that solves it, I wonder if we could make it more ergonomic somehow.
Likewise, I think using something like "tig" would be nice for viewing
context, but AFAIK it does not have an option to jump to a specific
commit. You can jump by line number, but it would be nice to be able to
do:

  tig --highlight=1234abcd

and get a graph starting at HEAD, but jump immediately to the line for
1234abcd.

-Peff
