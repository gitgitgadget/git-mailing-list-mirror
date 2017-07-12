Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B6C1F661
	for <e@80x24.org>; Wed, 12 Jul 2017 20:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbdGLUA5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 16:00:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:38390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751161AbdGLUA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 16:00:57 -0400
Received: (qmail 7783 invoked by uid 109); 12 Jul 2017 20:00:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 20:00:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26862 invoked by uid 111); 12 Jul 2017 20:01:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Jul 2017 16:01:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jul 2017 16:00:54 -0400
Date:   Wed, 12 Jul 2017 16:00:54 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git gc --auto aquires *.lock files that make a subsequent
 git-fetch error out
Message-ID: <20170712200054.mxcabiyttijpbkbb@sigill.intra.peff.net>
References: <20130126224038.GA20849@sigill.intra.peff.net>
 <87bmopzbqx.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bmopzbqx.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 09:38:46PM +0200, Ævar Arnfjörð Bjarmason wrote:

> In 131b8fcbfb ("fetch: run gc --auto after fetching", 2013-01-26) first
> released with v1.8.2 Jeff changed git-fetch to run "git gc --auto"
> afterwards.
> 
> This means that if you run two git fetches in a row the second one may
> fail because it can't acquire the *.lock files on the remote branches you
> have & which the next git-fetch needs to update.

Is it really "in a row" that's a problem? The second fetch should not
begin until the first one is done, including until its auto-gc exits.
And even with background gc, we do the ref-locking operations first, due
to 62aad1849 (gc --auto: do not lock refs in the background,
2014-05-25).

> I happen to run into this on a git.git which has a lot of remotes (most
> people on-list whose remotes I know about) and fetch them in parallel:
> 
>     $ git config alias.pfetch
>     !parallel 'git fetch {}' ::: $(git remote)

Ah, so it's not in a row. It's parallel. Then yes, you may run into
problems with the gc locks conflicting with real operations. This isn't
really unique to fetch. Any simultaneous operation can run into problems
(e.g., on a busy server repo you may see conflicts between pack-refs and
regular pushes).

> And so would 'git fetch --all':
> 
>     $ GIT_TRACE=1 git fetch --all 2>&1|grep --line-buffered built-in|grep -v rev-list
>     19:31:26.273577 git.c:328               trace: built-in: git 'fetch' '--all'
>     19:31:26.278869 git.c:328               trace: built-in: git 'fetch' '--append' 'origin'
>     19:31:27.993312 git.c:328               trace: built-in: git 'gc' '--auto'
>     19:31:27.995855 git.c:328               trace: built-in: git 'fetch' '--append' 'avar'
>     19:31:29.656925 git.c:328               trace: built-in: git 'gc' '--auto'
> 
> I think those two cases are bugs (but ones which I don't have the
> inclination to chase myself beyond sending this E-Mail). We should be
> running the 'git gc --auto' at the very end of the entire program, not
> after fetching every single remote.
> 
> Passing some env variable (similar to the config we pass via the env) to
> subprograms to make them avoid "git gc --auto" so the main process can
> do it would probably be the most simple solution.

Yes, I agree that's poor. Ideally there would be a command-line option
to tell the sub-fetches not to run auto-gc. It could be done with:

  git -c gc.auto=0 fetch --append ...

Or we could even take the "--append" as a hint not to run auto-gc.

> The more general case (such as with my parallel invocation) is harder to
> solve.

Yes, I don't think it can solved. The most general case is two totally
unrelated processes which know nothing about each other.

> Maybe "git gc --auto" should have a heuristic so it checks whether
> there's been recent activity on the repo, and waits until there's been
> say 60 seconds of no activity, or alternatively if it's waited 600
> seconds and hasn't run gc yet.

That sounds complicated.

> Ideally a "real" invocation like git-fetch would have a way to simply
> steal any *.lock a background "git gc --auto" creates, aborting the gc
> but allowing the "real" invocation to proceed. But that sounds even
> trickier to implement, and might without an extra heuristic on top
> postpone gc indefinitely.

The locks are generally due to ref-packing and reflog expiration.  I
think in the long run, it would be nice to move to a ref store that
didn't need packing, and that could do reflog expiration more
atomically.

I think the way "reflog expire" is done holds the locks for a lot longer
than is strictly necessary, too (it actually computes reachability for
--expire-unreachable on the fly while holding some locks).

-Peff
