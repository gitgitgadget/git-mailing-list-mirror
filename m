From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 2/5] Create a git.Branch class as ancestor of stack.Stack
Date: Fri, 06 Jun 2008 21:45:45 +0100
Message-ID: <20080606204545.8805.29222.stgit@localhost.localdomain>
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
	id 1K4iqN-0001dA-TO
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 22:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764721AbYFFUpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 16:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764833AbYFFUpv
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 16:45:51 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:41285 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764721AbYFFUpu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 16:45:50 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080606205007.YPNY7070.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Fri, 6 Jun 2008 21:50:07 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout04-winn.ispmail.ntl.com with ESMTP
          id <20080606204554.HZJL18637.aamtaout04-winn.ispmail.ntl.com@localhost.localdomain>;
          Fri, 6 Jun 2008 21:45:54 +0100
In-Reply-To: <20080606204322.8805.32313.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.2.168.ge637
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84109>

This class deals with Git-specific branch commands. The Stack class is a
direct child of Branch and some of its functionality was moved to the new
class.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/lib/git.py   |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 stgit/lib/stack.py |   27 ++++++--------------------
 2 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index fd66f6d..0e0cccb 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -28,6 +28,9 @@ class RepositoryException(exception.StgException):
     """Base class for all exceptions due to failed L{Repository}
     operations."""
 
+class BranchException(exception.StgException):
+    """Exception raised by failed L{Branch} operations."""
+
 class DateException(exception.StgException):
     """Exception raised when a date+time string could not be parsed."""
     def __init__(self, string, type):
@@ -379,6 +382,10 @@ class Repository(RunWithEnv):
         except run.RunException:
             raise RepositoryException('Cannot find git repository')
     @property
+    def current_branch_name(self):
+        """Return the name of the current branch."""
+        return utils.strip_leading('refs/heads/', self.head_ref)
+    @property
     def default_index(self):
         """An L{Index} object representing the default index file for the
         repository."""
@@ -619,3 +626,50 @@ class IndexAndWorktree(RunWithEnvCwd):
     def update_index(self, files):
         self.run(['git', 'update-index', '--remove', '-z', '--stdin']
                  ).input_nulterm(files).discard_output()
+
+class Branch(object):
+    """Represents a Git branch."""
+    def __init__(self, repository, name):
+        self.__repository = repository
+        self.__name = name
+        try:
+            self.head
+        except KeyError:
+            raise BranchException('%s: no such branch' % name)
+
+    name = property(lambda self: self.__name)
+    repository = property(lambda self: self.__repository)
+
+    def __ref(self):
+        return 'refs/heads/%s' % self.__name
+    @property
+    def head(self):
+        return self.__repository.refs.get(self.__ref())
+    def set_head(self, commit, msg):
+        self.__repository.refs.set(self.__ref(), commit, msg)
+
+    def set_parent_remote(self, name):
+        value = config.set('branch.%s.remote' % self.__name, name)
+    def set_parent_branch(self, name):
+        if config.get('branch.%s.remote' % self.__name):
+            # Never set merge if remote is not set to avoid
+            # possibly-erroneous lookups into 'origin'
+            config.set('branch.%s.merge' % self.__name, name)
+
+    @classmethod
+    def create(cls, repository, name, create_at = None):
+        """Create a new Git branch and return the corresponding
+        L{Branch} object."""
+        try:
+            branch = cls(repository, name)
+        except BranchException:
+            branch = None
+        if branch:
+            raise BranchException('%s: branch already exists' % name)
+
+        cmd = ['git', 'branch']
+        if create_at:
+            cmd.append(create_at.sha1)
+        repository.run(['git', 'branch', create_at.sha1]).discard_output()
+
+        return cls(repository, name)
diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index b1544a5..030c407 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -130,34 +130,22 @@ class Patches(object):
         self.__patches[name] = p
         return p
 
-class Stack(object):
+class Stack(git.Branch):
     """Represents an StGit stack (that is, a git branch with some extra
     metadata)."""
+    __repo_subdir = 'patches'
+
     def __init__(self, repository, name):
-        self.__repository = repository
-        self.__name = name
-        try:
-            self.head
-        except KeyError:
-            raise exception.StgException('%s: no such branch' % name)
+        git.Branch.__init__(self, repository, name)
         self.__patchorder = PatchOrder(self)
         self.__patches = Patches(self)
         if not stackupgrade.update_to_current_format_version(repository, name):
             raise exception.StgException('%s: branch not initialized' % name)
-    name = property(lambda self: self.__name)
-    repository = property(lambda self: self.__repository)
     patchorder = property(lambda self: self.__patchorder)
     patches = property(lambda self: self.__patches)
     @property
     def directory(self):
-        return os.path.join(self.__repository.directory, 'patches', self.__name)
-    def __ref(self):
-        return 'refs/heads/%s' % self.__name
-    @property
-    def head(self):
-        return self.__repository.refs.get(self.__ref())
-    def set_head(self, commit, msg):
-        self.__repository.refs.set(self.__ref(), commit, msg)
+        return os.path.join(self.repository.directory, self.__repo_subdir, self.name)
     @property
     def base(self):
         if self.patchorder.applied:
@@ -177,14 +165,11 @@ class Repository(git.Repository):
         git.Repository.__init__(self, *args, **kwargs)
         self.__stacks = {} # name -> Stack
     @property
-    def current_branch(self):
-        return utils.strip_leading('refs/heads/', self.head_ref)
-    @property
     def current_stack(self):
         return self.get_stack()
     def get_stack(self, name = None):
         if not name:
-            name = self.current_branch
+            name = self.current_branch_name
         if not name in self.__stacks:
             self.__stacks[name] = Stack(self, name)
         return self.__stacks[name]
