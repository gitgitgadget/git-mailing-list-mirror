From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/16] t5304: use helper to report failure of "test foo =
 bar"
Date: Tue, 7 Oct 2014 21:13:04 -0400
Message-ID: <20141008011304.GA26864@peff.net>
References: <xmqq61fveg1j.fsf@gitster.dls.corp.google.com>
 <20141007212941.GA24508@peff.net>
 <xmqqiojvczrd.fsf@gitster.dls.corp.google.com>
 <54346663.7090006@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 08 10:20:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbmTY-0000SJ-5G
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 10:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbaJHITy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 04:19:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:56110 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754520AbaJHITs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 04:19:48 -0400
Received: (qmail 5127 invoked by uid 102); 8 Oct 2014 08:19:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 03:19:49 -0500
Received: (qmail 10910 invoked by uid 107); 8 Oct 2014 01:13:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Oct 2014 21:13:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Oct 2014 21:13:04 -0400
Content-Disposition: inline
In-Reply-To: <54346663.7090006@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 08, 2014 at 12:17:07AM +0200, Michael Haggerty wrote:

> On 10/07/2014 11:53 PM, Junio C Hamano wrote:
> > Hmph, your 'test' in that name is a generic verb "we check that...",
> > which I think aligns better with the other test_foo functions.  When
> > I suggested 'test_verbose', 'test' in that name was specifically
> > meant to refer to the 'test' command.

I actually meant "test" as a namespace to indicate it is part of the
test suite (just like "test_seq" is not testing anything). I think that
is why the names are so silly. We are using the "test" command in our
"test" suite to "test" some conditions.

> I like "verbose_test $foo = $bar" because it puts the word "test" next
> to the condition, where the built-in command "test" would otherwise be.
> 
> We could even define a command
> 
> 	verbose () {
> 		"$@" && return 0
> 		echo >&2 "command failed: $*"
> 		return 1
> 	}
> 
> and use it like
> 
> 	verbose test $foo = $bar

I kind of like this. It is easy to see which shell command is being
invoked, and it would extend naturally to other silent commands.

> Somehow I feel like I'm reinventing something that must already exist...

Yes, we're basically reinventing "set -x" here, with the caveat that we
only _really_ care about showing failed commands. The problem with "set
-x" is that it also wants to apply itself to the test harness itself, so
you end up with a lot of cruft.

Below is my best attempt at keeping the cruft to a minimum. Here's
sample output using "-v" (the commands are all supplied by dummy
aliases):

    expecting success: 
            do_some_thing &&
            test "$(inspect_some_thing)" = "expected" &&
            do_some_other_thing
    
    + do_some_thing
    + echo doing some thing...
    doing some thing...
    + inspect_some_thing
    + echo foo
    + test foo = expected
    + eval_ret=1
    + set +x
    not ok 1 - experiment with set -x

It's not _too_ bad, because we turn on "set -x" for just the test eval
(mostly). But the rough edges are:

  1. We are stuck with the "eval_ret = 1; set +x" cleanup at the end. I
     don't think there's any way around that without a subshell, and
     many tests will not work in a subshell (they set environment
     variables they expect to persist).

  2. There's nothing highlighting the failed code. You just have to know
     that it was the last thing before the eval_ret call. We can set PS4
     to show $?, or even do something complicated like:

       PS4='+ $(test $? = 0 || say_color error "^^^ failure; ")'

     though note that running commands via PS4 works in bash, but
     causes dash to go into an infinite loop. :)

     But even with that, the output is still not great.

  3. The "-x" continues into any shell functions, which are hard to
     read. For example, notice above that we walked into the
     "do_some_thing" function and showed its implementation. Now imagine
     doing that for complicated test_* helpers.

So it's not great. The upside is that it Just Works everywhere without
even having to modify the tests themselves. I admit I have sometimes
used "sh -x" to debug a test script, but it is usually a giant pain due
to the verbosity of the harness code. The patch below cuts out _most_ of
that because at least we just use it during the eval, but I'm still not
sure it's a good default for "-v" (we could add it as "-vv" or
something, though, if others find it useful).

---
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 82095e3..af51868 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -517,10 +517,30 @@ maybe_setup_valgrind () {
 	fi
 }
 
+# This is a separate function because some tests use
+# "return" to end a test_expect_success block early
+# (and we want to make sure we do our "set +x" cleanup).
+test_eval_inner_2 () {
+	# We do the "set -x" inside the eval because we
+	# want to keep it as close to the actual test
+	# commands as possible to avoid harness cruft.
+	eval "set -x; $*"
+}
+
+# All of the "set +x" cleanup has to happen inside
+# here, because the output is redirected (otherwise
+# we leak "set -x" lines to stderr in non-verbose mode.
+test_eval_inner_1 () {
+	test_eval_inner_2 "$@"
+	eval_ret=$?
+	set +x
+	return $eval_ret
+}
+
+# This wrapper exists just to keep the I/O redirect
+# factored out into a single place.
 test_eval_ () {
-	# This is a separate function because some tests use
-	# "return" to end a test_expect_success block early.
-	eval </dev/null >&3 2>&4 "$*"
+	test_eval_inner_1 "$@" </dev/null >&3 2>&4
 }
 
 test_run_ () {
@@ -531,7 +551,10 @@ test_run_ () {
 	eval_ret=$?
 	teardown_malloc_check
 
-	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
+	# We avoid running a straight ":" because it is a noop, and it
+	# pollutes our "set -x" output.
+	if test -z "$immediate" || test $eval_ret = 0 ||
+	   test -n "$expecting_failure" && test "$test_cleanup" != ":"
 	then
 		setup_malloc_check
 		test_eval_ "$test_cleanup"
