From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 4/4] Rename branch.*.stgitformatversion to
	branch.*.stgit.stackformatversion.
Date: Mon, 11 Jun 2007 02:33:41 +0200
Message-ID: <20070611003341.4736.49364.stgit@gandelf.nowhere.earth>
References: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 02:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxXqu-0004P8-1X
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 02:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763244AbXFKAdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 20:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763285AbXFKAdh
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 20:33:37 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:46285 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763244AbXFKAdg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 20:33:36 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A9D8077D7;
	Mon, 11 Jun 2007 02:33:35 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 55E321F08A;
	Mon, 11 Jun 2007 02:33:41 +0200 (CEST)
In-Reply-To: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49804>

Nearly as discussed on the ml, with the name slightly modified to
better allow other types of PatchSet.
---

 stgit/stack.py |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 89b5a55..634588d 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -366,7 +366,7 @@ class Series(PatchSet):
         self.__trash_dir = os.path.join(self._dir(), 'trash')
 
     def format_version_key(self):
-        return 'branch.%s.stgitformatversion' % self.get_name()
+        return 'branch.%s.stgit.stackformatversion' % self.get_name()
 
     def update_to_current_format_version(self):
         """Update a potentially older StGIT directory structure to the
@@ -379,11 +379,17 @@ class Series(PatchSet):
             """Return the integer format version number, or None if the
             branch doesn't have any StGIT metadata at all, of any version."""
             fv = config.get(self.format_version_key())
+            ofv = config.get('branch.%s.stgitformatversion' % self.get_name())
             if fv:
                 # Great, there's an explicitly recorded format version
                 # number, which means that the branch is initialized and
                 # of that exact version.
                 return int(fv)
+            elif ofv:
+                # Old name for the version info, upgrade it
+                config.set(self.format_version_key(), ofv)
+                config.unset('branch.%s.stgitformatversion' % self.get_name())
+                return int(ofv)
             elif os.path.isdir(os.path.join(branch_dir, 'patches')):
                 # There's a .git/patches/<branch>/patches dirctory, which
                 # means this is an initialized version 1 branch.
@@ -713,7 +719,7 @@ class Series(PatchSet):
         config.unset('branch.%s.remote' % self.get_name())
         config.unset('branch.%s.merge' % self.get_name())
         config.unset('branch.%s.stgit.parentbranch' % self.get_name())
-        config.unset('branch.%s.stgitformatversion' % self.get_name())
+        config.unset(self.format_version_key())
 
     def refresh_patch(self, files = None, message = None, edit = False,
                       show_patch = False,
