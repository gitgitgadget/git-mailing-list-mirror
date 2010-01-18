From: Pete Harlan <pgit@pcharlan.com>
Subject: [PATCH/RFC] Allow empty commits during rebase -i
Date: Sun, 17 Jan 2010 17:12:01 -0800
Message-ID: <4B53B561.0@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 18 02:13:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWgB0-00024D-LJ
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 02:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab0ARBMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 20:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755839Ab0ARBMx
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 20:12:53 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:47886 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647Ab0ARBMr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 20:12:47 -0500
Received: from swarthymail-a3.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 1A61E17D276
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 17:12:46 -0800 (PST)
Received: from [192.168.0.119] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a3.g.dreamhost.com (Postfix) with ESMTP id 65A687F01A;
	Sun, 17 Jan 2010 17:12:02 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137352>

If you squash two commits into a previous commit, where the first
squash reverts the previous commit and the second redoes the change
correctly, rebase -i would fail during the first squash because it
generates an empty commit.  This patch allows the rebase to succeed.

This also introduces the possibility that you might accidentally
create an empty commit with a squash, but I expect that will happen
less often than the scenario this is intended to address.

Signed-off-by: Pete Harlan <pgit@pcharlan.com>
---

This arose for me recently; I used "git revert" to undo a commit
several changes back, and then reworked and committed anew.  The first
commit that I was redoing had a thorough commit message, while my new
commit had a message like "do it right this time".  I squashed the
three commits into one with rebase -i, but git choked on the
intermediate empty commit.

I could have simply removed the first two commits I was squashing (the
initial version and its revert), but then would have lost the
well-written commit message that went with the first version.

I imagine an ideal version of this fix would make it so the use case I
presented here would work, but rebase -i would still prevent
introducing a new empty commit, or at least warn when it was
introducing one.  In the absence of that ideal fix, I think this
behavior is better than failing to handle this case.

 git-rebase--interactive.sh    |    2 +-
 t/t3404-rebase-interactive.sh |    9 +++++++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1560e84..81db5cf 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -403,7 +403,7 @@ do_next () {
 			GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
 			GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
 			GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
-			$USE_OUTPUT git commit --no-verify \
+			$USE_OUTPUT git commit --no-verify --allow-empty \
 				$MSG_OPT "$EDIT_OR_FILE" || failed=t
 		fi
 		if test $failed = t
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 3a37793..5eb9f7e 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -484,4 +484,13 @@ test_expect_success 'reword' '
 	git show HEAD~2 | grep "C changed"
 '

+test_expect_success 'squash including empty' '
+	test_commit Initial_emptysquash emptysquash abc &&
+	test_commit first_mod emptysquash abd &&
+	test_tick &&
+	git revert --no-edit HEAD &&
+	test_commit second_mod emptysquash abe &&
+	FAKE_LINES="1 squash 2 squash 3" git rebase -i Initial_emptysquash
+'
+
 test_done
-- 
1.6.6.196.g1f735
