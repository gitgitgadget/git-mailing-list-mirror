Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C82211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 21:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeLEVg2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 16:36:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:60240 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727257AbeLEVg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 16:36:28 -0500
Received: (qmail 10713 invoked by uid 109); 5 Dec 2018 21:36:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 21:36:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3313 invoked by uid 111); 5 Dec 2018 21:35:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Dec 2018 16:35:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2018 16:36:26 -0500
Date:   Wed, 5 Dec 2018 16:36:26 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181205213625.GD19936@sigill.intra.peff.net>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <20181205054408.GE12284@sigill.intra.peff.net>
 <20181205103454.GJ30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205103454.GJ30222@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 11:34:54AM +0100, SZEDER Gábor wrote:

> 
> Just a quick reply to this one point for now:
> 
> On Wed, Dec 05, 2018 at 12:44:09AM -0500, Jeff King wrote:
> > On Tue, Dec 04, 2018 at 05:34:57PM +0100, SZEDER Gábor wrote:
> > > +	job_nr=0
> > > +	while test $job_nr -lt "$job_count"
> > > +	do
> > > +		wait
> > > +		job_nr=$(($job_nr + 1))
> > > +	done
> > 
> > Do we need to loop? Calling "wait" with no arguments should wait for all
> > children.
> 
> It should, but in dash, ksh, ksh93, Bash v4.2 or older it doesn't seem
> to do so, at least not on my machine, and I get back my shell prompt
> right after hitting ctrl-C or the first failed test, and then get the
> progress output from the remaining jobs later.

That's weird. I run my stress script under dash with a single "wait",
and it handles the failing case just fine. And switching to a single
"wait" in your script works for me.

But the ^C case is interesting. Try running your script under "sh -x"
and hitting ^C. The signal interrupts the first wait. In my script (or
yours modified to use a single wait), we then proceed immediately to the
"exit", and get output from the subshells after we've exited.

But in your script with the loop, the first wait is interrupted, and
then the _second_ wait (in the second loop iteration) picks up all of
the exiting processes. The subsequent waits are all noops that return
immediately, because there are no processes left.

So the right number of waits is either "1" or "2". Looping means we do
too many (which is mostly a harmless noop) or too few (in the off chance
that you have only a single job ;) ). So it works out in practice.

But I think a more clear way to do it is to simply wait in the signal
trap, to cover the case when our original wait was aborted.

I.e., something like this:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9b7f687396..5e0c41626f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -98,7 +98,7 @@ done,*)
 	mkdir -p "$(dirname "$TEST_RESULTS_BASE")"
 	stressfail="$TEST_RESULTS_BASE.stress-failed"
 	rm -f "$stressfail"
-	trap 'echo aborted >"$stressfail"' TERM INT HUP
+	trap 'echo aborted >"$stressfail"; wait' TERM INT HUP
 
 	job_nr=0
 	while test $job_nr -lt "$job_count"
@@ -128,12 +128,7 @@ done,*)
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

which behaves well for me in all cases.

> Bash 4.3 or later are strange: I get back the shell prompt immediately
> after ctrl-C as well, so it doesn't appear to be waiting for all
> remaining jobs to finish either, but! I don't get any of the progress
> output from those jobs to mess up my next command.

Interesting. My bash 4.4 seems to behave the same as dash. It almost
sounds like the SIGINT is getting passed to the subshells for you.
Probably not really worth digging into, though.

In case anybody is playing with this and needed to simulate a stress
failure, here's what I used:

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index b6566003dd..a370cd9977 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1171,4 +1171,11 @@ test_expect_success 'very long name in the index handled sanely' '
 	test $len = 4098
 '
 
+test_expect_success 'roll those dice' '
+	case "$(openssl rand -base64 1)" in
+	z*)
+		return 1
+	esac
+'
+
 test_done
