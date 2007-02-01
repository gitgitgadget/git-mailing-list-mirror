From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: [PATCH] add --remote option to git-clone.
Date: Fri, 2 Feb 2007 00:01:22 +0200
Message-ID: <20070201220122.GF17617@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 23:01:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCjzJ-0007pc-JK
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 23:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbXBAWA6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 17:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbXBAWA6
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 17:00:58 -0500
Received: from p02c11o144.mxlogic.net ([208.65.145.67]:40963 "EHLO
	p02c11o144.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbXBAWA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 17:00:57 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o144.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 81362c54.2389511088.10310.00-017.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 01 Feb 2007 15:00:56 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 2 Feb 2007 00:02:56 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Fri,  2 Feb 2007 00:00:21 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 01 Feb 2007 22:02:56.0337 (UTC) FILETIME=[BA7A1410:01C7464C]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14972.000
X-TM-AS-Result: Yes-4.038400-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38413>

It is sometimes useful to track, and develop against, a single
topic branch from the remote repository.
Make this easier to do by adding a flag to git-clone.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

---

We have a repository with several long-lived topic branches.

I'm often annoyed by the fact that when I clone from this repository,
I get a copy of all topic branches and origin tracking master
by default, when I actually might only want to work on a different
topic. And getting all extra branches is annoying on a slow connection.

So here's the patch to only get a single branch on clone.
Other branches can be added later, on demand.

Junio, what do you think?
I would like very much for git to support this capability.

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 707376f..f66a969 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git-clone' [--template=<template_directory>] [-l [-s]] [-q] [-n] [--bare]
-	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth=<depth>] <repository> [<directory>]
+	  [-o <name>] [-u <upload-pack>] [--remote <remote-branch>]
+	  [--reference <repository>] [--depth=<depth>] <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -84,6 +84,10 @@ OPTIONS
 	Instead of using the remote name 'origin' to keep track
 	of the upstream repository, use <name> instead.
 
+--remote <remote-branch>::
+	When given, only the specified remote branch will be
+	tracked; if unset all remote branches are tracked.
+
 --upload-pack <upload-pack>::
 -u <upload-pack>::
 	When given, and the repository to clone from is handled
diff --git a/git-clone.sh b/git-clone.sh
index 4ddfa77..b0fe7d1 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -14,7 +14,7 @@ die() {
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] <repo> [<dir>]"
+	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--remote <remote-branch>] [--origin <name>] [--depth <n>] [-n] <repo> [<dir>]"
 }
 
 get_repo_base() {
@@ -78,6 +78,8 @@ reference=
 origin=
 origin_override=
 use_separate_remote=t
+remote_branch=
+all_remote_branches="--all"
 depth=
 while
 	case "$#,$1" in
@@ -104,6 +106,10 @@ while
 		shift; reference="$1" ;;
 	*,--reference=*)
 		reference=`expr "z$1" : 'z--reference=\(.*\)'` ;;
+	*,--remote)
+		remote_branch="$2"
+		all_remote_branches=
+	       	shift ;;
 	*,-o|*,--or|*,--ori|*,--orig|*,--origi|*,--origin)
 		case "$2" in
 		'')
@@ -227,7 +233,7 @@ yes,yes)
 	    echo "$repo/objects" >> "$GIT_DIR/objects/info/alternates"
 	    ;;
 	esac
-	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
+	git-ls-remote "$repo" $remote_branch >"$GIT_DIR/CLONE_HEAD" || exit 1
 	;;
 *)
 	case "$repo" in
@@ -261,7 +267,7 @@ yes,yes)
 		    done
 		    rm -f "$GIT_DIR/TMP_ALT"
 		fi
-		git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
+		git-ls-remote "$repo" $remote_branch >"$GIT_DIR/CLONE_HEAD" || exit 1
 		;;
 	https://*|http://*|ftp://*)
 		case "$depth" in
@@ -277,8 +283,8 @@ yes,yes)
 		;;
 	*)
 		case "$upload_pack" in
-		'') git-fetch-pack --all -k $quiet $depth "$repo" ;;
-		*) git-fetch-pack --all -k $quiet "$upload_pack" $depth "$repo" ;;
+		'') git-fetch-pack $all_remote_branches -k $quiet $depth "$repo" $remote_branch;;
+		*) git-fetch-pack $all_remote_branches -k $quiet "$upload_pack" $depth "$repo" $remote_branch;;
 		esac >"$GIT_DIR/CLONE_HEAD" ||
 			die "fetch-pack from '$repo' failed."
 		;;
@@ -304,6 +310,9 @@ then
 			continue ;;
 		HEAD)
 			destname="REMOTE_HEAD" ;;
+		refs/heads/$remote_branch)
+			git-update-ref -m "clone: from $repo" "REMOTE_HEAD" "$sha1" ""
+			destname="refs/$branch_top/${name#refs/heads/}" ;;
 		refs/heads/*)
 			destname="refs/$branch_top/${name#refs/heads/}" ;;
 		refs/tags/*)
@@ -334,25 +343,32 @@ then
 	esac
 
 	# The name under $remote_top the remote HEAD seems to point at.
-	head_points_at=$(
-		(
-			test -f "$GIT_DIR/$remote_top/master" && echo "master"
-			cd "$GIT_DIR/$remote_top" &&
-			find . -type f -print | sed -e 's/^\.\///'
-		) | (
-		done=f
-		while read name
-		do
-			test t = $done && continue
-			branch_tip=`cat "$GIT_DIR/$remote_top/$name"`
-			if test "$head_sha1" = "$branch_tip"
-			then
-				echo "$name"
-				done=t
-			fi
-		done
+	if
+		test $remote_branch
+	then
+		head_points_at=$remote_branch
+		head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
+	else
+		head_points_at=$(
+			(
+				test -f "$GIT_DIR/$remote_top/master" && echo "master"
+				cd "$GIT_DIR/$remote_top" &&
+				find . -type f -print | sed -e 's/^\.\///'
+			) | (
+			done=f
+			while read name
+			do
+				test t = $done && continue
+				branch_tip=`cat "$GIT_DIR/$remote_top/$name"`
+				if test "$head_sha1" = "$branch_tip"
+				then
+					echo "$name"
+					done=t
+				fi
+			done
+			)
 		)
-	)
+	fi
 
 	# Write out remote.$origin config, and update our "$head_points_at".
 	case "$head_points_at" in
@@ -368,11 +384,18 @@ then
 		git-config remote."$origin".url "$repo" &&
 
 		# Set up the mappings to track the remote branches.
-		git-config remote."$origin".fetch \
-			"+refs/heads/*:$remote_top/*" '^$' &&
-		rm -f "refs/remotes/$origin/HEAD"
-		git-symbolic-ref "refs/remotes/$origin/HEAD" \
-			"refs/remotes/$origin/$head_points_at" &&
+		(if
+			test $remote_branch
+		then
+			git-config remote."$origin".fetch \
+				"+refs/heads/$remote_branch:$remote_top/$remote_branch" '^$'
+		else
+			git-config remote."$origin".fetch \
+				"+refs/heads/*:$remote_top/*" '^$' &&
+			rm -f "refs/remotes/$origin/HEAD"
+			git-symbolic-ref "refs/remotes/$origin/HEAD" \
+				"refs/remotes/$origin/$head_points_at"
+		fi)
 
 		git-config branch."$head_points_at".remote "$origin" &&
 		git-config branch."$head_points_at".merge "refs/heads/$head_points_at"

-- 
MST
