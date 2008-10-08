From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH v2 RFC] rebase-i-p: if todo was reordered use HEAD as the rewritten parent
Date: Wed,  8 Oct 2008 01:41:57 -0500
Message-ID: <211dfcea6f13f8ddb3153add3bfa3395c4a7e8c8.1223445353.git.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
 <e5ababa1de420b6460fd856679990c9dd2caf1d1.1223445353.git.stephen@exigencecorp.com>
 <e1cac64070f53f4f217a3b8e8c0f855f23691725.1223445353.git.stephen@exigencecorp.com>
 <90b5c351699999b5b4e4aa33475993661c26ee4c.1223445353.git.stephen@exigencecorp.com>
 <0d4d2cf9388866fe033f3545790fba6062fb1e1e.1223445353.git.stephen@exigencecorp.com>
 <90b5228cee1617efcb970f4e27b26c769f78a9bd.1223445353.git.stephen@exigencecorp.com>
 <c3ab1457d971985e349a0747178132c0c6f68b8a.1223445353.git.stephen@exigencecorp.com>
Cc: spearce@spearce.org, Stephen Haberman <stephen@exigencecorp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 08:43:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnSly-0006wy-2X
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 08:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbYJHGmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 02:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbYJHGmO
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 02:42:14 -0400
Received: from smtp132.sat.emailsrvr.com ([66.216.121.132]:32782 "EHLO
	smtp132.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbYJHGmF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 02:42:05 -0400
Received: from relay3.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 8F39A2534AF;
	Wed,  8 Oct 2008 02:42:04 -0400 (EDT)
Received: by relay3.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 0E9F3253461;
	Wed,  8 Oct 2008 02:42:03 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <c3ab1457d971985e349a0747178132c0c6f68b8a.1223445353.git.stephen@exigencecorp.com>
In-Reply-To: <cover.1223445353.git.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97769>

This seems like the best guess we can make until git sequencer marks are
available. That being said, within the context of re-ordering a commit before
its parent in todo, I think applying it on top of the current commit seems like
a reasonable assumption of what the user intended.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 git-rebase--interactive.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2e9270a..8a22d78 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -179,6 +179,15 @@ pick_one_preserving_merges () {
 		if test -f "$REWRITTEN"/$p
 		then
 			new_p=$(cat "$REWRITTEN"/$p)
+
+			# If the todo reordered commits, and our parent is marked for
+			# rewriting, but hasn't been gotten to yet, assume the user meant to
+			# drop it on top of the current HEAD
+			if test -z "$new_p"
+			then
+				new_p=$(git rev-parse HEAD)
+			fi
+
 			test $p != $new_p && fast_forward=f
 			case "$new_parents" in
 			*$new_p*)
-- 
1.6.0.2
