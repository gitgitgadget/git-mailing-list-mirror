From: Stephen Haberman <stephen@exigencecorp.com>
Subject: [PATCH] rebase-i-p: do not include non-first-parent commits touching UPSTREAM
Date: Wed, 15 Oct 2008 02:44:39 -0500
Message-ID: <3fd41e60ed27b248f15c60d5a45e543a7e32af99.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
 <79b3f186dc599ebb5e251d5c0ca93c233263974c.1224055978.git.stephen@exigencecorp.com>
 <ef8c08551dca1ddfea0017fd4026ac9ae60fbfec.1224055978.git.stephen@exigencecorp.com>
 <759654ef1f1781cd2b102e21c6f972b065560398.1224055978.git.stephen@exigencecorp.com>
 <ab80b829ebfa597dc4aaac6e49f9907e505adf59.1224055978.git.stephen@exigencecorp.com>
 <0977b23f6c709d4aea76de7a88e9fe17272b31ea.1224055978.git.stephen@exigencecorp.com>
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 15 09:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq15k-0001GN-8I
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944AbYJOHpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbYJOHow
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:44:52 -0400
Received: from smtp162.sat.emailsrvr.com ([66.216.121.162]:49879 "EHLO
	smtp162.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbYJOHos (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:44:48 -0400
Received: from relay6.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id 257FE1E06B1;
	Wed, 15 Oct 2008 03:44:48 -0400 (EDT)
Received: by relay6.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 9CD761E0660;
	Wed, 15 Oct 2008 03:44:47 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <0977b23f6c709d4aea76de7a88e9fe17272b31ea.1224055978.git.stephen@exigencecorp.com>
In-Reply-To: <cover.1224055978.git.stephen@exigencecorp.com>
References: <cover.1224055978.git.stephen@exigencecorp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98251>

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
index 331cb18..3821692 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -583,6 +583,7 @@ first and then run 'git rebase --continue' again."
 			# parents to rewrite and skipping dropped commits would
 			# prematurely end our probe
 			MERGES_OPTION=
+			first_after_upstream="$(git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1)"
 		else
 			MERGES_OPTION="--no-merges --cherry-pick"
 		fi
@@ -603,7 +604,7 @@ first and then run 'git rebase --continue' again."
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
