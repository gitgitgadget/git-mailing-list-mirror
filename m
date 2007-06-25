From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] rebase -i: provide reasonable reflog for the rebased
 branch
Date: Mon, 25 Jun 2007 18:58:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706251857410.4059@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com, j.sixt@eudaptics.com
X-From: git-owner@vger.kernel.org Mon Jun 25 19:59:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2spz-0000NZ-Tq
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 19:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbXFYR6h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 13:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbXFYR6h
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 13:58:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:52028 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751334AbXFYR6g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 13:58:36 -0400
Received: (qmail invoked by alias); 25 Jun 2007 17:58:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 25 Jun 2007 19:58:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WR/pGMR5Wn1QUKk6wpIzm9+Rh+fy5HsyaaQ0YZA
	AY98Y7gvtacXsH
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50910>


If your rebase succeeded, the HEAD's reflog will still show the whole
mess, but "<branchname>@{1}" now shows the state _before_ the rebase,
so that you can reset (or compare) the original and the rebased
revisions more easily.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Johannes, how about this? ;-)

 git-rebase--interactive.sh    |   10 ++++++++--
 t/t3404-rebase-interactive.sh |    4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b95fe86..fb93e13 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -151,8 +151,14 @@ do_next () {
 	esac
 	test -s "$TODO" && return
 
-	HEAD=$(git rev-parse HEAD)
-	HEADNAME=$(cat "$DOTEST"/head-name)
+	comment_for_reflog finish &&
+	HEADNAME=$(cat "$DOTEST"/head-name) &&
+	OLDHEAD=$(cat "$DOTEST"/head) &&
+	SHORTONTO=$(git rev-parse --short $(cat "$DOTEST"/onto)) &&
+	NEWHEAD=$(git rev-parse HEAD) &&
+	message="$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO)" &&
+	git update-ref -m "$message" $HEADNAME $NEWHEAD $OLDHEAD &&
+	git symbolic-ref HEAD $HEADNAME &&
 	rm -rf "$DOTEST" &&
 	warn "Successfully rebased and updated $HEADNAME."
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 19a3a8e..9f12bb9 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -99,6 +99,10 @@ test_expect_success 'rebase on top of a non-conflicting commit' '
 	test $(git rev-parse I) = $(git rev-parse HEAD~2)
 '
 
+test_expect_success 'reflog for the branch shows state before rebase' '
+	test $(git rev-parse branch1@{1}) = $(git rev-parse original-branch1)
+'
+
 test_expect_success 'exchange two commits' '
 	FAKE_LINES="2 1" git rebase -i HEAD~2 &&
 	test H = $(git cat-file commit HEAD^ | tail -n 1) &&
-- 
1.5.2.2.3172.ge55a1-dirty
