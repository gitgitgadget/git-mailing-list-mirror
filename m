From: Jeff King <peff@peff.net>
Subject: [PATCH 1/5] combine-diff: split header printing into its own function
Date: Mon, 23 May 2011 16:16:41 -0400
Message-ID: <20110523201641.GA6298@sigill.intra.peff.net>
References: <20110523201529.GA6281@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 22:17:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QObYm-0006P0-84
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 22:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933148Ab1EWUQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 16:16:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37647
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757356Ab1EWUQn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 16:16:43 -0400
Received: (qmail 22987 invoked by uid 107); 23 May 2011 20:18:47 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 16:18:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 16:16:41 -0400
Content-Disposition: inline
In-Reply-To: <20110523201529.GA6281@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174267>

This is a pretty big logical chunk, so it makes the function
a bit more readable to have it split out. In addition, it
will make it easier to add an alternate code path for binary
diffs in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c |  135 ++++++++++++++++++++++++++++++-------------------------
 1 files changed, 74 insertions(+), 61 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 655fa89..309dc6c 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -681,6 +681,78 @@ static void dump_quoted_path(const char *head,
 	puts(buf.buf);
 }
 
+static void show_combined_header(struct combine_diff_path *elem,
+				 int num_parent,
+				 int dense,
+				 struct rev_info *rev,
+				 int mode_differs)
+{
+	struct diff_options *opt = &rev->diffopt;
+	int abbrev = DIFF_OPT_TST(opt, FULL_INDEX) ? 40 : DEFAULT_ABBREV;
+	const char *a_prefix = opt->a_prefix ? opt->a_prefix : "a/";
+	const char *b_prefix = opt->b_prefix ? opt->b_prefix : "b/";
+	int use_color = DIFF_OPT_TST(opt, COLOR_DIFF);
+	const char *c_meta = diff_get_color(use_color, DIFF_METAINFO);
+	const char *c_reset = diff_get_color(use_color, DIFF_RESET);
+	const char *abb;
+	int added = 0;
+	int deleted = 0;
+	int i;
+
+	if (rev->loginfo && !rev->no_commit_id)
+		show_log(rev);
+
+	dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
+			 "", elem->path, c_meta, c_reset);
+	printf("%sindex ", c_meta);
+	for (i = 0; i < num_parent; i++) {
+		abb = find_unique_abbrev(elem->parent[i].sha1,
+					 abbrev);
+		printf("%s%s", i ? "," : "", abb);
+	}
+	abb = find_unique_abbrev(elem->sha1, abbrev);
+	printf("..%s%s\n", abb, c_reset);
+
+	if (mode_differs) {
+		deleted = !elem->mode;
+
+		/* We say it was added if nobody had it */
+		added = !deleted;
+		for (i = 0; added && i < num_parent; i++)
+			if (elem->parent[i].status !=
+			    DIFF_STATUS_ADDED)
+				added = 0;
+		if (added)
+			printf("%snew file mode %06o",
+			       c_meta, elem->mode);
+		else {
+			if (deleted)
+				printf("%sdeleted file ", c_meta);
+			printf("mode ");
+			for (i = 0; i < num_parent; i++) {
+				printf("%s%06o", i ? "," : "",
+				       elem->parent[i].mode);
+			}
+			if (elem->mode)
+				printf("..%06o", elem->mode);
+		}
+		printf("%s\n", c_reset);
+	}
+
+	if (added)
+		dump_quoted_path("--- ", "", "/dev/null",
+				 c_meta, c_reset);
+	else
+		dump_quoted_path("--- ", a_prefix, elem->path,
+				 c_meta, c_reset);
+	if (deleted)
+		dump_quoted_path("+++ ", "", "/dev/null",
+				 c_meta, c_reset);
+	else
+		dump_quoted_path("+++ ", b_prefix, elem->path,
+				 c_meta, c_reset);
+}
+
 static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			    int dense, struct rev_info *rev)
 {
@@ -692,13 +764,9 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	int mode_differs = 0;
 	int i, show_hunks;
 	int working_tree_file = is_null_sha1(elem->sha1);
-	int abbrev = DIFF_OPT_TST(opt, FULL_INDEX) ? 40 : DEFAULT_ABBREV;
-	const char *a_prefix, *b_prefix;
 	mmfile_t result_file;
 
 	context = opt->context;
-	a_prefix = opt->a_prefix ? opt->a_prefix : "a/";
-	b_prefix = opt->b_prefix ? opt->b_prefix : "b/";
 
 	/* Read the result of merge first */
 	if (!working_tree_file)
@@ -832,63 +900,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	show_hunks = make_hunks(sline, cnt, num_parent, dense);
 
 	if (show_hunks || mode_differs || working_tree_file) {
-		const char *abb;
-		int use_color = DIFF_OPT_TST(opt, COLOR_DIFF);
-		const char *c_meta = diff_get_color(use_color, DIFF_METAINFO);
-		const char *c_reset = diff_get_color(use_color, DIFF_RESET);
-		int added = 0;
-		int deleted = 0;
-
-		if (rev->loginfo && !rev->no_commit_id)
-			show_log(rev);
-		dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
-				 "", elem->path, c_meta, c_reset);
-		printf("%sindex ", c_meta);
-		for (i = 0; i < num_parent; i++) {
-			abb = find_unique_abbrev(elem->parent[i].sha1,
-						 abbrev);
-			printf("%s%s", i ? "," : "", abb);
-		}
-		abb = find_unique_abbrev(elem->sha1, abbrev);
-		printf("..%s%s\n", abb, c_reset);
-
-		if (mode_differs) {
-			deleted = !elem->mode;
-
-			/* We say it was added if nobody had it */
-			added = !deleted;
-			for (i = 0; added && i < num_parent; i++)
-				if (elem->parent[i].status !=
-				    DIFF_STATUS_ADDED)
-					added = 0;
-			if (added)
-				printf("%snew file mode %06o",
-				       c_meta, elem->mode);
-			else {
-				if (deleted)
-					printf("%sdeleted file ", c_meta);
-				printf("mode ");
-				for (i = 0; i < num_parent; i++) {
-					printf("%s%06o", i ? "," : "",
-					       elem->parent[i].mode);
-				}
-				if (elem->mode)
-					printf("..%06o", elem->mode);
-			}
-			printf("%s\n", c_reset);
-		}
-		if (added)
-			dump_quoted_path("--- ", "", "/dev/null",
-					 c_meta, c_reset);
-		else
-			dump_quoted_path("--- ", a_prefix, elem->path,
-					 c_meta, c_reset);
-		if (deleted)
-			dump_quoted_path("+++ ", "", "/dev/null",
-					 c_meta, c_reset);
-		else
-			dump_quoted_path("+++ ", b_prefix, elem->path,
-					 c_meta, c_reset);
+		show_combined_header(elem, num_parent, dense, rev,
+				     mode_differs);
 		dump_sline(sline, cnt, num_parent,
 			   DIFF_OPT_TST(opt, COLOR_DIFF), result_deleted);
 	}
-- 
1.7.5.2.4.g43415
