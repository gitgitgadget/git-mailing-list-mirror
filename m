From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH v2 RFC] rebase-i-p: only list commits that require rewriting in todo
Date: Wed,  8 Oct 2008 01:41:55 -0500
Message-ID: <90b5228cee1617efcb970f4e27b26c769f78a9bd.1223445353.git.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
 <e5ababa1de420b6460fd856679990c9dd2caf1d1.1223445353.git.stephen@exigencecorp.com>
 <e1cac64070f53f4f217a3b8e8c0f855f23691725.1223445353.git.stephen@exigencecorp.com>
 <90b5c351699999b5b4e4aa33475993661c26ee4c.1223445353.git.stephen@exigencecorp.com>
 <0d4d2cf9388866fe033f3545790fba6062fb1e1e.1223445353.git.stephen@exigencecorp.com>
Cc: spearce@spearce.org, Stephen Haberman <stephen@exigencecorp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 08:43:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnSlx-0006wy-AQ
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 08:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbYJHGmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 02:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753598AbYJHGmN
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 02:42:13 -0400
Received: from smtp132.sat.emailsrvr.com ([66.216.121.132]:32782 "EHLO
	smtp132.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbYJHGmD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 02:42:03 -0400
Received: from relay3.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 285F9253450;
	Wed,  8 Oct 2008 02:42:03 -0400 (EDT)
Received: by relay3.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 9915E253018;
	Wed,  8 Oct 2008 02:42:02 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <0d4d2cf9388866fe033f3545790fba6062fb1e1e.1223445353.git.stephen@exigencecorp.com>
In-Reply-To: <cover.1223445353.git.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97770>

This is heavily based on Stephan Beyer's git sequencer rewrite of rebase-i-p.

Each commit is still found by rev-list UPSTREAM..HEAD, but a commit is only
included in todo if at least one its parents has been marked for rewriting.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 git-rebase--interactive.sh |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0464bfb..7003ac0 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -561,9 +561,31 @@ first and then run 'git rebase --continue' again."
 		SHORTHEAD=$(git rev-parse --short $HEAD)
 		SHORTONTO=$(git rev-parse --short $ONTO)
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
-			--abbrev=7 --reverse --left-right --cherry-pick \
+			--abbrev=7 --reverse --left-right --cherry-pick --topo-order \
 			$UPSTREAM...$HEAD | \
-			sed -n "s/^>/pick /p" > "$TODO"
+			sed -n "s/^>//p" | while read shortsha1 rest
+		do
+			if test t != "$PRESERVE_MERGES"
+			then
+				echo "pick $shortsha1 $rest" >> "$TODO"
+			else
+				sha1=$(git rev-parse $shortsha1)
+				preserve=t
+				for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
+				do
+					if test -f "$REWRITTEN"/$p
+					then
+						preserve=f
+					fi
+				done
+				if test f = "$preserve"
+				then
+					touch "$REWRITTEN/$sha1"
+					echo "pick $shortsha1 $rest" >> "$TODO"
+				fi
+			fi
+		done
+
 		cat >> "$TODO" << EOF
 
 # Rebase $SHORTUPSTREAM..$SHORTHEAD onto $SHORTONTO
-- 
1.6.0.2
