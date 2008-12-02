From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH] Print conflict details with the new infrastructure (bug
	#11181)
Date: Tue, 02 Dec 2008 14:40:45 +0000
Message-ID: <20081202144045.24372.69278.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 15:42:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7WSP-0000oC-DO
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 15:42:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbYLBOkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 09:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754421AbYLBOku
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 09:40:50 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:9474 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755091AbYLBOkt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2008 09:40:49 -0500
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20081202144048.GWXW1717.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Tue, 2 Dec 2008 14:40:48 +0000
Received: from localhost.localdomain ([86.9.203.187])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20081202144047.IKVG2093.aamtaout03-winn.ispmail.ntl.com@localhost.localdomain>;
          Tue, 2 Dec 2008 14:40:47 +0000
User-Agent: StGit/0.14.3.290.g44ed
X-Cloudmark-Analysis: v=1.0 c=1 a=RBDifTlguUkA:10 a=bi3KFHPoJpwA:10 a=pGLkceISAAAA:8 a=IMDknEi_ueMbkkt5XyAA:9 a=qywoG7HkpjMDGe2chAYA:7 a=KBi2AT_gxN4uuA4pMCQZn_f5-zcA:4 a=XF7b4UCPwd8A:10 a=b5Ty8kZ7TbYA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102138>

The patch modifies the IndexAndWorkTree.merge() function to display
pass the conflict information (files) when raising an exception. The
logic is similar to the one in the old infrastructure.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/lib/git.py         |   14 +++++++++-----
 stgit/lib/transaction.py |    8 +++++---
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 0a208ef..6457893 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -829,12 +829,16 @@ class IndexAndWorktree(RunWithEnvCwd):
                          env = { 'GITHEAD_%s' % base.sha1: 'ancestor',
                                  'GITHEAD_%s' % ours.sha1: 'current',
                                  'GITHEAD_%s' % theirs.sha1: 'patched'})
-            r.discard_output()
+            r.returns([0, 1])
+            output = r.output_lines()
+            if r.exitcode:
+                # There were conflicts
+                conflicts = [l for l in output if l.startswith('CONFLICT')]
+                err = '%d conflict(s)\n%s' \
+                        % (len(conflicts), ''.join(conflicts))
+                raise MergeConflictException(err)
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
index 0f414d8..b8e82b6 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -201,7 +201,8 @@ class StackTransaction(object):
             self.__stack.set_head(new_head, self.__msg)
 
         if self.__error:
-            out.error(self.__error)
+            error_lines = self.__error.split('\n')
+            out.error(*error_lines)
 
         # Write patches.
         def write(msg):
@@ -311,9 +312,10 @@ class StackTransaction(object):
                 tree = iw.index.write_tree()
                 self.__current_tree = tree
                 s = ' (modified)'
-            except git.MergeConflictException:
+            except git.MergeConflictException, e:
                 tree = ours
                 merge_conflict = True
+                conflict_error = str(e)
                 s = ' (conflict)'
             except git.MergeException, e:
                 self.__halt(str(e))
@@ -344,7 +346,7 @@ class StackTransaction(object):
 
             # Save this update so that we can run it a little later.
             self.__conflicting_push = update
-            self.__halt('Merge conflict')
+            self.__halt(conflict_error)
         else:
             # Update immediately.
             update()
