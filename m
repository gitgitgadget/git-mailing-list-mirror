From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/7 v3] bisect: add test cases for "git bisect replace"
Date: Sat, 8 Nov 2008 08:48:55 +0100
Message-ID: <20081108084855.3fa6ae7b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 08 08:48:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyiYV-0007sl-UL
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 08:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbYKHHqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 02:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbYKHHqe
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 02:46:34 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:45794 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbYKHHqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 02:46:33 -0500
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 76FA2B0113;
	Sat,  8 Nov 2008 08:46:32 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp7-g19.free.fr (Postfix) with SMTP id 363A1B00EC;
	Sat,  8 Nov 2008 08:46:32 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100382>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6035-bisect-replace.sh |  130 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 130 insertions(+), 0 deletions(-)
 create mode 100755 t/t6035-bisect-replace.sh

diff --git a/t/t6035-bisect-replace.sh b/t/t6035-bisect-replace.sh
new file mode 100755
index 0000000..6ab3667
--- /dev/null
+++ b/t/t6035-bisect-replace.sh
@@ -0,0 +1,130 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Christian Couder
+#
+test_description='Test git bisect replace functionality'
+
+exec </dev/null
+
+. ./test-lib.sh
+
+add_and_commit_file()
+{
+    _file="$1"
+    _msg="$2"
+
+    git add $_file || return $?
+    test_tick || return $?
+    git commit --quiet -m "$_file: $_msg"
+}
+
+HASH1=
+HASH2=
+HASH3=
+HASH4=
+HASH5=
+HASH6=
+HASH7=
+
+test_expect_success 'set up buggy branch' '
+     echo "line 1" >> hello &&
+     echo "line 2" >> hello &&
+     echo "line 3" >> hello &&
+     echo "line 4" >> hello &&
+     add_and_commit_file hello "4 lines" &&
+     HASH1=$(git rev-parse --verify HEAD) &&
+     echo "line BUG" >> hello &&
+     echo "line 6" >> hello &&
+     echo "line 7" >> hello &&
+     echo "line 8" >> hello &&
+     add_and_commit_file hello "4 more lines with a BUG" &&
+     HASH2=$(git rev-parse --verify HEAD) &&
+     echo "line 9" >> hello &&
+     echo "line 10" >> hello &&
+     add_and_commit_file hello "2 more lines" &&
+     HASH3=$(git rev-parse --verify HEAD) &&
+     echo "line 11" >> hello &&
+     add_and_commit_file hello "1 more line" &&
+     HASH4=$(git rev-parse --verify HEAD) &&
+     sed -e "s/BUG/5/" hello > hello.new &&
+     mv hello.new hello &&
+     add_and_commit_file hello "BUG fixed" &&
+     HASH5=$(git rev-parse --verify HEAD) &&
+     echo "line 12" >> hello &&
+     echo "line 13" >> hello &&
+     add_and_commit_file hello "2 more lines" &&
+     HASH6=$(git rev-parse --verify HEAD)
+     echo "line 14" >> hello &&
+     echo "line 15" >> hello &&
+     echo "line 16" >> hello &&
+     add_and_commit_file hello "again 3 more lines" &&
+     HASH7=$(git rev-parse --verify HEAD)
+'
+
+HASHFIX2=
+HASHFIX3=
+HASHFIX4=
+
+test_expect_success 'set up fixed branch' '
+     git checkout $HASH1 &&
+     echo "line 5" >> hello &&
+     echo "line 6" >> hello &&
+     echo "line 7" >> hello &&
+     echo "line 8" >> hello &&
+     add_and_commit_file hello "4 more lines with no BUG" &&
+     HASHFIX2=$(git rev-parse --verify HEAD) &&
+     git cherry-pick $HASH3 &&
+     HASHFIX3=$(git rev-parse --verify HEAD) &&
+     git cherry-pick $HASH4 &&
+     HASHFIX4=$(git rev-parse --verify HEAD)
+'
+
+test_expect_success '"git bisect replace" buggy branch with fixed one' '
+     git bisect replace $HASH5 HEAD
+'
+
+test_expect_success 'replace works when bisecting with a later bad commit' '
+     git rev-list --bisect-all $HASH7 > rev_list.txt &&
+     grep $HASHFIX2 rev_list.txt &&
+     grep $HASHFIX3 rev_list.txt &&
+     grep $HASHFIX4 rev_list.txt &&
+     test_must_fail grep $HASH2 rev_list.txt &&
+     test_must_fail grep $HASH3 rev_list.txt &&
+     test_must_fail grep $HASH4 rev_list.txt
+'
+
+test_expect_success 'replace works starting just after replaced commit' '
+     git rev-list --bisect-all $HASH6 > rev_list.txt &&
+     grep $HASHFIX2 rev_list.txt &&
+     grep $HASHFIX3 rev_list.txt &&
+     grep $HASHFIX4 rev_list.txt &&
+     test_must_fail grep $HASH2 rev_list.txt &&
+     test_must_fail grep $HASH3 rev_list.txt &&
+     test_must_fail grep $HASH4 rev_list.txt
+'
+
+test_expect_success 'replace works starting from replaced commit' '
+     git rev-list --bisect-all $HASH5 > rev_list.txt &&
+     grep $HASHFIX2 rev_list.txt &&
+     grep $HASHFIX3 rev_list.txt &&
+     grep $HASHFIX4 rev_list.txt &&
+     test_must_fail grep $HASH2 rev_list.txt &&
+     test_must_fail grep $HASH3 rev_list.txt &&
+     test_must_fail grep $HASH4 rev_list.txt
+'
+
+test_expect_success 'standard bisect works' '
+     git bisect start $HASH6 $HASH1 &&
+     test "$(git rev-parse --verify HEAD)" = "$HASHFIX3" &&
+     git bisect good &&
+     test "$(git rev-parse --verify HEAD)" = "$HASH5" &&
+     git bisect bad &&
+     test "$(git rev-parse --verify HEAD)" = "$HASHFIX4" &&
+     git bisect bad > my_bisect_log.txt &&
+     grep "$HASHFIX4 is first bad commit" my_bisect_log.txt &&
+     git bisect reset
+'
+
+#
+#
+test_done
-- 
1.6.0.3.619.g9a6a
