From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH] Implement a new patch identification scheme and id
	command
Date: Sat, 14 Jun 2008 08:28:33 +0100
Message-ID: <20080614072833.7899.91460.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 09:29:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7QCb-0008Mt-LD
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbYFNH2i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2008 03:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752998AbYFNH2i
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:28:38 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:27120 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752979AbYFNH2h (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jun 2008 03:28:37 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080614073251.LKDB28496.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Sat, 14 Jun 2008 08:32:51 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080614073141.EIHM29365.aamtaout02-winn.ispmail.ntl.com@localhost.localdomain>;
          Sat, 14 Jun 2008 08:31:41 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84985>

The new scheme allows '[<branch>:]<patch>' and '[<branch>:]{base}'
(the latter showing the base of a stack). The former format allows
symbols like ^, ^{...} etc.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/commands/common.py   |   32 ++++++++++++++++++++++++++++++++
 stgit/commands/id.py       |   25 +++++++++++--------------
 stgit/lib/git.py           |    4 ++--
 t/t0001-subdir-branches.sh |   26 +++++++++++---------------
 t/t1200-push-modified.sh   |    2 +-
 t/t1201-pull-trailing.sh   |    2 +-
 t/t2200-rebase.sh          |    2 +-
 7 files changed, 59 insertions(+), 34 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 029ec65..d1545e4 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -28,6 +28,7 @@ from stgit.run import *
 from stgit import stack, git, basedir
 from stgit.config import config, file_extensions
 from stgit.lib import stack as libstack
+from stgit.lib import git as libgit
=20
 # Command exception class
 class CmdException(StgException):
@@ -116,6 +117,37 @@ def git_id(crt_series, rev):
=20
     raise CmdException, 'Unknown patch or revision: %s' % rev
=20
+def git_sha1(repository, branch, name):
+    """Return the SHA1 value if 'name' is a patch name or Git commit.
+    The patch names allowed are in the form '<branch>:<patch>' and can=
 be
+    followed by standard symbols used by git-rev-parse. If <patch> is =
'{base}',
+    it represents the bottom of the stack.
+    """
+    # Try a Git commit first
+    try:
+        return repository.rev_parse(name, discard_stderr =3D True).sha=
1
+    except libgit.RepositoryException:
+        pass
+
+    # Git didn't recognise it, try a [branch:]patch name
+    try:
+        branch, patch =3D name.split(':', 1)
+    except ValueError:
+        patch =3D name
+    if not branch:
+        branch =3D repository.current_branch_name
+
+    # the stack base
+    if patch =3D=3D '{base}':
+        return repository.get_stack(branch).base.sha1
+
+    # any other combination of branch and patch
+    try:
+        return repository.rev_parse('patches/%s/%s' % (branch, patch),
+                                    discard_stderr =3D True).sha1
+    except libgit.RepositoryException:
+        raise CmdException('%s: Unknown patch or revision name' % name=
)
+
 def check_local_changes():
     if git.local_changes():
         raise CmdException('local changes in the tree. Use "refresh" o=
r'
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index 94b0229..50f6e8a 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -15,29 +15,26 @@ along with this program; if not, write to the Free =
Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-import sys, os
 from optparse import OptionParser, make_option
=20
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit.out import *
-from stgit import stack, git
-
+from stgit.out import out
+from stgit.commands import common
+from stgit.lib import stack
=20
 help =3D 'print the GIT hash value of a StGIT reference'
 usage =3D """%prog [options] [id]
=20
-Print the hash value of a GIT id (defaulting to HEAD). In addition to
-the standard GIT id's like heads and tags, this command also accepts
-'base[@<branch>]' and '[<patch>[@<branch>]][//[bottom | top]]'. If no
-'top' or 'bottom' are passed and <patch> is a valid patch name, 'top'
-will be used by default."""
+Print the SHA1 value of a Git id (defaulting to HEAD). In addition to
+the standard Git id's like heads and tags, this command also accepts
+'[<branch>:]<patch>]' and '[<branch>:]{base}]' showing the id of a pat=
ch
+or the base of the stack. If no branch is specified, it defaults to th=
e
+current one. The bottom of a patch is accessible with the
+'[<branch>:]<patch>]^' format."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D common.DirectoryHasRepositoryLib()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
')]
=20
-
 def func(parser, options, args):
     """Show the applied patches
     """
@@ -48,4 +45,4 @@ def func(parser, options, args):
     else:
         parser.error('incorrect number of arguments')
=20
-    out.stdout(git_id(crt_series, id_str))
+    out.stdout(common.git_sha1(directory.repository, options.branch, i=
d_str))
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 0e0cccb..379fb52 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -422,11 +422,11 @@ class Repository(RunWithEnv):
     refs =3D property(lambda self: self.__refs)
     def cat_object(self, sha1):
         return self.run(['git', 'cat-file', '-p', sha1]).raw_output()
-    def rev_parse(self, rev):
+    def rev_parse(self, rev, discard_stderr =3D False):
         try:
             return self.get_commit(self.run(
                     ['git', 'rev-parse', '%s^{commit}' % rev]
-                    ).output_one_line())
+                    ).discard_stderr(discard_stderr).output_one_line()=
)
         except run.RunException:
             raise RepositoryException('%s: No such revision' % rev)
     def get_tree(self, sha1):
diff --git a/t/t0001-subdir-branches.sh b/t/t0001-subdir-branches.sh
index 0eed3a4..cf2059a 100755
--- a/t/t0001-subdir-branches.sh
+++ b/t/t0001-subdir-branches.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# Copyright (c) 2006 Karl Hasselstr=F6m
+# Copyright (c) 2006 Karl Hasselstr=EF=BF=BDm
 #
=20
 test_description=3D'Branch names containing slashes
@@ -18,25 +18,21 @@ test_expect_success 'Create a patch' \
    stg new foo -m "Add foo.txt" &&
    stg refresh'
=20
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
=20
 test_expect_success 'Clone branch to slashier name' \
   'stg branch --clone x/y/z'
=20
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
=20
 test_expect_success 'Try old id with slashy branch' '
    ! stg id foo/ &&
diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
index ba4f70c..e3c6425 100755
--- a/t/t1200-push-modified.sh
+++ b/t/t1200-push-modified.sh
@@ -36,7 +36,7 @@ test_expect_success \
     (
         cd foo &&
         GIT_DIR=3D../bar/.git git-format-patch --stdout \
-          $(cd ../bar && stg id base@master)..HEAD | git-am -3 -k
+          $(cd ../bar && stg id master:{base})..HEAD | git-am -3 -k
     )
 '
=20
diff --git a/t/t1201-pull-trailing.sh b/t/t1201-pull-trailing.sh
index 9d70fe0..8a74873 100755
--- a/t/t1201-pull-trailing.sh
+++ b/t/t1201-pull-trailing.sh
@@ -30,7 +30,7 @@ test_expect_success \
     'Port those patches to orig tree' \
     '(cd foo &&
       GIT_DIR=3D../bar/.git git-format-patch --stdout \
-          $(cd ../bar && stg id base@master)..HEAD |
+          $(cd ../bar && stg id master:{base})..HEAD |
       git-am -3 -k
      )
     '
diff --git a/t/t2200-rebase.sh b/t/t2200-rebase.sh
index ec2a104..cd43c41 100755
--- a/t/t2200-rebase.sh
+++ b/t/t2200-rebase.sh
@@ -27,7 +27,7 @@ test_expect_success \
 	'Rebase to previous commit' \
 	'
 	stg rebase master~1 &&
-	test `stg id base@stack` =3D `git rev-parse master~1` &&
+	test `stg id stack:{base}` =3D `git rev-parse master~1` &&
 	test `stg applied | wc -l` =3D 1
 	'
=20
