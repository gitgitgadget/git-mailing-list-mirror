From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] git-clone: define die() and use it.
Date: Fri, 20 Oct 2006 23:38:31 +0400
Message-ID: <20061020193831.GA24237@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 20 21:38:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb0CX-0005vG-CC
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 21:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992719AbWJTTii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 15:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422823AbWJTTii
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 15:38:38 -0400
Received: from mh.altlinux.org ([217.16.24.5]:52112 "EHLO mh.altlinux.org")
	by vger.kernel.org with ESMTP id S1422748AbWJTTih (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 15:38:37 -0400
Received: from nomad.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by mh.altlinux.org (Postfix) with ESMTP
	id B92F4382CE49; Fri, 20 Oct 2006 23:38:31 +0400 (MSD)
Received: by nomad.office.altlinux.org (Postfix, from userid 501)
	id 6368817102; Fri, 20 Oct 2006 23:38:31 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29529>

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 git-clone.sh |   61 +++++++++++++++++++++++-----------------------------------
 1 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index bf54a11..786d65a 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -8,11 +8,15 @@ # Clone a repository into a different di
 # See git-sh-setup why.
 unset CDPATH
 
-usage() {
-	echo >&2 "Usage: $0 [--template=<template_directory>] [--use-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
+die() {
+	echo >&2 "$@"
 	exit 1
 }
 
+usage() {
+	die "Usage: $0 [--template=<template_directory>] [--use-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
+}
+
 get_repo_base() {
 	(cd "$1" && (cd .git ; pwd)) 2> /dev/null
 }
@@ -35,11 +39,9 @@ clone_dumb_http () {
 		"`git-repo-config --bool http.noEPSV`" = true ]; then
 		curl_extra_args="${curl_extra_args} --disable-epsv"
 	fi
-	http_fetch "$1/info/refs" "$clone_tmp/refs" || {
-		echo >&2 "Cannot get remote repository information.
+	http_fetch "$1/info/refs" "$clone_tmp/refs" ||
+		die "Cannot get remote repository information.
 Perhaps git-update-server-info needs to be run there?"
-		exit 1;
-	}
 	while read sha1 refname
 	do
 		name=`expr "z$refname" : 'zrefs/\(.*\)'` &&
@@ -143,17 +145,12 @@ while
 		'')
 		    usage ;;
 		*/*)
-		    echo >&2 "'$2' is not suitable for an origin name"
-		    exit 1
+		    die "'$2' is not suitable for an origin name"
 		esac
-		git-check-ref-format "heads/$2" || {
-		    echo >&2 "'$2' is not suitable for a branch name"
-		    exit 1
-		}
-		test -z "$origin_override" || {
-		    echo >&2 "Do not give more than one --origin options."
-		    exit 1
-		}
+		git-check-ref-format "heads/$2" ||
+		    die "'$2' is not suitable for a branch name"
+		test -z "$origin_override" ||
+		    die "Do not give more than one --origin options."
 		origin_override=yes
 		origin="$2"; shift
 		;;
@@ -169,24 +166,19 @@ do
 done
 
 repo="$1"
-if test -z "$repo"
-then
-    echo >&2 'you must specify a repository to clone.'
-    exit 1
-fi
+test -n "$repo" ||
+    die 'you must specify a repository to clone.'
 
 # --bare implies --no-checkout
 if test yes = "$bare"
 then
 	if test yes = "$origin_override"
 	then
-		echo >&2 '--bare and --origin $origin options are incompatible.'
-		exit 1
+		die '--bare and --origin $origin options are incompatible.'
 	fi
 	if test t = "$use_separate_remote"
 	then
-		echo >&2 '--bare and --use-separate-remote options are incompatible.'
-		exit 1
+		die '--bare and --use-separate-remote options are incompatible.'
 	fi
 	no_checkout=yes
 fi
@@ -206,7 +198,7 @@ fi
 dir="$2"
 # Try using "humanish" part of source repo if user didn't specify one
 [ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
-[ -e "$dir" ] && echo "$dir already exists." && usage
+[ -e "$dir" ] && die "destination directory '$dir' already exists."
 mkdir -p "$dir" &&
 D=$(cd "$dir" && pwd) &&
 trap 'err=$?; cd ..; rm -rf "$D"; exit $err' 0
@@ -233,7 +225,7 @@ then
 		 cd reference-tmp &&
 		 tar xf -)
 	else
-		echo >&2 "$reference: not a local directory." && usage
+		die "reference repository '$reference' is not a local directory."
 	fi
 fi
 
@@ -242,10 +234,8 @@ rm -f "$GIT_DIR/CLONE_HEAD"
 # We do local magic only when the user tells us to.
 case "$local,$use_local" in
 yes,yes)
-	( cd "$repo/objects" ) || {
-		echo >&2 "-l flag seen but $repo is not local."
-		exit 1
-	}
+	( cd "$repo/objects" ) ||
+		die "-l flag seen but repository '$repo' is not local."
 
 	case "$local_shared" in
 	no)
@@ -307,18 +297,15 @@ yes,yes)
 		then
 			clone_dumb_http "$repo" "$D"
 		else
-			echo >&2 "http transport not supported, rebuild Git with curl support"
-			exit 1
+			die "http transport not supported, rebuild Git with curl support"
 		fi
 		;;
 	*)
 		case "$upload_pack" in
 		'') git-fetch-pack --all -k $quiet "$repo" ;;
 		*) git-fetch-pack --all -k $quiet "$upload_pack" "$repo" ;;
-		esac >"$GIT_DIR/CLONE_HEAD" || {
-			echo >&2 "fetch-pack from '$repo' failed."
-			exit 1
-		}
+		esac >"$GIT_DIR/CLONE_HEAD" ||
+			die "fetch-pack from '$repo' failed."
 		;;
 	esac
 	;;
-- 
1.4.3.GIT
