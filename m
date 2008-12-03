From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH] Print conflict details with the new infrastructure (bug
	#11181)
Date: Wed, 03 Dec 2008 21:38:13 +0000
Message-ID: <20081203213813.9924.62751.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 22:39:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7zRY-0001cs-RD
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 22:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbYLCViT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 16:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbYLCViT
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 16:38:19 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:15321 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750770AbYLCViS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 16:38:18 -0500
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20081203213816.YWJZ1717.mtaout02-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Wed, 3 Dec 2008 21:38:16 +0000
Received: from localhost.localdomain ([86.9.203.187])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20081203213816.UZDH19264.aamtaout01-winn.ispmail.ntl.com@localhost.localdomain>;
          Wed, 3 Dec 2008 21:38:16 +0000
User-Agent: StGit/0.14.3.290.g44ed
X-Cloudmark-Analysis: v=1.0 c=1 a=RBDifTlguUkA:10 a=bi3KFHPoJpwA:10 a=pGLkceISAAAA:8 a=D5pFM3QvYKuJDMg7VKcA:9 a=TMh7-S3zlc8eeMzTjxoA:7 a=aktxgMggdQ1d9vTgYTv65KDBvMMA:4 a=XF7b4UCPwd8A:10 a=b5Ty8kZ7TbYA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102292>

The patch modifies the IndexAndWorkTree.merge() function to display
pass the conflict information (files) when raising an exception. The
logic is similar to the one in the old infrastructure.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/lib/git.py         |   15 ++++++++++-----
 stgit/lib/transaction.py |   11 ++++++++---
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 0a208ef..e2b4266 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -677,6 +677,9 @@ class MergeException(exception.StgException):
 
 class MergeConflictException(MergeException):
     """Exception raised when a merge fails due to conflicts."""
+    def __init__(self, conflicts):
+        MergeException.__init__(self)
+        self.conflicts = conflicts
 
 class Index(RunWithEnv):
     """Represents a git index file."""
@@ -829,12 +832,14 @@ class IndexAndWorktree(RunWithEnvCwd):
                          env = { 'GITHEAD_%s' % base.sha1: 'ancestor',
                                  'GITHEAD_%s' % ours.sha1: 'current',
                                  'GITHEAD_%s' % theirs.sha1: 'patched'})
-            r.discard_output()
+            r.returns([0, 1])
+            output = r.output_lines()
+            if r.exitcode:
+                # There were conflicts
+                conflicts = [l for l in output if l.startswith('CONFLICT')]
+                raise MergeConflictException(conflicts)
         except run.RunException, e:
-            if r.exitcode == 1:
-                raise MergeConflictException()
-            else:
-                raise MergeException('Index/worktree dirty')
+            raise MergeException('Index/worktree dirty')
     def changed_files(self, tree, pathlimits = []):
         """Return the set of files in the worktree that have changed with
         respect to C{tree}. The listing is optionally restricted to
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 0f414d8..54de127 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -94,6 +94,7 @@ class StackTransaction(object):
         self.__base = self.__stack.base
         self.__discard_changes = discard_changes
         self.__bad_head = None
+        self.__conflicts = None
         if isinstance(allow_conflicts, bool):
             self.__allow_conflicts = lambda trans: allow_conflicts
         else:
@@ -201,7 +202,10 @@ class StackTransaction(object):
             self.__stack.set_head(new_head, self.__msg)
 
         if self.__error:
-            out.error(self.__error)
+            if self.__conflicts:
+                out.error(*([self.__error] + self.__conflicts))
+            else:
+                out.error(self.__error)
 
         # Write patches.
         def write(msg):
@@ -311,9 +315,10 @@ class StackTransaction(object):
                 tree = iw.index.write_tree()
                 self.__current_tree = tree
                 s = ' (modified)'
-            except git.MergeConflictException:
+            except git.MergeConflictException, e:
                 tree = ours
                 merge_conflict = True
+                self.__conflicts = e.conflicts
                 s = ' (conflict)'
             except git.MergeException, e:
                 self.__halt(str(e))
@@ -344,7 +349,7 @@ class StackTransaction(object):
 
             # Save this update so that we can run it a little later.
             self.__conflicting_push = update
-            self.__halt('Merge conflict')
+            self.__halt("%d merge conflict(s)" % len(self.__conflicts))
         else:
             # Update immediately.
             update()
