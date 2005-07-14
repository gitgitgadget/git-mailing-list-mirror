From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH] stgit: allow spaces in filenames (second try)
Date: Thu, 14 Jul 2005 02:27:38 -0400
Message-ID: <20050714062733.21779.33599.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org,
	catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 14 08:28:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsxCD-0004AV-0k
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 08:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVGNG1j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 02:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbVGNG1i
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 02:27:38 -0400
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:35976 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262703AbVGNG1i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 02:27:38 -0400
Received: (qmail 39792 invoked from network); 14 Jul 2005 06:27:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=NvCbxrxlNiW0mAkvxLvy0prdwGs6m9RgQPqeLtiPGhBabk3QJe1+8Q0SvcZthINkTxYkFbBR9BEbhpWOA3ORqAcp2gUCdxDTsz+iiR6Wi+vE7N8qssMx3LkyN74mcYultmkmof7bM9OgRC9dyTcoJn0JaUkbt35olZsLoEf82no=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@69.159.204.165 with plain)
  by smtp111.mail.sc5.yahoo.com with SMTP; 14 Jul 2005 06:27:36 -0000
To: bryan.larsen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The current version of stgit does not allow whitespace in filenames.  This patch fixes that.  It also speeds up operations on large filesets considerably.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 stgit/commands/export.py |    4 -
 stgit/git.py             |  203 ++++++++++++++++++++++++----------------------
 2 files changed, 110 insertions(+), 97 deletions(-)

diff --git a/stgit/commands/export.py b/stgit/commands/export.py
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -144,12 +144,12 @@ def func(parser, options, args):
                   'supported in the patch template'
         f = open(pfile, 'w+')
         f.write(descr)
-        f.close()
 
         # write the diff
         git.diff(rev1 = git_id('%s/bottom' % p),
                  rev2 = git_id('%s/top' % p),
-                 output = pfile, append = True)
+                 out_fd = f)
+        f.close()
         patch_no += 1
 
     series.close()
diff --git a/stgit/git.py b/stgit/git.py
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -18,7 +18,7 @@ along with this program; if not, write t
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os, glob
+import sys, os, glob, popen2
 
 from stgit.utils import *
 
@@ -35,7 +35,6 @@ else:
 
 head_link = os.path.join(base_dir, 'HEAD')
 
-
 #
 # Classes
 #
@@ -44,9 +43,10 @@ class Commit:
     """
     def __init__(self, id_hash):
         self.__id_hash = id_hash
-        f = os.popen('git-cat-file commit %s' % id_hash, 'r')
 
-        for line in f:
+        lines = _output_lines('git-cat-file commit %s' % id_hash)
+        for i in range(len(lines)):
+            line = lines[i]
             if line == '\n':
                 break
             field = line.strip().split(' ', 1)
@@ -58,10 +58,7 @@ class Commit:
                 self.__author = field[1]
             if field[0] == 'comitter':
                 self.__committer = field[1]
-        self.__log = f.read()
-
-        if f.close():
-            raise GitException, 'Unknown commit id'
+        self.__log = ''.join(lines[i:])
 
     def get_id_hash(self):
         return self.__id_hash
@@ -94,13 +91,46 @@ def get_conflicts():
     else:
         return None
 
-def __output(cmd):
-    f = os.popen(cmd, 'r')
-    string = f.readline().strip()
-    if f.close():
-        raise GitException, '%s failed' % cmd
+def _output(cmd):
+    p=popen2.Popen3(cmd)
+    string = p.fromchild.read()
+    if p.wait():
+        raise GitException, '%s failed' % str(cmd)
     return string
 
+def _output_one_line(cmd):
+    p=popen2.Popen3(cmd)
+    string = p.fromchild.readline().strip()
+    if p.wait():
+        raise GitException, '%s failed' % str(cmd)
+    return string
+
+def _output_lines(cmd):
+    p=popen2.Popen3(cmd)
+    lines = p.fromchild.readlines()
+    if p.wait():
+        raise GitException, '%s failed' % str(cmd)
+    return lines
+
+def __run(cmd, args=None):
+    """__run: runs cmd using spawnvp.
+
+    Runs cmd using spawnvp.  The shell is avoided so it won't mess up
+    our arguments.  If args is very large, the command is run multiple
+    times; args is split xargs style: cmd is passed on each
+    invocation.  Unlike xargs, returns immediately if any non-zero
+    return code is received.  
+    """
+    
+    args_l=cmd.split()
+    if args is None:
+        args = []
+    for i in range(0, len(args)+1, 100):
+        r=os.spawnvp(os.P_WAIT, args_l[0], args_l + args[i:min(i+100, len(args))])
+    if r:
+        return r
+    return 0
+
 def __check_base_dir():
     return os.path.isdir(base_dir)
 
@@ -114,14 +144,14 @@ def __tree_status(files = [], tree_id = 
     # unknown files
     if unknown:
         exclude_file = os.path.join(base_dir, 'exclude')
-        extra_exclude = ''
+        extra_exclude = []
         if os.path.exists(exclude_file):
-            extra_exclude += ' --exclude-from=%s' % exclude_file
-        fout = os.popen('git-ls-files --others'
-                        ' --exclude="*.[ao]" --exclude=".*"'
-                        ' --exclude=TAGS --exclude=tags --exclude="*~"'
-                        ' --exclude="#*"' + extra_exclude, 'r')
-        cache_files += [('?', line.strip()) for line in fout]
+            extra_exclude.append('--exclude-from=%s' % exclude_file)
+        lines = _output_lines(['git-ls-files', '--others',
+                        '--exclude=*.[ao]', '--exclude=.*'
+                        '--exclude=TAGS', '--exclude=tags', '--exclude=*~',
+                        '--exclude=#*'] + extra_exclude)
+        cache_files += [('?', line.strip()) for line in lines]
 
     # conflicted files
     conflicts = get_conflicts()
@@ -130,14 +160,10 @@ def __tree_status(files = [], tree_id = 
     cache_files += [('C', filename) for filename in conflicts]
 
     # the rest
-    files_str = reduce(lambda x, y: x + ' ' + y, files, '')
-    fout = os.popen('git-diff-cache -r %s %s' % (tree_id, files_str), 'r')
-    for line in fout:
-        fs = tuple(line.split()[4:])
+    for line in _output_lines(['git-diff-cache', '-r', tree_id] + files):
+        fs = tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
         if fs[1] not in conflicts:
             cache_files.append(fs)
-    if fout.close():
-        raise GitException, 'git-diff-cache failed'
 
     return cache_files
 
@@ -185,10 +211,9 @@ def add(names):
         else:
             raise GitException, '%s is not a file or directory' % i
 
-    for f in files:
-        print 'Adding file %s' % f
-        if os.system('git-update-cache --add -- %s' % f) != 0:
-            raise GitException, 'Unable to add %s' % f
+    if files:
+        if __run('git-update-cache --add --', files):
+            raise GitException, 'Unable to add file'
 
 def rm(files, force = False):
     """Remove a file from the repository
@@ -198,26 +223,32 @@ def rm(files, force = False):
     else:
         git_opt = '--remove'
 
-    for f in files:
-        if force:
-            print 'Removing file %s' % f
-            if os.system('git-update-cache --force-remove -- %s' % f) != 0:
-                raise GitException, 'Unable to remove %s' % f
-        elif os.path.exists(f):
-            raise GitException, '%s exists. Remove it first' %f
-        else:
-            print 'Removing file %s' % f
-            if os.system('git-update-cache --remove -- %s' % f) != 0:
-                raise GitException, 'Unable to remove %s' % f
+    if not force:
+        for f in files:
+            if os.path.exists(f):
+                raise GitException, '%s exists. Remove it first' %f
+        if files:
+            __run('git-update-cache --remove --', files)
+    else:
+        if files:
+            __run('git-update-cache --force-remove --', files)
 
 def update_cache(files):
     """Update the cache information for the given files
     """
+    files_here = []
+    files_gone = []
+
     for f in files:
         if os.path.exists(f):
-            os.system('git-update-cache -- %s' % f)
+            files_here.append(f)
         else:
-            os.system('git-update-cache --remove -- %s' % f)
+            files_gone.append(f)
+
+    if files_here:
+        __run('git-update-cache --', files_here)
+    if files_gone:
+        __run('git-update-cache --remove --', files_gone)
 
 def commit(message, files = [], parents = [], allowempty = False,
            author_name = None, author_email = None, author_date = None,
@@ -248,19 +279,29 @@ def commit(message, files = [], parents 
 
     # update the cache
     if not first:
+        add_files=[]
+        rm_files=[]
+        m_files=[]
         for f in cache_files:
             if f[0] == 'N':
-                git_flag = '--add'
+                add_files.append(f[1])
             elif f[0] == 'D':
-                git_flag = '--force-remove'
+                rm_files.append(f[1])
             else:
-                git_flag = '--'
+                m_files.append(f[1])
 
-            if os.system('git-update-cache %s %s' % (git_flag, f[1])) != 0:
-                raise GitException, 'Failed git-update-cache -- %s' % f[1]
+    if add_files:
+        if __run('git-update-cache --add --', add_files):
+            raise GitException, 'Failed git-update-cache --add'
+    if rm_files:
+        if __run('git-update-cache --force-remove --', rm_files):
+            raise GitException, 'Failed git-update-cache --rm'
+    if m_files:
+        if __run('git-update-cache --', m_files):
+            raise GitException, 'Failed git-update-cache'
 
     # write the index to repository
-    tree_id = __output('git-write-tree')
+    tree_id = _output_one_line('git-write-tree')
 
     # the commit
     cmd = ''
@@ -282,7 +323,7 @@ def commit(message, files = [], parents 
 
     cmd += ' < .commitmsg'
 
-    commit_id = __output(cmd)
+    commit_id = _output_one_line(cmd)
     __set_head(commit_id)
     os.remove('.commitmsg')
 
@@ -292,7 +333,7 @@ def merge(base, head1, head2):
     """Perform a 3-way merge between base, head1 and head2 into the
     local tree
     """
-    if os.system('git-read-tree -u -m %s %s %s' % (base, head1, head2)) != 0:
+    if __run('git-read-tree -u -m', [base, head1, head2]) != 0:
         raise GitException, 'git-read-tree failed (local changes maybe?)'
 
     # this can fail if there are conflicts
@@ -330,51 +371,27 @@ def status(files = [], modified = False,
         else:
             print '%s' % fs[1]
 
-def diff(files = [], rev1 = 'HEAD', rev2 = None, output = None,
-         append = False):
+def diff(files = [], rev1 = 'HEAD', rev2 = None, out_fd = sys.stdout):
     """Show the diff between rev1 and rev2
     """
-    files_str = reduce(lambda x, y: x + ' ' + y, files, '')
-
-    extra_args = ''
-    if output:
-        if append:
-            extra_args += ' >> %s' % output
-        else:
-            extra_args += ' > %s' % output
-
     os.system('git-update-cache --refresh > /dev/null')
 
     if rev2:
-        if os.system('git-diff-tree -p %s %s %s %s'
-                     % (rev1, rev2, files_str, extra_args)) != 0:
-            raise GitException, 'git-diff-tree failed'
+        out_fd.write(_output(['git-diff-tree', '-p', rev1, rev2]+files))
     else:
-        if os.system('git-diff-cache -p %s %s %s'
-                     % (rev1, files_str, extra_args)) != 0:
-            raise GitException, 'git-diff-cache failed'
+        out_fd.write(_output(['git-diff-cache', '-p', rev1]+files))
 
 def diffstat(files = [], rev1 = 'HEAD', rev2 = None):
     """Return the diffstat between rev1 and rev2
     """
-    files_str = reduce(lambda x, y: x + ' ' + y, files, '')
 
     os.system('git-update-cache --refresh > /dev/null')
-    ds_cmd = '| git-apply --stat'
-
-    if rev2:
-        f = os.popen('git-diff-tree -p %s %s %s %s'
-                     % (rev1, rev2, files_str, ds_cmd), 'r')
-        str = f.read().rstrip()
-        if f.close():
-            raise GitException, 'git-diff-tree failed'
-    else:
-        f = os.popen('git-diff-cache -p %s %s %s'
-                     % (rev1, files_str, ds_cmd), 'r')
-        str = f.read().rstrip()
-        if f.close():
-            raise GitException, 'git-diff-cache failed'
-
+    p=popen2.Popen3('git-apply --stat')
+    diff(files, rev1, rev2, p.tochild)
+    p.tochild.close()
+    str = p.fromchild.read().rstrip()
+    if p.wait():
+        raise GitException, 'git.diffstat failed'
     return str
 
 def files(rev1, rev2):
@@ -383,35 +400,31 @@ def files(rev1, rev2):
     os.system('git-update-cache --refresh > /dev/null')
 
     str = ''
-    f = os.popen('git-diff-tree -r %s %s' % (rev1, rev2),
-                 'r')
-    for line in f:
-        str += '%s %s\n' % tuple(line.split()[4:])
-    if f.close():
-        raise GitException, 'git-diff-tree failed'
+    for line in _output_lines('git-diff-tree -r %s %s' % (rev1, rev2)):
+        str += '%s %s\n' % tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
 
     return str.rstrip()
 
 def checkout(files = [], force = False):
     """Check out the given or all files
     """
-    git_flags = ''
+    git_flags = 'git-checkout-cache -q -u'
     if force:
         git_flags += ' -f'
     if len(files) == 0:
         git_flags += ' -a'
     else:
-        git_flags += reduce(lambda x, y: x + ' ' + y, files, ' --')
+        git_flags += ' --'
 
-    if os.system('git-checkout-cache -q -u%s' % git_flags) != 0:
-        raise GitException, 'Failed git-checkout-cache -q -u%s' % git_flags
+    if __run(git_flags, files) != 0:
+        raise GitException, 'Failed git-checkout-cache'
 
 def switch(tree_id):
     """Switch the tree to the given id
     """
     to_delete = filter(lambda x: x[0] == 'N', __tree_status(tree_id = tree_id))
 
-    if os.system('git-read-tree -m %s' % tree_id) != 0:
+    if __run('git-read-tree -m', [tree_id]) != 0:
         raise GitException, 'Failed git-read-tree -m %s' % tree_id
 
     checkout(force = True)
