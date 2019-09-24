Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AAE1F464
	for <e@80x24.org>; Tue, 24 Sep 2019 00:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392180AbfIXAza (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 20:55:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56680 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390912AbfIXAza (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 20:55:30 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 75F901F463;
        Tue, 24 Sep 2019 00:55:29 +0000 (UTC)
Date:   Tue, 24 Sep 2019 00:55:29 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190924005529.GA8354@dcvr>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
 <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 16 Sep 2019, Emily Shaffer wrote:
> >  - try and make progress towards running many tests from a single test
> >    file in parallel - maybe this is too big, I'm not sure if we know how
> >    many of our tests are order-dependent within a file for now...
> 
> Another, potentially more rewarding, project would be to modernize our
> test suite framework, so that it is not based on Unix shell scripting,
> but on C instead.

I worry more C would reduce the amount of contributors (some of
the C rewrites already scared me off hacking years ago).  I
figure more users are familiar with sh than C.

It would also increase the disparity between tests and use of
actual users from the command-line.

> The fact that it is based on Unix shell scripting not only costs a lot
> of speed, especially on Windows, it also limits us quite a bit, and I am
> talking about a lot more than just the awkwardness of having to think
> about options of BSD vs GNU variants of common command-line tools.

I agree that it costs a lot of time, and I'm even on Linux using
dash as /bin/sh + eatmydata (but ancient laptop)

> For example, many, many, if not all, test cases, spend the majority of
> their code on setting up specific scenarios. I don't know about you,
> but personally I have to dive into many of them when things fail (and I
> _dread_ the numbers 0021, 0025 and 3070, let me tell you) and I really
> have to say that most of that code is hard to follow and does not make
> it easy to form a mental model of what the code tries to accomplish.
> 
> To address this, a while ago Thomas Rast started to use `fast-export`ed
> commit histories in test scripts (see e.g. `t/t3206/history.export`). I
> still find that this fails to make it easier for occasional readers to
> understand the ideas underlying the test cases.
> 
> Another approach is to document heavily the ideas first, then use code
> to implement them. For example, t3430 starts with this:
> 
> 	[...]
> 
> 	Initial setup:
> 
> 	    -- B --                   (first)
> 	   /       \
> 	 A - C - D - E - H            (master)
> 	   \    \       /
> 	    \    F - G                (second)
> 	     \
> 	      Conflicting-G
> 
> 	[...]
> 
> 	test_commit A &&
> 	git checkout -b first &&
> 	test_commit B &&
> 	git checkout master &&
> 	test_commit C &&
> 	test_commit D &&
> 	git merge --no-commit B &&
> 	test_tick &&
> 	git commit -m E &&
> 	git tag -m E E &&
> 	git checkout -b second C &&
> 	test_commit F &&
> 	test_commit G &&
> 	git checkout master &&
> 	git merge --no-commit G &&
> 	test_tick &&
> 	git commit -m H &&
> 	git tag -m H H &&
> 	git checkout A &&
> 	test_commit conflicting-G G.t
> 
> 	[...]
> 
> While this is _somewhat_ better than having only the code, I am still
> unhappy about it: this wall of `test_commit` lines interspersed with
> other commands is very hard to follow.

Agreed.  More on the readability part below...

As far as speeding that up, I think moving some parts
of test setup to Makefiles + fast-import/fast-export would give
us a nice balance of speed + maintainability:

1. initial setup is done using normal commands (or graph drawing tool)
2. the result of setup is "built" with fast-export
3. test uses fast-import

Makefile rules would prevent subsequent test runs from repeating
1. and 2.

> If we were to (slowly) convert our test suite framework to C, we could
> change that.
> 
> One idea would be to allow recreating commit history from something that
> looks like the output of `git log`, or even `git log --graph --oneline`,
> much like `git mktree` (which really should have been a test helper
> instead of a Git command, but I digress) takes something that looks like
> the output of `git ls-tree` and creates a tree object from it.

I've been playing with Graph::Easy (Perl5 module) in other
projects, and I also think the setup could be more easily
expressed with a declarative language (e.g. GNU make)

> Another thing that would be much easier if we moved more and more parts
> of the test suite framework to C: we could implement more powerful
> assertions, a lot more easily. For example, the trace output of a failed
> `test_i18ngrep` (or `mingw_test_cmp`!!!) could be made a lot more
> focused on what is going wrong than on cluttering the terminal window
> with almost useless lines which are tedious to sift through.

I fail to see how language choice here matters.  But then again,
I have plenty of experience writing bad code in ALL languages I
know :>

> Likewise, having a framework in C would make it a lot easier to improve
> debugging, e.g. by making test scripts "resumable" (guarded by an
> option, it could store a complete state, including a copy of the trash
> directory, before executing commands, which would allow "going back in
> time" and calling a failing command with a debugger, or with valgrind, or
> just seeing whether the command would still fail, i.e. whether the test
> case is flaky).

Resumability sounds like a perfect job for GNU make.
(that said, I don't know if you use make or something else to build gfw)

> In many ways, our current test suite seems to test Git's functionality
> as much as (core) contributors' abilities to implement test cases in
> Unix shell script, _correctly_, and maybe also contributors' patience.
> You could say that it tests for the wrong thing at least half of the
> time, by design.

Basic (not advanced) sh is already a prerequisite for using git.

Writing correct code and tests in ANY language is still a
challenge for me; but I'm least convinced a low-level language
such as C is the right language for writing integration tests in.

C is fine for unit tests, and maybe we can use more unit tests
and less integration tests.

> It might look like a somewhat less important project, but given that we
> exercise almost 150,000 test cases with every CI build, I think it does
> make sense to grind our axe for a while, so to say.

Something that would benefit both users and regular contributors
is the use and adoption of more batch and eval-friendly interfaces.
e.g. fast-import/export, cat-file --batch, for-each-ref --perl...

I haven't used hg since 2005, but I know "hg server" exists
nowadays to get rid of a lot of startup overhead in Mercurial,
and maybe git could steal that idea, too...

> Therefore, it might be a really good project to modernize our test
> suite. To take ideas from modern test frameworks such as Jest and try to
> bring them to C. Which means that new contributors would probably be
> better suited to work on this project than Git old-timers!
> 
> And the really neat thing about this project is that it could be done
> incrementally.

I hope to find time to hack some more batch/eval-friendly stuff
that can make scripting git more performant; but no idea on my
availability :<
