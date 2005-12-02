From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's new in git.git master branch
Date: Thu, 01 Dec 2005 21:46:12 -0800
Message-ID: <7v7jao9hln.fsf@assigned-by-dhcp.cox.net>
References: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net>
	<20051201085433.GA7866@c165.ib.student.liu.se>
	<7vmzjljgwo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 07:00:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei3wp-0001lM-T5
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 06:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbVLBF6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 00:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbVLBF6z
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 00:58:55 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:55009 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751732AbVLBF6z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 00:58:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051202054450.RIGE17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Dec 2005 00:44:50 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <7vmzjljgwo.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 01 Dec 2005 01:38:47 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13102>

Junio C Hamano <junkio@cox.net> writes:

> Fredrik Kuivinen <freku045@student.liu.se> writes:
>
>> It turns out that this change breaks the directory/file conflict
>> handling in git-merge-recursive.
>>
>>    git-ls-tree -r -z <tree SHA1>
>>
>> Should we do it that way or should ls-tree be changed?
>
> Ouch.  Sorry, I should have been more careful.

So we updated ls-tree to take -t flag which shows tree entries
under -r flag.  I'd appreciate if you test the attached patch.

> Also I think I broke the case where base trees need to be merged
> in 58cce8a8 commit (I changed processEntry not to collapse the
> index entry when file content changes cannot be automerged, but
> that change has to be done only for the final merge, and merges
> between base trees must collapse to be able to write the index
> file out as a tree).

I think that the above worry was unfounded, because the
updateFileExt call I removed to prevent it from collapsing the
unmerged entries was in effect only in !cacheOnly case
(i.e. callDepth == 0).

-- >8 --
[PATCH] merge-recursive: adjust git-ls-tree use for the latest.

You need to pass -t flag if you want to see tree objects in
"git-ls-tree -r" output these days.  This change broke the tree
structure reading code in git-merge-recursive used to detect D/F
conflicts.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-merge-recursive.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

a6b51f11ab7f7f838a9b17f81059eebfc36e4c84
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index e599b11..b7fb096 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -98,7 +98,7 @@ getFilesRE = re.compile(r'^([0-7]+) (\S+
 def getFilesAndDirs(tree):
     files = Set()
     dirs = Set()
-    out = runProgram(['git-ls-tree', '-r', '-z', tree])
+    out = runProgram(['git-ls-tree', '-r', '-z', '-t', tree])
     for l in out.split('\0'):
         m = getFilesRE.match(l)
         if m:
-- 
0.99.9.GIT
