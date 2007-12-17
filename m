From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH w/ test] rebase -p -i: handle "no changes" gracefully
Date: Mon, 17 Dec 2007 21:01:25 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712172100450.9446@racer.site>
References: <2791F15A-EB72-4FE4-8DB3-7A4B4DCB07B3@frim.nl> <47623129.2030303@viscovery.net>
 <9CC305E7-3325-4D17-A43E-0A2072F52084@ai.rug.nl> <Pine.LNX.4.64.0712171649420.9446@racer.site>
 <7vprx56pfn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:02:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4N6J-0007zc-KL
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 22:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761523AbXLQVBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 16:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761350AbXLQVBp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 16:01:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:38323 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754607AbXLQVBo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 16:01:44 -0500
Received: (qmail invoked by alias); 17 Dec 2007 21:01:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 17 Dec 2007 22:01:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YZqdrQoxYYic1QrDZYHulWWxO67LFFlZ3X7t60k
	AzLr58+scXiJIb
X-X-Sender: gene099@racer.site
In-Reply-To: <7vprx56pfn.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68621>


Since commit 376ccb8cbb453343998e734d8a1ce79f57a4e092, unchanged
SHA-1s are no longer mapped via $REWRITTEN.  But the updating
phase was not prepared for the old head not being rewritten.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 17 Dec 2007, Junio C Hamano wrote:

	> Hmph, care to add a test to t3404?

	How about this?

 git-rebase--interactive.sh    |    7 ++++++-
 t/t3404-rebase-interactive.sh |    6 ++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f83e00f..cd7e43f 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -322,7 +322,12 @@ do_next () {
 		test -f "$DOTEST"/current-commit &&
 			current_commit=$(cat "$DOTEST"/current-commit) &&
 			git rev-parse HEAD > "$REWRITTEN"/$current_commit
-		NEWHEAD=$(cat "$REWRITTEN"/$OLDHEAD)
+		if test -f "$REWRITTEN"/$OLDHEAD
+		then
+			NEWHEAD=$(cat "$REWRITTEN"/$OLDHEAD)
+		else
+			NEWHEAD=$OLDHEAD
+		fi
 	else
 		NEWHEAD=$(git rev-parse HEAD)
 	fi &&
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 907c7f9..74a7eb3 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -184,6 +184,12 @@ test_expect_success 'retain authorship when squashing' '
 	git show HEAD | grep "^Author: Twerp Snog"
 '
 
+test_expect_success '-p handles "no changes" gracefully' '
+	HEAD=$(git rev-parse HEAD) &&
+	git rebase -i -p HEAD^ &&
+	test $HEAD = $(git rev-parse HEAD)
+'
+
 test_expect_success 'preserve merges with -p' '
 	git checkout -b to-be-preserved master^ &&
 	: > unrelated-file &&
-- 
1.5.4.rc0.59.g1d10d
