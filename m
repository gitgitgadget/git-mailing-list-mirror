From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH] Add automatic git-mergetool invocation to the new
	infrastructure
Date: Tue, 10 Feb 2009 14:14:07 +0000
Message-ID: <20090210141157.28782.10027.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 15:15:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWtOr-0004S7-3y
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 15:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262AbZBJOOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 09:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755155AbZBJOOS
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 09:14:18 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:47392 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754988AbZBJOOR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 09:14:17 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n1AECWZm016936;
	Tue, 10 Feb 2009 14:12:32 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 10 Feb 2009 14:14:12 +0000
User-Agent: StGit/0.14.3.346.g5c97
X-OriginalArrivalTime: 10 Feb 2009 14:14:12.0675 (UTC) FILETIME=[D926D130:01C98B89]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109242>

A subsequent patch will remove the i3merge and i2merge customisation
from the classic infrastructure and config files. The main difference
with the classic implementation is that mergetool is no invoked from the
Transaction.push_patch() function rather than directly from
IndexAndWorktree.merge().

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

I'm still not entirely sure where the check for stgit.autoimerge should
be done. In the classic infrastructure, it is done in the merge
function. With this patch, it is done in Transaction.push(). Should we
push this even further to stgit.commands.push? My opinion is not since
by having it in Transaction we get the advantage not listing the
conflicts if the mergetool succeeds and we don't need to abort the
transaction.


 stgit/lib/git.py         |    6 ++++++
 stgit/lib/transaction.py |   18 +++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 07079b8..04c1fa5 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -842,6 +842,12 @@ class IndexAndWorktree(RunWithEnvCwd):
                 raise MergeConflictException(conflicts)
         except run.RunException, e:
             raise MergeException('Index/worktree dirty')
+    def mergetool(self, files = []):
+        """Invoke 'git mergetool' on the current IndexAndWorktree to resolve
+        any outstanding conflicts."""
+        err = os.system('git mergetool %s' % ' '.join(files))
+        if err:
+            raise MergeException('"git mergetool" failed, exit code: %d' % err)
     def changed_files(self, tree, pathlimits = []):
         """Return the set of files in the worktree that have changed with
         respect to C{tree}. The listing is optionally restricted to
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 5a81f9d..c1c9125 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -8,6 +8,7 @@ from stgit import exception, utils
 from stgit.utils import any, all
 from stgit.out import *
 from stgit.lib import git, log
+from stgit.config import config
 
 class TransactionException(exception.StgException):
     """Exception raised when something goes wrong with a
@@ -324,10 +325,21 @@ class StackTransaction(object):
                 self.__current_tree = tree
                 s = ' (modified)'
             except git.MergeConflictException, e:
-                tree = ours
                 merge_conflict = True
-                self.__conflicts = e.conflicts
-                s = ' (conflict)'
+                if config.get('stgit.autoimerge') == 'yes':
+                    try:
+                        iw.mergetool()
+                        merge_conflict = False
+                    except git.MergeException:
+                        pass
+                if merge_conflict:
+                    tree = ours
+                    self.__conflicts = e.conflicts
+                    s = ' (conflict)'
+                else:
+                    tree = iw.index.write_tree()
+                    self.__current_tree = tree
+                    s = ' (modified)'
             except git.MergeException, e:
                 self.__halt(str(e))
         cd = cd.set_tree(tree)
