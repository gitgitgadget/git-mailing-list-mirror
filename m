Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E70A202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753853AbdGMPx2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:53:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:39220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753825AbdGMPx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:53:26 -0400
Received: (qmail 26472 invoked by uid 109); 13 Jul 2017 15:53:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 15:53:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32725 invoked by uid 111); 13 Jul 2017 15:53:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 11:53:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 11:53:13 -0400
Date:   Thu, 13 Jul 2017 11:53:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
Message-ID: <20170713155313.whucxkoita6nvmhz@sigill.intra.peff.net>
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>
 <xmqqzic8xsxd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzic8xsxd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 08:22:54AM -0700, Junio C Hamano wrote:

> > In other words, --force-with-lease could verify that the upstream branch
> > has no commits that weren't seen in the current branch's reflog, i.e. that
> > `git rev-parse HEAD@{upstream}` is identical to `git merge-base
> > --fork-point HEAD HEAD@{upstream}`.
> >
> > The assumption would be that you typically want to push with a lease only
> > when following the `pull --rebase` workflow. Meaning that you would only
> > want to force-push when your local branch had the upstream branch
> > integrated at some stage [*1*].
> 
> I suspect that the problem "--force-with-lease" wants to solve does
> not even appear in "pull --rebase" workflow, but let me think aloud
> to see where this leads, as the idea sounds interesting, even though
> I may have misunderstood what you meant by the above.
> 
> If you do a "pull --rebase", you first rewind to the upstream and
> then reapply your changes on top, meaning that the result would
> normally be based on what was once at the tip of the upstream and
> should fast-forward.  The only situation that a result of "pull
> --rebase" needs a non-ff push is when somebody else pushed there in
> the meantime, adding commits that you haven't seen yet.  And you
> do not want to force your push to lose their work with "--force",
> with or without any lease.

That assumes that you're pushing back to the upstream. You could be
doing a "pull --rebase" from upstream and then pushing up to another ref
(or even another repo).

Consider something like a topic branch whose @{upstream} is
origin/master, but you use the "current" push.default. If you do:

  $ git pull --rebase
  $ git push

then the push is a non-ff, because you're pushing the rebased commits.
You'd ideally want a way to force that without clobbering a push that
somebody else made to the topic branch.

I do think Dscho is on to something with the "see if it was ever in our
reflog" idea. What you really want as a default for force-with-lease is
some way to say "I want to change that ref from X to Y, but only for
values of X that I know Y has already considered and incorporated". So
the danger in using the tracking branch is that you may not have
incorporated that value (either because somebody fetched behind your
back, or because you simply forgot to merge it into your local branch
when doing your history-rewriting operation).

So even forgetting "git pull --rebase", doing:

  $ git fetch
  $ git rebase HEAD~2
  $ git push --force-with-lease

is bad, because your rebase didn't take into account what was fetched in
step 1. But imagine force-with-lease rule were more like: when pushing
branch "foo" to remote branch "bar", allow only if the current value of
"bar" is an ancestor of some entry in the reflog of "foo".

That degrades to the usual fast-forward rule if you just check the ref
tip.  And when checking the reflog entries, it shows that at some point
you had your local branch set to something that covered all of the
destination, but then later rewound or rewrote history. We don't have to
care what that operation was. "rebase" is a likely one, but "git reset
--hard HEAD^ && git push" would fall out naturally from the same rule.

It's not quite as safe as a true force-with-lease with a value would be.
For instance, if _upstream_ rewound by a commit, we'd happily undo that
rewind. But then, so does a normal non-forced fast-forward push.

So I'd say this is not really force-with-lease at all, but rather a
special mode that is somewhere between a normal fast-forward and a true
force-with-lease. I don't know if it would make sense to give it a
different name, or just lump it under force-with-lease.

-Peff
