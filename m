From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 1/2] Handle branch names with slashes
Date: Thu, 18 May 2006 08:42:14 +0200
Message-ID: <20060518064214.GA10390@backpacker.hemma.treskal.com>
References: <20060516074504.GA27234@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 18 08:42:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgcDG-0003MC-PV
	for gcvg-git@gmane.org; Thu, 18 May 2006 08:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWERGmT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 18 May 2006 02:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWERGmT
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 02:42:19 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:60634 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751237AbWERGmT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 02:42:19 -0400
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep02.bredband.com with ESMTP
          id <20060518064216.OQOB29698.mxfep02.bredband.com@backpacker.hemma.treskal.com>;
          Thu, 18 May 2006 08:42:16 +0200
Received: by backpacker.hemma.treskal.com (Postfix, from userid 1000)
	id A8EF9259B; Thu, 18 May 2006 08:42:15 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060516074504.GA27234@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20264>

Teach stgit to handle branch names with slashes in them; that is,
branches living in a subdirectory of .git/refs/heads.

I had to change the patch@branch/top command-line syntax to
patch@branch%top, in order to get sane parsing. The /top variant is
still available for repositories that have no slashy branches; it is
disabled as soon as there exists at least one subdirectory of
refs/heads. Preferably, this compatibility hack can be killed some
time in the future.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>


---

 stgit/commands/branch.py |    5 ++
 stgit/commands/common.py |  108 +++++++++++++++++++++++++++-----------=
--------
 stgit/commands/diff.py   |   16 ++++---
 stgit/commands/files.py  |    4 +-
 stgit/commands/id.py     |    2 -
 stgit/commands/mail.py   |    8 ++-
 stgit/git.py             |   42 +++++++++---------
 stgit/stack.py           |   21 ++++++---
 stgit/utils.py           |   88 +++++++++++++++++++++++++++++++++++--
 9 files changed, 202 insertions(+), 92 deletions(-)

fb5b39c8867474f4b23f0b52c4090c76aee6b1e8
diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 2218bbb..d348409 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -172,7 +172,10 @@ def func(parser, options, args):
         if len(args) !=3D 0:
             parser.error('incorrect number of arguments')
=20
-        branches =3D os.listdir(os.path.join(basedir.get(), 'refs', 'h=
eads'))
+        branches =3D []
+        basepath =3D os.path.join(basedir.get(), 'refs', 'heads')
+        for path, files, dirs in walk_tree(basepath):
+            branches +=3D [os.path.join(path, f) for f in files]
         branches.sort()
=20
         if branches:
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index c6ca514..93344aa 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -18,7 +18,7 @@ along with this program; if not, write t
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-import sys, os, re
+import sys, os, os.path, re
 from optparse import OptionParser, make_option
=20
 from stgit.utils import *
@@ -34,54 +34,74 @@ class CmdException(Exception):
=20
=20
 # Utility functions
+class RevParseException(Exception):
+    """Revision spec parse error."""
+    pass
+
+def parse_rev(rev):
+    """Parse a revision specification into its
+    patchname@branchname//patch_id parts. If no branch name has a slas=
h
+    in it, also accept / instead of //."""
+    files, dirs =3D list_files_and_dirs(os.path.join(basedir.get(),
+                                                   'refs', 'heads'))
+    if len(dirs) !=3D 0:
+        # We have branch names with / in them.
+        branch_chars =3D r'[^@]'
+        patch_id_mark =3D r'//'
+    else:
+        # No / in branch names.
+        branch_chars =3D r'[^@%/]'
+        patch_id_mark =3D r'(/|//)'
+    patch_re =3D r'(?P<patch>[^@/]+)'
+    branch_re =3D r'@(?P<branch>%s+)' % branch_chars
+    patch_id_re =3D r'%s(?P<patch_id>[a-z.]*)' % patch_id_mark
+
+    # Try //patch_id.
+    m =3D re.match(r'^%s$' % patch_id_re, rev)
+    if m:
+        return None, None, m.group('patch_id')
+
+    # Try path[@branch]//patch_id.
+    m =3D re.match(r'^%s(%s)?%s$' % (patch_re, branch_re, patch_id_re)=
, rev)
+    if m:
+        return m.group('patch'), m.group('branch'), m.group('patch_id'=
)
+
+    # Try patch[@branch].
+    m =3D re.match(r'^%s(%s)?$' % (patch_re, branch_re), rev)
+    if m:
+        return m.group('patch'), m.group('branch'), None
+
+    # No, we can't parse that.
+    raise RevParseException
+
 def git_id(rev):
     """Return the GIT id
     """
     if not rev:
         return None
-   =20
-    rev_list =3D rev.split('/')
-    if len(rev_list) =3D=3D 2:
-        patch_id =3D rev_list[1]
-        if not patch_id:
-            patch_id =3D 'top'
-    elif len(rev_list) =3D=3D 1:
-        patch_id =3D 'top'
-    else:
-        patch_id =3D None
-
-    patch_branch =3D rev_list[0].split('@')
-    if len(patch_branch) =3D=3D 1:
-        series =3D crt_series
-    elif len(patch_branch) =3D=3D 2:
-        series =3D stack.Series(patch_branch[1])
-    else:
-        raise CmdException, 'Unknown id: %s' % rev
-
-    patch_name =3D patch_branch[0]
-    if not patch_name:
-        patch_name =3D series.get_current()
-        if not patch_name:
-            raise CmdException, 'No patches applied'
-
-    # patch
-    if patch_name in series.get_applied() \
-           or patch_name in series.get_unapplied():
-        if patch_id =3D=3D 'top':
-            return series.get_patch(patch_name).get_top()
-        elif patch_id =3D=3D 'bottom':
-            return series.get_patch(patch_name).get_bottom()
-        # Note we can return None here.
-        elif patch_id =3D=3D 'top.old':
-            return series.get_patch(patch_name).get_old_top()
-        elif patch_id =3D=3D 'bottom.old':
-            return series.get_patch(patch_name).get_old_bottom()
-
-    # base
-    if patch_name =3D=3D 'base' and len(rev_list) =3D=3D 1:
-        return read_string(series.get_base_file())
-
-    # anything else failed
+    try:
+        patch, branch, patch_id =3D parse_rev(rev)
+        if branch =3D=3D None:
+            series =3D crt_series
+        else:
+            series =3D stack.Series(branch)
+        if patch =3D=3D None:
+            patch =3D series.get_current()
+            if not patch:
+                raise CmdException, 'No patches applied'
+        if patch in series.get_applied() or patch in series.get_unappl=
ied():
+            if patch_id in ['top', '', None]:
+                return series.get_patch(patch).get_top()
+            elif patch_id =3D=3D 'bottom':
+                return series.get_patch(patch).get_bottom()
+            elif patch_id =3D=3D 'top.old':
+                return series.get_patch(patch).get_old_top()
+            elif patch_id =3D=3D 'bottom.old':
+                return series.get_patch(patch).get_old_bottom()
+        if patch =3D=3D 'base' and patch_id =3D=3D None:
+            return read_string(series.get_base_file())
+    except RevParseException:
+        pass
     return git.rev_parse(rev + '^{commit}')
=20
 def check_local_changes():
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index 7dc6c5d..d765784 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -33,12 +33,12 @@ or a tree-ish object and another tree-is
 be given to restrict the diff output. The tree-ish object can be a
 standard git commit, tag or tree. In addition to these, the command
 also supports 'base', representing the bottom of the current stack,
-and '[patch]/[bottom | top]' for the patch boundaries (defaulting to
+and '[patch][//[bottom | top]]' for the patch boundaries (defaulting t=
o
 the current one):
=20
-rev =3D '([patch]/[bottom | top]) | <tree-ish> | base'
+rev =3D '([patch][//[bottom | top]]) | <tree-ish> | base'
=20
-If neither bottom or top are given but a '/' is present, the command
+If neither bottom nor top are given but a '//' is present, the command
 shows the specified patch (defaulting to the current one)."""
=20
 options =3D [make_option('-r', metavar =3D 'rev1[:[rev2]]', dest =3D '=
revs',
@@ -55,10 +55,14 @@ def func(parser, options, args):
         rev_list =3D options.revs.split(':')
         rev_list_len =3D len(rev_list)
         if rev_list_len =3D=3D 1:
-            if rev_list[0][-1] =3D=3D '/':
+            rev =3D rev_list[0]
+            if rev[-1] =3D=3D '/':
                 # the whole patch
-                rev1 =3D rev_list[0] + 'bottom'
-                rev2 =3D rev_list[0] + 'top'
+                rev =3D rev[:-1]
+                if rev[-1] =3D=3D '/':
+                    rev =3D rev[:-1]
+                rev1 =3D rev + '//bottom'
+                rev2 =3D rev + '//top'
             else:
                 rev1 =3D rev_list[0]
                 rev2 =3D None
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index 0694d83..b33bd2a 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -53,8 +53,8 @@ def func(parser, options, args):
     else:
         parser.error('incorrect number of arguments')
=20
-    rev1 =3D git_id('%s/bottom' % patch)
-    rev2 =3D git_id('%s/top' % patch)
+    rev1 =3D git_id('%s//bottom' % patch)
+    rev2 =3D git_id('%s//top' % patch)
=20
     if options.stat:
         print git.diffstat(rev1 =3D rev1, rev2 =3D rev2)
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index 1cf6ea6..284589a 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -28,7 +28,7 @@ usage =3D """%prog [options] [id]
=20
 Print the hash value of a GIT id (defaulting to HEAD). In addition to
 the standard GIT id's like heads and tags, this command also accepts
-'base[@<branch>]' and '[<patch>[@<branch>]][/(bottom | top)]'. If no
+'base[@<branch>]' and '[<patch>[@<branch>]][//[bottom | top]]'. If no
 'top' or 'bottom' are passed and <patch> is a valid patch name, 'top'
 will be used by default."""
=20
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 5e01ea1..3928b81 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -324,10 +324,10 @@ def __build_message(tmpl, patch, patch_n
                  'shortdescr':   short_descr,
                  'longdescr':    long_descr,
                  'endofheaders': headers_end,
-                 'diff':         git.diff(rev1 =3D git_id('%s/bottom' =
% patch),
-                                          rev2 =3D git_id('%s/top' % p=
atch)),
-                 'diffstat':     git.diffstat(rev1 =3D git_id('%s/bott=
om'%patch),
-                                              rev2 =3D git_id('%s/top'=
 % patch)),
+                 'diff':         git.diff(rev1 =3D git_id('%s//bottom'=
 % patch),
+                                          rev2 =3D git_id('%s//top' % =
patch)),
+                 'diffstat':     git.diffstat(rev1 =3D git_id('%s//bot=
tom'%patch),
+                                              rev2 =3D git_id('%s//top=
' % patch)),
                  'date':         email.Utils.formatdate(localtime =3D =
True),
                  'version':      version_str,
                  'patchnr':      patch_nr_str,
diff --git a/stgit/git.py b/stgit/git.py
index 2884f36..716609c 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -225,7 +225,8 @@ def get_head():
 def get_head_file():
     """Returns the name of the file pointed to by the HEAD link
     """
-    return os.path.basename(_output_one_line('git-symbolic-ref HEAD'))
+    return strip_prefix('refs/heads/',
+                        _output_one_line('git-symbolic-ref HEAD'))
=20
 def set_head_file(ref):
     """Resets HEAD to point to a new ref
@@ -233,7 +234,8 @@ def set_head_file(ref):
     # head cache flushing is needed since we might have a different va=
lue
     # in the new head
     __clear_head_cache()
-    if __run('git-symbolic-ref HEAD', [ref]) !=3D 0:
+    if __run('git-symbolic-ref HEAD',
+             [os.path.join('refs', 'heads', ref)]) !=3D 0:
         raise GitException, 'Could not set head to "%s"' % ref
=20
 def __set_head(val):
@@ -272,6 +274,7 @@ def rev_parse(git_id):
 def branch_exists(branch):
     """Existence check for the named branch
     """
+    branch =3D os.path.join('refs', 'heads', branch)
     for line in _output_lines('git-rev-parse --symbolic --all 2>&1'):
         if line.strip() =3D=3D branch:
             return True
@@ -282,12 +285,11 @@ def branch_exists(branch):
 def create_branch(new_branch, tree_id =3D None):
     """Create a new branch in the git repository
     """
-    new_head =3D os.path.join('refs', 'heads', new_branch)
-    if branch_exists(new_head):
+    if branch_exists(new_branch):
         raise GitException, 'Branch "%s" already exists' % new_branch
=20
     current_head =3D get_head()
-    set_head_file(new_head)
+    set_head_file(new_branch)
     __set_head(current_head)
=20
     # a checkout isn't needed if new branch points to the current head
@@ -297,22 +299,22 @@ def create_branch(new_branch, tree_id =3D=20
     if os.path.isfile(os.path.join(basedir.get(), 'MERGE_HEAD')):
         os.remove(os.path.join(basedir.get(), 'MERGE_HEAD'))
=20
-def switch_branch(name):
+def switch_branch(new_branch):
     """Switch to a git branch
     """
     global __head
=20
-    new_head =3D os.path.join('refs', 'heads', name)
-    if not branch_exists(new_head):
-        raise GitException, 'Branch "%s" does not exist' % name
+    if not branch_exists(new_branch):
+        raise GitException, 'Branch "%s" does not exist' % new_branch
=20
-    tree_id =3D rev_parse(new_head + '^{commit}')
+    tree_id =3D rev_parse(os.path.join('refs', 'heads', new_branch)
+                        + '^{commit}')
     if tree_id !=3D get_head():
         refresh_index()
         if __run('git-read-tree -u -m', [get_head(), tree_id]) !=3D 0:
             raise GitException, 'git-read-tree failed (local changes m=
aybe?)'
         __head =3D tree_id
-    set_head_file(new_head)
+    set_head_file(new_branch)
=20
     if os.path.isfile(os.path.join(basedir.get(), 'MERGE_HEAD')):
         os.remove(os.path.join(basedir.get(), 'MERGE_HEAD'))
@@ -320,25 +322,23 @@ def switch_branch(name):
 def delete_branch(name):
     """Delete a git branch
     """
-    branch_head =3D os.path.join('refs', 'heads', name)
-    if not branch_exists(branch_head):
+    if not branch_exists(name):
         raise GitException, 'Branch "%s" does not exist' % name
-    os.remove(os.path.join(basedir.get(), branch_head))
+    remove_file_and_dirs(os.path.join(basedir.get(), 'refs', 'heads'),
+                         name)
=20
 def rename_branch(from_name, to_name):
     """Rename a git branch
     """
-    from_head =3D os.path.join('refs', 'heads', from_name)
-    if not branch_exists(from_head):
+    if not branch_exists(from_name):
         raise GitException, 'Branch "%s" does not exist' % from_name
-    to_head =3D os.path.join('refs', 'heads', to_name)
-    if branch_exists(to_head):
+    if branch_exists(to_name):
         raise GitException, 'Branch "%s" already exists' % to_name
=20
     if get_head_file() =3D=3D from_name:
-        set_head_file(to_head)
-    os.rename(os.path.join(basedir.get(), from_head), \
-              os.path.join(basedir.get(), to_head))
+        set_head_file(to_name)
+    rename(os.path.join(basedir.get(), 'refs', 'heads'),
+           from_name, to_name)
=20
 def add(names):
     """Add the files or recursively add the directory contents
diff --git a/stgit/stack.py b/stgit/stack.py
index f83161b..49b50e7 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -443,8 +443,7 @@ class Series:
=20
         os.makedirs(self.__patch_dir)
=20
-        if not os.path.isdir(bases_dir):
-            os.makedirs(bases_dir)
+        create_dirs(bases_dir)
=20
         create_empty_file(self.__applied_file)
         create_empty_file(self.__unapplied_file)
@@ -502,11 +501,14 @@ class Series:
         git.rename_branch(self.__name, to_name)
=20
         if os.path.isdir(self.__series_dir):
-            os.rename(self.__series_dir, to_stack.__series_dir)
+            rename(os.path.join(self.__base_dir, 'patches'),
+                   self.__name, to_stack.__name)
         if os.path.exists(self.__base_file):
-            os.rename(self.__base_file, to_stack.__base_file)
+            rename(os.path.join(self.__base_dir, 'refs', 'bases'),
+                   self.__name, to_stack.__name)
         if os.path.exists(self.__refs_dir):
-            os.rename(self.__refs_dir, to_stack.__refs_dir)
+            rename(os.path.join(self.__base_dir, 'refs', 'patches'),
+                   self.__name, to_stack.__name)
=20
         self.__init__(to_name)
=20
@@ -560,16 +562,19 @@ class Series:
             else:
                 print 'Patch directory %s is not empty.' % self.__name
             if not os.listdir(self.__series_dir):
-                os.rmdir(self.__series_dir)
+                remove_dirs(os.path.join(self.__base_dir, 'patches'),
+                            self.__name)
             else:
                 print 'Series directory %s is not empty.' % self.__nam=
e
             if not os.listdir(self.__refs_dir):
-                os.rmdir(self.__refs_dir)
+                remove_dirs(os.path.join(self.__base_dir, 'refs', 'pat=
ches'),
+                            self.__name)
             else:
                 print 'Refs directory %s is not empty.' % self.__refs_=
dir
=20
         if os.path.exists(self.__base_file):
-            os.remove(self.__base_file)
+            remove_file_and_dirs(
+                os.path.join(self.__base_dir, 'refs', 'bases'), self._=
_name)
=20
     def refresh_patch(self, files =3D None, message =3D None, edit =3D=
 False,
                       show_patch =3D False,
diff --git a/stgit/utils.py b/stgit/utils.py
index 5749b3b..68b8f58 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -1,6 +1,8 @@
 """Common utility functions
 """
=20
+import errno, os, os.path
+
 __copyright__ =3D """
 Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
=20
@@ -18,6 +20,12 @@ along with this program; if not, write t
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
+def mkdir_file(filename, mode):
+    """Opens filename with the given mode, creating the directory it's
+    in if it doesn't already exist."""
+    create_dirs(os.path.dirname(filename))
+    return file(filename, mode)
+
 def read_string(filename, multiline =3D False):
     """Reads the first line from a file
     """
@@ -32,7 +40,7 @@ def read_string(filename, multiline =3D Fa
 def write_string(filename, line, multiline =3D False):
     """Writes 'line' to file and truncates it
     """
-    f =3D file(filename, 'w+')
+    f =3D mkdir_file(filename, 'w+')
     if multiline:
         f.write(line)
     else:
@@ -42,7 +50,7 @@ def write_string(filename, line, multili
 def append_strings(filename, lines):
     """Appends 'lines' sequence to file
     """
-    f =3D file(filename, 'a+')
+    f =3D mkdir_file(filename, 'a+')
     for line in lines:
         print >> f, line
     f.close()
@@ -50,14 +58,14 @@ def append_strings(filename, lines):
 def append_string(filename, line):
     """Appends 'line' to file
     """
-    f =3D file(filename, 'a+')
+    f =3D mkdir_file(filename, 'a+')
     print >> f, line
     f.close()
=20
 def insert_string(filename, line):
     """Inserts 'line' at the beginning of the file
     """
-    f =3D file(filename, 'r+')
+    f =3D mkdir_file(filename, 'r+')
     lines =3D f.readlines()
     f.seek(0); f.truncate()
     print >> f, line
@@ -67,4 +75,74 @@ def insert_string(filename, line):
 def create_empty_file(name):
     """Creates an empty file
     """
-    file(name, 'w+').close()
+    mkdir_file(name, 'w+').close()
+
+def list_files_and_dirs(path):
+    """Return the sets of filenames and directory names in a
+    directory."""
+    files, dirs =3D [], []
+    for fd in os.listdir(path):
+        full_fd =3D os.path.join(path, fd)
+        if os.path.isfile(full_fd):
+            files.append(fd)
+        elif os.path.isdir(full_fd):
+            dirs.append(fd)
+    return files, dirs
+
+def walk_tree(basedir):
+    """Starting in the given directory, iterate through all its
+    subdirectories. For each subdirectory, yield the name of the
+    subdirectory (relative to the base directory), the list of
+    filenames in the subdirectory, and the list of directory names in
+    the subdirectory."""
+    subdirs =3D ['']
+    while subdirs:
+        subdir =3D subdirs.pop()
+        files, dirs =3D list_files_and_dirs(os.path.join(basedir, subd=
ir))
+        for d in dirs:
+            subdirs.append(os.path.join(subdir, d))
+        yield subdir, files, dirs
+
+def strip_prefix(prefix, string):
+    """Return string, without the prefix. Blow up if string doesn't
+    start with prefix."""
+    assert string.startswith(prefix)
+    return string[len(prefix):]
+
+def remove_dirs(basedir, dirs):
+    """Starting at join(basedir, dirs), remove the directory if empty,
+    and try the same with its parent, until we find a nonempty
+    directory or reach basedir."""
+    path =3D dirs
+    while path:
+        try:
+            os.rmdir(os.path.join(basedir, path))
+        except OSError:
+            return # can't remove nonempty directory
+        path =3D os.path.dirname(path)
+
+def remove_file_and_dirs(basedir, file):
+    """Remove join(basedir, file), and then remove the directory it
+    was in if empty, and try the same with its parent, until we find a
+    nonempty directory or reach basedir."""
+    os.remove(os.path.join(basedir, file))
+    remove_dirs(basedir, os.path.dirname(file))
+
+def create_dirs(directory):
+    """Create the given directory, if the path doesn't already exist."=
""
+    if directory:
+        create_dirs(os.path.dirname(directory))
+        try:
+            os.mkdir(directory)
+        except OSError, e:
+            if e.errno !=3D errno.EEXIST:
+                raise e
+
+def rename(basedir, file1, file2):
+    """Rename join(basedir, file1) to join(basedir, file2), not
+    leaving any empty directories behind and creating any directories
+    necessary."""
+    full_file2 =3D os.path.join(basedir, file2)
+    create_dirs(os.path.dirname(full_file2))
+    os.rename(os.path.join(basedir, file1), full_file2)
+    remove_dirs(basedir, os.path.dirname(file1))
--=20
1.3.2.g639c


--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
