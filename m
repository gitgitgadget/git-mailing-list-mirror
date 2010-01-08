From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] t7111: check that reset options work as described in the
	tables
Date: Fri, 08 Jan 2010 05:45:10 +0100
Message-ID: <20100108044511.3530.90952.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 05:45:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT6ir-00034Q-Cd
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 05:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719Ab0AHEnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 23:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456Ab0AHEnO
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 23:43:14 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:38147 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442Ab0AHEnN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 23:43:13 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CA5F4818019;
	Fri,  8 Jan 2010 05:43:02 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 24281818002;
	Fri,  8 Jan 2010 05:42:59 +0100 (CET)
X-git-sha1: f4d4ceb95f9c86dde906f806f4eecc56b8035f47 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136415>

Some previous patches added some tables to the "git reset"
documentation. These tables describe the behavior of "git reset"
depending on the option it is passed and the state of the files
in the working tree, the index, HEAD and the target commit.

This patch adds some tests to make sure that the tables describe
the behavior of "git reset".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7111-reset-table.sh |  121 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100755 t/t7111-reset-table.sh

diff --git a/t/t7111-reset-table.sh b/t/t7111-reset-table.sh
new file mode 100755
index 0000000..16b33a5
--- /dev/null
+++ b/t/t7111-reset-table.sh
@@ -0,0 +1,121 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Christian Couder
+#
+
+test_description='Tests to check that "reset" options follow a known table'
+
+. ./test-lib.sh
+
+
+test_expect_success 'creating initial commits' '
+    test_commit E file1 &&
+    test_commit D file1 &&
+    test_commit C file1
+'
+
+test_expect_success 'creating table file 1' '
+    cat <<EOF >table1
+A B C D soft   A B D
+A B C D mixed  A D D
+A B C D hard   D D D
+A B C D merge  XXXXX
+A B C C soft   A B C
+A B C C mixed  A C C
+A B C C hard   C C C
+A B C C merge  XXXXX
+B B C D soft   B B D
+B B C D mixed  B D D
+B B C D hard   D D D
+B B C D merge  D D D
+B B C C soft   B B C
+B B C C mixed  B C C
+B B C C hard   C C C
+B B C C merge  C C C
+B C C D soft   B C D
+B C C D mixed  B D D
+B C C D hard   D D D
+B C C D merge  XXXXX
+B C C C soft   B C C
+B C C C mixed  B C C
+B C C C hard   C C C
+B C C C merge  B C C
+EOF
+'
+
+while read W1 I1 H1 T opt W2 I2 H2
+do
+    test_expect_success "check: $W1 $I1 $H1 $T --$opt $W2 $I2 $H2" '
+        git reset --hard C &&
+        if [ "$I1" != "$H1" ]
+        then
+            echo "$I1" > file1 &&
+            git add file1
+        fi &&
+        if [ "$W1" != "$I1" ]
+        then
+            echo "$W1" > file1
+        fi &&
+        if [ "$W2" != "XXXXX" ]
+        then
+            git reset --$opt $T &&
+            test "$(cat file1)" = "$W2" &&
+            git checkout-index -f -- file1 &&
+            test "$(cat file1)" = "$I2" &&
+            git checkout -f HEAD -- file1 &&
+            test "$(cat file1)" = "$H2"
+        else
+            test_must_fail git reset --$opt $T
+        fi
+    '
+done < table1
+
+test_expect_success 'setting up branches to test with unmerged entries' '
+    git reset --hard C &&
+    git branch branch1 &&
+    git branch branch2 &&
+    git checkout branch1 &&
+    test_commit B1 file1 &&
+    git checkout branch2 &&
+    test_commit B2 file1
+'
+
+test_expect_success 'creating table file 2' '
+    cat <<EOF >table2
+X U C D soft   XXXXX
+X U C D mixed  X D D
+X U C D hard   D D D
+X U C D merge  D D D
+X U C C soft   XXXXX
+X U C C mixed  X C C
+X U C C hard   C C C
+X U C C merge  C C C
+EOF
+'
+
+while read W1 I1 H1 T opt W2 I2 H2
+do
+    test_expect_success "check: $W1 $I1 $H1 $T --$opt $W2 $I2 $H2" '
+        git reset --hard B2 &&
+        test_must_fail git merge branch1 &&
+        cat file1 >X_file1 &&
+        if [ "$W2" != "XXXXX" ]
+        then
+            git reset --$opt $T &&
+            if [ "$W2" = "X" ]
+            then
+                test_cmp file1 X_file1
+            else
+                test "$(cat file1)" = "$W2"
+            fi &&
+            git checkout-index -f -- file1 &&
+            test "$(cat file1)" = "$I2" &&
+            git checkout -f HEAD -- file1 &&
+            test "$(cat file1)" = "$H2"
+        else
+            test_must_fail git reset --$opt $T
+        fi
+    '
+done < table2
+
+test_done
-- 
1.6.6.rc2.5.g49666
