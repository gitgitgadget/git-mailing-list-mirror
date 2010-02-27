From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH 4/4] git-am: Adding tests for `--keep-cr`, `--no-keep-cr` and `am.keepcr`.
Date: Sat, 27 Feb 2010 15:20:28 +0100
Message-ID: <1267280428-18223-5-git-send-email-stefan.hahn@s-hahn.de>
References: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 15:21:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlNXc-0008BS-GM
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 15:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968389Ab0B0OUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 09:20:53 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:53032 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968373Ab0B0OUw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 09:20:52 -0500
Received: from scotty.home (port-92-203-94-156.dynamic.qsc.de [92.203.94.156])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MZ9Wi-1O1wS53Kw8-00L02F; Sat, 27 Feb 2010 15:20:50 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1REKmVZ019226;
	Sat, 27 Feb 2010 15:20:48 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1REKmrd019222;
	Sat, 27 Feb 2010 15:20:48 +0100
X-Mailer: git-send-email 1.7.0.98.g42448
In-Reply-To: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX1/C8Ic+dZS/2eBQnTYhPSNFH6B+NGH3t/AGOFy
 LRaTTGVtovG9mhhNdJstDI2SmxHim0/lORddUtqwTiQ/FJoNQw
 lMi/a38WBHYUL5/X8MgCA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141213>

This test adds tests for git-am using files with dos line endings for
various combinations of `--keep-cr`, `--no-keep-cr` and `am.keepcr`.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---
 t/t4253-am-keep-cr-dos.sh |   96 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)
 create mode 100755 t/t4253-am-keep-cr-dos.sh

diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
new file mode 100755
index 0000000..6c4cb35
--- /dev/null
+++ b/t/t4253-am-keep-cr-dos.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Stefan-W. Hahn
+#
+
+test_description='git-am mbox with dos line ending.
+
+'
+. ./test-lib.sh
+
+# Three patches which will be added as files with dos line ending.
+
+cat > file1 <<\EOF
+line 1
+EOF
+
+cat > file1a <<\EOF
+line 1
+line 4
+EOF
+
+cat > file2 <<\EOF
+line 1
+line 2
+EOF
+
+cat > file3 <<\EOF
+line 1
+line 2
+line 3
+EOF
+
+test_expect_success 'setup repository with dos files' '
+        append_cr <file1 >file &&
+        git add file &&
+        git commit -m Initial &&
+        git tag initial &&
+        append_cr <file2 >file &&
+        git commit -a -m Second &&
+        append_cr <file3 >file &&
+        git commit -a -m Third
+'
+
+test_expect_success 'am with dos files without --keep-cr' '
+        git checkout -b dosfiles initial &&
+        git format-patch -k initial..master &&
+        test_must_fail git am -k -3 000*.patch &&
+        git am --abort &&
+        rm -rf .git/rebase-apply 000*.patch
+'
+
+test_expect_success 'am with dos files with --keep-cr' '
+        git checkout -b dosfiles-keep-cr initial &&
+        git format-patch -k --stdout initial..master | git am --keep-cr -k -3 &&
+        git diff --exit-code master
+'
+
+test_expect_success 'am with dos files config am.keepcr' '
+        git config am.keepcr 1 &&
+        git checkout -b dosfiles-conf-keepcr initial &&
+        git format-patch -k --stdout initial..master | git am -k -3 &&
+        git diff --exit-code master
+'
+
+test_expect_success 'am with dos files config am.keepcr overriden by --no-keep-cr' '
+        git config am.keepcr 1 &&
+        git checkout -b dosfiles-conf-keepcr-override initial &&
+        git format-patch -k initial..master &&
+        test_must_fail git am -k -3 --no-keep-cr 000*.patch &&
+        git am --abort &&
+        rm -rf .git/rebase-apply 000*.patch
+'
+
+test_expect_success 'am with dos files with --keep-cr continue' '
+        git checkout -b dosfiles-keep-cr-continue initial &&
+        git format-patch -k initial..master &&
+        append_cr <file1a >file &&
+        git commit -m "different patch" file &&
+        test_must_fail git am --keep-cr -k -3 000*.patch &&
+        append_cr <file2 >file &&
+        git add file &&
+        git am -3 --resolved &&
+        git diff --exit-code master
+'
+
+test_expect_success 'am with unix files config am.keepcr overriden by --no-keep-cr' '
+        git config am.keepcr 1 &&
+        git checkout -b unixfiles-conf-keepcr-override initial &&
+        cp -f file1 file &&
+        git commit -m "line ending to unix" file &&
+        git format-patch -k initial..master &&
+        git am -k -3 --no-keep-cr 000*.patch &&
+        git diff --exit-code -w master
+'
+
+test_done
-- 
1.7.0.98.g42448
