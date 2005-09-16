From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 07/11] Implement fast-forward when only tree (but not commits) match
Date: Fri, 16 Sep 2005 21:35:20 +0200
Message-ID: <20050916193520.18681.36248.stgit@zion.home.lan>
References: <20050916193511.18681.24189.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:39:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGM2L-0005kZ-RX
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbVIPTiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965300AbVIPTiP
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:38:15 -0400
Received: from ppp-62-11-79-165.dialup.tiscali.it ([62.11.79.165]:25739 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751245AbVIPTiO
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:38:14 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 41DAD28611;
	Fri, 16 Sep 2005 21:35:20 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20050916193511.18681.24189.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8716>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When the "bottom" commit and the HEAD don't match, but they refer to the
same tree (for instance after a refresh where only the description
changed), we can still fast-forward, by keeping the same top tree and
calling git-commit-tree (which only requires the tree object) with the new
parent. I've altered git.commit to allow this.

Btw, I've also avoided the use of .commitmsg and switched to piping the
description.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/git.py   |   30 ++++++++++++++++--------------
 stgit/stack.py |   35 +++++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -119,8 +119,12 @@ def _output(cmd):
         raise GitException, '%s failed' % str(cmd)
     return string
 
-def _output_one_line(cmd):
+def _output_one_line(cmd, file_desc = None):
     p=popen2.Popen3(cmd)
+    if file_desc != None:
+        for line in file_desc:
+            p.tochild.write(line)
+        p.tochild.close()
     string = p.fromchild.readline().strip()
     if p.wait():
         raise GitException, '%s failed' % str(cmd)
@@ -286,7 +290,7 @@ def update_cache(files = [], force = Fal
     return True
 
 def commit(message, files = [], parents = [], allowempty = False,
-           cache_update = True,
+           cache_update = True, tree_id = None,
            author_name = None, author_email = None, author_date = None,
            committer_name = None, committer_email = None):
     """Commit the current tree to repository
@@ -298,15 +302,15 @@ def commit(message, files = [], parents 
             raise GitException, 'No changes to commit'
 
     # get the commit message
-    f = file('.commitmsg', 'w+')
-    if message[-1:] == '\n':
-        f.write(message)
-    else:
-        print >> f, message
-    f.close()
+    if message[-1:] != '\n':
+        message += '\n'
 
+    must_switch = True
     # write the index to repository
-    tree_id = _output_one_line('git-write-tree')
+    if tree_id == None:
+        tree_id = _output_one_line('git-write-tree')
+    else:
+        must_switch = False
 
     # the commit
     cmd = ''
@@ -326,11 +330,9 @@ def commit(message, files = [], parents 
     for p in parents:
         cmd += ' -p %s' % p
 
-    cmd += ' < .commitmsg'
-
-    commit_id = _output_one_line(cmd)
-    __set_head(commit_id)
-    os.remove('.commitmsg')
+    commit_id = _output_one_line(cmd, message)
+    if must_switch:
+        __set_head(commit_id)
 
     return commit_id
 
diff --git a/stgit/stack.py b/stgit/stack.py
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -495,13 +495,40 @@ class Series:
             # top != bottom always since we have a commit for each patch
             if head == bottom:
                 # reset the backup information
-                patch.set_bottom(bottom, backup = True)
+                patch.set_bottom(head, backup = True)
                 patch.set_top(top, backup = True)
 
             else:
-                top = head
-                # stop the fast-forwarding, must do a real merge
-                break
+                head_tree = git.get_commit(head).get_tree()
+                bottom_tree = git.get_commit(bottom).get_tree()
+                if head_tree == bottom_tree:
+                    # We must just reparent this patch and create a new commit
+                    # for it
+                    descr = patch.get_description()
+                    author_name = patch.get_authname()
+                    author_email = patch.get_authemail()
+                    author_date = patch.get_authdate()
+                    committer_name = patch.get_commname()
+                    committer_email = patch.get_commemail()
+
+                    top_tree = git.get_commit(top).get_tree()
+
+                    top = git.commit(message = descr, parents = [head],
+                                     cache_update = False,
+                                     tree_id = top_tree,
+                                     allowempty = True,
+                                     author_name = author_name,
+                                     author_email = author_email,
+                                     author_date = author_date,
+                                     committer_name = committer_name,
+                                     committer_email = committer_email)
+
+                    patch.set_bottom(head, backup = True)
+                    patch.set_top(top, backup = True)
+                else:
+                    top = head
+                    # stop the fast-forwarding, must do a real merge
+                    break
 
             forwarded+=1
             unapplied.remove(name)
