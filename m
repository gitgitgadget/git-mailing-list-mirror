From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: bug in rebase--interactive with squash and conflicts
Date: Tue, 21 Aug 2007 17:10:04 +0200
Organization: eudaptics software gmbh
Message-ID: <46CB004C.AC39D562@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 21 17:09:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INVM8-00040t-53
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 17:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757241AbXHUPJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 11:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758051AbXHUPJQ
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 11:09:16 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:31790 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757074AbXHUPJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 11:09:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1INVLy-0006df-HA; Tue, 21 Aug 2007 17:09:10 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 01C4D546; Tue, 21 Aug 2007 17:09:10 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.361, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56300>

Hi,

There's a problem with rebase--interactive where I want to squash two
commits and the one to squash is the first in the original series. In
particular, I change the commit list from

	pick 1
	pick 2
	pick 3
to
	pick 3
	squash 1
	pick 2

In this case, the edits of commit 3 are lost. There are conflicts when
commits 3 and 1 are cherry-picked.

You can simulate the problematic case by applying this patch:

index 40d6799..861ece1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -252,3 +252,4 @@ 'interrupted squash works as expected' '
 		echo $n >> conflict &&
-		git add conflict &&
+		echo $n > $n
+		git add conflict $n &&
 		git commit -m $n
@@ -256,3 +257,3 @@ 'interrupted squash works as expected' '
 	one=$(git rev-parse HEAD~3) &&
-	! FAKE_LINES="1 squash 3 2" git rebase -i HEAD~3 &&
+	! FAKE_LINES="3 squash 1 2" git rebase -i HEAD~3 &&
 	(echo one; echo two; echo four) > conflict &&


The test fails now, because git rebase --continue did not fail although
it should have. Run

   gitk HEAD to-be-rebased@{1}

Note that the rebase was completed, i.e. there are now 2 commits instead
of the original 3. But the file 'four' is missing and the final contents
of the file 'conflict' is

one
two
three

i.e. as if commit 3 had never taken place.

-- Hannes
