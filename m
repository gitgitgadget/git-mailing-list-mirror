From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH] stgit: allow spaces in filenames
Date: Wed, 13 Jul 2005 04:38:11 -0400
Message-ID: <20050713083805.18461.87079.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org,
	catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 13 10:38:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsclB-0000kO-2O
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 10:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVGMIiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 04:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVGMIiL
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 04:38:11 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:55669 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262547AbVGMIiL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 04:38:11 -0400
Received: (qmail 56393 invoked from network); 13 Jul 2005 08:38:10 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:Subject;
  b=2vnC/SmcVJyx5TVi1QivZWBATGcInTNRzdH+1iWp9evhgmRDBIt2ykrBbV9WxR960+w/Kg3tvok916lJ1BTAiBfZQ15y8+wVE0sq12WqhyBrd69a+YicX0c7wOJUicb8ZSo6DZVQFKHDWfwSsqgH9V3Ce48k4Io5eqXlr0NylFg=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@69.159.204.165 with plain)
  by smtp015.mail.yahoo.com with SMTP; 13 Jul 2005 08:38:09 -0000
To: bryan.larsen@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The current version of stgit does not allow whitespace in filenames.  This patch fixes that.  It also speeds up operations on large filesets considerably.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 stgit/git.py  |  158 +++++++++++++++++++++++++++++++--------------------------
 stgit/main.py |    8 +--
 2 files changed, 90 insertions(+), 76 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -101,6 +101,24 @@ def __output(cmd):
         raise GitException, '%s failed' % cmd
     return string
 
+# __run: runs cmd using spawnvp.
+#
+#  The shell is avoided so it won't mess up our arguments.
+# If args is very large, the command is run multiple times;
+# args is split xargs style:  cmd is passed on each invocation.
+# Unlike xargs, returns immediately if any non-zero return code 
+# is received.
+#
+def __run(cmd, args=None):
+    args_l=cmd.split()
+    if args is None:
+	args = []
+    for i in range(0, len(args)+1, 1000):
+	r=os.spawnvp(os.P_WAIT, args_l[0], args_l + args[i:min(i+1000, len(args))])
+	if r:
+	    return r
+    return 0
+
 def __check_base_dir():
     return os.path.isdir(base_dir)
 
@@ -114,14 +132,16 @@ def __tree_status(files = [], tree_id = 
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
+            extra_exclude.append('--exclude-from=%s' % exclude_file)
+        fin, fout = os.popen2(['git-ls-files', '--others',
+                        '--exclude=*.[ao]', '--exclude=.*'
+                        '--exclude=TAGS', '--exclude=tags', '--exclude=*~',
+                        '--exclude=#*'] + extra_exclude)
         cache_files += [('?', line.strip()) for line in fout]
+	fin.close()
+	fout.close()
 
     # conflicted files
     conflicts = get_conflicts()
@@ -130,13 +150,12 @@ def __tree_status(files = [], tree_id = 
     cache_files += [('C', filename) for filename in conflicts]
 
     # the rest
-    files_str = reduce(lambda x, y: x + ' ' + y, files, '')
-    fout = os.popen('git-diff-cache -r %s %s' % (tree_id, files_str), 'r')
+    fin, fout = os.popen2(['git-diff-cache', '-r', tree_id] + files)
     for line in fout:
-        fs = tuple(line.split()[4:])
+        fs = tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
         if fs[1] not in conflicts:
             cache_files.append(fs)
-    if fout.close():
+    if fout.close() or fin.close():
         raise GitException, 'git-diff-cache failed'
 
     return cache_files
@@ -185,10 +204,9 @@ def add(names):
         else:
             raise GitException, '%s is not a file or directory' % i
 
-    for f in files:
-        print 'Adding file %s' % f
-        if os.system('git-update-cache --add -- %s' % f) != 0:
-            raise GitException, 'Unable to add %s' % f
+    if files:
+	if __run('git-update-cache --add --', files):
+            raise GitException, 'Unable to add file'
 
 def rm(files, force = False):
     """Remove a file from the repository
@@ -198,26 +216,32 @@ def rm(files, force = False):
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
+	for f in files:
+	    if os.path.exists(f):
+		raise GitException, '%s exists. Remove it first' %f
+	if files:
+	    __run('git-update-cache --remove --', files)
+    else:
+	if files:
+	    __run('git-update-cache --force-remove --', files)
 
 def update_cache(files):
     """Update the cache information for the given files
     """
+    files_here = []
+    files_gone = []
+
     for f in files:
         if os.path.exists(f):
-            os.system('git-update-cache -- %s' % f)
+	    files_here.append(f)
         else:
-            os.system('git-update-cache --remove -- %s' % f)
+	    files_gone.append(f)
+
+    if files_here:
+	__run('git-update-cache --', files_here)
+    if files_gone:
+	__run('git-update-cache --remove --', files_gone)
 
 def commit(message, files = [], parents = [], allowempty = False,
            author_name = None, author_email = None, author_date = None,
@@ -248,16 +272,26 @@ def commit(message, files = [], parents 
 
     # update the cache
     if not first:
+	add_files=[]
+	rm_files=[]
+	m_files=[]
         for f in cache_files:
             if f[0] == 'N':
-                git_flag = '--add'
+		add_files.append(f[1])
             elif f[0] == 'D':
-                git_flag = '--force-remove'
+		rm_files.append(f[1])
             else:
-                git_flag = '--'
+                m_files.append(f[1])
 
-            if os.system('git-update-cache %s %s' % (git_flag, f[1])) != 0:
-                raise GitException, 'Failed git-update-cache -- %s' % f[1]
+	if add_files:
+	    if __run('git-update-cache --add --', add_files):
+		raise GitException, 'Failed git-update-cache --add'
+	if rm_files:
+	    if __run('git-update-cache --force-remove --', rm_files):
+		raise GitException, 'Failed git-update-cache --rm'
+	if m_files:
+	    if __run('git-update-cache --', m_files):
+		raise GitException, 'Failed git-update-cache'
 
     # write the index to repository
     tree_id = __output('git-write-tree')
@@ -292,7 +326,7 @@ def merge(base, head1, head2):
     """Perform a 3-way merge between base, head1 and head2 into the
     local tree
     """
-    if os.system('git-read-tree -u -m %s %s %s' % (base, head1, head2)) != 0:
+    if __run('git-read-tree -u -m', [base, head1, head2]) != 0:
         raise GitException, 'git-read-tree failed (local changes maybe?)'
 
     # this can fail if there are conflicts
@@ -330,51 +364,31 @@ def status(files = [], modified = False,
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
+	nf, in_fd = os.popen2(['git-diff-tree', '-p', rev1, rev2]+files)
     else:
-        if os.system('git-diff-cache -p %s %s %s'
-                     % (rev1, files_str, extra_args)) != 0:
-            raise GitException, 'git-diff-cache failed'
+	nf, in_fd = os.popen2(['git-diff-cache', '-p', rev1]+files)
+    
+    out_fd.write(in_fd.read())
+    if in_fd.close() or nf.close():
+	raise GitException, 'git.diff failed'
 
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
+    ds_in, ds_out = os.popen2('git-apply --stat')
+    diff(files, rev1, rev2, ds_in)
+    ds_in.close()
+    str = ds_out.read().rstrip()
+    if ds_out.close():
+	raise GitException, 'git.diffstat failed'
     return str
 
 def files(rev1, rev2):
@@ -386,7 +400,7 @@ def files(rev1, rev2):
     f = os.popen('git-diff-tree -r %s %s' % (rev1, rev2),
                  'r')
     for line in f:
-        str += '%s %s\n' % tuple(line.split()[4:])
+        str += '%s %s\n' % tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
     if f.close():
         raise GitException, 'git-diff-tree failed'
 
@@ -395,23 +409,23 @@ def files(rev1, rev2):
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
+	git_flags += ' --'
 
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
diff --git a/stgit/main.py b/stgit/main.py
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -720,13 +720,13 @@ def export(parser, options, args):
                   'supported in the patch template'
         f = open(pfile, 'w+')
         f.write(descr)
-        f.close()
 
         # write the diff
-        git.diff(rev1 = __git_id('%s/bottom' % p),
+	git.diff(rev1 = __git_id('%s/bottom' % p),
                  rev2 = __git_id('%s/top' % p),
-                 output = pfile, append = True)
-        patch_no += 1
+                 out_fd = f)
+	f.close()
+	patch_no += 1
 
     series.close()
 
