From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-rebase: make 'rebase HEAD branch' works as expected.
Date: Thu, 22 Mar 2007 02:54:59 -0700
Message-ID: <7vzm65txfw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 10:55:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUK0g-0002i9-DP
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 10:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932773AbXCVJzB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 05:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933865AbXCVJzB
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 05:55:01 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54794 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932773AbXCVJzA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 05:55:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070322095501.PRID321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 22 Mar 2007 05:55:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dluz1W00T1kojtg0000000; Thu, 22 Mar 2007 05:55:00 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42854>

When you want to amend the commit message of 3 commits before
the tip of the current branch, say 'master',

	A--B--C--D--E(master)

it is sometimes handy to make your head detached at that commit
first with:

	$ git checkout HEAD~3 ;# check out B
	$ git commit --amend ;# without modifying contents...

to create

          .B'(HEAD)
         /
	A--B--C--D--E(master)

and then rebase master onto HEAD with this:

	$ git rebase HEAD master

However, the current code interprets HEAD _after_ it switches to
the branch 'master', which means the rebase will not do
anything.  You have to say something unwieldly like this instead:

	$ git rebase $(git rev-parse HEAD) master

This fixes it by expanding the $onto commit name before
switching to the target branch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * By the way, if you change the contents of the commit at the
   same time (i.e. tree(B) and tree(B') are different in the
   example), then rebase would say B and B' conflict.  In such a
   case, you can do:

	$ git rebase --onto HEAD master~3 master

   This is not something new, but I thought it would be good to
   mention it.

 git-rebase.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index b51d19d..aadd580 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -265,6 +265,10 @@ upstream_name="$1"
 upstream=`git rev-parse --verify "${upstream_name}^0"` ||
     die "invalid upstream $upstream_name"
 
+# Make sure the branch to rebase onto is valid.
+onto_name=${newbase-"$upstream_name"}
+onto=$(git-rev-parse --verify "${onto_name}^0") || exit
+
 # If a hook exists, give it a chance to interrupt
 if test -x "$GIT_DIR/hooks/pre-rebase"
 then
@@ -291,10 +295,6 @@ case "$#" in
 esac
 branch=$(git-rev-parse --verify "${branch_name}^0") || exit
 
-# Make sure the branch to rebase onto is valid.
-onto_name=${newbase-"$upstream_name"}
-onto=$(git-rev-parse --verify "${onto_name}^0") || exit
-
 # Now we are rebasing commits $upstream..$branch on top of $onto
 
 # Check if we are already based on $onto, but this should be
-- 
1.5.1.rc1.635.gd0664
