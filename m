From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 04/10] Drop utils.remove_dirs() in favor of os.removedirs().
Date: Thu, 15 Mar 2007 01:26:50 +0100
Message-ID: <20070315002649.9094.6314.stgit@gandelf.nowhere.earth>
References: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:27:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdnz-00035L-L4
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422760AbXCOA0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422764AbXCOA0w
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:26:52 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59016 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422760AbXCOA0v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:26:51 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 6C91C38F0;
	Thu, 15 Mar 2007 01:26:50 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 05EE91F095;
	Thu, 15 Mar 2007 01:26:50 +0100 (CET)
In-Reply-To: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42259>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/utils.py |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/stgit/utils.py b/stgit/utils.py
index bfe7797..d04d077 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -116,24 +116,16 @@ def strip_suffix(suffix, string):
     assert string.endswith(suffix)
     return string[:-len(suffix)]
 
-def remove_dirs(basedir, dirs):
-    """Starting at join(basedir, dirs), remove the directory if empty,
-    and try the same with its parent, until we find a nonempty
-    directory or reach basedir."""
-    path = dirs
-    while path:
-        try:
-            os.rmdir(os.path.join(basedir, path))
-        except OSError:
-            return # can't remove nonempty directory
-        path = os.path.dirname(path)
-
 def remove_file_and_dirs(basedir, file):
     """Remove join(basedir, file), and then remove the directory it
     was in if empty, and try the same with its parent, until we find a
     nonempty directory or reach basedir."""
     os.remove(os.path.join(basedir, file))
-    remove_dirs(basedir, os.path.dirname(file))
+    try:
+        os.removedirs(os.path.join(basedir, os.path.dirname(file)))
+    except OSError:
+        # file's parent dir may not be empty after removal
+        pass
 
 def create_dirs(directory):
     """Create the given directory, if the path doesn't already exist."""
@@ -152,7 +144,11 @@ def rename(basedir, file1, file2):
     full_file2 = os.path.join(basedir, file2)
     create_dirs(os.path.dirname(full_file2))
     os.rename(os.path.join(basedir, file1), full_file2)
-    remove_dirs(basedir, os.path.dirname(file1))
+    try:
+        os.removedirs(os.path.join(basedir, os.path.dirname(file1)))
+    except OSError:
+        # file1's parent dir may not be empty after move
+        pass
 
 class EditorException(Exception):
     pass
