From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 1/2] git-rebase-interactive: do not squash commits on abort
Date: Tue,  9 Sep 2008 00:42:48 +0400
Message-ID: <1220906569-26878-1-git-send-email-dpotapov@gmail.com>
Cc: Dmitry Potapov <dpotapov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 22:44:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcnag-0000cu-1r
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 22:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbYIHUm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 16:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbYIHUm5
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 16:42:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:24832 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbYIHUm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 16:42:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1598138fgg.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 13:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=R3EibMHrU6V1E6aI4OQv971HmAbwvm65++65o0PPDbo=;
        b=ULyaDO/JuiV2BlirdsZHdbUWSM8YPufY8wR8Blrlf+J3gXMpzvh8EtQfvhyYFKvgtQ
         8X8DV++a/rhlyqHt019Mwx44zafhBPX3q5/0eGIerzIO4rzyTtz2+tchk7Qty2zezzlL
         /Cli0nSeJJyYFjFtBQUdlLVyW5e+rpM3t6SLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Np73FYf1fPm2LSvQ5itmtKxNCUAlwPoZJ4aQUG1Cg/tNQSKiAfny/+Hf/VkAHwsRMB
         ZAP42MLy+MP/w7yVpl0H85CsLHOsuHgC6LExcL6XBh4NwULeiQf8PDXDShYKyFi1dWHy
         vUCBt+bmYPdsgTJq1pQpAlwSHLrGbdchSIj5E=
Received: by 10.86.97.7 with SMTP id u7mr11671468fgb.29.1220906572567;
        Mon, 08 Sep 2008 13:42:52 -0700 (PDT)
Received: from localhost ( [85.141.189.164])
        by mx.google.com with ESMTPS id 4sm5738726fgg.4.2008.09.08.13.42.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 13:42:51 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95299>

If git rebase interactive is stopped by "edit" command and then the user
said "git rebase --continue" while having some stage changes, git rebase
interactive is trying to amend the last commit by doing:
  git --soft reset && git commit

However, the user can abort commit for some reason by providing an empty
log message, and that would leave the last commit undone, while the user
being completely unaware about what happened. Now if the user tries to
continue, by issuing "git rebase --continue" that squashes two previous
commits.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 git-rebase--interactive.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 929d681..5b2b1e5 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -429,12 +429,15 @@ do
 				die "Cannot find the author identity"
 			if test -f "$DOTEST"/amend
 			then
+				amend=$(git rev-parse --verify HEAD)
 				git reset --soft HEAD^ ||
 				die "Cannot rewind the HEAD"
 			fi
 			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
-			git commit --no-verify -F "$DOTEST"/message -e ||
-			die "Could not commit staged changes."
+			git commit --no-verify -F "$DOTEST"/message -e || {
+				test -n "$amend" && git reset --soft $amend
+				die "Could not commit staged changes."
+			}
 		fi
 
 		require_clean_work_tree
-- 
1.6.0
