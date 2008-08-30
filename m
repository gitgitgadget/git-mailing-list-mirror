From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/12] xmerge.c: minimum readability fixups
Date: Fri, 29 Aug 2008 17:42:34 -0700
Message-ID: <1220056963-2352-4-git-send-email-gitster@pobox.com>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
 <1220056963-2352-2-git-send-email-gitster@pobox.com>
 <1220056963-2352-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 02:44:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEZN-00073m-1B
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 02:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbYH3Am5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbYH3Am4
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:42:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbYH3Amz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:42:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D313F6DC06
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:42:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EF0B86DC05 for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:42:53
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.149.ga4c44
In-Reply-To: <1220056963-2352-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 956CB152-762C-11DD-BED4-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94341>

This replaces hardcoded magic constants with symbolic ones for
readability, and swaps one if/else blocks to better match the
order in which 0/1/2 variables are handled to nearby codepath.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 xdiff/xmerge.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 29cdbea..7dcd405 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -427,7 +427,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 			xscr2 = xscr2->next;
 			continue;
 		}
-		if (level < 1 || xscr1->i1 != xscr2->i1 ||
+		if (level == XDL_MERGE_MINIMAL || xscr1->i1 != xscr2->i1 ||
 				xscr1->chg1 != xscr2->chg1 ||
 				xscr1->chg2 != xscr2->chg2 ||
 				xdl_merge_cmp_lines(xe1, xscr1->i2,
@@ -449,12 +449,11 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 			chg0 = xscr1->i1 + xscr1->chg1 - i0;
 			chg1 = xscr1->i2 + xscr1->chg2 - i1;
 			chg2 = xscr2->i2 + xscr2->chg2 - i2;
-			if (ffo > 0)
-				chg2 += ffo;
-			else {
+			if (ffo < 0) {
 				chg0 -= ffo;
 				chg1 -= ffo;
-			}
+			} else
+				chg2 += ffo;
 			if (xdl_append_merge(&c, 0,
 					     i0, chg0, i1, chg1, i2, chg2)) {
 				xdl_cleanup_merge(changes);
@@ -505,9 +504,10 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 	if (!changes)
 		changes = c;
 	/* refine conflicts */
-	if (level > 1 &&
+	if (XDL_MERGE_ZEALOUS <= level &&
 	    (xdl_refine_conflicts(xe1, xe2, changes, xpp) < 0 ||
-	     xdl_simplify_non_conflicts(xe1, changes, level > 2) < 0)) {
+	     xdl_simplify_non_conflicts(xe1, changes,
+					XDL_MERGE_ZEALOUS < level) < 0)) {
 		xdl_cleanup_merge(changes);
 		return -1;
 	}
-- 
1.6.0.1.149.ga4c44
