From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 16/22] Add --graph prefix before line history output
Date: Sat, 24 Jul 2010 23:13:48 +0800
Message-ID: <1279984434-28933-17-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:15:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgRs-00020D-F9
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164Ab0GXPPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:15:25 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58504 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084Ab0GXPPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:15:22 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so3932862pwi.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=E12DnrDmu0nnI6bLgKrYIBtAtcbyk3tybEy1irIiWHo=;
        b=C2WsInBxECA9+ION+vJiN6HFu/asUpjaEx7W2gOZGV9oYiL0nwu8ZSMp2yiEUjy2R3
         SR2plNWvr75EPMDxLDRTeZJK8dLpjbeYRum4xBjh1Y1dZLDUWgO+W/XEGUzt49B07Q5H
         +saQx+nSkyHGPUOCvUpR5/VK+SJRjiLBvEH4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Vpk660e0jZ4fzjgTel0YkQDU8FtMs+DrhCvohYmIBtV4wGZLJYih/ogJ1dbBBGKQKq
         bXzQqxb11doPoQHUHCKUq4gGCzlfiRqaHJtxOzaE7NTbeaW9mCBFoCPWya8dQmy21JAq
         M/zxJphTJZmWBSILJsMeX/KXhNYAgL9A7QheY=
Received: by 10.142.157.6 with SMTP id f6mr5994183wfe.177.1279984522398;
        Sat, 24 Jul 2010 08:15:22 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.15.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:15:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151649>

Makes the line level log output look good when used
with the '--graph' option.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c |   79 +++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/line.c b/line.c
index cc8be97..c8c9ad3 100644
--- a/line.c
+++ b/line.c
@@ -1007,6 +1007,13 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
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
@@ -1029,7 +1036,7 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
 
 	while (*ptr < end && *lno <= elno) {
 		if (**ptr == '\n') {
-			fprintf(opt->file, "%s", buf.buf);
+			fprintf(opt->file, "%s%s", line_prefix, buf.buf);
 			if (*ptr - p) {
 				fwrite(p, *ptr - p, 1, opt->file);
 			}
@@ -1040,7 +1047,7 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
 		(*ptr)++;
 	}
 	if (*lno <= elno) {
-		fprintf(opt->file, "%s", buf.buf);
+		fprintf(opt->file, "%s%s", line_prefix, buf.buf);
 		if (*ptr - p) {
 			fwrite(p, *ptr - p, 1, opt->file);
 		}
@@ -1083,8 +1090,15 @@ static void diff_flush_chunks(struct diff_options *opt, struct line_chunk *chunk
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
 		struct range *r = range->ranges + i;
 		long lenp = r->pend - r->pstart + 1, pstart = r->pstart;
@@ -1092,8 +1106,8 @@ static void diff_flush_chunks(struct diff_options *opt, struct line_chunk *chunk
 		if (pstart == 0)
 			lenp = 0;
 
-		fprintf(opt->file, "%s@@ -%ld,%ld +%ld,%ld @@%s\n",
-			set, pstart, lenp, r->start, len, reset);
+		fprintf(opt->file, "%s%s@@ -%ld,%ld +%ld,%ld @@%s\n",
+			line_prefix, set, pstart, lenp, r->start, len, reset);
 
 		diff_flush_range(opt, chunk, r);
 	}
@@ -1112,6 +1126,13 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
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
@@ -1153,21 +1174,26 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
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
 
@@ -1189,8 +1215,15 @@ static void flush_nontrivial_merge(struct rev_info *rev, struct diff_line_range
 	const char *frag = diff_get_color_opt(opt, DIFF_FRAGINFO);
 	const char *meta = diff_get_color_opt(opt, DIFF_METAINFO);
 	const char *new = diff_get_color_opt(opt, DIFF_FILE_NEW);
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
 
-	fprintf(opt->file, "%s%s%s\n", meta, EVIL_MERGE_STR, reset);
+	if (opt && opt->output_prefix) {
+		msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
+		line_prefix = msgbuf->buf;
+	}
+
+	fprintf(opt->file, "%s%s%s%s\n", line_prefix, meta, EVIL_MERGE_STR, reset);
 
 	while (range) {
 		if (range->nr) {
@@ -1198,15 +1231,17 @@ static void flush_nontrivial_merge(struct rev_info *rev, struct diff_line_range
 			const char *ptr = range->spec->data;
 			const char *end = range->spec->data + range->spec->size;
 			int i = 0;
-			fprintf(opt->file, "%s%s%s\n\n", meta, range->spec->path, reset);
+			fprintf(opt->file, "%s%s%s%s\n%s\n", line_prefix,
+				meta, range->spec->path, reset, line_prefix);
 			for (; i < range->nr; i++) {
 				struct range *r = range->ranges + i;
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
@@ -1217,6 +1252,9 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 	struct diff_line_range *range = lookup_line_range(rev, c);
 	struct diff_line_range *nontrivial = lookup_decoration(&rev->nontrivial_merge, &c->object);
 	struct log_info log;
+	struct diff_options *opt = &rev->diffopt;
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
 
 	if (range == NULL)
 		return;
@@ -1226,11 +1264,12 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
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
 
 	if (c->object.flags & EVIL_MERGE)
 		return flush_nontrivial_merge(rev, nontrivial);
-- 
1.7.0.2.273.gc2413.dirty
