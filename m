Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5AD20365
	for <e@80x24.org>; Thu, 13 Jul 2017 20:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbdGMUtt (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:49:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:39966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753116AbdGMUtt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:49:49 -0400
Received: (qmail 6120 invoked by uid 109); 13 Jul 2017 20:49:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 20:49:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5160 invoked by uid 111); 13 Jul 2017 20:50:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jul 2017 16:50:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jul 2017 16:49:46 -0400
Date:   Thu, 13 Jul 2017 16:49:46 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
Message-ID: <20170713204946.wfshkwpqoiwqgkft@sigill.intra.peff.net>
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>
 <xmqqzic8xsxd.fsf@gitster.mtv.corp.google.com>
 <20170713155313.whucxkoita6nvmhz@sigill.intra.peff.net>
 <xmqqvamwxm1y.fsf@gitster.mtv.corp.google.com>
 <20170713181350.tb6gndxc66ewpggj@sigill.intra.peff.net>
 <xmqqvamww3tc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvamww3tc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 12:10:39PM -0700, Junio C Hamano wrote:

> >   - I suspect in the third example we probably ought to be using the
> >     reflog of the branch that HEAD points to. You would not want:
> >
> >        $ git checkout advanced-branch $ git checkout older-branch $ git
> >        push --force-with-lease origin HEAD:older-branch
> >
> >     to consider that commits in advanced-branch are part of the lease.
> 
> The third one was meant to be rewriting on detached HEAD, not having
> any underlying branch.

Ah, OK, that makes a lot more sense. I'd be tempted to say that it
should not allow force-with-lease at all. The HEAD reflog sees too many
unrelated things to make it a good basis for "does this result account
for everything in its reflog".

> >   - For step 3, I'm not sure if we you mean to look for exactly X, or
> >     if it would be OK to have any commit whose ancestor is X. I think
> >     you'd need the latter to accommodate a non-fast-forward "git pull"
> >     (or fetch+merge) where the local ref is never set precisely to the
> >     upstream commit.
> 
> But the result in that case is a descendant of upstream you just
> merged, so you do not even want to use any form of forcing---you
> would rather want to rely on the usual "push must fast-forward"
> mechanism, no?

Sorry, I mean the case where you do a merge from the other side, but
then you end up rewinding the history in some way, taking into account
that merge and everything they did. For example:

  $ git pull
  $ git rebase  ;# this will flatten the merge
  $ git push --force-with-lease

There was never a moment where the other side's tip ref was in your
local branch, but you did incorporate it via the merge.

-Peff
