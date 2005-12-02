From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: What's new in git.git master branch
Date: Fri, 2 Dec 2005 09:46:54 +0100
Message-ID: <20051202084654.GB4824@c165.ib.student.liu.se>
References: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net> <20051201085433.GA7866@c165.ib.student.liu.se> <7vmzjljgwo.fsf@assigned-by-dhcp.cox.net> <7v7jao9hln.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 09:48:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei6ZJ-0003lK-4k
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 09:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVLBIq4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 03:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbVLBIq4
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 03:46:56 -0500
Received: from [85.8.31.11] ([85.8.31.11]:49595 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750931AbVLBIq4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 03:46:56 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id C90734103; Fri,  2 Dec 2005 09:56:41 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1Ei6ZC-0004D7-00; Fri, 02 Dec 2005 09:46:54 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jao9hln.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13106>

On Thu, Dec 01, 2005 at 09:46:12PM -0800, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Fredrik Kuivinen <freku045@student.liu.se> writes:
> >
> >> It turns out that this change breaks the directory/file conflict
> >> handling in git-merge-recursive.
> >>
> >>    git-ls-tree -r -z <tree SHA1>
> >>
> >> Should we do it that way or should ls-tree be changed?
> >
> > Ouch.  Sorry, I should have been more careful.
> 
> So we updated ls-tree to take -t flag which shows tree entries
> under -r flag.  I'd appreciate if you test the attached patch.

With the patch tt works properly again. Thanks :)

> > Also I think I broke the case where base trees need to be merged
> > in 58cce8a8 commit (I changed processEntry not to collapse the
> > index entry when file content changes cannot be automerged, but
> > that change has to be done only for the final merge, and merges
> > between base trees must collapse to be able to write the index
> > file out as a tree).
> 
> I think that the above worry was unfounded, because the
> updateFileExt call I removed to prevent it from collapsing the
> unmerged entries was in effect only in !cacheOnly case
> (i.e. callDepth == 0).

Yes, the code is correct. You can apply the following patch to make it
a bit simpler.

- Fredrik

--
merge-recursive: Clean up index updates

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

66b1a0157f25629b35ecf300450618a230741218
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index b7fb096..4f061da 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -825,10 +825,7 @@ def processEntry(entry, branch1Name, bra
             cleanMerge = False
             output('CONFLICT (content): Merge conflict in', path)
 
-            if cacheOnly:
-                updateFile(False, sha, mode, path)
-            else:
-                updateFileExt(sha, mode, path, updateCache=False, updateWd=True)
+            updateFile(False, sha, mode, path)
     else:
         die("ERROR: Fatal merge failure, shouldn't happen.")
 
-- 
0.99.9.GIT
