From: Jeff King <peff@peff.net>
Subject: [PATCH] tests: turn on network daemon tests by default
Date: Mon, 10 Feb 2014 16:29:37 -0500
Message-ID: <20140210212931.GA16154@sigill.intra.peff.net>
References: <20140210191521.GA3112@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 22:29:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCyQF-0003nS-4l
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 22:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbaBJV3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 16:29:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:48212 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752293AbaBJV3m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 16:29:42 -0500
Received: (qmail 19807 invoked by uid 102); 10 Feb 2014 21:29:41 -0000
Received: from mobile-032-162-138-072.mycingular.net (HELO sigill.intra.peff.net) (32.162.138.72)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Feb 2014 15:29:41 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Feb 2014 16:29:37 -0500
Content-Disposition: inline
In-Reply-To: <20140210191521.GA3112@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241932>

We do not run the httpd nor git-daemon tests by default, as
they are rather heavyweight and require network access
(albeit over localhost). However, it would be nice if more
pepole ran them, for two reasons:

  1. We would get more test coverage on more systems.

  2. The point of the test suite is to find regressions. It
     is very easy to change some of the underlying code and
     break the httpd code without realizing you are even
     affecting it. Running the httpd tests helps find these
     problems sooner (ideally before the patches even hit
     the list).

We still want to leave an "out", though, for people who
really do not want to run them. For that reason, the
GIT_TEST_HTTPD and GIT_TEST_GIT_DAEMON variables are now
tri-state booleans (true/false/auto), so you can say
GIT_TEST_HTTPD=false to turn the tests back off.

In addition, we are forgiving of common setup failures
(e.g., you do not have apache installed, or have an old
version) when the tri-state is "auto" (or empty), but report
an error when it is "true". This makes "auto" a sane
default, as we should not cause failures on setups where the
tests cannot run. But it allows people who use "true" to
catch regressions in their system (e.g., they uninstalled
apache, but were expecting their automated test runs to test
git-httpd, and would want to be notified).

Signed-off-by: Jeff King <peff@peff.net>
---

I dug in the history to see if there was any reasoning given for the
current "off by default" setting. It looks like Junio asked for it when
the original http-push tests were added, and everything else just
followed that. The reasoning there was basically "they're heavyweight
and we might not be able to run them", but hopefully having the option
variable will make that OK.

 t/lib-git-daemon.sh     |  8 +++++---
 t/lib-httpd.sh          | 22 +++++++++++-----------
 t/test-lib-functions.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index 1f22de2..e623bef 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -16,9 +16,10 @@
 #	stop_git_daemon
 #	test_done
 
-if test -z "$GIT_TEST_GIT_DAEMON"
+GIT_TEST_GIT_DAEMON=$(test_tristate "$GIT_TEST_GIT_DAEMON")
+if test "$GIT_TEST_GIT_DAEMON" = false
 then
-	skip_all="git-daemon testing disabled (define GIT_TEST_GIT_DAEMON to enable)"
+	skip_all="git-daemon testing disabled (unset GIT_TEST_GIT_DAEMON to enable)"
 	test_done
 fi
 
@@ -58,7 +59,8 @@ start_git_daemon() {
 		kill "$GIT_DAEMON_PID"
 		wait "$GIT_DAEMON_PID"
 		trap 'die' EXIT
-		error "git daemon failed to start"
+		test_skip_or_die $GIT_TEST_GIT_DAEMON \
+			"git daemon failed to start"
 	fi
 }
 
diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index b43162e..bb900ca 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -30,9 +30,10 @@
 # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
 #
 
-if test -z "$GIT_TEST_HTTPD"
+GIT_TEST_HTTPD=$(test_tristate "$GIT_TEST_HTTPD")
+if test "$GIT_TEST_HTTPD" = false
 then
-	skip_all="Network testing disabled (define GIT_TEST_HTTPD to enable)"
+	skip_all="Network testing disabled (unset GIT_TEST_HTTPD to enable)"
 	test_done
 fi
 
@@ -76,8 +77,7 @@ GIT_VALGRIND_OPTIONS=$GIT_VALGRIND_OPTIONS; export GIT_VALGRIND_OPTIONS
 
 if ! test -x "$LIB_HTTPD_PATH"
 then
-	skip_all="skipping test, no web server found at '$LIB_HTTPD_PATH'"
-	test_done
+	test_skip_or_die $GIT_TEST_HTTPD "no web server found at '$LIB_HTTPD_PATH'"
 fi
 
 HTTPD_VERSION=`$LIB_HTTPD_PATH -v | \
@@ -89,19 +89,20 @@ then
 	then
 		if ! test $HTTPD_VERSION -ge 2
 		then
-			skip_all="skipping test, at least Apache version 2 is required"
-			test_done
+			test_skip_or_die $GIT_TEST_HTTPD \
+				"at least Apache version 2 is required"
 		fi
 		if ! test -d "$DEFAULT_HTTPD_MODULE_PATH"
 		then
-			skip_all="Apache module directory not found.  Skipping tests."
-			test_done
+			test_skip_or_die $GIT_TEST_HTTPD \
+				"Apache module directory not found"
 		fi
 
 		LIB_HTTPD_MODULE_PATH="$DEFAULT_HTTPD_MODULE_PATH"
 	fi
 else
-	error "Could not identify web server at '$LIB_HTTPD_PATH'"
+	test_skip_or_die $GIT_TEST_HTTPD \
+		"Could not identify web server at '$LIB_HTTPD_PATH'"
 fi
 
 prepare_httpd() {
@@ -155,9 +156,8 @@ start_httpd() {
 		>&3 2>&4
 	if test $? -ne 0
 	then
-		skip_all="skipping test, web server setup failed"
 		trap 'die' EXIT
-		test_done
+		test_skip_or_die $GIT_TEST_HTTPD "web server setup failed"
 	fi
 }
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index aeae3ca..3cc09c0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -716,6 +716,50 @@ perl () {
 	command "$PERL_PATH" "$@"
 }
 
+# Normalize the value given in $1 to one of "true", "false", or "auto". The
+# result is written to stdout. E.g.:
+#
+#     GIT_TEST_HTTPD=$(test_tristate "$GIT_TEST_HTTPD")
+#
+test_tristate () {
+	case "$1" in
+	""|auto)
+		echo auto
+		;;
+	*)
+		# Rely on git-config to handle all the variants of
+		# true/1/on/etc that we allow.
+		if ! git -c magic.hack="$1" config --bool magic.hack 2>/dev/null
+		then
+			# If git-config failed, it was some non-bool value like
+			# YesPlease. Default this to "true" for historical
+			# compatibility.
+			echo true
+		fi
+	esac
+}
+
+# Exit the test suite, either by skipping all remaining tests or by
+# exiting with an error. If "$1" is "auto", we then we assume we were
+# opportunistically trying to set up some tests and we skip. If it is
+# "true", then we report a failure.
+#
+# The error/skip message should be given by $2.
+#
+test_skip_or_die () {
+	case "$1" in
+	auto)
+		skip_all=$2
+		test_done
+		;;
+	true)
+		error "$2"
+		;;
+	*)
+		error "BUG: test tristate is '$1' (real error: $2)"
+	esac
+}
+
 # The following mingw_* functions obey POSIX shell syntax, but are actually
 # bash scripts, and are meant to be used only with bash on Windows.
 
-- 
1.8.5.2.500.g8060133
