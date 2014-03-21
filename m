From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 07/10] t4018: reduce test files for pattern compilation tests
Date: Fri, 21 Mar 2014 22:07:19 +0100
Message-ID: <92c48a41f3aee778d1a1d21ef9f9abdd54bfdaab.1395433874.git.j6t@kdbg.org>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:09:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6gj-0003fP-6f
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbaCUVJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:09:02 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:55254 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751291AbaCUVJA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:09:00 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 0B6ACCEA73
	for <git@vger.kernel.org>; Fri, 21 Mar 2014 22:08:59 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 03978CDF85;
	Fri, 21 Mar 2014 22:08:46 +0100 (CET)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7872519F6A4;
	Fri, 21 Mar 2014 22:08:46 +0100 (CET)
X-Mailer: git-send-email 1.8.5.2.244.g9fb3fb1
In-Reply-To: <cover.1395433874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244744>

All test cases that need a file with specific text patterns have been
converted to utilize texts in the t4018/ directory. The remaining tests
in the test script deal only with the validity of the regular
expressions. These tests do not depend on the contents of files that
'git diff' is invoked on. Remove the largish here-document and use only
tiny files.

While we are touching these tests, convert grep to test_i18ngrep as the
texts checked for may undergo translation in the future.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4018-diff-funcname.sh | 52 +++++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 5ac744f..34591c2 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -7,29 +7,6 @@ test_description='Test custom diff function name patterns'
 
 . ./test-lib.sh
 
-LF='
-'
-cat >Beer.java <<\EOF
-public class Beer
-{
-	int special;
-	public static void main(String args[])
-	{
-		String s=" ";
-		for(int x = 99; x > 0; x--)
-		{
-			System.out.print(x + " bottles of beer on the wall "
-				+ x + " bottles of beer\n"
-				+ "Take one down, pass it around, " + (x - 1)
-				+ " bottles of beer on the wall.\n");
-		}
-		System.out.print("Go to the store, buy some more,\n"
-			+ "99 bottles of beer on the wall.\n");
-	}
-}
-EOF
-sed 's/beer\\/beer,\\/' <Beer.java >Beer-correct.java
-
 test_expect_success 'setup' '
 	# a non-trivial custom pattern
 	git config diff.custom1.funcname "!static
@@ -41,7 +18,11 @@ test_expect_success 'setup' '
 
 	# alternation in pattern
 	git config diff.custom3.funcname "Beer$" &&
-	git config diff.custom3.xfuncname "^[ 	]*((public|static).*)$"
+	git config diff.custom3.xfuncname "^[ 	]*((public|static).*)$" &&
+
+	# for regexp compilation tests
+	echo A >A.java &&
+	echo B >B.java
 '
 
 diffpatterns="
@@ -70,29 +51,24 @@ do
 	test_expect_success "builtin $p pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
 		test_expect_code 1 git diff --no-index \
-			Beer.java Beer-correct.java 2>msg &&
-		! grep fatal msg &&
-		! grep error msg
+			A.java B.java 2>msg &&
+		! test_i18ngrep fatal msg &&
+		! test_i18ngrep error msg
 	'
 	test_expect_success "builtin $p wordRegex pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
 		test_expect_code 1 git diff --no-index --word-diff \
-			Beer.java Beer-correct.java 2>msg &&
-		! grep fatal msg &&
-		! grep error msg
+			A.java B.java 2>msg &&
+		! test_i18ngrep fatal msg &&
+		! test_i18ngrep error msg
 	'
 done
 
-test_expect_success 'set up .gitattributes declaring drivers to test' '
-	cat >.gitattributes <<-\EOF
-	*.java diff=java
-	EOF
-'
-
 test_expect_success 'last regexp must not be negated' '
+	echo "*.java diff=java" >.gitattributes &&
 	test_config diff.java.funcname "!static" &&
-	test_expect_code 128 git diff --no-index Beer.java Beer-correct.java 2>msg &&
-	grep ": Last expression must not be negated:" msg
+	test_expect_code 128 git diff --no-index A.java B.java 2>msg &&
+	test_i18ngrep ": Last expression must not be negated:" msg
 '
 
 test_expect_success 'setup hunk header tests' '
-- 
1.8.5.2.244.g9fb3fb1
