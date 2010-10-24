From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] [RFC] Add --detect-bulk-moves output to unidiff format.
Date: Sun, 24 Oct 2010 23:10:34 +0200
Message-ID: <1287954634-14201-1-git-send-email-ydirson@altern.org>
References: <1287868022-24872-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 23:11:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA7qj-0005g8-Or
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 23:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932958Ab0JXVKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 17:10:44 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:51180 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932943Ab0JXVKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 17:10:43 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 5C5B2D4808B;
	Sun, 24 Oct 2010 23:10:37 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PA7ps-0003hi-6s; Sun, 24 Oct 2010 23:10:36 +0200
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1287868022-24872-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159892>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

This patch is a complement to the v7 "Detection of directory renames"
series.  It produces output like the sample below (taken from kernel
tree).  Does that feel right ?  Is it worth moving the output
production to a separate func filling an strbuf ?

|commit 86c6d4d0acc64543a485c11e197d0bd2c5ae0bb2
|Author: Ralf Baechle <ralf@linux-mips.org>
|Date:   Thu Aug 5 13:25:55 2010 +0100
|
|    MIPS: PNX833x: Move code one directory level up.
|    
|    It was sharing the nxp directory but no code with pnx8550 and will fit
|    better into the new platform makefile scheme, if moved.
|    
|    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
|
|diff --git --detect-bulk-moves arch/mips/nxp/pnx833x/common/ arch/mips/pnx833x/common/
|similarity index 100%
|bulk move from arch/mips/nxp/pnx833x/common/*
|bulk move to arch/mips/pnx833x/common/
|diff --git --detect-bulk-moves arch/mips/nxp/pnx833x/stb22x/ arch/mips/pnx833x/stb22x/
|similarity index 100%
|bulk move from arch/mips/nxp/pnx833x/stb22x/*
|bulk move to arch/mips/pnx833x/stb22x/
|diff --git a/arch/mips/Makefile b/arch/mips/Makefile
|index 2ba20d9..0556bc4 100644
[...]

 diff.c |   48 +++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 1d88281..8f2f67f 100644
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
+		fprintf(o->file, "%s%sdiff --git --detect-bulk-moves %s %s%s\n",
+			line_prefix, set, one->path, two->path, reset);
+		fprintf(o->file, "%s%ssimilarity index %d%%%s\n",
+			line_prefix, set, similarity_index(p), reset);
+		fprintf(o->file, "%s%sbulk move from %s*%s\n",
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
@@ -3529,9 +3554,10 @@ static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
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
