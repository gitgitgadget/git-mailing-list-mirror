From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH v2 RFC] rebase-i-p: delay saving current-commit to REWRITTEN if squashing
Date: Wed,  8 Oct 2008 01:41:53 -0500
Message-ID: <90b5c351699999b5b4e4aa33475993661c26ee4c.1223445353.git.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
 <e5ababa1de420b6460fd856679990c9dd2caf1d1.1223445353.git.stephen@exigencecorp.com>
 <e1cac64070f53f4f217a3b8e8c0f855f23691725.1223445353.git.stephen@exigencecorp.com>
Cc: spearce@spearce.org, Stephen Haberman <stephen@exigencecorp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 08:43:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnSlv-0006wy-PT
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 08:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbYJHGmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 02:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753479AbYJHGmK
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 02:42:10 -0400
Received: from smtp132.sat.emailsrvr.com ([66.216.121.132]:61000 "EHLO
	smtp132.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbYJHGmD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 02:42:03 -0400
Received: from relay3.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 94A7D25342F;
	Wed,  8 Oct 2008 02:42:01 -0400 (EDT)
Received: by relay3.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id F1394253461;
	Wed,  8 Oct 2008 02:42:00 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <e1cac64070f53f4f217a3b8e8c0f855f23691725.1223445353.git.stephen@exigencecorp.com>
In-Reply-To: <cover.1223445353.git.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97768>

If the current-commit was dumped to REWRITTEN, but then we squash the next
commit in to it, we have invalidated the HEAD was just written to REWRITTEN.
Instead, append the squash hash to current-commit and save both of them the next
time around.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 git-rebase--interactive.sh |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b7eda66..8af425d 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -159,13 +159,18 @@ pick_one_preserving_merges () {
 
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
