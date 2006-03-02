From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 2/3] annotate: Add a basic set of test cases.
Date: Thu, 2 Mar 2006 00:23:37 -0500
Message-ID: <11412770172128-git-send-email-ryan@michonline.com>
References: <11412770173208-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Thu Mar 02 06:24:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEgIc-0001Ff-V2
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 06:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWCBFYQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 00:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWCBFYQ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 00:24:16 -0500
Received: from mail.autoweb.net ([198.172.237.26]:41402 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751190AbWCBFYP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 00:24:15 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1FEgIP-00033N-5P; Thu, 02 Mar 2006 00:24:15 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FEgIH-0000qU-C7; Thu, 02 Mar 2006 00:24:05 -0500
Received: from localhost
	([127.0.0.1] helo=mythryan2 ident=ryan)
	by mythical with smtp (Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1FEgHp-000473-Kg; Thu, 02 Mar 2006 00:23:37 -0500
In-Reply-To: <11412770173208-git-send-email-ryan@michonline.com>
X-Mailer: git-send-email
To: Junio C Hamano <junkio@cox.net>
X-h4x0r5.com-MailScanner: Found to be clean
X-h4x0r5.com-MailScanner-From: ryan@michonline.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17051>

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

 t/t8001-annotate.sh |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100755 t/t8001-annotate.sh

7df39590a44352626c8d83a2b94d1ba11b24a118
diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
new file mode 100755
index 0000000..cae1794
--- /dev/null
+++ b/t/t8001-annotate.sh
@@ -0,0 +1,89 @@
+#!/bin/sh
+
+test_description='git-annotate'
+. ./test-lib.sh
+
+test_expect_success \
+    'prepare reference tree' \
+    'echo "1A quick brown fox jumps over the" >file &&
+     echo "lazy dog" >>file &&
+     git add file
+     GIT_AUTHOR_NAME="A" git commit -a -m "Initial."'
+
+test_expect_success \
+    'check all lines blamed on A' \
+    '[ $(git annotate file | awk "{print \$3}" | grep -c "A") == 2 ]'
+
+test_expect_success \
+    'Setup new lines blamed on B' \
+    'echo "2A quick brown fox jumps over the" >>file &&
+     echo "lazy dog" >> file &&
+     GIT_AUTHOR_NAME="B" git commit -a -m "Second."'
+
+test_expect_success \
+    'Two lines blamed on A' \
+    '[ $(git annotate file | awk "{print \$3}" | grep -c "A") == 2 ]'
+
+test_expect_success \
+    'Two lines blamed on B' \
+    '[ $(git annotate file | awk "{print \$3}" | grep -c "B") == 2 ]'
+
+test_expect_success \
+    'merge-setup part 1' \
+    'git checkout -b branch1 master &&
+     echo "3A slow green fox jumps into the" >> file &&
+     echo "well." >> file &&
+     GIT_AUTHOR_NAME="B1" git commit -a -m "Branch1-1"'
+
+test_expect_success \
+    'Two lines blamed on A' \
+    '[ $(git annotate file | awk "{print \$3}" | grep -c "^A$") == 2 ]'
+
+test_expect_success \
+    'Two lines blamed on B' \
+    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B$") == 2 ]'
+
+test_expect_success \
+    'Two lines blamed on B1' \
+    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B1$") == 2 ]'
+
+test_expect_success \
+    'merge-setup part 2' \
+    'git checkout -b branch2 master &&
+     sed -i -e "s/2A quick brown/4A quick brown lazy dog/" file &&
+     GIT_AUTHOR_NAME="B2" git commit -a -m "Branch2-1"'
+
+test_expect_success \
+    'Two lines blamed on A' \
+    '[ $(git annotate file | awk "{print \$3}" | grep -c "^A$") == 2 ]'
+
+test_expect_success \
+    'One line blamed on B' \
+    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B$") == 1 ]'
+
+test_expect_success \
+    'One line blamed on B2' \
+    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B2$") == 1 ]'
+
+
+test_expect_success \
+    'merge-setup part 3' \
+    'git pull . branch1'
+
+test_expect_success \
+    'Two lines blamed on A' \
+    '[ $(git annotate file | awk "{print \$3}" | grep -c "^A$") == 2 ]'
+
+test_expect_success \
+    'One line blamed on B' \
+    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B$") == 1 ]'
+
+test_expect_success \
+    'Two lines blamed on B1' \
+    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B1$") == 2 ]'
+
+test_expect_success \
+    'One line blamed on B2' \
+    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B2$") == 1 ]'
+
+test_done
-- 
1.2.2.g1070
