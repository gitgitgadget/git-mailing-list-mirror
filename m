From: Charles Bailey <charles@hashpling.org>
Subject: [RFH] Add some very basic tests for git mergetool
Date: Sun, 17 Feb 2008 10:35:45 +0000
Message-ID: <20080217103545.GA24158@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 11:36:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQgso-0007qh-Jp
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 11:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbYBQKf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 05:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754861AbYBQKfz
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 05:35:55 -0500
Received: from pih-relay04.plus.net ([212.159.14.131]:57497 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828AbYBQKfy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 05:35:54 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1JQgsF-0007Kn-CC
	for git@vger.kernel.org; Sun, 17 Feb 2008 10:35:55 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1HAZjbl024536
	for <git@vger.kernel.org>; Sun, 17 Feb 2008 10:35:45 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1HAZjHR024535
	for git@vger.kernel.org; Sun, 17 Feb 2008 10:35:45 GMT
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: 72b0deba1a7b6b96e9901610bca3703c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74115>

---

I tried to add some basic tests for git mergetool but unfortunately I
hit a major stumbling block. I seem to have to include a delay in my
fake mergetool otherwise the cat command didn't seem to work. It was
as though the source file hadn't been writted out yet.

(Other more minor stumbling blocks are that mergetool is a fond user
of shell read and explicit /dev/tty which makes some paths not
testable.)

I'm not sure if there's a shell usleep instead of having to "sleep 1",
but to me, adding four seconds of doing nothing to a test is
completely unacceptable. Individually most of git's tests are very
fast which is very important as there are so many of them.

All suggestions are welcome, especially if they indicate a bug in my
mergetool changes, which other than in automated test, seem to work
well for me.

Charles.

 t/t7610-mergetool.sh |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100644 t/t7610-mergetool.sh

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
new file mode 100644
index 0000000..a883f03
--- /dev/null
+++ b/t/t7610-mergetool.sh
@@ -0,0 +1,57 @@
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
+    git config mergetool.mytool.cmd "sleep 1;cat \"\$REMOTE\" >\"\$MERGED\"" &&
+    git config mergetool.mytool.trustExitCode true &&
+    git checkout branch1 &&
+    ! git merge master >/dev/null 2>&1 &&
+    ( yes "" | git mergetool file1>/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file2>/dev/null 2>&1 ) &&
+    test "$(cat file1)" = "master updated" &&
+    test "$(cat file2)" = "master new" &&
+    git commit -m "branch1 resolved with mergetool"
+'
+
+test_expect_success 'custom mergetool' '
+    git config mergetool.mytool.cmdNoBase "sleep 1;cat \"\$LOCAL\" >\"\$MERGED\"" &&
+    git checkout branch2 &&
+    ! git merge master >/dev/null 2>&1 &&
+    ( yes "" | git mergetool file1>/dev/null 2>&1 ) &&
+    ( yes "" | git mergetool file2>/dev/null 2>&1 ) &&
+    test "$(cat file1)" = "master updated" &&
+    test "$(cat file2)" = "branch2 newfile" &&
+    git commit -m "branch2 resolved with mergetool"
+'
+
+test_done
-- 
1.5.4.1.34.g94bf
