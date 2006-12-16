X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-clone: lose the traditional 'no-separate-remote' layout
Date: Sat, 16 Dec 2006 01:53:10 -0800
Message-ID: <7virgci2ux.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<7vfybgjj7k.fsf@assigned-by-dhcp.cox.net>
	<7v3b7gji73.fsf@assigned-by-dhcp.cox.net>
	<7vvekci3ds.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 09:53:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vvekci3ds.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 16 Dec 2006 01:41:51 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34601>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvWEG-0003QP-Ei for gcvg-git@gmane.org; Sat, 16 Dec
 2006 10:53:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965389AbWLPJxM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 04:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965387AbWLPJxM
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 04:53:12 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39462 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965394AbWLPJxL (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 04:53:11 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216095310.VMXA9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Sat, 16
 Dec 2006 04:53:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id zMsW1V00A1kojtg0000000; Sat, 16 Dec 2006
 04:52:31 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Finally.

The separate-remote layout is so much more organized than
traditional and easier to work with especially when you need to
deal with remote repositories with multiple branches and/or you
need to deal with more than one remote repositories, and using
traditional layout for new repositories simply does not make
much sense.

Internally we still have code for 1:1 mappings to create a bare
clone; that is a good thing and will not go away.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
Junio C Hamano <junkio@cox.net> writes:

>  Next step will be to remove the traditional layout altogether.
>  With the recent flurry of UI updates, I think it is sane to do
>  that before v1.5.0; opinions?

 And this drops it; modulo bugs, I think this is about it for
 v1.5.0 around this area.

 Documentation/git-clone.txt |   15 +----------
 git-clone.sh                |   58 +++++++++----------------------------------
 2 files changed, 13 insertions(+), 60 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index bfddb21..874934a 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -11,8 +11,7 @@ SYNOPSIS
 [verse]
 'git-clone' [--template=<template_directory>] [-l [-s]] [-q] [-n] [--bare]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--use-separate-remote | --no-separate-remote] <repository>
-	  [<directory>]
+	  <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -99,18 +98,6 @@ OPTIONS
 	if unset the templates are taken from the installation
 	defined default, typically `/usr/share/git-core/templates`.
 
---use-separate-remote::
-	Save remotes heads under `$GIT_DIR/refs/remotes/origin/` instead
-	of `$GIT_DIR/refs/heads/`.  Only the local master branch is
-	saved in the latter. This is the default.
-
---no-separate-remote::
-	Save remotes heads in the same namespace as the local
-	heads, `$GIT_DIR/refs/heads/'.  In regular repositories,
-	this is a legacy setup git-clone created by default in
-	older Git versions, and will be removed before the next
-	major release.
-
 <repository>::
 	The (possibly remote) repository to clone from.  It can
 	be any URL git-fetch supports.
diff --git a/git-clone.sh b/git-clone.sh
index 68dc4f2..490f3e4 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -14,7 +14,7 @@ die() {
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--no-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
+	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
 }
 
 get_repo_base() {
@@ -137,11 +137,9 @@ while
 	*,--template=*)
 	  template="$1" ;;
 	*,-q|*,--quiet) quiet=-q ;;
-	*,--use-separate-remote)
-		# default
-		use_separate_remote=t ;;
+	*,--use-separate-remote) ;;
 	*,--no-separate-remote)
-		use_separate_remote= ;;
+		die "clones are always made with separate-remote layout" ;;
 	1,--reference) usage ;;
 	*,--reference)
 		shift; reference="$1" ;;
@@ -327,12 +325,8 @@ cd "$D" || exit
 
 if test -z "$bare" && test -f "$GIT_DIR/REMOTE_HEAD"
 then
-	# Figure out which remote branch HEAD points at.
-	case "$use_separate_remote" in
-	'')	remote_top=refs/heads ;;
-	*)	remote_top="refs/remotes/$origin" ;;
-	esac
-
+	# a non-bare repository is always in separate-remote layout
+	remote_top="refs/remotes/$origin"
 	head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
 	case "$head_sha1" in
 	'ref: refs/'*)
@@ -373,46 +367,18 @@ then
 		git-symbolic-ref HEAD "refs/heads/$head_points_at" &&
 
 		# Tracking branch for the primary branch at the remote.
-		case "$use_separate_remote" in
-		t)	origin_track="$remote_top/$head_points_at"
-			git-update-ref HEAD "$head_sha1" ;;
-		*)	origin_track="$remote_top/$origin"
-			git-update-ref "refs/heads/$origin" "$head_sha1" ;;
-		esac &&
+		origin_track="$remote_top/$head_points_at" &&
+		git-update-ref HEAD "$head_sha1" &&
 
 		# Upstream URL
 		git-repo-config remote."$origin".url "$repo" &&
 
 		# Set up the mappings to track the remote branches.
-		case "$use_separate_remote" in
-		t)
-			git-repo-config remote."$origin".fetch \
-				"refs/heads/*:$remote_top/*" '^$'
-			;;
-		*)
-			git-repo-config remote."$origin".fetch \
-				"refs/heads/$head_points_at:$origin_track" &&
-			(cd "$GIT_DIR/$remote_top" && find . -type f -print) |
-			while read dotslref
-			do
-				name=`expr "$dotslref" : './\(.*\)'`
-				if test "z$head_points_at" = "z$name" ||
-					test "z$origin" = "z$name"
-				then
-					continue
-				fi
-				git-repo-config remote."$origin".fetch \
-				"refs/heads/${name}:$remote_top/${name}" '^$'
-			done
-			;;
-		esac &&
-
-		case "$use_separate_remote" in
-		t)
-			rm -f "refs/remotes/$origin/HEAD"
-			git-symbolic-ref "refs/remotes/$origin/HEAD" \
-				"refs/remotes/$origin/$head_points_at"
-		esac &&
+		git-repo-config remote."$origin".fetch \
+			"refs/heads/*:$remote_top/*" '^$' &&
+		rm -f "refs/remotes/$origin/HEAD"
+		git-symbolic-ref "refs/remotes/$origin/HEAD" \
+			"refs/remotes/$origin/$head_points_at" &&
 
 		git-repo-config branch."$head_points_at".remote "$origin" &&
 		git-repo-config branch."$head_points_at".merge "refs/heads/$head_points_at"
