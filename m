From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] rebase -m: Fix incorrect short-logs of already applied commits.
Date: Sat, 1 Sep 2007 09:25:27 +0200
Message-ID: <200709010925.27926.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 10:00:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRNti-0000G3-2w
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 10:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbXIAH7c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 03:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbXIAH7c
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 03:59:32 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:42620 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbXIAH7b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 03:59:31 -0400
X-Greylist: delayed 1982 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Sep 2007 03:59:31 EDT
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id D7F4735AB3;
	Sat,  1 Sep 2007 09:25:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 867E55765B;
	Sat,  1 Sep 2007 09:25:28 +0200 (CEST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57258>

When a topic branch is rebased, some of whose commits are already
cherry-picked upstream:

    o--X--A--B--Y    <- master
     \
      A--B--Z        <- topic

then 'git rebase -m master' would report:

    Already applied: 0001 Y
    Already applied: 0002 Y

With this fix it reports the expected:

    Already applied: 0001 A
    Already applied: 0002 B

As an added bonus, this change also avoids 'echo' of a commit message,
which might contain escapements.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 git-rebase.sh |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index cbafa14..9cf0056 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -59,20 +59,23 @@ continue_merge () {
 		die "$RESOLVEMSG"
 	fi
 
+	cmt=`cat $dotest/current`
 	if ! git diff-index --quiet HEAD
 	then
-		if ! git-commit -C "`cat $dotest/current`"
+		if ! git-commit -C "$cmt"
 		then
 			echo "Commit failed, please do not call \"git commit\""
 			echo "directly, but instead do one of the following: "
 			die "$RESOLVEMSG"
 		fi
-		printf "Committed: %0${prec}d" $msgnum
+		printf "Committed: %0${prec}d " $msgnum
+		git rev-list --pretty=oneline -1 HEAD | \
+			sed 's/^[a-f0-9]\+ //'
 	else
-		printf "Already applied: %0${prec}d" $msgnum
+		printf "Already applied: %0${prec}d " $msgnum
+		git rev-list --pretty=oneline -1 "$cmt" | \
+			sed 's/^[a-f0-9]\+ //'
 	fi
-	echo ' '`git rev-list --pretty=oneline -1 HEAD | \
-				sed 's/^[a-f0-9]\+ //'`
 
 	prev_head=`git rev-parse HEAD^0`
 	# save the resulting commit so we can read-tree on it later
-- 
1.5.3.rc6.55.ga005
