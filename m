From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 5/5] Enable ref log creation in git checkout -b.
Date: Fri, 19 May 2006 05:17:16 -0400
Message-ID: <20060519091716.GM22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 11:17:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh16p-0008Ry-Uq
	for gcvg-git@gmane.org; Fri, 19 May 2006 11:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWESJRU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 05:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWESJRU
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 05:17:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:26827 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751180AbWESJRT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 05:17:19 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fh16h-0005kW-62; Fri, 19 May 2006 05:17:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 70026212691; Fri, 19 May 2006 05:17:16 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20342>

Switch git checkout -b to use git-update-ref rather than echo and
a shell I/O redirection.  This is more in line with typical GIT
commands and allows -b to be logged according to the normal ref
logging rules.

Added -l option to allow users to create the ref log at the same
time as creating a branch.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---

 Documentation/git-checkout.txt |    7 ++++++-
 git-checkout.sh                |   19 +++++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

46409624159100ad958c3168b13e384168c12713
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 0951289..0643943 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,7 +8,7 @@ git-checkout - Checkout and switch to a 
 SYNOPSIS
 --------
 [verse]
-'git-checkout' [-f] [-b <new_branch>] [-m] [<branch>]
+'git-checkout' [-f] [-b <new_branch> [-l]] [-m] [<branch>]
 'git-checkout' [-m] [<branch>] <paths>...
 
 DESCRIPTION
@@ -37,6 +37,11 @@ OPTIONS
 -b::
 	Create a new branch and start it at <branch>.
 
+-l::
+	Create the new branch's ref log.  This activates recording of
+	all changes to made the branch ref, enabling use of date
+	based sha1 expressions such as "<branchname>@{yesterday}".
+
 -m::
 	If you have local modifications to one or more files that
 	are different between the current branch and the branch to
diff --git a/git-checkout.sh b/git-checkout.sh
index a11c939..360aabf 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -5,10 +5,13 @@ SUBDIRECTORY_OK=Sometimes
 . git-sh-setup
 
 old=$(git-rev-parse HEAD)
+old_name=HEAD
 new=
+new_name=
 force=
 branch=
 newbranch=
+newbranch_log=
 merge=
 while [ "$#" != "0" ]; do
     arg="$1"
@@ -24,6 +27,9 @@ while [ "$#" != "0" ]; do
 		git-check-ref-format "heads/$newbranch" ||
 			die "git checkout: we do not like '$newbranch' as a branch name."
 		;;
+	"-l")
+		newbranch_log=1
+		;;
 	"-f")
 		force=1
 		;;
@@ -44,6 +50,7 @@ while [ "$#" != "0" ]; do
 				exit 1
 			fi
 			new="$rev"
+			new_name="$arg^0"
 			if [ -f "$GIT_DIR/refs/heads/$arg" ]; then
 				branch="$arg"
 			fi
@@ -51,9 +58,11 @@ while [ "$#" != "0" ]; do
 		then
 			# checking out selected paths from a tree-ish.
 			new="$rev"
+			new_name="$arg^{tree}"
 			branch=
 		else
 			new=
+			new_name=
 			branch=
 			set x "$arg" "$@"
 			shift
@@ -114,7 +123,7 @@ then
 	cd "$cdup"
 fi
 
-[ -z "$new" ] && new=$old
+[ -z "$new" ] && new=$old && new_name="$old_name"
 
 # If we don't have an old branch that we're switching to,
 # and we don't have a new branch name for the target we
@@ -187,9 +196,11 @@ # be based on them, since we re-set the 
 #
 if [ "$?" -eq 0 ]; then
 	if [ "$newbranch" ]; then
-		leading=`expr "refs/heads/$newbranch" : '\(.*\)/'` &&
-		mkdir -p "$GIT_DIR/$leading" &&
-		echo $new >"$GIT_DIR/refs/heads/$newbranch" || exit
+		if [ "$newbranch_log" ]; then
+			mkdir -p $(dirname "$GIT_DIR/logs/refs/heads/$branchname")
+			touch "$GIT_DIR/logs/refs/heads/$branchname"
+		fi
+		git-update-ref -m "checkout: Created from $new_name" "refs/heads/$newbranch" $new || exit
 		branch="$newbranch"
 	fi
 	[ "$branch" ] &&
-- 
1.3.2.g7278
