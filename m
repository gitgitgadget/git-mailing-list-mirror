X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/3] Create a StgitObject class to factorise code for property handling.
Date: Thu, 30 Nov 2006 01:27:28 +0100
Message-ID: <20061130002728.21981.59782.stgit@gandelf.nowhere.earth>
References: <20061130002304.21981.67797.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Thu, 30 Nov 2006 00:29:34 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061130002304.21981.67797.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32687>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpZme-0002Qz-GD for gcvg-git@gmane.org; Thu, 30 Nov
 2006 01:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967728AbWK3A2I (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 19:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967729AbWK3A2H
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 19:28:07 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:58544 "EHLO
 smtp6-g19.free.fr") by vger.kernel.org with ESMTP id S967728AbWK3A2G (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 19:28:06 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp6-g19.free.fr (Postfix) with ESMTP id 4DD84430B3;
 Thu, 30 Nov 2006 01:28:04 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch) by
 bylbo.nowhere.earth with esmtp (Exim 4.62) (envelope-from
 <ydirson@altern.org>) id 1GpZn8-0006B3-C9; Thu, 30 Nov 2006 01:28:42 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org


This change makes it easier to add new stored fields to the Series object,
without having to duplicate existing code from Patch.

Generic field accessors were taken from the Patch class.  Dir accessors
were added to avoid making the __dir attribute public, and were used
to replace Series::__series_dir (that name was a bit redundant anyway).
Create_empty_field came as a natural addition to factorise more code.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/stack.py |  198 +++++++++++++++++++++++++++++---------------------------
 1 files changed, 103 insertions(+), 95 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 8fa3846..8cd632e 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -119,27 +119,58 @@ def edit_file(series, line, comment, show_patch = True):
 # Classes
 #
 
-class Patch:
+class StgitObject:
+    """An object with stgit-like properties stored as files in a directory
+    """
+    def _set_dir(self, dir):
+        self.__dir = dir
+    def dir(self):
+        return self.__dir
+
+    def create_empty_field(self, name):
+        print "Creating '%s'" % os.path.join(self.__dir, name)
+        create_empty_file(os.path.join(self.__dir, name))
+
+    def _get_field(self, name, multiline = False):
+        id_file = os.path.join(self.__dir, name)
+        if os.path.isfile(id_file):
+            line = read_string(id_file, multiline)
+            if line == '':
+                return None
+            else:
+                return line
+        else:
+            return None
+
+    def _set_field(self, name, value, multiline = False):
+        fname = os.path.join(self.__dir, name)
+        if value and value != '':
+            write_string(fname, value, multiline)
+        elif os.path.isfile(fname):
+            os.remove(fname)
+
+    
+class Patch(StgitObject):
     """Basic patch implementation
     """
     def __init__(self, name, series_dir, refs_dir):
         self.__series_dir = series_dir
         self.__name = name
-        self.__dir = os.path.join(self.__series_dir, self.__name)
+        self._set_dir(os.path.join(self.__series_dir, self.__name))
         self.__refs_dir = refs_dir
         self.__top_ref_file = os.path.join(self.__refs_dir, self.__name)
         self.__log_ref_file = os.path.join(self.__refs_dir,
                                            self.__name + '.log')
 
     def create(self):
-        os.mkdir(self.__dir)
-        create_empty_file(os.path.join(self.__dir, 'bottom'))
-        create_empty_file(os.path.join(self.__dir, 'top'))
+        os.mkdir(self.dir())
+        self.create_empty_field('bottom')
+        self.create_empty_field('top')
 
     def delete(self):
-        for f in os.listdir(self.__dir):
-            os.remove(os.path.join(self.__dir, f))
-        os.rmdir(self.__dir)
+        for f in os.listdir(self.dir()):
+            os.remove(os.path.join(self.dir(), f))
+        os.rmdir(self.dir())
         os.remove(self.__top_ref_file)
         if os.path.exists(self.__log_ref_file):
             os.remove(self.__log_ref_file)
@@ -148,16 +179,16 @@ class Patch:
         return self.__name
 
     def rename(self, newname):
-        olddir = self.__dir
+        olddir = self.dir()
         old_top_ref_file = self.__top_ref_file
         old_log_ref_file = self.__log_ref_file
         self.__name = newname
-        self.__dir = os.path.join(self.__series_dir, self.__name)
+        self._set_dir(os.path.join(self.__series_dir, self.__name))
         self.__top_ref_file = os.path.join(self.__refs_dir, self.__name)
         self.__log_ref_file = os.path.join(self.__refs_dir,
                                            self.__name + '.log')
 
-        os.rename(olddir, self.__dir)
+        os.rename(olddir, self.dir())
         os.rename(old_top_ref_file, self.__top_ref_file)
         if os.path.exists(old_log_ref_file):
             os.rename(old_log_ref_file, self.__log_ref_file)
@@ -173,69 +204,51 @@ class Patch:
         if top:
             self.__update_top_ref(top)
 
-    def __get_field(self, name, multiline = False):
-        id_file = os.path.join(self.__dir, name)
-        if os.path.isfile(id_file):
-            line = read_string(id_file, multiline)
-            if line == '':
-                return None
-            else:
-                return line
-        else:
-            return None
-
-    def __set_field(self, name, value, multiline = False):
-        fname = os.path.join(self.__dir, name)
-        if value and value != '':
-            write_string(fname, value, multiline)
-        elif os.path.isfile(fname):
-            os.remove(fname)
-
     def get_old_bottom(self):
-        return self.__get_field('bottom.old')
+        return self._get_field('bottom.old')
 
     def get_bottom(self):
-        return self.__get_field('bottom')
+        return self._get_field('bottom')
 
     def set_bottom(self, value, backup = False):
         if backup:
-            curr = self.__get_field('bottom')
-            self.__set_field('bottom.old', curr)
-        self.__set_field('bottom', value)
+            curr = self._get_field('bottom')
+            self._set_field('bottom.old', curr)
+        self._set_field('bottom', value)
 
     def get_old_top(self):
-        return self.__get_field('top.old')
+        return self._get_field('top.old')
 
     def get_top(self):
-        return self.__get_field('top')
+        return self._get_field('top')
 
     def set_top(self, value, backup = False):
         if backup:
-            curr = self.__get_field('top')
-            self.__set_field('top.old', curr)
-        self.__set_field('top', value)
+            curr = self._get_field('top')
+            self._set_field('top.old', curr)
+        self._set_field('top', value)
         self.__update_top_ref(value)
 
     def restore_old_boundaries(self):
-        bottom = self.__get_field('bottom.old')
-        top = self.__get_field('top.old')
+        bottom = self._get_field('bottom.old')
+        top = self._get_field('top.old')
 
         if top and bottom:
-            self.__set_field('bottom', bottom)
-            self.__set_field('top', top)
+            self._set_field('bottom', bottom)
+            self._set_field('top', top)
             self.__update_top_ref(top)
             return True
         else:
             return False
 
     def get_description(self):
-        return self.__get_field('description', True)
+        return self._get_field('description', True)
 
     def set_description(self, line):
-        self.__set_field('description', line, True)
+        self._set_field('description', line, True)
 
     def get_authname(self):
-        return self.__get_field('authname')
+        return self._get_field('authname')
 
     def set_authname(self, name):
         if not name:
@@ -243,10 +256,10 @@ class Patch:
                 name = config.get('stgit', 'authname')
             elif 'GIT_AUTHOR_NAME' in os.environ:
                 name = os.environ['GIT_AUTHOR_NAME']
-        self.__set_field('authname', name)
+        self._set_field('authname', name)
 
     def get_authemail(self):
-        return self.__get_field('authemail')
+        return self._get_field('authemail')
 
     def set_authemail(self, address):
         if not address:
@@ -254,18 +267,18 @@ class Patch:
                 address = config.get('stgit', 'authemail')
             elif 'GIT_AUTHOR_EMAIL' in os.environ:
                 address = os.environ['GIT_AUTHOR_EMAIL']
-        self.__set_field('authemail', address)
+        self._set_field('authemail', address)
 
     def get_authdate(self):
-        return self.__get_field('authdate')
+        return self._get_field('authdate')
 
     def set_authdate(self, date):
         if not date and 'GIT_AUTHOR_DATE' in os.environ:
             date = os.environ['GIT_AUTHOR_DATE']
-        self.__set_field('authdate', date)
+        self._set_field('authdate', date)
 
     def get_commname(self):
-        return self.__get_field('commname')
+        return self._get_field('commname')
 
     def set_commname(self, name):
         if not name:
@@ -273,10 +286,10 @@ class Patch:
                 name = config.get('stgit', 'commname')
             elif 'GIT_COMMITTER_NAME' in os.environ:
                 name = os.environ['GIT_COMMITTER_NAME']
-        self.__set_field('commname', name)
+        self._set_field('commname', name)
 
     def get_commemail(self):
-        return self.__get_field('commemail')
+        return self._get_field('commemail')
 
     def set_commemail(self, address):
         if not address:
@@ -284,17 +297,17 @@ class Patch:
                 address = config.get('stgit', 'commemail')
             elif 'GIT_COMMITTER_EMAIL' in os.environ:
                 address = os.environ['GIT_COMMITTER_EMAIL']
-        self.__set_field('commemail', address)
+        self._set_field('commemail', address)
 
     def get_log(self):
-        return self.__get_field('log')
+        return self._get_field('log')
 
     def set_log(self, value, backup = False):
-        self.__set_field('log', value)
+        self._set_field('log', value)
         self.__update_log_ref(value)
 
 
-class Series:
+class Series(StgitObject):
     """Class including the operations on series
     """
     def __init__(self, name = None):
@@ -309,22 +322,21 @@ class Series:
         except git.GitException, ex:
             raise StackException, 'GIT tree not initialised: %s' % ex
 
-        self.__series_dir = os.path.join(self.__base_dir, 'patches',
-                                         self.__name)
+        self._set_dir(os.path.join(self.__base_dir, 'patches', self.__name))
         self.__refs_dir = os.path.join(self.__base_dir, 'refs', 'patches',
                                        self.__name)
         self.__base_file = os.path.join(self.__base_dir, 'refs', 'bases',
                                         self.__name)
 
-        self.__applied_file = os.path.join(self.__series_dir, 'applied')
-        self.__unapplied_file = os.path.join(self.__series_dir, 'unapplied')
-        self.__current_file = os.path.join(self.__series_dir, 'current')
-        self.__descr_file = os.path.join(self.__series_dir, 'description')
+        self.__applied_file = os.path.join(self.dir(), 'applied')
+        self.__unapplied_file = os.path.join(self.dir(), 'unapplied')
+        self.__current_file = os.path.join(self.dir(), 'current')
+        self.__descr_file = os.path.join(self.dir(), 'description')
 
         # where this series keeps its patches
-        self.__patch_dir = os.path.join(self.__series_dir, 'patches')
+        self.__patch_dir = os.path.join(self.dir(), 'patches')
         if not os.path.isdir(self.__patch_dir):
-            self.__patch_dir = self.__series_dir
+            self.__patch_dir = self.dir()
 
         # if no __refs_dir, create and populate it (upgrade old repositories)
         if self.is_initialised() and not os.path.isdir(self.__refs_dir):
@@ -333,7 +345,7 @@ class Series:
                 self.get_patch(patch).update_top_ref()
 
         # trash directory
-        self.__trash_dir = os.path.join(self.__series_dir, 'trash')
+        self.__trash_dir = os.path.join(self.dir(), 'trash')
         if self.is_initialised() and not os.path.isdir(self.__trash_dir):
             os.makedirs(self.__trash_dir)
 
@@ -345,10 +357,7 @@ class Series:
     def __set_current(self, name):
         """Sets the topmost patch
         """
-        if name:
-            write_string(self.__current_file, name)
-        else:
-            create_empty_file(self.__current_file)
+        self._set_field('current', name)
 
     def get_patch(self, name):
         """Return a Patch object for the given name
@@ -366,10 +375,7 @@ class Series:
     def get_current(self):
         """Return the name of the topmost patch, or None if there is
         no such patch."""
-        if os.path.isfile(self.__current_file):
-            name = read_string(self.__current_file)
-        else:
-            return None
+        name = self._get_field('current')
         if name == '':
             return None
         else:
@@ -396,26 +402,26 @@ class Series:
         return self.__base_file
 
     def get_protected(self):
-        return os.path.isfile(os.path.join(self.__series_dir, 'protected'))
+        return os.path.isfile(os.path.join(self.dir(), 'protected'))
 
     def protect(self):
-        protect_file = os.path.join(self.__series_dir, 'protected')
+        protect_file = os.path.join(self.dir(), 'protected')
         if not os.path.isfile(protect_file):
             create_empty_file(protect_file)
 
     def unprotect(self):
-        protect_file = os.path.join(self.__series_dir, 'protected')
+        protect_file = os.path.join(self.dir(), 'protected')
         if os.path.isfile(protect_file):
             os.remove(protect_file)
 
     def get_description(self):
-        if os.path.isfile(self.__descr_file):
-            return read_string(self.__descr_file)
-        else:
-            return ''
+        return self._get_field('description')
+
+    def set_description(self, line):
+        self._set_field('description', line)
 
     def __patch_is_current(self, patch):
-        return patch.get_name() == read_string(self.__current_file)
+        return patch.get_name() == self.get_current()
 
     def patch_applied(self, name):
         """Return true if the patch exists in the applied list
@@ -481,10 +487,10 @@ class Series:
 
         create_dirs(bases_dir)
 
-        create_empty_file(self.__applied_file)
-        create_empty_file(self.__unapplied_file)
-        create_empty_file(self.__descr_file)
-        os.makedirs(os.path.join(self.__series_dir, 'patches'))
+        self.create_empty_field('applied')
+        self.create_empty_field('unapplied')
+        self.create_empty_field('description')
+        os.makedirs(os.path.join(self.dir(), 'patches'))
         os.makedirs(self.__refs_dir)
         self.__begin_stack_check()
 
@@ -493,15 +499,15 @@ class Series:
         unconvert to place the patches in the same directory with
         series control files
         """
-        if self.__patch_dir == self.__series_dir:
+        if self.__patch_dir == self.dir():
             print 'Converting old-style to new-style...',
             sys.stdout.flush()
 
-            self.__patch_dir = os.path.join(self.__series_dir, 'patches')
+            self.__patch_dir = os.path.join(self.dir(), 'patches')
             os.makedirs(self.__patch_dir)
 
             for p in self.get_applied() + self.get_unapplied():
-                src = os.path.join(self.__series_dir, p)
+                src = os.path.join(self.dir(), p)
                 dest = os.path.join(self.__patch_dir, p)
                 os.rename(src, dest)
 
@@ -513,7 +519,7 @@ class Series:
 
             for p in self.get_applied() + self.get_unapplied():
                 src = os.path.join(self.__patch_dir, p)
-                dest = os.path.join(self.__series_dir, p)
+                dest = os.path.join(self.dir(), p)
                 os.rename(src, dest)
 
             if not os.listdir(self.__patch_dir):
@@ -522,7 +528,7 @@ class Series:
             else:
                 print 'Patch directory %s is not empty.' % self.__name
 
-            self.__patch_dir = self.__series_dir
+            self.__patch_dir = self.dir()
 
     def rename(self, to_name):
         """Renames a series
@@ -536,7 +542,7 @@ class Series:
 
         git.rename_branch(self.__name, to_name)
 
-        if os.path.isdir(self.__series_dir):
+        if os.path.isdir(self.dir()):
             rename(os.path.join(self.__base_dir, 'patches'),
                    self.__name, to_stack.__name)
         if os.path.exists(self.__base_file):
@@ -556,7 +562,7 @@ class Series:
         new_series = Series(target_series)
 
         # generate an artificial description file
-        write_string(new_series.__descr_file, 'clone of "%s"' % self.__name)
+        new_series.set_description('clone of "%s"' % self.__name)
 
         # clone self's entire series as unapplied patches
         patches = self.get_applied() + self.get_unapplied()
@@ -590,6 +596,8 @@ class Series:
                 os.remove(fname)
             os.rmdir(self.__trash_dir)
 
+            # FIXME: find a way to get rid of those manual removals
+            # (move functionnality to StgitObject ?)
             if os.path.exists(self.__applied_file):
                 os.remove(self.__applied_file)
             if os.path.exists(self.__unapplied_file):
@@ -602,7 +610,7 @@ class Series:
                 os.rmdir(self.__patch_dir)
             else:
                 print 'Patch directory %s is not empty.' % self.__name
-            if not os.listdir(self.__series_dir):
+            if not os.listdir(self.dir()):
                 remove_dirs(os.path.join(self.__base_dir, 'patches'),
                             self.__name)
