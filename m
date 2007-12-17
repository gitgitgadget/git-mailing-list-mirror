From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] rebase -p -i: handle "no changes" gracefully
Date: Mon, 17 Dec 2007 16:59:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171649420.9446@racer.site>
References: <2791F15A-EB72-4FE4-8DB3-7A4B4DCB07B3@frim.nl> <47623129.2030303@viscovery.net>
 <9CC305E7-3325-4D17-A43E-0A2072F52084@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Mon Dec 17 18:03:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4JKE-0002zd-7j
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 18:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbXLQQ7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 11:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbXLQQ7y
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 11:59:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:50196 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752325AbXLQQ7x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 11:59:53 -0500
Received: (qmail invoked by alias); 17 Dec 2007 16:59:51 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 17 Dec 2007 17:59:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fItFT0jefink0zirqZgaLfEcsukBY3jZZhqLpbO
	tbzLk66QiJoi+Z
X-X-Sender: gene099@racer.site
In-Reply-To: <9CC305E7-3325-4D17-A43E-0A2072F52084@ai.rug.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68580>


Since commit 376ccb8cbb453343998e734d8a1ce79f57a4e092, unchanged
SHA-1s are no longer mapped via $REWRITTEN.  But the updating
phase was not prepared for the old head not being rewritten.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 17 Dec 2007, Pieter de Bie wrote:

	> Ok, but what about the error in the rebase?
	> 
	> On Dec 14, 2007, at 2:21 AM, Pieter de Bie wrote:
	> > Tirana:~/git pieter$ time git rebase -p -i HEAD~100
	> > cat:
	> > /Users/pieter/git/.git/.dotest-merge/rewritten/1e8df762b38e01685f3aa3613e2d61f73346fcbe:
	> > No such file or directory

	This buglet was not caught earlier, probably because a 
	non-rewriting rebase is not really interesting ;-)

 git-rebase--interactive.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

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
-- 
1.5.4.rc0.59.g1d10d
