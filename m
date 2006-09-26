From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] update a few Porcelain-ish for ref lock safety.
Date: Tue, 26 Sep 2006 11:05:08 -0700
Message-ID: <7vu02uqzaj.fsf@assigned-by-dhcp.cox.net>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
	<200609231322.30214.chriscool@tuxfamily.org>
	<7veju2nthl.fsf@assigned-by-dhcp.cox.net>
	<200609240645.54467.chriscool@tuxfamily.org>
	<7vmz8o1em0.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 26 20:06:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSHIy-0002TY-8q
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 20:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWIZSFM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 14:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWIZSFL
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 14:05:11 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41397 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932363AbWIZSFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 14:05:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926180508.CWTM18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Sep 2006 14:05:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id T65A1V00z1kojtg0000000
	Tue, 26 Sep 2006 14:05:11 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27805>

This updates the use of git-update-ref in git-branch, git-tag
and git-commit to make them safer in a few corner cases as
demonstration.

 - git-tag makes sure that the named tag does not exist, allows
   you to edit tag message and then creates the tag.  If a tag
   with the same name was created by somebody else in the
   meantime, it used to happily overwrote it.  Now it notices
   the situation.

 - git-branch -d and git-commit (for the initial commit) had the
   same issue but with smaller race window, which is plugged
   with this.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Obviously I would need to update this on top of Linus's
   packed-refs, but this 3-patch series applies on top of the
   current "master". 

 git-branch.sh |    9 ++++++---
 git-commit.sh |    2 +-
 git-tag.sh    |    9 ++++++---
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/git-branch.sh b/git-branch.sh
index e0501ec..2b58d20 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -42,8 +42,7 @@ If you are sure you want to delete it, r
 	    esac
 	    ;;
 	esac
-	rm -f "$GIT_DIR/logs/refs/heads/$branch_name"
-	rm -f "$GIT_DIR/refs/heads/$branch_name"
+	git update-ref -d "refs/heads/$branch_name" "$branch"
 	echo "Deleted branch $branch_name."
     done
     exit 0
@@ -112,6 +111,7 @@ rev=$(git-rev-parse --verify "$head") ||
 git-check-ref-format "heads/$branchname" ||
 	die "we do not like '$branchname' as a branch name."
 
+prev=0000000000000000000000000000000000000000
 if [ -e "$GIT_DIR/refs/heads/$branchname" ]
 then
 	if test '' = "$force"
@@ -121,10 +121,13 @@ then
 	then
 		die "cannot force-update the current branch."
 	fi
+	prev=`git rev-parse --verify "refs/heads/$branchname"`
 fi
 if test "$create_log" = 'yes'
 then
 	mkdir -p $(dirname "$GIT_DIR/logs/refs/heads/$branchname")
 	touch "$GIT_DIR/logs/refs/heads/$branchname"
 fi
-git update-ref -m "branch: Created from $head" "refs/heads/$branchname" $rev
+git update-ref -m "branch: Created from $head" \
+	"refs/heads/$branchname" $rev $prev
+
diff --git a/git-commit.sh b/git-commit.sh
index 5a4c659..87b13ef 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -554,8 +554,8 @@ else
 		exit 1
 	fi
 	PARENTS=""
-	current=
 	rloga='commit (initial)'
+	current=0000000000000000000000000000000000000000
 fi
 
 if test -z "$no_edit"
diff --git a/git-tag.sh b/git-tag.sh
index a0afa25..2bde3c0 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -63,8 +63,11 @@ done
 
 name="$1"
 [ "$name" ] || usage
-if [ -e "$GIT_DIR/refs/tags/$name" -a -z "$force" ]; then
-    die "tag '$name' already exists"
+prev=0000000000000000000000000000000000000000
+if test -e "$GIT_DIR/refs/tags/$name"
+then
+    test -n "$force" || die "tag '$name' already exists"
+    prev=`git rev-parse "refs/tags/$name"`
 fi
 shift
 git-check-ref-format "tags/$name" ||
@@ -109,4 +112,4 @@ fi
 
 leading=`expr "refs/tags/$name" : '\(.*\)/'` &&
 mkdir -p "$GIT_DIR/$leading" &&
-echo $object > "$GIT_DIR/refs/tags/$name"
+GIT_DIR="$GIT_DIR" git update-ref "refs/tags/$name" "$object" "$prev"
-- 
1.4.2.1.g7a39b
