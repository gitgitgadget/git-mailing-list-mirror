From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] Allow whole-tree operations to be started from a subdirectory
Date: Fri, 12 Jan 2007 12:56:02 -0800
Message-ID: <7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
	<200701121501.24642.andyparkins@gmail.com>
	<7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 21:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5TRZ-0004WR-IN
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 21:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbXALU4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 15:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbXALU4G
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 15:56:06 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:33188 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030459AbXALU4F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 15:56:05 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112205602.SZAE20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 15:56:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ALvB1W0051kojtg0000000; Fri, 12 Jan 2007 15:55:11 -0500
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 12 Jan 2007 12:26:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36708>

This updates five commands (merge, pull, rebase, revert and cherry-pick)
so that they can be started from a subdirectory.

This may not actually be what we want to do.  These commands are
inherently whole-tree operations, and an inexperienced user may
mistakenly expect a "git pull" from a subdirectory would merge
only the subdirectory the command started from.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-merge.sh  |    4 +++-
 git-pull.sh   |    4 +++-
 git-rebase.sh |    3 +++
 git-revert.sh |    3 +++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 3eef048..7de83dc 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -5,12 +5,14 @@
 
 USAGE='[-n] [--no-commit] [--squash] [-s <strategy>] [-m=<merge-message>] <commit>+'
 
+SUBDIRECTORY_OK=Yes
 . git-sh-setup
 set_reflog_action "merge $*"
 require_work_tree
+cd_to_toplevel
 
 test -z "$(git ls-files -u)" ||
-	die "You are in a middle of conflicted merge."
+	die "You are in the middle of a conflicted merge."
 
 LF='
 '
diff --git a/git-pull.sh b/git-pull.sh
index e9826fc..9592617 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -6,12 +6,14 @@
 
 USAGE='[-n | --no-summary] [--no-commit] [-s strategy]... [<fetch-options>] <repo> <head>...'
 LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
+SUBDIRECTORY_OK=Yes
 . git-sh-setup
 set_reflog_action "pull $*"
 require_work_tree
+cd_to_toplevel
 
 test -z "$(git ls-files -u)" ||
-	die "You are in a middle of conflicted merge."
+	die "You are in the middle of a conflicted merge."
 
 strategy_args= no_summary= no_commit= squash=
 while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
diff --git a/git-rebase.sh b/git-rebase.sh
index 98f9558..c8bd0f9 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -27,9 +27,12 @@ Example:       git-rebase master~1 topic
        /                   -->           /
   D---E---F---G master          D---E---F---G master
 '
+
+SUBDIRECTORY_OK=Yes
 . git-sh-setup
 set_reflog_action rebase
 require_work_tree
+cd_to_toplevel
 
 RESOLVEMSG="
 When you have resolved this problem run \"git rebase --continue\".
diff --git a/git-revert.sh b/git-revert.sh
index fcca3eb..224e654 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -19,8 +19,11 @@ case "$0" in
 	echo >&2 "What are you talking about?"
 	exit 1 ;;
 esac
+
+SUBDIRECTORY_OK=Yes ;# we will cd up
 . git-sh-setup
 require_work_tree
+cd_to_toplevel
 
 no_commit=
 while case "$#" in 0) break ;; esac
-- 
1.5.0.rc1.g397d
