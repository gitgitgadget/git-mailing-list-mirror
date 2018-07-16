Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9661F597
	for <e@80x24.org>; Mon, 16 Jul 2018 17:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbeGPSFE (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 14:05:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:48052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727866AbeGPSFE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 14:05:04 -0400
Received: (qmail 6046 invoked by uid 109); 16 Jul 2018 17:36:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 17:36:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13294 invoked by uid 111); 16 Jul 2018 17:36:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 13:36:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 13:36:36 -0400
Date:   Mon, 16 Jul 2018 13:36:36 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
Message-ID: <20180716173636.GA18636@sigill.intra.peff.net>
References: <pull.9.git.gitgitgadget@gmail.com>
 <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
 <20180713203140.GB17670@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1807142351100.75@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1807142351100.75@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 14, 2018 at 11:56:57PM +0200, Johannes Schindelin wrote:

> > > To avoid this problem, let's prune the shallow list in `git repack` when
> > > the `-d` option is passed, unless `-A` is passed, too (which would force
> > > the now-unreachable objects to be turned into loose objects instead of
> > > being deleted).
> > 
> > I'm not sure if this covers all cases:
> > 
> >  - even with "-A", we may still drop objects subject to
> >    --unpack-unreachable. So if your pack has an old mtime (e.g., because
> >    you haven't packed in a while) I think you'd see the same problem.
> > 
> >  - if you use "-adk", we'd keep all objects, and this pruning would not
> >    be necessary
> 
> Sure. I can add those cases.

Thanks.

> > I understand how this solves your immediate problem, but it feels like a
> > weird layering violation (which I think is a result of existing layering
> > violations ;) ).
> 
> Okay, but please don't punish me for those existing layering violations by
> forcing me to address them, instead of a quick bug fix for a very real bug
> that was reported to me privately, and that I would like to see fixed
> relatively quickly.

I'm OK with having a partial fix, or one that fixes immediate pain
without doing a big cleanup, as long as it doesn't make anything _worse_
in a user-visible way. And that's really my question: is pruning here
going to bite people unexpectedly (not rhetorical -- I really don't
know)?

For instance, at GitHub we do not ever run "git gc", but have our
maintenance regimen that builds around "git repack". I don't think this
patch will matter to us either way, because we would never have a
shallow repository in the first place. But I'm wondering if people in a
similar situation might.

I'm also not entirely sure if people _care_ if their shallow list is
pruned. Maybe it's not a big deal, and should just be quietly cleaned
up.

And I know that you're probably coming at it from the opposite angle.
Somebody isn't running git-gc but doing a "repack -adl" and they _do_
want these shallow files cleaned up (because their repo is broken after
dropping the objects). I just want to make sure we don't regress some
other case.

> > I.e., it seems unexpected that "git repack" is going to tweak your
> > shallow lists. If we were designing from scratch, the sane behavior
> > seems to me to be:
> > 
> >   1. Shallow pruning should be its own separate command (distinct from
> >      either repacking or loose object pruning), and should be triggered
> >      as part of a normal git-gc.
> 
> I fail to see the value in a separate command.

The value of a separate command is that you can run those other commands
without triggering this behavior. I actually think "git prune" does too
much already (e.g., imagine that I do not ever want to prune objects,
but I _do_ want to get rid of tmp_pack and tmp_obj cruft; what command
do I run?). But that is definitely not a new problem. And I'm OK with
not fixing it for now. My main concern is that we are using the presence
of that mistake to justify making it again.

> And: `git gc` already calls `git prune`, which *does* prune the shallow
> list.

Right, I was trying to propose that each individual cleanup step which
_could_ be done independently should be done so, but that "gc" should
continue to do them all.

I think in the case of git-prune and prune_shallow(), it's a little
tricky, though. It looks like prune_shallow() relies on somebody having
marked the SEEN flag, which implies doing a full reachability walk. So
it's really amortizing the work already being done by prune.

Speaking of which, I don't see how your patch can work as-is. The repack
command does not do such a walk, so it has no idea which commits are
SEEN or not, and will delete all of them! Try this:

  [shallow of clone of git.git (or any repo)]
  $ git clone --no-local --depth=1 /path/to/git tmp
  ...
  $ cd tmp

  [we have a commit]
  $ git log --oneline -1
  de46fca (grafted, HEAD) repack -ad: prune the list of shallow commits

  [repacking with existing git is fine]
  $ git repack -adl
  ...
  $ git log --oneline -1
  de46fca (grafted, HEAD) repack -ad: prune the list of shallow commits

  [repacking with your patch empties the shallow file, which
   makes the repository look corrupt]
  $ /path/to/git repack -adl
  $ git log --oneline -1
  error: Could not read a2df50675979af639cf9490f7fc9b86fa18fd907
  fatal: Failed to traverse parents of commit de46fca5b43f47f3c5c6f9232a17490d39fc80b1

So either we have to do a reachability walk (which is expensive), or we
have to rely on some other command (like prune) that is doing a
reachability walk and reuse that work.

That also probably means my "separate command" suggestion is a bad one.
If we're trying to amortize work, then we're better to have a single
command with options to enable/disable certain operations (so in theory
I could use "git prune --no-prune-objects" to just clean up tempfiles,
and users of "repack -adl" could do something similar to _just_ prune
the shallow if they really didn't want to delete loose objects.

> >   AND ONE OF:
> > 
> >   2a. Objects mentions in the shallow file are important, and therefore
> >       _are_ considered reachable on their own. Neither repack nor prune
> >       needs to know or care.
> 
> If we were to do that, we would never be able to gc any stale shallow
> commits.
> 
> That would be rather bad a design, don't you agree?

I had meant for this to be coupled with my (1), which would presumably
remove unreachable commits from the shallow list in a separate step
(based on what criteria, I don't know -- again, I'm not really a shallow
user).

> >   2b. It's OK for shallow objects to be missing, and the shallow code
> >       should be more resilient to missing objects. Neither repack nor
> >       prune needs to know or care.
> 
> That would be possible. Kind of like saying: we do have this list of
> shallow commits, but oh, BTW, it is likely incorrect, so we painstakingly
> verify for every entry during every fetch and push that those commits
> objects are still there.

Obviously verifying reachability on each fetch is a bad idea. But my
understanding of the shallow list is that it says "this is a graft point
where we do not have any of the parents". If we find that we do not have
such an object, would it be OK to quietly ignore that? We used to claim
"we do not have the parents of X", but now we know "well, we do not have
X anymore either".

Again, I may be showing my ignorance of the shallow code here.

> It looks to me like a rather bad design, too, as the whole idea of having
> a `git gc` is to update such information *then*.

Right, I think "git gc" is absolutely the place to do such cleanups. My
only complaint was that having it as part of repack may be unexpected.

-Peff
