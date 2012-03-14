From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 1/3] Demonstrate a bug in --word-diff where diff.*.wordregex
 is "sticky"
Date: Wed, 14 Mar 2012 20:50:21 +0100
Message-ID: <4F60F67D.9050003@kdbg.org>
References: <3bb99e938624ae674674b304c24c48b9dc05871b.1331749299.git.trast@student.ethz.ch> <7vsjhboujp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 20:50:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7uDf-0007MR-RG
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 20:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030753Ab2CNTun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 15:50:43 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:55480 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030685Ab2CNTum (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 15:50:42 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.105])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 01966CE29A
	for <git@vger.kernel.org>; Wed, 14 Mar 2012 20:50:58 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E571C2C4008;
	Wed, 14 Mar 2012 20:50:39 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1F73719F458;
	Wed, 14 Mar 2012 20:50:21 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.27) Gecko/20120215 SUSE/3.1.19 Thunderbird/3.1.19
In-Reply-To: <7vsjhboujp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193157>

The test case applies a custom wordRegex to one file in a diff, and expects
that the default word splitting applies to the second file in the diff.
But the custom wordRegex is also incorrectly used for the second file.

Helped-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Changes in this round, where I do not resend 2/3 and 3/3:

- Use test_unconfig.
- Use compare_diff_patch to check the result.
- Fix a broken && chain at the end of the last test.
- Name the files a.tex and z.tex as per your suggestion.

 t/t4034-diff-words.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 5c20121..9e9643e 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -3,6 +3,7 @@
 test_description='word diff colors'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
 
 cat >pre.simple <<-\EOF
 	h(4)
@@ -293,6 +294,10 @@ test_expect_success '--word-diff=none' '
 	word_diff --word-diff=plain --word-diff=none
 '
 
+test_expect_success 'unset default driver' '
+	test_unconfig diff.wordregex
+'
+
 test_language_driver bibtex
 test_language_driver cpp
 test_language_driver csharp
@@ -348,4 +353,35 @@ test_expect_success 'word-diff with no newline at EOF' '
 	word_diff --word-diff=plain
 '
 
+test_expect_success 'setup history with two files' '
+	echo "a b; c" >a.tex &&
+	echo "a b; c" >z.tex &&
+	git add a.tex z.tex &&
+	git commit -minitial &&
+
+	# modify both
+	echo "a bx; c" >a.tex &&
+	echo "a bx; c" >z.tex &&
+	git commit -mmodified -a
+'
+
+test_expect_failure 'wordRegex for the first file does not apply to the second' '
+	echo "a.tex diff=tex" >.gitattributes &&
+	git config diff.tex.wordRegex "[a-z]+|." &&
+	cat >expect <<-\EOF &&
+		diff --git a/a.tex b/a.tex
+		--- a/a.tex
+		+++ b/a.tex
+		@@ -1 +1 @@
+		a [-b-]{+bx+}; c
+		diff --git a/z.tex b/z.tex
+		--- a/z.tex
+		+++ b/z.tex
+		@@ -1 +1 @@
+		a [-b;-]{+bx;+} c
+	EOF
+	git diff --word-diff HEAD~ >actual &&
+	compare_diff_patch expect actual
+'
+
 test_done
-- 
1.7.8.216.g2e426
