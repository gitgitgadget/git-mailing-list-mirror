From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/4] patch-ids: use the new generic "sha1_pos" function to
 lookup sha1
Date: Sat, 4 Apr 2009 22:59:31 +0200
Message-ID: <20090404225931.7449a125.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 23:02:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqD0d-0001uP-Tf
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 23:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbZDDVAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 17:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbZDDVAl
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 17:00:41 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:52576 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754751AbZDDVAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 17:00:40 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5603F818134;
	Sat,  4 Apr 2009 23:00:31 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with SMTP id 04843818122;
	Sat,  4 Apr 2009 23:00:28 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115598>

instead of the specific one from which the new one has been copied.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 patch-ids.c |   93 +++-------------------------------------------------------
 1 files changed, 5 insertions(+), 88 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index 3be5d31..5717257 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "diff.h"
 #include "commit.h"
+#include "sha1-lookup.h"
 #include "patch-ids.h"
 
 static int commit_patch_id(struct commit *commit, struct diff_options *options,
@@ -15,99 +16,15 @@ static int commit_patch_id(struct commit *commit, struct diff_options *options,
 	return diff_flush_patch_id(options, sha1);
 }
 
-static uint32_t take2(const unsigned char *id)
+static const unsigned char *patch_id_access(size_t index, void *table)
 {
-	return ((id[0] << 8) | id[1]);
+	struct patch_id **id_table = table;
+	return id_table[index]->patch_id;
 }
 
-/*
- * Conventional binary search loop looks like this:
- *
- *      do {
- *              int mi = (lo + hi) / 2;
- *              int cmp = "entry pointed at by mi" minus "target";
- *              if (!cmp)
- *                      return (mi is the wanted one)
- *              if (cmp > 0)
- *                      hi = mi; "mi is larger than target"
- *              else
- *                      lo = mi+1; "mi is smaller than target"
- *      } while (lo < hi);
- *
- * The invariants are:
- *
- * - When entering the loop, lo points at a slot that is never
- *   above the target (it could be at the target), hi points at a
- *   slot that is guaranteed to be above the target (it can never
- *   be at the target).
- *
- * - We find a point 'mi' between lo and hi (mi could be the same
- *   as lo, but never can be the same as hi), and check if it hits
- *   the target.  There are three cases:
- *
- *    - if it is a hit, we are happy.
- *
- *    - if it is strictly higher than the target, we update hi with
- *      it.
- *
- *    - if it is strictly lower than the target, we update lo to be
- *      one slot after it, because we allow lo to be at the target.
- *
- * When choosing 'mi', we do not have to take the "middle" but
- * anywhere in between lo and hi, as long as lo <= mi < hi is
- * satisfied.  When we somehow know that the distance between the
- * target and lo is much shorter than the target and hi, we could
- * pick mi that is much closer to lo than the midway.
- */
 static int patch_pos(struct patch_id **table, int nr, const unsigned char *id)
 {
-	int hi = nr;
-	int lo = 0;
-	int mi = 0;
-
-	if (!nr)
-		return -1;
-
-	if (nr != 1) {
-		unsigned lov, hiv, miv, ofs;
-
-		for (ofs = 0; ofs < 18; ofs += 2) {
-			lov = take2(table[0]->patch_id + ofs);
-			hiv = take2(table[nr-1]->patch_id + ofs);
-			miv = take2(id + ofs);
-			if (miv < lov)
-				return -1;
-			if (hiv < miv)
-				return -1 - nr;
-			if (lov != hiv) {
-				/*
-				 * At this point miv could be equal
-				 * to hiv (but id could still be higher);
-				 * the invariant of (mi < hi) should be
-				 * kept.
-				 */
-				mi = (nr-1) * (miv - lov) / (hiv - lov);
-				if (lo <= mi && mi < hi)
-					break;
-				die("oops");
-			}
-		}
-		if (18 <= ofs)
-			die("cannot happen -- lo and hi are identical");
-	}
-
-	do {
-		int cmp;
-		cmp = hashcmp(table[mi]->patch_id, id);
-		if (!cmp)
-			return mi;
-		if (cmp > 0)
-			hi = mi;
-		else
-			lo = mi + 1;
-		mi = (hi + lo) / 2;
-	} while (lo < hi);
-	return -lo-1;
+	return sha1_pos(id, table, nr, patch_id_access);
 }
 
 #define BUCKET_SIZE 190 /* 190 * 21 = 3990, with slop close enough to 4K */
-- 
1.6.2.2.404.ge96f3.dirty
