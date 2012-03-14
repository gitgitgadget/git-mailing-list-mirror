From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Demonstrate a bug in --word-diff where diff.*.wordregex is
 "sticky"
Date: Wed, 14 Mar 2012 17:39:38 +0100
Message-ID: <4F60C9CA.1040109@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Mar 14 17:40:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7rF6-0004j9-Cc
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 17:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234Ab2CNQjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 12:39:45 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:2059 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965222Ab2CNQjn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 12:39:43 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S7rEh-00008j-UQ; Wed, 14 Mar 2012 17:39:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 532461660F;
	Wed, 14 Mar 2012 17:39:39 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
X-Enigmail-Version: 1.3.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193128>

From: Johannes Sixt <j6t@kdbg.org>

The test case applies a custom wordRegex to one file in a diff, and expects
that the default word splitting applies to the second file in the diff.
But the custom wordRegex is also incorrectly used for the second file.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 What's going on here?

 t/t4034-diff-words.sh |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 5c20121..1ad7ab5 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -348,4 +348,37 @@ test_expect_success 'word-diff with no newline at EOF' '
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
1.7.9.rc2.96.g8a78a
