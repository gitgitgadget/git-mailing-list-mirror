Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C86120986
	for <e@80x24.org>; Fri, 21 Oct 2016 10:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754531AbcJUKsD (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 06:48:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:60565 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753620AbcJUKsC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 06:48:02 -0400
Received: (qmail 17786 invoked by uid 109); 21 Oct 2016 10:48:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 10:48:01 +0000
Received: (qmail 1913 invoked by uid 111); 21 Oct 2016 10:48:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 06:48:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2016 06:48:00 -0400
Date:   Fri, 21 Oct 2016 06:48:00 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: [PATCH 2/3] test-lib: add --verbose-log option
Message-ID: <20161021104759.hx6q7u66r3ll7l44@sigill.intra.peff.net>
References: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "--verbose" option redirects output from arbitrary
test commands to stdout. This is useful for examining the
output manually, like:

  ./t5547-push-quarantine.sh -v | less

But it also means that the output is intermingled with the
TAP directives, which can confuse a TAP parser like "prove".
This has always been a potential problem, but became an
issue recently when one test happened to output the word
"ok" on a line by itself, which prove interprets as a test
success:

  $ prove t5547-push-quarantine.sh :: -v
  t5547-push-quarantine.sh .. 1/? To dest.git
   * [new branch]      HEAD -> master
  To dest.git
   ! [remote rejected] reject -> reject (pre-receive hook declined)
  error: failed to push some refs to 'dest.git'
  fatal: git cat-file d08c8eba97f4e683ece08654c7c8d2ba0c03b129: bad file
  t5547-push-quarantine.sh .. Failed -1/4 subtests

  Test Summary Report
  -------------------
  t5547-push-quarantine.sh (Wstat: 0 Tests: 5 Failed: 0)
    Parse errors: Tests out of sequence.  Found (2) but expected (3)
                  Tests out of sequence.  Found (3) but expected (4)
                  Tests out of sequence.  Found (4) but expected (5)
                  Bad plan.  You planned 4 tests but ran 5.
  Files=1, Tests=5,  0 wallclock secs ( 0.01 usr +  0.01 sys =  0.02 CPU)
  Result: FAIL

One answer is "if it hurts, don't do it", but that's not
quite the whole story. The Travis tests use "--verbose
--tee" so that they can get the benefit of prove's parallel
options, along with a verbose log in case there is a
failure. We just need the verbose output to go to the log,
but keep stdout clean.

Getting this right turns out to be surprisingly difficult.
Here's the progression of alternatives I considered:

 1. Add an option to write verbose output to stderr. This is
    hard to capture, though, because we want each test to
    have its own log (because they're all run in parallel
    and the jumbled output would be useless).

 2. Add an option to write verbose output to a file in
    test-results. This works, but the log is missing all of
    the non-verbose output, which gives context.

 3. Like (2), but teach say_color() to additionally output
    to the log. This mostly works, but misses any output
    that happens outside of the say() functions (which isn't
    a lot, but is a potential maintenance headache).

 4. Like (2), but make the log file the same as the "--tee"
    file. That almost works, but now we have two processes
    opening the same file. That gives us two separate
    descriptors, each with their own idea of the current
    position. They'll each start writing at offset 0, and
    overwrite each other's data.

 5. Like (4), but in each case open the file for appending.
    That atomically positions each write at the end of the
    file.

    It's possible we may still get sheared writes between
    the two processes, but this is already the case when
    writing to stdout. It's not a problem in practice
    because the test harness generally waits for snippets to
    finish before writing the TAP output.

    We can ignore buffering issues with tee, because POSIX
    mandates that it does not buffer. Likewise, POSIX
    specifies "tee -a", so it should be available
    everywhere.

This patch implements option (5), which seems to work well
in practice.

Signed-off-by: Jeff King <peff@peff.net>
---
Arguably we don't need a new option for this, and could just do it
automatically. I wasn't sure when, though:

  - if "--tee --verbose" triggers it, then somebody running that outside
    of "prove" who _wants_ the verbose output on stdout (because they're
    looking at it, but also want to save a copy to the log) would be
    regressed

  - possibly "--tee" could just always write verbose output to the
    logfile (but not stdout). That's kind of weirdly magical, and we'd
    have to update the travis invocation anyway.

So I went with a new option which implies the other ones. No chance of
regression, and it's easy to explain.

 t/README      |  6 ++++++
 t/test-lib.sh | 22 +++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index 0f764c0aef..4982d1c521 100644
--- a/t/README
+++ b/t/README
@@ -153,6 +153,12 @@ appropriately before running "make".
 	As the names depend on the tests' file names, it is safe to
 	run the tests with this option in parallel.
 
+--verbose-log::
+	Write verbose output to the same logfile as `--tee`, but do
+	_not_ write it to stdout. Unlike `--tee --verbose`, this option
+	is safe to use when stdout is being consumed by a TAP parser
+	like `prove`. Implies `--tee` and `--verbose`.
+
 --with-dashes::
 	By default tests are run without dashed forms of
 	commands (like git-commit) in the PATH (it only uses
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 33cbbb7806..85946ec40d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -54,11 +54,21 @@ case "$GIT_TEST_TEE_STARTED, $* " in
 done,*)
 	# do not redirect again
 	;;
-*' --tee '*|*' --va'*)
+*' --tee '*|*' --va'*|*' --verbose-log '*)
 	mkdir -p "$TEST_OUTPUT_DIRECTORY/test-results"
 	BASE="$TEST_OUTPUT_DIRECTORY/test-results/$(basename "$0" .sh)"
+
+	# Make this filename available to the sub-process in case it is using
+	# --verbose-log.
+	GIT_TEST_TEE_OUTPUT_FILE=$BASE.out
+	export GIT_TEST_TEE_OUTPUT_FILE
+
+	# Truncate before calling "tee -a" to get rid of the results
+	# from any previous runs.
+	>"$GIT_TEST_TEE_OUTPUT_FILE"
+
 	(GIT_TEST_TEE_STARTED=done ${SHELL_PATH} "$0" "$@" 2>&1;
-	 echo $? >"$BASE.exit") | tee "$BASE.out"
+	 echo $? >"$BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
 	test "$(cat "$BASE.exit")" = 0
 	exit
 	;;
@@ -246,6 +256,9 @@ do
 		trace=t
 		verbose=t
 		shift ;;
+	--verbose-log)
+		verbose_log=t
+		shift ;;
 	*)
 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
 	esac
@@ -319,7 +332,10 @@ fi
 
 exec 5>&1
 exec 6<&0
-if test "$verbose" = "t"
+if test "$verbose_log" = "t"
+then
+	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
+elif test "$verbose" = "t"
 then
 	exec 4>&2 3>&1
 else
-- 
2.10.1.776.ge0e381e

