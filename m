From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 3/4] Add tests for .git file
Date: Mon,  4 Feb 2008 21:59:20 +0100
Message-ID: <1202158761-31211-4-git-send-email-hjemli@gmail.com>
References: <1202158761-31211-1-git-send-email-hjemli@gmail.com>
 <1202158761-31211-2-git-send-email-hjemli@gmail.com>
 <1202158761-31211-3-git-send-email-hjemli@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:02:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8S2-0008Ne-D4
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 22:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbYBDVBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 16:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbYBDVBG
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 16:01:06 -0500
Received: from mail42.e.nsc.no ([193.213.115.42]:46892 "EHLO mail42.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbYBDVBE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 16:01:04 -0500
Received: from localhost.localdomain (ti231210a341-0149.bb.online.no [88.88.168.149])
	by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id m14L0REf021902;
	Mon, 4 Feb 2008 22:00:31 +0100 (MET)
X-Mailer: git-send-email 1.5.4.5.g25d066
In-Reply-To: <1202158761-31211-3-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72566>

Verify that the basic plumbing works when .git is a file pointing at
the real git directory.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 t/t0002-gitfile.sh |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100755 t/t0002-gitfile.sh

diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
new file mode 100755
index 0000000..f8f39e6
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
+	echo "gitdir: $REAL" >.git
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
1.5.4.5.g25d066
