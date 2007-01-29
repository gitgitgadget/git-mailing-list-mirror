From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/7] Add caching to the new config class.
Date: Tue, 30 Jan 2007 00:05:30 +0100
Message-ID: <20070129230530.7102.65330.stgit@gandelf.nowhere.earth>
References: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 00:06:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBfa4-00053b-41
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 00:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbXA2XGV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 18:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbXA2XGV
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 18:06:21 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:49467 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932833AbXA2XGN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 18:06:13 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 8CAF95518;
	Tue, 30 Jan 2007 00:06:11 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 66F7C2004;
	Tue, 30 Jan 2007 00:05:30 +0100 (CET)
In-Reply-To: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38105>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/config.py |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/stgit/config.py b/stgit/config.py
index d42754b..901f600 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -39,6 +39,8 @@ class GitConfig:
         'stgit.shortnr':	 '5'
         }
 
+    __cache={}
+
     def __run(self, cmd, args=None):
         """__run: runs cmd using spawnvp.
     
@@ -59,20 +61,31 @@ class GitConfig:
         return 0
     
     def get(self, name):
+        if self.__cache.has_key(name):
+            return self.__cache[name]
+
         stream = os.popen('git repo-config --get %s' % name, 'r')
         value = stream.readline().strip()
         stream.close()
         if len(value) > 0:
-            return value
+            pass
         elif (self.__defaults.has_key(name)):
-            return self.__defaults[name]
+            value = self.__defaults[name]
         else:
-            return None
+            value = None
+
+        self.__cache[name] = value
+        return value
 
     def getall(self, name):
+        if self.__cache.has_key(name):
+            return self.__cache[name]
+
         stream = os.popen('git repo-config --get-all %s' % name, 'r')
         values = [line.strip() for line in stream]
         stream.close()
+
+        self.__cache[name] = values
         return values
 
     def getint(self, name):
