From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2/4] Implement a new patch identification scheme and id command
Date: Sun, 13 Jul 2008 12:40:35 +0100
Message-ID: <20080713114035.18845.45056.stgit@localhost.localdomain>
References: <20080713113853.18845.37686.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 13:41:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHzxb-0006GP-OC
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 13:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbYGMLkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 07:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbYGMLkt
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 07:40:49 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:28326 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752720AbYGMLks (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jul 2008 07:40:48 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080713114547.JWNT7070.mtaout02-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Sun, 13 Jul 2008 12:45:47 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080713115117.IIM8797.aamtaout03-winn.ispmail.ntl.com@localhost.localdomain>;
          Sun, 13 Jul 2008 12:51:17 +0100
In-Reply-To: <20080713113853.18845.37686.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3.163.g06f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88302>

The new scheme allows '[<branch>:]<patch>' and '[<branch>:]{base}'
(the latter showing the base of a stack). The former format allows
symbols like ^ and ^{...}.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/commands/common.py   |   33 +++++++++++++++++++++++++++++++++
 stgit/commands/id.py       |   28 ++++++++++++----------------
 stgit/lib/git.py           |    4 ++--
 t/t0001-subdir-branches.sh |   24 ++++++++++--------------
 t/t1200-push-modified.sh   |    2 +-
 t/t1201-pull-trailing.sh   |    2 +-
 t/t2200-rebase.sh          |    2 +-
 7 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 029ec65..0133f1a 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -28,6 +28,7 @@ from stgit.run import *
 from stgit import stack, git, basedir
 from stgit.config import config, file_extensions
 from stgit.lib import stack as libstack
+from stgit.lib import git as libgit
 
 # Command exception class
 class CmdException(StgException):
@@ -116,6 +117,38 @@ def git_id(crt_series, rev):
 
     raise CmdException, 'Unknown patch or revision: %s' % rev
 
+def git_commit(name, repository, branch = None):
+    """Return the a Commit object if 'name' is a patch name or Git commit.
+    The patch names allowed are in the form '<branch>:<patch>' and can
+    be followed by standard symbols used by git-rev-parse. If <patch>
+    is '{base}', it represents the bottom of the stack.
+    """
+    # Try a [branch:]patch name first
+    try:
+        branch, patch = name.split(':', 1)
+    except ValueError:
+        patch = name
+    if not branch:
+        branch = repository.current_branch_name
+
+    # The stack base
+    if patch.startswith('{base}'):
+        base_id = repository.get_stack(branch).base.sha1
+        return repository.rev_parse(base_id + patch[6:])
+
+    # Other combination of branch and patch
+    try:
+        return repository.rev_parse('patches/%s/%s' % (branch, patch),
+                                    discard_stderr = True)
+    except libgit.RepositoryException:
+        pass
+
+    # Try a Git commit
+    try:
+        return repository.rev_parse(name, discard_stderr = True)
+    except libgit.RepositoryException:
+        raise CmdException('%s: Unknown patch or revision name' % name)
+
 def check_local_changes():
     if git.local_changes():
         raise CmdException('local changes in the tree. Use "refresh" or'
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index 94b0229..3819acc 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -15,28 +15,24 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os
 from optparse import OptionParser, make_option
 
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit.out import *
-from stgit import stack, git
-
+from stgit.out import out
+from stgit.commands import common
+from stgit.lib import stack
 
 help = 'print the GIT hash value of a StGIT reference'
 usage = """%prog [options] [id]
 
-Print the hash value of a GIT id (defaulting to HEAD). In addition to
-the standard GIT id's like heads and tags, this command also accepts
-'base[@<branch>]' and '[<patch>[@<branch>]][//[bottom | top]]'. If no
-'top' or 'bottom' are passed and <patch> is a valid patch name, 'top'
-will be used by default."""
-
-directory = DirectoryHasRepository()
-options = [make_option('-b', '--branch',
-                       help = 'use BRANCH instead of the default one')]
+Print the SHA1 value of a Git id (defaulting to HEAD). In addition to
+the standard Git id's like heads and tags, this command also accepts
+'[<branch>:]<patch>' and '[<branch>:]{base}' showing the id of a patch
+or the base of the stack. If no branch is specified, it defaults to the
+current one. The bottom of a patch is accessible with the
+'[<branch>:]<patch>^' format."""
 
+directory = common.DirectoryHasRepositoryLib()
+options = []
 
 def func(parser, options, args):
     """Show the applied patches
@@ -48,4 +44,4 @@ def func(parser, options, args):
     else:
         parser.error('incorrect number of arguments')
 
-    out.stdout(git_id(crt_series, id_str))
+    out.stdout(common.git_commit(id_str, directory.repository).sha1)
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 6ccdfa7..4746da3 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -422,11 +422,11 @@ class Repository(RunWithEnv):
     refs = property(lambda self: self.__refs)
     def cat_object(self, sha1):
         return self.run(['git', 'cat-file', '-p', sha1]).raw_output()
-    def rev_parse(self, rev):
+    def rev_parse(self, rev, discard_stderr = False):
         try:
             return self.get_commit(self.run(
                     ['git', 'rev-parse', '%s^{commit}' % rev]
-                    ).output_one_line())
+                    ).discard_stderr(discard_stderr).output_one_line())
         except run.RunException:
             raise RepositoryException('%s: No such revision' % rev)
     def get_tree(self, sha1):
diff --git a/t/t0001-subdir-branches.sh b/t/t0001-subdir-branches.sh
index 69c11a3..3f7962a 100755
--- a/t/t0001-subdir-branches.sh
+++ b/t/t0001-subdir-branches.sh
@@ -18,25 +18,21 @@ test_expect_success 'Create a patch' \
    stg new foo -m "Add foo.txt" &&
    stg refresh'
 
-test_expect_success 'Old and new id with non-slashy branch' \
-  'stg id foo &&
-   stg id foo// &&
-   stg id foo/ &&
-   stg id foo//top &&
-   stg id foo/top &&
-   stg id foo@master &&
-   stg id foo@master//top &&
-   stg id foo@master/top'
+test_expect_success 'Try id with non-slashy branch' \
+  'stg id &&
+   stg id foo &&
+   stg id foo^ &&
+   stg id master:foo &&
+   stg id master:foo^'
 
 test_expect_success 'Clone branch to slashier name' \
   'stg branch --clone x/y/z'
 
-test_expect_success 'Try new form of id with slashy branch' \
+test_expect_success 'Try new id with slashy branch' \
   'stg id foo &&
-   stg id foo// &&
-   stg id foo//top &&
-   stg id foo@x/y/z &&
-   stg id foo@x/y/z//top'
+   stg id foo^ &&
+   stg id x/y/z:foo &&
+   stg id x/y/z:foo^'
 
 test_expect_success 'Try old id with slashy branch' '
    command_error stg id foo/ &&
diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
index 6ebd0a1..2edc760 100755
--- a/t/t1200-push-modified.sh
+++ b/t/t1200-push-modified.sh
@@ -36,7 +36,7 @@ test_expect_success \
     (
         cd foo &&
         GIT_DIR=../bar/.git git-format-patch --stdout \
-          $(cd ../bar && stg id base@master)..HEAD | git-am -3 -k
+          $(cd ../bar && stg id master:{base})..HEAD | git-am -3 -k
     )
 '
 
diff --git a/t/t1201-pull-trailing.sh b/t/t1201-pull-trailing.sh
index 9d70fe0..8a74873 100755
--- a/t/t1201-pull-trailing.sh
+++ b/t/t1201-pull-trailing.sh
@@ -30,7 +30,7 @@ test_expect_success \
     'Port those patches to orig tree' \
     '(cd foo &&
       GIT_DIR=../bar/.git git-format-patch --stdout \
-          $(cd ../bar && stg id base@master)..HEAD |
+          $(cd ../bar && stg id master:{base})..HEAD |
       git-am -3 -k
      )
     '
diff --git a/t/t2200-rebase.sh b/t/t2200-rebase.sh
index a6f43bc..256eaaa 100755
--- a/t/t2200-rebase.sh
+++ b/t/t2200-rebase.sh
@@ -27,7 +27,7 @@ test_expect_success \
 	'Rebase to previous commit' \
 	'
 	stg rebase master~1 &&
-	test `stg id base@stack` = `git rev-parse master~1` &&
+	test `stg id stack:{base}` = `git rev-parse master~1` &&
 	test `stg applied | wc -l` = 1
 	'
 
