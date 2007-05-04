From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] git-clone: add --submodules for cloning submodules
Date: Fri,  4 May 2007 12:49:27 +0200
Message-ID: <11782757681900-git-send-email-skimo@liacs.nl>
References: <11782757671754-git-send-email-skimo@liacs.nl>
Cc: Sven Verdoolaege <skimo@liacs.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 13:29:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjvz4-0003fl-SP
	for gcvg-git@gmane.org; Fri, 04 May 2007 13:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbXEDL3n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 07:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755007AbXEDL3m
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 07:29:42 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:42111 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754986AbXEDL3l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 07:29:41 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l44AnXrS026175;
	Fri, 4 May 2007 12:49:38 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 235DA3C012; Fri,  4 May 2007 12:49:28 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11782757671754-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46170>

From: Sven Verdoolaege <skimo@kotnet.org>

When the --submodules option is specified, git-clone will search
for submodule.<submodule>.url options in the remote configuration
and clone each submodule using the first url that it can use from
the local site.

The submodules are currently not checked out.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 Documentation/config.txt    |    3 ++
 Documentation/git-clone.txt |    6 +++-
 git-clone.sh                |   68 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 24f9655..92747d8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -597,6 +597,9 @@ showbranch.default::
 	The default set of branches for gitlink:git-show-branch[1].
 	See gitlink:git-show-branch[1].
 
+submodule.<submodule>.url
+	The URL of a submodule.  See gitlink:git-clone[1].
+
 tar.umask::
 	By default, gitlink:git-tar-tree[1] sets file and directories modes
 	to 0666 or 0777. While this is both useful and acceptable for projects
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 6d32c49..b112a6a 100644
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
index cad5c0c..3a9b09c 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -14,7 +14,7 @@ die() {
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] <repo> [<dir>]"
+	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] [--submodules] <repo> [<dir>]"
 }
 
 get_repo_base() {
@@ -67,6 +67,60 @@ Perhaps git-update-server-info needs to be run there?"
 	rm -f "$GIT_DIR/REMOTE_HEAD"
 }
 
+local_URL() {
+	# tranforms a "URL" on the remote to a URL that works on the local machine
+	# $1 - remote, $2 - URL on remote
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
+	previous=
+	git-config --remote=$1 --get-regexp 'submodule\..*\.url' | \
+	sed -e 's/^submodule\.//;s/\.url / /' |
+	while read submodule URL
+	do
+		echo "$submodule $URL"
+		if test "$submodule" = "$previous"
+		then
+			continue;
+		fi
+		URL=$(local_URL "$1" "$URL")
+		echo "$submodule $URL"
+		if test -z "$URL"
+		then
+			continue;
+		fi
+		git-clone -n "$URL" "$submodule"
+		git-config "submodule.$submodule.url" "$URL"
+		previous="$submodule"
+	done
+}
+
 quiet=
 local=no
 use_local=no
@@ -81,6 +135,7 @@ origin_override=
 use_separate_remote=t
 depth=
 no_progress=
+submodules=
 test -t 1 || no_progress=--no-progress
 while
 	case "$#,$1" in
@@ -131,6 +186,8 @@ while
 	*,--depth)
 		shift
 		depth="--depth=$1";;
+	*,--su|*,--sub|*,--subm|*,--submo|*,--submod|*,--submodu|*,--submodul|\
+	*,--submodule|*,--submodules) submodules=yes ;;
 	*,-*) usage ;;
 	*) break ;;
 	esac
@@ -149,6 +206,10 @@ then
 	then
 		die '--bare and --origin $origin options are incompatible.'
 	fi
+	if test yes = "$submodules"
+	then
+		die '--bare and --submodules origin options are incompatible.'
+	fi
 	no_checkout=yes
 	use_separate_remote=
 fi
@@ -394,6 +455,11 @@ then
 		git-config branch."$head_points_at".merge "refs/heads/$head_points_at"
 	esac
 
+	if test yes = "$submodules"
+	then
+		clone_submodules "$repo"
+	fi
+
 	case "$no_checkout" in
 	'')
 		test "z$quiet" = z -a "z$no_progress" = z && v=-v || v=
-- 
1.5.2.rc1.25.g889f-dirty
