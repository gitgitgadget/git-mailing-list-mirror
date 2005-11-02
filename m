From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-clone: do not forget to create origin branch.
Date: Tue, 01 Nov 2005 22:20:56 -0800
Message-ID: <7v8xw71sfr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 02 07:21:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXBzd-00086U-5o
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 07:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVKBGU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 01:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbVKBGU6
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 01:20:58 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64411 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932370AbVKBGU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 01:20:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102062006.MGBS2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 01:20:06 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11001>

The newly cloned repository by default had .git/remotes/origin
set up to track the remote master to origin, but forgot to
create the origin branch ourselves.  Also it hardcoded the
assumption that the remote HEAD points at "master", which may
not always be true.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * Objections?

 git-clone.sh |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

applies-to: 9c030fed625268c19d7f0838b26f742745b36085
e125c1a717bb732319596d8b792a67c2b7b15ef7
diff --git a/git-clone.sh b/git-clone.sh
index 18e692a..c27a913 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -196,10 +196,17 @@ cd $D || exit
 
 if test -f ".git/HEAD"
 then
-	mkdir -p .git/remotes || exit
-	echo >.git/remotes/origin \
-	"URL: $repo
-Pull: master:origin"
+	head_points_at=`git-symbolic-ref HEAD`
+	case "$head_points_at" in
+	refs/heads/*)
+		head_points_at=`expr "$head_points_at" : 'refs/heads/\(.*\)'`
+		mkdir -p .git/remotes &&
+		echo >.git/remotes/origin \
+		"URL: $repo
+Pull: $head_points_at:origin"
+		cp ".git/refs/heads/$head_points_at" .git/refs/heads/origin
+	esac
+
 	case "$no_checkout" in
 	'')
 		git checkout
---
0.99.9.GIT
