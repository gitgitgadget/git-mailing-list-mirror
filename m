From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] tests: factor out terminal handling from t7006
Date: Wed, 13 Oct 2010 23:04:04 -0400
Message-ID: <20101014030403.GA5626@sigill.intra.peff.net>
References: <20101014030220.GB20685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 05:03:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6E6c-0005uw-5d
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 05:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab0JNDDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 23:03:41 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44604 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108Ab0JNDDl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 23:03:41 -0400
Received: (qmail 4641 invoked by uid 111); 14 Oct 2010 03:03:40 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 14 Oct 2010 03:03:40 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Oct 2010 23:04:04 -0400
Content-Disposition: inline
In-Reply-To: <20101014030220.GB20685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159016>

Other tests besides the pager ones may want to check how we handle
output to a terminal. This patch makes the code reusable.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-terminal.sh                |   28 ++++++++++++++++++++++++++++
 t/t7006-pager.sh                 |   31 +------------------------------
 t/{t7006 => }/test-terminal.perl |    0
 3 files changed, 29 insertions(+), 30 deletions(-)
 create mode 100644 t/lib-terminal.sh
 rename t/{t7006 => }/test-terminal.perl (100%)

diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
new file mode 100644
index 0000000..6fc33db
--- /dev/null
+++ b/t/lib-terminal.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_expect_success 'set up terminal for tests' '
+	if test -t 1
+	then
+		>stdout_is_tty
+	elif
+		test_have_prereq PERL &&
+		"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl \
+			sh -c "test -t 1"
+	then
+		>test_terminal_works
+	fi
+'
+
+if test -e stdout_is_tty
+then
+	test_terminal() { "$@"; }
+	test_set_prereq TTY
+elif test -e test_terminal_works
+then
+	test_terminal() {
+		"$PERL_PATH" "$TEST_DIRECTORY"/test-terminal.perl "$@"
+	}
+	test_set_prereq TTY
+else
+	say "# no usable terminal, so skipping some tests"
+fi
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index fb744e3..17e54d3 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -4,42 +4,13 @@ test_description='Test automatic use of a pager.'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pager.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 cleanup_fail() {
 	echo >&2 cleanup failed
 	(exit 1)
 }
 
-test_expect_success 'set up terminal for tests' '
-	rm -f stdout_is_tty ||
-	cleanup_fail &&
-
-	if test -t 1
-	then
-		>stdout_is_tty
-	elif
-		test_have_prereq PERL &&
-		"$PERL_PATH" "$TEST_DIRECTORY"/t7006/test-terminal.perl \
-			sh -c "test -t 1"
-	then
-		>test_terminal_works
-	fi
-'
-
-if test -e stdout_is_tty
-then
-	test_terminal() { "$@"; }
-	test_set_prereq TTY
-elif test -e test_terminal_works
-then
-	test_terminal() {
-		"$PERL_PATH" "$TEST_DIRECTORY"/t7006/test-terminal.perl "$@"
-	}
-	test_set_prereq TTY
-else
-	say "# no usable terminal, so skipping some tests"
-fi
-
 test_expect_success 'setup' '
 	unset GIT_PAGER GIT_PAGER_IN_USE;
 	test_might_fail git config --unset core.pager &&
diff --git a/t/t7006/test-terminal.perl b/t/test-terminal.perl
similarity index 100%
rename from t/t7006/test-terminal.perl
rename to t/test-terminal.perl
-- 
1.7.3.1.204.g337d6.dirty
