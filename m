From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/2] test: allow prerequisite to be evaluated lazily
Date: Fri, 27 Jul 2012 11:45:00 -0400
Message-ID: <20120727154500.GA11957@sigill.intra.peff.net>
References: <7vboj25dk7.fsf@alter.siamese.dyndns.org>
 <7v7gtq5da3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 17:45:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sumj5-00022t-8G
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 17:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab2G0PpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 11:45:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38942 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459Ab2G0PpF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 11:45:05 -0400
Received: (qmail 20785 invoked by uid 107); 27 Jul 2012 15:45:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jul 2012 11:45:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jul 2012 11:45:00 -0400
Content-Disposition: inline
In-Reply-To: <7v7gtq5da3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202356>

On Thu, Jul 26, 2012 at 04:11:00PM -0700, Junio C Hamano wrote:

> Introduce a mechanism to probe the prerequiste lazily.  Changes are:
> 
>  - test_lazy_prereq () function, which takes the name of the
>    prerequisite it probes and the script to probe for it, is
>    added.  This only registers the name of the prerequiste that can
>    be lazily probed and the script to eval (without running).
> 
>  - test_have_prereq() function (which is used by test_expect_success
>    and also can be called directly by test scripts) learns to look
>    at the list of prerequisites that can be lazily probed, and the
>    prerequisites that have already been probed that way.

The overall strategy looks good to me. A few minor comments follow.

>  * I thought about various error conditions but didn't come up with
>    a solid conclusion.  For example, what should happen when the
>    prober directory cannot be created, or removed?  Perhaps aborting
>    the whole thing may be a safe and better option.

Yeah, it would be safer. But we have the same problems in the probes
themselves, which sometimes have setup steps (e.g., before this patch,
they typically set up the equivalent of the probe directory themselves).
Fixing it completely would involve the probes returning a tri-state
(yes, no, error), but it would make them more annoying to write.

So you are at least preserving the status quo, and as far as I know,
that has never been a problem in practice.

>    Also, I am not distinguishing a syntax error in the script and
>    "the prerequisite is not satisfied" signal (they would both be a
>    false in the "if ()" part). I do not think we care too much, but
>    others may have better ideas.

For a syntax error in a regular test, the script aborts (and you get
a "FATAL: unexpected exit..."). It probably makes sense to do the same
thing here. I find it is helpful when writing tests to have an immediate
abort instead of having to investigate why your test did not pass.

> +			*" $prerequisite "*)
> +				mkdir -p "$TRASH_DIRECTORY/prereq-test-dir"
> +				if (
> +					eval "script=\$test_prereq_lazily_$prerequisite" &&
> +					cd "$TRASH_DIRECTORY/prereq-test-dir" &&
> +					eval "$script"
> +				)

I expected to see test_run_ here so we could get the usual redirections
and "-v" support in case the probe has useful output (and it might be
nice to report to the user during "-v" that we are checking the prereq,
and what we are about to do).

Pushing the subshell and chdir inside the test would let us just die
naturally on syntax errors, like regular tests do. There's no reason not
to put the mkdir there, too, so that somebody debugging via "-v" can see
more of what's happening.

Something like this on top of your patch:

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2214388..f5831cc 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -232,6 +232,21 @@ test_lazy_prereq () {
 	eval test_prereq_lazily_$1=\$2
 }
 
+test_run_prereq_ () {
+	script='
+mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
+(cd "$TRASH_DIRECTORY/prereq-test-dir" &&
+'"$2"'
+)
+'
+	say >&3 "checking prerequisite: $1"
+	say >&3 "$script"
+	test_eval_ "$script"
+	eval_ret=$?
+	rm -rf "$TRASH_DIRECTORY/prereq-test-dir"
+	return $eval_ret
+}
+
 test_have_prereq () {
 	# prerequisites can be concatenated with ','
 	save_IFS=$IFS
@@ -251,16 +266,11 @@ test_have_prereq () {
 		*)
 			case " $lazy_testable_prereq " in
 			*" $prerequisite "*)
-				mkdir -p "$TRASH_DIRECTORY/prereq-test-dir"
-				if (
-					eval "script=\$test_prereq_lazily_$prerequisite" &&
-					cd "$TRASH_DIRECTORY/prereq-test-dir" &&
-					eval "$script"
-				)
+				eval "script=\$test_prereq_lazily_$prerequisite" &&
+				if test_run_prereq_ "$prerequisite" "$script"
 				then
 					test_set_prereq $prerequisite
 				fi
-				rm -fr "$TRASH_DIRECTORY/prereq-test-dir"
 				lazy_tested_prereq="$lazy_tested_prereq$prerequisite "
 			esac
 			;;

Try it with a broken probe like:

  $ cat >foo.sh <<EOF
  #!/bin/sh

  test_description='broken lazy eval'
  . ./test-lib.sh
  test_lazy_prereq LAZY 'broken &&'
  test_expect_success LAZY 'need lazy' 'echo lazy ok'
  test_done
  EOF

  : properly alert us to syntactic error
  $ sh foo.sh
  FATAL: Unexpected exit with code 2

  : give sane output for debugging a broken probe
  $ sh foo.sh -v
  Initialized empty Git repository in /home/peff/compile/git/t/trash directory.foo/.git/
  checking prerequisite: LAZY

  mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
  (cd "$TRASH_DIRECTORY/prereq-test-dir" &&
  broken &&
  )

  foo.sh: 5: eval: Syntax error: ")" unexpected
  FATAL: Unexpected exit with code 2

And of course with non-broken probes, "-v" would also help to see exactly
when the probe is run, using which commands, and what output they
produced. E.g., for SYMLINKS, we should probably drop the stderr
redirection from the probe so we can see how "ln" complains.

It might also be worth doing a "say >&3" at the end of the check, too,
to tell "-v" users the outcome.

-Peff
