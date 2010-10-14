From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v6 3/5] [RFC] Handle the simpler case of a subdir invalidating bulk move.
Date: Fri, 15 Oct 2010 01:29:57 +0200
Message-ID: <1287098999-9244-4-git-send-email-ydirson@altern.org>
References: <1287098999-9244-1-git-send-email-ydirson@altern.org>
 <1287098999-9244-2-git-send-email-ydirson@altern.org>
 <1287098999-9244-3-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>, Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 15 01:20:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6X5k-00046c-QD
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 01:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020Ab0JNXTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 19:19:19 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:40506 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755991Ab0JNXTR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 19:19:17 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 7C260D48037;
	Fri, 15 Oct 2010 01:19:11 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P6XFJ-0002Q2-Ul; Fri, 15 Oct 2010 01:30:01 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1287098999-9244-3-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159080>

Doing it so simply depends on the subdir moves being noticed later,
this fixes only one of the remaining failing testcases.  Doing better
requires real handling of deep trees, which is addressed by next
patch, but add much complexity.

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 diffcore-rename.c |   59 ++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index f252da7..1be1af1 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -596,10 +596,52 @@ static void check_one_bulk_move(struct diff_filepair *dstpair)
 	    maybe_disqualify_bulkmove(one_parent_path, one_leftover))
 		return;
 
+	fprintf(stderr, "[] %s -> %s ?\n",dstpair->one->path, dstpair->two->path);
+
+	// FIXME: loop over successive prefixes
+	unsigned needs_adding = 1;
+
 	/* already considered ? */
-	for (seen=bulkmove_candidates; seen; seen = seen->next)
-		if (!strcmp(seen->one->path, one_parent_path)) break;
-	if (!seen) { /* record potential dir rename */
+	for (seen=bulkmove_candidates; seen; seen = seen->next) {
+		if (seen->discarded) {
+			/* already seen a rename from seen->one to some than ->two */
+			needs_adding = 0;
+			continue;
+		}
+		/* check exact dir */
+		if (!strcmp(seen->one->path, one_parent_path)) {
+			/* already added */
+			needs_adding = 0;
+			/* check that seen entry matches this rename */
+			if (strcmp(two_parent_path, seen->two->path)) {
+				fprintf(stderr, "[DBG] discarding dir %s from bulk moves (split into %s and %s)\n",
+					seen->one->path, two_parent_path, seen->two->path);
+				// FIXME: may be worth to free it instead
+				seen->discarded = 1;
+			}
+			continue;
+		}
+		if (!prefixcmp(one_parent_path, seen->one->path)) {
+			if (prefixcmp(two_parent_path, seen->two->path)) {
+				fprintf(stderr, "[DBG] discarding dir %s from bulk moves (split into %s and %s)\n",
+					seen->one->path, two_parent_path, seen->two->path);
+				// FIXME: may be worth to free it instead
+				seen->discarded = 1;
+				continue;
+			}
+		} else {
+			fprintf(stderr, "[DBG]  %s considered irrelevant for %s -> %s\n",
+				dstpair->one->path, seen->one->path, seen->two->path);
+			continue;
+		}
+
+		/* dstpair confirms seen */
+		fprintf(stderr, "[DBG] %s -> %s DOES NOT cause discard of %s -> %s\n",
+			dstpair->one->path, dstpair->two->path,
+			seen->one->path, seen->two->path);
+	}
+	if (needs_adding) { /* record potential dir rename */
+		/* all checks ok, we keep that entry */
 		seen = xmalloc(sizeof(*seen));
 		seen->one = alloc_filespec(one_parent_path);
 		fill_filespec(seen->one, null_sha1, S_IFDIR);
@@ -614,17 +656,6 @@ static void check_one_bulk_move(struct diff_filepair *dstpair)
 			one_parent_path, two_parent_path);
 		return;
 	}
-	if (seen->discarded)
-		/* already seen a rename from seen->one to some than ->two */
-		return;
-	/* check that seen entry matches this rename */
-	if (strcmp(two_parent_path, seen->two->path)) {
-		fprintf(stderr, "[DBG] discarding dir %s from bulk moves (split into %s and %s)\n",
-			one_parent_path, two_parent_path, seen->two->path);
-		seen->discarded = 1;
-	}
-
-	/* all checks ok, we keep that entry */
 }
 
 /*
-- 
1.7.2.3
