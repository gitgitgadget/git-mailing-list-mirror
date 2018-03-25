Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9B611F404
	for <e@80x24.org>; Sun, 25 Mar 2018 04:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750957AbeCYELA (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 00:11:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:41946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750771AbeCYEK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 00:10:59 -0400
Received: (qmail 26642 invoked by uid 109); 25 Mar 2018 04:10:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 25 Mar 2018 04:10:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10971 invoked by uid 111); 25 Mar 2018 04:11:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 25 Mar 2018 00:11:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Mar 2018 00:10:57 -0400
Date:   Sun, 25 Mar 2018 00:10:57 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local
 branch
Message-ID: <20180325041056.GA22321@sigill.intra.peff.net>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
 <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 09:11:34AM +0530, Kaartic Sivaraam wrote:

> >> When rebasing interacitvely (rebase -i), "git branch -l" prints a line
> > 
> > The "git branch -l" threw me since "-l" is short for --create-reflog.
> > I'm guessing you meant "git branch --list".
> 
> That's surprising, I just tried "git branch -l" on a repository and I
> did get a list of branch names. Is this a consequence of some option
> parsing weirdness ?!

Sort of. The "-l" option causes us to set the "reflog" variable to 1.
And then we have no other command-line options, so we default to
"--list" mode. The listing code does not look at the "reflog" variable
at all, so it's just silently ignored.

So:

  git branch -l

_looks_ like it works, but only because list mode is the default. If you
did:

  git branch -l foo

you would find that it does list "foo" at all, but instead creates a new
branch "foo" with reflog.

> To be honest, I actually assumed "-l" to be a shorthand for "--list" and
> didn't check with it in the documentation; which I should have. Sorry,
> for that. I still wonder why "git branch -l" prints a list of branch
> names when it is not a shorthand for "--list" ? (BTW, I'm also surprised
> by the fact that "-l" is not act shorthand for "--list"!)

It's historical and quite unfortunate. Doubly so since probably nobody
has ever actually wanted to use the short "-l" to create a reflog, since
it's typically the default and has been for a decade.

We've been hesitant to change it due to backwards compatibility. While
"branch" is generally considered porcelain, it probably is the main
scripting interface for creating branches (the only other option would
be using "update-ref" manually). So I dunno. Maybe it would be OK to
transition.

Alternatively, we could at least detect the situation that confused you:

diff --git a/builtin/branch.c b/builtin/branch.c
index 6d0cea9d4b..89e7fdc89c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -676,6 +676,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		colopts = 0;
 	}
 
+	if (list && reflog)
+		die(_("--reflog in list mode does not make sense"));
+
 	if (force) {
 		delete *= 2;
 		rename *= 2;

That doesn't help somebody mistakenly doing "git branch -l foo", but
more likely they'd do "git branch -l jk/*" if they were trying to list
branches (and then "branch" would barf with "that's not a valid branch
name", though that may still leave them quite confused).

-Peff
