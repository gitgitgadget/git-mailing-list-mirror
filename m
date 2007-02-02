From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Be tolerant to repos without .git/remotes/ or .git/branches/.
Date: Sat, 03 Feb 2007 00:00:08 +0100
Message-ID: <20070202225900.30628.17382.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 03 00:01:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD7P2-0001QP-7t
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 00:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946149AbXBBXBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 18:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946139AbXBBXBE
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 18:01:04 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:54526 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946149AbXBBXBD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 18:01:03 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 03C9B5541;
	Sat,  3 Feb 2007 00:01:01 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 9636A1F07F;
	Sat,  3 Feb 2007 00:00:08 +0100 (CET)
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38537>


__remotes_from_dir() was not robust against non-existent dirs.
This a Git 1.5 compat issue, since repos do not have .git/remotes any
more.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

This problem prevented me from seeing the t1200 regression you
reported, but once this one is fixed I do hit a problem there.

 stgit/git.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 022d607..069833d 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -904,7 +904,11 @@ def __remotes_from_config():
     return config.sections_matching(r'remote\.(.*)\.url')
 
 def __remotes_from_dir(dir):
-    return os.listdir(os.path.join(basedir.get(), dir))
+    absdir=os.path.join(basedir.get(), dir)
+    if os.path.isdir(absdir):
+        return os.listdir(absdir)
+    else:
+        return []
 
 def remotes_list():
     """Return the list of remotes in the repository
