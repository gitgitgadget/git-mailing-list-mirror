From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] diff [--cached] HEAD: catch updates to the current branch behind your back.
Date: Wed, 11 Apr 2007 13:58:17 -0700
Message-ID: <7vabxeocgm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 22:58:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbjtd-00028f-Cy
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 22:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbXDKU6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 16:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbXDKU6S
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 16:58:18 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:65068 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030369AbXDKU6R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 16:58:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411205817.GRXL1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 16:58:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lwyH1W00C1kojtg0000000; Wed, 11 Apr 2007 16:58:17 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44256>

This makes "git-diff [--cached] HEAD" issue a warning message
when it detects that your index is not based on the tip of the
current branch (e.g. updated by gremlins running git-send-pack
from elsewhere to update it, or from another working tree that
shares the same $GIT_DIR/refs with your working tree).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * This is on top of 'next', which contains 'jc/checkout' aka
   "index base" topic.

 diff-lib.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 5c5b05b..940c18a 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -657,6 +657,14 @@ int run_diff_index(struct rev_info *revs, int cached)
 	const char *tree_name;
 	int match_missing = 0;
 
+	/* Check for gremlins */
+	if (active_cache_base_valid &&
+	    revs->pending.objects->item->type == OBJ_COMMIT &&
+	    revs->pending.objects->name &&
+	    !strcmp(revs->pending.objects->name, "HEAD") &&
+	    hashcmp(active_cache_base, revs->pending.objects->item->sha1))
+		revs->diffopt.warning = "WARNING: HEAD and index BASE do not match";
+
 	/* 
 	 * Backward compatibility wart - "diff-index -m" does
 	 * not mean "do not ignore merges", but totally different.
-- 
1.5.1.777.gd14d3
