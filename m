From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-branch -d <branch>: delete unused branch.
Date: Wed, 14 Sep 2005 01:46:50 -0700
Message-ID: <7vvf14ox39.fsf@assigned-by-dhcp.cox.net>
References: <4326F2AE.50108@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 10:48:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFSuy-00087q-Ob
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 10:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVINIq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 04:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbVINIq6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 04:46:58 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:64664 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965077AbVINIq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 04:46:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914084651.OKUF7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 04:46:51 -0400
To: Chuck Lever <cel@citi.umich.edu>
In-Reply-To: <4326F2AE.50108@citi.umich.edu> (Chuck Lever's message of "Tue,
	13 Sep 2005 11:39:26 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8514>

The new flag '-d' lets you delete a branch.  For safety, it does not
lets you delete the branch you are currently on, nor a branch that
has been fully merged into your current branch.

The credit for the safety check idea goes to Daniel Barkalow.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-branch.sh |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 54 insertions(+), 6 deletions(-)

6a714989f83ccb93188dc37791da8a0f2e32cabe
diff --git a/git-branch.sh b/git-branch.sh
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -3,7 +3,7 @@
 . git-sh-setup || die "Not a git archive"
 
 usage () {
-    echo >&2 "usage: $(basename $0)"' [<branchname> [start-point]]
+    echo >&2 "usage: $(basename $0)"' [-d <branch>] | [<branch> [start-point]]
 
 If no arguments, show available branches and mark current branch with a star.
 If one argument, create a new branch <branchname> based off of current HEAD.
@@ -12,6 +12,59 @@ If two arguments, create a new branch <b
     exit 1
 }
 
+delete_branch () {
+    option="$1" branch_name="$2"
+    headref=$(readlink "$GIT_DIR/HEAD" | sed -e 's|^refs/heads/||')
+    case ",$headref," in
+    ",$branch_name,")
+	die "Cannot delete the branch you are on." ;;
+    ,,)
+	die "What branch are you on anyway?" ;;
+    esac
+    branch=$(cat "$GIT_DIR/refs/heads/$branch_name") &&
+	branch=$(git-rev-parse --verify "$branch^0") ||
+	    die "Seriously, what branch are you talking about?"
+    case "$option" in
+    -D)
+	;;
+    *)
+	mbs=$(git-merge-base -a "$branch" HEAD | tr '\012' ' ')
+	case " $mbs " in
+	*' '$branch' '*)
+	    # the merge base of branch and HEAD contains branch --
+	    # which means that the HEAD contains everything in the HEAD.
+	    ;;
+	*)
+	    echo >&2 "The branch '$branch_name' is not a strict subset of your current HEAD.
+If you are sure you want to delete it, run 'git branch -D $branch_name'."
+	    exit 1
+	    ;;
+	esac
+	;;
+    esac
+    rm -f "$GIT_DIR/refs/heads/$branch_name"
+    echo "Deleted branch $branch_name."
+    exit 0
+}
+
+while case "$#,$1" in 0,*) break ;; *,-*) ;; *) break ;; esac
+do
+	case "$1" in
+	-d | -D)
+		delete_branch "$1" "$2"
+		exit
+		;;
+	--)
+		shift
+		break
+		;;
+	-*)
+		usage
+		;;
+	esac
+	shift
+done
+
 case "$#" in
 0)
 	headref=$(readlink "$GIT_DIR/HEAD" | sed -e 's|^refs/heads/||')
@@ -36,11 +89,6 @@ case "$#" in
 esac
 branchname="$1"
 
-case "$branchname" in
--*)
-	usage;;
-esac
-
 rev=$(git-rev-parse --verify "$head") || exit
 
 [ -e "$GIT_DIR/refs/heads/$branchname" ] && die "$branchname already exists"
