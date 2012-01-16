From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] test_interactive: interactive debugging in test scripts
Date: Mon, 16 Jan 2012 10:49:53 -0500
Message-ID: <20120116154953.GA21238@padd.com>
References: <4F133069.10308@web.de>
 <20120115232413.GA14724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 16 16:50:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmoov-0005JV-0Y
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 16:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab2APPt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 10:49:59 -0500
Received: from honk.padd.com ([74.3.171.149]:52429 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab2APPt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 10:49:59 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id C115FE8C;
	Mon, 16 Jan 2012 07:49:57 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id CEDCA31446; Mon, 16 Jan 2012 10:49:53 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20120115232413.GA14724@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188630>

For test debugging, pause test execution and spawn a shell to
allow examination of internal test state.  The shell has access
to all exported variables from the test.  Exit the shell to
continue the test.  Calls to this function should never be
included in committed code.  The "--verbose" option is required.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
peff@peff.net wrote on Sun, 15 Jan 2012 18:24 -0500:
> On Sun, Jan 15, 2012 at 09:00:41PM +0100, Jens Lehmann wrote:
> > As that invocation is not that easy to remember add the test_bash
> > convenience function. This function also checks if the -v flag is given
> > and will complain if that is not the case instead of letting the test
> > hang until ^D is pressed.
> 
> Nice. Many times I have added such a "bash" or "gdb" invocation then
> forgotten "-v", only to scratch my head at why the test seemed to be
> hanging.

Yes, good catch noticing the need for "-v".

Here's something similar that I've been playing around with
locally.  I export HOME and TERM in the debug shell to make
sure all the features around dotfiles and color/editing work
nicely.  Also just use SHELL directly, not SHELL_PATH or bash,
to cater to other shell users.

And it is necessary to export any test variables you want to use
in the debug shell.  I often cut-n-paste lines containing
TEST_DIRECTORY and TRASH_DIRECTORY; there could be others,
in test scripts and helper libraries too.

> 2. I do this not just with bash, but with "gdb". I wonder if it is worth
>    making this "test_foo bash", for some value of "foo" (the ones that
>    occur to me are "debug" and "run", but of course they are taken).
> 
>    Actually, I wonder if the existing test_debug could handle this
>    already (though you do have to remember to add "--debug" to your
>    command line, then).

While it would be nice to use:

    test_interactive gdb --args git ...

the path is setup to invoke the script in bin-wrappers/git,
requiring either --with-dashes or something like

    test_interactive gdb --args "$GIT_EXEC_PATH"/git ...

both of which I'm sure to forget.  I have a "test_gdb_git" that
can be used in place of "git" in a script for exactly this
purpose, but feel it's not general enough to warrant inclusion.
It's easy to start a shell then invoke gdb by hand.

Between mine and Jens' there is hopefully something widely useful
here.

		-- Pete

 t/README      |    9 +++++++++
 t/test-lib.sh |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index c85abaf..da4521f 100644
--- a/t/README
+++ b/t/README
@@ -548,6 +548,15 @@ library for your script to use.
 		...
 	'
 
+ - test_interactive
+
+   For test debugging, pause test execution and spawn a shell
+   to allow examination of internal test state.  The shell has
+   access to all exported variables from the test.  Exit the shell
+   to continue the test.  Calls to this function should never be
+   included in committed code.  This function requires the "-v"
+   ("--verbose") option.
+
 Prerequisites
 -------------
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a65dfc7..a834602 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -32,7 +32,9 @@ done,*)
 esac
 
 # Keep the original TERM for say_color
+# and the original HOME for interactive debugging
 ORIGINAL_TERM=$TERM
+ORIGINAL_HOME="$HOME"
 
 # For repeatability, reset the environment to known value.
 LANG=C
@@ -473,6 +475,36 @@ test_debug () {
 	test "$debug" = "" || eval "$1"
 }
 
+#
+# Add to a test script to spawn a shell during execution.  This
+# spawns a shell allowing inspection of internal test state.  Exit
+# the shell to continue with the test.  Example:
+#
+# 	test_expect_success 'test' '
+# 		git do-something &&
+# 		test_interactive &&
+# 		test_cmp expected current
+#	'
+#
+# Be sure to remove the debug lines before submitting:  it only
+# works with "-v".
+#
+test_interactive () {
+	if test -z "$verbose" ; then
+		error >&5 "test_interactive requires --verbose"
+	fi
+	say >&3 "Interactive debugging"
+	say >&3 "Exit shell to continue test"
+	(
+		# restore important original environment variables
+		exec 0<&6 3>&5 2>&4
+		export HOME="$ORIGINAL_HOME"
+		export TERM="$ORIGINAL_TERM"
+		exec $SHELL
+	)
+	return 0
+}
+
 test_eval_ () {
 	# This is a separate function because some tests use
 	# "return" to end a test_expect_success block early.
@@ -901,6 +933,7 @@ then
 	# itself.
 	TEST_DIRECTORY=$(pwd)
 fi
+export TEST_DIRECTORY
 GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 
 if test -n "$valgrind"
@@ -1038,6 +1071,7 @@ case "$test" in
 /*) TRASH_DIRECTORY="$test" ;;
  *) TRASH_DIRECTORY="$TEST_DIRECTORY/$test" ;;
 esac
+export TRASH_DIRECTORY
 test ! -z "$debug" || remove_trash=$TRASH_DIRECTORY
 rm -fr "$test" || {
 	GIT_EXIT_OK=t
-- 
1.7.9.rc0.47.gc9457
