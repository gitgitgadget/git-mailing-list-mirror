From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 4/4] Add a very basic test script for git mergetool
Date: Thu, 21 Feb 2008 23:31:56 +0000
Message-ID: <75cca7ef76ce7cb0453ae2d940751dd1957b2075.1203636096.git.charles@hashpling.org>
References: <e6d984bbbb5d4dab54c38caa5c0c71b060d69156.1203636096.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:33:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSKvI-0007kX-A0
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 00:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763620AbYBUXcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 18:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762746AbYBUXcw
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 18:32:52 -0500
Received: from pih-relay08.plus.net ([212.159.14.134]:52922 "EHLO
	pih-relay08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762525AbYBUXcv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 18:32:51 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1JSKuH-0003XT-1S; Thu, 21 Feb 2008 23:32:49 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1LNVuJR012862;
	Thu, 21 Feb 2008 23:31:56 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1LNVuaC012861;
	Thu, 21 Feb 2008 23:31:56 GMT
Content-Disposition: inline
In-Reply-To: <e6d984bbbb5d4dab54c38caa5c0c71b060d69156.1203636096.git.charles@hashpling.org>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: 33402e64e9d95a6a00b0f87adbf2ceda
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74681>

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 t/t7610-mergetool.sh |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100644 t/t7610-mergetool.sh

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
new file mode 100644
index 0000000..6b0483f
--- /dev/null
+++ b/t/t7610-mergetool.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Charles Bailey
+#
+
+test_description='git-mergetool
+
+Testing basic merge tool invocation'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+    echo master >file1 &&
+    git add file1 &&
+    git commit -m "added file1" &&
+    git checkout -b branch1 master &&
+    echo branch1 change >file1 &&
+    echo branch1 newfile >file2 &&
+    git add file1 file2 &&
+    git commit -m "branch1 changes" &&
+    git checkout -b branch2 master &&
+    echo branch2 change >file1 &&
+    echo branch2 newfile >file2 &&
+    git add file1 file2 &&
+    git commit -m "branch2 changes" &&
+    git checkout master &&
+    echo master updated >file1 &&
+    echo master new >file2 &&
+    git add file1 file2 &&
+    git commit -m "master updates"
+'
+
+test_expect_success 'custom mergetool' '
+    git config merge.tool mytool &&
+    git config mergetool.mytool.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
+    git config mergetool.mytool.trustExitCode true &&
+	git checkout branch1 &&
+    ! git merge master >/dev/null 2>&1 &&
+    ( yes "" | git mergetool file1>/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file2>/dev/null 2>&1 ) &&
+    test "$(cat file1)" = "master updated" &&
+    test "$(cat file2)" = "master new" &&
+	git commit -m "branch1 resolved with mergetool"
+'
+
+test_done
-- 
1.5.4.2.133.g3d51e


-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
