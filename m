From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] git-blame: Use the same tests for git-blame as for git-annotate
Date: Sun, 5 Mar 2006 12:13:34 +0100
Message-ID: <20060305111334.GB23448@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Mar 05 12:13:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFrBG-0005xz-KK
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 12:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWCELNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 06:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWCELNg
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 06:13:36 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:2282 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1750954AbWCELNg
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 06:13:36 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id A5CB24118; Sun,  5 Mar 2006 12:28:54 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FFrB8-0001gL-00; Sun, 05 Mar 2006 12:13:34 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17221>


Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 t/annotate-tests.sh |   86 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t8001-annotate.sh |   85 +-------------------------------------------------
 t/t8002-blame.sh    |    9 +++++
 3 files changed, 97 insertions(+), 83 deletions(-)
 create mode 100644 t/annotate-tests.sh
 create mode 100755 t/t8002-blame.sh

06b0e500a5202899dcfd037cf78ee4a982da46b4
diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
new file mode 100644
index 0000000..54a4dfb
--- /dev/null
+++ b/t/annotate-tests.sh
@@ -0,0 +1,86 @@
+# This file isn't used as a test script directly, instead it is
+# sourced from t8001-annotate.sh and t8001-blame.sh.
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
+    '[ $($PROG file | awk "{print \$3}" | grep -c "A") == 2 ]'
+
+test_expect_success \
+    'Two lines blamed on B' \
+    '[ $($PROG file | awk "{print \$3}" | grep -c "B") == 2 ]'
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
+    '[ $($PROG file | awk "{print \$3}" | grep -c "^A$") == 2 ]'
+
+test_expect_success \
+    'Two lines blamed on B' \
+    '[ $($PROG file | awk "{print \$3}" | grep -c "^B$") == 2 ]'
+
+test_expect_success \
+    'Two lines blamed on B1' \
+    '[ $($PROG file | awk "{print \$3}" | grep -c "^B1$") == 2 ]'
+
+test_expect_success \
+    'merge-setup part 2' \
+    'git checkout -b branch2 master &&
+     sed -e "s/2A quick brown/4A quick brown lazy dog/" < file > file.new &&
+     mv file.new file &&
+     GIT_AUTHOR_NAME="B2" git commit -a -m "Branch2-1"'
+
+test_expect_success \
+    'Two lines blamed on A' \
+    '[ $($PROG file | awk "{print \$3}" | grep -c "^A$") == 2 ]'
+
+test_expect_success \
+    'One line blamed on B' \
+    '[ $($PROG file | awk "{print \$3}" | grep -c "^B$") == 1 ]'
+
+test_expect_success \
+    'One line blamed on B2' \
+    '[ $($PROG file | awk "{print \$3}" | grep -c "^B2$") == 1 ]'
+
+
+test_expect_success \
+    'merge-setup part 3' \
+    'git pull . branch1'
+
+test_expect_success \
+    'Two lines blamed on A' \
+    '[ $($PROG file | awk "{print \$3}" | grep -c "^A$") == 2 ]'
+
+test_expect_success \
+    'One line blamed on B' \
+    '[ $($PROG file | awk "{print \$3}" | grep -c "^B$") == 1 ]'
+
+test_expect_success \
+    'Two lines blamed on B1' \
+    '[ $($PROG file | awk "{print \$3}" | grep -c "^B1$") == 2 ]'
+
+test_expect_success \
+    'One line blamed on B2' \
+    '[ $($PROG file | awk "{print \$3}" | grep -c "^B2$") == 1 ]'
diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index 172908a..9e5a04b 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -3,88 +3,7 @@
 test_description='git-annotate'
 . ./test-lib.sh
 
-test_expect_success \
-    'prepare reference tree' \
-    'echo "1A quick brown fox jumps over the" >file &&
-     echo "lazy dog" >>file &&
-     git add file
-     GIT_AUTHOR_NAME="A" git commit -a -m "Initial."'
-
-test_expect_success \
-    'check all lines blamed on A' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "A") == 2 ]'
-
-test_expect_success \
-    'Setup new lines blamed on B' \
-    'echo "2A quick brown fox jumps over the" >>file &&
-     echo "lazy dog" >> file &&
-     GIT_AUTHOR_NAME="B" git commit -a -m "Second."'
-
-test_expect_success \
-    'Two lines blamed on A' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "A") == 2 ]'
-
-test_expect_success \
-    'Two lines blamed on B' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "B") == 2 ]'
-
-test_expect_success \
-    'merge-setup part 1' \
-    'git checkout -b branch1 master &&
-     echo "3A slow green fox jumps into the" >> file &&
-     echo "well." >> file &&
-     GIT_AUTHOR_NAME="B1" git commit -a -m "Branch1-1"'
-
-test_expect_success \
-    'Two lines blamed on A' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "^A$") == 2 ]'
-
-test_expect_success \
-    'Two lines blamed on B' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B$") == 2 ]'
-
-test_expect_success \
-    'Two lines blamed on B1' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B1$") == 2 ]'
-
-test_expect_success \
-    'merge-setup part 2' \
-    'git checkout -b branch2 master &&
-     sed -e "s/2A quick brown/4A quick brown lazy dog/" < file > file.new &&
-     mv file.new file &&
-     GIT_AUTHOR_NAME="B2" git commit -a -m "Branch2-1"'
-
-test_expect_success \
-    'Two lines blamed on A' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "^A$") == 2 ]'
-
-test_expect_success \
-    'One line blamed on B' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B$") == 1 ]'
-
-test_expect_success \
-    'One line blamed on B2' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B2$") == 1 ]'
-
-
-test_expect_success \
-    'merge-setup part 3' \
-    'git pull . branch1'
-
-test_expect_success \
-    'Two lines blamed on A' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "^A$") == 2 ]'
-
-test_expect_success \
-    'One line blamed on B' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B$") == 1 ]'
-
-test_expect_success \
-    'Two lines blamed on B1' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B1$") == 2 ]'
-
-test_expect_success \
-    'One line blamed on B2' \
-    '[ $(git annotate file | awk "{print \$3}" | grep -c "^B2$") == 1 ]'
+PROG='git annotate'
+source ../annotate-tests.sh
 
 test_done
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
new file mode 100755
index 0000000..1036c54
--- /dev/null
+++ b/t/t8002-blame.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+test_description='git-blame'
+. ./test-lib.sh
+
+PROG='git blame -c'
+source ../annotate-tests.sh
+
+test_done
-- 
1.2.4.g4644-dirty
