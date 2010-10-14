From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v6 4/5] [RFC] Consider all parents of a file as candidates for bulk rename.
Date: Fri, 15 Oct 2010 01:29:58 +0200
Message-ID: <1287098999-9244-5-git-send-email-ydirson@altern.org>
References: <1287098999-9244-1-git-send-email-ydirson@altern.org>
 <1287098999-9244-2-git-send-email-ydirson@altern.org>
 <1287098999-9244-3-git-send-email-ydirson@altern.org>
 <1287098999-9244-4-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>, Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 15 01:20:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6X5l-00046c-AL
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 01:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018Ab0JNXTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 19:19:20 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:40477 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755770Ab0JNXTP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 19:19:15 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id A1CC7D48049;
	Fri, 15 Oct 2010 01:19:08 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P6XFK-0002Q5-1K; Fri, 15 Oct 2010 01:30:02 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1287098999-9244-4-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159085>

We previously only looked at the immediate parents of a file involved
in a move.  Now consider upper ones as candidates too.

The way it is done here is somewhat inefficient, but at least it
handles all previously-known cases of incorrectness.

Note this patch largely puts existing code in a look, and is a bit
easier to read with -w.

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 diffcore-rename.c |  118 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 63 insertions(+), 55 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1be1af1..ff69201 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -542,7 +542,7 @@ static int maybe_disqualify_bulkmove(const char* one_parent_path,
 		if (strncmp(rename_dst[j].two->path,
 			    one_parent_path, onep_len))
 			break; /* exhausted directory in this direction */
-		fprintf(stderr, "[DBG] leftover file %s in %s\n",
+		fprintf(stderr, "[DBG] leftover file %s in '%s'\n",
 			rename_dst[j].two->path, one_parent_path);
 		if (rename_dst[j].i_am_not_single || /* those were already here */
 		    (rename_dst[j].pair &&
@@ -596,66 +596,74 @@ static void check_one_bulk_move(struct diff_filepair *dstpair)
 	    maybe_disqualify_bulkmove(one_parent_path, one_leftover))
 		return;
 
-	fprintf(stderr, "[] %s -> %s ?\n",dstpair->one->path, dstpair->two->path);
+	fprintf(stderr, "[] %s -> %s ?\n", dstpair->one->path, dstpair->two->path);
 
-	// FIXME: loop over successive prefixes
-	unsigned needs_adding = 1;
+	// loop over successive prefixes
+	// FIXME: also loop over two_parent_path prefixes ?
+	do {
+		unsigned needs_adding = 1;
 
-	/* already considered ? */
-	for (seen=bulkmove_candidates; seen; seen = seen->next) {
-		if (seen->discarded) {
-			/* already seen a rename from seen->one to some than ->two */
-			needs_adding = 0;
-			continue;
-		}
-		/* check exact dir */
-		if (!strcmp(seen->one->path, one_parent_path)) {
-			/* already added */
-			needs_adding = 0;
-			/* check that seen entry matches this rename */
-			if (strcmp(two_parent_path, seen->two->path)) {
-				fprintf(stderr, "[DBG] discarding dir %s from bulk moves (split into %s and %s)\n",
-					seen->one->path, two_parent_path, seen->two->path);
-				// FIXME: may be worth to free it instead
-				seen->discarded = 1;
-			}
-			continue;
-		}
-		if (!prefixcmp(one_parent_path, seen->one->path)) {
-			if (prefixcmp(two_parent_path, seen->two->path)) {
-				fprintf(stderr, "[DBG] discarding dir %s from bulk moves (split into %s and %s)\n",
-					seen->one->path, two_parent_path, seen->two->path);
-				// FIXME: may be worth to free it instead
-				seen->discarded = 1;
+		fprintf(stderr, "[[]] %s ...\n", one_parent_path);
+
+		/* already considered ? */
+		for (seen=bulkmove_candidates; seen; seen = seen->next) {
+			if (seen->discarded) {
+				/* already seen a rename from seen->one to some than ->two */
+				needs_adding = 0;
 				continue;
 			}
-		} else {
-			fprintf(stderr, "[DBG]  %s considered irrelevant for %s -> %s\n",
-				dstpair->one->path, seen->one->path, seen->two->path);
-			continue;
+			fprintf(stderr, "[DBG]  ? %s -> %s\n", seen->one->path, seen->two->path);
+			/* subdir of "seen" source dir ? */
+			if (!prefixcmp(one_parent_path, seen->one->path)) {
+				/* subdir of "seen" dest dir ? */
+				if (!prefixcmp(two_parent_path, seen->two->path)) {
+					if (!strcmp(seen->one->path, one_parent_path) &&
+					    !strcmp(seen->two->path, two_parent_path)) {
+						/* already added */
+						fprintf(stderr, "[DBG] already added\n");
+						needs_adding = 0;
+					} else // confirms
+						fprintf(stderr, "[DBG]  'dstpair' conforts 'seen'\n");
+				} else {
+					fprintf(stderr, "[DBG] discarding %s -> %s from bulk moves (split into %s and %s)\n",
+						seen->one->path, seen->two->path,
+						two_parent_path, seen->two->path);
+					// FIXME: may be worth to free it instead
+					seen->discarded = 1;
+					if (!strcmp(seen->one->path, one_parent_path) &&
+					    prefixcmp(seen->two->path, two_parent_path)) {
+						fprintf(stderr, "[DBG] ... and not adding self\n");
+						needs_adding = 0;
+					}
+					continue;
+				}
+			}
+			else fprintf(stderr, "[DBG]  'dstpair' unrelated to 'seen'\n");
+
+			/* dstpair confirms seen, or does not infirm */
+			fprintf(stderr, "[DBG] %s -> %s DOES NOT cause discard of %s -> %s\n",
+				dstpair->one->path, dstpair->two->path,
+				seen->one->path, seen->two->path);
+		}
+		if (needs_adding) { /* record potential dir rename */
+			/* all checks ok, we keep that entry */
+			seen = xmalloc(sizeof(*seen));
+			seen->one = alloc_filespec(one_parent_path);
+			fill_filespec(seen->one, null_sha1, S_IFDIR);
+			seen->two = alloc_filespec(two_parent_path);
+			fill_filespec(seen->two, null_sha1, S_IFDIR);
+			seen->discarded = 0;
+			seen->next = bulkmove_candidates;
+			bulkmove_candidates = seen;
+			fprintf(stderr, "[DBG] %s -> %s suggests possible bulk move from %s to %s\n",
+				dstpair->one->path,
+				dstpair->two->path,
+				one_parent_path, two_parent_path);
 		}
 
-		/* dstpair confirms seen */
-		fprintf(stderr, "[DBG] %s -> %s DOES NOT cause discard of %s -> %s\n",
-			dstpair->one->path, dstpair->two->path,
-			seen->one->path, seen->two->path);
-	}
-	if (needs_adding) { /* record potential dir rename */
-		/* all checks ok, we keep that entry */
-		seen = xmalloc(sizeof(*seen));
-		seen->one = alloc_filespec(one_parent_path);
-		fill_filespec(seen->one, null_sha1, S_IFDIR);
-		seen->two = alloc_filespec(two_parent_path);
-		fill_filespec(seen->two, null_sha1, S_IFDIR);
-		seen->discarded = 0;
-		seen->next = bulkmove_candidates;
-		bulkmove_candidates = seen;
-		fprintf(stderr, "[DBG] %s -> %s suggests possible bulk move from %s to %s\n",
-			dstpair->one->path,
-			dstpair->two->path,
-			one_parent_path, two_parent_path);
-		return;
-	}
+		/* next parent if any */
+		copy_dirname(one_parent_path, one_parent_path);
+	} while (*one_parent_path);
 }
 
 /*
-- 
1.7.2.3
