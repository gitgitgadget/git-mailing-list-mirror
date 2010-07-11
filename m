From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v1 3/4] line.c output the '--graph' padding before each line
Date: Sun, 11 Jul 2010 14:27:36 +0800
Message-ID: <1278829657-26607-4-git-send-email-struggleyb.nku@gmail.com>
References: <1278829657-26607-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 11 08:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXq3I-0003wy-Tt
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 08:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab0GKGaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 02:30:00 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51755 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab0GKG34 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 02:29:56 -0400
Received: by pwi5 with SMTP id 5so1400513pwi.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 23:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=J6YtZ1nrc506kt8O6O2fEAR5BIYkkc2EZidGKGzY6So=;
        b=F9MnNH/VnPpAs6oMviKCNgdQOqxNPnMShdcSWFasgc5I5pStbMvmRwSl8VynizKfvE
         Zn9lb3f/jsU50zUfZ3LLFwrW6FTOjL33dTAHQPNBvNHSfrCaOxLh2mVaZtZr77TrXSw0
         cLoZFCyOvXLnCUf/guqjW8K1lC0aFNR7Nqr/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Lmk9HTKQ8mV0em7OqxJykh2FYYQL12RKzv3IZEmJgbiA0Q+fVHIiyITlkOmVEibS3w
         B2a1O6jI4v/ieK7kbLUgf4Hj9eUivccX9Pnmif3/VoI4Nfkb2AFDHU/0/M385ATAYaxz
         whePQYpn/aajIWwCQ4UZpnCULLjyfDagOte58=
Received: by 10.142.211.6 with SMTP id j6mr14638575wfg.164.1278829795734;
        Sat, 10 Jul 2010 23:29:55 -0700 (PDT)
Received: from localhost.localdomain ([222.35.175.242])
        by mx.google.com with ESMTPS id b19sm1874759rvf.3.2010.07.10.23.29.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 23:29:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2.18.g2bc49
In-Reply-To: <1278829657-26607-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150758>

Make line level log output looks well with '--graph'
option.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c |   83 +++++++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/line.c b/line.c
index 0d62732..04a3500 100644
--- a/line.c
+++ b/line.c
@@ -967,6 +967,13 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
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
 
 	if (strcmp(color, ""))
 		reset = "";
@@ -987,13 +994,9 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
 	assert(*ptr <= end);
 	p = *ptr;
 
-	/*
-	 * todo: when --graph landed on master, this should be changed
-	 * a little.
-	 */
 	while (*ptr < end && *lno <= elno) {
 		if (**ptr == '\n') {
-			fprintf(opt->file, "%s", buf.buf);
+			fprintf(opt->file, "%s%s", line_prefix, buf.buf);
 			if (*ptr - p) {
 				fwrite(p, *ptr - p, 1, opt->file);
 			}
@@ -1004,7 +1007,7 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
 		(*ptr)++;
 	}
 	if (*lno <= elno) {
-		fprintf(opt->file, "%s", buf.buf);
+		fprintf(opt->file, "%s%s", line_prefix, buf.buf);
 		if (*ptr - p) {
 			fwrite(p, *ptr - p, 1, opt->file);
 		}
@@ -1047,8 +1050,15 @@ static void diff_flush_chunks(struct diff_options *opt, struct line_chunk *chunk
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
@@ -1056,8 +1066,8 @@ static void diff_flush_chunks(struct diff_options *opt, struct line_chunk *chunk
 		if (pstart == 0)
 			lenp = 0;
 
-		fprintf(opt->file, "%s@@ -%ld,%ld +%ld,%ld @@%s\n",
-			set, pstart, lenp, r->start, len, reset);
+		fprintf(opt->file, "%s%s@@ -%ld,%ld +%ld,%ld @@%s\n",
+			line_prefix, set, pstart, lenp, r->start, len, reset);
 
 		diff_flush_range(opt, chunk, r);
 	}
@@ -1076,6 +1086,13 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
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
@@ -1117,21 +1134,26 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
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
 
@@ -1153,24 +1175,33 @@ static void flush_nontrivial_merge(struct rev_info *rev, struct diff_line_range
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
-			fprintf(opt->file, "%s%s%s\n\n", meta, range->spec->path, reset);
+			fprintf(opt->file, "%s%s%s%s\n%s\n", line_prefix,
+				meta, range->spec->path, reset, line_prefix);
 			int lno = 1;
 			const char *ptr = range->spec->data;
 			const char *end = range->spec->data + range->spec->size;
 			int i = 0;
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
@@ -1181,6 +1212,9 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 	struct diff_line_range *range = lookup_line_range(rev, c);
 	struct diff_line_range *nontrivial = lookup_decoration(&rev->nontrivial_merge, &c->object);
 	struct log_info log;
+	struct diff_options *opt = &rev->diffopt;
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
 
 	if (range == NULL)
 		return;
@@ -1190,11 +1224,12 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
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
