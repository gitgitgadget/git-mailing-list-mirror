From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 3/5] Add stack creation and initialisation support to
	lib.Stack
Date: Fri, 06 Jun 2008 21:45:54 +0100
Message-ID: <20080606204554.8805.37257.stgit@localhost.localdomain>
References: <20080606204322.8805.32313.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 22:47:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4iqO-0001dA-HL
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 22:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764841AbYFFUqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 16:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764833AbYFFUp7
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 16:45:59 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:44039 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764837AbYFFUp6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 16:45:58 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080606205116.LOVA16629.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Fri, 6 Jun 2008 21:51:16 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080606205125.LMQP16854.aamtaout01-winn.ispmail.ntl.com@localhost.localdomain>;
          Fri, 6 Jun 2008 21:51:25 +0100
In-Reply-To: <20080606204322.8805.32313.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.2.168.ge637
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84112>

This patch adds the create and initialise Stack classmethods to handle
the initialisation of StGIT patch series on a Git branch.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/lib/stack.py |   63 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 62 insertions(+), 1 deletions(-)

diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index 030c407..9cb3967 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -3,6 +3,10 @@
 import os.path
 from stgit import exception, utils
 from stgit.lib import git, stackupgrade
+from stgit.config import config
+
+class StackException(exception.StgException):
+    """Exception raised by L{stack} objects."""
 
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
@@ -140,7 +152,7 @@ class Stack(git.Branch):
         self.__patchorder = PatchOrder(self)
         self.__patches = Patches(self)
         if not stackupgrade.update_to_current_format_version(repository, name):
-            raise exception.StgException('%s: branch not initialized' % name)
+            raise StackException('%s: branch not initialized' % name)
     patchorder = property(lambda self: self.__patchorder)
     patches = property(lambda self: self.__patches)
     @property
@@ -158,6 +170,55 @@ class Stack(git.Branch):
             return True
         return self.head == self.patches.get(self.patchorder.applied[-1]).commit
 
+    def set_parents(self, remote, branch):
+        if remote:
+            self.set_parent_remote(remote)
+        if branch:
+            self.set_parent_branch(branch)
+
+    @classmethod
+    def initialise(cls, repository, name = None):
+        """Initialise a Git branch to handle patch series.
+
+        @param repository: The L{Repository} where the L{Stack} will be created
+        @param name: The name of the L{Stack}
+        """
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
+        """Create and initialise a Git branch returning the L{Stack} object.
+
+        @param repository: The L{Repository} where the L{Stack} will be created
+        @param name: The name of the L{Stack}
+        @param create_at: The Git id used as the base for the newly created
+            Git branch
+        @param parent_remote: The name of the remote Git branch
+        @param parent_branch: The name of the parent Git branch
+        """
+        git.Branch.create(repository, name, create_at = create_at)
+        stack = cls.initialise(repository, name)
+        stack.set_parents(parent_remote, parent_branch)
+        return stack
+
 class Repository(git.Repository):
     """A git L{Repository<git.Repository>} with some added StGit-specific
     operations."""
