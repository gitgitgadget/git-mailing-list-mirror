From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/5] Move identification of parent branch's remote def up into
	stack class.
Date: Sat, 27 Jan 2007 12:21:17 +0100
Message-ID: <20070127112117.16475.79541.stgit@gandelf.nowhere.earth>
References: <20070127104024.16475.81445.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 12:23:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAleI-0005F8-BS
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 12:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbXA0LXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 06:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbXA0LXG
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 06:23:06 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:49280 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253AbXA0LXF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 06:23:05 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 21D0327ADB
	for <git@vger.kernel.org>; Sat, 27 Jan 2007 12:23:04 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1HAldv-0003ZJ-QN; Sat, 27 Jan 2007 12:22:47 +0100
In-Reply-To: <20070127104024.16475.81445.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37945>


Also adds the __set_parent_remote() counterpart method, but only
private since it is expected to be called only through set_parent, to
be introduced in subsequent patch.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/pull.py |    6 +-----
 stgit/stack.py         |   13 +++++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 7c5db22..1a948be 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -53,11 +53,7 @@ def func(parser, options, args):
     if len(args) >= 1:
         repository = args[0]
     else:
-        section = 'branch "%s"' % git.get_head_file()
-        if config.has_option(section, 'remote'):
-            repository = config.get(section, 'remote')
-        else:
-            repository = 'origin'
+        repository = crt_series.get_parent_remote()
 
     refspec = None
     if len(args) == 2:
diff --git a/stgit/stack.py b/stgit/stack.py
index 2ae4dd5..e801f42 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -397,6 +397,19 @@ class Series(StgitObject):
     def set_description(self, line):
         self._set_field('description', line)
 
+    def get_parent_remote(self):
+        section = 'branch "%s"' % self.__name
+        if config.has_option(section, 'remote'):
+            return config.get(section, 'remote')
+        else:
+            return 'origin'
+
+    def __set_parent_remote(self, remote):
+        section = 'branch "%s"' % self.__name
+        if not config.has_section(section):
+            config.add_section(section)
+        config.set(section, 'remote', remote)
+
     def __patch_is_current(self, patch):
         return patch.get_name() == self.get_current()
 
