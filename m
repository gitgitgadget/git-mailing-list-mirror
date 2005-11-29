From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 6/7] Add a "--clone" option to "stg branch"
Date: Tue, 29 Nov 2005 17:09:49 -0500
Message-ID: <20051129220949.9885.51533.stgit@dexter.citi.umich.edu>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 23:11:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhDfj-0006zv-Na
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 23:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVK2WJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 17:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVK2WJv
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 17:09:51 -0500
Received: from citi.umich.edu ([141.211.133.111]:5243 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932440AbVK2WJu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 17:09:50 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id B916D1BBDE;
	Tue, 29 Nov 2005 17:09:49 -0500 (EST)
To: catalin.marinas@gmail.com
In-Reply-To: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12958>

Cloning a branch means creating a new branch and copying all of the
original branch's patches and its base to it.  Like creating a tag,
but this also preserves all the StGIT patches as well.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/commands/branch.py |   28 +++++++++++++++++++++++++---
 stgit/stack.py           |   35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index ccf1f6b..5bc5e94 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -18,7 +18,7 @@ along with this program; if not, write t
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os
+import sys, os, time
 from optparse import OptionParser, make_option
 
 from stgit.commands.common import *
@@ -29,10 +29,10 @@ from stgit import stack, git
 help = 'manage development branches'
 usage = """%prog [options] branch-name [commit-id]
 
-Create, list, switch between, rename, or delete development branches
+Create, clone, switch between, rename, or delete development branches
 within a git repository.  By default, a single branch called 'master'
 is always created in a new repository.  This subcommand allows you to
-manage several patch series in the same repository.
+manage several patch series in the same repository via GIT branches.
 
 When displaying the branches, the names can be prefixed with
 's' (StGIT managed) or 'p' (protected)."""
@@ -40,6 +40,9 @@ When displaying the branches, the names 
 options = [make_option('-c', '--create',
                        help = 'create a new development branch',
                        action = 'store_true'),
+           make_option('--clone',
+                       help = 'copy the contents of a branch',
+                       action = 'store_true'),
            make_option('--delete',
                        help = 'delete an existing development branch',
                        action = 'store_true'),
@@ -124,6 +127,25 @@ def func(parser, options, args):
         print 'Branch "%s" created.' % args[0]
         return
 
+    elif options.clone:
+
+        if len(args) == 0:
+            clone = crt_series.get_branch() + \
+                    time.strftime('-%C%y%m%d-%H%M%S')
+        elif len(args) == 1:
+            clone = args[0]
+        else:
+            parser.error('incorrect number of arguments')
+
+        check_local_changes()
+        check_conflicts()
+        check_head_top_equal()
+
+        print 'Cloning current branch to "%s"...' % clone
+        crt_series.clone(clone)
+        print 'done'
+        return
+
     elif options.delete:
 
         if len(args) != 1:
diff --git a/stgit/stack.py b/stgit/stack.py
index dc7c19f..2866121 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -18,7 +18,7 @@ along with this program; if not, write t
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os
+import sys, os, shutil
 
 from stgit.utils import *
 from stgit import git
@@ -420,6 +420,39 @@ class Series:
 
         self.__init__(to_name)
 
+    def clone(self, target_series):
+        """Clones a series
+        """
+        base = read_string(self.get_base_file())
+        git.create_branch(target_series, tree_id = base)
+        Series(target_series).init()
+
+        new_series = Series(target_series)
+
+        if os.path.exists(self.__descr_file):
+            shutil.copyfile(self.__descr_file, new_series.__descr_file)
+
+        for p in self.get_applied():
+            patch = self.get_patch(p)
+            new_series.new_patch(p, message = patch.get_description(),
+                                 can_edit = False, unapplied = True,
+                                 bottom = patch.get_bottom(),
+                                 top = patch.get_top(),
+                                 author_name = patch.get_authname(),
+                                 author_email = patch.get_authemail(),
+                                 author_date = patch.get_authdate())
+            modified = new_series.push_patch(p)
+
+        for p in self.get_unapplied():
+            patch = self.get_patch(p)
+            new_series.new_patch(p, message = patch.get_description(),
+                                 can_edit = False, unapplied = True,
+                                 bottom = patch.get_bottom(),
+                                 top = patch.get_top(),
+                                 author_name = patch.get_authname(),
+                                 author_email = patch.get_authemail(),
+                                 author_date = patch.get_authdate())
+
     def delete(self, force = False):
         """Deletes an stgit series
         """
