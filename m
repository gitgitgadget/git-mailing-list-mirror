From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/6] Move identification of parent branch's remote def up into
	stack class.
Date: Sat, 27 Jan 2007 18:22:38 +0100
Message-ID: <20070127172238.27183.36508.stgit@gandelf.nowhere.earth>
References: <20070127172129.27183.50432.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 18:24:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HArHS-00032T-R9
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 18:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbXA0RXx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 12:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbXA0RXx
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 12:23:53 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:58385 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbXA0RXw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 12:23:52 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id E587127B7C;
	Sat, 27 Jan 2007 18:23:51 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 8BFE91F08A;
	Sat, 27 Jan 2007 18:22:38 +0100 (CET)
In-Reply-To: <20070127172129.27183.50432.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37969>


Also adds the __set_parent_remote() counterpart method, but only
private since it is expected to be called only through set_parent, to
be introduced in subsequent patch.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/pull.py |    4 +---
 stgit/stack.py         |   10 ++++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 15ed636..0608fb6 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -53,9 +53,7 @@ def func(parser, options, args):
     if len(args) >= 1:
         repository = args[0]
     else:
-        repository = config.get('branch.%s.remote' % git.get_head_file())
-        if not repository:
-            repository = 'origin'
+        repository = crt_series.get_parent_remote()
 
     refspec = None
     if len(args) == 2:
diff --git a/stgit/stack.py b/stgit/stack.py
index 087403f..026fc36 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -398,6 +398,16 @@ class Series(StgitObject):
     def set_description(self, line):
         self._set_field('description', line)
 
+    def get_parent_remote(self):
+        value = config.get('branch.%s.remote' % self.__name)
+        if value:
+            return value
+        else:
+            return 'origin'
+
+    def __set_parent_remote(self, remote):
+        value = config.set('branch.%s.remote' % self.__name, remote)
+
     def __patch_is_current(self, patch):
         return patch.get_name() == self.get_current()
 
