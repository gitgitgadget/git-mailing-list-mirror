From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] rebase-i-p: delay saving current-commit to REWRITTEN if squashing
Date: Wed, 15 Oct 2008 02:44:36 -0500
Message-ID: <759654ef1f1781cd2b102e21c6f972b065560398.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
 <79b3f186dc599ebb5e251d5c0ca93c233263974c.1224055978.git.stephen@exigencecorp.com>
 <ef8c08551dca1ddfea0017fd4026ac9ae60fbfec.1224055978.git.stephen@exigencecorp.com>
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 15 09:46:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq150-00012V-Pi
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbYJOHot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbYJOHos
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:44:48 -0400
Received: from smtp162.sat.emailsrvr.com ([66.216.121.162]:49874 "EHLO
	smtp162.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbYJOHoq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:44:46 -0400
Received: from relay6.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 008831E06AF;
	Wed, 15 Oct 2008 03:44:46 -0400 (EDT)
Received: by relay6.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 77EC61E0660;
	Wed, 15 Oct 2008 03:44:45 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <ef8c08551dca1ddfea0017fd4026ac9ae60fbfec.1224055978.git.stephen@exigencecorp.com>
In-Reply-To: <cover.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98245>

If the current-commit was dumped to REWRITTEN, but then we squash the next
commit in to it, we have invalidated the HEAD was just written to REWRITTEN.
Instead, append the squash hash to current-commit and save both of them the next
time around.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 git-rebase--interactive.sh |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c968117..23cf7a5 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -170,13 +170,18 @@ pick_one_preserving_merges () {
 
 	if test -f "$DOTEST"/current-commit
 	then
-		current_commit=$(cat "$DOTEST"/current-commit) &&
-		git rev-parse HEAD > "$REWRITTEN"/$current_commit &&
-		rm "$DOTEST"/current-commit ||
-		die "Cannot write current commit's replacement sha1"
+		if [ "$fast_forward" == "t" ]
+		then
+			cat "$DOTEST"/current-commit | while read current_commit
+			do
+				git rev-parse HEAD > "$REWRITTEN"/$current_commit
+			done
+			rm "$DOTEST"/current-commit ||
+			die "Cannot write current commit's replacement sha1"
+		fi
 	fi
 
-	echo $sha1 > "$DOTEST"/current-commit
+	echo $sha1 >> "$DOTEST"/current-commit
 
 	# rewrite parents; if none were rewritten, we can fast-forward.
 	new_parents=
-- 
1.6.0.2
