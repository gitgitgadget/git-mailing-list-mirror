From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/5] Infrastructure for current directory handling
Date: Mon, 08 Oct 2007 01:24:41 +0200
Message-ID: <20071007232441.13070.665.stgit@yoghurt>
References: <20071007231949.13070.49517.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IefVT-0004S3-CC
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912AbXJGXYu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 19:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754987AbXJGXYu
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:24:50 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4885 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbXJGXYs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:24:48 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IefUI-0000Q4-00; Mon, 08 Oct 2007 00:24:42 +0100
In-Reply-To: <20071007231949.13070.49517.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60251>

Add infrastructure to allow commands to specify if they need a git
repository, if they need to be called from within the working tree,
and if they should cd to the root of the working tree before doing
anything else.

=46or now, all commands are set to just require a repository (except
"stg clone", which is set to require nothing), which means the only
thing that's added is some very light error checking. The idea is to
tighten this for commands that turn out to need it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/add.py        |    1 +
 stgit/commands/applied.py    |    1 +
 stgit/commands/assimilate.py |    1 +
 stgit/commands/branch.py     |    1 +
 stgit/commands/clean.py      |    1 +
 stgit/commands/clone.py      |    1 +
 stgit/commands/commit.py     |    1 +
 stgit/commands/common.py     |   68 ++++++++++++++++++++++++++++++++++=
++++++++
 stgit/commands/copy.py       |    1 +
 stgit/commands/delete.py     |    1 +
 stgit/commands/diff.py       |    1 +
 stgit/commands/edit.py       |    1 +
 stgit/commands/export.py     |    1 +
 stgit/commands/files.py      |    1 +
 stgit/commands/float.py      |    1 +
 stgit/commands/fold.py       |    1 +
 stgit/commands/goto.py       |    1 +
 stgit/commands/hide.py       |    1 +
 stgit/commands/id.py         |    1 +
 stgit/commands/imprt.py      |    1 +
 stgit/commands/init.py       |    1 +
 stgit/commands/log.py        |    1 +
 stgit/commands/mail.py       |    1 +
 stgit/commands/new.py        |    1 +
 stgit/commands/patches.py    |    1 +
 stgit/commands/pick.py       |    1 +
 stgit/commands/pop.py        |    1 +
 stgit/commands/pull.py       |    1 +
 stgit/commands/push.py       |    1 +
 stgit/commands/rebase.py     |    1 +
 stgit/commands/refresh.py    |    1 +
 stgit/commands/rename.py     |    1 +
 stgit/commands/resolved.py   |    1 +
 stgit/commands/rm.py         |    1 +
 stgit/commands/series.py     |    1 +
 stgit/commands/show.py       |    1 +
 stgit/commands/sink.py       |    1 +
 stgit/commands/status.py     |    1 +
 stgit/commands/sync.py       |    1 +
 stgit/commands/top.py        |    1 +
 stgit/commands/unapplied.py  |    1 +
 stgit/commands/uncommit.py   |    1 +
 stgit/commands/unhide.py     |    1 +
 stgit/main.py                |    2 +
 44 files changed, 112 insertions(+), 0 deletions(-)


diff --git a/stgit/commands/add.py b/stgit/commands/add.py
index fc9c5a7..264ab9f 100644
--- a/stgit/commands/add.py
+++ b/stgit/commands/add.py
@@ -31,6 +31,7 @@ Add the files or directories passed as arguments to t=
he
 repository. When a directory name is given, all the files and
 subdirectories are recursively added."""
=20
+directory =3D DirectoryHasRepository()
 options =3D []
=20
=20
diff --git a/stgit/commands/applied.py b/stgit/commands/applied.py
index b9bb716..45d0926 100644
--- a/stgit/commands/applied.py
+++ b/stgit/commands/applied.py
@@ -32,6 +32,7 @@ List the patches from the series which were already p=
ushed onto the
 stack.  They are listed in the order in which they were pushed, the
 last one being the current (topmost) patch."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
            make_option('-c', '--count',
diff --git a/stgit/commands/assimilate.py b/stgit/commands/assimilate.p=
y
index 43672fd..db8a95c 100644
--- a/stgit/commands/assimilate.py
+++ b/stgit/commands/assimilate.py
@@ -53,6 +53,7 @@ Note that these are "inconsistencies", not "errors"; =
furthermore,
 with the way "assimilate" handles them, you have no reason to avoid
 causing them in the first place if that is convenient for you."""
=20
+directory =3D DirectoryHasRepository()
 options =3D []
=20
 class Commit(object):
diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index c16fc69..6e0a6d8 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -40,6 +40,7 @@ When displaying the branches, the names can be prefix=
ed with
=20
 If not given any options, switch to the named branch."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-c', '--create',
                        help =3D 'create a new development branch',
                        action =3D 'store_true'),
diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index 2e3b202..d8bbe71 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -31,6 +31,7 @@ Delete the empty patches in the whole series or only =
those applied or
 unapplied. A patch is considered empty if the two commit objects
 representing its boundaries refer to the same tree object."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-a', '--applied',
                        help =3D 'delete the empty applied patches',
                        action =3D 'store_true'),
diff --git a/stgit/commands/clone.py b/stgit/commands/clone.py
index 15139c8..a150010 100644
--- a/stgit/commands/clone.py
+++ b/stgit/commands/clone.py
@@ -29,6 +29,7 @@ usage =3D """%prog [options] <repository> <dir>
 Clone a GIT <repository> into the local <dir> and initialise the
 patch stack."""
=20
+directory =3D DirectoryAnywhere()
 options =3D []
=20
=20
diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index 0b76c56..2b45c0d 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -32,6 +32,7 @@ remove them from the series while advancing the base.
 Use this command only if you want to permanently store the applied
 patches and no longer manage them with StGIT."""
=20
+directory =3D DirectoryHasRepository()
 options =3D []
=20
=20
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 9815400..27ef465 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -24,6 +24,7 @@ from optparse import OptionParser, make_option
 from stgit.exception import *
 from stgit.utils import *
 from stgit.out import *
+from stgit.run import *
 from stgit import stack, git, basedir
 from stgit.config import config, file_extensions
=20
@@ -480,3 +481,70 @@ def parse_patch(fobj):
     # we don't yet have an agreed place for the creation date.
     # Just return None
     return (descr, authname, authemail, authdate, diff)
+
+def readonly_constant_property(f):
+    """Decorator that converts a function that computes a value to an
+    attribute that returns the value. The value is computed only once,
+    the first time it is accessed."""
+    def new_f(self):
+        n =3D '__' + f.__name__
+        if not hasattr(self, n):
+            setattr(self, n, f(self))
+        return getattr(self, n)
+    return property(new_f)
+
+class DirectoryException(StgException):
+    pass
+
+class _Directory(object):
+    @readonly_constant_property
+    def git_dir(self):
+        try:
+            return Run('git-rev-parse', '--git-dir'
+                       ).discard_stderr().output_one_line()
+        except RunException:
+            raise DirectoryException('No git repository found')
+    @readonly_constant_property
+    def __topdir_path(self):
+        try:
+            lines =3D Run('git-rev-parse', '--show-cdup'
+                        ).discard_stderr().output_lines()
+            if len(lines) =3D=3D 0:
+                return '.'
+            elif len(lines) =3D=3D 1:
+                return lines[0]
+            else:
+                raise RunException('Too much output')
+        except RunException:
+            raise DirectoryException('No git repository found')
+    @readonly_constant_property
+    def is_inside_git_dir(self):
+        return { 'true': True, 'false': False
+                 }[Run('git-rev-parse', '--is-inside-git-dir'
+                       ).output_one_line()]
+    @readonly_constant_property
+    def is_inside_worktree(self):
+        return { 'true': True, 'false': False
+                 }[Run('git-rev-parse', '--is-inside-work-tree'
+                       ).output_one_line()]
+    def cd_to_topdir(self):
+        os.chdir(self.__topdir_path)
+
+class DirectoryAnywhere(_Directory):
+    def setup(self):
+        pass
+
+class DirectoryHasRepository(_Directory):
+    def setup(self):
+        self.git_dir # might throw an exception
+
+class DirectoryInWorktree(DirectoryHasRepository):
+    def setup(self):
+        DirectoryHasRepository.setup(self)
+        if not self.is_inside_worktree:
+            raise DirectoryException('Not inside a git worktree')
+
+class DirectoryGotoToplevel(DirectoryInWorktree):
+    def setup(self):
+        DirectoryInWorktree.setup(self)
+        self.cd_to_topdir()
diff --git a/stgit/commands/copy.py b/stgit/commands/copy.py
index 76e3bf9..e94dd66 100644
--- a/stgit/commands/copy.py
+++ b/stgit/commands/copy.py
@@ -30,6 +30,7 @@ usage =3D """%prog [options] [<file/dir> <newname> | =
<files/dirs...> <dir>]
 Copy of the files and dirs passed as arguments under another name or
 location inside the same repository."""
=20
+directory =3D DirectoryHasRepository()
 options =3D []
=20
 def func(parser, options, args):
diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index 2121015..8462857 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -36,6 +36,7 @@ patches are deleted, they are popped from the stack.
=20
 Note that the 'delete' operation is irreversible."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
')]
=20
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index aeca4ab..f3b0ea2 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -42,6 +42,7 @@ rev =3D '([patch][//[bottom | top]]) | <tree-ish> | b=
ase'
 If neither bottom nor top are given but a '//' is present, the command
 shows the specified patch (defaulting to the current one)."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-r', '--range',
                        metavar =3D 'rev1[..[rev2]]', dest =3D 'revs',
                        help =3D 'show the diff between revisions'),
diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index 223c628..02970bc 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -57,6 +57,7 @@ rejected patch is stored in the .stgit-failed.patch f=
ile (and also in
 these files using the '--file' and '--diff' options.
 """
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-d', '--diff',
                        help =3D 'edit the patch diff',
                        action =3D 'store_true'),
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 62be394..d8ce86d 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -49,6 +49,7 @@ file:
   %(commemail)s   - committer's e-mail
 """
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-d', '--dir',
                        help =3D 'export patches to DIR instead of the =
default'),
            make_option('-p', '--patch',
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index 1a10023..07cc955 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -34,6 +34,7 @@ given patch. Note that this command doesn't show the =
files modified in
 the working tree and not yet included in the patch by a 'refresh'
 command. Use the 'diff' or 'status' commands for these files."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-s', '--stat',
                        help =3D 'show the diff stat',
                        action =3D 'store_true'),
diff --git a/stgit/commands/float.py b/stgit/commands/float.py
index 0e32f6b..d5299fb 100644
--- a/stgit/commands/float.py
+++ b/stgit/commands/float.py
@@ -31,6 +31,7 @@ necessary pop and push operations will be performed t=
o accomplish
 this. The '--series' option can be used to rearrange the (top) patches
 as specified by the given series file (or the standard input)."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-s', '--series',
                        help =3D 'rearrange according to a series file'=
,
                        action =3D 'store_true')]
diff --git a/stgit/commands/fold.py b/stgit/commands/fold.py
index d97185e..6e43101 100644
--- a/stgit/commands/fold.py
+++ b/stgit/commands/fold.py
@@ -34,6 +34,7 @@ performed with the current top. With the --base optio=
n, the patch is
 applied onto the specified base and a three-way merged is performed
 with the current top."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-t', '--threeway',
                        help =3D 'perform a three-way merge with the cu=
rrent patch',
                        action =3D 'store_true'),
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index a4427fa..9e008a9 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -31,6 +31,7 @@ line becomes current. This is a shortcut for the 'pus=
h --to' or 'pop
 --to' commands. There is no '--undo' option for 'goto'. Use the 'push'
 command for this."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-k', '--keep',
                        help =3D 'keep the local changes when popping p=
atches',
                        action =3D 'store_true')]
diff --git a/stgit/commands/hide.py b/stgit/commands/hide.py
index de19c19..1a38907 100644
--- a/stgit/commands/hide.py
+++ b/stgit/commands/hide.py
@@ -30,6 +30,7 @@ usage =3D """%prog [options] <patch-range>
 Hide a range of unapplied patches so that they are no longer shown in
 the plain 'series' command output."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
')]
=20
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index f72d2f3..3e28f2f 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -33,6 +33,7 @@ the standard GIT id's like heads and tags, this comma=
nd also accepts
 'top' or 'bottom' are passed and <patch> is a valid patch name, 'top'
 will be used by default."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
')]
=20
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 717f373..045f185 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -44,6 +44,7 @@ stack.
 The patch description has to be separated from the data with a '---'
 line."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-m', '--mail',
                        help =3D 'import the patch from a standard e-ma=
il file',
                        action =3D 'store_true'),
diff --git a/stgit/commands/init.py b/stgit/commands/init.py
index 46562d0..475a4ce 100644
--- a/stgit/commands/init.py
+++ b/stgit/commands/init.py
@@ -31,6 +31,7 @@ Initialise the current GIT branch to be used as an St=
GIT stack. Note
 that you must already be in a GIT repository and .git/HEAD must point
 to a valid file in refs/heads/."""
=20
+directory =3D DirectoryHasRepository()
 options =3D []
=20
=20
diff --git a/stgit/commands/log.py b/stgit/commands/log.py
index 4d6b022..f8337f9 100644
--- a/stgit/commands/log.py
+++ b/stgit/commands/log.py
@@ -43,6 +43,7 @@ represent the changes to the entire base of the curre=
nt
 patch. Conflicts reset the patch content and a subsequent 'refresh'
 will show the entire patch."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
            make_option('-p', '--patch',
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index c32894e..4a4158a 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -88,6 +88,7 @@ the following:
   %(prefix)s       - 'prefix ' string passed on the command line
   %(shortdescr)s   - the first line of the patch description"""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-a', '--all',
                        help =3D 'e-mail all the applied patches',
                        action =3D 'store_true'),
diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 59671ab..ccc8141 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -38,6 +38,7 @@ needed for this.
 If no name is given for the new patch, one is generated from the first
 line of the commit message."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-m', '--message',
                        help =3D 'use MESSAGE as the patch description'=
),
            make_option('-s', '--showpatch',
diff --git a/stgit/commands/patches.py b/stgit/commands/patches.py
index fb65b62..0b618fe 100644
--- a/stgit/commands/patches.py
+++ b/stgit/commands/patches.py
@@ -33,6 +33,7 @@ it shows the patches affected by the local tree modif=
ications. The
 '--diff' option also lists the patch log and the diff for the given
 files."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-d', '--diff',
                        help =3D 'show the diff for the given files',
                        action =3D 'store_true'),
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index 1c3ef11..3acec32 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -34,6 +34,7 @@ the name of the current patch. It can be overridden w=
ith the '--name'
 option. A commit object can be reverted with the '--reverse'
 option. The log and author information are those of the commit object.=
"""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-n', '--name',
                        help =3D 'use NAME as the patch name'),
            make_option('-r', '--reverse',
diff --git a/stgit/commands/pop.py b/stgit/commands/pop.py
index 0dfaad9..a1d73e4 100644
--- a/stgit/commands/pop.py
+++ b/stgit/commands/pop.py
@@ -36,6 +36,7 @@ patches passed on the command line are popped from th=
e stack. Some of
 the push operations may fail because of conflicts (push --undo would
 revert the last push operation)."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-a', '--all',
                        help =3D 'pop all the applied patches',
                        action =3D 'store_true'),
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 237bdd9..5fcf2cc 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -38,6 +38,7 @@ resolved and the patch pushed again.
=20
 Check the 'git fetch' documentation for the <repository> format."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-n', '--nopush',
                        help =3D 'do not push the patches back after pu=
lling',
                        action =3D 'store_true'),
diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index 53cdb8f..b91bc5e 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -39,6 +39,7 @@ command run.
 The command also notifies when the patch becomes empty (fully merged
 upstream) or is modified (three-way merged) by the 'push' operation.""=
"
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-a', '--all',
                        help =3D 'push all the unapplied patches',
                        action =3D 'store_true'),
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index 513729a..bbb3e12 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -29,6 +29,7 @@ usage =3D """%prog [options] <new-base-id>
 Pop all patches from current stack, move the stack base to the given
 <new-base-id> and push the patches back."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-n', '--nopush',
                        help =3D 'do not push the patches back after re=
basing',
                        action =3D 'store_true'),
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 241f065..b283892 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -37,6 +37,7 @@ options. The '--force' option is useful when a commit=
 object was
 created with a different tool but the changes need to be included in
 the current patch."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-f', '--force',
                        help =3D 'force the refresh even if HEAD and '\
                        'top differ',
diff --git a/stgit/commands/rename.py b/stgit/commands/rename.py
index 2830e72..e2b0fa4 100644
--- a/stgit/commands/rename.py
+++ b/stgit/commands/rename.py
@@ -29,6 +29,7 @@ usage =3D """%prog [options] <oldpatch> <newpatch>
=20
 Rename <oldpatch> into <newpatch> in a series."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
')]
=20
diff --git a/stgit/commands/resolved.py b/stgit/commands/resolved.py
index 1130641..c2ef678 100644
--- a/stgit/commands/resolved.py
+++ b/stgit/commands/resolved.py
@@ -34,6 +34,7 @@ Mark a merge conflict as resolved. The conflicts can =
be seen with the
 'C'. This command also removes any <file>.{ancestor,current,patched}
 files."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-a', '--all',
                        help =3D 'mark all conflicts as solved',
                        action =3D 'store_true'),
diff --git a/stgit/commands/rm.py b/stgit/commands/rm.py
index 91908a1..59d098b 100644
--- a/stgit/commands/rm.py
+++ b/stgit/commands/rm.py
@@ -30,6 +30,7 @@ usage =3D """%prog [options] <files...>
 Remove given files from the repository. The command doesn't remove the
 working copy of the file."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-f', '--force',
                        help =3D 'force removing even if the file exist=
s',
                        action =3D 'store_true')]
diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index 00a3372..2c75876 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -34,6 +34,7 @@ range. The applied patches are prefixed with a '+', t=
he unapplied ones
 with a '-' and the hidden ones with a '!'. The current patch is
 prefixed with a '>'. Empty patches are prefixed with a '0'."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
            make_option('-a', '--all',
diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index 45ca253..7efb4e1 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -30,6 +30,7 @@ Show the commit log and the diff corresponding to the=
 given
 patches. The output is similar to that generated by the 'git show'
 command."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
            make_option('-a', '--applied',
diff --git a/stgit/commands/sink.py b/stgit/commands/sink.py
index 2a18ebc..737dde0 100644
--- a/stgit/commands/sink.py
+++ b/stgit/commands/sink.py
@@ -32,6 +32,7 @@ push the specified <patches> (the current patch by de=
fault), and
 then push back into place the formerly-applied patches (unless -n
 is also given)."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-n', '--nopush',
                        help =3D 'do not push the patches back after si=
nking',
                        action =3D 'store_true'),
diff --git a/stgit/commands/status.py b/stgit/commands/status.py
index b2835ab..a688f7e 100644
--- a/stgit/commands/status.py
+++ b/stgit/commands/status.py
@@ -40,6 +40,7 @@ under revision control. The files are prefixed as fol=
lows:
 A 'refresh' command clears the status of the modified, new and deleted
 files."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-m', '--modified',
                        help =3D 'show modified files only',
                        action =3D 'store_true'),
diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index 580b5bd..8a31c29 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -36,6 +36,7 @@ in the series must apply cleanly.
=20
 The sync operation can be reverted for individual patches with --undo.=
"""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-a', '--all',
                        help =3D 'synchronise all the patches',
                        action =3D 'store_true'),
diff --git a/stgit/commands/top.py b/stgit/commands/top.py
index 1a9267a..e7cb275 100644
--- a/stgit/commands/top.py
+++ b/stgit/commands/top.py
@@ -30,6 +30,7 @@ usage =3D """%prog [options]
=20
 Print the name of the current (topmost) patch."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
')]
=20
diff --git a/stgit/commands/unapplied.py b/stgit/commands/unapplied.py
index c6408a3..d5bb43e 100644
--- a/stgit/commands/unapplied.py
+++ b/stgit/commands/unapplied.py
@@ -31,6 +31,7 @@ usage =3D """%prog [options]
 List the patches from the series which are not pushed onto the stack.
 They are listed in the reverse order in which they were popped."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
            make_option('-c', '--count',
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index c22d3ea..a23ae20 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -48,6 +48,7 @@ given commit should be uncommitted.
 Only commits with exactly one parent can be uncommitted; in other
 words, you can't uncommit a merge."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-n', '--number', type =3D 'int',
                        help =3D 'uncommit the specified number of comm=
its'),
            make_option('-t', '--to',
diff --git a/stgit/commands/unhide.py b/stgit/commands/unhide.py
index 0a1dcaf..665d664 100644
--- a/stgit/commands/unhide.py
+++ b/stgit/commands/unhide.py
@@ -30,6 +30,7 @@ usage =3D """%prog [options] <patch-range>
 Unhide a hidden range of patches so that they are shown in the plain
 'series' command output."""
=20
+directory =3D DirectoryHasRepository()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
')]
=20
diff --git a/stgit/main.py b/stgit/main.py
index 19ba2bd..15582dd 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -252,6 +252,7 @@ def main():
     usage =3D command.usage.split('\n')[0].strip()
     parser =3D OptionParser(usage =3D usage, option_list =3D command.o=
ptions)
     options, args =3D parser.parse_args()
+    directory =3D command.directory
=20
     # These modules are only used from this point onwards and do not
     # need to be imported earlier
@@ -267,6 +268,7 @@ def main():
         sys.exit(1)
=20
     try:
+        directory.setup()
         config_setup()
=20
         # 'clone' doesn't expect an already initialised GIT tree. A Se=
ries
