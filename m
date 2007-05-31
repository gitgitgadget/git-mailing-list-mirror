From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/4] Call external commands without a shell where possible.
Date: Fri, 01 Jun 2007 00:34:28 +0200
Message-ID: <20070531223428.6005.16339.stgit@gandelf.nowhere.earth>
References: <20070531222920.6005.74481.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 00:36:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HttGE-0006MX-KN
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 00:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbXEaWgn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 18:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753460AbXEaWgn
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 18:36:43 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51734 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753868AbXEaWgm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 18:36:42 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 3916B7259;
	Fri,  1 Jun 2007 00:36:41 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 9C3161F157;
	Fri,  1 Jun 2007 00:34:28 +0200 (CEST)
In-Reply-To: <20070531222920.6005.74481.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48826>


On my dev box it consistently improves performance when timing the
full testsuite:

before:

user    2m22.509s
sys     0m50.695s

user    2m23.565s
sys     0m49.399s

user    2m23.497s
sys     0m49.675s

after:

user    2m20.261s
sys     0m45.687s

user    2m21.485s
sys     0m46.427s

user    2m20.581s
sys     0m45.367s

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/git.py |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 845c712..5cdc8cd 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -74,7 +74,7 @@ class Commit:
     def __init__(self, id_hash):
         self.__id_hash = id_hash
 
-        lines = _output_lines('git-cat-file commit %s' % id_hash)
+        lines = _output_lines(['git-cat-file', 'commit', id_hash])
         for i in range(len(lines)):
             line = lines[i]
             if line == '\n':
@@ -102,8 +102,8 @@ class Commit:
             return None
 
     def get_parents(self):
-        return _output_lines('git-rev-list --parents --max-count=1 %s'
-                             % self.__id_hash)[0].split()[1:]
+        return _output_lines(['git-rev-list', '--parents', '--max-count=1',
+                              self.__id_hash])[0].split()[1:]
 
     def get_author(self):
         return self.__author
@@ -285,7 +285,7 @@ def get_head_file():
     """Returns the name of the file pointed to by the HEAD link
     """
     return strip_prefix('refs/heads/',
-                        _output_one_line('git-symbolic-ref HEAD'))
+                        _output_one_line(['git-symbolic-ref', 'HEAD']))
 
 def set_head_file(ref):
     """Resets HEAD to point to a new ref
@@ -617,27 +617,27 @@ def commit(message, files = None, parents = None, allowempty = False,
     must_switch = True
     # write the index to repository
     if tree_id == None:
-        tree_id = _output_one_line('git-write-tree')
+        tree_id = _output_one_line(['git-write-tree'])
     else:
         must_switch = False
 
     # the commit
-    cmd = ''
+    cmd = ['env']
     if author_name:
-        cmd += 'GIT_AUTHOR_NAME="%s" ' % author_name
+        cmd += ['GIT_AUTHOR_NAME=%s' % author_name]
     if author_email:
-        cmd += 'GIT_AUTHOR_EMAIL="%s" ' % author_email
+        cmd += ['GIT_AUTHOR_EMAIL=%s' % author_email]
     if author_date:
-        cmd += 'GIT_AUTHOR_DATE="%s" ' % author_date
+        cmd += ['GIT_AUTHOR_DATE=%s' % author_date]
     if committer_name:
-        cmd += 'GIT_COMMITTER_NAME="%s" ' % committer_name
+        cmd += ['GIT_COMMITTER_NAME=%s' % committer_name]
     if committer_email:
-        cmd += 'GIT_COMMITTER_EMAIL="%s" ' % committer_email
-    cmd += 'git-commit-tree %s' % tree_id
+        cmd += ['GIT_COMMITTER_EMAIL=%s' % committer_email]
+    cmd += ['git-commit-tree', tree_id]
 
     # get the parents
     for p in parents:
-        cmd += ' -p %s' % p
+        cmd += ['-p', p]
 
     commit_id = _output_one_line(cmd, message)
     if must_switch:
@@ -652,9 +652,9 @@ def apply_diff(rev1, rev2, check_index = True, files = None):
     the pushing would fall back to the three-way merge.
     """
     if check_index:
-        index_opt = '--index'
+        index_opt = ['--index']
     else:
-        index_opt = ''
+        index_opt = []
 
     if not files:
         files = []
@@ -662,7 +662,7 @@ def apply_diff(rev1, rev2, check_index = True, files = None):
     diff_str = diff(files, rev1, rev2)
     if diff_str:
         try:
-            _input_str('git-apply %s' % index_opt, diff_str)
+            _input_str(['git-apply'] + index_opt, diff_str)
         except GitException:
             return False
 
@@ -680,7 +680,7 @@ def merge(base, head1, head2, recursive = False):
         # general when pushing or picking patches)
         try:
             # use _output() to mask the verbose prints of the tool
-            _output('git-merge-recursive %s -- %s %s' % (base, head1, head2))
+            _output(['git-merge-recursive', base, '--', head1, head2])
         except GitException, ex:
             err_output = str(ex)
             pass
@@ -696,7 +696,7 @@ def merge(base, head1, head2, recursive = False):
     files = {}
     stages_re = re.compile('^([0-7]+) ([0-9a-f]{40}) ([1-3])\t(.*)$', re.S)
 
-    for line in _output('git-ls-files --unmerged --stage -z').split('\0'):
+    for line in _output(['git-ls-files', '--unmerged', '--stage', '-z']).split('\0'):
         if not line:
             continue
 
@@ -818,7 +818,7 @@ def files(rev1, rev2):
     """
 
     result = ''
-    for line in _output_lines('git-diff-tree -r %s %s' % (rev1, rev2)):
+    for line in _output_lines(['git-diff-tree', '-r', rev1, rev2]):
         result += '%s %s\n' % tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
 
     return result.rstrip()
@@ -828,7 +828,7 @@ def barefiles(rev1, rev2):
     """
 
     result = ''
-    for line in _output_lines('git-diff-tree -r %s %s' % (rev1, rev2)):
+    for line in _output_lines(['git-diff-tree', '-r', rev1, rev2]):
         result += '%s\n' % line.rstrip().split(' ',4)[-1].split('\t',1)[-1]
 
     return result.rstrip()
@@ -947,7 +947,7 @@ def apply_patch(filename = None, diff = None, base = None,
         refresh_index()
 
     try:
-        _input_str('git-apply --index', diff)
+        _input_str(['git-apply', '--index'], diff)
     except GitException:
         if base:
             switch(orig_head)
