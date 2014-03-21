From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 03/10] t4018: an infrastructure to test hunk headers
Date: Fri, 21 Mar 2014 22:07:15 +0100
Message-ID: <52505977c20a480941ae1f85f50ffb7a0bbffedb.1395433874.git.j6t@kdbg.org>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:08:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6gQ-0003Ev-PU
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbaCUVIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:08:50 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:23344 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750807AbaCUVIu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:08:50 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.108])
	by lbmfmo03.bon.at (Postfix) with ESMTP id E4BADCEA70
	for <git@vger.kernel.org>; Fri, 21 Mar 2014 22:08:48 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 70BF1130057;
	Fri, 21 Mar 2014 22:08:36 +0100 (CET)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2280E19F6A4;
	Fri, 21 Mar 2014 22:08:36 +0100 (CET)
X-Mailer: git-send-email 1.8.5.2.244.g9fb3fb1
In-Reply-To: <cover.1395433874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244741>

Add an infrastructure that simplifies adding new tests of the hunk
header regular expressions.

To add new tests, a file with the syntax to test can be dropped in the
directory t4018. The README file explains how a test file must contain;
the README itself tests the default behavior.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4018-diff-funcname.sh | 60 +++++++++++++++++++++++++++++++++++++++++++-----
 t/t4018/README           | 18 +++++++++++++++
 2 files changed, 72 insertions(+), 6 deletions(-)
 create mode 100644 t/t4018/README

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 38a092a..b467d9e 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -100,7 +100,25 @@ test_expect_funcname () {
 	grep "^@@.*@@ $1" diff
 }
 
-for p in ada bibtex cpp csharp fortran html java matlab objc pascal perl php python ruby tex
+diffpatterns="
+	ada
+	bibtex
+	cpp
+	csharp
+	fortran
+	html
+	java
+	matlab
+	objc
+	pascal
+	perl
+	php
+	python
+	ruby
+	tex
+"
+
+for p in $diffpatterns
 do
 	test_expect_success "builtin $p pattern compiles" '
 		echo "*.java diff=$p" >.gitattributes &&
@@ -118,11 +136,6 @@ do
 	'
 done
 
-test_expect_success 'default behaviour' '
-	rm -f .gitattributes &&
-	test_expect_funcname "public class Beer\$"
-'
-
 test_expect_success 'set up .gitattributes declaring drivers to test' '
 	cat >.gitattributes <<-\EOF
 	*.java diff=java
@@ -182,4 +195,39 @@ test_expect_success 'alternation in pattern' '
 	test_expect_funcname "public static void main("
 '
 
+test_expect_success 'setup hunk header tests' '
+	for i in $diffpatterns
+	do
+		echo "$i-* diff=$i"
+	done > .gitattributes &&
+
+	# add all test files to the index
+	(
+		cd "$TEST_DIRECTORY"/t4018 &&
+		git --git-dir="$TRASH_DIRECTORY/.git" add .
+	) &&
+
+	# place modified files in the worktree
+	for i in $(git ls-files)
+	do
+		sed -e "s/ChangeMe/IWasChanged/" <"$TEST_DIRECTORY/t4018/$i" >"$i" || return 1
+	done
+'
+
+# check each individual file
+for i in $(git ls-files)
+do
+	if grep broken "$i" >/dev/null 2>&1
+	then
+		result=failure
+	else
+		result=success
+	fi
+	test_expect_$result "hunk header: $i" "
+		test_when_finished 'cat actual' &&	# for debugging only
+		git diff -U1 $i >actual &&
+		grep '@@ .* @@.*RIGHT' actual
+	"
+done
+
 test_done
diff --git a/t/t4018/README b/t/t4018/README
new file mode 100644
index 0000000..283e01cc
--- /dev/null
+++ b/t/t4018/README
@@ -0,0 +1,18 @@
+How to write RIGHT test cases
+=============================
+
+Insert the word "ChangeMe" (exactly this form) at a distance of
+at least two lines from the line that must appear in the hunk header.
+
+The text that must appear in the hunk header must contain the word
+"right", but in all upper-case, like in the title above.
+
+To mark a test case that highlights a malfunction, insert the word
+BROKEN in all lower-case somewhere in the file.
+
+This text is a bit twisted and out of order, but it is itself a
+test case for the default hunk header pattern. Know what you are doing
+if you change it.
+
+BTW, this tests that the head line goes to the hunk header, not the line
+of equal signs.
-- 
1.8.5.2.244.g9fb3fb1
