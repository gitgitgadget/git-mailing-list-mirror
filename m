From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: [PATCH 3/3] Adding test for `--keep-cr` for git-am.
Date: Sat, 13 Feb 2010 18:11:32 +0100
Message-ID: <20100213171132.GC14754@scotty.home>
References: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 18:11:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgLX0-00075B-6c
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 18:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757586Ab0BMRLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 12:11:35 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:52091 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757426Ab0BMRLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 12:11:34 -0500
Received: from scotty.home (port-92-203-27-201.dynamic.qsc.de [92.203.27.201])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0Lvywf-1Nluzw0Hyn-018MSZ; Sat, 13 Feb 2010 18:11:33 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1DHBWs1025962;
	Sat, 13 Feb 2010 18:11:32 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1DHBWW7025960;
	Sat, 13 Feb 2010 18:11:32 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
X-Mailer: git-send-email 1.7.0.rc2.31.g49e2a
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX18rod/tUHy020x+vQDzwgwNb16qySrFtTz52tS
 GPu5dZznV/tAc3T7FgY1VqOV/bV4AAOjR/cMVhIHly4QKsE9Gp
 Wo+y5GXW3o6H5Ay2nzyWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139814>

This test adds test for git-am dos line endings, the command sequence
'git format-patch ... | git am ...' and the configuration variable
`am.keepcr`.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---
 t/t4253-am-keep-cr-dos.sh |   68 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100644 t/t4253-am-keep-cr-dos.sh

diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
new file mode 100644
index 0000000..a4f5f80
--- /dev/null
+++ b/t/t4253-am-keep-cr-dos.sh
@@ -0,0 +1,68 @@
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
+test_expect_success 'mailsplit format-patch of dos files' '
+        mkdir split &&
+        git mailsplit -osplit format-patch.diff &&
+        cat split/0001 split/0002 > mailsplit.diff &&
+        test_must_fail test_cmp format-patch.diff mailsplit.diff
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
+test_expect_success 'format-patch with dos files config.mailsplit' '
+        git config am.keepcr 1 &&
+        git checkout -b new3 start &&
+	git format-patch -k --stdout start..master | git am -k -3 &&
+        git diff master
+'
+
+test_done
-- 
1.7.0.rc2.31.g49e2a
