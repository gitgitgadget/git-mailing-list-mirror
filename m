From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] Use cd_to_toplevel in scripts that implement it by hand.
Date: Fri, 12 Jan 2007 12:55:41 -0800
Message-ID: <7vfyagrmlu.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
	<200701121501.24642.andyparkins@gmail.com>
	<7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 21:55:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5TRC-0004Op-2F
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 21:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbXALUzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 15:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbXALUzn
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 15:55:43 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:44640 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030373AbXALUzm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 15:55:42 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112205542.TCUX7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 15:55:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ALuq1W0091kojtg0000000; Fri, 12 Jan 2007 15:54:50 -0500
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 12 Jan 2007 12:26:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36707>

This converts scripts that do "cd $(rev-parse --show-cdup)" by
hand to use cd_to_toplevel.

I think git-fetch does not have to go to the toplevel, but that
should be dealt with in a separate patch.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-checkout.sh |    6 +-----
 git-commit.sh   |   22 ++++++++--------------
 git-fetch.sh    |    6 +-----
 git-reset.sh    |    6 +-----
 4 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index a2b8e4f..66e40b9 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -135,11 +135,7 @@ fi
 
 # We are switching branches and checking out trees, so
 # we *NEED* to be at the toplevel.
-cdup=$(git-rev-parse --show-cdup)
-if test ! -z "$cdup"
-then
-	cd "$cdup"
-fi
+cd_to_toplevel
 
 [ -z "$new" ] && new=$old && new_name="$old_name"
 
diff --git a/git-commit.sh b/git-commit.sh
index eddd863..9fdf234 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -316,22 +316,16 @@ esac
 ################################################################
 # Prepare index to have a tree to be committed
 
-TOP=`git-rev-parse --show-cdup`
-if test -z "$TOP"
-then
-	TOP=./
-fi
-
 case "$all,$also" in
 t,)
 	save_index &&
 	(
-		cd "$TOP"
-		GIT_INDEX_FILE="$NEXT_INDEX"
-		export GIT_INDEX_FILE
+		cd_to_toplevel &&
+		GIT_INDEX_FILE="$NEXT_INDEX" &&
+		export GIT_INDEX_FILE &&
 		git-diff-files --name-only -z |
 		git-update-index --remove -z --stdin
-	)
+	) || exit
 	;;
 ,t)
 	save_index &&
@@ -339,11 +333,11 @@ t,)
 
 	git-diff-files --name-only -z -- "$@"  |
 	(
-		cd "$TOP"
-		GIT_INDEX_FILE="$NEXT_INDEX"
-		export GIT_INDEX_FILE
+		cd_to_toplevel &&
+		GIT_INDEX_FILE="$NEXT_INDEX" &&
+		export GIT_INDEX_FILE &&
 		git-update-index --remove -z --stdin
-	)
+	) || exit
 	;;
 ,)
 	case "$#" in
diff --git a/git-fetch.sh b/git-fetch.sh
index c58704d..87b940b 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -5,12 +5,8 @@ USAGE='<fetch-options> <repository> <refspec>...'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 set_reflog_action "fetch $*"
+cd_to_toplevel ;# probably unnecessary...
 
-TOP=$(git-rev-parse --show-cdup)
-if test ! -z "$TOP"
-then
-	cd "$TOP"
-fi
 . git-parse-remote
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
diff --git a/git-reset.sh b/git-reset.sh
index b9045bc..91c7e6e 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -53,11 +53,7 @@ then
 	exit
 fi
 
-TOP=$(git-rev-parse --show-cdup)
-if test ! -z "$TOP"
-then
-	cd "$TOP"
-fi
+cd_to_toplevel
 
 if test "$reset_type" = "--hard"
 then
-- 
1.5.0.rc1.g397d
