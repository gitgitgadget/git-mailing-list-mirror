X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] git-commit: prepare to make '-a' behaviour the default.
Date: Mon, 27 Nov 2006 23:00:11 -0800
Message-ID: <7v64d06op0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
	<87bqmswm1e.wl%cworth@cworth.org>
	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	<87ac2cwha4.wl%cworth@cworth.org>
	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
	<878xhwwdyj.wl%cworth@cworth.org>
	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 07:00:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32490>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gowx6-0003Nn-Jw for gcvg-git@gmane.org; Tue, 28 Nov
 2006 08:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935684AbWK1HAO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 02:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935685AbWK1HAO
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 02:00:14 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25276 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S935684AbWK1HAM
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 02:00:12 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128070011.PCOQ9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Tue, 28
 Nov 2006 02:00:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id s70L1V0031kojtg0000000; Tue, 28 Nov 2006
 02:00:20 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

This makes "git commit" accept "-i" without any parameter (we
used to barf on such a command line) to mean "commit what is in
the index as-is".  There is nothing surprising about this new
behaviour.  "git commit -i paths..."  means "in addition to the
changes I accumulated in the index, also run update-index on
these paths and then make a commit" and this new behaviour is a
natural extension to that to the case where "paths..." is empty.

"git commit" without -i, -a, nor -o still behave the same way as
it has done for a long time, but it now warns that this will be
changed to default to the "-a" behaviour.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-commit.sh |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 81c3a0c..6c95817 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -11,10 +11,10 @@ git-rev-parse --verify HEAD >/dev/null 2>&1 || initial_commit=t
 branch=$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD)
 
 case "$0" in
-*status)
+*status|*status.sh)
 	status_only=t
 	unmerged_ok_if_status=--unmerged ;;
-*commit)
+*commit|*commit.sh)
 	status_only=
 	unmerged_ok_if_status= ;;
 esac
@@ -287,11 +287,15 @@ esac
 case "$#,$also,$only,$amend" in
 *,t,t,*)
 	die "Only one of --include/--only can be used." ;;
-0,t,,* | 0,,t,)
-	die "No paths with --include/--only does not make sense." ;;
+0,t,,*)
+	;;
+0,,t,)
+	die "No paths with --only does not make sense." ;;
 0,,t,t)
 	only_include_assumed="# Clever... amending the last one with dirty index." ;;
 0,,,*)
+	: all=t
+	only_include_assumed="# We will start assuming -a without -i; you have been warned."
 	;;
 *,,,*)
 	only_include_assumed="# Explicit paths specified without -i nor -o; assuming --only paths..."
@@ -304,8 +308,6 @@ t,t,*)
 	die "Cannot use -a and -i at the same time." ;;
 t,,[1-9]*)
 	die "Paths with -a does not make sense." ;;
-,t,0)
-	die "No paths with -i does not make sense." ;;
 esac
 
 ################################################################
@@ -317,8 +319,8 @@ then
 	TOP=./
 fi
 
-case "$all,$also" in
-t,)
+case "$all,$also,$#" in
+t,,*)
 	save_index &&
 	(
 		cd "$TOP"
@@ -328,7 +330,7 @@ t,)
 		git-update-index --remove -z --stdin
 	)
 	;;
-,t)
+,t,[1-9]*)
 	save_index &&
 	git-ls-files --error-unmatch -- "$@" >/dev/null || exit
 
@@ -340,7 +342,7 @@ t,)
 		git-update-index --remove -z --stdin
 	)
 	;;
-,)
+,,* | ,t,0)
 	case "$#" in
 	0)
 		;; # commit as-is
@@ -407,7 +409,7 @@ GIT_INDEX_FILE="$USE_INDEX" \
 # If the request is status, just show it and exit.
 
 case "$0" in
-*status)
+*status|*status.sh)
 	run_status
 	exit $?
 esac
@@ -539,7 +541,11 @@ then
 		echo ""
 		echo "# Please enter the commit message for your changes."
 		echo "# (Comment lines starting with '#' will not be included)"
-		test -z "$only_include_assumed" || echo "$only_include_assumed"
+		test -z "$only_include_assumed" || {
+			echo "#"
+			echo "$only_include_assumed"
+			echo "#"
+		}
 		run_status
 	} >>"$GIT_DIR"/COMMIT_EDITMSG
 else
-- 
1.4.4.1.gcee8-dirty

