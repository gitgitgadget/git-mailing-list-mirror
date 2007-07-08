From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] rebase -i: actually show the diffstat when being verbose
Date: Sun, 8 Jul 2007 03:02:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707080301460.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 08 04:09:27 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7MDG-0000mo-Fu
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 04:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbXGHCJY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 22:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754743AbXGHCJY
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 22:09:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:51075 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754729AbXGHCJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 22:09:23 -0400
Received: (qmail invoked by alias); 08 Jul 2007 02:09:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 08 Jul 2007 04:09:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wUldJ2cxwUiI7QFoBf/vkUWRQiqEwYvbb72FrnS
	fcuk/Icwj/ebhP
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51856>


The "while" loop in the function do_rest is not supposed to ever be
exited.  Instead, the function do_one checks if there is nothing left,
and cleans up and exits if that is the case.  So the diffstat code
belongs there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 67f2ee2..84148a9 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -239,7 +239,10 @@ do_next () {
 	fi &&
 	message="$GIT_REFLOG_ACTION: $HEADNAME onto $SHORTONTO)" &&
 	git update-ref -m "$message" $HEADNAME $NEWHEAD $OLDHEAD &&
-	git symbolic-ref HEAD $HEADNAME &&
+	git symbolic-ref HEAD $HEADNAME && {
+		test ! -f "$DOTEST"/verbose ||
+			git diff --stat $(cat "$DOTEST"/head)..HEAD
+	} &&
 	rm -rf "$DOTEST" &&
 	warn "Successfully rebased and updated $HEADNAME."
 
@@ -251,9 +254,6 @@ do_rest () {
 	do
 		do_next
 	done
-	test -f "$DOTEST"/verbose &&
-		git diff --stat $(cat "$DOTEST"/head)..HEAD
-	exit
 }
 
 while case $# in 0) break ;; esac
-- 
1.5.3.rc0.2712.g125b7f
