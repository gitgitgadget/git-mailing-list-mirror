From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make sure diff-helper can tell rename/copy in the new
 diff-raw format.
Date: Mon, 23 May 2005 00:26:06 -0700
Message-ID: <7vfywe769d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 09:26:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da7Jr-0002di-Fc
	for gcvg-git@gmane.org; Mon, 23 May 2005 09:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVEWH1A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 03:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVEWH1A
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 03:27:00 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:20477 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261855AbVEWH0I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 03:26:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523072606.EQAT7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 03:26:06 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds tests to make sure that diff-helper can tell renames
from copies using the same "everything but the last one are
copies and the last one is either rename or stay" logic.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

t/t4003-diff-rename-1.sh |    6 +--
t/t4005-diff-rename-2.sh |   93 +++++++++++++++++++++++++++++++++++++++++++++--
2 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -58,7 +58,7 @@ rename new COPYING.#
 EOF
 
 test_expect_success \
-    'validate output from rename/copy detection' \
+    'validate output from rename/copy detection (#1)' \
     'diff -u current expected'
 
 test_expect_success \
@@ -98,7 +98,7 @@ diff --git a/COPYING b/COPYING
 EOF
 
 test_expect_success \
-    'validate output from rename/copy detection' \
+    'validate output from rename/copy detection (#2)' \
     'diff -u current expected'
 
 test_expect_success \
@@ -127,7 +127,7 @@ copy to COPYING.#
 EOF
 
 test_expect_success \
-    'validate output from rename/copy detection' \
+    'validate output from rename/copy detection (#3)' \
     'diff -u current expected'
 
 test_done
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -36,7 +36,42 @@ cat >expected <<\EOF
 EOF
 
 test_expect_success \
-    'validate output from rename/copy detection' \
+    'validate output from rename/copy detection (#1)' \
+    'diff -u current expected'
+
+# make sure diff-helper groks it correctly.
+mv expected raw-output
+GIT_DIFF_OPTS=--unified=0 git-diff-helper <raw-output |
+sed -e 's/\([0-9][0-9]*\)/#/g' >current &&
+cat >expected <<\EOF
+diff --git a/COPYING b/COPYING.#
+similarity index #%
+copy from COPYING
+copy to COPYING.#
+--- a/COPYING
++++ b/COPYING.#
+@@ -# +# @@
+- HOWEVER, in order to allow a migration to GPLv# if that seems like
++ However, in order to allow a migration to GPLv# if that seems like
+diff --git a/COPYING b/COPYING.#
+similarity index #%
+rename old COPYING
+rename new COPYING.#
+--- a/COPYING
++++ b/COPYING.#
+@@ -# +# @@
+- Note that the only valid version of the GPL as far as this project
++ Note that the only valid version of the G.P.L as far as this project
+@@ -# +# @@
+- HOWEVER, in order to allow a migration to GPLv# if that seems like
++ HOWEVER, in order to allow a migration to G.P.Lv# if that seems like
+@@ -# +# @@
+-	This file is licensed under the GPL v#, or a later version
++	This file is licensed under the G.P.L v#, or a later version
+EOF
+
+test_expect_success \
+    'validate output from diff-helper (#1)' \
     'diff -u current expected'
 
 test_expect_success \
@@ -56,7 +91,39 @@ cat >expected <<\EOF
 EOF
 
 test_expect_success \
-    'validate output from rename/copy detection' \
+    'validate output from rename/copy detection (#2)' \
+    'diff -u current expected'
+
+# make sure diff-helper groks it correctly.
+mv expected raw-output
+GIT_DIFF_OPTS=--unified=0 git-diff-helper <raw-output |
+sed -e 's/\([0-9][0-9]*\)/#/g' >current
+cat >expected <<\EOF
+diff --git a/COPYING b/COPYING.#
+similarity index #%
+copy from COPYING
+copy to COPYING.#
+--- a/COPYING
++++ b/COPYING.#
+@@ -# +# @@
+- HOWEVER, in order to allow a migration to GPLv# if that seems like
++ However, in order to allow a migration to GPLv# if that seems like
+diff --git a/COPYING b/COPYING
+--- a/COPYING
++++ b/COPYING
+@@ -# +# @@
+- Note that the only valid version of the GPL as far as this project
++ Note that the only valid version of the G.P.L as far as this project
+@@ -# +# @@
+- HOWEVER, in order to allow a migration to GPLv# if that seems like
++ HOWEVER, in order to allow a migration to G.P.Lv# if that seems like
+@@ -# +# @@
+-	This file is licensed under the GPL v#, or a later version
++	This file is licensed under the G.P.L v#, or a later version
+EOF
+
+test_expect_success \
+    'validate output from diff-helper (#2)' \
     'diff -u current expected'
 
 test_expect_success \
@@ -76,7 +143,27 @@ cat >expected <<\EOF
 EOF
 
 test_expect_success \
-    'validate output from rename/copy detection' \
+    'validate output from rename/copy detection (#3)' \
+    'diff -u current expected'
+
+# make sure diff-helper groks it correctly.
+mv expected raw-output
+GIT_DIFF_OPTS=--unified=0 git-diff-helper <raw-output |
+sed -e 's/\([0-9][0-9]*\)/#/g' >current
+cat >expected <<\EOF
+diff --git a/COPYING b/COPYING.#
+similarity index #%
+copy from COPYING
+copy to COPYING.#
+--- a/COPYING
++++ b/COPYING.#
+@@ -# +# @@
+- HOWEVER, in order to allow a migration to GPLv# if that seems like
++ However, in order to allow a migration to GPLv# if that seems like
+EOF
+
+test_expect_success \
+    'validate output from diff-helper (#3)' \
     'diff -u current expected'
 
 test_done
------------------------------------------------

