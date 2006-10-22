From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 1/2] Regression test for "stg delete"
Date: Sun, 22 Oct 2006 14:58:11 +0200
Message-ID: <20061022125811.15194.63337.stgit@localhost>
References: <20061022125337.15194.64831.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 14:58:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbcu8-0000Rj-Ak
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 14:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWJVM6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 08:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWJVM6O
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 08:58:14 -0400
Received: from mxfep04.bredband.com ([195.54.107.79]:24514 "EHLO
	mxfep04.bredband.com") by vger.kernel.org with ESMTP
	id S1751787AbWJVM6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 08:58:13 -0400
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep04.bredband.com with ESMTP
          id <20061022125811.QUTO8360.mxfep04.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 14:58:11 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport.bredband.com with ESMTP; 22 Oct 2006 14:58:11 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id 69B554C010;
	Sun, 22 Oct 2006 14:58:11 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20061022125337.15194.64831.stgit@localhost>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29729>

From: Karl Hasselstr=C3=B6m <kha@treskal.com>

NOTE: The subtest that attempts to delete a patch in another branch
currently fails, because there's a bug in "delete".

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 t/t1600-delete.sh |  109 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/t/t1600-delete.sh b/t/t1600-delete.sh
new file mode 100644
index 0000000..e22e624
--- /dev/null
+++ b/t/t1600-delete.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+# Copyright (c) 2006 Karl Hasselstr=C3=B6m
+test_description=3D'Test the delete command.'
+=2E ./test-lib.sh
+
+test_expect_success \
+    'Initialize the StGIT repository' \
+    'stg init'
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
+    'Try to delete a non-existing patch' \
+    '
+    [ $(stg applied | wc -l) -eq 1 ] &&
+    ! stg delete bar &&
+    [ $(stg applied | wc -l) -eq 1 ]
+    '
+
+test_expect_success \
+    'Try to delete the topmost patch while dirty' \
+    '
+    echo dirty >> foo.txt &&
+    [ $(stg applied | wc -l) -eq 1 ] &&
+    ! stg delete foo &&
+    [ $(stg applied | wc -l) -eq 1 ] &&
+    git reset --hard
+    '
+
+test_expect_success \
+    'Delete the topmost patch' \
+    '
+    [ $(stg applied | wc -l) -eq 1 ] &&
+    stg delete foo &&
+    [ $(stg applied | wc -l) -eq 0 ]
+    '
+
+test_expect_success \
+    'Create an unapplied patch' \
+    '
+    stg new foo -m foo &&
+    echo foo > foo.txt &&
+    stg add foo.txt &&
+    stg refresh &&
+    stg pop
+    '
+
+test_expect_success \
+    'Delete an unapplied patch' \
+    '
+    [ $(stg unapplied | wc -l) -eq 1 ] &&
+    stg delete foo &&
+    [ $(stg unapplied | wc -l) -eq 0 ]
+    '
+
+test_expect_success \
+    'Create two patches' \
+    '
+    stg new foo -m foo &&
+    echo foo > foo.txt &&
+    stg add foo.txt &&
+    stg refresh &&
+    stg new bar -m bar &&
+    echo bar > bar.txt &&
+    stg add bar.txt &&
+    stg refresh
+    '
+
+test_expect_success \
+    'Try to delete a non-topmost applied patch' \
+    '
+    [ $(stg applied | wc -l) -eq 2 ] &&
+    ! stg delete foo &&
+    [ $(stg applied | wc -l) -eq 2 ]
+    '
+
+test_expect_success \
+    'Create another branch, and put one patch in each branch' \
+    '
+    stg branch --create br &&
+    stg new baz -m baz &&
+    echo baz > baz.txt &&
+    stg add baz.txt &&
+    stg refresh &&
+    stg branch master &&
+    stg new baz -m baz &&
+    echo baz > baz.txt &&
+    stg add baz.txt &&
+    stg refresh
+    '
+
+test_expect_success \
+    'Delete a patch in another branch' \
+    '
+    [ $(stg applied | wc -l) -eq 3 ] &&
+    [ $(stg applied -b br | wc -l) -eq 1 ] &&
+    stg delete -b br baz &&
+    [ $(stg applied | wc -l) -eq 3 ] &&
+    [ $(stg applied -b br | wc -l) -eq 0 ]
+    '
+
+test_done
