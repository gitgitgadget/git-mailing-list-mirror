From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5541: don't call start_httpd after sourcing
 lib-terminal.sh
Date: Fri, 14 Mar 2014 17:37:15 -0400
Message-ID: <20140314213715.GA10299@sigill.intra.peff.net>
References: <53237228.10809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:37:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOZna-0005NP-UW
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 22:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756600AbaCNVhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 17:37:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:39700 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756345AbaCNVhR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 17:37:17 -0400
Received: (qmail 22125 invoked by uid 102); 14 Mar 2014 21:37:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Mar 2014 16:37:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 17:37:15 -0400
Content-Disposition: inline
In-Reply-To: <53237228.10809@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244115>

On Fri, Mar 14, 2014 at 10:18:32PM +0100, Jens Lehmann wrote:

> Since 83d842dc8 "make test" using prove fails for some setups in t5541
> with:
> 
>    "Parse errors: No plan found in TAP output"
> 
> Running t5541 on its own fails with:
> 
>    "error: Can't use skip_all after running some tests"
> 
> This happens because "start_httpd" (which determines if the test is to
> be skipped) is called after sourcing lib-terminal.sh (which sets up the
> terminal using test_expect_success).
> 
> Fix that by calling "start_httpd" before sourcing lib-terminal.sh.

Thanks, your solution seems reasonable. lib-terminal runs a test behind
our back when we source it, which is a little funny.

Potentially we could turn its test into a lazy prereq, but I think that
does not quite work. In addition to setting the TTY prereq, it defines
the test_terminal function, and lazy prereqs happen in a subshell, IIRC.

One option would be to _always_ define test_terminal. Right now we rely
on it failing to exist to catch tests which should fail to correctly
depend on the TTY prerequisite. But we could just as easily have it
report failure in such a case.

Something like the patch below (looks like we should be using $PERL_PATH
instead of "perl", too).

> Since recently t5541 fails for me on master and pu. I'm not sure what
> detail in my setup causes this breakage (I have httpd installed and it
> is running), but this patch fixes it for me.

Yeah, this is because we now try to run the tests by default, and skip
them if webserver setup fails. If you want to know why it's failing on
your machine, try running with "-v -i" to see output, and/or looking in
httpd/error.log in the trash directory.

---
diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 9a2dca5..55b708f 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -1,35 +1,36 @@
 # Helpers for terminal output tests.
 
-test_expect_success PERL 'set up terminal for tests' '
+# Catch tests which should depend on TTY but forgot to. There's no need
+# to check that TTY is set here. If the test declared it and we are running
+# it, then it is set.
+test_terminal() {
+	if ! test_declared_prereq TTY
+	then
+		echo >&4 "test_terminal: need to declare TTY prerequisite"
+		return 127
+	fi
+	perl "$TEST_DIRECTORY"/test-terminal.perl "$@"
+}
+
+test_lazy_prereq TTY '
+	test_have_prereq PERL &&
+
 	# Reading from the pty master seems to get stuck _sometimes_
 	# on Mac OS X 10.5.0, using Perl 5.10.0 or 5.8.9.
 	#
 	# Reproduction recipe: run
 	#
 	#	i=0
 	#	while ./test-terminal.perl echo hi $i
 	#	do
 	#		: $((i = $i + 1))
 	#	done
 	#
 	# After 2000 iterations or so it hangs.
 	# https://rt.cpan.org/Ticket/Display.html?id=65692
 	#
-	if test "$(uname -s)" = Darwin
-	then
-		:
-	elif
-		perl "$TEST_DIRECTORY"/test-terminal.perl \
-			sh -c "test -t 1 && test -t 2"
-	then
-		test_set_prereq TTY &&
-		test_terminal () {
-			if ! test_declared_prereq TTY
-			then
-				echo >&4 "test_terminal: need to declare TTY prerequisite"
-				return 127
-			fi
-			perl "$TEST_DIRECTORY"/test-terminal.perl "$@"
-		}
-	fi
+	test "$(uname -s)" != Darwin &&
+
+	perl "$TEST_DIRECTORY"/test-terminal.perl \
+		sh -c "test -t 1 && test -t 2"
 '
