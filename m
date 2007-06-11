From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 1/4] Use get/set_name for a stack's name.
Date: Mon, 11 Jun 2007 02:33:25 +0200
Message-ID: <20070611003325.4736.58433.stgit@gandelf.nowhere.earth>
References: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 02:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxXqa-0004M4-FF
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 02:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762956AbXFKAdW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 20:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761092AbXFKAdW
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 20:33:22 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:46277 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760668AbXFKAdV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 20:33:21 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2E7878175;
	Mon, 11 Jun 2007 02:33:20 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id CE7D91F08A;
	Mon, 11 Jun 2007 02:33:25 +0200 (CEST)
In-Reply-To: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49801>

It is much more clear to use get_name() than get_branch(), and this is
a step towards factoring stuff into a PatchSet class.
---

 stgit/commands/branch.py |   12 +++---
 stgit/commands/export.py |    2 +
 stgit/commands/pull.py   |    2 +
 stgit/commands/series.py |    2 +
 stgit/commands/sync.py   |    2 +
 stgit/stack.py           |   88 +++++++++++++++++++++++-----------------------
 6 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 07bdca8..c22e143 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -68,7 +68,7 @@ options = [make_option('-c', '--create',
 
 
 def __is_current_branch(branch_name):
-    return crt_series.get_branch() == branch_name
+    return crt_series.get_name() == branch_name
 
 def __print_branch(branch_name, length):
     initialized = ' '
@@ -168,7 +168,7 @@ def func(parser, options, args):
     elif options.clone:
 
         if len(args) == 0:
-            clone = crt_series.get_branch() + \
+            clone = crt_series.get_name() + \
                     time.strftime('-%C%y%m%d-%H%M%S')
         elif len(args) == 1:
             clone = args[0]
@@ -215,7 +215,7 @@ def func(parser, options, args):
     elif options.protect:
 
         if len(args) == 0:
-            branch_name = crt_series.get_branch()
+            branch_name = crt_series.get_name()
         elif len(args) == 1:
             branch_name = args[0]
         else:
@@ -249,7 +249,7 @@ def func(parser, options, args):
     elif options.unprotect:
 
         if len(args) == 0:
-            branch_name = crt_series.get_branch()
+            branch_name = crt_series.get_name()
         elif len(args) == 1:
             branch_name = args[0]
         else:
@@ -269,7 +269,7 @@ def func(parser, options, args):
     elif options.description is not None:
 
         if len(args) == 0:
-            branch_name = crt_series.get_branch()
+            branch_name = crt_series.get_name()
         elif len(args) == 1:
             branch_name = args[0]
         else:
@@ -303,4 +303,4 @@ def func(parser, options, args):
     if len(args) != 0:
         parser.error('incorrect number of arguments')
 
-    print crt_series.get_branch()
+    print crt_series.get_name()
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 35851bc..8424f9d 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -75,7 +75,7 @@ def func(parser, options, args):
     if options.dir:
         dirname = options.dir
     else:
-        dirname = 'patches-%s' % crt_series.get_branch()
+        dirname = 'patches-%s' % crt_series.get_name()
 
     if not options.branch and git.local_changes():
         out.warn('Local changes in the tree;'
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index beaa7b5..5f72f9b 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -50,7 +50,7 @@ options = [make_option('-n', '--nopush',
 def func(parser, options, args):
     """Pull the changes from a remote repository
     """
-    policy = config.get('branch.%s.stgit.pull-policy' % crt_series.get_branch()) or \
+    policy = config.get('branch.%s.stgit.pull-policy' % crt_series.get_name()) or \
              config.get('stgit.pull-policy')
 
     if policy == 'rebase':
diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index fe4e468..0b3efe0 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -181,7 +181,7 @@ def func(parser, options, args):
         return
 
     if options.showbranch:
-        branch_str = '@' + crt_series.get_branch()
+        branch_str = '@' + crt_series.get_name()
     else:
         branch_str = ''
 
diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index 8359061..e769602 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -85,7 +85,7 @@ def func(parser, options, args):
         # branch
         remote_series = crt_series
         stgit.commands.common.crt_series = crt_series = stack.Series()
-        if options.branch == crt_series.get_branch():
+        if options.branch == crt_series.get_name():
             raise CmdException, 'Cannot synchronise with the current branch'
         remote_patches = remote_series.get_applied()
 
diff --git a/stgit/stack.py b/stgit/stack.py
index a64aff6..0d475da 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -356,21 +356,21 @@ class Series(StgitObject):
         """
         try:
             if name:
-                self.__name = name
+                self.set_name (name)
             else:
-                self.__name = git.get_head_file()
+                self.set_name (git.get_head_file())
             self.__base_dir = basedir.get()
         except git.GitException, ex:
             raise StackException, 'GIT tree not initialised: %s' % ex
 
-        self._set_dir(os.path.join(self.__base_dir, 'patches', self.__name))
+        self._set_dir(os.path.join(self.__base_dir, 'patches', self.get_name()))
 
         # Update the branch to the latest format version if it is
         # initialized, but don't touch it if it isn't.
-        update_to_current_format_version(self.__name, self.__base_dir)
+        update_to_current_format_version(self.get_name(), self.__base_dir)
 
         self.__refs_dir = os.path.join(self.__base_dir, 'refs', 'patches',
-                                       self.__name)
+                                       self.get_name())
 
         self.__applied_file = os.path.join(self._dir(), 'applied')
         self.__unapplied_file = os.path.join(self._dir(), 'unapplied')
@@ -388,11 +388,11 @@ class Series(StgitObject):
         if not name or re.search('[^\w.-]', name):
             raise StackException, 'Invalid patch name: "%s"' % name
 
-    def get_branch(self):
-        """Return the branch name for the Series object
-        """
+    def get_name(self):
         return self.__name
-
+    def set_name(self, name):
+        self.__name = name
+        
     def get_patch(self, name):
         """Return a Patch object for the given name
         """
@@ -422,12 +422,12 @@ class Series(StgitObject):
 
     def get_applied(self):
         if not os.path.isfile(self.__applied_file):
-            raise StackException, 'Branch "%s" not initialised' % self.__name
+            raise StackException, 'Branch "%s" not initialised' % self.get_name()
         return read_strings(self.__applied_file)
 
     def get_unapplied(self):
         if not os.path.isfile(self.__unapplied_file):
-            raise StackException, 'Branch "%s" not initialised' % self.__name
+            raise StackException, 'Branch "%s" not initialised' % self.get_name()
         return read_strings(self.__unapplied_file)
 
     def get_hidden(self):
@@ -467,7 +467,7 @@ class Series(StgitObject):
             os.remove(protect_file)
 
     def __branch_descr(self):
-        return 'branch.%s.description' % self.get_branch()
+        return 'branch.%s.description' % self.get_name()
 
     def get_description(self):
         return config.get(self.__branch_descr()) or ''
@@ -479,41 +479,41 @@ class Series(StgitObject):
             config.unset(self.__branch_descr())
 
     def get_parent_remote(self):
-        value = config.get('branch.%s.remote' % self.__name)
+        value = config.get('branch.%s.remote' % self.get_name())
         if value:
             return value
         elif 'origin' in git.remotes_list():
             out.note(('No parent remote declared for stack "%s",'
-                      ' defaulting to "origin".' % self.__name),
+                      ' defaulting to "origin".' % self.get_name()),
                      ('Consider setting "branch.%s.remote" and'
                       ' "branch.%s.merge" with "git repo-config".'
-                      % (self.__name, self.__name)))
+                      % (self.get_name(), self.get_name())))
             return 'origin'
         else:
-            raise StackException, 'Cannot find a parent remote for "%s"' % self.__name
+            raise StackException, 'Cannot find a parent remote for "%s"' % self.get_name()
 
     def __set_parent_remote(self, remote):
-        value = config.set('branch.%s.remote' % self.__name, remote)
+        value = config.set('branch.%s.remote' % self.get_name(), remote)
 
     def get_parent_branch(self):
-        value = config.get('branch.%s.stgit.parentbranch' % self.__name)
+        value = config.get('branch.%s.stgit.parentbranch' % self.get_name())
         if value:
             return value
         elif git.rev_parse('heads/origin'):
             out.note(('No parent branch declared for stack "%s",'
-                      ' defaulting to "heads/origin".' % self.__name),
+                      ' defaulting to "heads/origin".' % self.get_name()),
                      ('Consider setting "branch.%s.stgit.parentbranch"'
-                      ' with "git repo-config".' % self.__name))
+                      ' with "git repo-config".' % self.get_name()))
             return 'heads/origin'
         else:
-            raise StackException, 'Cannot find a parent branch for "%s"' % self.__name
+            raise StackException, 'Cannot find a parent branch for "%s"' % self.get_name()
 
     def __set_parent_branch(self, name):
-        if config.get('branch.%s.remote' % self.__name):
+        if config.get('branch.%s.remote' % self.get_name()):
             # Never set merge if remote is not set to avoid
             # possibly-erroneous lookups into 'origin'
-            config.set('branch.%s.merge' % self.__name, name)
-        config.set('branch.%s.stgit.parentbranch' % self.__name, name)
+            config.set('branch.%s.merge' % self.get_name(), name)
+        config.set('branch.%s.stgit.parentbranch' % self.get_name(), name)
 
     def set_parent(self, remote, localbranch):
         if localbranch:
@@ -521,7 +521,7 @@ class Series(StgitObject):
             self.__set_parent_branch(localbranch)
         # We'll enforce this later
 #         else:
-#             raise StackException, 'Parent branch (%s) should be specified for %s' % localbranch, self.__name
+#             raise StackException, 'Parent branch (%s) should be specified for %s' % localbranch, self.get_name()
 
     def __patch_is_current(self, patch):
         return patch.get_name() == self.get_current()
@@ -559,19 +559,19 @@ class Series(StgitObject):
     def is_initialised(self):
         """Checks if series is already initialised
         """
-        return bool(config.get(format_version_key(self.get_branch())))
+        return bool(config.get(format_version_key(self.get_name())))
 
     def init(self, create_at=False, parent_remote=None, parent_branch=None):
         """Initialises the stgit series
         """
         if self.is_initialised():
-            raise StackException, '%s already initialized' % self.get_branch()
+            raise StackException, '%s already initialized' % self.get_name()
         for d in [self._dir(), self.__refs_dir]:
             if os.path.exists(d):
                 raise StackException, '%s already exists' % d
 
         if (create_at!=False):
-            git.create_branch(self.__name, create_at)
+            git.create_branch(self.get_name(), create_at)
 
         os.makedirs(self.__patch_dir)
 
@@ -582,7 +582,7 @@ class Series(StgitObject):
         os.makedirs(self.__refs_dir)
         self._set_field('orig-base', git.get_head())
 
-        config.set(format_version_key(self.get_branch()), str(FORMAT_VERSION))
+        config.set(format_version_key(self.get_name()), str(FORMAT_VERSION))
 
     def rename(self, to_name):
         """Renames a series
@@ -590,19 +590,19 @@ class Series(StgitObject):
         to_stack = Series(to_name)
 
         if to_stack.is_initialised():
-            raise StackException, '"%s" already exists' % to_stack.get_branch()
+            raise StackException, '"%s" already exists' % to_stack.get_name()
 
-        git.rename_branch(self.__name, to_name)
+        git.rename_branch(self.get_name(), to_name)
 
         if os.path.isdir(self._dir()):
             rename(os.path.join(self.__base_dir, 'patches'),
-                   self.__name, to_stack.__name)
+                   self.get_name(), to_stack.get_name())
         if os.path.exists(self.__refs_dir):
             rename(os.path.join(self.__base_dir, 'refs', 'patches'),
-                   self.__name, to_stack.__name)
+                   self.get_name(), to_stack.get_name())
 
         # Rename the config section
-        config.rename_section("branch.%s" % self.__name,
+        config.rename_section("branch.%s" % self.get_name(),
                               "branch.%s" % to_name)
 
         self.__init__(to_name)
@@ -619,7 +619,7 @@ class Series(StgitObject):
         new_series = Series(target_series)
 
         # generate an artificial description file
-        new_series.set_description('clone of "%s"' % self.__name)
+        new_series.set_description('clone of "%s"' % self.get_name())
 
         # clone self's entire series as unapplied patches
         try:
@@ -649,15 +649,15 @@ class Series(StgitObject):
         new_series.forward_patches(applied)
 
         # Clone parent informations
-        value = config.get('branch.%s.remote' % self.__name)
+        value = config.get('branch.%s.remote' % self.get_name())
         if value:
             config.set('branch.%s.remote' % target_series, value)
 
-        value = config.get('branch.%s.merge' % self.__name)
+        value = config.get('branch.%s.merge' % self.get_name())
         if value:
             config.set('branch.%s.merge' % target_series, value)
 
-        value = config.get('branch.%s.stgit.parentbranch' % self.__name)
+        value = config.get('branch.%s.stgit.parentbranch' % self.get_name())
         if value:
             config.set('branch.%s.stgit.parentbranch' % target_series, value)
 
@@ -708,10 +708,10 @@ class Series(StgitObject):
         # Cleanup parent informations
         # FIXME: should one day make use of git-config --section-remove,
         # scheduled for 1.5.1
-        config.unset('branch.%s.remote' % self.__name)
-        config.unset('branch.%s.merge' % self.__name)
-        config.unset('branch.%s.stgit.parentbranch' % self.__name)
-        config.unset('branch.%s.stgitformatversion' % self.__name)
+        config.unset('branch.%s.remote' % self.get_name())
+        config.unset('branch.%s.merge' % self.get_name())
+        config.unset('branch.%s.stgit.parentbranch' % self.get_name())
+        config.unset('branch.%s.stgitformatversion' % self.get_name())
 
     def refresh_patch(self, files = None, message = None, edit = False,
                       show_patch = False,
@@ -1093,13 +1093,13 @@ class Series(StgitObject):
 
         patch = Patch(name, self.__patch_dir, self.__refs_dir)
 
-        if git.get_head_file() == self.get_branch():
+        if git.get_head_file() == self.get_name():
             if keep and not git.apply_diff(git.get_head(), patch.get_bottom()):
                 raise StackException(
                     'Failed to pop patches while preserving the local changes')
             git.switch(patch.get_bottom(), keep)
         else:
-            git.set_branch(self.get_branch(), patch.get_bottom())
+            git.set_branch(self.get_name(), patch.get_bottom())
 
         # save the new applied list
         idx = applied.index(name) + 1
