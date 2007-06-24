From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] git-submodule: provide easy way of adding new submodules
Date: Sun, 24 Jun 2007 23:06:07 +0200
Message-ID: <20070624210607.GC997MdfPADPa@greensroom.kotnet.org>
References: <20070621095300.GA27071MdfPADPa@greensroom.kotnet.org>
 <7v8xaa4f5g.fsf@assigned-by-dhcp.pobox.com>
 <20070624151750.GA997MdfPADPa@greensroom.kotnet.org>
 <7vir9dtf5z.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 23:06:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2ZHk-00011n-7j
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 23:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbXFXVGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 17:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbXFXVGL
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 17:06:11 -0400
Received: from smtp19.wxs.nl ([195.121.247.10]:47734 "EHLO smtp19.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbXFXVGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 17:06:09 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JK50086HRY7NE@smtp19.wxs.nl> for git@vger.kernel.org; Sun,
 24 Jun 2007 23:06:08 +0200 (CEST)
Received: (qmail 17054 invoked by uid 500); Sun, 24 Jun 2007 21:06:07 +0000
In-reply-to: <7vir9dtf5z.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50821>

To make a submodule effectively usable, the path and
a URL where the submodule can be cloned need to be stored
in .gitmodules.  This subcommand takes care of setting
this information after cloning the new submodule.
Only the index is updated, so, if needed, the user may still
change the URL or switch to a different branch of the submodule
before committing.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
On Sun, Jun 24, 2007 at 10:50:48AM -0700, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
> 
> > They're different because submodule update (which also calls module_clone)
> > is performed on a module that already exists in the repo and
> > was therefore checked out by git as an empty directory.  If you
> > add a new submodule, then there is no reason for the subdirectory
> > to exist already.
> 
> Ah, you are absolutely right.  Thanks for the clarification.
> 
> By the way, when I have to say "thanks for the clarification", I
> think it is an indication that the relevant parts of the code
> need a bit of commenting ;-).

How's this ?

skimo

 Documentation/git-submodule.txt |   11 ++++
 git-submodule.sh                |  102 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index f8fb80f..7f0904e 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -8,11 +8,19 @@ git-submodule - Initialize, update or inspect submodules
 
 SYNOPSIS
 --------
+'git-submodule' [--quiet] [-b branch] add <repository> [<path>]
 'git-submodule' [--quiet] [--cached] [status|init|update] [--] [<path>...]
 
 
 COMMANDS
 --------
+add::
+	Add the given repository as a submodule at the given path
+	to the changeset to be committed next.  In particular, the
+	repository is cloned at the specified path, added to the
+	changeset and registered in .gitmodules.   If no path is
+	specified, the path is deduced from the repository specification.
+
 status::
 	Show the status of the submodules. This will print the SHA-1 of the
 	currently checked out commit for each submodule, along with the
@@ -39,6 +47,9 @@ OPTIONS
 -q, --quiet::
 	Only print error messages.
 
+-b, --branch::
+	Branch of repository to add as submodule.
+
 --cached::
 	Display the SHA-1 stored in the index, not the SHA-1 of the currently
 	checked out submodule commit. This option is only valid for the
diff --git a/git-submodule.sh b/git-submodule.sh
index 89a3885..67c78f2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1,13 +1,15 @@
 #!/bin/sh
 #
-# git-submodules.sh: init, update or list git submodules
+# git-submodules.sh: add, init, update or list git submodules
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [status|init|update] [--] [<path>...]'
+USAGE='[--quiet] [--cached] [add <repo> [-b branch]|status|init|update] [--] [<path>...]'
 . git-sh-setup
 require_work_tree
 
+add=
+branch=
 init=
 update=
 status=
@@ -25,6 +27,18 @@ say()
 	fi
 }
 
+# NEEDSWORK: identical function exists in get_repo_base in clone.sh
+get_repo_base() {
+	(
+		cd "`/bin/pwd`" &&
+		cd "$1" || cd "$1.git" &&
+		{
+			cd .git
+			pwd
+		}
+	) 2>/dev/null
+}
+
 #
 # Map submodule path to submodule name
 #
@@ -42,6 +56,11 @@ module_name()
 #
 # Clone a submodule
 #
+# Prior to calling, modules_update checks that a possibly existing
+# path is not a git repository.
+# Likewise, module_add checks that path does not exist at all,
+# since it is the location of a new submodule.
+#
 module_clone()
 {
 	path=$1
@@ -66,6 +85,53 @@ module_clone()
 }
 
 #
+# Add a new submodule to the working tree, .gitmodules and the index
+#
+# $@ = repo [path]
+#
+# optional branch is stored in global branch variable
+#
+module_add()
+{
+	repo=$1
+	path=$2
+
+	if test -z "$repo"; then
+		usage
+	fi
+
+	# Turn the source into an absolute path if
+	# it is local
+	if base=$(get_repo_base "$repo"); then
+		repo="$base"
+	fi
+
+	# Guess path from repo if not specified or strip trailing slashes
+	if test -z "$path"; then
+		path=$(echo "$repo" | sed -e 's|/*$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
+	else
+		path=$(echo "$path" | sed -e 's|/*$||')
+	fi
+
+	test -e "$path" &&
+	die "'$path' already exists"
+
+	git-ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
+	die "'$path' already exists in the index"
+
+	module_clone "$path" "$repo" || exit
+	(unset GIT_DIR && cd "$path" && git checkout -q ${branch:+-b "$branch" "origin/$branch"}) ||
+	die "Unable to checkout submodule '$path'"
+	git add "$path" ||
+	die "Failed to add submodule '$path'"
+
+	GIT_CONFIG=.gitmodules git config submodule."$path".path "$path" &&
+	GIT_CONFIG=.gitmodules git config submodule."$path".url "$repo" &&
+	git add .gitmodules ||
+	die "Failed to register submodule '$path'"
+}
+
+#
 # Register submodules in .git/config
 #
 # $@ = requested paths (default to all)
@@ -173,6 +239,9 @@ modules_list()
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
+	add)
+		add=1
+		;;
 	init)
 		init=1
 		;;
@@ -185,6 +254,14 @@ do
 	-q|--quiet)
 		quiet=1
 		;;
+	-b|--branch)
+		case "$2" in
+		'')
+			usage
+			;;
+		esac
+		branch="$2"; shift
+		;;
 	--cached)
 		cached=1
 		;;
@@ -201,14 +278,27 @@ do
 	shift
 done
 
-case "$init,$update,$status,$cached" in
-1,,,)
+case "$add,$branch" in
+1,*)
+	;;
+,)
+	;;
+,*)
+	usage
+	;;
+esac
+
+case "$add,$init,$update,$status,$cached" in
+1,,,,)
+	module_add "$@"
+	;;
+,1,,,)
 	modules_init "$@"
 	;;
-,1,,)
+,,1,,)
 	modules_update "$@"
 	;;
-,,*,*)
+,,,1,*)
 	modules_list "$@"
 	;;
 *)
-- 
1.5.2.2.1064.g59b4
