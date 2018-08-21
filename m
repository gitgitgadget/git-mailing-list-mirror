Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9EF01F954
	for <e@80x24.org>; Tue, 21 Aug 2018 20:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeHVAFZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 20:05:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:50970 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726626AbeHVAFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 20:05:25 -0400
Received: (qmail 10606 invoked by uid 109); 21 Aug 2018 20:43:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Aug 2018 20:43:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26979 invoked by uid 111); 21 Aug 2018 20:43:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 21 Aug 2018 16:43:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Aug 2018 16:43:41 -0400
Date:   Tue, 21 Aug 2018 16:43:41 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: worktree duplicates, was: [PATCH] SubmittingPatches: mention
 doc-diff
Message-ID: <20180821204341.GA24431@sigill.intra.peff.net>
References: <20180821192321.GA720@sigill.intra.peff.net>
 <20180821193556.GA859@sigill.intra.peff.net>
 <CAPig+cT+LBSJHoR1kUi+S2h96y_qmVEpK0xAy6sRUGQj6GQEyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cT+LBSJHoR1kUi+S2h96y_qmVEpK0xAy6sRUGQj6GQEyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 21, 2018 at 04:22:08PM -0400, Eric Sunshine wrote:

> On Tue, Aug 21, 2018 at 3:36 PM Jeff King <peff@peff.net> wrote:
> > The script does basically this to set up the temporary tree:
> >
> >   test -d $tmp || git worktree add $tmp ...
> >
> > The script never cleans up the worktree (since its results can often be
> > reused between runs), but you may do so with "rm" or "git clean". That
> > creates an interesting situation if the script is run again before
> > "worktree prune" runs.
> 
> Aside from the problems you enumerate below, leaving worktrees sitting
> around which the user did not create explicitly does seem a bit
> unfriendly, which leads me to think that worktrees may not be the best
> tool for this task. How about using "git clone --shared" instead?

That seems even more dangerous to me, since the created clone can become
corrupt when the parent prunes. Probably not huge for a single
operation, but you may be surprised when you run the script a few days
later and it barfs horribly due to a missing object.

We could do a local filesystem clone which would make a hardlink. But
eventually those hardlinks would be broken, and we'd be wasting a lot of
extra space (and there's no provision for repacking or maintenance of
the temp repo; again, OK for a day or two, but if maybe not if you leave
this thing lying around for months).

I also considered just using "git archive | tar xf -" to create the
checkouts.  But we really would like to move between trees without
updating files unnecessarily (to avoid triggering rebuilds via make).

We could do that without a full-on worktree by just keeping our own
temporary index. But I think that potentially ends up with similar
problems to the "clone --shared" one: at some point objects in the
parent go away, and it has no idea about our custom index.

I think a worktree with a detached HEAD is roughly the same concept, but
with an officially-approved mechanism by which the parent knows about
our worktree.

> >   1. Should the script be doing something else to indicate that the
> >      worktree may be reused? I tried "git worktree remove", but it's
> >      unhappy that the directory doesn't exist. Should it quietly handle
> >      ignore that and remove any leftover cruft in $GIT_DIR/worktrees?
> 
> That's a weird case. There are multiple entries in
> .git/worktrees/*/gitdir pointing at the same worktree directory, which
> I don't think was considered when the machinery was being designed.
> "git worktree remove" refusing to delete the worktree in this case
> seems a good safety measure since something is obviously askew in the
> bookkeeping and it doesn't want to lose potential work.
> 
> The solution to this problem might be to upgrade "prune" as you
> describe in #3 and then ensure that that sort of aggressive pruning
> happens automatically at "git worktree add" time.

I would feel funny about running "git worktree prune" in my script,
since it may also delete _other_ worktrees. But if "worktree prune"
handled this case, I'd be OK just ignoring occasional duplicates, and
periodic "git gc" would clean up the cruft.

> >   2. Should "git worktree add" be more clever about realizing that an
> >      existing entry in $GIT_DIR/worktrees points to this directory? That
> >      would be fine for my use, but I wonder if there's some potential
> >      for loss (e.g., you blew away the work tree but until you do a
> >      "worktree prune", the refs are still there, objects reachable,
> >      etc).
> 
> In the case that you've already blown away the directory, then having
> "git worktree add" prune away the old worktree bookkeeping would make
> sense and wouldn't lose anything (you've already thrown it away
> manually). However, it could be lossy for the case when the directory
> is only temporarily missing (because it's on removable media or a
> network share).

I think the removable ones already suffer from that problem (an auto-gc
can prune them). And they should already be marked with "git worktree
lock". That said, people don't always do what they should, and I'd
rather not make the problem worse. :)

> In this case, it might make sense for "git worktree add" to refuse to
> operate if an existing worktree entry still points at the directory
> that you're trying to add. That should prevent those duplicate
> worktree entries you saw.

Yes, but then what's the next step for my script? I can't "remove" since
the worktree isn't there. I can't blow away any directory that I know
about, since there isn't one. I need to somehow know that an existing
"$GIT_DIR/worktrees/foo" is the problem. But "foo" is not even
deterministic. Looking at the duplicates, it seems to be the basename of
the working tree, but then mutated to avoid collisions with other
worktrees.

What about refusing by default, but forcing an overwrite with "-f"?

That should keep the existing case as safe as now, but give an outlet
for this kind of case where the caller is in charge of the worktree and
knows that any prior contents are trashable.

> However, upon further consideration, any of the proposed "fixes" could
> potentially be lossy. Consider a case like this:
> 
> % git worktree add foo
> ... make some changes in 'foo' ...
> % mv foo bar # (fogetting to do "git worktree move foo bar")
> % git worktree add foo
> 
> As currently implemented, one can "correct" the situation by manually
> fixing the bookkeeping file in .git/worktrees for the worktree created
> first. If it gets pruned automatically, then the state of those
> changes in "bar" (nee "foo") could be lost.

True, though again, you're already in danger with:

  $ git worktree add foo
  $ mv foo bar ;# forget to "git worktree move"
  $ git fetch ;# oops, we ran auto-gc!

-Peff
