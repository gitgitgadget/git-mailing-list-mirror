From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Write to a stack log when stack is modified
Date: Mon, 30 Jun 2008 03:02:32 +0200
Message-ID: <20080630005428.22637.10732.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 03:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD7pF-0005A6-0i
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 03:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029AbYF3BDY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 21:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756149AbYF3BDY
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 21:03:24 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4728 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbYF3BCk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 21:02:40 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KD7mr-0003th-00; Mon, 30 Jun 2008 02:02:33 +0100
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86853>

Create a log branch (called <branchname>.stgit) for each StGit branch,
and write to it whenever the stack is modified.

Commands using the new infrastructure write to the log when they
commit a transaction. Commands using the old infrastructure get a log
entry write written for them when they exit, unless they explicitly
ask for this not to happen.

The only thing you can do with this log at the moment is look at it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Now rewritten to use a log format that should be more efficient (see
the docs at the top of lib/log.py). There is still a simplified log,
but it's not expensive since we recompute only the parts that have
changed since the last log entry.

A few of the other patches in the series had to be fixed up as well,
but mostly trivially since the interface between the log stuff and the
rest did not change; I won't spam the list with them. I'll be pushing
out the updated series to

  git://repo.or.cz/stgit/kha.git experimental

in a few minutes.

 stgit/commands/branch.py  |   19 ++-
 stgit/commands/common.py  |    8 +
 stgit/commands/diff.py    |    2=20
 stgit/commands/files.py   |    2=20
 stgit/commands/id.py      |    2=20
 stgit/commands/log.py     |    2=20
 stgit/commands/mail.py    |    2=20
 stgit/commands/patches.py |    2=20
 stgit/commands/show.py    |    2=20
 stgit/commands/status.py  |    3=20
 stgit/lib/git.py          |    3=20
 stgit/lib/log.py          |  340 +++++++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py        |    9 +
 stgit/lib/transaction.py  |    3=20
 stgit/main.py             |    2=20
 15 files changed, 384 insertions(+), 17 deletions(-)
 create mode 100644 stgit/lib/log.py


diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 50684bb..edbb01c 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -25,7 +25,7 @@ from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
 from stgit import stack, git, basedir
-
+from stgit.lib import log
=20
 help =3D 'manage patch stacks'
 usage =3D """%prog [options] branch-name [commit-id]
@@ -40,7 +40,7 @@ When displaying the branches, the names can be prefix=
ed with
=20
 If not given any options, switch to the named branch."""
=20
-directory =3D DirectoryGotoToplevel()
+directory =3D DirectoryGotoToplevel(log =3D False)
 options =3D [make_option('-c', '--create',
                        help =3D 'create a new development branch',
                        action =3D 'store_true'),
@@ -161,6 +161,7 @@ def func(parser, options, args):
                                    parent_branch =3D parentbranch)
=20
         out.info('Branch "%s" created' % args[0])
+        log.compat_log_entry('branch --create')
         return
=20
     elif options.clone:
@@ -181,6 +182,8 @@ def func(parser, options, args):
         crt_series.clone(clone)
         out.done()
=20
+        log.copy_log(log.default_repo(), crt_series.get_name(), clone,
+                     'branch --clone')
         return
=20
     elif options.delete:
@@ -188,6 +191,7 @@ def func(parser, options, args):
         if len(args) !=3D 1:
             parser.error('incorrect number of arguments')
         __delete_branch(args[0], options.force)
+        log.delete_log(log.default_repo(), args[0])
         return
=20
     elif options.list:
@@ -195,13 +199,16 @@ def func(parser, options, args):
         if len(args) !=3D 0:
             parser.error('incorrect number of arguments')
=20
-        branches =3D git.get_heads()
-        branches.sort()
+        branches =3D set(git.get_heads())
+        for br in set(branches):
+            m =3D re.match(r'^(.*)\.stgit$', br)
+            if m and m.group(1) in branches:
+                branches.remove(br)
=20
         if branches:
             out.info('Available branches:')
             max_len =3D max([len(i) for i in branches])
-            for i in branches:
+            for i in sorted(branches):
                 __print_branch(i, max_len)
         else:
             out.info('No branches')
@@ -238,7 +245,7 @@ def func(parser, options, args):
         stack.Series(args[0]).rename(args[1])
=20
         out.info('Renamed branch "%s" to "%s"' % (args[0], args[1]))
-
+        log.rename_log(log.default_repo(), args[0], args[1], 'branch -=
-rename')
         return
=20
     elif options.unprotect:
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 029ec65..fd02398 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -28,6 +28,7 @@ from stgit.run import *
 from stgit import stack, git, basedir
 from stgit.config import config, file_extensions
 from stgit.lib import stack as libstack
+from stgit.lib import log
=20
 # Command exception class
 class CmdException(StgException):
@@ -478,8 +479,9 @@ class DirectoryException(StgException):
     pass
=20
 class _Directory(object):
-    def __init__(self, needs_current_series =3D True):
+    def __init__(self, needs_current_series =3D True, log =3D True):
         self.needs_current_series =3D  needs_current_series
+        self.log =3D log
     @readonly_constant_property
     def git_dir(self):
         try:
@@ -512,6 +514,9 @@ class _Directory(object):
                        ).output_one_line()]
     def cd_to_topdir(self):
         os.chdir(self.__topdir_path)
+    def write_log(self, msg):
+        if self.log:
+            log.compat_log_entry(msg)
=20
 class DirectoryAnywhere(_Directory):
     def setup(self):
@@ -536,6 +541,7 @@ class DirectoryHasRepositoryLib(_Directory):
     """For commands that use the new infrastructure in stgit.lib.*."""
     def __init__(self):
         self.needs_current_series =3D False
+        self.log =3D False # stgit.lib.transaction handles logging
     def setup(self):
         # This will throw an exception if we don't have a repository.
         self.repository =3D libstack.Repository.default()
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index fd6be34..8966642 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -42,7 +42,7 @@ rev =3D '([patch][//[bottom | top]]) | <tree-ish> | b=
ase'
 If neither bottom nor top are given but a '//' is present, the command
 shows the specified patch (defaulting to the current one)."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-r', '--range',
                        metavar =3D 'rev1[..[rev2]]', dest =3D 'revs',
                        help =3D 'show the diff between revisions'),
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index b43b12f..7844f8d 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -34,7 +34,7 @@ given patch. Note that this command doesn't show the =
files modified in
 the working tree and not yet included in the patch by a 'refresh'
 command. Use the 'diff' or 'status' commands for these files."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-s', '--stat',
                        help =3D 'show the diff stat',
                        action =3D 'store_true'),
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index 94b0229..5bb1ad2 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -33,7 +33,7 @@ the standard GIT id's like heads and tags, this comma=
nd also accepts
 'top' or 'bottom' are passed and <patch> is a valid patch name, 'top'
 will be used by default."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
')]
=20
diff --git a/stgit/commands/log.py b/stgit/commands/log.py
index 52d55a5..13e0baa 100644
--- a/stgit/commands/log.py
+++ b/stgit/commands/log.py
@@ -44,7 +44,7 @@ represent the changes to the entire base of the curre=
nt
 patch. Conflicts reset the patch content and a subsequent 'refresh'
 will show the entire patch."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
            make_option('-p', '--patch',
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index b4d4e18..4027170 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -90,7 +90,7 @@ the following:
   %(prefix)s       - 'prefix ' string passed on the command line
   %(shortdescr)s   - the first line of the patch description"""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-a', '--all',
                        help =3D 'e-mail all the applied patches',
                        action =3D 'store_true'),
diff --git a/stgit/commands/patches.py b/stgit/commands/patches.py
index 140699d..c95c40f 100644
--- a/stgit/commands/patches.py
+++ b/stgit/commands/patches.py
@@ -33,7 +33,7 @@ it shows the patches affected by the local tree modif=
ications. The
 '--diff' option also lists the patch log and the diff for the given
 files."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-d', '--diff',
                        help =3D 'show the diff for the given files',
                        action =3D 'store_true'),
diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index b77a9c8..dd2a3a3 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -30,7 +30,7 @@ Show the commit log and the diff corresponding to the=
 given
 patches. The output is similar to that generated by the 'git show'
 command."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
            make_option('-a', '--applied',
diff --git a/stgit/commands/status.py b/stgit/commands/status.py
index a5b2f88..4d13112 100644
--- a/stgit/commands/status.py
+++ b/stgit/commands/status.py
@@ -40,7 +40,7 @@ under revision control. The files are prefixed as fol=
lows:
 A 'refresh' command clears the status of the modified, new and deleted
 files."""
=20
-directory =3D DirectoryHasRepository(needs_current_series =3D False)
+directory =3D DirectoryHasRepository(needs_current_series =3D False, l=
og =3D False)
 options =3D [make_option('-m', '--modified',
                        help =3D 'show modified files only',
                        action =3D 'store_true'),
@@ -106,6 +106,7 @@ def func(parser, options, args):
     directory.cd_to_topdir()
=20
     if options.reset:
+        directory.log =3D True
         if args:
             conflicts =3D git.get_conflicts()
             git.resolved([fn for fn in args if fn in conflicts])
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index a8881f4..35e03d2 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -139,6 +139,7 @@ class Person(Immutable, Repr):
         assert isinstance(self.__date, Date) or self.__date in [None, =
NoValue]
     name =3D property(lambda self: self.__name)
     email =3D property(lambda self: self.__email)
+    name_email =3D property(lambda self: '%s <%s>' % (self.name, self.=
email))
     date =3D property(lambda self: self.__date)
     def set_name(self, name):
         return type(self)(name =3D name, defaults =3D self)
@@ -147,7 +148,7 @@ class Person(Immutable, Repr):
     def set_date(self, date):
         return type(self)(date =3D date, defaults =3D self)
     def __str__(self):
-        return '%s <%s> %s' % (self.name, self.email, self.date)
+        return '%s %s' % (self.name_email, self.date)
     @classmethod
     def parse(cls, s):
         m =3D re.match(r'^([^<]*)<([^>]*)>\s+(\d+\s+[+-]\d{4})$', s)
diff --git a/stgit/lib/log.py b/stgit/lib/log.py
new file mode 100644
index 0000000..1188b24
--- /dev/null
+++ b/stgit/lib/log.py
@@ -0,0 +1,340 @@
+r"""This module contains functions and classes for manipulating
+I{patch stack logs} (or just I{stack logs}).
+
+A stack log is a git branch. Each commit contains the complete state
+of the stack at the moment it was written; the most recent commit has
+the most recent state.
+
+For a branch C{I{foo}}, the stack log is stored in C{I{foo}.stgit}.
+
+Stack log format (full)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Commit message
+--------------
+
+First comes a message for human consumption; in most cases it is just
+a subject line: the stg subcommand name and possibly some important
+command-line flag.
+
+An exception to this is log commits for undo and redo. Their subject
+line is "C{undo I{n}}" and "C{redo I{n}}"; the positive integer I{n}
+says how many steps were undone or redone.
+
+Following the message is a newline, three dashes, and another newline.
+Then come, each on its own line,
+
+  - C{Version:} I{n}
+
+    where I{n} must be 0. (Future versions of StGit might change the
+    log format; when this is done, this version number will be
+    incremented.)
+
+  - C{Previous:} I{sha1 or C{None}}
+
+    The commit of the previous log entry, or C{None} if this is the
+    first entry.
+
+  - C{Head:} I{sha1}
+
+    The current branch head.
+
+  - C{Applied:}
+
+    Marks the start of the list of applied patches. They are listed in
+    order, each on its own line: first one or more spaces, then the
+    patch name, then a colon, then the patch's sha1.
+
+  - C{Unapplied:}
+
+    Same as C{Applied:}, but for the unapplied patches.
+
+Tree
+----
+
+The tree is not significant.
+
+Parents
+-------
+
+  - The first parent is the I{simplified log}, described below.
+
+  - The rest of the parents are just there to make sure that all the
+    commits referred to in the log entry -- patches, branch head,
+    previous log entry -- are ancestors of the log commit.
+
+Stack log format (simplified)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+The simplified log contains no information not in the full log; its
+purpose is ease of visualization.
+
+Commit message
+--------------
+
+Same as for the full log, but just the message part; the three dashes
+and the log data are omitted.
+
+Tree
+----
+
+  - One blob, C{meta}, that contains the log data (but not the three
+    dashes) that was omitted from the commit message.
+
+  - One subtree, C{patches}, that contains one blob per patch::
+
+      Bottom: <sha1 of patch's bottom tree>
+      Top:    <sha1 of patch's top tree>
+      Author: <author name and e-mail>
+      Date:   <patch timestamp>
+
+      <commit message>
+
+      ---
+
+      <patch diff>
+
+Parents
+-------
+
+Just one parent: the simplified version of the previous log entry. (If
+there is no previous log entry, there are no parents.)"""
+
+from stgit.lib import git, stack
+from stgit import exception, utils
+from stgit.out import out
+import StringIO
+
+class LogException(exception.StgException):
+    pass
+
+class LogParseException(LogException):
+    pass
+
+def patch_file(repo, cd):
+    return repo.commit(git.BlobData(''.join(s + '\n' for s in [
+                    'Bottom: %s' % cd.parent.data.tree.sha1,
+                    'Top:    %s' % cd.tree.sha1,
+                    'Author: %s' % cd.author.name_email,
+                    'Date:   %s' % cd.author.date,
+                    '',
+                    cd.message,
+                    '',
+                    '---',
+                    '',
+                    repo.diff_tree(cd.parent.data.tree, cd.tree, ['-M'=
]
+                                   ).strip()])))
+
+def log_ref(branch):
+    return 'refs/heads/%s.stgit' % branch
+
+class LogEntry(object):
+    __separator =3D '\n---\n'
+    __max_parents =3D 16
+    def __init__(self, repo, prev, head, applied, unapplied, patches, =
message):
+        self.__repo =3D repo
+        self.__prev =3D prev
+        self.head =3D head
+        self.applied =3D applied
+        self.unapplied =3D unapplied
+        self.patches =3D patches
+        self.message =3D message
+    @property
+    def prev(self):
+        if self.__prev !=3D None and not isinstance(self.__prev, LogEn=
try):
+            self.__prev =3D self.__from_commit_full(self.__repo, self.=
__prev)
+        return self.__prev
+    @classmethod
+    def from_stack(cls, prev, stack, message):
+        return cls(
+            repo =3D stack.repository,
+            prev =3D prev,
+            head =3D stack.head,
+            applied =3D list(stack.patchorder.applied),
+            unapplied =3D list(stack.patchorder.unapplied),
+            patches =3D dict((pn, stack.patches.get(pn).commit)
+                           for pn in stack.patchorder.all),
+            message =3D message)
+    @staticmethod
+    def __parse_metadata(repo, metadata):
+        """Parse a stack log metadata string."""
+        if not metadata.startswith('Version:'):
+            raise LogParseException('Malformed log metadata')
+        metadata =3D metadata.splitlines()
+        version_str =3D utils.strip_leading('Version:', metadata.pop(0=
)).strip()
+        try:
+            version =3D int(version_str)
+        except ValueError:
+            raise LogParseException(
+                'Malformed version number: %r' % version_str)
+        if version !=3D 0:
+            raise LogException('Log is version %d, which is too new' %=
 version)
+        parsed =3D {}
+        for line in metadata:
+            if line.startswith(' '):
+                parsed[key].append(line.strip())
+            else:
+                key, val =3D [x.strip() for x in line.split(':', 1)]
+                if val:
+                    parsed[key] =3D val
+                else:
+                    parsed[key] =3D []
+        prev =3D parsed['Previous']
+        if prev =3D=3D 'None':
+            prev =3D None
+        else:
+            prev =3D repo.get_commit(prev)
+        head =3D repo.get_commit(parsed['Head'])
+        lists =3D { 'Applied': [], 'Unapplied': [] }
+        patches =3D {}
+        for lst in lists.keys():
+            for entry in parsed[lst]:
+                pn, sha1 =3D [x.strip() for x in entry.split(':')]
+                lists[lst].append(pn)
+                patches[pn] =3D repo.get_commit(sha1)
+        return (prev, head, lists['Applied'], lists['Unapplied'], patc=
hes)
+    @classmethod
+    def __from_commit_full(cls, repo, commit):
+        """Parse a full stack log commit."""
+        if not cls.__separator in commit.data.message:
+            raise LogParseException('Not a full log')
+        message, metadata =3D commit.data.message.rsplit(cls.__separat=
or, 1)
+        (prev, head, applied, unapplied, patches
+         ) =3D cls.__parse_metadata(repo, metadata)
+        lg =3D cls(repo, prev, head, applied, unapplied, patches, mess=
age)
+        lg.simplified =3D commit.data.parents[0]
+        lg.commit =3D commit
+        return lg
+    @classmethod
+    def __from_commit_simplified(cls, repo, commit):
+        """Parse a simplified stack log commit."""
+        message =3D commit.data.message
+        try:
+            perm, meta =3D commit.data.tree.data.entries['meta']
+        except KeyError:
+            raise LogParseException('Not a simplified log')
+        (prev, head, applied, unapplied, patches
+         ) =3D cls.__parse_metadata(repo, meta.data.str)
+        lg =3D cls(repo, prev, head, applied, unapplied, patches, mess=
age)
+        lg.simplified =3D commit
+        return lg
+    @classmethod
+    def from_commit(cls, repo, commit):
+        """Parse a stack log commit, either full or simplified."""
+        try:
+            return cls.__from_commit_full(repo, commit)
+        except LogException, e:
+            full_exc =3D e
+        try:
+            return cls.__from_commit_simplified(repo, commit)
+        except LogParseException, e:
+            # Couldn't parse it as a simplified log. Raise the
+            # exception we got while trying to parse it as a full log,
+            # since that exception might be more informative than a
+            # simple parse exception.
+            raise full_exc
+    def __metadata_string(self):
+        e =3D StringIO.StringIO()
+        e.write('Version: 0\n')
+        if self.prev =3D=3D None:
+            e.write('Previous: None\n')
+        else:
+            e.write('Previous: %s\n' % self.prev.commit.sha1)
+        e.write('Head: %s\n' % self.head.sha1)
+        for lst, title in [(self.applied, 'Applied'),
+                           (self.unapplied, 'Unapplied')]:
+            e.write('%s:\n' % title)
+            for pn in lst:
+                e.write('  %s: %s\n' % (pn, self.patches[pn].sha1))
+        return e.getvalue()
+    def __parents(self):
+        """Return the set of parents this log entry needs in order to =
be a
+        descendant of all the commits it refers to."""
+        xp =3D set([self.head]) | set(self.patches[pn] for pn in self.=
unapplied)
+        if self.applied:
+            xp.add(self.patches[self.applied[-1]])
+        if self.prev !=3D None:
+            xp.add(self.prev.commit)
+            xp -=3D set(self.prev.patches.values())
+        return xp
+    def __simplified_tree(self, metadata):
+        if self.prev =3D=3D None:
+            def pf(c):
+                return patch_file(self.__repo, c.data)
+        else:
+            prev_top_tree =3D self.prev.simplified.data.tree
+            perm, prev_patch_tree =3D prev_top_tree.data.entries['patc=
hes']
+            # Map from Commit object to patch_file() results taken
+            # from the previous log entry.
+            c2b =3D dict((self.prev.patches[pn], pf) for pn, pf
+                       in prev_patch_tree.data.entries.iteritems())
+            def pf(c):
+                r =3D c2b.get(c, None)
+                if not r:
+                    r =3D patch_file(self.__repo, c.data)
+                return r
+        patches =3D dict((pn, pf(c)) for pn, c in self.patches.iterite=
ms())
+        return self.__repo.commit(git.TreeData({
+                    'meta': self.__repo.commit(git.BlobData(metadata))=
,
+                    'patches': self.__repo.commit(git.TreeData(patches=
)) }))
+    def write_commit(self):
+        metadata =3D self.__metadata_string()
+        self.simplified =3D self.__repo.commit(git.CommitData(
+                tree =3D self.__simplified_tree(metadata),
+                parents =3D [prev.simplified for prev in [self.prev]
+                           if prev !=3D None],
+                message =3D self.message))
+        parents =3D list(self.__parents())
+        while len(parents) > self.__max_parents - 1:
+            g =3D self.__repo.commit(git.CommitData(
+                    tree =3D self.head.data.tree,
+                    parents =3D parents[-self.__max_parents:],
+                    message =3D 'Stack log parent grouping'))
+            parents[-self.__max_parents:] =3D [g]
+        self.commit =3D self.__repo.commit(git.CommitData(
+                tree =3D self.head.data.tree,
+                parents =3D [self.simplified] + parents,
+                message =3D self.message + self.__separator + metadata=
))
+
+def log_entry(stack, msg):
+    """Write a new log entry for the stack."""
+    ref =3D log_ref(stack.name)
+    try:
+        last_log =3D stack.repository.refs.get(ref)
+    except KeyError:
+        last_log =3D None
+    try:
+        new_log =3D LogEntry.from_stack(last_log, stack, msg)
+    except LogException, e:
+        out.warn(str(e), 'No log entry written.')
+        return
+    new_log.write_commit()
+    stack.repository.refs.set(ref, new_log.commit, msg)
+
+def compat_log_entry(msg):
+    """Write a new log entry. (Convenience function intended for use b=
y
+    code not yet converted to the new infrastructure.)"""
+    repo =3D default_repo()
+    stack =3D repo.get_stack(repo.current_branch_name)
+    log_entry(stack, msg)
+
+def delete_log(repo, branch):
+    ref =3D log_ref(branch)
+    if repo.refs.exists(ref):
+        repo.refs.delete(ref)
+
+def rename_log(repo, old_branch, new_branch, msg):
+    old_ref =3D log_ref(old_branch)
+    new_ref =3D log_ref(new_branch)
+    if repo.refs.exists(old_ref):
+        repo.refs.set(new_ref, repo.refs.get(old_ref), msg)
+        repo.refs.delete(old_ref)
+
+def copy_log(repo, src_branch, dst_branch, msg):
+    src_ref =3D log_ref(src_branch)
+    dst_ref =3D log_ref(dst_branch)
+    if repo.refs.exists(src_ref):
+        repo.refs.set(dst_ref, repo.refs.get(src_ref), msg)
+
+def default_repo():
+    return stack.Repository.default()
diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index 9cb3967..62a1ec2 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -165,6 +165,15 @@ class Stack(git.Branch):
                                     ).commit.data.parent
         else:
             return self.head
+    @property
+    def top(self):
+        """Commit of the topmost patch, or the stack base if no patche=
s are
+        applied."""
+        if self.patchorder.applied:
+            return self.patches.get(self.patchorder.applied[-1]).commi=
t
+        else:
+            # When no patches are applied, base =3D=3D head.
+            return self.head
     def head_top_equal(self):
         if not self.patchorder.applied:
             return True
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index e47997e..4c4da1a 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -4,7 +4,7 @@ updates to an StGit stack in a safe and convenient way.=
"""
 from stgit import exception, utils
 from stgit.utils import any, all
 from stgit.out import *
-from stgit.lib import git
+from stgit.lib import git, log
=20
 class TransactionException(exception.StgException):
     """Exception raised when something goes wrong with a
@@ -170,6 +170,7 @@ class StackTransaction(object):
         _print_current_patch(self.__stack.patchorder.applied, self.__a=
pplied)
         self.__stack.patchorder.applied =3D self.__applied
         self.__stack.patchorder.unapplied =3D self.__unapplied
+        log.log_entry(self.__stack, self.__msg)
=20
         if self.__error:
             return utils.STGIT_CONFLICT
diff --git a/stgit/main.py b/stgit/main.py
index aa1f8ef..ec0e840 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -277,6 +277,7 @@ def main():
=20
         ret =3D command.func(parser, options, args)
     except (StgException, IOError, ParsingError, NoSectionError), err:
+        directory.write_log(cmd)
         out.error(str(err), title =3D '%s %s' % (prog, cmd))
         if debug_level > 0:
             traceback.print_exc()
@@ -292,4 +293,5 @@ def main():
         traceback.print_exc()
         sys.exit(utils.STGIT_BUG_ERROR)
=20
+    directory.write_log(cmd)
     sys.exit(ret or utils.STGIT_SUCCESS)
