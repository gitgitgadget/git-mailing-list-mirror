From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] checkout -d: explicitly detach HEAD even when switching to the tip of a branch
Date: Thu, 29 Mar 2007 01:02:50 -0700
Message-ID: <7vr6r879zp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 10:03:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWpb7-0001vV-Bc
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 10:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933591AbXC2IDB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 04:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933993AbXC2IDB
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 04:03:01 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61783 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933591AbXC2IC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 04:02:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329080250.QPWO27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 29 Mar 2007 04:02:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gY2q1W00J1kojtg0000000; Thu, 29 Mar 2007 04:02:51 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43410>

You cannot currently checkout the tip of an existing branch
without moving to the branch.

This allows you to detach your HEAD and place it at such a
commit, with:

    $ git checkout -d master

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-checkout.txt |    6 +++-
 git-checkout.sh                |   18 +++++++++--
 t/t7201-co.sh                  |   63 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index f5b2d50..d00eeaa 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,7 +8,7 @@ git-checkout - Checkout and switch to a branch
 SYNOPSIS
 --------
 [verse]
-'git-checkout' [-q] [-f] [-b [--track | --no-track] <new_branch> [-l]] [-m] [<branch>]
+'git-checkout' [-q] [-f] [-b [--track | --no-track] <new_branch> [-l] | -d] [-m] [<branch>]
 'git-checkout' [<tree-ish>] <paths>...
 
 DESCRIPTION
@@ -61,6 +61,10 @@ OPTIONS
 	all changes to made the branch ref, enabling use of date
 	based sha1 expressions such as "<branchname>@{yesterday}".
 
+-d::
+	Explicitly ask to detach HEAD, even when named revision
+	to switch to is at the tip of a branch.
+
 -m::
 	If you have local modifications to one or more files that
 	are different between the current branch and the branch to
diff --git a/git-checkout.sh b/git-checkout.sh
index a7390e8..e551443 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[-q] [-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
+USAGE='[-q] [-f] [-b <new_branch> | -d] [-m] [<branch>] [<paths>...]'
 SUBDIRECTORY_OK=Sometimes
 . git-sh-setup
 require_work_tree
@@ -17,6 +17,7 @@ newbranch=
 newbranch_log=
 merge=
 quiet=
+explicit_detach=
 LF='
 '
 while [ "$#" != "0" ]; do
@@ -39,6 +40,9 @@ while [ "$#" != "0" ]; do
 	"--track"|"--no-track")
 		track="$arg"
 		;;
+	-d)
+		explicit_detach=1
+		;;
 	"-f")
 		force=1
 		;;
@@ -94,6 +98,11 @@ case "$newbranch,$track" in
 	die "git checkout: --track and --no-track require -b"
 esac
 
+case "$newbranch$explicit_detach" in
+11)
+	die "git checkout: -d and -b are incompatible"
+esac
+
 case "$force$merge" in
 11)
 	die "git checkout: -f and -m are incompatible"
@@ -117,7 +126,7 @@ then
 		hint="
 Did you intend to checkout '$@' which can not be resolved as commit?"
 	fi
-	if test '' != "$newbranch$force$merge"
+	if test '' != "$newbranch$force$merge$explicit_detach"
 	then
 		die "git checkout: updating paths is incompatible with switching branches/forcing$hint"
 	fi
@@ -170,7 +179,8 @@ describe_detached_head () {
 	}
 }
 
-if test -z "$branch$newbranch" && test "$new" != "$old"
+if test -z "$branch$newbranch" && test "$new" != "$old" ||
+   test -n "$explicit_detach"
 then
 	detached="$new"
 	if test -n "$oldbranch" && test -z "$quiet"
@@ -254,7 +264,7 @@ if [ "$?" -eq 0 ]; then
 		git-branch $track $newbranch_log "$newbranch" "$new_name" || exit
 		branch="$newbranch"
 	fi
-	if test -n "$branch"
+	if test -n "$branch" && test -z "$explicit_detach"
 	then
 		GIT_DIR="$GIT_DIR" git-symbolic-ref -m "checkout: moving to $branch" HEAD "refs/heads/$branch"
 		if test -n "$quiet"
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 867bbd2..caa04f9 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -3,7 +3,20 @@
 # Copyright (c) 2006 Junio C Hamano
 #
 
-test_description='git-checkout tests.'
+test_description='git-checkout tests.
+
+Creates master, forks renamer and side branches from it.
+Test switching across them.
+
+  ! [master] Initial A one, A two
+   * [renamer] Renamer R one->uno, M two
+    ! [side] Side M one, D two, A three
+  ---
+    + [side] Side M one, D two, A three
+   *  [renamer] Renamer R one->uno, M two
+  +*+ [master] Initial A one, A two
+
+'
 
 . ./test-lib.sh
 
@@ -129,4 +142,52 @@ test_expect_success 'checkout -m with merge conflict' '
 	! test -s current
 '
 
+test_expect_success 'checkout to detach HEAD' '
+
+	git checkout -f renamer && git clean &&
+	git checkout renamer^ &&
+	H=$(git rev-parse --verify HEAD) &&
+	M=$(git show-ref -s --verify refs/heads/master) &&
+	test "z$H" = "z$M" &&
+	if git symbolic-ref HEAD >/dev/null 2>&1
+	then
+		echo "OOPS, HEAD is still symbolic???"
+		false
+	else
+		: happy
+	fi
+'
+
+test_expect_success 'checkout to detach HEAD with explicit -d' '
+
+	git checkout -f master && git clean &&
+	git checkout -d renamer^ &&
+	H=$(git rev-parse --verify HEAD) &&
+	M=$(git show-ref -s --verify refs/heads/master) &&
+	test "z$H" = "z$M" &&
+	if git symbolic-ref HEAD >/dev/null 2>&1
+	then
+		echo "OOPS, HEAD is still symbolic???"
+		false
+	else
+		: happy
+	fi
+'
+
+test_expect_success 'checkout to detach HEAD with explicit -d' '
+
+	git checkout -f master && git clean &&
+	git checkout -d &&
+	H=$(git rev-parse --verify HEAD) &&
+	M=$(git show-ref -s --verify refs/heads/master) &&
+	test "z$H" = "z$M" &&
+	if git symbolic-ref HEAD >/dev/null 2>&1
+	then
+		echo "OOPS, HEAD is still symbolic???"
+		false
+	else
+		: happy
+	fi
+'
+
 test_done
-- 
1.5.1.rc3.1.ga429d
