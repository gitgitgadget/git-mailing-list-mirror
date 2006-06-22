From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rebase --merge: fix for rebasing more than 7 commits.
Date: Thu, 22 Jun 2006 01:44:54 -0700
Message-ID: <7vy7vptw8p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 10:45:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtKo7-0002iZ-1m
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 10:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWFVIo4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 04:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWFVIo4
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 04:44:56 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:45050 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751769AbWFVIoz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 04:44:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622084455.YHMV6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 04:44:55 -0400
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22311>

Instead of using 4-digit numbers to name commits being rebased,
just use "cmt.$msgnum" string, with $msgnum as a decimal number
without leading zero padding.  This makes it possible to rebase
more than 9999 commits, but of more practical importance is that
the earlier code used "printf" to format already formatted
$msgnum and barfed when it counted up to 0008.  In other words,
the old code was incapable of rebasing more than 7 commits, and
this fixes that problem.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I wanted to raise my confidence level in the new rebase --merge
   code, so I did a little exercise which resulted in finding this
   buglet.

   I did not have "read/write-tree --prefix" on the "master"
   branch, when I received the patch series that begins with
   "Make git-write-tree a builtin" from Lukas.  Now, my policy
   is to avoid starting a new topic based on "next" (because it
   would make later pulling in the topic into "master" without
   all the other uncooked stuff in "next" impossible), but the
   series was based on "next" (which was actually nice, since
   write-tree between "master" and "next" were somewhat diverged
   back then), and I couldn't easily rebase Lukas's patch series
   on top of "master" because we did not have "rebase --merge"
   option.  Now I can with the updated "rebase".

   So the exercise went like this:

   (1) Start from a clone of git.git, with "master" at 8c278ab
       (where the "master" was before "read/write-tree --prefix"
       was merged), and "ls/am" at ab195e1 (what applying
       Lukas's series on top of "next" would have produced).
       Use "reset --hard" as needed.

   (2) "git rebase --merge --onto master ls/am~9" (ls/am~8 being
       the first one of the series).  This fails with a merge
       conflict on builtin-write-tree.c (the "rebase --merge"
       code did the right thing with the renamed path).  Fix it
       up and also fix builtin.h (signature of write_tree()
       needs to be changed to drop prefix).

       It was very helpful to view:

           git diff :3:builtin-write-tree.c builtin-write-tree.c	

       during the hand resolution of the conflicts; it lets me
       see what Lukas did, so I can adjust the patch by removing
       parts that are specific to "next" and not applicable to
       "master".  

  (3) "git update-index builtin-write-tree.c builtin.h" and then
      "git rebase --continue".  The bug manifests itself during
      the finalization step, which this commit fixes.

  With this fix, the above works beautifully.  I am reasonably
  happy with this shiny new toy.  Good job, Eric! and thanks.

 git-rebase.sh |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index b9ce112..9159477 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -67,16 +67,16 @@ continue_merge () {
 	prev_head=`git-rev-parse HEAD^0`
 
 	# save the resulting commit so we can read-tree on it later
-	echo "$prev_head" > "$dotest/`printf %0${prec}d $msgnum`.result"
+	echo "$prev_head" > "$dotest/cmt.$msgnum.result"
 	echo "$prev_head" > "$dotest/prev_head"
 
 	# onto the next patch:
 	msgnum=$(($msgnum + 1))
-	printf "%0${prec}d" "$msgnum" > "$dotest/msgnum"
+	echo "$msgnum" >"$dotest/msgnum"
 }
 
 call_merge () {
-	cmt="$(cat $dotest/`printf %0${prec}d $1`)"
+	cmt="$(cat $dotest/cmt.$1)"
 	echo "$cmt" > "$dotest/current"
 	git-merge-$strategy "$cmt^" -- HEAD "$cmt"
 	rv=$?
@@ -108,15 +108,12 @@ finish_rb_merge () {
 	end="`cat $dotest/end`"
 	while test "$msgnum" -le "$end"
 	do
-		msgnum=`printf "%0${prec}d" "$msgnum"`
-		printf "%0${prec}d" "$msgnum" > "$dotest/msgnum"
-
-		git-read-tree `cat "$dotest/$msgnum.result"`
+		git-read-tree `cat "$dotest/cmt.$msgnum.result"`
 		git-checkout-index -q -f -u -a
-		git-commit -C "`cat $dotest/$msgnum`"
+		git-commit -C "`cat $dotest/cmt.$msgnum`"
 
-		echo "Committed $msgnum"
-		echo '    '`git-rev-list --pretty=oneline -1 HEAD | \
+		printf "Committed %0${prec}d" $msgnum
+		echo ' '`git-rev-list --pretty=oneline -1 HEAD | \
 					sed 's/^[a-f0-9]\+ //'`
 		msgnum=$(($msgnum + 1))
 	done
@@ -322,11 +319,11 @@ for cmt in `git-rev-list --no-merges "$u
 			| perl -e 'print reverse <>'`
 do
 	msgnum=$(($msgnum + 1))
-	echo "$cmt" > "$dotest/`printf "%0${prec}d" $msgnum`"
+	echo "$cmt" > "$dotest/cmt.$msgnum"
 done
 
-printf "%0${prec}d" 1 > "$dotest/msgnum"
-printf "%0${prec}d" "$msgnum" > "$dotest/end"
+echo 1 >"$dotest/msgnum"
+echo $msgnum >"$dotest/end"
 
 end=$msgnum
 msgnum=1
-- 
1.4.0.gfba6
