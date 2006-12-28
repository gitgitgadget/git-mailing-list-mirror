From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Teach git-reset to let others override its reflog entry.
Date: Wed, 27 Dec 2006 20:43:36 -0500
Message-ID: <20061228014336.GA16790@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 02:43:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzkJ5-0003Ap-1r
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 02:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWL1Bnk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 20:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWL1Bnk
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 20:43:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37318 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964845AbWL1Bnj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 20:43:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzkIw-0004Yj-CE; Wed, 27 Dec 2006 20:43:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 281C720FB65; Wed, 27 Dec 2006 20:43:36 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35502>

When git-rebase invokes `git reset --hard` to rewind the user's
branch prior to starting to reapply each commit this is showing
up in the reflog as a simple `git reset --hard <cmt>` but its not
clear to the end-user inspecting the log why there is a reset.

The new --reflog-action for git-reset behaves like the same option
to git-merge; it can be used by the caller to override the message
entry in the reflog and is intended to be used only when git-reset
is acting as plumbing, not porcelain.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-reset.txt |    5 +++++
 git-rebase.sh               |    4 ++--
 git-reset.sh                |    8 ++++++--
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 4f42478..7eaa186 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -45,6 +45,11 @@ OPTIONS
 	switched to. Any changes to tracked files in the working tree
 	since <commit> are lost.
 
+--reflog-action=<action>::
+	This is used internally when `git-rebase` calls this command
+	to reset the current branch prior to merging the rebased
+	commits onto it.
+
 <commit>::
 	Commit to make the current HEAD.
 
diff --git a/git-rebase.sh b/git-rebase.sh
index ece3142..b99f1e3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -174,7 +174,7 @@ do
 		else
 			die "No rebase in progress?"
 		fi
-		git reset --hard ORIG_HEAD
+		git reset --reflog-action="rebase: abort" --hard ORIG_HEAD
 		exit
 		;;
 	--onto)
@@ -293,7 +293,7 @@ fi
 
 # Rewind the head to "$onto"; this saves our current head in ORIG_HEAD.
 echo "First, rewinding head to replay your work on top of it..."
-git-reset --hard "$onto"
+git-reset --hard --reflog-action="rebase: rewind to $onto_name" "$onto"
 
 # If the $onto is a proper descendant of the tip of the branch, then
 # we just fast forwarded.
diff --git a/git-reset.sh b/git-reset.sh
index 2379db0..7ef6789 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -6,7 +6,7 @@ USAGE='[--mixed | --soft | --hard]  [<commit-ish>] [ [--] <paths>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 
-update= reset_type=--mixed
+rloga= update= reset_type=--mixed
 unset rev
 
 while case $# in 0) break ;; esac
@@ -15,6 +15,9 @@ do
 	--mixed | --soft | --hard)
 		reset_type="$1"
 		;;
+	--reflog-action=*)
+		rloga=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		;;
 	--)
 		break
 		;;
@@ -81,7 +84,8 @@ then
 else
 	rm -f "$GIT_DIR/ORIG_HEAD"
 fi
-git-update-ref -m "reset $reset_type $*" HEAD "$rev"
+test "$rloga" = '' && rloga="reset $reset_type $*"
+git-update-ref -m "$rloga" HEAD "$rev"
 update_ref_status=$?
 
 case "$reset_type" in
-- 
1.4.4.3.gd2e4
