From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Avoid update hook during git-rebase --interactive
Date: Wed, 19 Dec 2007 01:41:26 -0500
Message-ID: <20071219064125.GA8915@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 07:41:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4sct-0003LL-8V
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 07:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbXLSGlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 01:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbXLSGlc
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 01:41:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38953 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbXLSGlb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 01:41:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J4scR-00006m-VA; Wed, 19 Dec 2007 01:41:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 137A420FBAE; Wed, 19 Dec 2007 01:41:26 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68856>

If we are rebasing changes that contain potential whitespace
errors that our .git/hooks/pre-commit hook looks for and fails
on then git-commit will fail to commit that change.  This causes
git-rebase--interactive to squash commits together, even though it
was not requested to do so by the todo file.

Passing --no-verify to git-commit makes git-rebase -i behave more
like git-rebase normally would in such conditions, providing more
consistent behavior between the different rebase implementations.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This bug has bitten me more than once.  One could argue that the
 pre-commit hook should be running, to prevent you from rebasing a
 series that has crappy whitespace, but git-rebase without -m and
 without -i will let you rebase such a series without stopping you,
 as git-am doesn't execute the pre-commit hook.

 git-rebase--interactive.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index cd7e43f..b846ea8 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -296,7 +296,7 @@ do_next () {
 			GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
 			GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
 			GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
-			$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
+			$USE_OUTPUT git commit --no-verify -F "$MSG" $EDIT_COMMIT
 			;;
 		t)
 			cp "$MSG" "$GIT_DIR"/MERGE_MSG
@@ -372,7 +372,7 @@ do
 			test ! -f "$DOTEST"/amend || git reset --soft HEAD^
 		} &&
 		export GIT_AUTHOR_NAME GIT_AUTHOR_NAME GIT_AUTHOR_DATE &&
-		git commit -F "$DOTEST"/message -e
+		git commit --no-verify -F "$DOTEST"/message -e
 
 		require_clean_work_tree
 		do_rest
-- 
1.5.4.rc0.1155.g12ed9
