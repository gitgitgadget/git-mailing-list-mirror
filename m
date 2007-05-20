From: skimo@liacs.nl
Subject: [PATCH 2/3] git-clone: rely on git-fetch for fetching for most protocols
Date: Sun, 20 May 2007 19:57:44 +0200
Message-ID: <11796838662238-git-send-email-skimo@liacs.nl>
References: <1179683865547-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 19:58:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HppfX-000640-17
	for gcvg-git@gmane.org; Sun, 20 May 2007 19:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571AbXETR56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 13:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756856AbXETR54
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 13:57:56 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37075 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756833AbXETR5z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 13:57:55 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KHvku2007624;
	Sun, 20 May 2007 19:57:51 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 4FF6F7DDA1; Sun, 20 May 2007 19:57:46 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <1179683865547-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47860>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 git-clone.sh |   20 ++++++++++++--------
 git-fetch.sh |   28 ++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index fdd354f..823b973 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -159,6 +159,11 @@ then
 	no_checkout=yes
 	use_separate_remote=
 fi
+if test t = "$use_separate_remote"; then
+	separate_remote_flag="--use-separate-remote"
+else
+	separate_remote_flag="--no-separate-remote"
+fi
 
 if test -z "$origin"
 then
@@ -219,6 +224,10 @@ then
 	fi
 fi
 
+# Write out $origin URL
+GIT_CONFIG="$GIT_DIR/config"
+git-config remote."$origin".url "$repo" || exit
+
 rm -f "$GIT_DIR/CLONE_HEAD"
 
 # We do local magic only when the user tells us to.
@@ -299,11 +308,9 @@ yes,yes)
 		fi
 		;;
 	*)
-		case "$upload_pack" in
-		'') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
-		*) git-fetch-pack --all -k $quiet "$upload_pack" $depth $no_progress "$repo" ;;
-		esac >"$GIT_DIR/CLONE_HEAD" ||
-			die "fetch-pack from '$repo' failed."
+		git-fetch --all -k $quiet  ${upload_pack:+"$upload_pack"} $depth \
+			$separate_remote_flag "$origin" ||
+			die "fetch from '$repo' failed."
 		;;
 	esac
 	;;
@@ -387,9 +394,6 @@ then
 		origin_track="$remote_top/$head_points_at" &&
 		git-update-ref HEAD "$head_sha1" &&
 
-		# Upstream URL
-		git-config remote."$origin".url "$repo" &&
-
 		# Set up the mappings to track the remote branches.
 		git-config remote."$origin".fetch \
 			"+refs/heads/*:$remote_top/*" '^$' &&
diff --git a/git-fetch.sh b/git-fetch.sh
index 0e05cf1..dcb6985 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -15,6 +15,7 @@ LF='
 '
 IFS="$LF"
 
+all=
 no_tags=
 tags=
 append=
@@ -25,6 +26,7 @@ exec=
 keep=
 shallow_depth=
 no_progress=
+use_separate_remote=
 test -t 1 || no_progress=--no-progress
 quiet=
 while case "$#" in 0) break ;; esac
@@ -33,6 +35,9 @@ do
 	-a|--a|--ap|--app|--appe|--appen|--append)
 		append=t
 		;;
+	--al|--all)
+		all=--all
+		;;
 	--upl|--uplo|--uploa|--upload|--upload-|--upload-p|\
 	--upload-pa|--upload-pac|--upload-pack)
 		shift
@@ -63,6 +68,12 @@ do
 	-v|--verbose)
 		verbose=Yes
 		;;
+	--use-separate-remote)
+		use_separate_remote="--use-separate-remote"
+		;;
+	--no-separate-remote)
+		use_separate_remote="--no-separate-remote"
+		;;
 	-k|--k|--ke|--kee|--keep)
 		keep='-k -k'
 		;;
@@ -141,7 +152,9 @@ esac
 # branches file, and just fetch those and refspecs explicitly given.
 # Otherwise we do what we always did.
 
-reflist=$(get_remote_refs_for_fetch "$@")
+if test -z "$all"; then
+	reflist=$(get_remote_refs_for_fetch "$@")
+fi
 if test "$tags"
 then
 	taglist=`IFS='	' &&
@@ -163,8 +176,10 @@ fi
 
 fetch_all_at_once () {
 
-  eval=$(echo "$1" | git-fetch--tool parse-reflist "-")
-  eval "$eval"
+    if test -z "$all"; then
+	eval=$(echo "$1" | git-fetch--tool parse-reflist "-")
+	eval "$eval"
+    fi
 
     ( : subshell because we muck with IFS
       IFS=" 	$LF"
@@ -177,7 +192,8 @@ fetch_all_at_once () {
 	    git-bundle unbundle "$remote" $rref ||
 	    echo failed "$remote"
 	else
-		if	test -d "$remote" &&
+		if	test -z "$all" &&
+			test -d "$remote" &&
 
 			# The remote might be our alternate.  With
 			# this optimization we will bypass fetch-pack
@@ -201,7 +217,7 @@ fetch_all_at_once () {
 			echo "$ls_remote_result" | \
 				git-fetch--tool pick-rref "$rref" "-"
 		else
-			git-fetch-pack --thin $exec $keep $shallow_depth \
+			git-fetch-pack --thin $all $exec $keep $shallow_depth \
 				$quiet $no_progress "$remote" $rref ||
 			echo failed "$remote"
 		fi
@@ -212,7 +228,7 @@ fetch_all_at_once () {
 	test -n "$verbose" && flags="$flags -v"
 	test -n "$force" && flags="$flags -f"
 	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION" \
-		git-fetch--tool $flags native-store \
+		git-fetch--tool $flags $all $use_separate_remote native-store \
 			"$remote" "$remote_nick" "$refs"
       )
     ) || exit
-- 
1.5.1.5.g8fc2
