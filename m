From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/3] add a quiet option to git-checkout
Date: Thu, 01 Feb 2007 12:31:26 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702011230320.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 18:31:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCfmb-0006CI-Nc
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 18:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbXBARb2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 12:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbXBARb2
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 12:31:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:29462 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbXBARb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 12:31:27 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCS00FUTOOET9O0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Feb 2007 12:31:26 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38377>

Those new messages are certainly nice, but there might be cases where
they are simply unwelcome, like when git-commit is used within scripts.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 Documentation/git-checkout.txt |    5 ++++-
 git-checkout.sh                |   23 ++++++++++++++---------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 4ea2b31..55c9289 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,7 +8,7 @@ git-checkout - Checkout and switch to a branch
 SYNOPSIS
 --------
 [verse]
-'git-checkout' [-f] [-b <new_branch> [-l]] [-m] [<branch>]
+'git-checkout' [-q] [-f] [-b <new_branch> [-l]] [-m] [<branch>]
 'git-checkout' [<tree-ish>] <paths>...
 
 DESCRIPTION
@@ -33,6 +33,9 @@ working tree.
 
 OPTIONS
 -------
+-q::
+	Quiet, supress feedback messages.
+
 -f::
 	Force a re-read of everything.
 
diff --git a/git-checkout.sh b/git-checkout.sh
index 97c26ad..99a81f5 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
+USAGE='[-q] [-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
 SUBDIRECTORY_OK=Sometimes
 . git-sh-setup
 require_work_tree
@@ -15,6 +15,7 @@ branch=
 newbranch=
 newbranch_log=
 merge=
+quiet=
 LF='
 '
 while [ "$#" != "0" ]; do
@@ -40,6 +41,9 @@ while [ "$#" != "0" ]; do
 	-m)
 		merge=1
 		;;
+	"-q")
+		quiet=1
+		;;
 	--)
 		break
 		;;
@@ -153,7 +157,7 @@ detach_warn=
 if test -z "$branch$newbranch" && test "$new" != "$old"
 then
 	detached="$new"
-	if test -n "$oldbranch"
+	if test -n "$oldbranch" && test -z "$quiet"
 	then
 		detach_warn="Note: moving to \"$new_name\" which isn't a local branch
 If you want to create a new branch from this checkout, you may do so
@@ -180,8 +184,11 @@ fi
 
 if [ "X$old" = X ]
 then
-	echo >&2 "warning: You appear to be on a branch yet to be born."
-	echo >&2 "warning: Forcing checkout of $new_name."
+	if test -z "$quiet"
+	then
+		echo >&2 "warning: You appear to be on a branch yet to be born."
+		echo >&2 "warning: Forcing checkout of $new_name."
+	fi
 	force=1
 fi
 
@@ -226,7 +233,7 @@ else
 	exit 0
     )
     saved_err=$?
-    if test "$saved_err" = 0
+    if test "$saved_err" = 0 && test -z "$quiet"
     then
 	git diff-index --name-status "$new"
     fi
@@ -251,11 +258,9 @@ if [ "$?" -eq 0 ]; then
 	if test -n "$branch"
 	then
 		GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD "refs/heads/$branch"
-		if test -n "$newbranch"
+		if test -z "$quiet"
 		then
-			echo >&2 "Switched to a new branch \"$branch\""
-		else
-			echo >&2 "Switched to branch \"$branch\""
+			echo >&2 "Switched to${newbranch:+ a new} branch \"$branch\""
 		fi
 	elif test -n "$detached"
 	then
-- 
1.5.0.rc2.131.g4b01-dirty
