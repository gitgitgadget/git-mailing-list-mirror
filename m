From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v6.1 6/8] log -L: add --graph prefix before output
Date: Tue, 14 Dec 2010 23:54:13 +0100
Message-ID: <a1a60895616caf59b901705d9c0374ecb7f40db3.1292366984.git.trast@student.ethz.ch>
References: <cover.1292366984.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 23:54:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSdlL-0003BE-P2
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 23:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344Ab0LNWyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 17:54:22 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:10668 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369Ab0LNWyV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 17:54:21 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 23:54:11 +0100
Received: from localhost.localdomain (84.74.105.24) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 23:54:18 +0100
X-Mailer: git-send-email 1.7.3.3.807.g6ee1f
In-Reply-To: <cover.1292366984.git.trast@student.ethz.ch>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163709>

From: Bo Yang <struggleyb.nku@gmail.com>

Makes the line level log output look good when used
with the '--graph' option.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 line.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/line.c b/line.c
index 10870a5..1a9a947 100644
--- a/line.c
+++ b/line.c
@@ -1242,6 +1242,13 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
 	const char *p = *ptr;
 	struct strbuf buf = STRBUF_INIT;
 	const char *reset;
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
+
+	if (opt && opt->output_prefix) {
+		msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
 
 	if (*color)
 		reset = diff_get_color_opt(opt, DIFF_RESET);
@@ -1264,7 +1271,7 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
 
 	while (*ptr < end && *lno <= elno) {
 		if (**ptr == '\n') {
-			fprintf(opt->file, "%s", buf.buf);
+			fprintf(opt->file, "%s%s", line_prefix, buf.buf);
 			if (*ptr - p)
 				fwrite(p, *ptr - p, 1, opt->file);
 			fprintf(opt->file, "%s\n", reset);
@@ -1274,7 +1281,7 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
 		(*ptr)++;
 	}
 	if (*lno <= elno) {
-		fprintf(opt->file, "%s", buf.buf);
+		fprintf(opt->file, "%s%s", line_prefix, buf.buf);
 		if (*ptr - p)
 			fwrite(p, *ptr - p, 1, opt->file);
 		fprintf(opt->file, "%s\n", reset);
@@ -1316,8 +1323,15 @@ static void diff_flush_chunks(struct diff_options *opt, struct line_chunk *chunk
 	struct diff_line_range *range = chunk->range;
 	const char *set = diff_get_color_opt(opt, DIFF_FRAGINFO);
 	const char *reset = diff_get_color_opt(opt, DIFF_RESET);
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
 	int i;
 
+	if (opt && opt->output_prefix) {
+		msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
+
 	for (i = 0; i < range->nr; i++) {
 		struct line_range *r = range->ranges + i;
 		long lenp = r->pend - r->pstart + 1, pstart = r->pstart;
@@ -1325,8 +1339,8 @@ static void diff_flush_chunks(struct diff_options *opt, struct line_chunk *chunk
 		if (pstart == 0)
 			lenp = 0;
 
-		fprintf(opt->file, "%s@@ -%ld,%ld +%ld,%ld @@%s\n",
-			set, pstart, lenp, r->start, len, reset);
+		fprintf(opt->file, "%s%s@@ -%ld,%ld +%ld,%ld @@%s\n",
+			line_prefix, set, pstart, lenp, r->start, len, reset);
 
 		diff_flush_range(opt, chunk, r);
 	}
@@ -1345,6 +1359,13 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
 	const char *reset = diff_get_color_opt(opt, DIFF_RESET);
 	struct line_chunk chunk;
 	int must_show_header;
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
+
+	if (opt && opt->output_prefix) {
+		msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
 
 	/*
 	 * the ranges that touch no different file, in this case
@@ -1378,21 +1399,26 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	strbuf_addf(&header, "%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
+	strbuf_addf(&header, "%s%sdiff --git %s %s%s\n", line_prefix,
+			set, a_one, b_two, reset);
 	if (lbl[0][0] == '/') {
-		strbuf_addf(&header, "%snew file mode %06o%s\n", set, two->mode, reset);
+		strbuf_addf(&header, "%s%snew file mode %06o%s\n",
+			line_prefix, set, two->mode, reset);
 	} else if (lbl[1][0] == '/') {
-		strbuf_addf(&header, "%sdeleted file mode %06o%s\n", set, one->mode, reset);
+		strbuf_addf(&header, "%s%sdeleted file mode %06o%s\n",
+			line_prefix, set, one->mode, reset);
 	} else if (one->mode != two->mode) {
-			strbuf_addf(&header, "%sold mode %06o%s\n", set, one->mode, reset);
-			strbuf_addf(&header, "%snew mode %06o%s\n", set, two->mode, reset);
+			strbuf_addf(&header, "%s%sold mode %06o%s\n",
+				line_prefix, set, one->mode, reset);
+			strbuf_addf(&header, "%s%snew mode %06o%s\n",
+				line_prefix, set, two->mode, reset);
 	}
 
 	fprintf(opt->file, "%s%s", header.buf, meta.buf);
 	strbuf_release(&meta);
 	strbuf_release(&header);
-	fprintf(opt->file, "%s--- %s%s\n", set, lbl[0], reset);
-	fprintf(opt->file, "%s+++ %s%s\n", set, lbl[1], reset);
+	fprintf(opt->file, "%s%s--- %s%s\n", line_prefix, set, lbl[0], reset);
+	fprintf(opt->file, "%s%s+++ %s%s\n", line_prefix, set, lbl[1], reset);
 	free((void *)a_one);
 	free((void *)b_two);
 
@@ -1446,12 +1472,13 @@ static void flush_nontrivial_merge(struct rev_info *rev,
 				meta, range->spec->path, reset);
 			for (; i < range->nr; i++) {
 				struct line_range *r = range->ranges + i;
-				fprintf(opt->file, "%s@@ %ld,%ld @@%s\n", frag, r->start,
+				fprintf(opt->file, "%s%s@@ %ld,%ld @@%s\n",
+					line_prefix, frag, r->start,
 					r->end - r->start + 1, reset);
 				flush_lines(opt, &ptr, end, r->start, r->end,
 					&lno, new, ' ');
 			}
-			fprintf(opt->file, "\n");
+			fprintf(opt->file, "%s\n", line_prefix);
 		}
 		range = range->next;
 	}
@@ -1464,6 +1491,8 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 							&c->object);
 	struct log_info log;
 	struct diff_options *opt = &rev->diffopt;
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
 
 	if (!range || !(c->object.flags & NONTRIVIAL_MERGE ||
 			c->object.flags & NEED_PRINT))
@@ -1476,11 +1505,12 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 	rev->loginfo = &log;
 	show_log(rev);
 	rev->loginfo = NULL;
-	/*
-	 * Add a new line after each commit message, of course we should
-	 * add --graph alignment later when the patches comes to master.
-	 */
-	fprintf(rev->diffopt.file, "\n");
+
+	if (opt && opt->output_prefix) {
+		msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
+	fprintf(rev->diffopt.file, "%s\n", line_prefix);
 
 	if (c->object.flags & NONTRIVIAL_MERGE)
 		flush_nontrivial_merge(rev, nontrivial);
-- 
1.7.3.3.807.g6ee1f
