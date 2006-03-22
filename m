From: Junio C Hamano <junkio@cox.net>
Subject: Warning: fetch updated the current branch head.
Date: Wed, 22 Mar 2006 01:48:37 -0800
Message-ID: <7v4q1qajyi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 22 10:48:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLzxQ-0002nN-JG
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 10:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWCVJso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 04:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWCVJso
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 04:48:44 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:28846 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751169AbWCVJso (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 04:48:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060322094843.TCEF15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Mar 2006 04:48:43 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17809>

I was helping somebody who:

 * had a clone of git.git repository;
 * had "next" checked out a week or so ago;
 * did not have any development on his own;
 * tried to pull using the default .git/remotes/origin from me.

Somehow the index was out of sync before that pull but there was
no change in the working tree (i.e. just the cached stat was
different), and it refused to fast-forward the index and the
working tree, because if there _were_ real changes in the
working tree, they would have been lost by a fast-forward.

This patch will be in "next" and does two things:

 * runs "git update-index --refresh" before the fast-forwarding,
   to prevent stat-only difference from interfering;

 * if there really is a local change in the working tree, show
   the original branch head information in the message, to allow
   the user to decide what to do next.

The first one would have made his working tree to fast-forward
correctly.  If the fast-forward is still prevented, that means
there really was a change, and in such a case, the way to recover
would be:

 * Examine "git diff $orig_head" output, to make sure there is
   no local change since the last pull.  If there is none, you
   can run "git reset --hard" (you do not have to name "next",
   because that is the branch you are already on) and you are
   done.

 * If there are local changes, stash them away as a patch,
   "git reset --hard" and re-apply if they are precious.

I've considered rewinding the tracking branch to match
$orig_head in such a case just before "die", but that would be a
disservice to people behind a narrow pipe -- it would require
them to re-download the objects to update the branch.

I now realize that the "die" message is a bit confusing, after
writing the above recovery procedure.  Especially, the new
"git-update-index --refresh" would say "foo: needs update", but
"update your working tree" does not mean "git update-index foo"
after such a failure.  Maybe this phrasing is better:

	die 'Cannot fast-forward your working tree.
After making sure that you saved anything precious from
$ git diff '$orig_head'
output, and run 
$ git reset --hard
to recover.'

Opinions?

-- >8 --
[PATCH] git-pull: further safety while on tracking branch.

Running 'git pull' while on the tracking branch has a built-in
safety valve to fast-forward the index and working tree to match
the branch head, but it errs on the safe side too cautiously.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-pull.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

cf46e7b8999f25d5d7f2acd64701a100e403ee03
diff --git a/git-pull.sh b/git-pull.sh
index 29c14e1..d90f7c9 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -55,7 +55,9 @@ then
 	# First update the working tree to match $curr_head.
 
 	echo >&2 "Warning: fetch updated the current branch head."
-	echo >&2 "Warning: fast forwarding your working tree."
+	echo >&2 "Warning: fast forwarding your working tree from"
+	echo >&2 "Warning: $orig_head commit."
+	git-update-index --refresh 2>/dev/null
 	git-read-tree -u -m "$orig_head" "$curr_head" ||
 		die "You need to first update your working tree."
 fi
-- 
1.2.4.gfd45
