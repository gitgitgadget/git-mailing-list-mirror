From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 2/4] Refactor subprocess creation
Date: Sun, 26 Aug 2007 22:33:33 +0200
Message-ID: <20070826203333.16265.63019.stgit@yoghurt>
References: <20070826202724.16265.85821.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:34:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOoV-0008Ch-2E
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754298AbXHZUd7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754309AbXHZUd6
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:33:58 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4758 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbXHZUdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:33:38 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOnd-0005vj-00; Sun, 26 Aug 2007 21:33:34 +0100
In-Reply-To: <20070826202724.16265.85821.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56722>

Instead of having a gazillion different little functions that wrap
os.spawnvp and popen2.Popen3, make a single wrapper that's flexible
enough to cater to everyone. Apart from making the code cleaner and
easier to read, this has the added benefit of making it possible to
add little things such as extra safety checks and logging.

Ideally, I'd have liked this wrapper to wrap subprocess.Popen, but
that's only available in Python 2.4 and up, so we'll have to make do
with os.spawnvp and popen2.Popen3 for now, even though they suck.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/basedir.py         |   13 +-
 stgit/commands/export.py |    9 -
 stgit/config.py          |   56 ++------
 stgit/git.py             |  330 ++++++++++++++++++--------------------=
--------
 stgit/gitmergeonefile.py |   18 +--
 stgit/run.py             |  111 +++++++++++++++
 6 files changed, 272 insertions(+), 265 deletions(-)

diff --git a/stgit/basedir.py b/stgit/basedir.py
index 81f2b40..30f45f9 100644
--- a/stgit/basedir.py
+++ b/stgit/basedir.py
@@ -19,13 +19,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston=
, MA 02111-1307 USA
 """
=20
 import os
-
-def __output(cmd):
-    f =3D os.popen(cmd, 'r')
-    string =3D f.readline().rstrip()
-    if f.close():
-        return ''
-    return string
+from stgit.run import *
=20
 # GIT_DIR value cached
 __base_dir =3D None
@@ -39,7 +33,10 @@ def get():
         if 'GIT_DIR' in os.environ:
             __base_dir =3D os.environ['GIT_DIR']
         else:
-            __base_dir =3D __output('git-rev-parse --git-dir 2> /dev/n=
ull')
+            try:
+                __base_dir =3D Run('git-rev-parse', '--git-dir').outpu=
t_one_line()
+            except RunException:
+                __base_dir =3D ''
=20
     return __base_dir
=20
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 5ca07d3..62be394 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -175,13 +175,10 @@ def func(parser, options, args):
             print patch.get_name()
             print '-'*79
=20
-        # write description
         f.write(descr)
-        # write the diff
-        git.diff(rev1 =3D patch.get_bottom(),
-                 rev2 =3D patch.get_top(),
-                 out_fd =3D f,
-                 diff_flags =3D diff_flags )
+        f.write(git.diff(rev1 =3D patch.get_bottom(),
+                         rev2 =3D patch.get_top(),
+                         diff_flags =3D diff_flags))
         if not options.stdout:
             f.close()
         patch_no +=3D 1
diff --git a/stgit/config.py b/stgit/config.py
index 2fd1273..799e1d7 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -20,6 +20,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
=20
 import os, re
 from stgit import basedir
+from stgit.run import *
=20
 class GitConfigException(Exception):
     pass
@@ -43,50 +44,21 @@ class GitConfig:
=20
     __cache=3D{}
=20
-    def __run(self, cmd, args=3DNone):
-        """__run: runs cmd using spawnvp.
-   =20
-        Runs cmd using spawnvp.  The shell is avoided so it won't mess=
 up
-        our arguments.  If args is very large, the command is run mult=
iple
-        times; args is split xargs style: cmd is passed on each
-        invocation.  Unlike xargs, returns immediately if any non-zero
-        return code is received. =20
-        """
-       =20
-        args_l=3Dcmd.split()
-        if args is None:
-            args =3D []
-        for i in range(0, len(args)+1, 100):
-            r=3Dos.spawnvp(os.P_WAIT, args_l[0], args_l + args[i:min(i=
+100, len(args))])
-        if r:
-            return r
-        return 0
-   =20
     def get(self, name):
         if self.__cache.has_key(name):
             return self.__cache[name]
-
-        stream =3D os.popen('git repo-config --get %s' % name, 'r')
-        value =3D stream.readline().strip()
-        stream.close()
-        if len(value) > 0:
-            pass
-        elif (self.__defaults.has_key(name)):
-            value =3D self.__defaults[name]
-        else:
-            value =3D None
-
+        try:
+            value =3D Run('git-repo-config', '--get', name).output_one=
_line()
+        except RunException:
+            value =3D self.__defaults.get(name, None)
         self.__cache[name] =3D value
         return value
=20
     def getall(self, name):
         if self.__cache.has_key(name):
             return self.__cache[name]
-
-        stream =3D os.popen('git repo-config --get-all %s' % name, 'r'=
)
-        values =3D [line.strip() for line in stream]
-        stream.close()
-
+        values =3D Run('git-repo-config', '--get-all', name
+                     ).returns([0, 1]).output_lines()
         self.__cache[name] =3D values
         return values
=20
@@ -98,15 +70,18 @@ class GitConfig:
             raise GitConfigException, 'Value for "%s" is not an intege=
r: "%s"' % (name, value)
=20
     def rename_section(self, from_name, to_name):
-        self.__run('git-repo-config --rename-section', [from_name, to_=
name])
+        """Rename a section in the config file. Silently do nothing if
+        the section doesn't exist."""
+        Run('git-repo-config', '--rename-section', from_name, to_name
+            ).returns([0, 1]).run()
         self.__cache.clear()
=20
     def set(self, name, value):
-        self.__run('git-repo-config', [name, value])
+        Run('git-repo-config', name, value).run()
         self.__cache[name] =3D value
=20
     def unset(self, name):
-        self.__run('git-repo-config --unset', [name])
+        Run('git-repo-config', '--unset', name)
         self.__cache[name] =3D None
=20
     def sections_matching(self, regexp):
@@ -115,12 +90,11 @@ class GitConfig:
         group contents, for all variable names matching the regexp.
         """
         result =3D []
-        stream =3D os.popen('git repo-config --get-regexp "^%s$"' % re=
gexp, 'r')
-        for line in stream:
+        for line in Run('git-repo-config', '--get-regexp', '"^%s$"' % =
regexp
+                        ).returns([0, 1]).output_lines():
             m =3D re.match('^%s ' % regexp, line)
             if m:
                 result.append(m.group(1))
-        stream.close()
         return result
        =20
 config=3DGitConfig()
diff --git a/stgit/git.py b/stgit/git.py
index 827bd61..7962cdb 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -18,12 +18,13 @@ along with this program; if not, write to the Free =
Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-import sys, os, popen2, re, gitmergeonefile
+import sys, os, re, gitmergeonefile
 from shutil import copyfile
=20
 from stgit import basedir
 from stgit.utils import *
 from stgit.out import *
+from stgit.run import *
 from stgit.config import config
 from sets import Set
=20
@@ -31,6 +32,12 @@ from sets import Set
 class GitException(Exception):
     pass
=20
+# When a subprocess has a problem, we want the exception to be a
+# subclass of GitException.
+class GitRunException(GitException):
+    pass
+class GRun(Run):
+    exc =3D GitRunException
=20
=20
 #
@@ -75,19 +82,21 @@ class Commit:
     def __init__(self, id_hash):
         self.__id_hash =3D id_hash
=20
-        lines =3D _output_lines(['git-cat-file', 'commit', id_hash])
+        lines =3D GRun('git-cat-file', 'commit', id_hash).output_lines=
()
         for i in range(len(lines)):
             line =3D lines[i]
-            if line =3D=3D '\n':
-                break
-            field =3D line.strip().split(' ', 1)
-            if field[0] =3D=3D 'tree':
-                self.__tree =3D field[1]
-            if field[0] =3D=3D 'author':
-                self.__author =3D field[1]
-            if field[0] =3D=3D 'committer':
-                self.__committer =3D field[1]
-        self.__log =3D ''.join(lines[i+1:])
+            if not line:
+                break # we've seen all the header fields
+            key, val =3D line.split(' ', 1)
+            if key =3D=3D 'tree':
+                self.__tree =3D val
+            elif key =3D=3D 'author':
+                self.__author =3D val
+            elif key =3D=3D 'committer':
+                self.__committer =3D val
+            else:
+                pass # ignore other headers
+        self.__log =3D '\n'.join(lines[i+1:])
=20
     def get_id_hash(self):
         return self.__id_hash
@@ -103,8 +112,8 @@ class Commit:
             return None
=20
     def get_parents(self):
-        return _output_lines(['git-rev-list', '--parents', '--max-coun=
t=3D1',
-                              self.__id_hash])[0].split()[1:]
+        return GRun('git-rev-list', '--parents', '--max-count=3D1', se=
lf.__id_hash
+                    ).output_one_line().split()[1:]
=20
     def get_author(self):
         return self.__author
@@ -150,73 +159,6 @@ def get_conflicts():
     else:
         return None
=20
-def _input(cmd, file_desc):
-    p =3D popen2.Popen3(cmd, True)
-    while True:
-        line =3D file_desc.readline()
-        if not line:
-            break
-        p.tochild.write(line)
-    p.tochild.close()
-    if p.wait():
-        raise GitException, '%s failed (%s)' % (' '.join(cmd),
-                                                p.childerr.read().stri=
p())
-
-def _input_str(cmd, string):
-    p =3D popen2.Popen3(cmd, True)
-    p.tochild.write(string)
-    p.tochild.close()
-    if p.wait():
-        raise GitException, '%s failed (%s)' % (' '.join(cmd),
-                                                p.childerr.read().stri=
p())
-
-def _output(cmd):
-    p=3Dpopen2.Popen3(cmd, True)
-    output =3D p.fromchild.read()
-    if p.wait():
-        raise GitException, '%s failed (%s)' % (' '.join(cmd),
-                                                p.childerr.read().stri=
p())
-    return output
-
-def _output_one_line(cmd, file_desc =3D None):
-    p=3Dpopen2.Popen3(cmd, True)
-    if file_desc !=3D None:
-        for line in file_desc:
-            p.tochild.write(line)
-        p.tochild.close()
-    output =3D p.fromchild.readline().strip()
-    if p.wait():
-        raise GitException, '%s failed (%s)' % (' '.join(cmd),
-                                                p.childerr.read().stri=
p())
-    return output
-
-def _output_lines(cmd):
-    p=3Dpopen2.Popen3(cmd, True)
-    lines =3D p.fromchild.readlines()
-    if p.wait():
-        raise GitException, '%s failed (%s)' % (' '.join(cmd),
-                                                p.childerr.read().stri=
p())
-    return lines
-
-def __run(cmd, args=3DNone):
-    """__run: runs cmd using spawnvp.
-
-    Runs cmd using spawnvp.  The shell is avoided so it won't mess up
-    our arguments.  If args is very large, the command is run multiple
-    times; args is split xargs style: cmd is passed on each
-    invocation.  Unlike xargs, returns immediately if any non-zero
-    return code is received. =20
-    """
-   =20
-    args_l=3Dcmd.split()
-    if args is None:
-        args =3D []
-    for i in range(0, len(args)+1, 100):
-        r=3Dos.spawnvp(os.P_WAIT, args_l[0], args_l + args[i:min(i+100=
, len(args))])
-    if r:
-        return r
-    return 0
-
 def exclude_files():
     files =3D [os.path.join(basedir.get(), 'info', 'exclude')]
     user_exclude =3D config.get('core.excludesfile')
@@ -247,9 +189,9 @@ def tree_status(files =3D None, tree_id =3D 'HEAD',=
 unknown =3D False,
                        + ['--exclude-per-directory=3D.gitignore']
                        + ['--exclude-from=3D%s' % fn for fn in exclude=
_files()
                           if os.path.exists(fn)])
-        lines =3D _output_lines(['git-ls-files', '--others', '--direct=
ory']
-                              + exclude)
-        cache_files +=3D [('?', line.strip()) for line in lines]
+        lines =3D GRun('git-ls-files', '--others', '--directory', *exc=
lude
+                     ).output_lines()
+        cache_files +=3D [('?', line) for line in lines]
=20
     # conflicted files
     conflicts =3D get_conflicts()
@@ -258,8 +200,8 @@ def tree_status(files =3D None, tree_id =3D 'HEAD',=
 unknown =3D False,
     cache_files +=3D [('C', filename) for filename in conflicts]
=20
     # the rest
-    for line in _output_lines(['git-diff-index'] + diff_flags +
-                              [ tree_id, '--'] + files):
+    for line in GRun('git-diff-index', *(diff_flags + [tree_id, '--'] =
+ files)
+                     ).output_lines():
         fs =3D tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
         if fs[1] not in conflicts:
             cache_files.append(fs)
@@ -277,7 +219,7 @@ def local_changes(verbose =3D True):
 def get_heads():
     heads =3D []
     hr =3D re.compile(r'^[0-9a-f]{40} refs/heads/(.+)$')
-    for line in _output_lines(['git-show-ref', '--heads']):
+    for line in GRun('git-show-ref', '--heads').output_lines():
         m =3D hr.match(line)
         heads.append(m.group(1))
     return heads
@@ -298,7 +240,7 @@ def get_head_file():
     """Returns the name of the file pointed to by the HEAD link
     """
     return strip_prefix('refs/heads/',
-                        _output_one_line(['git-symbolic-ref', 'HEAD'])=
)
+                        GRun('git-symbolic-ref', 'HEAD').output_one_li=
ne())
=20
 def set_head_file(ref):
     """Resets HEAD to point to a new ref
@@ -306,12 +248,16 @@ def set_head_file(ref):
     # head cache flushing is needed since we might have a different va=
lue
     # in the new head
     __clear_head_cache()
-    if __run('git-symbolic-ref HEAD', ['refs/heads/%s' % ref]) !=3D 0:
+    try:
+        GRun('git-symbolic-ref', 'HEAD', 'refs/heads/%s' % ref).run()
+    except GitRunException:
         raise GitException, 'Could not set head to "%s"' % ref
=20
 def set_ref(ref, val):
     """Point ref at a new commit object."""
-    if __run('git-update-ref', [ref, val]) !=3D 0:
+    try:
+        GRun('git-update-ref', ref, val).run()
+    except GitRunException:
         raise GitException, 'Could not update %s to "%s".' % (ref, val=
)
=20
 def set_branch(branch, val):
@@ -339,14 +285,14 @@ def __clear_head_cache():
 def refresh_index():
     """Refresh index with stat() information from the working director=
y.
     """
-    __run('git-update-index -q --unmerged --refresh')
+    GRun('git-update-index', '-q', '--unmerged', '--refresh').run()
=20
 def rev_parse(git_id):
     """Parse the string and return a verified SHA1 id
     """
     try:
-        return _output_one_line(['git-rev-parse', '--verify', git_id])
-    except GitException:
+        return GRun('git-rev-parse', '--verify', git_id).output_one_li=
ne()
+    except GitRunException:
         raise GitException, 'Unknown revision: %s' % git_id
=20
 def ref_exists(ref):
@@ -387,7 +333,9 @@ def switch_branch(new_branch):
     tree_id =3D rev_parse('refs/heads/%s^{commit}' % new_branch)
     if tree_id !=3D get_head():
         refresh_index()
-        if __run('git-read-tree -u -m', [get_head(), tree_id]) !=3D 0:
+        try:
+            GRun('git-read-tree', '-u', '-m', get_head(), tree_id).run=
()
+        except GitRunException:
             raise GitException, 'git-read-tree failed (local changes m=
aybe?)'
         __head =3D tree_id
     set_head_file(new_branch)
@@ -398,8 +346,10 @@ def switch_branch(new_branch):
 def delete_ref(ref):
     if not ref_exists(ref):
         raise GitException, '%s does not exist' % ref
-    sha1 =3D _output_one_line(['git-show-ref', '-s', ref])
-    if __run('git-update-ref -d %s %s' % (ref, sha1)):
+    sha1 =3D GRun('git-show-ref', '-s', ref).output_one_line()
+    try:
+        GRun('git-update-ref', '-d', ref, sha1).run()
+    except GitRunException:
         raise GitException, 'Failed to delete ref %s' % ref
=20
 def delete_branch(name):
@@ -411,10 +361,14 @@ def rename_ref(from_ref, to_ref):
     if ref_exists(to_ref):
         raise GitException, '"%s" already exists' % to_ref
=20
-    sha1 =3D _output_one_line(['git-show-ref', '-s', from_ref])
-    if __run('git-update-ref %s %s %s' % (to_ref, sha1, '0'*40)):
+    sha1 =3D GRun('git-show-ref', '-s', from_ref).output_one_line()
+    try:
+        GRun('git-update-ref', to_ref, sha1, '0'*40).run()
+    except GitRunException:
         raise GitException, 'Failed to create new ref %s' % to_ref
-    if __run('git-update-ref -d %s %s' % (from_ref, sha1)):
+    try:
+        GRun('git-update-ref', '-d', from_ref, sha1).run()
+    except GitRunException:
         raise GitException, 'Failed to delete ref %s' % from_ref
=20
 def rename_branch(from_name, to_name):
@@ -448,14 +402,16 @@ def add(names):
             raise GitException, '%s is not a file or directory' % i
=20
     if files:
-        if __run('git-update-index --add --', files):
+        try:
+            GRun('git-update-index', '--add', '--').xargs(files)
+        except GitRunException:
             raise GitException, 'Unable to add file'
=20
 def __copy_single(source, target, target2=3D''):
     """Copy file or dir named 'source' to name target+target2"""
=20
     # "source" (file or dir) must match one or more git-controlled fil=
e
-    realfiles =3D _output_lines(['git-ls-files', source])
+    realfiles =3D GRun('git-ls-files', source).output_lines()
     if len(realfiles) =3D=3D 0:
         raise GitException, '"%s" matches no git-controled files' % so=
urce
=20
@@ -523,10 +479,10 @@ def rm(files, force =3D False):
             if os.path.exists(f):
                 raise GitException, '%s exists. Remove it first' %f
         if files:
-            __run('git-update-index --remove --', files)
+            GRun('git-update-index', '--remove', '--').xargs(files)
     else:
         if files:
-            __run('git-update-index --force-remove --', files)
+            GRun('git-update-index', '--force-remove', '--').xargs(fil=
es)
=20
 # Persons caching
 __user =3D None
@@ -601,12 +557,9 @@ def update_cache(files =3D None, force =3D False):
     rm_files =3D  [x[1] for x in cache_files if x[0] in ['D']]
     m_files =3D   [x[1] for x in cache_files if x[0] in ['M']]
=20
-    if add_files and __run('git-update-index --add --', add_files) !=3D=
 0:
-        raise GitException, 'Failed git-update-index --add'
-    if rm_files and __run('git-update-index --force-remove --', rm_fil=
es) !=3D 0:
-        raise GitException, 'Failed git-update-index --rm'
-    if m_files and __run('git-update-index --', m_files) !=3D 0:
-        raise GitException, 'Failed git-update-index'
+    GRun('git-update-index', '--add', '--').xargs(add_files)
+    GRun('git-update-index', '--force-remove', '--').xargs(rm_files)
+    GRun('git-update-index', '--').xargs(m_files)
=20
     return True
=20
@@ -635,28 +588,24 @@ def commit(message, files =3D None, parents =3D N=
one, allowempty =3D False,
=20
     # write the index to repository
     if tree_id =3D=3D None:
-        tree_id =3D _output_one_line(['git-write-tree'])
+        tree_id =3D GRun('git-write-tree').output_one_line()
         set_head =3D True
=20
     # the commit
-    cmd =3D ['env']
+    env =3D {}
     if author_name:
-        cmd +=3D ['GIT_AUTHOR_NAME=3D%s' % author_name]
+        env['GIT_AUTHOR_NAME'] =3D author_name
     if author_email:
-        cmd +=3D ['GIT_AUTHOR_EMAIL=3D%s' % author_email]
+        env['GIT_AUTHOR_EMAIL'] =3D author_email
     if author_date:
-        cmd +=3D ['GIT_AUTHOR_DATE=3D%s' % author_date]
+        env['GIT_AUTHOR_DATE'] =3D author_date
     if committer_name:
-        cmd +=3D ['GIT_COMMITTER_NAME=3D%s' % committer_name]
+        env['GIT_COMMITTER_NAME'] =3D committer_name
     if committer_email:
-        cmd +=3D ['GIT_COMMITTER_EMAIL=3D%s' % committer_email]
-    cmd +=3D ['git-commit-tree', tree_id]
-
-    # get the parents
-    for p in parents:
-        cmd +=3D ['-p', p]
-
-    commit_id =3D _output_one_line(cmd, message)
+        env['GIT_COMMITTER_EMAIL'] =3D committer_email
+    commit_id =3D GRun('git-commit-tree', tree_id,
+                     *sum([['-p', p] for p in parents], [])
+                     ).env(env).raw_input(message).output_one_line()
     if set_head:
         __set_head(commit_id)
=20
@@ -679,8 +628,8 @@ def apply_diff(rev1, rev2, check_index =3D True, fi=
les =3D None):
     diff_str =3D diff(files, rev1, rev2)
     if diff_str:
         try:
-            _input_str(['git-apply'] + index_opt, diff_str)
-        except GitException:
+            GRun('git-apply', *index_opt).raw_input(diff_str).no_outpu=
t()
+        except GitRunException:
             return False
=20
     return True
@@ -696,24 +645,28 @@ def merge(base, head1, head2, recursive =3D False=
):
         # this operation tracks renames but it is slower (used in
         # general when pushing or picking patches)
         try:
-            # use _output() to mask the verbose prints of the tool
-            _output(['git-merge-recursive', base, '--', head1, head2])
-        except GitException, ex:
+            # discard output to mask the verbose prints of the tool
+            GRun('git-merge-recursive', base, '--', head1, head2
+                 ).discard_output()
+        except GitRunException, ex:
             err_output =3D str(ex)
             pass
     else:
         # the fast case where we don't track renames (used when the
         # distance between base and heads is small, i.e. folding or
         # synchronising patches)
-        if __run('git-read-tree -u -m --aggressive',
-                 [base, head1, head2]) !=3D 0:
+        try:
+            GRun('git-read-tree', '-u', '-m', '--aggressive',
+                 base, head1, head2).run()
+        except GitRunException:
             raise GitException, 'git-read-tree failed (local changes m=
aybe?)'
=20
     # check the index for unmerged entries
     files =3D {}
     stages_re =3D re.compile('^([0-7]+) ([0-9a-f]{40}) ([1-3])\t(.*)$'=
, re.S)
=20
-    for line in _output(['git-ls-files', '--unmerged', '--stage', '-z'=
]).split('\0'):
+    for line in GRun('git-ls-files', '--unmerged', '--stage', '-z'
+                     ).raw_output().split('\0'):
         if not line:
             continue
=20
@@ -788,98 +741,85 @@ def status(files =3D None, modified =3D False, ne=
w =3D False, deleted =3D False,
         else:
             out.stdout('%s' % fs[1])
=20
-def diff(files =3D None, rev1 =3D 'HEAD', rev2 =3D None, out_fd =3D No=
ne,
-         diff_flags =3D []):
+def diff(files =3D None, rev1 =3D 'HEAD', rev2 =3D None, diff_flags =3D=
 []):
     """Show the diff between rev1 and rev2
     """
     if not files:
         files =3D []
=20
     if rev1 and rev2:
-        diff_str =3D _output(['git-diff-tree', '-p'] + diff_flags
-                           + [rev1, rev2, '--'] + files)
+        return GRun('git-diff-tree', '-p',
+                    *(diff_flags + [rev1, rev2, '--'] + files)).raw_ou=
tput()
     elif rev1 or rev2:
         refresh_index()
         if rev2:
-            diff_str =3D _output(['git-diff-index', '-p', '-R']
-                               + diff_flags + [rev2, '--'] + files)
+            return GRun('git-diff-index', '-p', '-R',
+                        *(diff_flags + [rev2, '--'] + files)).raw_outp=
ut()
         else:
-            diff_str =3D _output(['git-diff-index', '-p']
-                               + diff_flags + [rev1, '--'] + files)
+            return GRun('git-diff-index', '-p',
+                        *(diff_flags + [rev1, '--'] + files)).raw_outp=
ut()
     else:
-        diff_str =3D ''
-
-    if out_fd:
-        out_fd.write(diff_str)
-    else:
-        return diff_str
+        return ''
=20
 def diffstat(files =3D None, rev1 =3D 'HEAD', rev2 =3D None):
-    """Return the diffstat between rev1 and rev2
-    """
-    if not files:
-        files =3D []
-
-    p=3Dpopen2.Popen3('git-apply --stat')
-    diff(files, rev1, rev2, p.tochild)
-    p.tochild.close()
-    diff_str =3D p.fromchild.read().rstrip()
-    if p.wait():
-        raise GitException, 'git.diffstat failed'
-    return diff_str
+    """Return the diffstat between rev1 and rev2."""
+    return GRun('git-apply', '--stat'
+                ).raw_input(diff(files, rev1, rev2)).raw_output()
=20
 def files(rev1, rev2, diff_flags =3D []):
     """Return the files modified between rev1 and rev2
     """
=20
-    result =3D ''
-    for line in _output_lines(['git-diff-tree'] + diff_flags + ['-r', =
rev1, rev2]):
-        result +=3D '%s %s\n' % tuple(line.rstrip().split(' ',4)[-1].s=
plit('\t',1))
+    result =3D []
+    for line in GRun('git-diff-tree', *(diff_flags + ['-r', rev1, rev2=
])
+                     ).output_lines():
+        result.append('%s %s' % tuple(line.split(' ', 4)[-1].split('\t=
', 1)))
=20
-    return result.rstrip()
+    return '\n'.join(result)
=20
 def barefiles(rev1, rev2):
     """Return the files modified between rev1 and rev2, without status=
 info
     """
=20
-    result =3D ''
-    for line in _output_lines(['git-diff-tree', '-r', rev1, rev2]):
-        result +=3D '%s\n' % line.rstrip().split(' ',4)[-1].split('\t'=
,1)[-1]
+    result =3D []
+    for line in GRun('git-diff-tree', '-r', rev1, rev2).output_lines()=
:
+        result.append(line.split(' ', 4)[-1].split('\t', 1)[-1])
=20
-    return result.rstrip()
+    return '\n'.join(result)
=20
 def pretty_commit(commit_id =3D 'HEAD', diff_flags =3D []):
     """Return a given commit (log + diff)
     """
-    return _output(['git-diff-tree'] + diff_flags +
-                   ['--cc', '--always', '--pretty', '-r', commit_id])
+    return GRun('git-diff-tree',
+                *(diff_flags
+                  + ['--cc', '--always', '--pretty', '-r', commit_id])
+                ).raw_output()
=20
 def checkout(files =3D None, tree_id =3D None, force =3D False):
     """Check out the given or all files
     """
-    if not files:
-        files =3D []
-
-    if tree_id and __run('git-read-tree --reset', [tree_id]) !=3D 0:
-        raise GitException, 'Failed git-read-tree --reset %s' % tree_i=
d
+    if tree_id:
+        try:
+            GRun('git-read-tree', '--reset', tree_id).run()
+        except GitRunException:
+            raise GitException, 'Failed git-read-tree --reset %s' % tr=
ee_id
=20
-    checkout_cmd =3D 'git-checkout-index -q -u'
+    cmd =3D ['git-checkout-index', '-q', '-u']
     if force:
-        checkout_cmd +=3D ' -f'
-    if len(files) =3D=3D 0:
-        checkout_cmd +=3D ' -a'
+        cmd.append('-f')
+    if files:
+        GRun(*(cmd + ['--'])).xargs(files)
     else:
-        checkout_cmd +=3D ' --'
-
-    if __run(checkout_cmd, files) !=3D 0:
-        raise GitException, 'Failed git-checkout-index'
+        GRun(*(cmd + ['-a'])).run()
=20
 def switch(tree_id, keep =3D False):
     """Switch the tree to the given id
     """
     if not keep:
         refresh_index()
-        if __run('git-read-tree -u -m', [get_head(), tree_id]) !=3D 0:
+        try:
+            GRun('git-read-tree', '-u', '-m', get_head(), tree_id).run=
()
+        except GitRunException:
             raise GitException, 'git-read-tree failed (local changes m=
aybe?)'
=20
     __set_head(tree_id)
@@ -917,8 +857,7 @@ def fetch(repository =3D 'origin', refspec =3D None=
):
=20
     command =3D config.get('branch.%s.stgit.fetchcmd' % get_head_file(=
)) or \
               config.get('stgit.fetchcmd')
-    if __run(command, args) !=3D 0:
-        raise GitException, 'Failed "%s %s"' % (command, repository)
+    GRun(*(command.split() + args)).run()
=20
 def pull(repository =3D 'origin', refspec =3D None):
     """Fetches changes from the remote repository, using 'git-pull'
@@ -933,13 +872,12 @@ def pull(repository =3D 'origin', refspec =3D Non=
e):
=20
     command =3D config.get('branch.%s.stgit.pullcmd' % get_head_file()=
) or \
               config.get('stgit.pullcmd')
-    if __run(command, args) !=3D 0:
-        raise GitException, 'Failed "%s %s"' % (command, repository)
+    GRun(*(command.split() + args)).run()
=20
 def repack():
     """Repack all objects into a single pack
     """
-    __run('git-repack -a -d -f')
+    GRun('git-repack', '-a', '-d', '-f').run()
=20
 def apply_patch(filename =3D None, diff =3D None, base =3D None,
                 fail_dump =3D True):
@@ -962,8 +900,8 @@ def apply_patch(filename =3D None, diff =3D None, b=
ase =3D None,
         refresh_index()
=20
     try:
-        _input_str(['git-apply', '--index'], diff)
-    except GitException:
+        GRun('git-apply', '--index').raw_input(diff).no_output()
+    except GitRunException:
         if base:
             switch(orig_head)
         if fail_dump:
@@ -985,18 +923,12 @@ def clone(repository, local_dir):
     """Clone a remote repository. At the moment, just use the
     'git-clone' script
     """
-    if __run('git-clone', [repository, local_dir]) !=3D 0:
-        raise GitException, 'Failed "git-clone %s %s"' \
-              % (repository, local_dir)
+    GRun('git-clone', repository, local_dir).run()
=20
 def modifying_revs(files, base_rev, head_rev):
-    """Return the revisions from the list modifying the given files
-    """
-    cmd =3D ['git-rev-list', '%s..%s' % (base_rev, head_rev), '--']
-    revs =3D [line.strip() for line in _output_lines(cmd + files)]
-
-    return revs
-
+    """Return the revisions from the list modifying the given files.""=
"
+    return GRun('git-rev-list', '%s..%s' % (base_rev, head_rev), '--',=
 *files
+                ).output_lines()
=20
 def refspec_localpart(refspec):
     m =3D re.match('^[^:]*:([^:]*)$', refspec)
@@ -1091,4 +1023,4 @@ def all_refs():
     """Return a list of all refs in the current repository.
     """
=20
-    return [line.split()[1] for line in _output_lines(['git-show-ref']=
)]
+    return [line.split()[1] for line in GRun('git-show-ref').output_li=
nes()]
diff --git a/stgit/gitmergeonefile.py b/stgit/gitmergeonefile.py
index e76f9b1..2aa5ef8 100644
--- a/stgit/gitmergeonefile.py
+++ b/stgit/gitmergeonefile.py
@@ -23,7 +23,7 @@ from stgit import basedir
 from stgit.config import config, file_extensions, ConfigOption
 from stgit.utils import append_string
 from stgit.out import *
-
+from stgit.run import *
=20
 class GitMergeException(Exception):
     pass
@@ -44,12 +44,8 @@ def __str2none(x):
     else:
         return x
=20
-def __output(cmd):
-    f =3D os.popen(cmd, 'r')
-    string =3D f.readline().rstrip()
-    if f.close():
-        raise GitMergeException, 'Error: failed to execute "%s"' % cmd
-    return string
+class MRun(Run):
+    exc =3D GitMergeException # use a custom exception class on errors
=20
 def __checkout_files(orig_hash, file1_hash, file2_hash,
                      path,
@@ -62,24 +58,24 @@ def __checkout_files(orig_hash, file1_hash, file2_h=
ash,
=20
     if orig_hash:
         orig =3D path + extensions['ancestor']
-        tmp =3D __output('git-unpack-file %s' % orig_hash)
+        tmp =3D MRun('git-unpack-file', orig_hash).output_one_line()
         os.chmod(tmp, int(orig_mode, 8))
         os.renames(tmp, orig)
     if file1_hash:
         src1 =3D path + extensions['current']
-        tmp =3D __output('git-unpack-file %s' % file1_hash)
+        tmp =3D MRun('git-unpack-file', file1_hash).output_one_line()
         os.chmod(tmp, int(file1_mode, 8))
         os.renames(tmp, src1)
     if file2_hash:
         src2 =3D path + extensions['patched']
-        tmp =3D __output('git-unpack-file %s' % file2_hash)
+        tmp =3D MRun('git-unpack-file', file2_hash).output_one_line()
         os.chmod(tmp, int(file2_mode, 8))
         os.renames(tmp, src2)
=20
     if file1_hash and not os.path.exists(path):
         # the current file might be removed by GIT when it is a new
         # file added in both branches. Just re-generate it
-        tmp =3D __output('git-unpack-file %s' % file1_hash)
+        tmp =3D MRun('git-unpack-file', file1_hash).output_one_line()
         os.chmod(tmp, int(file1_mode, 8))
         os.renames(tmp, path)
=20
diff --git a/stgit/run.py b/stgit/run.py
new file mode 100644
index 0000000..d925cce
--- /dev/null
+++ b/stgit/run.py
@@ -0,0 +1,111 @@
+# -*- coding: utf-8 -*-
+
+__copyright__ =3D """
+Copyright (C) 2007, Karl Hasselstr=C3=B6m <kha@treskal.com>
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
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
+"""
+
+# popen2 and os.spawn* suck. We should really use subprocess instead,
+# but that's only available in Python 2.4 and up, and we try our best
+# to stay Python 2.3 compatible.
+import popen2, os
+
+class RunException(Exception):
+    """Thrown when something bad happened when we tried to run the
+    subprocess."""
+    pass
+
+class Run:
+    exc =3D RunException
+    def __init__(self, *cmd):
+        self.__cmd =3D list(cmd)
+        self.__good_retvals =3D [0]
+        self.__env =3D None
+        self.__indata =3D None
+    def __run_io(self, cmd):
+        """Run with captured IO. Note: arguments are parsed by the
+        shell. We single-quote them, so don't use anything with single
+        quotes in it."""
+        if self.__env =3D=3D None:
+            ecmd =3D cmd
+        else:
+            ecmd =3D (['env'] + ['%s=3D%s' % (key, val)
+                               for key, val in self.__env.iteritems()]
+                    + cmd)
+        p =3D popen2.Popen3(' '.join(["'%s'" % c for c in ecmd]), True=
)
+        if self.__indata !=3D None:
+            p.tochild.write(self.__indata)
+        p.tochild.close()
+        outdata =3D p.fromchild.read()
+        errdata =3D p.childerr.read()
+        self.exitcode =3D p.wait() >> 8
+        if errdata or self.exitcode not in self.__good_retvals:
+            raise self.exc('%s failed with code %d:\n%s'
+                           % (cmd[0], self.exitcode, errdata))
+        return outdata
+    def __run_noshell(self, cmd):
+        """Run without captured IO. Note: arguments are not parsed by
+        the shell."""
+        assert self.__env =3D=3D None
+        assert self.__indata =3D=3D None
+        self.exitcode =3D os.spawnvp(os.P_WAIT, cmd[0], cmd)
+        if not self.exitcode in self.__good_retvals:
+            raise self.exc('%s failed with code %d'
+                           % (cmd[0], self.exitcode))
+    def returns(self, retvals):
+        self.__good_retvals =3D retvals
+        return self
+    def env(self, env):
+        self.__env =3D env
+        return self
+    def raw_input(self, indata):
+        self.__indata =3D indata
+        return self
+    def input_lines(self, lines):
+        self.__indata =3D ''.join(['%s\n' % line for line in lines])
+        return self
+    def no_output(self):
+        outdata =3D self.__run_io(self.__cmd)
+        if outdata:
+            raise self.exc, '%s produced output' % self.__cmd[0]
+    def discard_output(self):
+        self.__run_io(self.__cmd)
+    def raw_output(self):
+        return self.__run_io(self.__cmd)
+    def output_lines(self):
+        outdata =3D self.__run_io(self.__cmd)
+        if outdata.endswith('\n'):
+            outdata =3D outdata[:-1]
+        if outdata:
+            return outdata.split('\n')
+        else:
+            return []
+    def output_one_line(self):
+        outlines =3D self.output_lines()
+        if len(outlines) =3D=3D 1:
+            return outlines[0]
+        else:
+            raise self.exc('%s produced %d lines, expected 1'
+                           % (self.__cmd[0], len(outlines)))
+    def run(self):
+        """Just run, with no IO redirection."""
+        self.__run_noshell(self.__cmd)
+    def xargs(self, xargs):
+        """Just run, with no IO redirection. The extra arguments are
+        appended to the command line a few at a time; the command is
+        run as many times as needed to consume them all."""
+        step =3D 100
+        for i in xrange(0, len(xargs), step):
+            self.__run_noshell(self.__cmd + xargs[i:i+step])
