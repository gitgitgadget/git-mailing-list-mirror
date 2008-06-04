From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 4/5] Add stack creation and initialisation support to
	lib.Stack
Date: Wed, 04 Jun 2008 22:13:43 +0100
Message-ID: <20080604211343.32531.41429.stgit@localhost.localdomain>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: kha@treskal.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 23:30:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K40Yb-0007US-JU
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 23:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbYFDV3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 17:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754277AbYFDV3P
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 17:29:15 -0400
Received: from queueout01-winn.ispmail.ntl.com ([81.103.221.31]:8203 "EHLO
	queueout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753343AbYFDV3O (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 17:29:14 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080604211801.KJOC7070.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Wed, 4 Jun 2008 22:18:01 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080604212242.GIQI8797.aamtaout03-winn.ispmail.ntl.com@localhost.localdomain>;
          Wed, 4 Jun 2008 22:22:42 +0100
In-Reply-To: <20080604210655.32531.82580.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.2.152.g3f19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83834>

This patch adds the create and initialise Stack classmethods to handle
the initialisation of StGIT patch series on a Git branch.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/lib/stack.py |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 54 insertions(+), 1 deletions(-)

diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index aca7a36..7375d41 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -3,6 +3,10 @@
 import os.path
 from stgit import exception, utils
 from stgit.lib import git, stackupgrade
+from stgit.config import config
+
+class StackException(exception.StgException):
+    """Exception raised by stack objects."""
 
 class Patch(object):
     """Represents an StGit patch. This class is mainly concerned with
@@ -105,6 +109,14 @@ class PatchOrder(object):
     all = property(lambda self: self.applied + self.unapplied + self.hidden)
     all_visible = property(lambda self: self.applied + self.unapplied)
 
+    @staticmethod
+    def create(stackdir):
+        """Create the PatchOrder specific files
+        """
+        utils.create_empty_file(os.path.join(stackdir, 'applied'))
+        utils.create_empty_file(os.path.join(stackdir, 'unapplied'))
+        utils.create_empty_file(os.path.join(stackdir, 'hidden'))
+
 class Patches(object):
     """Creates L{Patch} objects. Makes sure there is only one such object
     per patch."""
@@ -133,12 +145,14 @@ class Patches(object):
 class Stack(git.Branch):
     """Represents an StGit stack (that is, a git branch with some extra
     metadata)."""
+    __repo_subdir = 'patches'
+
     def __init__(self, repository, name):
         git.Branch.__init__(self, repository, name)
         self.__patchorder = PatchOrder(self)
         self.__patches = Patches(self)
         if not stackupgrade.update_to_current_format_version(repository, name):
-            raise exception.StgException('%s: branch not initialized' % name)
+            raise StackException('%s: branch not initialized' % name)
     patchorder = property(lambda self: self.__patchorder)
     patches = property(lambda self: self.__patches)
     @property
@@ -156,6 +170,45 @@ class Stack(git.Branch):
             return True
         return self.head == self.patches.get(self.patchorder.applied[-1]).commit
 
+    def set_parents(self, remote, localbranch):
+        if not localbranch:
+            return
+        if remote:
+            self.set_parent_remote(remote)
+        self.set_parent_branch(localbranch)
+        config.set('branch.%s.stgit.parentbranch' % self._name, localbranch)
+
+    @classmethod
+    def initialise(cls, repository, name = None):
+        """Initialise a Git branch to handle patch series."""
+        if not name:
+            name = repository.current_branch_name
+        # make sure that the corresponding Git branch exists
+        git.Branch(repository, name)
+
+        dir = os.path.join(repository.directory, cls.__repo_subdir, name)
+        compat_dir = os.path.join(dir, 'patches')
+        if os.path.exists(dir):
+            raise StackException('%s: branch already initialized' % name)
+
+        # create the stack directory and files
+        utils.create_dirs(dir)
+        utils.create_dirs(compat_dir)
+        PatchOrder.create(dir)
+        config.set(stackupgrade.format_version_key(name),
+                   str(stackupgrade.FORMAT_VERSION))
+
+        return repository.get_stack(name)
+
+    @classmethod
+    def create(cls, repository, name,
+               create_at = None, parent_remote = None, parent_branch = None):
+        """Create and initialise a Git branch returning the L{Stack} object."""
+        git.Branch.create(repository, name, create_at = create_at)
+        stack = cls.initialise(repository, name)
+        stack.set_parents(parent_remote, parent_branch)
+        return stack
+
 class Repository(git.Repository):
     """A git L{Repository<git.Repository>} with some added StGit-specific
     operations."""
