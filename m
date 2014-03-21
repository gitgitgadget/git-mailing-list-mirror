From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 06/10] t4018: convert custom pattern test to the new infrastructure
Date: Fri, 21 Mar 2014 22:07:18 +0100
Message-ID: <55ac94cf04b486da0dc6402557455b148971be01.1395433874.git.j6t@kdbg.org>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:09:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6gi-0003fP-M6
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbaCUVJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:09:00 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:23353 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751725AbaCUVI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:08:58 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.104])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 7B9B6CEA73
	for <git@vger.kernel.org>; Fri, 21 Mar 2014 22:08:56 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4068A130052;
	Fri, 21 Mar 2014 22:08:43 +0100 (CET)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id D637D19F6A4;
	Fri, 21 Mar 2014 22:08:42 +0100 (CET)
X-Mailer: git-send-email 1.8.5.2.244.g9fb3fb1
In-Reply-To: <cover.1395433874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244746>

For the test case "matches to end of line", extend the pattern by a few
wildcards so that the pattern captures the "RIGHT" token, which is needed
for verification, without mentioning it in the pattern.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4018-diff-funcname.sh               | 40 ++++++++++++++--------------------
 t/t4018/custom1-pattern                | 17 +++++++++++++++
 t/t4018/custom2-match-to-end-of-line   |  8 +++++++
 t/t4018/custom3-alternation-in-pattern | 17 +++++++++++++++
 4 files changed, 58 insertions(+), 24 deletions(-)
 create mode 100644 t/t4018/custom1-pattern
 create mode 100644 t/t4018/custom2-match-to-end-of-line
 create mode 100644 t/t4018/custom3-alternation-in-pattern

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 008325f..5ac744f 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -30,12 +30,19 @@ public class Beer
 EOF
 sed 's/beer\\/beer,\\/' <Beer.java >Beer-correct.java
 
-test_expect_funcname () {
-	lang=${2-java}
-	test_expect_code 1 git diff --no-index -U1 \
-		"Beer.$lang" "Beer-correct.$lang" >diff &&
-	grep "^@@.*@@ $1" diff
-}
+test_expect_success 'setup' '
+	# a non-trivial custom pattern
+	git config diff.custom1.funcname "!static
+!String
+[^ 	].*s.*" &&
+
+	# a custom pattern which matches to end of line
+	git config diff.custom2.funcname "......Beer\$" &&
+
+	# alternation in pattern
+	git config diff.custom3.funcname "Beer$" &&
+	git config diff.custom3.xfuncname "^[ 	]*((public|static).*)$"
+'
 
 diffpatterns="
 	ada
@@ -53,6 +60,9 @@ diffpatterns="
 	python
 	ruby
 	tex
+	custom1
+	custom2
+	custom3
 "
 
 for p in $diffpatterns
@@ -79,30 +89,12 @@ test_expect_success 'set up .gitattributes declaring drivers to test' '
 	EOF
 '
 
-test_expect_success 'custom pattern' '
-	test_config diff.java.funcname "!static
-!String
-[^ 	].*s.*" &&
-	test_expect_funcname "int special;\$"
-'
-
 test_expect_success 'last regexp must not be negated' '
 	test_config diff.java.funcname "!static" &&
 	test_expect_code 128 git diff --no-index Beer.java Beer-correct.java 2>msg &&
 	grep ": Last expression must not be negated:" msg
 '
 
-test_expect_success 'pattern which matches to end of line' '
-	test_config diff.java.funcname "Beer\$" &&
-	test_expect_funcname "Beer\$"
-'
-
-test_expect_success 'alternation in pattern' '
-	test_config diff.java.funcname "Beer$" &&
-	test_config diff.java.xfuncname "^[ 	]*((public|static).*)$" &&
-	test_expect_funcname "public static void main("
-'
-
 test_expect_success 'setup hunk header tests' '
 	for i in $diffpatterns
 	do
diff --git a/t/t4018/custom1-pattern b/t/t4018/custom1-pattern
new file mode 100644
index 0000000..e8fd59f
--- /dev/null
+++ b/t/t4018/custom1-pattern
@@ -0,0 +1,17 @@
+public class Beer
+{
+	int special, RIGHT;
+	public static void main(String args[])
+	{
+		String s=" ";
+		for(int x = 99; x > 0; x--)
+		{
+			System.out.print(x + " bottles of beer on the wall "
+				+ x + " bottles of beer\n" // ChangeMe
+				+ "Take one down, pass it around, " + (x - 1)
+				+ " bottles of beer on the wall.\n");
+		}
+		System.out.print("Go to the store, buy some more,\n"
+			+ "99 bottles of beer on the wall.\n");
+	}
+}
diff --git a/t/t4018/custom2-match-to-end-of-line b/t/t4018/custom2-match-to-end-of-line
new file mode 100644
index 0000000..f88ac31
--- /dev/null
+++ b/t/t4018/custom2-match-to-end-of-line
@@ -0,0 +1,8 @@
+public class RIGHT_Beer
+{
+	int special;
+	public static void main(String args[])
+	{
+		System.out.print("ChangeMe");
+	}
+}
diff --git a/t/t4018/custom3-alternation-in-pattern b/t/t4018/custom3-alternation-in-pattern
new file mode 100644
index 0000000..5f3769c
--- /dev/null
+++ b/t/t4018/custom3-alternation-in-pattern
@@ -0,0 +1,17 @@
+public class Beer
+{
+	int special;
+	public static void main(String RIGHT[])
+	{
+		String s=" ";
+		for(int x = 99; x > 0; x--)
+		{
+			System.out.print(x + " bottles of beer on the wall "
+				+ x + " bottles of beer\n" // ChangeMe
+				+ "Take one down, pass it around, " + (x - 1)
+				+ " bottles of beer on the wall.\n");
+		}
+		System.out.print("Go to the store, buy some more,\n"
+			+ "99 bottles of beer on the wall.\n");
+	}
+}
-- 
1.8.5.2.244.g9fb3fb1
