From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v8 4/5] Unified diff output format for bulk moves.
Date: Fri, 29 Oct 2010 00:08:31 +0200
Message-ID: <1288303712-14662-5-git-send-email-ydirson@altern.org>
References: <1288303712-14662-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>, Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 00:09:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBaf0-0002AX-31
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 00:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760139Ab0J1WI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 18:08:58 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:60574 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759080Ab0J1WIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 18:08:55 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id E3C47D480BF;
	Fri, 29 Oct 2010 00:08:48 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PBaeJ-0003pF-Fv; Fri, 29 Oct 2010 00:08:43 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1288303712-14662-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160238>

The output produced is as shown below.

diff --git-detect-bulk-moves mips/nxp/pnx833x/common/ mips/pnx833x/common/
bulk move with similarity index 100%
bulk move from mips/nxp/pnx833x/common/
bulk move to mips/pnx833x/common/

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 Documentation/diff-generate-patch.txt |   19 +++++++++++++
 diff.c                                |   48 +++++++++++++++++++++++++-------
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 3ac2bea..367e859 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -71,6 +71,25 @@ separate lines indicate the old and the new mode.
       rename to a
 
 
+bulk move entries
+-----------------
+
+When a bulk move is detected, a special block is output in addition to
+the renames that constitute the bulk move, looking like this:
+
+       diff --git-detect-bulk-moves a/dir1/ b/dir2/
+
+It is essentially similar to the standard diff header, with a special
+syntax showing we are describing a difference between two directories,
+and not a change to be applied as-is to a file.
+
+It is followed by three specific extended header lines:
+
+       bulk move with similarity index <number>
+       bulk move from <dir1>/
+       bulk move to <dir2>/
+
+
 combined diff format
 --------------------
 
diff --git a/diff.c b/diff.c
index 948eb76..ab2e201 100644
--- a/diff.c
+++ b/diff.c
@@ -2659,6 +2659,7 @@ static void run_diff_cmd(const char *pgm,
 	const char *xfrm_msg = NULL;
 	int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
 	int must_show_header = 0;
+	int use_color;
 
 	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
 		pgm = NULL;
@@ -2668,14 +2669,36 @@ static void run_diff_cmd(const char *pgm,
 			pgm = drv->external;
 	}
 
+	/*
+	 * don't use colors when the header is intended for an
+	 * external diff driver
+	 */
+	use_color = DIFF_OPT_TST(o, COLOR_DIFF) && !pgm;
+
+	if (p->is_bulkmove) {
+		const char *set = diff_get_color(use_color, DIFF_METAINFO);
+		const char *reset = diff_get_color(use_color, DIFF_RESET);
+		struct strbuf *msgbuf;
+		char *line_prefix = "";
+
+		if (o->output_prefix) {
+			msgbuf = o->output_prefix(o, o->output_prefix_data);
+			line_prefix = msgbuf->buf;
+		}
+		fprintf(o->file, "%s%sdiff --git-detect-bulk-moves %s %s%s\n",
+			line_prefix, set, one->path, two->path, reset);
+		fprintf(o->file, "%s%sbulk move with similarity index %d%%%s\n",
+			line_prefix, set, similarity_index(p), reset);
+		fprintf(o->file, "%s%sbulk move from %s%s\n",
+			line_prefix, set, one->path, reset);
+		fprintf(o->file, "%s%sbulk move to %s%s\n",
+			line_prefix, set, two->path, reset);
+		return;
+	}
+
 	if (msg) {
-		/*
-		 * don't use colors when the header is intended for an
-		 * external diff driver
-		 */
 		fill_metainfo(msg, name, other, one, two, o, p,
-			      &must_show_header,
-			      DIFF_OPT_TST(o, COLOR_DIFF) && !pgm);
+			      &must_show_header, use_color);
 		xfrm_msg = msg->len ? msg->buf : NULL;
 	}
 
@@ -2748,8 +2771,10 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 		return;
 	}
 
-	diff_fill_sha1_info(one);
-	diff_fill_sha1_info(two);
+	if (!p->is_bulkmove) {
+		diff_fill_sha1_info(one);
+		diff_fill_sha1_info(two);
+	}
 
 	if (!pgm &&
 	    DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two) &&
@@ -3548,9 +3573,10 @@ static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 	if (diff_unmodified_pair(p))
 		return;
 
-	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
-	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
-		return; /* no tree diffs in patch format */
+	if (!p->is_bulkmove &&
+	    ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
+	     (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode))))
+		return; /* no tree diffs in patch format, except for bulk moves */
 
 	run_diff(p, o);
 }
-- 
1.7.2.3
