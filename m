From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-branch: avoid getting confused by empty or nonexisting branches.
Date: Fri, 22 Jul 2005 19:08:47 -0700
Message-ID: <7vzmse6zps.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 04:09:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw9Rd-0008Aw-L3
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 04:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbVGWCIt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 22:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVGWCIt
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 22:08:49 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:58098 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262276AbVGWCIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 22:08:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050723020847.WUMC18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 22:08:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

When not specifying the start point explicitly, we ended up
emitting ^0 in addition to the default HEAD.  Be careful to see
if we have "$2" before finding out which commit to base the new
branch on.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-branch-script |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

baf3c4ffceae925d836f19382611968699414cd6
diff --git a/git-branch-script b/git-branch-script
--- a/git-branch-script
+++ b/git-branch-script
@@ -3,7 +3,13 @@
 . git-sh-setup-script || die "Not a git archive"
 
 branchname="$1"
-rev=$(git-rev-parse --verify --default HEAD "$2"^0) || exit
+case "$2" in
+'')
+	head=HEAD ;;
+*)
+	head="$2^0" ;;
+esac
+rev=$(git-rev-parse --revs-only --verify "$head") || exit
 
 [ -z "$branchname" ] && die "git branch: I want a branch name"
 [ -e "$GIT_DIR/refs/heads/$branchname" ] && die "$branchname already exists"
