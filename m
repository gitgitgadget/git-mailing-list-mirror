Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9711F20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 19:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754219AbdASTCm (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 14:02:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:41675 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754242AbdASTCe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 14:02:34 -0500
Received: (qmail 6178 invoked by uid 109); 19 Jan 2017 19:02:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 19:02:30 +0000
Received: (qmail 7853 invoked by uid 111); 19 Jan 2017 19:03:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 14:03:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jan 2017 14:02:27 -0500
Date:   Thu, 19 Jan 2017 14:02:27 -0500
From:   Jeff King <peff@peff.net>
To:     Jack Bates <bk874k@nottheoilrig.com>
Cc:     git@vger.kernel.org
Subject: Re: grep open pull requests
Message-ID: <20170119190227.opjisryyqn766tqy@sigill.intra.peff.net>
References: <276f6ed9-ff06-a00f-b88a-4d40d55c6d40@nottheoilrig.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <276f6ed9-ff06-a00f-b88a-4d40d55c6d40@nottheoilrig.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 11:12:03AM -0700, Jack Bates wrote:

> I have a couple questions around grepping among open pull requests.
> 
> First, "git for-each-ref --no-merged": When I run the following,
> it lists refs/pull/1112/head, even though #1112 was merged in commit
> ced4da1. I guess this is because the tip of refs/pull/1112/head is 107fc59,
> not ced4da1?

Right. Git's `--no-merged` is about commit ancestry.

> This maybe shows my lack of familiarity with Git details,
> but superficially the two commits appear identical -- [1] and [2] --
> same parent, etc. Nonetheless they have different SHA-1s.
> I'm not sure why that is -- I didn't merge the commit --
> but regardless, GitHub somehow still connects ced4da1 with #1112.

The commits differ only in the committer timestamp. Try:

  diff -u <(git cat-file commit 107fc5910) \
          <(git cat-file commit ced4da132)

Is it possible that somebody cherry-pick or rebased it? Looking at the
history of apache/trafficserver, I don't see any merges, which implies
to me that the project is using a rebase workflow to merge PRs.

It's much trickier to find from the git topology whether a particular
history contains rebased versions of commits.  You can look at the
--cherry options to "git log", which use patch-ids to try to equate
commits. Something like:

  git for-each-ref --format='%(refname)' 'refs/pull/*/head' |
  while read refname; do
	if test -z "$(git rev-list --right-only --cherry-pick -1 origin...$refname)
	then
		echo "$refname: not merged"
	fi
  done

That's obviously much less efficient than `--no-merged`, but it should
generally work. The exception is if the rebase changed the commit
sufficiently that its patch-id may have changed.

> So my question is, how are they doing that,

I suspect the answer is "somebody clicked the rebase button GitHub"
which simultaneously did the rebase and marked the PR as merged.

> Lastly, a question more about GitHub than Git, but: Given the way GitHub is
> setup, I hope I can get a list of unmerged pull requests from Git alone. Can
> you think of a way to list *open* pull requests,
> or is that status only available out of band?

That information isn't reflected in the git topology. It's in GitHub's
database. You can ask the API:

  https://developer.github.com/v3/

There are libraries to help with that:

  https://developer.github.com/libraries/

I think that's probably the best answer to your "unmerged" question,
too. Ask the API which PRs are unmerged, and then do whatever git-level
analysis you want based on that.

-Peff
