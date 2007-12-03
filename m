From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] git-commit: Allow to amend a merge commit that does not change the tree
Date: Mon,  3 Dec 2007 08:24:50 +0100
Message-ID: <1196666690-22187-1-git-send-email-johannes.sixt@telecom.at>
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: krh@redhat.com
X-From: git-owner@vger.kernel.org Mon Dec 03 08:25:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz5g7-0003Dm-Tg
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 08:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbXLCHY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 02:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759AbXLCHY7
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 02:24:59 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:48254 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbXLCHY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 02:24:58 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1Iz5ev-0007SY-FV; Mon, 03 Dec 2007 08:24:05 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2EF306EF; Mon,  3 Dec 2007 08:24:51 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id D40D7FA45; Mon,  3 Dec 2007 08:24:50 +0100 (CET)
X-Mailer: git-send-email 1.5.3.6.969.g3cdf46
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66880>

Normally, it should not be allowed to generate an empty commit. A merge
commit generated with git 'merge -s ours' does not change the tree (along
the first parent), but merges are not "empty" even if they do not change
the tree. Hence, commit 8588452ceb7 allowed to amend a merge commit that
does not change the tree, but 4fb5fd5d301 disallowed it again in an
attempt to avoid that an existing commit is amended such that it becomes
empty. With this change, a commit can be edited (create a new one or amend
an existing one) either if there are changes or if there are at least two
parents.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
	I need this patch because I sometimes do 'git merge -s ours' and
	then want to change the commit message.

	I haven't gotten around to write a test case for this scenario,
	so I'm sending out the fix alone, in order to draw attention
	to the issue and have builtin-commit fixed by its authors, if
	necessary ;)

	Thanks,
	-- Hannes

 git-commit.sh |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index 4853397..1a07278 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -515,13 +515,16 @@ else
 	# we need to check if there is anything to commit
 	run_status >/dev/null
 fi
-if [ "$?" != "0" -a ! -f "$GIT_DIR/MERGE_HEAD" ]
-then
+case "$?,$PARENTS" in
+0,* | *,-p*-p*)
+	:	# ok, go ahead
+	;;
+*)
 	rm -f "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
 	use_status_color=t
 	run_status
 	exit 1
-fi
+esac
 
 case "$no_edit" in
 '')
-- 
1.5.3.6.969.g3cdf46
