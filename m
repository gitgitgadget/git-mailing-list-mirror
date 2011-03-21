From: Elijah Newren <newren@gmail.com>
Subject: [WIP PATCH 08/10] More test scripts
Date: Mon, 21 Mar 2011 12:31:02 -0600
Message-ID: <1300732264-9638-9-git-send-email-newren@gmail.com>
References: <1300732264-9638-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:25:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jmn-0000RW-41
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153Ab1CUSY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:24:57 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:47678 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142Ab1CUSYz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:24:55 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so5223921vxi.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=USUWWj8R/3Jm9gKMdYNHTFrPqAyMarPiGybu1mKUKdk=;
        b=Tds+B3km+oZDMrumlRGzLukutk3aa8YibhgDa6cSq/CSCxQ25li3ISUSzvzTE5LePD
         gmfR8kjK80YpGCOHGOnrxqBtbuO2PhF8r4cet2U26Tx3eNmi6tatarkdf5cYYTDv/dWa
         3eoUCu5D06S/VgZbVqtL3mR1gusOKy3HOwWa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nVoGLEaJbbAK8Lj8Yg1IS8cyrJY//WOPXcQZo0g5+jQ9eI+ZTjlKsphcuyqC8VqPSx
         snwcHIcBRdvf6dfk9H02PXvHF/muhiyznbAwWu9Oh+n/ggnekbmbgR11YJblYy2PXEIN
         izLFN6rkoxONl5ePlcJBb6vS2XZODdO3dDFCs=
Received: by 10.220.178.137 with SMTP id bm9mr1263297vcb.98.1300731894125;
        Mon, 21 Mar 2011 11:24:54 -0700 (PDT)
Received: from localhost6.localdomain6 (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b6sm1507291vci.0.2011.03.21.11.24.51
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:24:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.120.g38a18
In-Reply-To: <1300732264-9638-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169632>

---
 t/temp10.sh |   41 +++++++++++++++++++++++++++++++++
 t/temp11.sh |   41 +++++++++++++++++++++++++++++++++
 t/temp50.sh |   38 ++++++++++++++++++++++++++++++
 t/temp9.sh  |   73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 193 insertions(+), 0 deletions(-)
 create mode 100755 t/temp10.sh
 create mode 100755 t/temp11.sh
 create mode 100755 t/temp50.sh
 create mode 100755 t/temp9.sh

diff --git a/t/temp10.sh b/t/temp10.sh
new file mode 100755
index 0000000..100c74f
--- /dev/null
+++ b/t/temp10.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='merge+diff issue: rename/add vs. copy/modify'
+
+. ./test-lib.sh
+
+# Testcase setup:
+#   Commit A: new file: a
+#   Commit B: modify a slightly
+#   Commit C: rename a->b, add completely different a
+#
+# We should be able to merge B & C cleanly
+
+test_expect_success 'setup modify + rename/add(source) merge' '
+	printf "1\n2\n3\n4\n5\n6\n7\n" >a &&
+	git add a &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	echo 8 >>a &&
+	git add a &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a b &&
+	echo something completely different >a &&
+	git add a &&
+	git commit -m C
+'
+
+test_expect_success 'no conflict merging B & C' '
+	git checkout B^0 &&
+
+	git merge -s recursive C^0 &&
+
+	test $(git rev-parse B:a) = $(git rev-parse b) &&
+	test $(git rev-parse C:a) = $(git rev-parse a)
+'
+
+test_done
diff --git a/t/temp11.sh b/t/temp11.sh
new file mode 100755
index 0000000..1d8fb9a
--- /dev/null
+++ b/t/temp11.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+
+test_description='merge+diff issue: rename/add vs. copy/modify, v2'
+
+. ./test-lib.sh
+
+# Testcase setup:
+#   Commit A: new file: a
+#   Commit B: rename a->b
+#   Commit C: rename a->c, add completely different a
+#
+# Merging of B & C should NOT be clean; there's a rename/rename conflict
+
+test_expect_success 'setup modify + rename/add(source) merge' '
+	printf "1\n2\n3\n4\n5\n6\n7\n" >a &&
+	git add a &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a c &&
+	echo something completely different >a &&
+	git add a &&
+	git commit -m C
+'
+
+test_expect_success 'detect conflict merging B & C' '
+	git checkout B^0 &&
+
+	test_must_fail git merge -s recursive C^0 &&
+
+	test -f a &&
+	test -f b &&
+	test -f c
+'
+
+test_done
diff --git a/t/temp50.sh b/t/temp50.sh
new file mode 100755
index 0000000..5baebec
--- /dev/null
+++ b/t/temp50.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description="Rename/rename conflict doesn't leave files in place for user"
+
+. ./test-lib.sh
+
+test_expect_success 'setup rename/rename (1to2) conflict' '
+	echo stuff >a &&
+	git add a &&
+	test_tick &&
+	git commit -m base &&
+	git tag base &&
+
+	git checkout -b one base &&
+	git mv a b &&
+	test_tick &&
+	git commit -m one &&
+
+	git checkout -b two base &&
+	git mv a c &&
+	test_tick &&
+	git commit -m two
+'
+
+test_expect_success 'merge has correct working tree contents' '
+	git checkout two^0 &&
+
+	test_must_fail git merge -s recursive one^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 3 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test -f b &&
+	test -f c
+'
+
+test_done
diff --git a/t/temp9.sh b/t/temp9.sh
new file mode 100755
index 0000000..3936461
--- /dev/null
+++ b/t/temp9.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+
+test_description='recursive merge corner case: rename/rename + criss-cross merge + reintroduce file with name of rename source but different contents'
+
+. ./test-lib.sh
+
+#
+# Standard setup:
+#
+#      B   D
+#      o---o
+#     / \ / \
+#  A o   X   ? F
+#     \ / \ /
+#      o---o
+#      C   E
+#
+#   Commit A: new file: a
+#   Commit B: rename a->b
+#   Commit C: rename a->c, add different a
+#   Commit D: merge B&C, keeping a&b&c, modifying a at the beginning
+#   Commit E: merge B&C, keeping a&b&c, modifying a at the end
+#
+# Now, when we merge commits D & E, there should be no conflict...
+
+test_expect_success 'setup rename/rename + criss-cross + new file' '
+	printf "lots\nof\nwords\nand\ncontent\n" >a &&
+	git add a &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a b &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	git mv a c &&
+	printf "2\n3\n4\n5\n6\n7\n" >a &&
+	git add a &&
+	git commit -m C &&
+
+	git checkout B^0 &&
+	exit 1
+	test_must_fail git merge C &&
+	mv a old_a &&
+	echo 1 >a &&
+	cat old_a >>a &&
+	rm old_a &&
+	git add -u &&
+	git commit -m D &&
+	git tag D &&
+
+	git checkout C^0 &&
+	test_must_fail git merge B &&
+	echo 6 >> a &&
+	git add -u &&
+	git commit -m E &&
+	git tag E
+'
+
+test_expect_success 'no conflict merging D & E' '
+	git checkout D^0 &&
+
+	git merge -s recursive E^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test 6 -eq $(wc -l < a)
+'
+
+test_done
-- 
1.7.4
