From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] merge-recursive: Only print relevant rename messages
Date: Tue, 8 Nov 2005 00:19:44 +0100
Message-ID: <20051107231944.GA11327@c165.ib.student.liu.se>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org> <Pine.LNX.4.64.0511070848440.3193@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 00:22:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZGHF-0006g3-ON
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 00:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbVKGXTq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 18:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965590AbVKGXTq
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 18:19:46 -0500
Received: from [85.8.31.11] ([85.8.31.11]:49549 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S965125AbVKGXTp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 18:19:45 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 20C0540FD; Tue,  8 Nov 2005 00:28:04 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EZGHA-0002wv-00; Tue, 08 Nov 2005 00:19:44 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511070848440.3193@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11290>

On Mon, Nov 07, 2005 at 08:56:07AM -0800, Linus Torvalds wrote:
> 
> Btw, one thing that it does is print out too much information.
> 
> In particular, I had renames on both sides of the merge (in case anybody 
> wants to see which one I'm talking about: it's the current top-of-head 
> commit in the kernel archives: 333c47c847c90aaefde8b593054d9344106333b5).
> 
> Now, renames that you've done yourself you really don't want to hear 
> about, at least if the other side didn't change anything in that file.
> 
> Renames that the _other_ side has done (the one you're merging) you may or 
> may not want to know about, regardless of whether they happened to files 
> that are changed. But since "git pull" will do a "git-apply --stat" at the 
> end and show the renames there, I'd argue that the merge strategy itself 
> should be quiet about any renames that are trivial.
> 
> So how about talking about renames only if you end up also doing a 
> file-level merge? As it is, doing the merge talked about renames that I 
> had merged earlier in my own branch, which is just confusing.
> 

Sounds like a good idea. How about something like the following?

--

It isn't really interesting to know about the renames that have
already been committed to the branch you are working on. Furthermore,
the 'git-apply --stat' at the end of git-(merge|pull) will tell us
about any renames in the other branch.

With this commit only renames which require a file-level merge will
be printed.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

applies-to: 5af1b5b93257ecfe993bb24975bf596faa342758
89c029b439603630a53ee4e4d0cb7931111afd2a
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index 626d854..9983cd9 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -162,10 +162,13 @@ def mergeTrees(head, merge, common, bran
 # Low level file merging, update and removal
 # ------------------------------------------
 
+MERGE_NONE = 0
+MERGE_TRIVIAL = 1
+MERGE_3WAY = 2
 def mergeFile(oPath, oSha, oMode, aPath, aSha, aMode, bPath, bSha, bMode,
               branch1Name, branch2Name):
 
-    merge = False
+    merge = MERGE_NONE
     clean = True
 
     if stat.S_IFMT(aMode) != stat.S_IFMT(bMode):
@@ -178,7 +181,7 @@ def mergeFile(oPath, oSha, oMode, aPath,
             sha = bSha
     else:
         if aSha != oSha and bSha != oSha:
-            merge = True
+            merge = MERGE_TRIVIAL
 
         if aMode == oMode:
             mode = bMode
@@ -207,7 +210,8 @@ def mergeFile(oPath, oSha, oMode, aPath,
             os.unlink(orig)
             os.unlink(src1)
             os.unlink(src2)
-            
+
+            merge = MERGE_3WAY
             clean = (code == 0)
         else:
             assert(stat.S_ISLNK(aMode) and stat.S_ISLNK(bMode))
@@ -577,14 +581,16 @@ def processRenames(renamesA, renamesB, b
                 updateFile(False, ren1.dstSha, ren1.dstMode, dstName1)
                 updateFile(False, ren2.dstSha, ren2.dstMode, dstName2)
             else:
-                print 'Renaming', fmtRename(path, ren1.dstName)
                 [resSha, resMode, clean, merge] = \
                          mergeFile(ren1.srcName, ren1.srcSha, ren1.srcMode,
                                    ren1.dstName, ren1.dstSha, ren1.dstMode,
                                    ren2.dstName, ren2.dstSha, ren2.dstMode,
                                    branchName1, branchName2)
 
-                if merge:
+                if merge or not clean:
+                    print 'Renaming', fmtRename(path, ren1.dstName)
+
+                if merge == MERGE_3WAY:
                     print 'Auto-merging', ren1.dstName
 
                 if not clean:
@@ -653,14 +659,16 @@ def processRenames(renamesA, renamesB, b
                 tryMerge = True
 
             if tryMerge:
-                print 'Renaming', fmtRename(ren1.srcName, ren1.dstName)
                 [resSha, resMode, clean, merge] = \
                          mergeFile(ren1.srcName, ren1.srcSha, ren1.srcMode,
                                    ren1.dstName, ren1.dstSha, ren1.dstMode,
                                    ren1.srcName, srcShaOtherBranch, srcModeOtherBranch,
                                    branchName1, branchName2)
 
-                if merge:
+                if merge or not clean:
+                    print 'Renaming', fmtRename(ren1.srcName, ren1.dstName)
+
+                if merge == MERGE_3WAY:
                     print 'Auto-merging', ren1.dstName
 
                 if not clean:
