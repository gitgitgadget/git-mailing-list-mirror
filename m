From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH 4/5] Create/delete branch ref logs.
Date: Fri, 19 May 2006 05:16:58 -0400
Message-ID: <20060519091658.GL22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 11:17:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh16Z-0008OO-AA
	for gcvg-git@gmane.org; Fri, 19 May 2006 11:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWESJRE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 05:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWESJRE
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 05:17:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:24523 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751202AbWESJRC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 05:17:02 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fh16P-0005jf-Ix; Fri, 19 May 2006 05:16:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D089F212691; Fri, 19 May 2006 05:16:58 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20341>

When crating a new branch offer '-l' as a way for the user to
quickly enable ref logging for the new branch.

When deleting a branch also delete its ref log.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---
 This was discussed on #git earlier today and was thought to be a
 useful feature.  :-)

 Documentation/git-branch.txt |   10 ++++++++--
 git-branch.sh                |   12 +++++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

e4fb59c8b73009e3bcae71bfb7edd7de2c648117
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 72fb2f8..a7bec3c 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-branch' [-r]
-'git-branch' [-f] <branchname> [<start-point>]
+'git-branch' [-l] [-f] <branchname> [<start-point>]
 'git-branch' (-d | -D) <branchname>...
 
 DESCRIPTION
@@ -23,7 +23,8 @@ If no <start-point> is given, the branch
 equal to that of the currently checked out branch.
 
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
-specify more than one branch for deletion.
+specify more than one branch for deletion.  If the branch currently
+has a ref log then the ref log will also be deleted.
 
 
 OPTIONS
@@ -34,6 +35,11 @@ OPTIONS
 -D::
 	Delete a branch irrespective of its index status.
 
+-l::
+	Create the branch's ref log.  This activates recording of
+	all changes to made the branch ref, enabling use of date
+	based sha1 expressions such as "<branchname>@{yesterday}".
+
 -f::
 	Force the creation of a new branch even if it means deleting
 	a branch that already exists with the same name.
diff --git a/git-branch.sh b/git-branch.sh
index d1e3730..e0501ec 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]] | -r'
+USAGE='[-l] [(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]] | -r'
 LONG_USAGE='If no arguments, show available branches and mark current branch with a star.
 If one argument, create a new branch <branchname> based off of current HEAD.
 If two arguments, create a new branch <branchname> based off of <start-point>.'
@@ -42,6 +42,7 @@ If you are sure you want to delete it, r
 	    esac
 	    ;;
 	esac
+	rm -f "$GIT_DIR/logs/refs/heads/$branch_name"
 	rm -f "$GIT_DIR/refs/heads/$branch_name"
 	echo "Deleted branch $branch_name."
     done
@@ -55,6 +56,7 @@ ls_remote_branches () {
 }
 
 force=
+create_log=
 while case "$#,$1" in 0,*) break ;; *,-*) ;; *) break ;; esac
 do
 	case "$1" in
@@ -69,6 +71,9 @@ do
 	-f)
 		force="$1"
 		;;
+	-l)
+		create_log="yes"
+		;;
 	--)
 		shift
 		break
@@ -117,4 +122,9 @@ then
 		die "cannot force-update the current branch."
 	fi
 fi
+if test "$create_log" = 'yes'
+then
+	mkdir -p $(dirname "$GIT_DIR/logs/refs/heads/$branchname")
+	touch "$GIT_DIR/logs/refs/heads/$branchname"
+fi
 git update-ref -m "branch: Created from $head" "refs/heads/$branchname" $rev
-- 
1.3.2.g7278
