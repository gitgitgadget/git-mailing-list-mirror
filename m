From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH] Stgit - gitmergeonefile.py: handle removal vs. changes
Date: Sun, 13 Nov 2005 20:42:25 +0100
Message-ID: <20051113194225.20447.57910.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 20:37:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbNdl-00066d-UZ
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 20:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVKMTfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 14:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbVKMTfi
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 14:35:38 -0500
Received: from host20-103.pool873.interbusiness.it ([87.3.103.20]:35550 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750862AbVKMTfh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2005 14:35:37 -0500
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 7023323717;
	Sun, 13 Nov 2005 20:42:26 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11746>

I just got a "removal vs. changed" conflict, which is unhandled by StGit. That
is taken from git-merge-one-file resolver, but is bad, as stg resolved does not
handle unmerged entries (and probably it should be fixed too).

Sample patch included, but some thought must be done on it (see the comments I
left in).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 gitmergeonefile.py |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/gitmergeonefile.py b/gitmergeonefile.py
index 1cba193..9344d33 100755
--- a/gitmergeonefile.py
+++ b/gitmergeonefile.py
@@ -180,6 +180,30 @@ if orig_hash:
             os.remove(path)
         __remove_files()
         sys.exit(os.system('git-update-index --remove -- %s' % path))
+    # file deleted in one and changed in the other
+    else:
+        # Do something here - we must at least merge the entry in the cache,
+        # instead of leaving it in U(nmerged) state. In fact, stg resolved
+        # does not handle that.
+
+        # Do the same thing cogito does - remove the file in any case.
+        os.system('git-update-index --remove -- %s' % path)
+
+        #if file1_hash:
+            ## file deleted upstream and changed in the patch. The patch is
+            ## probably going to move the changes elsewhere.
+
+            #os.system('git-update-index --remove -- %s' % path)
+        #else:
+            ## file deleted in the patch and changed upstream. We could re-delete
+            ## it, but for now leave it there - and let the user check if he
+            ## still wants to remove the file.
+
+            ## reset the cache to the first branch
+            #os.system('git-update-index --cacheinfo %s %s %s'
+                      #% (file1_mode, file1_hash, path))
+        __conflict()
+
 # file does not exist in origin
 else:
     # file added in both
