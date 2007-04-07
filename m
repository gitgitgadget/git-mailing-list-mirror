From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/5] Treat D/F conflict entry more carefully in unpack-trees.c::threeway_merge()
Date: Sat, 07 Apr 2007 07:40:42 -0700
Message-ID: <7vabxkcknp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 16:42:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaC5u-00040y-Tu
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 16:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965908AbXDGOko (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 10:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965907AbXDGOko
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 10:40:44 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:56044 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965908AbXDGOkn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 10:40:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070407144042.QQWY24385.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 7 Apr 2007 10:40:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kEgi1W0011kojtg0000000; Sat, 07 Apr 2007 10:40:42 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43968>

This fixes three buglets in threeway_merge() regarding D/F
conflict entries.

* After finishing with path D and handling path D/F, some stages
  have D/F conflict entry which are obviously non-NULL.  For the
  purpose of determining if the path D/F is missing in the
  ancestor, they should not be taken into account.

* D/F conflict entry is a phony entry and does not record the
  path being processed, so do not pick up the name from there.

* D/F conflict entry is a marker to say "this stage does _not_
  have the path", so do not send them to keep_entry().

There might be more glitches, but I am slowly digging this mess
through, which unfortunately was made even more work since
merge-recursive is a built-in now.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 unpack-trees.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index a0b6769..4039653 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -675,10 +675,10 @@ int threeway_merge(struct cache_entry **stages,
 	int i;
 
 	for (i = 1; i < o->head_idx; i++) {
-		if (!stages[i])
+		if (!stages[i] || stages[i] == o->df_conflict_entry)
 			any_anc_missing = 1;
 		else {
-			if (!path)
+			if (!path && stages[i] != o->df_conflict_entry)
 				path = stages[i]->name;
 			no_anc_exists = 0;
 		}
@@ -790,7 +790,7 @@ int threeway_merge(struct cache_entry **stages,
 	count = 0;
 	if (!head_match || !remote_match) {
 		for (i = 1; i < o->head_idx; i++) {
-			if (stages[i]) {
+			if (stages[i] && stages[i] != o->df_conflict_entry) {
 				keep_entry(stages[i], o);
 				count++;
 				break;
-- 
1.5.1.81.gee969
