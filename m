From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH 4/4] Adding test for `--keep-cr` for git-mailsplit and git-am.
Date: Thu, 11 Feb 2010 22:26:19 +0100
Message-ID: <1265923579-24900-5-git-send-email-stefan.hahn@s-hahn.de>
References: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de>
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 22:27:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfgZZ-0005Cd-SW
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 22:27:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822Ab0BKV1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 16:27:11 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:55855 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186Ab0BKV1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 16:27:09 -0500
Received: from scotty.home (port-92-203-5-233.dynamic.qsc.de [92.203.5.233])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MfStn-1NMdLV0e31-00Oi25; Thu, 11 Feb 2010 22:27:06 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1BLR5Lr025045;
	Thu, 11 Feb 2010 22:27:05 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1BLR5qt025043;
	Thu, 11 Feb 2010 22:27:05 +0100
X-Mailer: git-send-email 1.7.0.rc2.17.g39385
In-Reply-To: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX19SiRRWgMz3WIrctaSQmP/LzaW4kSUIbyDltlh
 2YxQmzxISYs/oFsXDRW+rWRL2BenBXl69tD/nsawiV/tCTDmCR
 OX8S1066an1J8Tcg9pBjg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139634>

This test adds test for git-mailsplit using dos line endings, the
command sequence 'git format-patch ... | git am ...' and the
configuration variable `mailsplit.keepcr`.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---
 t/t5101-mailinfo-dos.sh |   74 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100644 t/t5101-mailinfo-dos.sh

diff --git a/t/t5101-mailinfo-dos.sh b/t/t5101-mailinfo-dos.sh
new file mode 100644
index 0000000..c6acd55
--- /dev/null
+++ b/t/t5101-mailinfo-dos.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Stefan-W. Hahn
+#
+
+test_description='git-mailsplit mbox with dos line ending.
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
+        append_cr <file1 >file
+        git add file &&
+        git commit -m Initial &&
+        git tag start &&
+        append_cr <file2 >file
+        git commit -a -m Second &&
+        git tag start2 &&
+        append_cr <file3 >file
+        git commit -a -m Third &&
+	git format-patch -k --stdout start.. > format-patch.diff
+'
+
+test_expect_failure 'mailsplit format-patch of dos files' '
+        mkdir split &&
+        git mailsplit -osplit format-patch.diff &&
+        cat split/0001 split/0002 > mailsplit.diff &&
+        test_cmp format-patch.diff mailsplit.diff
+'
+
+test_expect_success 'mailsplit --keep-cr format-patch of dos files' '
+        mkdir split2 &&
+        git mailsplit --keep-cr -osplit2 format-patch.diff &&
+        cat split2/0001 split2/0002 > mailsplit2.diff &&
+        test_cmp format-patch.diff mailsplit2.diff
+'
+
+test_expect_success 'format-patch with dos files --keep-cr' '
+        git checkout -b new start &&
+	git format-patch -k --stdout start..master | git am --keep-cr -k -3 &&
+        git diff master
+'
+
+test_expect_success 'format-patch with dos files -e' '
+        git checkout -b new2 start &&
+	git format-patch -k --stdout start..master | git am -e -k -3 &&
+        git diff master
+'
+
+test_expect_success 'format-patch with dos files config.mailsplit' '
+        git config mailsplit.keepcr 1 &&
+        git checkout -b new3 start &&
+	git format-patch -k --stdout start..master | git am -k -3 &&
+        git diff master
+'
+
+test_done
-- 
1.7.0.rc2.17.g39385
