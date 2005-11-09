From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] merge-recursive: Only print relevant rename messages
Date: Wed, 9 Nov 2005 11:36:55 +0100
Message-ID: <20051109103655.GB4960@c165.ib.student.liu.se>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org> <Pine.LNX.4.64.0511070848440.3193@g5.osdl.org> <20051107231944.GA11327@c165.ib.student.liu.se> <7v64r4qai6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 09 11:39:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZnKH-0007Sc-6L
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 11:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbVKIKhF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 05:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbVKIKhF
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 05:37:05 -0500
Received: from [85.8.31.11] ([85.8.31.11]:21392 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030479AbVKIKhC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 05:37:02 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 208CA40FD; Wed,  9 Nov 2005 11:45:21 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EZnK3-0000GG-00; Wed, 09 Nov 2005 11:36:55 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64r4qai6.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11392>

On Mon, Nov 07, 2005 at 03:54:57PM -0800, Junio C Hamano wrote:
> Fredrik Kuivinen <freku045@student.liu.se> writes:
> 
> > @@ -178,7 +181,7 @@ def mergeFile(oPath, oSha, oMode, aPath,
> >              sha = bSha
> >      else:
> >          if aSha != oSha and bSha != oSha:
> > -            merge = True
> > +            merge = MERGE_TRIVIAL
> 
> The rest looks good to me, but are you sure about this part?  I
> have a feeling that the above "and" should be "or", meaning, we
> check to see if there is _any_ change, and default to TRIVIAL,
> but later we would find that we need a real merge and then
> promote it to MERGE_3WAY.
> 

You are right. The code actually do the right thing, but it does it by
accident. Please apply the following patch.

---

merge-recursive: Fix limited output of rename messages

The previous code did the right thing, but it did it by accident.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

applies-to: bb7dd65e1d945edbe0137a761ebc388c7394067a
f56613498cd7fb7013f532a04e63b580314ed957
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index 9983cd9..3657875 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -162,13 +162,10 @@ def mergeTrees(head, merge, common, bran
 # Low level file merging, update and removal
 # ------------------------------------------
 
-MERGE_NONE = 0
-MERGE_TRIVIAL = 1
-MERGE_3WAY = 2
 def mergeFile(oPath, oSha, oMode, aPath, aSha, aMode, bPath, bSha, bMode,
               branch1Name, branch2Name):
 
-    merge = MERGE_NONE
+    merge = False
     clean = True
 
     if stat.S_IFMT(aMode) != stat.S_IFMT(bMode):
@@ -181,7 +178,7 @@ def mergeFile(oPath, oSha, oMode, aPath,
             sha = bSha
     else:
         if aSha != oSha and bSha != oSha:
-            merge = MERGE_TRIVIAL
+            merge = True
 
         if aMode == oMode:
             mode = bMode
@@ -211,7 +208,6 @@ def mergeFile(oPath, oSha, oMode, aPath,
             os.unlink(src1)
             os.unlink(src2)
 
-            merge = MERGE_3WAY
             clean = (code == 0)
         else:
             assert(stat.S_ISLNK(aMode) and stat.S_ISLNK(bMode))
@@ -590,7 +586,7 @@ def processRenames(renamesA, renamesB, b
                 if merge or not clean:
                     print 'Renaming', fmtRename(path, ren1.dstName)
 
-                if merge == MERGE_3WAY:
+                if merge:
                     print 'Auto-merging', ren1.dstName
 
                 if not clean:
@@ -668,7 +664,7 @@ def processRenames(renamesA, renamesB, b
                 if merge or not clean:
                     print 'Renaming', fmtRename(ren1.srcName, ren1.dstName)
 
-                if merge == MERGE_3WAY:
+                if merge:
                     print 'Auto-merging', ren1.dstName
 
                 if not clean:
---
0.99.9.GIT
