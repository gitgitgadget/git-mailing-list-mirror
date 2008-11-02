From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 2/2] bisect: add test case for "git bisect replace"
Date: Sun, 2 Nov 2008 02:20:16 +0100
Message-ID: <20081102022016.99b7771e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 02:19:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwRcJ-0006Un-3y
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 02:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbYKBBRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 21:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbYKBBRp
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 21:17:45 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:42495 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbYKBBRo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 21:17:44 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 3556619701;
	Sun,  2 Nov 2008 02:17:43 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g19.free.fr (Postfix) with SMTP id C77CD19700;
	Sun,  2 Nov 2008 02:17:42 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99796>

---
 t/t6035-bisect-replace.sh |   89 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100755 t/t6035-bisect-replace.sh

diff --git a/t/t6035-bisect-replace.sh b/t/t6035-bisect-replace.sh
new file mode 100755
index 0000000..ed2061e
--- /dev/null
+++ b/t/t6035-bisect-replace.sh
@@ -0,0 +1,89 @@
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
+     git bisect replace $HASH5 HEAD &&
+     git rev-list --bisect-all $HASH6 > rev_list.txt &&
+     grep $HASHFIX2 rev_list.txt &&
+     grep $HASHFIX3 rev_list.txt &&
+     grep $HASHFIX4 rev_list.txt &&
+     test_must_fail grep $HASH2 rev_list.txt &&
+     test_must_fail grep $HASH3 rev_list.txt &&
+     test_must_fail grep $HASH4 rev_list.txt
+'
+
+#
+#
+test_done
-- 
1.6.0.3.531.gd12eb.dirty
