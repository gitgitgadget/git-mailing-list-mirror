From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] Fixed t2102-pull-policy-rebase to really test 'rebase'
	policy.
Date: Sun, 11 Mar 2007 22:44:17 +0100
Message-ID: <20070311214417.3142.16353.stgit@gandelf.nowhere.earth>
References: <20070311214133.3142.11407.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:45:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQVqf-0006Lq-KM
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 22:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932859AbXCKVoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 17:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932849AbXCKVoz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 17:44:55 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58322 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932859AbXCKVoy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 17:44:54 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 0F16B399C;
	Sun, 11 Mar 2007 22:44:53 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 4D4E01F083;
	Sun, 11 Mar 2007 22:44:17 +0100 (CET)
In-Reply-To: <20070311214133.3142.11407.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41993>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 t/t2102-pull-policy-rebase.sh |   79 ++++++++++++++++++-----------------------
 1 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/t/t2102-pull-policy-rebase.sh b/t/t2102-pull-policy-rebase.sh
index e1398a3..41f8168 100755
--- a/t/t2102-pull-policy-rebase.sh
+++ b/t/t2102-pull-policy-rebase.sh
@@ -3,70 +3,61 @@
 # Copyright (c) 2007 Yann Dirson
 #
 
-test_description='Excercise pull-policy "fetch-rebase".'
+test_description='Excercise pull-policy "rebase".'
 
 . ./test-lib.sh
 
-# don't need this repo, but better not drop it, see t1100
-#rm -rf .git
-
-# Need a repo to clone
-test_create_repo upstream
-
-test_expect_success \
-    'Setup upstream repo, clone it, and add patches to the clone' \
-    '
-    (cd upstream && stg init) &&
-    stg clone upstream clone &&
-    (cd clone &&
-     git repo-config branch.master.stgit.pull-policy fetch-rebase &&
-     git repo-config --list &&
-     stg new c1 -m c1 &&
-     echo a > file && stg add file && stg refresh
-    )
-    '
-
 test_expect_success \
-    'Add non-rewinding commit upstream and pull it from clone' \
+    'Fork stack off parent branch, and add patches to the stack' \
     '
-    (cd upstream && stg new u1 -m u1 &&
-     echo a > file2 && stg add file2 && stg refresh) &&
-    (cd clone && stg pull) &&
-    test -e clone/file2
+    stg init &
+    git branch -m master parent &&
+    stg branch --create stack &&
+    git repo-config branch.stack.stgit.pull-policy rebase &&
+    git repo-config --list &&
+    stg new c1 -m c1 &&
+    echo a > file && stg add file && stg refresh
     '
 
-# note: with pre-1.5 Git the clone is not automatically recorded
-# as rewinding, and thus heads/origin is not moved, but the stack
-# is still correctly rebased
 test_expect_success \
-    'Rewind/rewrite upstream commit and pull it from clone' \
+    'Add non-rewinding commit in parent and pull the stack' \
     '
-    (cd upstream && echo b >> file2 && stg refresh) &&
-    (cd clone && stg pull) &&
-    test `wc -l <clone/file2` = 2
+    stg branch parent && stg new u1 -m u1 &&
+    echo b > file2 && stg add file2 && stg refresh &&
+    stg branch stack && stg pull &&
+    test -e file2
     '
 
-# this one ensures the guard against commits does not unduly trigger
 test_expect_success \
-    'Rewind/rewrite upstream commit and fetch it from clone before pulling' \
+    'Rewind/rewrite commit in parent and pull the stack' \
     '
-    (cd upstream && echo c >> file2 && stg refresh) &&
-    (cd clone && git fetch && stg pull) &&
-    test `wc -l <clone/file2` = 3
+    stg branch parent && echo b >> file2 && stg refresh &&
+    stg branch stack && stg pull &&
+    test `wc -l <file2` = 2
     '
 
 # this one exercises the guard against commits
 # (use a new file to avoid mistaking a conflict for a success)
 test_expect_success \
-    'New upstream commit and commit a patch in clone' \
+    'New commit in parent and commit a patch in stack' \
     '
-    (cd upstream && stg new u2 -m u2 &&
-     echo a > file3 && stg add file3 && stg refresh) &&
-    (cd clone && stg commit && stg new c2 -m c2 &&
-     echo a >> file && stg refresh)
+    stg branch parent && stg new u2 -m u2 &&
+     echo c > file3 && stg add file3 && stg refresh &&
+    stg branch stack && stg commit && stg new c2 -m c2 &&
+     echo a >> file && stg refresh
     '
 test_expect_failure \
-    'Try to  and commit a patch in clone' \
-    '(cd clone && stg pull)'
+    'Try to pull/rebase now that stack base has moved' \
+    'stg pull'
+
+test_expect_success \
+    'Force the pull/rebase, but do not push yet' \
+    'stg pull --force --nopush'
+test_expect_failure \
+    '...check we lost the committed patch' \
+    'test -e file'
+test_expect_failure \
+    '...and check we get a conflict while pushing' \
+    'stg push'
 
 test_done
