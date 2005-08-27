From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use "git cherry-pick" in "git rebase"
Date: Fri, 26 Aug 2005 18:19:02 -0700
Message-ID: <7vacj489dl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 27 03:20:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8pMJ-0003hT-3c
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 03:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbVH0BTG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 21:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbVH0BTF
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 21:19:05 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38016 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965195AbVH0BTE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 21:19:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050827011904.GUQM15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 21:19:04 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7836>

Rewrite "git rebase" using "git cherry-pick".

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-rebase-script |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

913404ae6371857c21c696cc3d8b0a04421fdeb2
diff --git a/git-rebase-script b/git-rebase-script
--- a/git-rebase-script
+++ b/git-rebase-script
@@ -37,7 +37,7 @@ git-rev-parse --verify "$upstream^0" >"$
 
 tmp=.rebase-tmp$$
 fail=$tmp-fail
-trap "rm -rf $tmp-*" 0 1 2 3 15
+trap "rm -rf $tmp-*" 1 2 3 15
 
 >$fail
 
@@ -48,14 +48,18 @@ do
 	-) continue ;;
 	esac
 	S=`cat "$GIT_DIR/HEAD"` &&
-        GIT_EXTERNAL_DIFF=git-apply-patch-script git-diff-tree -p $commit &&
-	git-commit-script -C "$commit" || {
+	git-cherry-pick-script --replay $commit || {
+		echo >&2 "* Not applying the patch and continuing."
 		echo $commit >>$fail
-		git-read-tree --reset -u $S
+		git-reset-script --hard $S
 	}
 done
 if test -s $fail
 then
-	echo Some commits could not be rebased, check by hand:
-	cat $fail
+	echo >&2 Some commits could not be rebased, check by hand:
+	cat >&2 $fail
+	echo >&2 "(the same list of commits are found in $tmp)"
+	exit 1
+else
+	rm -f $fail
 fi
