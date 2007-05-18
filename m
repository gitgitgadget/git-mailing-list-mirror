From: skimo@liacs.nl
Subject: [PATCH 16/16] git-clone: add --submodules for cloning submodules
Date: Fri, 18 May 2007 21:25:05 +0200
Message-ID: <11795163073175-git-send-email-skimo@liacs.nl>
References: <11795163053812-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 21:26:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp85f-0002Yo-Nj
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758439AbXERTZl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757816AbXERTZk
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:25:40 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:55769 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757909AbXERTZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 15:25:26 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4IJPIKQ005221;
	Fri, 18 May 2007 21:25:23 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id D9EC37DDAF; Fri, 18 May 2007 21:25:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11795163053812-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47650>

From: Sven Verdoolaege <skimo@kotnet.org>

When the --submodules option is specified, git-clone will search
for submodule.<submodule>.url options in the remote configuration
and clone each submodule using the first url that it can use from
the local site.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 Documentation/config.txt    |    7 +++
 Documentation/git-clone.txt |    6 ++-
 git-clone.sh                |   18 +++++++-
 git-fetch.sh                |   90 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ee1c35e..cee9e40 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -256,6 +256,10 @@ You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.submodules
+	If true, gitlink:git-checkout[1] also checks out submodules.
+	False by default.
+
 alias.*::
 	Command aliases for the gitlink:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
@@ -606,6 +610,9 @@ showbranch.default::
 	The default set of branches for gitlink:git-show-branch[1].
 	See gitlink:git-show-branch[1].
 
+submodule.<submodule>.url
+	The URL of a submodule.  See gitlink:git-clone[1].
+
 tar.umask::
 	By default, gitlink:git-tar-tree[1] sets file and directories modes
 	to 0666 or 0777. While this is both useful and acceptable for projects
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 644bf12..565155b 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-clone' [--template=<template_directory>] [-l [-s]] [-q] [-n] [--bare]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth <depth>] <repository> [<directory>]
+	  [--depth <depth>] [--submodules] <repository> [<directory>]
 
 DESCRIPTION
 -----------
@@ -105,6 +105,10 @@ OPTIONS
 	with a long history, and would want to send in a fixes
 	as patches.
 
+--submodules::
+	Clone submodules specified in (remote) configuration parameters
+	submodule.<submodule>.url.
+
 <repository>::
 	The (possibly remote) repository to clone from.  It can
 	be any URL git-fetch supports.
diff --git a/git-clone.sh b/git-clone.sh
index 44387f4..f5a3548 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -14,7 +14,7 @@ die() {
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] <repo> [<dir>]"
+	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] [--submodules] <repo> [<dir>]"
 }
 
 get_repo_base() {
@@ -88,6 +88,7 @@ origin_override=
 use_separate_remote=t
 depth=
 no_progress=
+submodules=
 test -t 1 || no_progress=--no-progress
 while
 	case "$#,$1" in
@@ -138,6 +139,8 @@ while
 	*,--depth)
 		shift
 		depth="--depth=$1";;
+	*,--su|*,--sub|*,--subm|*,--submo|*,--submod|*,--submodu|*,--submodul|\
+	*,--submodule|*,--submodules) submodules="--submodules" ;;
 	*,-*) usage ;;
 	*) break ;;
 	esac
@@ -156,6 +159,10 @@ then
 	then
 		die '--bare and --origin $origin options are incompatible.'
 	fi
+	if test -n "$submodules"
+	then
+		die '--bare and --submodules origin options are incompatible.'
+	fi
 	no_checkout=yes
 	use_separate_remote=
 fi
@@ -309,7 +316,7 @@ yes,yes)
 		;;
 	*)
 		git-fetch --all -k $quiet "$upload_pack" $depth \
-			$separate_remote_flag "$origin" ||
+			$separate_remote_flag $submodules "$origin" ||
 			die "fetch from '$repo' failed."
 		;;
 	esac
@@ -405,10 +412,15 @@ then
 		git-config branch."$head_points_at".merge "refs/heads/$head_points_at"
 	esac
 
+	if test -n "$submodules"
+	then
+		git-config core.submodules true
+	fi
+
 	case "$no_checkout" in
 	'')
 		test "z$quiet" = z -a "z$no_progress" = z && v=-v || v=
-		git-read-tree -m -u $v HEAD HEAD
+		git-read-tree -m -u $v $submodules HEAD HEAD
 	esac
 fi
 rm -f "$GIT_DIR/CLONE_HEAD" "$GIT_DIR/REMOTE_HEAD"
diff --git a/git-fetch.sh b/git-fetch.sh
index 84c2523..b7ef0c3 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -15,6 +15,70 @@ LF='
 '
 IFS="$LF"
 
+local_URL() {
+	# tranforms a "URL" on the remote to a URL that works on the local machine
+	# $1 - remote, $2 - URL on remote
+	echo "$1 $2" >&2
+	case "$1" in
+	https://*|http://*|ftp://*)
+		case "$2" in
+		https://*|http://*|ftp://*)
+			echo $2
+		esac
+		;;
+	ssh://*)
+		case "$2" in
+		https://*|http://*|ftp://*)
+			echo $2
+			;;
+		/*)
+			echo $(echo $1 | sed -e 's/\(ssh:\/\/[^\/]*\)\/.*/\1/')$2
+		esac
+		;;
+	/*)
+		echo $2
+		;;
+	*)
+		case "$2" in
+		https://*|http://*|ftp://*)
+			echo $2
+		esac
+	esac
+}
+
+clone_submodules () {
+	# $1 - remote
+	remote=$1
+	( : subshell because we muck with IFS
+        IFS=" 	$LF"
+	cd "$GIT_DIR/.."
+	git-config --remote="$remote" --get-regexp 'submodule\..*\.url' | \
+	sed -e 's/^submodule\.//' -e 's/\.url / /' |
+	while read submodule URL
+	do
+		previous=$(git-config "submodule.$submodule.url")
+		if test -n "$previous"
+		then
+			continue;
+		fi
+		URL=$(local_URL "$remote" "$URL")
+		if test -z "$URL"
+		then
+			continue;
+		fi
+		# At this point, we don't know if the submodule
+		# appears in the HEAD of the supermodule, so clone it
+		# without a checkout and overwrite HEAD so that a subsequent
+		# checkout won't assume the submodule has already been
+		# checked out.
+		git-clone --submodules -n "$URL" "$submodule"
+		z40=0000000000000000000000000000000000000000
+		GIT_DIR="$submodule/.git" git-update-ref --no-deref HEAD $z40
+		git-config "submodule.$submodule.url" "$URL"
+	done
+	)
+}
+
 all=
 no_tags=
 tags=
@@ -27,6 +91,7 @@ keep=
 shallow_depth=
 no_progress=
 use_separate_remote=
+submodules=
 test -t 1 || no_progress=--no-progress
 quiet=
 while case "$#" in 0) break ;; esac
@@ -84,6 +149,15 @@ do
 		shift
 		shallow_depth="--depth=$1"
 		;;
+	--su|--sub|--subm|--submo|--submod|--submodu|--submodul|\
+	--submodule|--submodules)
+		submodules="yes"
+		;;
+	--no-su|--no-sub|--no-subm|--no-submo|--no-submod|\
+	--no-submodu|--no-submodul|\
+	--no-submodule|--no-submodules)
+		submodules="no"
+		;;
 	-*)
 		usage
 		;;
@@ -149,6 +223,18 @@ case "$tags$no_tags" in
 	esac
 esac
 
+case "$submodules" in
+'')
+	case "$(git-config --bool core.submodules)" in
+	true)
+		submodues=yes
+		;;
+	*)
+		submodules=no
+		;;
+	esac
+esac
+
 # If --tags (and later --heads or --all) is specified, then we are
 # not talking about defaults stored in Pull: line of remotes or
 # branches file, and just fetch those and refspecs explicitly given.
@@ -407,3 +493,7 @@ case "$orig_head" in
 	fi
 	;;
 esac
+
+if test "$submodules" = yes; then
+	clone_submodules "$remote"
+fi
-- 
1.5.2.rc3.783.gc7476-dirty
