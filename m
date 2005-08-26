From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Show the branch name more prominently in "git status".
Date: Fri, 26 Aug 2005 01:02:46 -0700
Message-ID: <7vr7chgm6x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 26 10:35:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8ZAs-0001zr-MH
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 10:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965050AbVHZICt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 04:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbVHZICt
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 04:02:49 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:14214 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965050AbVHZICs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 04:02:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050826080248.WISE17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 04:02:48 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7782>

When not working on "master" branch, remind the user at the beginning
of the status message, not at the end.

Adjust git-revert-script for this change as well.  The way it detected
a clean working tree was depending on the git status behaviour too much.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-revert-script |   10 ++++++----
 git-status-script |   12 ++++++------
 2 files changed, 12 insertions(+), 10 deletions(-)

0f60ee0f83468393fb3bca2b5e4c8e78a8896cf5
diff --git a/git-revert-script b/git-revert-script
--- a/git-revert-script
+++ b/git-revert-script
@@ -2,11 +2,13 @@
 . git-sh-setup-script || die "Not a git archive"
 
 # We want a clean tree and clean index to be able to revert.
-status=$(git status)
-case "$status" in
-'nothing to commit') ;;
+dirty=`git-diff-cache --name-only --cached HEAD`
+case "$dirty" in '') dirty=`git-diff-cache --name-only HEAD` ;; esac
+case "$dirty" in
+'') ;;
 *)
-	echo "$status"
+	echo >&2 "Modified:"
+	echo "$dirty" | sed >&2 -e 's/^/	/'
 	die "Your working tree is dirty; cannot revert a previous patch." ;;
 esac
 
diff --git a/git-status-script b/git-status-script
--- a/git-status-script
+++ b/git-status-script
@@ -28,6 +28,12 @@ report () {
   [ "$header" ]
 }
 
+branch=`readlink "$GIT_DIR/HEAD"`
+case "$branch" in
+refs/heads/master) ;;
+*)	echo "#
+# On branch $branch" ;;
+esac
 git-update-cache --refresh >/dev/null 2>&1
 git-diff-cache -M --cached HEAD | sed 's/^://' | report "Updated but not checked in" "will commit"
 committable="$?"
@@ -37,10 +43,4 @@ then
 	echo "nothing to commit"
 	exit 1
 fi
-branch=`readlink "$GIT_DIR/HEAD"`
-case "$branch" in
-refs/heads/master) ;;
-*)	echo "#
-# On branch $branch" ;;
-esac
 exit 0
