From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/4] add a test case for git-merge-one-file
Date: Wed, 24 Jan 2007 02:14:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701240214000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jan 24 02:14:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9WiV-0006VF-Ro
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 02:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965486AbXAXBOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 20:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933158AbXAXBOV
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 20:14:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:56682 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933129AbXAXBOU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 20:14:20 -0500
Received: (qmail invoked by alias); 24 Jan 2007 01:14:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 24 Jan 2007 02:14:19 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37586>


Eventually, merge-one-file should go away. But in the meantime
let's make sure we don't have any regressions.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 t/t6025-merge-one-file.sh |   96 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)
 create mode 100644 t/t6025-merge-one-file.sh

diff --git a/t/t6025-merge-one-file.sh b/t/t6025-merge-one-file.sh
new file mode 100644
index 0000000..2eadcb3
--- /dev/null
+++ b/t/t6025-merge-one-file.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+
+test_description='Test merge-one-file'
+. ./test-lib.sh
+
+for w in one two three; do
+	echo $w > $w
+	git-hash-object -t blob -w $w
+	eval hash_$w=$(git-hash-object -t blob -w $w)
+done
+
+git-update-index --index-info << EOF
+10644 $hash_one 1	one
+10644 $hash_two 2	one
+10644 $hash_three 3	one
+EOF
+
+test_expect_failure "1 -> 2 -> 3" \
+	"git-merge-one-file $hash_one $hash_two $hash_three two 0644 0644 0644"
+
+git-update-index --index-info << EOF
+10644 $hash_one 1	two
+10644 $hash_three 3	two
+EOF
+
+test_expect_failure "deleted in our; modified in their" \
+	"git-merge-one-file $hash_one '' $hash_three two 0644 '' 0644"
+
+git-update-index --index-info << EOF
+10644 $hash_one 1	two
+10644 $hash_one 3	two
+EOF
+
+test_expect_success "deleted in our" \
+	"git-merge-one-file $hash_one '' $hash_one two 0644 '' 0644"
+
+test_expect_success "-> file untouched in work tree" "test -f two"
+
+git-update-index --index-info << EOF
+10644 $hash_one 1	two
+10644 $hash_one 2	two
+EOF
+
+test_expect_success "deleted in their" \
+	"git-merge-one-file $hash_one $hash_one '' two 0644 0644 ''"
+
+test_expect_success "-> now deleted in work tree" "test ! -f two"
+
+git-update-index --index-info << EOF
+10644 $hash_one 2	two
+10644 $hash_one 3	two
+EOF
+
+test_expect_failure "created identically, but mode differs" \
+	"git-merge-one-file '' $hash_one $hash_one two '' 0644 0755"
+
+test_expect_success "created identically" \
+	"git-merge-one-file '' $hash_one $hash_one two '' 0644 0644"
+
+test_expect_success "-> correct file" "test z$(cat two) = zone"
+
+cat one three > thirteen
+hash_13=$(git-hash-object -t blob -w thirteen)
+
+git-update-index --index-info << EOF
+10644 $hash_one 2	two
+10644 $hash_13 3	two
+EOF
+
+test_expect_failure "created non-identically, but mergeable" \
+	"git-merge-one-file '' $hash_one $hash_13 two '' 0644 0644"
+
+test_expect_success "-> correct file" "diff -u thirteen two"
+
+git-update-index --index-info << EOF
+10644 $hash_one 1	two
+10644 $hash_two 2	two
+10644 $hash_three 3	two
+EOF
+
+test_expect_failure "modified non-identically" \
+	"git-merge-one-file $hash_one $hash_two $hash_three two 0644 0644 0644"
+
+cat > expect << EOF
+<<<<<<<
+two
+=======
+three
+>>>>>>>
+EOF
+
+sed -e "s/<<<<<<< .*/<<<<<<</" -e "s/>>>>>>> .*/>>>>>>>/" < two > out
+
+test_expect_success "-> correct file" "diff -u expect out"
+
+test_done
-- 
1.5.0.rc2.gc5868-dirty
