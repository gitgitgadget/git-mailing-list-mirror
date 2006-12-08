X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] rerere: record (or avoid misrecording) resolved, skipped or aborted rebase/am
Date: Fri,  8 Dec 2006 13:29:56 -0800
Message-ID: <1165613397460-git-send-email-normalperson@yhbt.net>
References: <20061208212830.GB13944@localdomain> <11656133963055-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Fri, 8 Dec 2006 21:30:10 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.2.g860f4
In-Reply-To: <11656133963055-git-send-email-normalperson@yhbt.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33748>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsnIE-00088o-Mp for gcvg-git@gmane.org; Fri, 08 Dec
 2006 22:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947275AbWLHVaA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 16:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947276AbWLHVaA
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 16:30:00 -0500
Received: from hand.yhbt.net ([66.150.188.102]:48158 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1947275AbWLHV37
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 16:29:59 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 12FB52DC089; Fri,  8 Dec 2006 13:29:58 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  8 Dec 2006
 13:29:57 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Data in rr-cache isn't valid after a patch application is
skipped or and aborted, so our next commit could be misrecorded
as a resolution of that skipped/failed commit, which is wrong.

git-am --skip, git-rebase --skip/--abort will automatically
invoke git-rerere clear to avoid this.

Also, since git-am --resolved indicates a resolution was
succesful, remember to run git-rerere to record the resolution
(and not surprise the user when the next commit is made).

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-am.sh     |    8 ++++++++
 git-rebase.sh |    8 ++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index afe322b..5df6787 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -246,6 +246,10 @@ last=`cat "$dotest/last"`
 this=`cat "$dotest/next"`
 if test "$skip" = t
 then
+	if test -d "$GIT_DIR/rr-cache"
+	then
+		git-rerere clear
+	fi
 	this=`expr "$this" + 1`
 	resume=
 fi
@@ -408,6 +412,10 @@ do
 			stop_here_user_resolve $this
 		fi
 		apply_status=0
+		if test -d "$GIT_DIR/rr-cache"
+		then
+			git rerere
+		fi
 		;;
 	esac
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 25530df..2b4f347 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -139,6 +139,10 @@ do
 	--skip)
 		if test -d "$dotest"
 		then
+			if test -d "$GIT_DIR/rr-cache"
+			then
+				git-rerere clear
+			fi
 			prev_head="`cat $dotest/prev_head`"
 			end="`cat $dotest/end`"
 			msgnum="`cat $dotest/msgnum`"
@@ -157,6 +161,10 @@ do
 		exit
 		;;
 	--abort)
+		if test -d "$GIT_DIR/rr-cache"
+		then
+			git-rerere clear
+		fi
 		if test -d "$dotest"
 		then
 			rm -r "$dotest"
-- 
1.4.4.2.g860f4
