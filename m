From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/3] Demonstrate a bug in --word-diff where diff.*.wordregex is "sticky"
Date: Wed, 14 Mar 2012 19:24:07 +0100
Message-ID: <3bb99e938624ae674674b304c24c48b9dc05871b.1331749299.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 14 19:24:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7ssQ-0001Uz-F2
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 19:24:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761298Ab2CNSYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 14:24:14 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:33801 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756688Ab2CNSYN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 14:24:13 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Mar
 2012 19:24:10 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 14 Mar
 2012 19:24:09 +0100
X-Mailer: git-send-email 1.7.10.rc0.286.gd2cb29
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193144>

From: Johannes Sixt <j6t@kdbg.org>

The test case applies a custom wordRegex to one file in a diff, and expects
that the default word splitting applies to the second file in the diff.
But the custom wordRegex is also incorrectly used for the second file.

[tr: unset the diff.wordRegex variable to make the test meaningful]

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Compared to your version, I added the first hunk.  Otherwise the
diff.wordRegex=[[:alnum:]]+ setting carries over and makes the test
fail even with the bug fixed.

I deliberately put it as early as possible, rather than into the setup
for your test, to avoid confusion next time someone patches that file.

 t/t4034-diff-words.sh |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 5c20121..69e81f3 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -293,6 +293,10 @@ test_expect_success '--word-diff=none' '
 	word_diff --word-diff=plain --word-diff=none
 '
 
+test_expect_success 'unset default driver' '
+	git config --unset diff.wordregex
+'
+
 test_language_driver bibtex
 test_language_driver cpp
 test_language_driver csharp
@@ -348,4 +352,37 @@ test_expect_success 'word-diff with no newline at EOF' '
 	word_diff --word-diff=plain
 '
 
+test_expect_success 'setup history with two files' '
+	echo "a b; c" >a &&
+	echo "a b; c" >z &&
+	git add a z &&
+	git commit -minitial &&
+
+	# modify both
+	echo "a bx; c" >a &&
+	echo "a bx; c" >z &&
+	git commit -mmodified -a
+'
+
+test_expect_failure 'wordRegex for the first file does not apply to the second' '
+	echo "a diff=tex" >.gitattributes &&
+	git config diff.tex.wordRegex "[a-z]+|." &&
+	cat >expect <<-\EOF &&
+		diff --git a/a b/a
+		index 9823d38..b09f967 100644
+		--- a/a
+		+++ b/a
+		@@ -1 +1 @@
+		a [-b-]{+bx+}; c
+		diff --git a/z b/z
+		index 9823d38..b09f967 100644
+		--- a/z
+		+++ b/z
+		@@ -1 +1 @@
+		a [-b;-]{+bx;+} c
+	EOF
+	git diff --word-diff HEAD~ >actual
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.10.rc0.286.gd2cb29
