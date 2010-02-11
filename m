From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Adding test for `--keep-cr` for git-mailsplit and git-am.
Date: Thu, 11 Feb 2010 19:14:26 +0100
Message-ID: <20100211181426.GE15028@scotty.home>
References: <1265911741-14840-1-git-send-email-stefan.hahn@s-hahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 19:14:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfdYh-0005B6-4d
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 19:14:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756727Ab0BKSOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 13:14:30 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:57727 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547Ab0BKSO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 13:14:29 -0500
Received: from scotty.home (port-92-203-5-233.dynamic.qsc.de [92.203.5.233])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MJYNz-1Nied63ybz-003Fqa; Thu, 11 Feb 2010 19:14:28 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.3/8.14.3/Debian-5) with ESMTP id o1BIEQ2r015196
	for <git@vger.kernel.org>; Thu, 11 Feb 2010 19:14:26 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.3/8.14.3/Submit) id o1BIEQ5q015194
	for git@vger.kernel.org; Thu, 11 Feb 2010 19:14:26 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
In-Reply-To: <1265911741-14840-1-git-send-email-stefan.hahn@s-hahn.de>
X-Mailer: git-send-email 1.7.0.rc1.50.g84249.dirty
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on scotty.home
X-Virus-Scanned: clamav-milter 0.95.3 at scotty
X-Virus-Status: Clean
X-Provags-ID: V01U2FsdGVkX19Uc0E9Z8GM7BnOKDqi7AaCUHyeP+99zPXGzKf
 yeKguaZvN0do0vjQoOVToiRDzPHady2rCP9MfDQi8zirCNfgGa
 5SifYJdOMUdqw8+xbGbsQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139614>

This test adds test for git-mailsplit using dos line endings, the
command sequence 'git format-patch ... | git am ...' and the
configuration variable `mailsplit.keep-cr`.

Signed-off-by: Stefan-W. Hahn <stefan.hahn@s-hahn.de>
---
 t/t5101-mailinfo-dos.sh |   75 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100644 t/t5101-mailinfo-dos.sh

diff --git a/t/t5101-mailinfo-dos.sh b/t/t5101-mailinfo-dos.sh
new file mode 100644
index 0000000..0afa713
--- /dev/null
+++ b/t/t5101-mailinfo-dos.sh
@@ -0,0 +1,75 @@
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
+# This primes main.c file that indents without using HT at all.
+# Various patches with HT and other spaces are attempted in the test.
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
+        git config mailsplit.keep-cr 1 &&
+        git checkout -b new3 start &&
+	git format-patch -k --stdout start..master | git am -k -3 &&
+        git diff master
+'
+
+test_done
-- 
1.7.0.rc1.50.g84249.dirty
