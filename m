From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/3] Do not return 'origin' as parent remote when there is no
	such remote.
Date: Fri, 02 Feb 2007 00:48:10 +0100
Message-ID: <20070201234810.3313.72720.stgit@gandelf.nowhere.earth>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:49:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HClfw-0001mp-0z
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422944AbXBAXtB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422948AbXBAXtB
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:49:01 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:41627 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422944AbXBAXtA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:49:00 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id ECC819B720;
	Fri,  2 Feb 2007 00:48:59 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 4AB791F080;
	Fri,  2 Feb 2007 00:48:10 +0100 (CET)
In-Reply-To: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38435>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/stack.py |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index dbdda01..729b77e 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -408,7 +408,15 @@ class Series(StgitObject):
         self._set_field('description', line)
 
     def get_parent_remote(self):
-        return config.get('branch.%s.remote' % self.__name) or 'origin'
+        value = config.get('branch.%s.remote' % self.__name)
+        if value:
+            return value
+        elif 'origin' in git.remotes_list():
+            # FIXME: this is for compatibility only.  Should be
+            # dropped when all relevant commands record this info.
+            return 'origin'
+        else:
+            raise StackException, 'Cannot find a parent remote for "%s"' % self.__name
 
     def __set_parent_remote(self, remote):
         value = config.set('branch.%s.remote' % self.__name, remote)
@@ -418,6 +426,8 @@ class Series(StgitObject):
         if value:
             return value
         elif git.rev_parse('heads/origin'):
+            # FIXME: this is for compatibility only.  Should be
+            # dropped when all relevant commands record this info.
             return 'heads/origin'
         else:
             raise StackException, 'Cannot find a parent branch for "%s"' % self.__name
