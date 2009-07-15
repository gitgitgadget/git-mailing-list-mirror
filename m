From: Karl Wiberg <kha@treskal.com>
Subject: [StGit PATCH] t2800: Adapt to changes in git's conflict markers
Date: Wed, 15 Jul 2009 11:54:08 +0200
Message-ID: <20090715095312.1705.13477.stgit@october.e.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 12:16:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR1WY-0003kn-4c
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 12:15:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926AbZGOKPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 06:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbZGOKPQ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 06:15:16 -0400
Received: from vtab.com ([62.20.90.195]:38250 "EHLO oden.vtab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753857AbZGOKPN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 06:15:13 -0400
X-Greylist: delayed 1263 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2009 06:15:13 EDT
Received: from oden.vtab.com (oden.vtab.com [127.0.0.1])
	by oden.vtab.com (Postfix) with ESMTP id 6A4B426EF5E;
	Wed, 15 Jul 2009 11:54:08 +0200 (CEST)
Received: from october.e.vtech (october.e.vtech [10.40.0.158])
	by oden.vtab.com (Postfix) with ESMTP id 555DD26EF49;
	Wed, 15 Jul 2009 11:54:08 +0200 (CEST)
User-Agent: StGit/0.14.3.403.g20ff7
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123296>

From: Karl Wiberg <kha@treskal.com>

The conflict markers used by git were changed slightly by commit
606475f3 ("Remove filename from conflict markers"); specifically, the
conflict markers contain the filename only when the filename has
changed.

This patch adapts t2800 to allow either the new or the old format.

Signed-off-by: Karl Wiberg <kha@treskal.com>

---

 t/t2800-goto-subdir.sh |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)


diff --git a/t/t2800-goto-subdir.sh b/t/t2800-goto-subdir.sh
index 855972b..5960bd6 100755
--- a/t/t2800-goto-subdir.sh
+++ b/t/t2800-goto-subdir.sh
@@ -36,7 +36,8 @@ test_expect_success 'Prepare conflicting goto' '
     stg delete p2
 '
 
-cat > expected1.txt <<EOF
+# git gives this result before commit 606475f3 ...
+cat > expected1a.txt <<EOF
 foo1
 <<<<<<< current:foo/bar
 =======
@@ -44,6 +45,17 @@ foo2
 foo3
 >>>>>>> patched:foo/bar
 EOF
+
+# ... and this result after commit 606475f3.
+cat > expected1b.txt <<EOF
+foo1
+<<<<<<< current
+=======
+foo2
+foo3
+>>>>>>> patched
+EOF
+
 cat > expected2.txt <<EOF
 bar
 EOF
@@ -51,7 +63,8 @@ test_expect_success 'Goto in subdirectory (conflicting push)' '
     (cd foo && stg goto --keep p3) ;
     [ $? -eq 3 ] &&
     cat foo/bar > actual.txt &&
-    test_cmp expected1.txt actual.txt &&
+    ( test_cmp expected1a.txt actual.txt \
+      || test_cmp expected1b.txt actual.txt ) &&
     ls foo > actual.txt &&
     test_cmp expected2.txt actual.txt
 '
