From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 06/11] Avoid allowing --undo if it doesn't change anything
Date: Fri, 16 Sep 2005 21:35:19 +0200
Message-ID: <20050916193518.18681.9261.stgit@zion.home.lan>
References: <20050916193511.18681.24189.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:39:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGM26-0005fW-Aq
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVIPTiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVIPTh7
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:37:59 -0400
Received: from ppp-62-11-79-165.dialup.tiscali.it ([62.11.79.165]:23179 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750705AbVIPTh7
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 15:37:59 -0400
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 14BDE2856B;
	Fri, 16 Sep 2005 21:35:19 +0200 (CEST)
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20050916193511.18681.24189.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8714>

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Avoid top/bottom backup files identical to current ones. Simply remove
them.

Also, change restore_old_boundaries() to handle gracefully the new
situation rather than print an exception.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 stgit/commands/push.py |    6 ++++--
 stgit/stack.py         |   17 +++++++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/stgit/commands/push.py b/stgit/commands/push.py
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -66,8 +66,10 @@ def func(parser, options, args):
         print 'Undoing the "%s" push...' % patch,
         sys.stdout.flush()
         resolved_all()
-        crt_series.undo_push()
-        print 'done'
+        if crt_series.undo_push():
+            print 'done'
+        else:
+            print 'done (patch unchanged)'
         print_crt_patch()
 
         return
diff --git a/stgit/stack.py b/stgit/stack.py
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -170,7 +170,11 @@ class Patch:
 
     def set_bottom(self, string, backup = False):
         if backup:
-            self.__set_field('bottom.old', self.__get_field('bottom'))
+            curr = self.__get_field('bottom')
+            if curr != string:
+                self.__set_field('bottom.old', curr)
+            else:
+                self.__set_field('bottom.old', None)
         self.__set_field('bottom', string)
 
     def get_top(self):
@@ -178,7 +182,11 @@ class Patch:
 
     def set_top(self, string, backup = False):
         if backup:
-            self.__set_field('top.old', self.__get_field('top'))
+            curr = self.__get_field('top')
+            if curr != string:
+                self.__set_field('top.old', curr)
+            else:
+                self.__set_field('top.old', None)
         self.__set_field('top', string)
 
     def restore_old_boundaries(self):
@@ -188,8 +196,9 @@ class Patch:
         if top and bottom:
             self.__set_field('bottom', bottom)
             self.__set_field('top', top)
+            return True
         else:
-            raise StackException, 'No patch undo information'
+            return False
 
     def get_description(self):
         return self.__get_field('description', True)
@@ -571,7 +580,7 @@ class Series:
         patch = Patch(name, self.__patch_dir)
         git.reset()
         self.pop_patch(name)
-        patch.restore_old_boundaries()
+        return patch.restore_old_boundaries()
 
     def pop_patch(self, name):
         """Pops the top patch from the stack
