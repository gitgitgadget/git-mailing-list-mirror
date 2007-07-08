From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/3] rebase -i: remember the settings of -v, -s and -p when
 interrupted
Date: Sun, 8 Jul 2007 03:02:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707080302370.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 08 04:10:02 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7MDp-0000qI-FS
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 04:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797AbXGHCJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 22:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754785AbXGHCJ7
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 22:09:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:40675 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754743AbXGHCJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 22:09:58 -0400
Received: (qmail invoked by alias); 08 Jul 2007 02:09:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 08 Jul 2007 04:09:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jt70O49wjY1gLa+3y7VNcZntThQrzLnOwq3jNkt
	Yc9I1QSnQoTYE0
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51857>


After interruption, be that an edit, or a conflicting commit, reset
the variables VERBOSE, STRATEGY and PRESERVE_MERGES, so that the
user does not have to respecify them with "rebase --continue".

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-rebase--interactive.sh    |    4 ++++
 t/t3404-rebase-interactive.sh |   10 ++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 84148a9..a9bb622 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -23,6 +23,9 @@ REWRITTEN="$DOTEST"/rewritten
 PRESERVE_MERGES=
 STRATEGY=
 VERBOSE=
+test -d "$REWRITTEN" && PRESERVE_MERGES=t
+test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
+test -f "$DOTEST"/verbose && VERBOSE=t
 
 warn () {
 	echo "$*" >&2
@@ -365,6 +368,7 @@ do
 		echo $HEAD > "$DOTEST"/head
 		echo $UPSTREAM > "$DOTEST"/upstream
 		echo $ONTO > "$DOTEST"/onto
+		test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
 		test t = "$VERBOSE" && : > "$DOTEST"/verbose
 		if [ t = "$PRESERVE_MERGES" ]
 		then
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index c251336..43a6675 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -202,4 +202,14 @@ test_expect_success '--continue tries to commit' '
 	git show HEAD | grep chouette
 '
 
+test_expect_success 'verbose flag is heeded, even after --continue' '
+	git reset --hard HEAD@{1} &&
+	test_tick &&
+	! git rebase -v -i --onto new-branch1 HEAD^ &&
+	echo resolved > file1 &&
+	git add file1 &&
+	git rebase --continue > output &&
+	grep "^ file1 |    2 +-$" output
+'
+
 test_done
-- 
1.5.3.rc0.2712.g125b7f
