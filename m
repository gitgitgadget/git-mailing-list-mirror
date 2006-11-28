X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] git-commit: make '-a' the default.
Date: Mon, 27 Nov 2006 23:00:18 -0800
Message-ID: <7vy7pw5a4d.fsf@assigned-by-dhcp.cox.net>
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
NNTP-Posting-Date: Tue, 28 Nov 2006 07:00:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32489>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gowx7-0003Nn-Dp for gcvg-git@gmane.org; Tue, 28 Nov
 2006 08:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935685AbWK1HAV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 02:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935688AbWK1HAV
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 02:00:21 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:28092 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S935685AbWK1HAT
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 02:00:19 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128070019.PCSJ9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Tue, 28
 Nov 2006 02:00:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id s70T1V00Q1kojtg0000000; Tue, 28 Nov 2006
 02:00:28 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

At the same time, stop talking about "--only" option being the
default when given paths.  It has been that way for quite some
time.

This change breaks t1400 which assumed the long tradition of not
modifying index when not told to touch it with an explicit -a
nor paths, so this commit includes adjustment for it as well.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 git-commit.sh         |   13 ++++++-------
 t/t1400-update-ref.sh |    4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 6c95817..655340c 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -292,13 +292,12 @@ case "$#,$also,$only,$amend" in
 0,,t,)
 	die "No paths with --only does not make sense." ;;
 0,,t,t)
-	only_include_assumed="# Clever... amending the last one with dirty index." ;;
+	only_include_assumed="Clever... amending the last one with dirty index." ;;
 0,,,*)
-	: all=t
-	only_include_assumed="# We will start assuming -a without -i; you have been warned."
+	all=t
+	only_include_assumed="No -o nor -i is given; committing --all"
 	;;
 *,,,*)
-	only_include_assumed="# Explicit paths specified without -i nor -o; assuming --only paths..."
 	also=
 	;;
 esac
@@ -542,9 +541,9 @@ then
 		echo "# Please enter the commit message for your changes."
 		echo "# (Comment lines starting with '#' will not be included)"
 		test -z "$only_include_assumed" || {
-			echo "#"
-			echo "$only_include_assumed"
-			echo "#"
+			echo "################################################"
+			echo "# $only_include_assumed"
+			echo "################################################"
 		}
 		run_status
 	} >>"$GIT_DIR"/COMMIT_EDITMSG
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 6a917f2..1580224 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -200,13 +200,13 @@ test_expect_success \
 	 h_OTHER=$(git-rev-parse --verify HEAD) &&
 	 echo FIXED >F &&
 	 GIT_AUTHOR_DATE="2005-05-26 23:44" \
-	 GIT_COMMITTER_DATE="2005-05-26 23:44" git-commit --amend &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:44" git-commit --amend -i &&
 	 h_FIXED=$(git-rev-parse --verify HEAD) &&
 	 echo TEST+FIXED >F &&
 	 echo Merged initial commit and a later commit. >M &&
 	 echo $h_TEST >.git/MERGE_HEAD &&
 	 GIT_AUTHOR_DATE="2005-05-26 23:45" \
-	 GIT_COMMITTER_DATE="2005-05-26 23:45" git-commit -F M &&
+	 GIT_COMMITTER_DATE="2005-05-26 23:45" git-commit -F M -i &&
 	 h_MERGED=$(git-rev-parse --verify HEAD)
 	 rm -f M'
 
-- 
1.4.4.1.gcee8-dirty

