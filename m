From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Add a testcase for the safety of pull-policy='pull'.
Date: Sun, 25 Feb 2007 23:11:33 +0100
Message-ID: <20070225220853.31361.7201.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 25 23:11:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLRap-0000zo-NY
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 23:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbXBYWLl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 17:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbXBYWLl
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 17:11:41 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:34723 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965158AbXBYWLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 17:11:39 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 93E1F59C9D;
	Sun, 25 Feb 2007 23:11:38 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 684751F084;
	Sun, 25 Feb 2007 23:11:33 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40580>


This testcase demonstrates a long-standing problem with the handling
of conflicts on a rewinding branch, when "stg pull" calls git-pull.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

This is precisely the problem that made me believe using "git-pull"
was a wrong idea to start with.  Since it seems there are uses for the
"git-pull" mode, this particular issue has to be addressed - I'm
however not sure how.

 t/t2101-pull-policy-pull.sh   |   60 ++++++++++++++++++++++++++++++++++
 t/t2102-pull-policy-rebase.sh |   72 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 0 deletions(-)

diff --git a/t/t2101-pull-policy-pull.sh b/t/t2101-pull-policy-pull.sh
new file mode 100755
index 0000000..368d7d4
--- /dev/null
+++ b/t/t2101-pull-policy-pull.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Yann Dirson
+#
+
+test_description='Excercise pull-policy "fetch-rebase".'
+
+. ./test-lib.sh
+
+# don't need this repo, but better not drop it, see t1100
+#rm -rf .git
+
+# Need a repo to clone
+test_create_repo upstream
+
+test_expect_success \
+    'Setup upstream repo, clone it, and add patches to the clone' \
+    '
+    (cd upstream && stg init) &&
+    stg clone upstream clone &&
+    (cd clone &&
+     git repo-config branch.master.stgit.pull-policy pull &&
+     git repo-config --list &&
+     stg new c1 -m c1 &&
+     echo a > file && stg add file && stg refresh
+    )
+    '
+
+test_expect_success \
+    'Add non-rewinding commit upstream and pull it from clone' \
+    '
+    (cd upstream && stg new u1 -m u1 &&
+     echo a > file2 && stg add file2 && stg refresh) &&
+    (cd clone && stg pull) &&
+     test -e clone/file2
+    '
+
+# note: with pre-1.5 Git the clone is not automatically recorded
+# as rewinding, and thus heads/origin is not moved, but the stack
+# is still correctly rebased
+
+test_expect_failure \
+    'Rewind/rewrite upstream commit and pull it from clone, without --merged' \
+    '
+    (cd upstream && echo b >> file2 && stg refresh) &&
+    (cd clone && stg pull)
+    '
+
+test_expect_success \
+    'Undo the conflicted pull' \
+    '(cd clone && stg push --undo)'
+
+test_expect_success \
+    'Pull the rewinded commit, with --merged' \
+    '
+    (cd clone && stg pull --merged) &&
+    test `wc -l <clone/file2` = 2
+    '
+
+test_done
diff --git a/t/t2102-pull-policy-rebase.sh b/t/t2102-pull-policy-rebase.sh
new file mode 100755
index 0000000..e1398a3
--- /dev/null
+++ b/t/t2102-pull-policy-rebase.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Yann Dirson
+#
+
+test_description='Excercise pull-policy "fetch-rebase".'
+
+. ./test-lib.sh
+
+# don't need this repo, but better not drop it, see t1100
+#rm -rf .git
+
+# Need a repo to clone
+test_create_repo upstream
+
+test_expect_success \
+    'Setup upstream repo, clone it, and add patches to the clone' \
+    '
+    (cd upstream && stg init) &&
+    stg clone upstream clone &&
+    (cd clone &&
+     git repo-config branch.master.stgit.pull-policy fetch-rebase &&
+     git repo-config --list &&
+     stg new c1 -m c1 &&
+     echo a > file && stg add file && stg refresh
+    )
+    '
+
+test_expect_success \
+    'Add non-rewinding commit upstream and pull it from clone' \
+    '
+    (cd upstream && stg new u1 -m u1 &&
+     echo a > file2 && stg add file2 && stg refresh) &&
+    (cd clone && stg pull) &&
+    test -e clone/file2
+    '
+
+# note: with pre-1.5 Git the clone is not automatically recorded
+# as rewinding, and thus heads/origin is not moved, but the stack
+# is still correctly rebased
+test_expect_success \
+    'Rewind/rewrite upstream commit and pull it from clone' \
+    '
+    (cd upstream && echo b >> file2 && stg refresh) &&
+    (cd clone && stg pull) &&
+    test `wc -l <clone/file2` = 2
+    '
+
+# this one ensures the guard against commits does not unduly trigger
+test_expect_success \
+    'Rewind/rewrite upstream commit and fetch it from clone before pulling' \
+    '
+    (cd upstream && echo c >> file2 && stg refresh) &&
+    (cd clone && git fetch && stg pull) &&
+    test `wc -l <clone/file2` = 3
+    '
+
+# this one exercises the guard against commits
+# (use a new file to avoid mistaking a conflict for a success)
+test_expect_success \
+    'New upstream commit and commit a patch in clone' \
+    '
+    (cd upstream && stg new u2 -m u2 &&
+     echo a > file3 && stg add file3 && stg refresh) &&
+    (cd clone && stg commit && stg new c2 -m c2 &&
+     echo a >> file && stg refresh)
+    '
+test_expect_failure \
+    'Try to  and commit a patch in clone' \
+    '(cd clone && stg pull)'
+
+test_done
