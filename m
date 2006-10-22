From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 1/2] New stg command: assimilate
Date: Sun, 22 Oct 2006 15:08:02 +0200
Message-ID: <20061022130802.17015.50188.stgit@localhost>
References: <20061022130559.17015.51385.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 15:09:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbd4r-0002Bj-0V
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 15:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWJVNJM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 09:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWJVNJM
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 09:09:12 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:42396 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751802AbWJVNJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 09:09:09 -0400
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep02.bredband.com with ESMTP
          id <20061022130907.QLMA2091.mxfep02.bredband.com@ironport2.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 15:09:07 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport2.bredband.com with ESMTP; 22 Oct 2006 15:09:05 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id ED5964CBCE;
	Sun, 22 Oct 2006 15:08:02 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20061022130559.17015.51385.stgit@localhost>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29740>

From: Karl Hasselstr=C3=B6m <kha@treskal.com>

Introduce an "assimilate" command, with no options. It takes any GIT
commits committed on top of your StGIT patch stack and converts them
into StGIT patches.

Also change the error message when an StGIT command can't do its job
because there are GIT commits on top of the stack. Instead of
recommending "refresh -f", which is a destructive operation, recommend
"assimilate", which is not.

NOTE: "assimilate" currently refuses to work its magic if it
encounters a merge commit. This is reasonable, since merge commits
can't (yet) be represented as StGIT patches. However, it would be
possible (and well-defined) to replace the merge commit with a regular
commit on the branch with the same end result (tree object),
discarding all the parents that aren't on our branch. But this would
take a substantial amount of code, and is of dubious value, so for now
"assimilate" just cries bloody murder if it finds a merge.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/assimilate.py |   96 ++++++++++++++++++++++++++++++++++++++=
++++
 stgit/commands/common.py     |    8 ++--
 stgit/git.py                 |    3 +
 stgit/main.py                |    3 +
 stgit/stack.py               |   28 +++++++++---
 5 files changed, 126 insertions(+), 12 deletions(-)

diff --git a/stgit/commands/assimilate.py b/stgit/commands/assimilate.py
new file mode 100644
index 0000000..2c0ec56
--- /dev/null
+++ b/stgit/commands/assimilate.py
@@ -0,0 +1,96 @@
+# -*- coding: utf-8 -*-
+
+__copyright__ =3D """
+Copyright (C) 2006, Karl Hasselstr=C3=B6m <kha@treskal.com>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License version 2 as
+published by the Free Software Foundation.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+"""
+
+import sys, os
+from optparse import OptionParser, make_option
+
+from stgit.commands.common import *
+from stgit.utils import *
+from stgit import stack, git
+
+help =3D 'StGIT-ify any GIT commits made on top of your StGIT stack'
+usage =3D """%prog
+
+If you have made GIT commits on top of your stack of StGIT patches,
+many StGIT commands will refuse to work. This command converts any
+such commits to StGIT patches, preserving their contents.
+
+Only GIT commits with exactly one parent can be assimilated; in other
+words, if you have committed a merge on top of your stack, this
+command cannot help you."""
+
+options =3D []
+
+def func(parser, options, args):
+    """Assimilate a number of patches.
+    """
+
+    def nothing_to_do():
+        print 'No commits to assimilate'
+
+    top_patch =3D crt_series.get_current_patch()
+    if not top_patch:
+        return nothing_to_do()
+
+    victims =3D []
+    victim =3D git.get_commit(git.get_head())
+    while victim.get_id_hash() !=3D top_patch.get_top():
+        victims.append(victim)
+        parents =3D victim.get_parents()
+        if not parents:
+            raise CmdException, 'Commit %s has no parents, aborting' % vic=
tim
+        elif len(parents) > 1:
+            raise CmdException, 'Commit %s is a merge, aborting' % victim
+        victim =3D git.get_commit(parents[0])
+
+    if not victims:
+        return nothing_to_do()
+
+    if crt_series.get_protected():
+        raise CmdException(
+            'This branch is protected. Modification is not permitted')
+
+    patch2name =3D {}
+    name2patch =3D {}
+    def name_taken(name):
+        return patchname in name2patch or crt_series.patch_exists(patchnam=
e)
+    for victim in victims:
+        patchname =3D make_patch_name(victim.get_log())
+        if not patchname:
+            patchname =3D 'patch'
+        if name_taken(patchname):
+            suffix =3D 0
+            while name_taken('%s-%d' % (patchname, suffix)):
+                suffix +=3D 1
+            patchname =3D '%s-%d' % (patchname, suffix)
+        patch2name[victim] =3D patchname
+        name2patch[patchname] =3D victim
+
+    for victim in reversed(victims):
+        print ('Creating patch "%s" from commit %s'
+               % (patch2name[victim], victim))
+        aname, amail, adate =3D name_email_date(victim.get_author())
+        cname, cmail, cdate =3D name_email_date(victim.get_committer())
+        crt_series.new_patch(
+            patch2name[victim],
+            can_edit =3D False, before_existing =3D False, refresh =3D Fal=
se,
+            top =3D victim.get_id_hash(), bottom =3D victim.get_parent(),
+            message =3D victim.get_log(),
+            author_name =3D aname, author_email =3D amail, author_date =3D=
 adate,
+            committer_name =3D cname, committer_email =3D cmail)
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index bf8481e..1ea6025 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -113,10 +113,10 @@ def check_local_changes():
=20
 def check_head_top_equal():
     if not crt_series.head_top_equal():
-        raise CmdException, \
-              'HEAD and top are not the same. You probably committed\n' \
-              '  changes to the tree outside of StGIT. If you know what yo=
u\n' \
-              '  are doing, use the "refresh -f" command'
+        raise CmdException(
+            'HEAD and top are not the same. You probably committed\n'
+            '  changes to the tree outside of StGIT. To bring them\n'
+            '  into StGIT, use the "assimilate" command')
=20
 def check_conflicts():
     if os.path.exists(os.path.join(basedir.get(), 'conflicts')):
diff --git a/stgit/git.py b/stgit/git.py
index 43bdc7e..42b0d12 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -79,6 +79,9 @@ class Commit:
     def get_log(self):
         return self.__log
=20
+    def __str__(self):
+        return self.get_id_hash()
+
 # dictionary of Commit objects, used to avoid multiple calls to git
 __commits =3D dict()
=20
diff --git a/stgit/main.py b/stgit/main.py
index e9cc6cd..de35ca8 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -30,6 +30,7 @@ from stgit.commands.common import *
 # The commands
 import stgit.commands.add
 import stgit.commands.applied
+import stgit.commands.assimilate
 import stgit.commands.branch
 import stgit.commands.delete
 import stgit.commands.diff
@@ -70,6 +71,7 @@ #
 commands =3D {
     'add':      stgit.commands.add,
     'applied':  stgit.commands.applied,
+    'assimilate': stgit.commands.assimilate,
     'branch':   stgit.commands.branch,
     'delete':   stgit.commands.delete,
     'diff':     stgit.commands.diff,
@@ -113,6 +115,7 @@ repocommands =3D (
     )
 stackcommands =3D (
     'applied',
+    'assimilate',
     'clean',
     'commit',
     'float',
diff --git a/stgit/stack.py b/stgit/stack.py
index 93a3d4e..e50f189 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -350,9 +350,17 @@ class Series:
         """
         return Patch(name, self.__patch_dir, self.__refs_dir)
=20
+    def get_current_patch(self):
+        """Return a Patch object representing the topmost patch, or
+        None if there is no such patch."""
+        crt =3D self.get_current()
+        if not crt:
+            return None
+        return Patch(crt, self.__patch_dir, self.__refs_dir)
+
     def get_current(self):
-        """Return a Patch object representing the topmost patch
-        """
+        """Return the name of the topmost patch, or None if there is
+        no such patch."""
         if os.path.isfile(self.__current_file):
             name =3D read_string(self.__current_file)
         else:
@@ -414,6 +422,11 @@ class Series:
         """
         return name in self.get_unapplied()
=20
+    def patch_exists(self, name):
+        """Return true if there is a patch with the given name, false
+        otherwise."""
+        return self.__patch_applied(name) or self.__patch_applied(name)
+
     def __begin_stack_check(self):
         """Save the current HEAD into .git/refs/heads/base if the stack
         is empty
@@ -433,12 +446,11 @@ class Series:
     def head_top_equal(self):
         """Return true if the head and the top are the same
         """
-        crt =3D self.get_current()
+        crt =3D self.get_current_patch()
         if not crt:
             # we don't care, no patches applied
             return True
-        return git.get_head() =3D=3D Patch(crt, self.__patch_dir,
-                                       self.__refs_dir).get_top()
+        return git.get_head() =3D=3D crt.get_top()
=20
     def is_initialised(self):
         """Checks if series is already initialised
@@ -688,7 +700,7 @@ class Series:
                   top =3D None, bottom =3D None,
                   author_name =3D None, author_email =3D None, author_date=
 =3D None,
                   committer_name =3D None, committer_email =3D None,
-                  before_existing =3D False):
+                  before_existing =3D False, refresh =3D True):
         """Creates a new patch
         """
         if self.__patch_applied(name) or self.__patch_unapplied(name):
@@ -741,8 +753,8 @@ class Series:
         else:
             append_string(self.__applied_file, patch.get_name())
             self.__set_current(name)
-
-            self.refresh_patch(cache_update =3D False, log =3D 'new')
+            if refresh:
+                self.refresh_patch(cache_update =3D False, log =3D 'new')
=20
     def delete_patch(self, name):
         """Deletes a patch
