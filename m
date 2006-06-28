From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH (fixed) 1/2] rebase: check for errors from git-commit
Date: Wed, 28 Jun 2006 03:24:23 -0700
Message-ID: <20060628102423.GA25093@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 12:25:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvXDi-0003Ls-5Z
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 12:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423262AbWF1KY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 06:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423266AbWF1KY0
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 06:24:26 -0400
Received: from hand.yhbt.net ([66.150.188.102]:6874 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1423262AbWF1KYZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 06:24:25 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 649DB7DC022;
	Wed, 28 Jun 2006 03:24:23 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 28 Jun 2006 03:24:23 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

commit does not always succeed, so we'll have to check for
it in the absence of set -e.  This fixes a regression
introduced in 9e4bc7dd1bb9d92491c475cec55147fa0b3f954d

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-rebase.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 9ad1c44..28860fc 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -59,8 +59,13 @@ continue_merge () {
 
 	if test -n "`git-diff-index HEAD`"
 	then
+		if ! git-commit -C "`cat $dotest/current`"
+		then
+			echo "Commit failed, please do not call \"git commit\""
+			echo "directly, but instead do one of the following: "
+			die "$RESOLVEMSG"
+		fi
 		printf "Committed: %0${prec}d" $msgnum
-		git-commit -C "`cat $dotest/current`"
 	else
 		printf "Already applied: %0${prec}d" $msgnum
 	fi
-- 
1.4.1.rc1.gc7c5
