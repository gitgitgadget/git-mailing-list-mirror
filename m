From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 2/7] Use git-rev-parse to find the local GIT repository
Date: Tue, 29 Nov 2005 17:09:40 -0500
Message-ID: <20051129220940.9885.55885.stgit@dexter.citi.umich.edu>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 23:11:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhDfo-0006zv-CO
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 23:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbVK2WJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 17:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVK2WJm
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 17:09:42 -0500
Received: from citi.umich.edu ([141.211.133.111]:3477 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932438AbVK2WJl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 17:09:41 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id D0F191BBD7;
	Tue, 29 Nov 2005 17:09:40 -0500 (EST)
To: catalin.marinas@gmail.com
In-Reply-To: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12959>

Use the latest git-rev-parse technology to allow some StGIT commands to
function correctly in subdirectories of the working directory.

Any command that relies on git-read-tree still doesn't work (changes to
GIT forthcoming).

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/commands/branch.py   |    2 +-
 stgit/commands/common.py   |    4 ++--
 stgit/commands/export.py   |    2 +-
 stgit/commands/mail.py     |    4 ++--
 stgit/commands/resolved.py |    4 ++--
 stgit/git.py               |   35 ++++++++++++++++++-----------------
 stgit/stack.py             |    9 +++++----
 7 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 9bf6cdb..c3f7944 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -136,7 +136,7 @@ def func(parser, options, args):
         if len(args) != 0:
             parser.error('incorrect number of arguments')
 
-        branches = os.listdir(os.path.join(git.base_dir, 'refs', 'heads'))
+        branches = os.listdir(os.path.join(git.get_base_dir(), 'refs', 'heads'))
         branches.sort()
 
         print 'Available branches:'
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index e437111..8084cbd 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -96,7 +96,7 @@ def check_head_top_equal():
               '  are doing, use the "refresh -f" command'
 
 def check_conflicts():
-    if os.path.exists(os.path.join(git.base_dir, 'conflicts')):
+    if os.path.exists(os.path.join(git.get_base_dir(), 'conflicts')):
         raise CmdException, 'Unsolved conflicts. Please resolve them first'
 
 def print_crt_patch(branch = None):
@@ -130,7 +130,7 @@ def resolved_all(reset = None):
     if conflicts:
         for filename in conflicts:
             resolved(filename, reset)
-        os.remove(os.path.join(git.base_dir, 'conflicts'))
+        os.remove(os.path.join(git.get_base_dir(), 'conflicts'))
 
 def name_email(address):
     """Return a tuple consisting of the name and email parsed from a
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 167a8d3..c93ab6e 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -132,7 +132,7 @@ def func(parser, options, args):
     else:
         patch_tmpl_list = []
 
-    patch_tmpl_list += [os.path.join(git.base_dir, 'patchexport.tmpl'),
+    patch_tmpl_list += [os.path.join(git.get_base_dir(), 'patchexport.tmpl'),
                         os.path.join(sys.prefix,
                                      'share/stgit/templates/patchexport.tmpl')]
     tmpl = ''
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 7cc18bc..b3b7b49 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -419,7 +419,7 @@ def func(parser, options, args):
         if options.cover:
             tfile_list = [options.cover]
         else:
-            tfile_list = [os.path.join(git.base_dir, 'covermail.tmpl'),
+            tfile_list = [os.path.join(git.get_base_dir(), 'covermail.tmpl'),
                           os.path.join(sys.prefix,
                                        'share/stgit/templates/covermail.tmpl')]
 
@@ -450,7 +450,7 @@ def func(parser, options, args):
     if options.template:
         tfile_list = [options.template]
     else:
-        tfile_list = [os.path.join(git.base_dir, 'patchmail.tmpl'),
+        tfile_list = [os.path.join(git.get_base_dir(), 'patchmail.tmpl'),
                       os.path.join(sys.prefix,
                                    'share/stgit/templates/patchmail.tmpl')]
     tmpl = None
diff --git a/stgit/commands/resolved.py b/stgit/commands/resolved.py
index d21ecc9..585c51b 100644
--- a/stgit/commands/resolved.py
+++ b/stgit/commands/resolved.py
@@ -65,8 +65,8 @@ def func(parser, options, args):
 
     # save or remove the conflicts file
     if conflicts == []:
-        os.remove(os.path.join(git.base_dir, 'conflicts'))
+        os.remove(os.path.join(git.get_base_dir(), 'conflicts'))
     else:
-        f = file(os.path.join(git.base_dir, 'conflicts'), 'w+')
+        f = file(os.path.join(git.get_base_dir(), 'conflicts'), 'w+')
         f.writelines([line + '\n' for line in conflicts])
         f.close()
diff --git a/stgit/git.py b/stgit/git.py
index b19f75f..2cedeaa 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -27,12 +27,6 @@ class GitException(Exception):
     pass
 
 
-# Different start-up variables read from the environment
-if 'GIT_DIR' in os.environ:
-    base_dir = os.environ['GIT_DIR']
-else:
-    base_dir = '.git'
-
 
 #
 # Classes
@@ -87,6 +81,15 @@ __commits = dict()
 #
 # Functions
 #
+
+def get_base_dir():
+    """Different start-up variables read from the environment
+    """
+    if 'GIT_DIR' in os.environ:
+        return os.environ['GIT_DIR']
+    else:
+        return _output_one_line('git-rev-parse --git-dir')
+
 def get_commit(id_hash):
     """Commit objects factory. Save/look-up them in the __commits
     dictionary
@@ -103,7 +106,7 @@ def get_commit(id_hash):
 def get_conflicts():
     """Return the list of file conflicts
     """
-    conflicts_file = os.path.join(base_dir, 'conflicts')
+    conflicts_file = os.path.join(get_base_dir(), 'conflicts')
     if os.path.isfile(conflicts_file):
         f = file(conflicts_file)
         names = [line.strip() for line in f.readlines()]
@@ -167,9 +170,6 @@ def __run(cmd, args=None):
         return r
     return 0
 
-def __check_base_dir():
-    return os.path.isdir(base_dir)
-
 def __tree_status(files = None, tree_id = 'HEAD', unknown = False,
                   noexclude = True):
     """Returns a list of pairs - [status, filename]
@@ -182,7 +182,7 @@ def __tree_status(files = None, tree_id 
 
     # unknown files
     if unknown:
-        exclude_file = os.path.join(base_dir, 'info', 'exclude')
+        exclude_file = os.path.join(get_base_dir(), 'info', 'exclude')
         base_exclude = ['--exclude=%s' % s for s in
                         ['*.[ao]', '*.pyc', '.*', '*~', '#*', 'TAGS', 'tags']]
         base_exclude.append('--exclude-per-directory=.gitignore')
@@ -296,8 +296,8 @@ def create_branch(new_branch, tree_id = 
     if tree_id:
         switch(tree_id)
 
-    if os.path.isfile(os.path.join(base_dir, 'MERGE_HEAD')):
-        os.remove(os.path.join(base_dir, 'MERGE_HEAD'))
+    if os.path.isfile(os.path.join(get_base_dir(), 'MERGE_HEAD')):
+        os.remove(os.path.join(get_base_dir(), 'MERGE_HEAD'))
 
 def switch_branch(name):
     """Switch to a git branch
@@ -316,8 +316,8 @@ def switch_branch(name):
         __head = tree_id
     set_head_file(new_head)
 
-    if os.path.isfile(os.path.join(base_dir, 'MERGE_HEAD')):
-        os.remove(os.path.join(base_dir, 'MERGE_HEAD'))
+    if os.path.isfile(os.path.join(get_base_dir(), 'MERGE_HEAD')):
+        os.remove(os.path.join(get_base_dir(), 'MERGE_HEAD'))
 
 def delete_branch(name):
     """Delete a git branch
@@ -325,7 +325,7 @@ def delete_branch(name):
     branch_head = os.path.join('refs', 'heads', name)
     if not branch_exists(branch_head):
         raise GitException, 'Branch "%s" does not exist' % name
-    os.remove(os.path.join(base_dir, branch_head))
+    os.remove(os.path.join(get_base_dir(), branch_head))
 
 def rename_branch(from_name, to_name):
     """Rename a git branch
@@ -339,7 +339,8 @@ def rename_branch(from_name, to_name):
 
     if get_head_file() == from_name:
         set_head_file(to_head)
-    os.rename(os.path.join(base_dir, from_head), os.path.join(base_dir, to_head))
+    os.rename(os.path.join(get_base_dir(), from_head), \
+              os.path.join(get_base_dir(), to_head))
 
 def add(names):
     """Add the files or recursively add the directory contents
diff --git a/stgit/stack.py b/stgit/stack.py
index 18b4c6e..dc7c19f 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -66,7 +66,7 @@ def __clean_comments(f):
 
 def edit_file(series, line, comment, show_patch = True):
     fname = '.stgit.msg'
-    tmpl = os.path.join(git.base_dir, 'patchdescr.tmpl')
+    tmpl = os.path.join(git.get_base_dir(), 'patchdescr.tmpl')
 
     f = file(fname, 'w+')
     if line:
@@ -263,9 +263,10 @@ class Series:
             self.__name = git.get_head_file()
 
         if self.__name:
-            self.__patch_dir = os.path.join(git.base_dir, 'patches',
+            base_dir = git.get_base_dir()
+            self.__patch_dir = os.path.join(base_dir, 'patches',
                                             self.__name)
-            self.__base_file = os.path.join(git.base_dir, 'refs', 'bases',
+            self.__base_file = os.path.join(base_dir, 'refs', 'bases',
                                             self.__name)
             self.__applied_file = os.path.join(self.__patch_dir, 'applied')
             self.__unapplied_file = os.path.join(self.__patch_dir, 'unapplied')
@@ -386,7 +387,7 @@ class Series:
     def init(self):
         """Initialises the stgit series
         """
-        bases_dir = os.path.join(git.base_dir, 'refs', 'bases')
+        bases_dir = os.path.join(git.get_base_dir(), 'refs', 'bases')
 
         if self.is_initialised():
             raise StackException, self.__patch_dir + ' already exists'
