From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/7] replace_object: add a test case
Date: Fri, 23 Jan 2009 10:07:18 +0100
Message-ID: <20090123100718.b6613f76.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 10:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQI1u-0007ur-P4
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 10:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbZAWJHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 04:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754870AbZAWJHE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 04:07:04 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:46806 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754811AbZAWJHA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 04:07:00 -0500
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id EFF424B01CC;
	Fri, 23 Jan 2009 10:06:53 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id E93A04B00EC;
	Fri, 23 Jan 2009 10:06:50 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106865>

In this patch the setup code is very big, but this will be used in
test cases that will be added later.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100755 t/t6050-replace.sh

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
new file mode 100755
index 0000000..0a585ec
--- /dev/null
+++ b/t/t6050-replace.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Christian Couder
+#
+test_description='Tests replace refs functionality'
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
+test_expect_success 'replace the author' '
+     git cat-file commit $HASH2 | grep "author A U Thor" &&
+     R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
+     git cat-file commit $R | grep "author O Thor" &&
+     git update-ref refs/replace/$HASH2 $R &&
+     git show HEAD~5 | grep "O Thor" &&
+     git show $HASH2 | grep "O Thor"
+'
+
+#
+#
+test_done
-- 
1.6.1.231.g9c286
