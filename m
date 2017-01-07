Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9692C205C9
	for <e@80x24.org>; Sat,  7 Jan 2017 07:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbdAGHSg (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 02:18:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:36340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751734AbdAGHSe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 02:18:34 -0500
Received: (qmail 21984 invoked by uid 109); 7 Jan 2017 07:18:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 07:18:33 +0000
Received: (qmail 23210 invoked by uid 111); 7 Jan 2017 07:19:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 07 Jan 2017 02:19:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Jan 2017 02:18:32 -0500
Date:   Sat, 7 Jan 2017 02:18:32 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git discussion list <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] git-test: run automated tests against a range of Git
 commits
Message-ID: <20170107071832.2rucap3rskzmkgq4@sigill.intra.peff.net>
References: <1341c01a-aca7-699c-c53a-28d048614bfe@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1341c01a-aca7-699c-c53a-28d048614bfe@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 06, 2017 at 04:52:16PM +0100, Michael Haggerty wrote:

> I just released ﻿⁠⁠⁠⁠`git test﻿⁠⁠⁠⁠`, a script for running automated
> tests across a range of Git commits and keeping track of the results in
> git notes:
> 
>     https://github.com/mhagger/git-test
> 
> This is a script that I've been using in one form or another for years
> and I find it really handy [1].

Neat. I usually "git rebase -x 'make -j8 test' @{u}" after finishing a
topic to make sure the intermediate steps are good. But it would be neat
to have this running continuously in the background to alert me to
problems sooner (and the key thing there is that it remembers
already-run tests, so it should be safe to basically for new commits
every 10 seconds or so).

I did hit a few interesting cases trying out "git test". So here's a
narrative, and you can pick out where there may be room for improvement
in the tool, and where I'm just being dumb. :)

I tried it out first on a topic I finished earlier today, which has 3
commits. So I did:

  $ git test add 'make -j8 test'
  $ git test range @{u}..HEAD

It barfed on the first commit, because the script expects "git co" to
work, but I don't have that alias. No big deal (and I already submitted
a PR to fix it).

So then I reinvoked it like:

  $ git test range @{u}..HEAD

and it actually ran some tests. Yay.

And then of course I wanted to prove to myself how cool the notes
feature is, so I ran it again. It didn't run any tests this time. Yay
again. But there were a few surprises:

  $ git test range @{u}..HEAD
  setup_test default
  Using test default; command: make -j8 test
  Old status: bad
  Tree 9fcdbd5c78^{tree} is already known to be bad!
  Old status: good
  Tree c22f4f6624^{tree} is already known to be good.
  Old status: good
  Tree 19e2e62e5e^{tree} is already known to be good.
  Already on 'jk/wait-for-child-cleanup'
  Your branch is ahead of 'origin/master' by 3 commits.

  ALL TESTS SUCCESSFUL

My initial run with "git co" had left the first commit marked as "bad".
That's not _too_ surprising, since it did indeed fail. I think it's
probably a bug to record a failure note, though, if checking out fails.
It's not necessarily an immutable property of the tree. In my case, it
was obviously dependent on a change in the git-test code, but that's
hopefully a fairly uncommon occurrence. But there are other reasons for
git-checkout to complain. For instance, imagine topic "foo" creates file
"foo.c". If I do:

  $ echo content >foo.c
  $ git test foo@{u}..foo

then checkout will complain about overwriting the untracked "foo.c".
It's reasonable to abort the operation there, but probably not to write
a permanent failure note. The problem wasn't in "foo", but in my local
tree.

The second thing that surprised me was "ALL TESTS SUCCESSFUL", when
clearly one of them was known-bad. :)

So at this point I knew I needed to re-run the test. Looks like there's
a "--force" option. Let's try it. There's no need to re-run the other
two, so let's just give it one commit:

  $ git test range -f HEAD~2
  ...
  Object 95649d6cf9ec68f05d1dc57ec1b989b8d263a7ae^{tree} has no note
  Object e1970ce43abfbf625bce68516857e910748e5965^{tree} has no note
  Object 368f99d57e8ed17243f2e164431449d48bfca2fb^{tree} has no note
  Object ceede59ea90cebad52ba9c8263fef3fb6ef17593^{tree} has no note
  Object dfe070511c652f2b8e1bf6540f238c9ca9ba41d3^{tree} has no note
  Object 902d960b382a0cd424618ff4e1316da40e4be2f6^{tree} has no note
  ...

This started spewing out many lines like the one above, until I hit ^C.
Yikes!

Thinking something was wrong with the "-f" option, I tried it without:

  $ git test range -f HEAD~2
  ...
  commit e83c5163316f89bfbde7d9ab23ca2e25604af290 (origin/initial)
  Author: Linus Torvalds <torvalds@ppc970.osdl.org>
  Date:   Thu Apr 7 15:13:13 2005 -0700

      Initial revision of "git", the information manager from hell

Oops. Now I see the problem. I was expecting the arguments to be
rebase-like. But they're really rev-list like. So in both cases it
wanted to test all the way up from the root commits to HEAD~2.  The "-f"
version never got to testing a commit because it was so busy trying to
delete the old notes.

I see the symmetry and simplicity in allowing the user to specify a full
range. But it also seems like it's easy to make a mistake that's going
to want to test a lot of commits. I wonder if it should complain when
there's no lower bound to the commit range. Or alternatively, if there's
a single positive reference, treat it as a lower bound, with HEAD as the
upper bound (which is vaguely rebase-like).

A few other observations about the note deletion:

  - The "has no note" message should perhaps be suppressed. We're just
    trying to overwrite the value if there is one (alternatively,
    instead of removing it, just overwrite it, so the old note stays
    until we get a result one way or the other).

  - It was sufficiently slow that it looks like we invoke "git notes
    remove" once per commit. It would be a lot more efficient to batch
    them (not just in terms of process startup, but because you're going
    to write a _ton_ of intermediate notes trees).

    Of course none of that matters if you don't do something stupid like
    trying to "git test" 45,000 commits. :)

So OK. Now I know what's going on. And I can get what I want with:

  $ git test range -f HEAD~3..HEAD~2

which works, and now all of my tests are correctly marked. Of course
that's a lot to type. It would be easier as:

  $ git test range -f -1 HEAD~2
  usage: git-test [-h] {add,range,help} ...
  git-test: error: unrecognized arguments: HEAD~2

but the tool doesn't seem to like passing through the rev-list argument.

It would be even easier if I could just repeat my range and only re-test
the "bad" commits. It was then that I decided to actually read the rest
of "git test help range" and see that you already wrote such an option,
cleverly hidden under the name "--retest".

And one final nit. I notice there is also a "--keep-going" option. Which
made me surprised that we bothered to test HEAD~1 and HEAD, when we knew
that HEAD~2 was bogus. I suspect this is related to the "ALL TESTS
SUCCESSFUL" issue. Presumably cached test results are not treated as
"bad" in general, which seems funny to me.

So those were all little cosmetic things. The other big thing I wanted
to see was what it's like to fix a bug deep in a topic. So I used "git
rebase -i" to inset a compile error into the first commit of my 3-patch
series. And then I tested it:

  $ git test add -t compile 'make -j8'
  $ git test range -t compile HEAD~3..

As predicted, it stopped at the first commit and told me it was buggy.
But I'm dumped onto a detached HEAD, and I'm on my own to actually get
the working tree to a state where I can test and fix on my actual
branch.

That's a nice outcome of the "git rebase -x make" approach. When you hit
a bug, you can fix it, "git commit --amend", and "git rebase
--continue". The downside is that it takes ownership of the branch while
you're doing it. So the whole concept of "run this in the background
with a separate worktree" breaks down completely.

I think it should be possible to script the next steps, though.
Something like like "git test fix foo", which would:

  - expand the range of foo@{u}..foo to get the list of commits

  - see which ones were marked as broken

  - kick off an interactive rebase, but override GIT_EDITOR to mark any
    broken ones as "edit" instead of "pick"

That lets you separate the act of testing from the act of fixing. You
can let the tester run continuously in the background, and only stop to
fix when you're at an appropriate point in your work.

Anyway. Seems like a neat tool. I may play around with it and see if I
can fit it into my workflow.

-Peff
