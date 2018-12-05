Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C923211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 21:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeLEV4Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 16:56:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:60256 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727337AbeLEV4X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 16:56:23 -0500
Received: (qmail 11606 invoked by uid 109); 5 Dec 2018 21:56:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 21:56:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3382 invoked by uid 111); 5 Dec 2018 21:55:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Dec 2018 16:55:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2018 16:56:21 -0500
Date:   Wed, 5 Dec 2018 16:56:21 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181205215621.GE19936@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <20181205054408.GE12284@sigill.intra.peff.net>
 <20181205140106.GM30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205140106.GM30222@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 03:01:06PM +0100, SZEDER Gábor wrote:

> > >   - Make '--stress' imply '--verbose-log' and discard the test's
> > >     standard ouput and error; dumping the output of several parallel
> > >     tests to the terminal would create a big ugly mess.
> > 
> > Makes sense. My script just redirects the output to a file, but it
> > predates --verbose-log.
> > 
> > My script always runs with "-x". I guess it's not that hard to add it if
> > you want, but it is annoying to finally get a failure after several
> > minutes only to realize that your are missing some important
> > information. ;)
> > 
> > Ditto for "-i", which leaves more readable output (you know the
> > interesting part is at the end of the log), and leaves a trash directory
> > state that is more likely to be useful for inspecting.
> 
> I wanted to imply only the bare minimum of options that are necessary
> to prevent the tests from stomping on each other.  Other than that I
> agree and wouldn't run '--stress' without '-x -i' myself, and at one
> point considered to recommend '-x -i' in the description of
> '--stress'.

Yeah, it probably is the right thing to make the options as orthogonal
as possible, and let the user decide what they want. I was just
wondering if I could replace my "stress" script with this. But I think
I'd still want it to remember to use a sane set of options (including
"--root" in my case).

> > > 'wait' for all parallel jobs before exiting (either because a failure
> > > was found or because the user lost patience and aborted the stress
> > > test), allowing the still running tests to finish.  Otherwise the "OK
> > > X.Y" progress output from the last iteration would likely arrive after
> > > the user got back the shell prompt, interfering with typing in the
> > > next command.  OTOH, this waiting might induce a considerable delay
> > > between hitting ctrl-C and the test actually exiting; I'm not sure
> > > this is the right tradeoff.
> > 
> > If there is a delay, it's actually quite annoying to _not_ wait; you
> > start doing something in the terminal, and then a bunch of extra test
> > statuses print at a random time.
> 
> At least the INT/TERM/etc. handler should say something like "Waiting
> for background jobs to finish", to let the user know why it doesn't
> exit right away.

That seems reasonable. There's also no point in waiting for them to
finish if we know we're aborting anyway. Could we just kill them all?

I guess it's a little tricky, because $! is going to give us the pid of
each subshell. We actually want to kill the test sub-process. That takes
a few contortions, but the output is nice (every sub-job immediately
says "ABORTED ...", and the final process does not exit until the whole
tree is done):

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9b7f687396..357dead3ff 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -98,8 +98,9 @@ done,*)
 	mkdir -p "$(dirname "$TEST_RESULTS_BASE")"
 	stressfail="$TEST_RESULTS_BASE.stress-failed"
 	rm -f "$stressfail"
-	trap 'echo aborted >"$stressfail"' TERM INT HUP
+	trap 'echo aborted >"$stressfail"; kill $job_pids 2>/dev/null; wait' TERM INT HUP
 
+	job_pids=
 	job_nr=0
 	while test $job_nr -lt "$job_count"
 	do
@@ -108,10 +109,13 @@ done,*)
 			GIT_TEST_STRESS_JOB_NR=$job_nr
 			export GIT_TEST_STRESS_STARTED GIT_TEST_STRESS_JOB_NR
 
+			trap 'kill $test_pid 2>/dev/null' TERM
+
 			cnt=0
 			while ! test -e "$stressfail"
 			do
-				if $TEST_SHELL_PATH "$0" "$@" >/dev/null 2>&1
+				$TEST_SHELL_PATH "$0" "$@" >/dev/null 2>&1 & test_pid=$!
+				if wait
 				then
 					printf >&2 "OK   %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
 				elif test -f "$stressfail" &&
@@ -124,16 +128,11 @@ done,*)
 				fi
 				cnt=$(($cnt + 1))
 			done
-		) &
+		) & job_pids="$job_pids $!"
 		job_nr=$(($job_nr + 1))
 	done
 
-	job_nr=0
-	while test $job_nr -lt "$job_count"
-	do
-		wait
-		job_nr=$(($job_nr + 1))
-	done
+	wait
 
 	if test -f "$stressfail" && test "$(cat "$stressfail")" != "aborted"
 	then

> > > +				elif test -f "$stressfail" &&
> > > +				     test "$(cat "$stressfail")" = "aborted"
> > > +				then
> > > +					printf >&2 "ABORTED %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
> > > +				else
> > > +					printf >&2 "FAIL %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
> > > +					echo $GIT_TEST_STRESS_JOB_NR >>"$stressfail"
> > > +				fi
> > 
> > Hmm. What happens if we see a failure _and_ there's an abort? That's
> > actually pretty plausible if you see a failure whiz by, and you want to
> > abort the remaining scripts because they take a long time to run.
> > 
> > If the abort happens first, then the goal is to assume any errors are
> > due to the abort.
> 
> Yeah, that's why I added this ABORTED case.  When I hit ctrl-C, a
> couple of the tests tend to fail, but that's not the rare failure we
> are hoping to find when stress testing, so printing FAIL would be
> misleading.  The test script exits with 1 all the same, so we can't
> tell the difference, but since rare failures are, well, rare, this
> failure is most likely due to the abort.

With the patch as posted I actually see most of them still say "OK",
because the SIGINT does not make it to them (it would be a different
story if I killed the whole process group).

But with the modification above, I get "ABORTED" for most, which is what
I'd want. And it should be pretty race-free, since the "aborted" file is
put into place before triggering the signal cascade.

> > If the fail happens first (which I think is the more likely case), then
> > the abort handler will overwrite the file with "aborted", and we'll
> > forget that there was a real failure. This works in my script because of
> > the symlinking (if a real failure symlinked $fail to a directory, then
> > the attempt to write "aborted" will just be a noop).
> 
> OK, I think the abort handler should append, not overwrite, and then
> the file's contents should be checked e.g. with a case statement
> looking for *aborted*.
> 
> Or use two separate files for signaling abort and test failure.

Two separate files seems a lot simpler to me.

> > In my experience, outputting the failed log saves a step (especially
> > with "-i"), since seeing the failed test and its output is often
> > sufficient.
> 
> I just don't like when test output, especially with '-x', is dumped on
> my terminal :)

Don't you then use your terminal to display the file? ;) (I'm kidding, I
assume you load it in "less" or whatever, which is distinct).

I wish this could be optional somehow, though. I really prefer the dump.
I guess if I continue to use my script as a wrapper, it can dump for me
(after digging in the $stressfail file, I guess).

> > I'm also sad to lose the symlink to the failed trash directory, which
> > saves cutting and pasting when you have to inspect it. But I guess we
> > can't rely on symlinks everywhere.
> 
> You can tab-complete most of the trash directory, and then there are
> only those 1-2-3 digits of the job number that you have to type.  That
> worked out well enough for me so far (but I've only used it for a few
> days, so...).
> 
> We could rename the trash directory of the failed test to something
> short, sweet, and common, but that could be racy in the unlikely case
> that two tests fail at the same time.  And I like the 'trash
> directory.' prefix, because then 'make clean' will delete that one,
> too, without modifying 't/Makefile' (which is also the reason for
> adding the 'stress-N' suffix instead of a prefix, and putting the fail
> file into the 'test-results' directory).

We could rename it to "trash directory.xxx.failed", which is at least
predictable. That can even be done atomically, though I think it's a
little tricky to do portably with shell tools. I guess I can continue to
do the symlink thing in my wrapper script.

-Peff
