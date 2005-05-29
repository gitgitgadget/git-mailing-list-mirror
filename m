From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] diff-helper: Fix R/C score parsing under -z flag.
Date: Sun, 29 May 2005 16:54:59 -0700
Message-ID: <7vacmdh9kc.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
	<7vis11n69l.fsf@assigned-by-dhcp.cox.net>
	<7v3bs5k8d1.fsf@assigned-by-dhcp.cox.net>
	<7vmzqdiore.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 01:53:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcXb3-0002W0-Lo
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVE2Xzx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVE2Xzx
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:55:53 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:57839 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261464AbVE2XzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 19:55:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529235458.TVHH23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 19:54:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzqdiore.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 29 May 2005 16:41:25 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The score number that follow R/C status were parsed but the
parse pointer was not updated, causing the entire line to become
unrecognized.  This patch fixes this problem.

There was a test missing to catch this breakage, which this
commit adds as t4009-diff-rename-4.sh.  The diff-raw tests used
in related t4005-diff-rename-2.sh (the same test without -z) and
t4007-rename-3.sh were stricter than necessarily, despite that
the comment for the tests said otherwise.  This patch also
corrects them.

The documentation is updated to say that the status can
optionally be followed by a number called "score"; it does not
have to stay similarity index forever and there is no reason to
limit it only to C and R.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Documentation/diff-format.txt |    2 
diff-helper.c                 |   17 +--
t/t4005-diff-rename-2.sh      |   20 ++--
t/t4007-rename-3.sh           |    2 
t/t4009-diff-rename-4.sh      |  196 ++++++++++++++++++++++++++++++++++++++++++
5 files changed, 219 insertions(+), 18 deletions(-)
new file (100755): t/t4009-diff-rename-4.sh

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -36,7 +36,7 @@ That is, from the left to the right:
   (6) sha1 for "src"; 0{40} if creation or unmerged.
   (7) a space.
   (8) sha1 for "dst"; 0{40} if creation, unmerged or "look at work tree".
-  (9) status, followed by similarlity index number only for C and R.
+  (9) status, followed by optional "score" number.
  (10) a tab or a NUL when '-z' option is used.
  (11) path for "src"
  (12) a tab or a NUL when '-z' option is used; only exists for C or R.
diff --git a/diff-helper.c b/diff-helper.c
--- a/diff-helper.c
+++ b/diff-helper.c
@@ -80,17 +80,16 @@ int main(int ac, const char **av) {
 			if (!strchr("MCRNDU", status))
 				break;
 			two_paths = score = 0;
-			if (status == 'R' || status == 'C') {
+			if (status == 'R' || status == 'C')
 				two_paths = 1;
-				sscanf(cp, "%d", &score);
-				if (line_termination) {
-					cp = strchr(cp,
-						    inter_name_termination);
-					if (!cp)
-						break;
-				}
-			}
 
+			/* pick up score if exists */
+			if (sscanf(cp, "%d", &score) != 1)
+				score = 0;
+			cp = strchr(cp,
+				    inter_name_termination);
+			if (!cp)
+				break;
 			if (*cp++ != inter_name_termination)
 				break;
 
diff --git a/t/t4005-diff-rename-2.sh b/t/t4005-diff-rename-2.sh
--- a/t/t4005-diff-rename-2.sh
+++ b/t/t4005-diff-rename-2.sh
@@ -8,11 +8,17 @@ test_description='Same rename detection 
 '
 . ./test-lib.sh
 
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+sanitize_diff_raw='s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*	/ X X \1#	/'
 compare_diff_raw () {
     # When heuristics are improved, the score numbers would change.
     # Ignore them while comparing.
-    sed -e 's/ \([CR]\)[0-9]*	/\1#/' <"$1" >.tmp-1
-    sed -e 's/ \([CR]\)[0-9]*	/\1#/' <"$2" >.tmp-2
+    # Also we do not check SHA1 hash generation in this test, which
+    # is a job for t0000-basic.sh
+
+    sed -e "$sanitize_diff_raw" <"$1" >.tmp-1
+    sed -e "$sanitize_diff_raw" <"$2" >.tmp-2
     diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
 
@@ -109,11 +115,6 @@ test_expect_success \
     'validate output from rename/copy detection (#2)' \
     'compare_diff_raw current expected'
 
-test_expect_success \
-    'prepare work tree once again' \
-    'cat ../../COPYING >COPYING &&
-     git-update-cache --add --remove COPYING COPYING.1'
-
 # make sure diff-helper can grok it.
 mv expected diff-raw
 GIT_DIFF_OPTS=--unified=0 git-diff-helper <diff-raw >current
@@ -151,6 +152,11 @@ test_expect_success \
 # anything about rezrov nor COPYING, since the revised again diff-raw
 # nows how to say Copy.
 
+test_expect_success \
+    'prepare work tree once again' \
+    'cat ../../COPYING >COPYING &&
+     git-update-cache --add --remove COPYING COPYING.1'
+
 git-diff-cache -C $tree >current
 cat >expected <<\EOF
 :100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234	COPYING	COPYING.1
diff --git a/t/t4007-rename-3.sh b/t/t4007-rename-3.sh
--- a/t/t4007-rename-3.sh
+++ b/t/t4007-rename-3.sh
@@ -10,7 +10,7 @@ test_description='Rename interaction wit
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
-sanitize_diff_raw='s/ \('"$_x40"'\) \1 \([CR]\)[0-9]*	/ \1 \1 \2#	/'
+sanitize_diff_raw='s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*	/ X X \1#	/'
 compare_diff_raw () {
     # When heuristics are improved, the score numbers would change.
     # Ignore them while comparing.
diff --git a/t/t4009-diff-rename-4.sh b/t/t4009-diff-rename-4.sh
new file mode 100755
--- /dev/null
+++ b/t/t4009-diff-rename-4.sh
@@ -0,0 +1,196 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='Same rename detection as t4003 but testing diff-raw -z.
+
+'
+. ./test-lib.sh
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+sanitize_diff_raw='/^:/s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*$/ X X \1#/'
+compare_diff_raw () {
+    # When heuristics are improved, the score numbers would change.
+    # Ignore them while comparing.
+    # Also we do not check SHA1 hash generation in this test, which
+    # is a job for t0000-basic.sh
+
+    tr '\0' '\012' <"$1" | sed -e "$sanitize_diff_raw" >.tmp-1
+    tr '\0' '\012' <"$2" | sed -e "$sanitize_diff_raw" >.tmp-2
+    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
+
+compare_diff_patch () {
+    # When heuristics are improved, the score numbers would change.
+    # Ignore them while comparing.
+    sed -e '/^similarity index [0-9]*%$/d' <"$1" >.tmp-1
+    sed -e '/^similarity index [0-9]*%$/d' <"$2" >.tmp-2
+    diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
+}
+
+test_expect_success \
+    'prepare reference tree' \
+    'cat ../../COPYING >COPYING &&
+     echo frotz >rezrov &&
+    git-update-cache --add COPYING rezrov &&
+    tree=$(git-write-tree) &&
+    echo $tree'
+
+test_expect_success \
+    'prepare work tree' \
+    'sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
+    sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
+    rm -f COPYING &&
+    git-update-cache --add --remove COPYING COPYING.?'
+
+# tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
+# both are slightly edited, and unchanged rezrov.  We say COPYING.1
+# and COPYING.2 are based on COPYING, and do not say anything about
+# rezrov.
+
+git-diff-cache -z -M $tree >current
+
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234
+COPYING
+COPYING.1
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471 R1234
+COPYING
+COPYING.2
+EOF
+
+test_expect_success \
+    'validate output from rename/copy detection (#1)' \
+    'compare_diff_raw current expected'
+
+# make sure diff-helper can grok it.
+mv current diff-raw
+GIT_DIFF_OPTS=--unified=0 git-diff-helper -z <diff-raw >current
+cat >expected <<\EOF
+diff --git a/COPYING b/COPYING.1
+copy from COPYING
+copy to COPYING.1
+--- a/COPYING
++++ b/COPYING.1
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ However, in order to allow a migration to GPLv3 if that seems like
+diff --git a/COPYING b/COPYING.2
+rename old COPYING
+rename new COPYING.2
+--- a/COPYING
++++ b/COPYING.2
+@@ -2 +2 @@
+- Note that the only valid version of the GPL as far as this project
++ Note that the only valid version of the G.P.L as far as this project
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ HOWEVER, in order to allow a migration to G.P.Lv3 if that seems like
+@@ -12 +12 @@
+-	This file is licensed under the GPL v2, or a later version
++	This file is licensed under the G.P.L v2, or a later version
+EOF
+
+test_expect_success \
+    'validate output from diff-helper (#1)' \
+    'compare_diff_patch current expected'
+
+################################################################
+
+test_expect_success \
+    'prepare work tree again' \
+    'mv COPYING.2 COPYING &&
+     git-update-cache --add --remove COPYING COPYING.1 COPYING.2'
+
+# tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
+# both are slightly edited, and unchanged rezrov.  We say COPYING.1
+# is based on COPYING and COPYING is still there, and do not say anything
+# about rezrov.
+
+git-diff-cache -z -C $tree >current
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 06c67961bbaed34a127f76d261f4c0bf73eda471 M
+COPYING
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234
+COPYING
+COPYING.1
+EOF
+
+test_expect_success \
+    'validate output from rename/copy detection (#2)' \
+    'compare_diff_raw current expected'
+
+# make sure diff-helper can grok it.
+mv current diff-raw
+GIT_DIFF_OPTS=--unified=0 git-diff-helper -z <diff-raw >current
+cat >expected <<\EOF
+diff --git a/COPYING b/COPYING
+--- a/COPYING
++++ b/COPYING
+@@ -2 +2 @@
+- Note that the only valid version of the GPL as far as this project
++ Note that the only valid version of the G.P.L as far as this project
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ HOWEVER, in order to allow a migration to G.P.Lv3 if that seems like
+@@ -12 +12 @@
+-	This file is licensed under the GPL v2, or a later version
++	This file is licensed under the G.P.L v2, or a later version
+diff --git a/COPYING b/COPYING.1
+copy from COPYING
+copy to COPYING.1
+--- a/COPYING
++++ b/COPYING.1
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ However, in order to allow a migration to GPLv3 if that seems like
+EOF
+
+test_expect_success \
+    'validate output from diff-helper (#2)' \
+    'compare_diff_patch current expected'
+
+################################################################
+
+# tree has COPYING and rezrov.  work tree has the same COPYING and
+# copy-edited COPYING.1, and unchanged rezrov.  We should not say
+# anything about rezrov nor COPYING, since the revised again diff-raw
+# nows how to say Copy.
+
+test_expect_success \
+    'prepare work tree once again' \
+    'cat ../../COPYING >COPYING &&
+     git-update-cache --add --remove COPYING COPYING.1'
+
+git-diff-cache -z -C $tree >current
+cat >expected <<\EOF
+:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 0603b3238a076dc6c8022aedc6648fa523a17178 C1234
+COPYING
+COPYING.1
+EOF
+
+test_expect_success \
+    'validate output from rename/copy detection (#3)' \
+    'compare_diff_raw current expected'
+
+# make sure diff-helper can grok it.
+mv current diff-raw
+GIT_DIFF_OPTS=--unified=0 git-diff-helper -z <diff-raw >current
+cat >expected <<\EOF
+diff --git a/COPYING b/COPYING.1
+copy from COPYING
+copy to COPYING.1
+--- a/COPYING
++++ b/COPYING.1
+@@ -6 +6 @@
+- HOWEVER, in order to allow a migration to GPLv3 if that seems like
++ However, in order to allow a migration to GPLv3 if that seems like
+EOF
+
+test_expect_success \
+    'validate output from diff-helper (#3)' \
+    'compare_diff_patch current expected'
+
+test_done
------------------------------------------------

