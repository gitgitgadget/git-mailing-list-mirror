From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH V5 14/17] Add --graph prefix before line history output
Date: Wed, 11 Aug 2010 23:03:39 +0800
Message-ID: <1281539022-31616-15-git-send-email-struggleyb.nku@gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Cc: Jens.Lehmann@web.de, trast@student.ethz.ch, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 17:06:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjCsU-0005Yv-O8
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797Ab0HKPFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:05:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56122 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab0HKPFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:05:45 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so73597pzk.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cKvK2iHbyOVTO3rVfXlcMdXa8KWG1MFuS5bfCL+SwrM=;
        b=bHcwCmmUQ2+hSH5pVv5HjZjBq4V9vVfD1o7xub+ZApHUOjurVyB6s2wbZ0dENt6k44
         HfQ7mTIHwkhu089HOcOfK3ajFh0SDq14AFodqVpQnzYu12zpTvEFtzQuG3cY7EVUUc2B
         NPho7MBiiAyRUHvUW+Q8jksqQMnqqGbqxr/ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xFCzrkDP4vHb/ZGJl5pclFts90YDjCWP0JabkUA1c+yTnbR5haRDK3rBPYHvorNeJ1
         q1Vu37K3wDAuPnmI/9fQe9N9kcFsV7vO/Ti9kgkCHfEk2JZKa8aDeJTbXuTvWYoIvNt+
         E4wkcHsN2q3uz3JrGen9VEKL91k/Yzdbcj9Kc=
Received: by 10.114.77.11 with SMTP id z11mr21835221waa.112.1281539144615;
        Wed, 11 Aug 2010 08:05:44 -0700 (PDT)
Received: from localhost.localdomain ([116.226.85.245])
        by mx.google.com with ESMTPS id c10sm356199wam.1.2010.08.11.08.05.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 08:05:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.19.g79e5d
In-Reply-To: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153255>

Makes the line level log output look good when used
with the '--graph' option.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/line.c b/line.c
index a2afe60..5580768 100644
--- a/line.c
+++ b/line.c
@@ -1116,6 +1116,13 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
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
@@ -1138,7 +1145,7 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
 
 	while (*ptr < end && *lno <= elno) {
 		if (**ptr == '\n') {
-			fprintf(opt->file, "%s", buf.buf);
+			fprintf(opt->file, "%s%s", line_prefix, buf.buf);
 			if (*ptr - p)
 				fwrite(p, *ptr - p, 1, opt->file);
 			fprintf(opt->file, "%s\n", reset);
@@ -1148,7 +1155,7 @@ static void flush_lines(struct diff_options *opt, const char **ptr, const char *
 		(*ptr)++;
 	}
 	if (*lno <= elno) {
-		fprintf(opt->file, "%s", buf.buf);
+		fprintf(opt->file, "%s%s", line_prefix, buf.buf);
 		if (*ptr - p)
 			fwrite(p, *ptr - p, 1, opt->file);
 		fprintf(opt->file, "%s\n", reset);
@@ -1190,8 +1197,15 @@ static void diff_flush_chunks(struct diff_options *opt, struct line_chunk *chunk
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
@@ -1199,8 +1213,8 @@ static void diff_flush_chunks(struct diff_options *opt, struct line_chunk *chunk
 		if (pstart == 0)
 			lenp = 0;
 
-		fprintf(opt->file, "%s@@ -%ld,%ld +%ld,%ld @@%s\n",
-			set, pstart, lenp, r->start, len, reset);
+		fprintf(opt->file, "%s%s@@ -%ld,%ld +%ld,%ld @@%s\n",
+			line_prefix, set, pstart, lenp, r->start, len, reset);
 
 		diff_flush_range(opt, chunk, r);
 	}
@@ -1219,6 +1233,13 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
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
@@ -1252,21 +1273,26 @@ static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *ra
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
 
@@ -1320,12 +1346,13 @@ static void flush_nontrivial_merge(struct rev_info *rev,
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
@@ -1338,6 +1365,8 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 							&c->object);
 	struct log_info log;
 	struct diff_options *opt = &rev->diffopt;
+	char *line_prefix = "";
+	struct strbuf *msgbuf;
 
 	if (range == NULL || !(c->object.flags & NONTRIVIAL_MERGE ||
 							c->object.flags & NEED_PRINT))
@@ -1350,11 +1379,12 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
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
1.7.2.19.g79e5d
