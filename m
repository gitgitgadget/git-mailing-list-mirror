From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/3] add tests for merging with submodules
Date: Sun,  5 Apr 2009 02:46:58 +0200
Message-ID: <1238892420-721-2-git-send-email-drizzd@aon.at>
References: <20090401180627.GA14716@localhost>
 <1238892420-721-1-git-send-email-drizzd@aon.at>
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Michael Johnson <redbeard@mdjohnson.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 02:48:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqGXO-0004hw-Fh
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 02:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179AbZDEArF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 20:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755772AbZDEArE
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 20:47:04 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:51887 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352AbZDEArD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 20:47:03 -0400
Received: from darc.dyndns.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 5 Apr 2009 02:46:57 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LqGVo-0000CV-D9; Sun, 05 Apr 2009 02:47:00 +0200
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1238892420-721-1-git-send-email-drizzd@aon.at>
X-OriginalArrivalTime: 05 Apr 2009 00:46:57.0918 (UTC) FILETIME=[0617E9E0:01C9B588]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115612>


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t7405-submodule-merge.sh |   74 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100755 t/t7405-submodule-merge.sh

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
new file mode 100755
index 0000000..9778ad4
--- /dev/null
+++ b/t/t7405-submodule-merge.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+test_description='merging with submodules'
+
+. ./test-lib.sh
+
+#
+# history
+#
+#        a --- c
+#      /   \ /
+# root      X
+#      \   / \
+#        b --- d
+#
+
+test_expect_success setup '
+
+	mkdir sub &&
+	(cd sub &&
+	 git init &&
+	 echo original > file &&
+	 git add file &&
+	 test_tick &&
+	 git commit -m sub-root) &&
+	git add sub &&
+	test_tick &&
+	git commit -m root &&
+
+	git checkout -b a master &&
+	(cd sub &&
+	 echo A > file &&
+	 git add file &&
+	 test_tick &&
+	 git commit -m sub-a) &&
+	git add sub &&
+	test_tick &&
+	git commit -m a &&
+
+	git checkout -b b master &&
+	(cd sub &&
+	 echo B > file &&
+	 git add file &&
+	 test_tick &&
+	 git commit -m sub-b) &&
+	git add sub &&
+	test_tick &&
+	git commit -m b
+
+	git checkout -b c a &&
+	git merge -s ours b &&
+
+	git checkout -b d b &&
+	git merge -s ours a
+'
+
+test_expect_failure 'merging with modify/modify conflict' '
+
+	git checkout -b test1 a &&
+	test_must_fail git merge b &&
+	test -f .git/MERGE_MSG &&
+	git diff
+
+'
+
+test_expect_failure 'merging with a modify/modify conflict between merge bases' '
+
+	git reset --hard HEAD &&
+	git checkout -b test2 c &&
+	git merge d
+
+'
+
+test_done
-- 
1.6.2.1
