From: Jeff King <peff@peff.net>
Subject: [PATCH] t/lib-terminal: make TTY a lazy prerequisite
Date: Fri, 14 Mar 2014 17:57:23 -0400
Message-ID: <20140314215723.GB10299@sigill.intra.peff.net>
References: <53237228.10809@web.de>
 <20140314213715.GA10299@sigill.intra.peff.net>
 <xmqqtxb0fo65.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 22:57:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOa6d-0005pT-Uc
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 22:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756036AbaCNV50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 17:57:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:39714 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756017AbaCNV5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 17:57:25 -0400
Received: (qmail 23150 invoked by uid 102); 14 Mar 2014 21:57:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Mar 2014 16:57:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 17:57:23 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtxb0fo65.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244118>

On Fri, Mar 14, 2014 at 02:47:14PM -0700, Junio C Hamano wrote:

> > Something like the patch below (looks like we should be using $PERL_PATH
> > instead of "perl", too).

Actually, we don't need to do this, as of 94221d2 (t: use perl instead
of "$PERL_PATH" where applicable, 2013-10-28). If only the author of
that commit were here to correct me...

> ;-)  Also a SP between test_terminal and (), perhaps.

Fixed below. Here it is with a commit message.

-- >8 --
Subject: t/lib-terminal: make TTY a lazy prerequisite

When lib-terminal.sh is sourced by a test script, we
immediately set up the TTY prerequisite. We do so inside a
test_expect_success, because that nicely isolates any
generated output.

However, this early test can interfere with a script that
later wants to skip all tests (e.g., t5541 then goes on to
set up the httpd server, and wants to skip_all if that
fails). TAP output doesn't let us skip everything after we
have already run at least one test.

We could fix this by reordering the inclusion of
lib-terminal.sh in t5541 to go after the httpd setup.  That
solves this case, but we might eventually hit a case with
circular dependencies, where either lib-*.sh include might
want to skip_all after the other has run a test.  So
instead, let's just remove the ordering constraint entirely
by doing the setup inside a test_lazy_prereq construct,
rather than in a regular test.  We never cared about the
test outcome anyway (it was written to always succeed).

Note that in addition to setting up the prerequisite, the
current test also defines test_terminal. Since we can't
affect the environment from a lazy_prereq, we have to hoist
that out. We previously depended on it _not_ being defined
when the TTY prereq isn't set as a way to ensure that tests
properly declare their dependency on TTY. However, we still
cover the case (see the in-code comment for details).

Reported-by: Jens Lehmann <Jens.Lehmann@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-terminal.sh | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
index 9a2dca5..5184549 100644
--- a/t/lib-terminal.sh
+++ b/t/lib-terminal.sh
@@ -1,6 +1,20 @@
 # Helpers for terminal output tests.
 
-test_expect_success PERL 'set up terminal for tests' '
+# Catch tests which should depend on TTY but forgot to. There's no need
+# to aditionally check that the TTY prereq is set here.  If the test declared
+# it and we are running the test, then it must have been set.
+test_terminal () {
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
@@ -15,21 +29,8 @@ test_expect_success PERL 'set up terminal for tests' '
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
-- 
1.9.0.417.gc6bea4f
