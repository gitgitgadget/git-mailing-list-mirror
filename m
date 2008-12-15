From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 2/2] rebase -i -p: Fix --continue after a merge could not be redone
Date: Mon, 15 Dec 2008 11:05:31 +0100
Message-ID: <1229335531-32707-2-git-send-email-j6t@kdbg.org>
References: <1229012461-31377-1-git-send-email-j6t@kdbg.org>
 <1229335531-32707-1-git-send-email-j6t@kdbg.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Stephen Haberman <stephen@exigencecorp.com>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 11:07:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCALw-0006gs-Ei
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 11:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbYLOKFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 05:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754046AbYLOKFq
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 05:05:46 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58358 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbYLOKFo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 05:05:44 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1LCAKS-00056C-Hw; Mon, 15 Dec 2008 11:05:38 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 362A2FF4F; Mon, 15 Dec 2008 11:05:32 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id DB563FA45; Mon, 15 Dec 2008 11:05:31 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc2.22.gf3bf84
In-Reply-To: <1229335531-32707-1-git-send-email-j6t@kdbg.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103148>

When a merge that has a conflict was rebased, then rebase stopped to let
the user resolve the conflicts. However, thereafter --continue failed
because the author-script was not saved. (This is rebase -i's way to
preserve a commit's authorship.) This fixes it by doing taking the same
failure route after a merge that is also taken after a normal cherry-pick.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 This is an attempt at fixing the failure.  I don't know whether it is
 problematic to leave a "patch" behind if there was actually a merge.
 Nevertheless, all rebase tests pass.

 -- Hannes
 
 git-rebase--interactive.sh        |    3 +--
 t/t3409-rebase-preserve-merges.sh |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1172e47..89c39eb 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -253,15 +253,14 @@ pick_one_preserving_merges () {
 			if ! GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
 				GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
 				GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
 				output git merge $STRATEGY -m "$msg" \
 					$new_parents
 			then
-				git rerere
 				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
-				die Error redoing merge $sha1
+				die_with_patch $sha1 "Error redoing merge $sha1"
 			fi
 			;;
 		*)
 			output git cherry-pick "$@" ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 5ddd1d1..820e010 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -72,13 +72,13 @@ test_expect_success 'rebase -p fakes interactive rebase' '
 	git rebase -p origin/topic &&
 	test 1 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
 	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge commit" | wc -l)
 	)
 '
 
-test_expect_failure '--continue works after a conflict' '
+test_expect_success '--continue works after a conflict' '
 	(
 	cd clone2 &&
 	git fetch &&
 	test_must_fail git rebase -p origin/topic &&
 	test 2 = $(git ls-files B | wc -l) &&
 	echo Resolved again > B &&
-- 
1.6.1.rc2.22.gf3bf84
