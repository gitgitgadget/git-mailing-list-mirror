From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 3/5] Create a git.Branch class as ancestor of stack.Stack
Date: Wed, 04 Jun 2008 22:13:35 +0100
Message-ID: <20080604211334.32531.74258.stgit@localhost.localdomain>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: kha@treskal.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:29:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K40Xs-0007A0-9P
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 23:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbYFDV2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 17:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbYFDV2W
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 17:28:22 -0400
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:24371 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753643AbYFDV2W (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 17:28:22 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080604211740.GVHP28496.mtaout01-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Wed, 4 Jun 2008 22:17:40 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080604211902.GGMS16854.aamtaout01-winn.ispmail.ntl.com@localhost.localdomain>;
          Wed, 4 Jun 2008 22:19:02 +0100
In-Reply-To: <20080604210655.32531.82580.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.2.152.g3f19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83832>

This class deals with Git-specific branch commands. The Stack class is a
direct child of Branch and some of its functionality was moved to the new
class.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/lib/git.py   |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 stgit/lib/stack.py |   25 ++++---------------------
 2 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index fd66f6d..6393af2 100644
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
@@ -619,3 +626,47 @@ class IndexAndWorktree(RunWithEnvCwd):
     def update_index(self, files):
         self.run(['git', 'update-index', '--remove', '-z', '--stdin']
                  ).input_nulterm(files).discard_output()
+
+class Branch(object):
+    """Represents Git branch."""
+    def __init__(self, repository, name):
+        self._repository = repository
+        self._name = name
+        try:
+            self.head
+        except KeyError:
+            raise BranchException('%s: no such branch' % name)
+
+    name = property(lambda self: self._name)
+    repository = property(lambda self: self._repository)
+
+    def __ref(self):
+        return 'refs/heads/%s' % self._name
+    @property
+    def head(self):
+        return self._repository.refs.get(self.__ref())
+    def set_head(self, commit, msg):
+        self._repository.refs.set(self.__ref(), commit, msg)
+
+    def set_parent_remote(self, name):
+        value = config.set('branch.%s.remote' % self._name, name)
+    def set_parent_branch(self, name):
+        if config.get('branch.%s.remote' % self._name):
+            # Never set merge if remote is not set to avoid
+            # possibly-erroneous lookups into 'origin'
+            config.set('branch.%s.merge' % self._name, name)
+
+    @classmethod
+    def create(cls, repository, name, create_at = None):
+        """Create a new Git branch and return the corresponding L{Branch} object."""
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
+        self._repository.run(['git', 'branch', create_at.sha1]).discard_output()
diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index bdd21b1..aca7a36 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -130,34 +130,20 @@ class Patches(object):
         self.__patches[name] = p
         return p
 
-class Stack(object):
+class Stack(git.Branch):
     """Represents an StGit stack (that is, a git branch with some extra
     metadata)."""
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
+        return os.path.join(self._repository.directory, self.__repo_subdir, self._name)
     @property
     def base(self):
         if self.patchorder.applied:
@@ -177,14 +163,11 @@ class Repository(git.Repository):
         git.Repository.__init__(self, *args, **kwargs)
         self.__stacks = {} # name -> Stack
     @property
-    def current_branch(self):
-        return utils.strip_leading('refs/heads/', self.head)
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
