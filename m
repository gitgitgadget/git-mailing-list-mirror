From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 1/5] Rename Repository.head to Repository.head_ref
Date: Fri, 06 Jun 2008 21:45:37 +0100
Message-ID: <20080606204537.8805.12051.stgit@localhost.localdomain>
References: <20080606204322.8805.32313.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 22:47:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4iqN-0001dA-9z
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 22:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbYFFUpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 16:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764598AbYFFUpn
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 16:45:43 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:41253 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751553AbYFFUpl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 16:45:41 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080606204959.YPMM7070.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Fri, 6 Jun 2008 21:49:59 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080606204837.IRKI29365.aamtaout02-winn.ispmail.ntl.com@localhost.localdomain>;
          Fri, 6 Jun 2008 21:48:37 +0100
In-Reply-To: <20080606204322.8805.32313.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.2.168.ge637
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84108>

This is to avoid confusion with the Stack.head function which returns
a commit object rather than a file name. The patch also changes the
"new" function to use stack.head directly rather than via the
Repository.refs... object.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/commands/new.py |    3 +--
 stgit/lib/git.py      |    4 ++--
 stgit/lib/stack.py    |    2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 15bb2e0..c4ee4e1 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -58,9 +58,8 @@ def func(parser, options, args):
     else:
         parser.error('incorrect number of arguments')
 
-    head = directory.repository.refs.get(directory.repository.head)
     cd = gitlib.CommitData(
-        tree = head.data.tree, parents = [head], message = '',
+        tree = stack.head.data.tree, parents = [stack.head], message = '',
         author = gitlib.Person.author(), committer = gitlib.Person.committer())
 
     # Set patch commit message from commandline.
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index c9f01e3..fd66f6d 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -443,13 +443,13 @@ class Repository(RunWithEnv):
                                                 ).output_one_line()
         return self.get_commit(sha1)
     @property
-    def head(self):
+    def head_ref(self):
         try:
             return self.run(['git', 'symbolic-ref', '-q', 'HEAD']
                             ).output_one_line()
         except run.RunException:
             raise DetachedHeadException()
-    def set_head(self, ref, msg):
+    def set_head_ref(self, ref, msg):
         self.run(['git', 'symbolic-ref', '-m', msg, 'HEAD', ref]).no_output()
     def simple_merge(self, base, ours, theirs):
         """Given three L{Tree}s, tries to do an in-index merge with a
diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index bdd21b1..b1544a5 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -178,7 +178,7 @@ class Repository(git.Repository):
         self.__stacks = {} # name -> Stack
     @property
     def current_branch(self):
-        return utils.strip_leading('refs/heads/', self.head)
+        return utils.strip_leading('refs/heads/', self.head_ref)
     @property
     def current_stack(self):
         return self.get_stack()
