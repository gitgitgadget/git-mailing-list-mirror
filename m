From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH v2 RFC] rebase-i-p: do not include non-first-parent commits touching UPSTREAM
Date: Wed,  8 Oct 2008 01:41:56 -0500
Message-ID: <c3ab1457d971985e349a0747178132c0c6f68b8a.1223445353.git.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
 <e5ababa1de420b6460fd856679990c9dd2caf1d1.1223445353.git.stephen@exigencecorp.com>
 <e1cac64070f53f4f217a3b8e8c0f855f23691725.1223445353.git.stephen@exigencecorp.com>
 <90b5c351699999b5b4e4aa33475993661c26ee4c.1223445353.git.stephen@exigencecorp.com>
 <0d4d2cf9388866fe033f3545790fba6062fb1e1e.1223445353.git.stephen@exigencecorp.com>
 <90b5228cee1617efcb970f4e27b26c769f78a9bd.1223445353.git.stephen@exigencecorp.com>
Cc: spearce@spearce.org, Stephen Haberman <stephen@exigencecorp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 08 08:43:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnSly-0006wy-Ql
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 08:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbYJHGmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 02:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbYJHGmS
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 02:42:18 -0400
Received: from smtp132.sat.emailsrvr.com ([66.216.121.132]:32785 "EHLO
	smtp132.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbYJHGmF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 02:42:05 -0400
Received: from relay3.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay3.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id D434825342F;
	Wed,  8 Oct 2008 02:42:03 -0400 (EDT)
Received: by relay3.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 5463B253018;
	Wed,  8 Oct 2008 02:42:03 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <90b5228cee1617efcb970f4e27b26c769f78a9bd.1223445353.git.stephen@exigencecorp.com>
In-Reply-To: <cover.1223445353.git.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97771>

This covers an odd boundary case found by Avi Kivity's script where a branch
coming off of UPSTREAM is merged into HEAD. Initially it show up in
UPSTREAM..HEAD, but technically UPSTREAM is not moving, the rest of head is, so
we should not need to rewrite the merge.

This adds a check saying we can keep `preserve=t` if `p=UPSTREAM`...unless this
is the first first-parent commit in our UPSTREAM..HEAD rev-list, which could
very well point to UPSTREAM, but we still need to consider it as rewritten so we
start pulling in the rest of the UPSTREAM..HEAD commits that point to it.

Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
---
 git-rebase--interactive.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 7003ac0..2e9270a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -553,6 +553,7 @@ first and then run 'git rebase --continue' again."
 					die "Could not init rewritten commits"
 			done
 			MERGES_OPTION=
+			first_after_upstream="$(git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1)"
 		else
 			MERGES_OPTION=--no-merges
 		fi
@@ -573,7 +574,7 @@ first and then run 'git rebase --continue' again."
 				preserve=t
 				for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -f2-)
 				do
-					if test -f "$REWRITTEN"/$p
+					if test -f "$REWRITTEN"/$p -a \( $p != $UPSTREAM -o $sha1 = $first_after_upstream \)
 					then
 						preserve=f
 					fi
-- 
1.6.0.2
