From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] checkout -f: do not leave untracked working tree files.
Date: Tue, 20 Jun 2006 02:50:08 -0700
Message-ID: <7vfyi0b1gv.fsf_-_@assigned-by-dhcp.cox.net>
References: <449557B6.1080907@garzik.org>
	<7vbqsqdru0.fsf@assigned-by-dhcp.cox.net> <4495DB3B.10403@garzik.org>
	<7v4pyhdel5.fsf@assigned-by-dhcp.cox.net>
	<4497B39E.2050205@garzik.org>
	<7vr71kb257.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Tue Jun 20 11:50:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FscsB-0007tp-B0
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 11:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWFTJuM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 05:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbWFTJuL
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 05:50:11 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62169 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932497AbWFTJuK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 05:50:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620095009.FZJG554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Jun 2006 05:50:09 -0400
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <7vr71kb257.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 20 Jun 2006 02:35:32 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22188>

Earlier we did not consider untracked working tree files
"precious", but we have always considered them fair game to
clobber.  These days, branch switching by read-tree is more
careful and tries to protect untracked working tree files.  This
caused the following workflow to stop working:

	git checkout one-branch-with-file-F
	git checkout -f another-without-file-F
	git pull . one-branch-with-file-F

Because the second checkout leaves F from the previous state as
untracked file in the working tree, the merge would fail, trying
to protect F from being clobbered.

This changes "git checkout -f" to remove working tree files that
are known to git in the switched-from state but do not exist in
the switched-to state, borrowing the same logic from "reset --hard".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I am going to bed without trying this out since it is very
   late tonight.  Might be in "pu" or "next" tomorrow depending
   on my mood.  If this works out for Jeff, I can simply drop
   the "core.oktoclobber = ask" patch from my topics -- although
   I kind of liked that one ;-).

 git-checkout.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 564117f..77c2593 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -137,8 +137,7 @@ # what we already had
 
 if [ "$force" ]
 then
-    git-read-tree --reset $new &&
-	git-checkout-index -q -f -u -a
+    git-read-tree --reset -u $new
 else
     git-update-index --refresh >/dev/null
     merge_error=$(git-read-tree -m -u $old $new 2>&1) || (
-- 
1.4.0.g59268
