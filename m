From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v4 15/18] Add --graph prefix before line history output
Date: Fri,  6 Aug 2010 00:11:54 +0800
Message-ID: <1281024717-7855-16-git-send-email-struggleyb.nku@gmail.com>
References: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Cc: trast@student.ethz.ch, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 05 18:14:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh35K-0001XF-4w
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759876Ab0HEQNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:13:36 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:59045 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933639Ab0HEQNb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:13:31 -0400
Received: by mail-px0-f174.google.com with SMTP id 14so2531057pxi.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DP2pJJY8qQYPbzCs8o7mfPaWCR1JtaArI9JfSmZH8VI=;
        b=MlytXQhi3D39MTCgPhcr2rhcSOh8/dEHCqN/oldxe8qwZVtJBfLkQUgfheGgYmaM4z
         PHYqpIrOiHOxvbHdz8eWeNp6ze6E1cAi3Ym+6pq/RiWOrhkKJnsh19WWsrWucTOndvD+
         VaMEPJRNxd9y9/BMO5yN7gJzJ3zo5aEhTwf6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=wSUCBDF8Saq7LLF4zIqZnndEoth8oc5mjAbIsuYLQzXcjDm15RtkDXVB2i3+R01Hk4
         25ad7fQR96iZY1sWKgyDDQiP21QI7AjZ5rFDUumMTSBJWxreDCA2MTlf3xbH/OTa5gVF
         mpQzqLNelGWioX41vIbA2fALcC0JcuATN69AM=
Received: by 10.142.178.12 with SMTP id a12mr3362036wff.146.1281024811427;
        Thu, 05 Aug 2010 09:13:31 -0700 (PDT)
Received: from localhost.localdomain ([222.35.120.192])
        by mx.google.com with ESMTPS id w8sm343653wfd.19.2010.08.05.09.13.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 09:13:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.20.g388bbb
In-Reply-To: <1281024717-7855-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152676>

Makes the line level log output look good when used
with the '--graph' option.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/line.c b/line.c
index 2e513da..7d80da8 100644
--- a/line.c
+++ b/line.c
@@ -1125,6 +1125,13 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
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
@@ -1147,7 +1154,7 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
 
 	while (*ptr < end && *lno <= elno) {
 		if (**ptr == '\n') {
-			fprintf(opt->file, "%s", buf.buf);
+			fprintf(opt->file, "%s%s", line_prefix, buf.buf);
 			if (*ptr - p) {
 				fwrite(p, *ptr - p, 1, opt->file);
 			}
@@ -1158,7 +1165,7 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
 		(*ptr)++;
 	}
 	if (*lno <= elno) {
-		fprintf(opt->file, "%s", buf.buf);
+		fprintf(opt->file, "%s%s", line_prefix, buf.buf);
 		if (*ptr - p) {
 			fwrite(p, *ptr - p, 1, opt->file);
 		}
@@ -1201,8 +1208,15 @@ static void diff_flush_chunks(struct diff_options *opt, struct line_chunk *chunk
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
@@ -1210,8 +1224,8 @@ static void diff_flush_chunks(struct diff_options *opt, struct line_chunk *chunk
 		if (pstart == 0)
 			lenp = 0;
 
-		fprintf(opt->file, "%s@@ -%ld,%ld +%ld,%ld @@%s\n",
-			set, pstart, lenp, r->start, len, reset);
+		fprintf(opt->file, "%s%s@@ -%ld,%ld +%ld,%ld @@%s\n",
+			line_prefix, set, pstart, lenp, r->start, len, reset);
 
 		diff_flush_range(opt, chunk, r);
 	}
@@ -1230,6 +1244,13 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
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
@@ -1264,21 +1285,26 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
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
 
@@ -1331,12 +1357,13 @@ static void flush_nontrivial_merge(struct rev_info *rev, struct diff_line_range
 				meta, range->spec->path, reset);
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
@@ -1348,6 +1375,8 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 	struct diff_line_range *nontrivial = lookup_decoration(&rev->nontrivial_merge, &c->object);
 	struct log_info log;
 	struct diff_options *opt = &rev->diffopt;
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
 
 	if (range == NULL || ! (c->object.flags & NONTRIVIAL_MERGE ||
 							c->object.flags & NEED_PRINT))
@@ -1360,11 +1389,12 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
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
1.7.2.20.g388bbb
