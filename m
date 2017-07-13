Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DF7A202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 18:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbdGMSNy (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 14:13:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:39568 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751017AbdGMSNx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 14:13:53 -0400
Received: (qmail 32331 invoked by uid 109); 13 Jul 2017 18:13:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 18:13:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3001 invoked by uid 111); 13 Jul 2017 18:14:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 14:14:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 14:13:50 -0400
Date:   Thu, 13 Jul 2017 14:13:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
Message-ID: <20170713181350.tb6gndxc66ewpggj@sigill.intra.peff.net>
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>
 <xmqqzic8xsxd.fsf@gitster.mtv.corp.google.com>
 <20170713155313.whucxkoita6nvmhz@sigill.intra.peff.net>
 <xmqqvamwxm1y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvamwxm1y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 10:51:21AM -0700, Junio C Hamano wrote:

> > But imagine force-with-lease rule were more like: when pushing
> > branch "foo" to remote branch "bar", allow only if the current value of
> > "bar" is an ancestor of some entry in the reflog of "foo".
> 
> Would that cover the case that originally motivated the "with lease"
> thing?  Let's see.
> 
>           BC            "foo"
>          /
>     o---A---B---C       "bar"
> 
> You are pushing back to "bar" that still has C (or it may have
> acquired D) from "foo" that is now at BC.  It is likely that you
> started to prepare the "A---BC" history from "A---B---C" history, in
> which case your current branch "foo" that is being pushed out would
> have had C at its tip some time in the past.  So seeing that the tip
> of the remote is still C, which is in the reflog of "foo", we can
> happily push it out.  If the tip of the remote "bar" is now D
> because somebody updated it, you did not consider it while preparing
> your BC, and we want to fail the push---because D does not appear in
> the reflog of "foo", that is achieved.

Yeah. I think where this scheme falls down is if you incorporate work
from the remote ref _without_ it ever being in your ref[1]. So for
example I could do something like:

    $ git fetch  ;# new commits arrive
    $ git log origin/master ;# oh my, that tip commit looks broken
    $ git reset --hard origin/master^  ;# lets get rid of it
    $ git push --force-with-lease

and that tricks the system. But the nice thing is that it tricks it in
the "safe" direction. We'd refuse such a push, unless you do it more
like:

    $ git merge origin/master
    $ git reset --hard HEAD^
    $ git push --force-with-lease

Which is really the sane way to do it in the first place.

What I'd wonder more is if there are cases where we fail in the unsafe
direction. Here's the most plausible scenario I could come up with:

  $ git pull ;# get some new commits
  $ git reset --hard HEAD^ ;# doh, that merge didn't look right
  $ git rebase -i ;# hack hack hack
  $ git push --force-with-lease ;# oops, I should have re-merged

We get fooled because yes, we were once on the remote's tip. But we
discarded it and then did a _different_ rewriting operation (of course
it is impossible for the tool to tell if the original "reset --hard" was
an intentional rewriting operation, or one where we simply backed out a
mistake).

[1] Another sticking point is that this really does need to be in the
    reflog of the ref we are pushing (and not, e.g., HEAD). But one does
    not always push from a ref. I suspect that's OK in practice, though.
    If you are doing "git push --force-with-lease HEAD~2:master", it is
    probably OK for us to error out with "uh, lease from what?".

> I wonder if this could be a replacement for the current "the user
> did not even specify what the expected current value is, so we
> pretend as if the tip of the remote-tracking branch was given"
> kludge.

Yes, that is exactly what I was thinking of (and why I said that even
though this really isn't force-with-lease in a strict sense, it slots
into the same level of safety, so it might be worth using the name).

> Instead,
> 
> 	git push --force-with-lease origin master
> 	git push --force-with-lease origin topic:master
> 	git push --force-with-lease origin HEAD:master
> 
> could
> 
>  (1) first learn where 'refs/heads/master' over there is at.  Call
>      it X (it may be C or D in the earlier example).
> 
>  (2) locate from which ref the commit we are pushing out is taken;
>      in the above examples, they are our refs/heads/master,
>      refs/heads/topic, and HEAD, respectively.  Call it R.
> 
>  (3) see if the reflog of R has X.  If so do a --force push;
>      otherwise fail.

Yes, more or less. A few thoughts:

  - that step 2 is where the "wait, that isn't even a ref" error above
    would come in

  - I suspect in the third example we probably ought to be using the
    reflog of the branch that HEAD points to. You would not want:

       $ git checkout advanced-branch $ git checkout older-branch $ git
       push --force-with-lease origin HEAD:older-branch

    to consider that commits in advanced-branch are part of the lease.

  - For step 3, I'm not sure if we you mean to look for exactly X, or
    if it would be OK to have any commit whose ancestor is X. I think
    you'd need the latter to accommodate a non-fast-forward "git pull"
    (or fetch+merge) where the local ref is never set precisely to the
    upstream commit.

-Peff
