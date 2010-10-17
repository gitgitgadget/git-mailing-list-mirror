From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v6.1] [RFC] Consider all parents of a file as candidates for bulk rename.
Date: Sun, 17 Oct 2010 21:24:03 +0200
Message-ID: <1287343443-23098-1-git-send-email-ydirson@altern.org>
References: <1287098999-9244-5-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>, Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 17 21:24:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7YqM-0004Yr-T8
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 21:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650Ab0JQTYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 15:24:16 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:50631 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932644Ab0JQTYO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 15:24:14 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 80E5CD4817C;
	Sun, 17 Oct 2010 21:24:07 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P7Ypy-00061D-8g; Sun, 17 Oct 2010 21:24:06 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1287098999-9244-5-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159213>

We previously only looked at the immediate parents of a file involved
in a move.  Now consider upper ones as candidates too.

The way it is done here is somewhat inefficient, but at least it
handles all previously-known cases of incorrectness.

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 diffcore-rename.c |  120 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 63 insertions(+), 57 deletions(-)

There was a major flaw in the first iteration of this patch (never
looking again at discarded renames).  This iteration also adds more
explicit comments about why this piece of code should work, despite
having been written late at night and having already shown one problem
which demonstrated that a testsuite is no replacement for a good night
of sleep :)

I'm still not happy with the thing, though - the loops can surely be
made shorter by using the discarded flags previously set, and more
importantly we need to consider moves to parents of the file's
destination too, which will add a loop of its own which will have to
be made as short as possible.  All of this seems to require to sort
bulkmove_candidates so we can binary-search into it and rapidly access
related paths.

Other opinions on the spirit of this patch still gladly welcome :)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 1be1af1..a8f3a8b 100644
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
@@ -596,66 +596,72 @@ static void check_one_bulk_move(struct diff_filepair *dstpair)
 	    maybe_disqualify_bulkmove(one_parent_path, one_leftover))
 		return;
 
-	fprintf(stderr, "[] %s -> %s ?\n",dstpair->one->path, dstpair->two->path);
-
-	// FIXME: loop over successive prefixes
-	unsigned needs_adding = 1;
+	fprintf(stderr, "[] %s -> %s ?\n", dstpair->one->path, dstpair->two->path);
 
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
+	/* loop up one_parent_path over successive parents */
+	// FIXME: also loop over two_parent_path prefixes ?
+	// FIXME: use a more informative prefixcmp to avoid strcmp calls
+	do {
+		unsigned needs_adding = 1;
+
+		fprintf(stderr, "[[]] %s ...\n", one_parent_path);
+
+		/* already considered ? */
+		for (seen=bulkmove_candidates; seen; seen = seen->next) {
+			fprintf(stderr, "[DBG]  ? %s -> %s\n", seen->one->path, seen->two->path);
+			/* subdir of "seen" source dir ? */
+			if (!prefixcmp(one_parent_path, seen->one->path)) {
+				/* subdir of "seen" dest dir ? */
+				if (!prefixcmp(two_parent_path, seen->two->path)) {
+					if (!strcmp(seen->one->path, one_parent_path) &&
+					    !strcmp(seen->two->path, two_parent_path)) {
+						/* already added */
+						fprintf(stderr, "[DBG]  already added\n");
+						needs_adding = 0;
+					} else /* is in a subdir: confirms but still
+						* may need adding */
+						fprintf(stderr, "[DBG]  'dstpair' conforts 'seen'\n");
+				} else {
+					fprintf(stderr, "[DBG] discarding %s -> %s from bulk moves (split into %s and %s)\n",
+						seen->one->path, seen->two->path,
+						two_parent_path, seen->two->path);
+					seen->discarded = 1;
+					/* Need to discard dstpair as well, unless moving
+					 * from a strict subdir of seen->one or to a
+					 * strict subdir of seen->two */
+					if (!strcmp(seen->one->path, one_parent_path) &&
+					    prefixcmp(seen->two->path, two_parent_path)) {
+						fprintf(stderr, "[DBG] ... and not adding self\n");
+						needs_adding = 0;
+					}
+					continue;
+				}
 			}
-			continue;
+			else fprintf(stderr, "[DBG]  %s outside of %s\n",
+				     one_parent_path, seen->one->path);
+
+			/* dstpair confirms seen, or does not infirm */
+			fprintf(stderr, "[DBG] %s -> %s DOES NOT cause discard of %s -> %s\n",
+				dstpair->one->path, dstpair->two->path,
+				seen->one->path, seen->two->path);
 		}
-		if (!prefixcmp(one_parent_path, seen->one->path)) {
-			if (prefixcmp(two_parent_path, seen->two->path)) {
-				fprintf(stderr, "[DBG] discarding dir %s from bulk moves (split into %s and %s)\n",
-					seen->one->path, two_parent_path, seen->two->path);
-				// FIXME: may be worth to free it instead
-				seen->discarded = 1;
-				continue;
-			}
-		} else {
-			fprintf(stderr, "[DBG]  %s considered irrelevant for %s -> %s\n",
-				dstpair->one->path, seen->one->path, seen->two->path);
-			continue;
+		if (needs_adding) { /* record potential dir rename */
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
-
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
