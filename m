From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/4] Rewrite rebase to use git-format-patch piped to git-am.
Date: Tue, 15 Nov 2005 15:33:27 -0800
Message-ID: <7virutfpvc.fsf@assigned-by-dhcp.cox.net>
References: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 16 00:34:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAIw-0004YH-2D
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbVKOXda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 18:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVKOXda
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:33:30 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:42703 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932576AbVKOXd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 18:33:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115233236.UZEA17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 18:32:36 -0500
To: git@vger.kernel.org
In-Reply-To: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 15 Nov 2005 15:32:05 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11969>

This does not handle binary files yet, but a patch or two to
git-apply should solve that problem.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-rebase.sh |   71 ++++++++++++---------------------------------------------
 1 files changed, 15 insertions(+), 56 deletions(-)

applies-to: efad0bc70473bdc02b8ac6a5e5f001519f1d5dfa
d64a7b926edfcebf9f5b116fedebd365e5c206f1
diff --git a/git-rebase.sh b/git-rebase.sh
index fa95009..56196e7 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -5,65 +5,24 @@
 
 . git-sh-setup || die "Not a git archive."
 
-usage="usage: $0 "'<upstream> [<head>]
-
-Uses output from git-cherry to rebase local commits to the new head of
-upstream tree.'
-
-case "$#,$1" in
-1,*..*)
-    upstream=$(expr "$1" : '\(.*\)\.\.') ours=$(expr "$1" : '.*\.\.\(.*\)$')
-    set x "$upstream" "$ours"
-    shift ;;
-esac
+# The other head is given
+other=$(git-rev-parse --verify "$1^0") || exit
 
+# The tree must be really really clean.
 git-update-index --refresh || exit
+diff=$(git-diff-index --cached --name-status -r HEAD)
+case "$different" in
+?*)	echo "$diff"
+	exit 1
+	;;
+esac
 
+# If the branch to rebase is given, first switch to it.
 case "$#" in
-1) ours_symbolic=HEAD ;;
-2) ours_symbolic="$2" ;;
-*) die "$usage" ;;
+2)
+	git-checkout "$2" || exit
 esac
 
-upstream=`git-rev-parse --verify "$1"` &&
-ours=`git-rev-parse --verify "$ours_symbolic"` || exit
-different1=$(git-diff-index --name-only --cached "$ours") &&
-different2=$(git-diff-index --name-only "$ours") &&
-test "$different1$different2" = "" ||
-die "Your working tree does not match $ours_symbolic."
-
-git-read-tree -m -u $ours $upstream &&
-new_head=$(git-rev-parse --verify "$upstream^0") &&
-git-update-ref HEAD "$new_head" || exit
-
-tmp=.rebase-tmp$$
-fail=$tmp-fail
-trap "rm -rf $tmp-*" 1 2 3 15
-
->$fail
-
-git-cherry -v $upstream $ours |
-while read sign commit msg
-do
-	case "$sign" in
-	-)
-		echo >&2 "* Already applied: $msg"
-		continue ;;
-	esac
-	echo >&2 "* Applying: $msg"
-	S=$(git-rev-parse --verify HEAD) &&
-	git-cherry-pick --replay $commit || {
-		echo >&2 "* Not applying the patch and continuing."
-		echo $commit >>$fail
-		git-reset --hard $S
-	}
-done
-if test -s $fail
-then
-	echo >&2 Some commits could not be rebased, check by hand:
-	cat >&2 $fail
-	echo >&2 "(the same list of commits are found in $tmp)"
-	exit 1
-else
-	rm -f $fail
-fi
+# Rewind the head to "$other"
+git-reset --hard "$other"
+git-format-patch -k --stdout "$other" ORIG_HEAD | git am -3 -k
---
0.99.9.GIT
