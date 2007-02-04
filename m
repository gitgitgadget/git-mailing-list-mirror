From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Use branch.*.stgit.parentbranch for authoritative parent
	information.
Date: Sun, 04 Feb 2007 10:48:21 +0100
Message-ID: <20070204094723.18334.72391.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 04 10:49:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDdzu-0004jA-Q4
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 10:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbXBDJtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 04:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbXBDJtV
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 04:49:21 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:47939 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218AbXBDJtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 04:49:20 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 50DFB43658;
	Sun,  4 Feb 2007 10:49:18 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 100CB1F07F;
	Sun,  4 Feb 2007 10:48:22 +0100 (CET)
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38675>


Also set the API to use remote=None as "parent branch is local", and
have set_parent() translate that to branch.*.remote=".".

Also enforces that we never set a parent-branch info without a
parent-remote (so they are now both set or both untouched), and try to
give useful info when we have to use the old "origin" defaults.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

This is an updated version of yesterday's patch rebased to current
HEAD, and with normalized string quoting.

 stgit/commands/branch.py |    3 ++-
 stgit/git.py             |    5 +----
 stgit/stack.py           |   30 ++++++++++++++++++++----------
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index f074d47..3026d9c 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -151,8 +151,9 @@ def func(parser, options, args):
             if parentremote:
                 print 'Using "%s" remote to pull parent from.' % parentremote
             else:
-                print 'Not identified a remote to pull parent from.'
+                print 'Recording as a local branch.'
         else:
+            # no known parent branch, can't guess the remote
             parentremote = None
 
         stack.Series(args[0]).init(create_at = tree_id,
diff --git a/stgit/git.py b/stgit/git.py
index 3d84e97..73d07fd 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -950,8 +950,5 @@ def identify_remote(branchname):
         if branchname in remotes_local_branches(remote):
             return remote
 
-    # FIXME: in the case of local branch we should maybe set remote to
-    # "." but are we even sure it is the only case left ?
-
-    # if we get here we've found nothing
+    # if we get here we've found nothing, the branch is a local one
     return None
diff --git a/stgit/stack.py b/stgit/stack.py
index 3960729..e091d4e 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -418,8 +418,10 @@ class Series(StgitObject):
         if value:
             return value
         elif 'origin' in git.remotes_list():
-            # FIXME: this is for compatibility only.  Should be
-            # dropped when all relevant commands record this info.
+            print 'Notice: no parent remote declared for stack "%s", ' \
+                  'defaulting to "origin". Consider setting "branch.%s.remote" ' \
+                  'and "branch.%s.merge" with "git repo-config".' \
+                  % (self.__name, self.__name, self.__name)
             return 'origin'
         else:
             raise StackException, 'Cannot find a parent remote for "%s"' % self.__name
@@ -428,26 +430,34 @@ class Series(StgitObject):
         value = config.set('branch.%s.remote' % self.__name, remote)
 
     def get_parent_branch(self):
-        value = config.get('branch.%s.merge' % self.__name)
+        value = config.get('branch.%s.stgit.parentbranch' % self.__name)
         if value:
             return value
         elif git.rev_parse('heads/origin'):
-            # FIXME: this is for compatibility only.  Should be
-            # dropped when all relevant commands record this info.
+            print 'Notice: no parent branch declared for stack "%s", ' \
+                  'defaulting to "heads/origin".  Consider setting ' \
+                  '"branch.%s.stgit.parentbranch" with "git repo-config".' \
+                  % (self.__name, self.__name)
             return 'heads/origin'
         else:
             raise StackException, 'Cannot find a parent branch for "%s"' % self.__name
 
     def __set_parent_branch(self, name):
-        config.set('branch.%s.merge' % self.__name, name)
+        if config.get('branch.%s.remote' % self.__name):
+            # Never set merge if remote is not set to avoid
+            # possibly-erroneous lookups into 'origin'
+            config.set('branch.%s.merge' % self.__name, name)
+        config.set('branch.%s.stgit.parentbranch' % self.__name, name)
 
     def set_parent(self, remote, localbranch):
+        # policy: record local branches as remote='.'
+        recordremote = remote or '.'
         if localbranch:
+            self.__set_parent_remote(recordremote)
             self.__set_parent_branch(localbranch)
-            if remote:
-                self.__set_parent_remote(remote)
-        elif remote:
-            raise StackException, 'Remote "%s" without a branch cannot be used as parent' % remote
+        # We'll enforce this later
+#         else:
+#             raise StackException, 'Parent branch (%s) should be specified for %s' % localbranch, self.__name
 
     def __patch_is_current(self, patch):
         return patch.get_name() == self.get_current()
