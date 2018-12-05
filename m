Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0328211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 05:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeLEFoL (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 00:44:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:59370 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726082AbeLEFoL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 00:44:11 -0500
Received: (qmail 339 invoked by uid 109); 5 Dec 2018 05:44:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 05:44:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28105 invoked by uid 111); 5 Dec 2018 05:43:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Dec 2018 00:43:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2018 00:44:09 -0500
Date:   Wed, 5 Dec 2018 00:44:09 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181205054408.GE12284@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181204163457.15717-4-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 04, 2018 at 05:34:57PM +0100, SZEDER Gábor wrote:

> To prevent the several parallel invocations of the same test from
> interfering with each other:
> 
>   - Include the parallel job's number in the name of the trash
>     directory and the various output files under 't/test-results/' as
>     a '.stress-<Nr>' suffix.

Makes sense.

>   - Add the parallel job's number to the port number specified by the
>     user or to the test number, so even tests involving daemons
>     listening on a TCP socket can be stressed.

In my script I just use an arbitrary sequence of ports. That means two
stress runs may stomp on each other, but stress runs tend not to
interfere with regular runs (whereas with your scheme, a stress run of
t5561 is going to stomp on t5562). It probably doesn't matter much
either way, as I tend not to do too much with the machine during a
stress run.

>   - Make '--stress' imply '--verbose-log' and discard the test's
>     standard ouput and error; dumping the output of several parallel
>     tests to the terminal would create a big ugly mess.

Makes sense. My script just redirects the output to a file, but it
predates --verbose-log.

My script always runs with "-x". I guess it's not that hard to add it if
you want, but it is annoying to finally get a failure after several
minutes only to realize that your are missing some important
information. ;)

Ditto for "-i", which leaves more readable output (you know the
interesting part is at the end of the log), and leaves a trash directory
state that is more likely to be useful for inspecting.

My script also implies "--root". That's not strictly necessary, though I
suspect it is much more likely to catch races when it's run on a ram
disk (simply because it leaves the CPU as the main bottleneck).

> 'wait' for all parallel jobs before exiting (either because a failure
> was found or because the user lost patience and aborted the stress
> test), allowing the still running tests to finish.  Otherwise the "OK
> X.Y" progress output from the last iteration would likely arrive after
> the user got back the shell prompt, interfering with typing in the
> next command.  OTOH, this waiting might induce a considerable delay
> between hitting ctrl-C and the test actually exiting; I'm not sure
> this is the right tradeoff.

If there is a delay, it's actually quite annoying to _not_ wait; you
start doing something in the terminal, and then a bunch of extra test
statuses print at a random time.

> +	job_nr=0
> +	while test $job_nr -lt "$job_count"
> +	do
> +		(
> +			GIT_TEST_STRESS_STARTED=done
> +			GIT_TEST_STRESS_JOB_NR=$job_nr
> +			export GIT_TEST_STRESS_STARTED GIT_TEST_STRESS_JOB_NR
> +
> +			cnt=0
> +			while ! test -e "$stressfail"
> +			do
> +				if $TEST_SHELL_PATH "$0" "$@" >/dev/null 2>&1
> +				then
> +					printf >&2 "OK   %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt

OK, this adds a counter for each job number (compared to my script).
Seems helpful.

> +				elif test -f "$stressfail" &&
> +				     test "$(cat "$stressfail")" = "aborted"
> +				then
> +					printf >&2 "ABORTED %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
> +				else
> +					printf >&2 "FAIL %2d.%d\n" $GIT_TEST_STRESS_JOB_NR $cnt
> +					echo $GIT_TEST_STRESS_JOB_NR >>"$stressfail"
> +				fi

Hmm. What happens if we see a failure _and_ there's an abort? That's
actually pretty plausible if you see a failure whiz by, and you want to
abort the remaining scripts because they take a long time to run.

If the abort happens first, then the goal is to assume any errors are
due to the abort. But there's a race between the individual jobs reading
$stressfail and the parent signal handler writing it. So you may end up
with "aborted\n5" or similar (after which any other jobs would fail to
match "aborted" and declare themselves failures, as well).  I think my
script probably also has this race, too (it doesn't check the abort case
explicitly, but it would race in checking "test -e fail").

If the fail happens first (which I think is the more likely case), then
the abort handler will overwrite the file with "aborted", and we'll
forget that there was a real failure. This works in my script because of
the symlinking (if a real failure symlinked $fail to a directory, then
the attempt to write "aborted" will just be a noop).

> +	job_nr=0
> +	while test $job_nr -lt "$job_count"
> +	do
> +		wait
> +		job_nr=$(($job_nr + 1))
> +	done

Do we need to loop? Calling "wait" with no arguments should wait for all
children.

> +	if test -f "$stressfail" && test "$(cat "$stressfail")" != "aborted"
> +	then
> +		echo "Log(s) of failed test run(s) be found in:"
> +		for f in $(cat "$stressfail")
> +		do
> +			echo "  $TEST_RESULTS_BASE.stress-$f.out"
> +		done
> +	fi

In my experience, outputting the failed log saves a step (especially
with "-i"), since seeing the failed test and its output is often
sufficient.

I'm also sad to lose the symlink to the failed trash directory, which
saves cutting and pasting when you have to inspect it. But I guess we
can't rely on symlinks everywhere.

-Peff
