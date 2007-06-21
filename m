From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH][RESEND] git-submodule: provide easy way of adding new
 submodules
Date: Thu, 21 Jun 2007 11:53:00 +0200
Message-ID: <20070621095300.GA27071MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: skimo@liacs.nl
To: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 11:53:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1JLf-0003pb-VF
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 11:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbXFUJxG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 05:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbXFUJxE
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 05:53:04 -0400
Received: from psmtp02.wxs.nl ([195.121.247.11]:62116 "EHLO psmtp02.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbXFUJxD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 05:53:03 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp02.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JJZ00BK9CSC4B@psmtp02.wxs.nl> for git@vger.kernel.org; Thu,
 21 Jun 2007 11:53:01 +0200 (MEST)
Received: (qmail 27090 invoked by uid 500); Thu, 21 Jun 2007 09:53:00 +0000
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50611>

To make a submodule effectively usable, the path and
a URL where the submodule can be cloned need to be stored
in .gitmodules.  This subcommand takes care of setting
this information after cloning the new submodule.
Only the index is updated, so, if needed, the user may still
change the URL or switch to a different branch of the submodule
before committing.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
I didn't get any reaction (negative or positive) to this patch.
The only difference with the previous version is that I know
check for the existence of the destination path before calling
module_clone.

skimo

 Documentation/git-submodule.txt |    8 ++++
 git-submodule.sh                |   68 +++++++++++++++++++++++++++++++++++---
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index f8fb80f..bf9cbf9 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -8,11 +8,19 @@ git-submodule - Initialize, update or inspect submodules
 
 SYNOPSIS
 --------
+'git-submodule' [--quiet] add <repository> [<path>]
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
diff --git a/git-submodule.sh b/git-submodule.sh
index 89a3885..3df7121 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1,13 +1,14 @@
 #!/bin/sh
 #
-# git-submodules.sh: init, update or list git submodules
+# git-submodules.sh: add, init, update or list git submodules
 #
 # Copyright (c) 2007 Lars Hjemli
 
-USAGE='[--quiet] [--cached] [status|init|update] [--] [<path>...]'
+USAGE='[--quiet] [--cached] [add <repo>|status|init|update] [--] [<path>...]'
 . git-sh-setup
 require_work_tree
 
+add=
 init=
 update=
 status=
@@ -25,6 +26,17 @@ say()
 	fi
 }
 
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
@@ -66,6 +78,44 @@ module_clone()
 }
 
 #
+# Add a new submodule to the working tree, .gitmodules and the index
+#
+# $@ = repo [path]
+#
+module_add()
+{
+	repo=$1
+	path=$2
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
+	module_clone "$path" "$repo" || exit
+	(unset GIT_DIR && cd "$path" && git checkout -q) ||
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
@@ -173,6 +223,9 @@ modules_list()
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
+	add)
+		add=1
+		;;
 	init)
 		init=1
 		;;
@@ -201,14 +254,17 @@ do
 	shift
 done
 
-case "$init,$update,$status,$cached" in
-1,,,)
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
+,,,*,*)
 	modules_list "$@"
 	;;
 *)
-- 
1.5.2.2.250.g1cd90-dirty
