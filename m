From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] Make 'stg cp' 2nd form safe.
Date: Sun, 11 Mar 2007 22:44:12 +0100
Message-ID: <20070311214412.3142.58190.stgit@gandelf.nowhere.earth>
References: <20070311214133.3142.11407.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:44:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQVqW-0006GL-7G
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 22:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830AbXCKVot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 17:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932849AbXCKVot
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 17:44:49 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58299 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932830AbXCKVos (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 17:44:48 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E99C5819A;
	Sun, 11 Mar 2007 22:44:47 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 33C941F083;
	Sun, 11 Mar 2007 22:44:12 +0100 (CET)
In-Reply-To: <20070311214133.3142.11407.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41992>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/stg-cp.txt |    9 +++++----
 stgit/git.py             |    9 +++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/stg-cp.txt b/Documentation/stg-cp.txt
index f499309..723d811 100644
--- a/Documentation/stg-cp.txt
+++ b/Documentation/stg-cp.txt
@@ -35,10 +35,11 @@ file not known to Git will not be copied.
 CAVEATS
 -------
 
-The first form doesn't allow yet to overwrite an existing file
-(whether it could be recovered from Git or not), and the second form
-does not check before overwriting any file, possibly leading to loss
-of non-committed modifications.
+This command does not allow yet to overwrite an existing file (whether
+it could be recovered from Git or not).  Further more, when copying a
+directory, the second form does not allow to proceed if a directory by
+that name already exists inside the target, even when no file inside
+that directory would be overwritten.
 
 FUTURE OPTIONS
 --------------
diff --git a/stgit/git.py b/stgit/git.py
index 9129c92..f6d6b43 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -464,6 +464,15 @@ def copy(filespecs, target):
     if os.path.isdir(target):
         # target is a directory: copy each entry on the command line,
         # with the same name, into the target
+        target = target.rstrip('/')
+        
+        # first, check that none of the children of the target
+        # matching the command line aleady exist
+        for filespec in filespecs:
+            entry = target+ '/' + os.path.basename(filespec.rstrip('/'))
+            if os.path.exists(entry):
+                raise GitException, 'Target "%s" already exists' % entry
+        
         for filespec in filespecs:
             filespec = filespec.rstrip('/')
             basename = '/' + os.path.basename(filespec)
