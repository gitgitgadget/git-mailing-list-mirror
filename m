From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 2/2] Regression test for "stg assimilate"
Date: Sun, 22 Oct 2006 15:08:08 +0200
Message-ID: <20061022130807.17015.77803.stgit@localhost>
References: <20061022130559.17015.51385.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 15:09:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbd4i-00029J-IC
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 15:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWJVNJK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 09:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWJVNJJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 09:09:09 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:33436 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751801AbWJVNJH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 09:09:07 -0400
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20061022130905.QLLO2091.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 15:09:05 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport.bredband.com with ESMTP; 22 Oct 2006 15:09:05 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id 2060B4CBD2;
	Sun, 22 Oct 2006 15:08:08 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20061022130559.17015.51385.stgit@localhost>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29738>

From: Karl Hasselstr=C3=B6m <kha@treskal.com>



Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t1301-assimilate.sh |   86 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/t/t1301-assimilate.sh b/t/t1301-assimilate.sh
new file mode 100755
index 0000000..26b263c
--- /dev/null
+++ b/t/t1301-assimilate.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+# Copyright (c) 2006 Karl Hasselstr=C3=B6m
+test_description=3D'Test the assimilate command.'
+=2E ./test-lib.sh
+
+test_expect_success \
+    'Assimilate in a non-initialized repository' \
+    'stg assimilate'
+
+test_expect_success \
+    'Initialize the StGIT repository' \
+    'stg init'
+
+test_expect_success \
+    'Assimilate in a repository without patches' \
+    'stg assimilate'
+
+test_expect_success \
+    'Create a patch' \
+    '
+    stg new foo -m foo &&
+    echo foo > foo.txt &&
+    stg add foo.txt &&
+    stg refresh
+    '
+
+test_expect_success \
+    'Assimilate when there is nothing to do' \
+    'stg assimilate'
+
+test_expect_success \
+    'Create a GIT commit' \
+    '
+    echo bar > bar.txt &&
+    git add bar.txt &&
+    git commit -a -m bar
+    '
+
+test_expect_success \
+    'Assimilate one GIT commit' \
+    '
+    [ $(stg applied | wc -l) -eq 1 ] &&
+    stg assimilate &&
+    [ $(stg applied | wc -l) -eq 2 ]
+    '
+
+test_expect_success \
+    'Create three more GIT commits' \
+    '
+    echo one > numbers.txt &&
+    git add numbers.txt &&
+    git commit -a -m one &&
+    echo two >> numbers.txt &&
+    git commit -a -m two &&
+    echo three >> numbers.txt &&
+    git commit -a -m three
+    '
+
+test_expect_success \
+    'Assimilate three GIT commits' \
+    '
+    [ $(stg applied | wc -l) -eq 2 ] &&
+    stg assimilate &&
+    [ $(stg applied | wc -l) -eq 5 ]
+    '
+
+test_expect_success \
+    'Create a mege commit' \
+    '
+    git checkout -b br master^^ &&
+    echo woof > woof.txt &&
+    git add woof.txt &&
+    git commit -a -m woof &&
+    git checkout master &&
+    git pull . br
+    '
+
+test_expect_success \
+    'Try (and fail) to assimilate the merge commit' \
+    '
+    [ $(stg applied | wc -l) -eq 5 ] &&
+    ! stg assimilate &&
+    [ $(stg applied | wc -l) -eq 5 ]
+    '
+
+test_done
