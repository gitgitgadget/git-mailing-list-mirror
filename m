From: Jeff King <peff@peff.net>
Subject: [PATCH v2 3/3] test-lib.sh: support -x option for shell-tracing
Date: Fri, 10 Oct 2014 02:47:27 -0400
Message-ID: <20141010064727.GC17481@peff.net>
References: <20141010062722.GB17481@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 08:47:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcTzK-0003Qg-Fe
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 08:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbaJJGr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 02:47:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:57103 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905AbaJJGr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 02:47:28 -0400
Received: (qmail 29861 invoked by uid 102); 10 Oct 2014 06:47:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 01:47:28 -0500
Received: (qmail 30835 invoked by uid 107); 10 Oct 2014 06:47:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 02:47:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Oct 2014 02:47:27 -0400
Content-Disposition: inline
In-Reply-To: <20141010062722.GB17481@peff.net>
 <20141010062156.GA17481@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 10, 2014 at 02:21:56AM -0400, Jeff King wrote:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index a60ec75..81ceb23 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -237,7 +237,11 @@ do
>  		shift ;;
>  	-x)
>  		test_eval_start_='set -x'
> -		test_eval_end_='set +x'
> +		test_eval_end_='
> +			set +x
> +			test "$test_eval_ret_" = 0 ||
> +			  say_color error >&4 "last command exited with \$?=$?"

That should be \$?=$test_eval_ret_, of course. The patch below fixes it.

> I think we can probably do away with this excessive use of eval, and
> just keep a boolean flag for "is -x in effect" and check it inside
> test_eval_. Originally I was trying to keep the number of executed
> commands down, because everything until the "set +x" ran (including
> checks for an "is -x in effect" flag) was shown to the user. But since
> that is no longer the case, we can be less stingy with the conditionals.

The patch below does so. The result is much cleaner.

> Hmph. I had originally intended to make this "set -x;" with a semicolon,
> to keep it split from $*. But I forgot to, and much to my surprise, all
> of the tests still passed.

And by "all" I mean "all of the handful that I ran with -x". Of course
the bug does not show up when "-x" is not in use, which it was not when
I ran "make test". *forehead palm*

Trying to run the whole test suite with "-x" does fail. Some tests
invoke shell functions and redirect their stderr. The "set -x" will
pollute that output. There's not much we can do; it's sort of inherent
in "set -x" (and it only seems to affect about 25 of the scripts, so I
think it's still a useful tool to have). I've added a warning to the
README.

Rerolled patch is below. Sorry for all the emails. I'll stop looking at
it now to give you guys a chance to find any remaining mistakes. ;)

-- >8 --
Subject: test-lib.sh: support -x option for shell-tracing

Usually running a test under "-v" makes it clear which
command is failing. However, sometimes it can be useful to
also see a complete trace of the shell commands being run in
the test. You can do so without any support from the test
suite by running "sh -x tXXXX-foo.sh". However, this
produces quite a large bit of output, as we see a trace of
the entire test suite.

This patch instead introduces a "-x" option to the test
scripts (i.e., "./tXXXX-foo.sh -x"). When enabled, this
turns on "set -x" only for the tests themselves. This can
still be a bit verbose, but should keep things to a more
manageable level. You can even use "--verbose-only" to see
the trace only for a specific test.

The implementation is a little invasive. We turn on the "set
-x" inside the "eval" of the test code. This lets the eval
itself avoid being reported in the trace (which would be
long, and redundant with the verbose listing we already
showed). And then after the eval runs, we do some trickery
with stderr to avoid showing the "set +x" to the user.

We also show traces for test_cleanup functions (since they
can impact the test outcome, too). However, we do avoid
running the noop ":" cleanup (the default if the test does
not use test_cleanup at all), as it creates unnecessary
noise in the "set -x" output.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/README      |  6 ++++++
 t/test-lib.sh | 42 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/t/README b/t/README
index 52c77ae..9952261 100644
--- a/t/README
+++ b/t/README
@@ -82,6 +82,12 @@ appropriately before running "make".
 	numbers matching <pattern>.  The number matched against is
 	simply the running count of the test within the file.
 
+-x::
+	Turn on shell tracing (i.e., `set -x`) during the tests
+	themselves. Implies `--verbose`. Note that this can cause
+	failures in some tests which redirect and test the
+	output of shell functions. Use with caution.
+
 -d::
 --debug::
 	This may help the person who is developing a new test.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 82095e3..4dab575 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -233,6 +233,10 @@ do
 	--root=*)
 		root=$(expr "z$1" : 'z[^=]*=\(.*\)')
 		shift ;;
+	-x)
+		trace=t
+		verbose=t
+		shift ;;
 	*)
 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
 	esac
@@ -517,10 +521,39 @@ maybe_setup_valgrind () {
 	fi
 }
 
+# This is a separate function because some tests use
+# "return" to end a test_expect_success block early
+# (and we want to make sure we run any cleanup like
+# "set +x").
+test_eval_inner_ () {
+	eval "
+		test \"$trace\" = t && set -x
+		$*
+	"
+}
+
 test_eval_ () {
-	# This is a separate function because some tests use
-	# "return" to end a test_expect_success block early.
-	eval </dev/null >&3 2>&4 "$*"
+	# We run this block with stderr redirected to avoid extra cruft
+	# during a "-x" trace. Once in "set -x" mode, we cannot prevent
+	# the shell from printing the "set +x" to turn it off (nor the saving
+	# of $? before that). But we can make sure that the output goes to
+	# /dev/null.
+	#
+	# The test itself is run with stderr put back to &4 (so either to
+	# /dev/null, or to the original stderr if --verbose was used).
+	{
+		test_eval_inner_ "$@" </dev/null >&3 2>&4
+		test_eval_ret_=$?
+		if test "$trace" = t
+		then
+			set +x
+			if test "$test_eval_ret_" != 0
+			then
+				say_color error >&4 "error: last command exited with \$?=$test_eval_ret_"
+			fi
+		fi
+	} 2>/dev/null
+	return $test_eval_ret_
 }
 
 test_run_ () {
@@ -531,7 +564,8 @@ test_run_ () {
 	eval_ret=$?
 	teardown_malloc_check
 
-	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
+	if test -z "$immediate" || test $eval_ret = 0 ||
+	   test -n "$expecting_failure" && test "$test_cleanup" != ":"
 	then
 		setup_malloc_check
 		test_eval_ "$test_cleanup"
-- 
2.1.2.596.g7379948
