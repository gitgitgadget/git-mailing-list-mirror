Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FDCF1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 13:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbeHCPp3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 11:45:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:41774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729969AbeHCPp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 11:45:29 -0400
Received: (qmail 3836 invoked by uid 109); 3 Aug 2018 13:49:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Aug 2018 13:49:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1771 invoked by uid 111); 3 Aug 2018 13:49:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 Aug 2018 09:49:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2018 09:49:02 -0400
Date:   Fri, 3 Aug 2018 09:49:02 -0400
From:   Jeff King <peff@peff.net>
To:     Vadim Belov <vadim.belov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Squash & Merge Implementation
Message-ID: <20180803134901.GC28939@sigill.intra.peff.net>
References: <CALr1GiFBm9zJ1v-UWuVLWJJ+zFh-iTKOv=T4KETLN8qkW_0pAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALr1GiFBm9zJ1v-UWuVLWJJ+zFh-iTKOv=T4KETLN8qkW_0pAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 03, 2018 at 03:01:15PM +0300, Vadim Belov wrote:

> 1. This merges successfully without squash:
> git checkout origin/master
> git merge ${PR-Branch}
> git push origin HEAD:master
> git push origin --delete ${PR-Branch}

Right, this is a normal merge.

> 2. This closes the PR, but there is no update seen on master:
> git checkout origin/master
> git merge --squash --commit ${PR-Branch}
> git push origin HEAD:master
> git push origin --delete ${PR-Branch}

Doing "merge --squash --commit" doesn't do what you expect; namely
"--commit" does not override the non-committing nature of "--squash". It
only override a "--no-commit" found elsewhere.

IMHO this is something that could be improved in Git (i.e., telling the
difference between "the user did not say --no-commit" and "the user said
--commit" and respecting it for --squash).

But that explains what you see. The push to master is a noop, since you
didn't make a new commit. And then deleting the PR branch on GitHub
auto-closes the PR.

> 3. This fails to push to master with the error "GH006: Protected branch
> update failed"  (despite that the PR is set to SUCCESS):
> git checkout origin/master
> git merge --squash ${PR-Branch}
> git commit -am"comment"
> git push origin HEAD:${m_mainBranch}
> git push origin --delete ${m_prBranch}

So here you _do_ make an actual commit. But that commit doesn't look
like a merge to the receiver; it just looks like a single commit that
has all the changes there were on PR-Branch.

The tree of that commit should be the same tree that would result from a
real merge. So in theory things like protected-branch status checks
could handle that, but I suspect they use the actual commit id (the tree
id is fine if you're just doing CI, but if you wanted to have a status
check for commit messages, say, you'd obviously want that to be tied to
the actual commit object).

I don't offhand recall how that is implemented (and you could also be
falling afoul of other checks, like required reviews). But this is a
GitHub-specific question, and you should probably ask GitHub support to
go further.

-Peff
