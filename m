From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] merge-recursive: leave unmerged entries in the index.
Date: Sat, 10 Dec 2005 22:26:30 -0800
Message-ID: <7vek4ktai1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 07:29:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElKh8-0007oN-8s
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 07:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVLKG0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 01:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVLKG0d
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 01:26:33 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:18092 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932147AbVLKG0c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2005 01:26:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051211062547.QHBE20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Dec 2005 01:25:47 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13485>

This does two things.

 - When one branch renamed and the other branch did not, the
   resulting half-merged file in the working tree used to swap
   branches around and showed as if renaming side was "ours".
   This was confusing and inconsistent (even though the conflict
   markers were marked with branch names, it was not a good
   enough excuse).  This changes the order of arguments to
   mergeFile in such a case to make sure we always see "our"
   change between <<< and ===, and "their" change between ===
   and >>>.

 - When both branches renamed to the same path, and when one
   branch renamed and the other branch did not, we attempt
   mergeFile.  When this automerge conflicted, we used to
   collapse the index.  Now we use update-index --index-info
   to inject higher stage entries to leave the index in unmerged
   state for these two cases.

What this still does _not_ do is to inject unmerged state into
the index when the structural changes conflict.  I have not
thought things through what to do in each case yet, but the
cases this commit cover are the most common ones, so this would
be a good start.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Aside from minor cleanups both in usage strings and
   documentation, many of which might still remain, I consider
   this the last remaining bit before we can go 1.0, and
   comments and corrections are very much appreciated.

 git-merge-recursive.py |   54 +++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 46 insertions(+), 8 deletions(-)

e5c23ede9ccc6ddd5f2cf13154f977bb1b687051
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index b7fb096..767b13c 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -280,6 +280,22 @@ def updateFileExt(sha, mode, path, updat
         runProgram(['git-update-index', '--add', '--cacheinfo',
                     '0%o' % mode, sha, path])
 
+def setIndexStages(path,
+                   oSHA1, oMode,
+                   aSHA1, aMode,
+                   bSHA1, bMode):
+    prog = ['git-update-index', '-z', '--index-info']
+    proc = subprocess.Popen(prog, stdin=subprocess.PIPE)
+    pipe = proc.stdin
+    # Clear stages first.
+    pipe.write("0 " + ("0" * 40) + "\t" + path + "\0")
+    # Set stages
+    pipe.write("%o %s %d\t%s\0" % (oMode, oSHA1, 1, path))
+    pipe.write("%o %s %d\t%s\0" % (aMode, aSHA1, 2, path))
+    pipe.write("%o %s %d\t%s\0" % (bMode, bSHA1, 3, path))
+    pipe.close()
+    proc.wait()
+
 def removeFile(clean, path):
     updateCache = cacheOnly or clean
     updateWd = not cacheOnly
@@ -590,6 +606,8 @@ def processRenames(renamesA, renamesB, b
                 else:
                     dstName2 = ren1.dstName
 
+                # NEEDSWORK: place dstNameA at stage 2 and dstNameB at stage 3
+                # What about other stages???
                 updateFile(False, ren1.dstSha, ren1.dstMode, dstName1)
                 updateFile(False, ren2.dstSha, ren2.dstMode, dstName2)
             else:
@@ -611,8 +629,11 @@ def processRenames(renamesA, renamesB, b
                     cleanMerge = False
 
                     if not cacheOnly:
-                        updateFileExt(ren1.dstSha, ren1.dstMode, ren1.dstName,
-                                      updateCache=True, updateWd=False)
+                        setIndexStages(ren1.dstName,
+                                       ren1.srcSha, ren1.srcMode,
+                                       ren1.dstSha, ren1.dstMode,
+                                       ren2.dstSha, ren2.dstMode)
+
                 updateFile(clean, resSha, resMode, ren1.dstName)
         else:
             # Renamed in 1, maybe changed in 2
@@ -672,11 +693,24 @@ def processRenames(renamesA, renamesB, b
                 tryMerge = True
 
             if tryMerge:
+
+                oName, oSHA1, oMode = ren1.srcName, ren1.srcSha, ren1.srcMode
+                aName, bName = ren1.dstName, ren1.srcName
+                aSHA1, bSHA1 = ren1.dstSha, srcShaOtherBranch
+                aMode, bMode = ren1.dstMode, srcModeOtherBranch
+                aBranch, bBranch = branchName1, branchName2
+
+                if renamesA != renames1:
+                    aName, bName = bName, aName
+                    aSHA1, bSHA1 = bSHA1, aSHA1
+                    aMode, bMode = bMode, aMode
+                    aBranch, bBranch = bBranch, aBranch
+
                 [resSha, resMode, clean, merge] = \
-                         mergeFile(ren1.srcName, ren1.srcSha, ren1.srcMode,
-                                   ren1.dstName, ren1.dstSha, ren1.dstMode,
-                                   ren1.srcName, srcShaOtherBranch, srcModeOtherBranch,
-                                   branchName1, branchName2)
+                         mergeFile(oName, oSHA1, oMode,
+                                   aName, aSHA1, aMode,
+                                   bName, bSHA1, bMode,
+                                   aBranch, bBranch);
 
                 if merge or not clean:
                     output('Renaming', fmtRename(ren1.srcName, ren1.dstName))
@@ -690,8 +724,12 @@ def processRenames(renamesA, renamesB, b
                     cleanMerge = False
 
                     if not cacheOnly:
-                        updateFileExt(ren1.dstSha, ren1.dstMode, ren1.dstName,
-                                      updateCache=True, updateWd=False)
+                        # Stuff stage1/2/3
+                        setIndexStages(ren1.dstName,
+                                       oSHA1, oMode,
+                                       aSHA1, aMode,
+                                       bSHA1, bMode)
+
                 updateFile(clean, resSha, resMode, ren1.dstName)
 
     return cleanMerge
-- 
0.99.9.GIT
