From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Add tests for .git file
Date: Sat,  2 Feb 2008 16:02:51 +0100
Message-ID: <1201964571-4801-1-git-send-email-hjemli@gmail.com>
References: <1201948579-11807-1-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 16:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLJvj-0007Sb-8H
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 16:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758168AbYBBPEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 10:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758045AbYBBPEf
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 10:04:35 -0500
Received: from mail44.e.nsc.no ([193.213.115.44]:39226 "EHLO mail44.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755529AbYBBPEe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 10:04:34 -0500
Received: from localhost.localdomain (ti231210a341-0149.bb.online.no [88.88.168.149])
	by mail44.nsc.no (8.13.8/8.13.5) with ESMTP id m12F3njN008203;
	Sat, 2 Feb 2008 16:03:50 +0100 (MET)
X-Mailer: git-send-email 1.5.4.GIT-dirty
In-Reply-To: <1201948579-11807-1-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72279>

Verify that the basic plumbing works when .git is a file pointing at
the real git directory.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 t/t0002-gitfile.sh |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100755 t/t0002-gitfile.sh

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
new file mode 100755
index 0000000..55276c6
--- /dev/null
+++ b/t/t0002-gitfile.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+
+test_description='.git file
+
+Verify that plumbing commands work when .git is a file
+'
+. ./test-lib.sh
+
+chkfile() {
+	D=$(echo $1 | cut -b 1-2) &&
+	F=$(echo $1 | cut -b 3-40) &&
+	if test ! -f $REAL/objects/$D/$F
+	then
+		echo "Object not found: $REAL/objects/$D/$F"
+		false
+	fi
+}
+
+test_expect_success 'setup' '
+	REAL=$(pwd)/.real &&
+	mv .git $REAL &&
+	echo "GITDIR: $REAL" >.git
+'
+
+test_expect_success 'check rev-parse --git-dir' '
+	test "$REAL" = "$(git rev-parse --git-dir)"
+'
+
+test_expect_success 'check hash-object' '
+	echo "foo" >bar &&
+	SHA=$(cat bar | git hash-object -w --stdin) &&
+	chkfile $SHA
+'
+
+test_expect_success 'check cat-file' '
+	git cat-file blob $SHA >actual &&
+	diff -u bar actual
+'
+
+test_expect_success 'check update-index' '
+	if test -f $REAL/index
+	then
+		echo "Hmm, $REAL/index exists?"
+		false
+	fi &&
+	rm -rf $REAL/objects/* &&
+	git update-index --add bar &&
+	if ! test -f $REAL/index
+	then
+		echo "$REAL/index not found"
+		false
+	fi &&
+	chkfile $SHA
+'
+
+test_expect_success 'check write-tree' '
+	SHA=$(git write-tree) &&
+	chkfile $SHA
+'
+
+test_expect_success 'check commit-tree' '
+	SHA=$(echo "commit bar" | git commit-tree $SHA) &&
+	chkfile $SHA
+'
+
+test_expect_success 'check rev-list' '
+	echo $SHA >$REAL/HEAD &&
+	test "$SHA" = "$(git rev-list HEAD)"
+'
+
+test_done
-- 
1.5.4.GIT-dirty
