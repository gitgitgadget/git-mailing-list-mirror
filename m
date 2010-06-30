From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH v2 09/13] print the line log
Date: Wed, 30 Jun 2010 23:25:22 +0800
Message-ID: <1277911526-12105-9-git-send-email-struggleyb.nku@gmail.com>
References: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 30 17:30:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzFY-0001VQ-1V
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135Ab0F3Pap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:30:45 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34267 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131Ab0F3Pao (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:30:44 -0400
Received: by mail-pw0-f46.google.com with SMTP id 8so320542pwj.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wZW6gDDNxgQ1r7nYUpbcCwI7XnbutwDCNQF7Q9KGrr4=;
        b=I+/NvcV//rvBe+pWjcNyKIJbHUGLUe/YU36b++lsG4Yhbmsrqrbv8BPL+rJ7CSAdo8
         9t99eWT3VD9/AiyRCdSmFyokdbcLWhufMGuMCYo3lvCe+B2mCm/bCf6+3NWjRQeZfOkR
         JfIIKE0kGgKaGEtYsWcOB2oaWvqsPCX6hiLao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=r2arTQhf6veq5orhomtOIlMz6+fvBIe7zz6zRCN6q+75lov/1O58Yag7/i4s5JWuHT
         DoV+CXoC1qLh/cguZ8YzS7qkKxo57gYskA0/ln49HCoGSezDmVrQIx6xczb7a7jNodRg
         yq3EjOKinb7Pfhlzjo2+XUQHWAr08a3GZNvfk=
Received: by 10.115.85.24 with SMTP id n24mr10016383wal.4.1277911843744;
        Wed, 30 Jun 2010 08:30:43 -0700 (PDT)
Received: from localhost.localdomain ([117.15.79.69])
        by mx.google.com with ESMTPS id d38sm75050850wam.20.2010.06.30.08.30.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 08:30:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc0.27.g1c5fd
In-Reply-To: <1277911526-12105-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149972>

'struct line_chunk' is used to make sure each file is scaned
only once when printing the lines. We trace the line number and
the start position of intermediate line in this struct.
Two helper functions from diff.c are used to generate the
consistent format of diff meta info.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c |  245 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 245 insertions(+), 0 deletions(-)

diff --git a/line.c b/line.c
index 734a3cb..973eff5 100644
--- a/line.c
+++ b/line.c
@@ -945,3 +945,248 @@ static void assign_parents_range(struct rev_info *rev, struct commit *commit)
 	}
 }
 
+struct line_chunk {
+	int lone, ltwo;
+	const char *one, *two;
+	const char *one_end, *two_end;
+	struct diff_line_range *range;
+};
+
+static void flush_lines(struct diff_options *opt, const char **ptr, const char *end,
+		int slno, int elno, int *lno, const char *color, const char heading)
+{
+	const char *p = *ptr;
+	struct strbuf buf = STRBUF_INIT;
+	const char *reset;
+
+	if (strcmp(color, ""))
+		reset = "";
+	else
+		reset = diff_get_color_opt(opt, DIFF_RESET);
+
+	strbuf_addf(&buf, "%s%c", color, heading);
+	while (*ptr < end && *lno < slno) {
+		if (**ptr == '\n') {
+			(*lno)++;
+			if (*lno == slno) {
+				(*ptr)++;
+				break;
+			}
+		}
+		(*ptr)++;
+	}
+	assert(*ptr <= end);
+	p = *ptr;
+
+	/*
+	 * todo: when --graph landed on master, this should be changed
+	 * a little.
+	 */
+	while (*ptr < end && *lno <= elno) {
+		if (**ptr == '\n') {
+			fprintf(opt->file, "%s", buf.buf);
+			if (*ptr - p) {
+				fwrite(p, *ptr - p, 1, opt->file);
+			}
+			fprintf(opt->file, "%s\n", reset);
+			p = *ptr + 1;
+			(*lno)++;
+		}
+		(*ptr)++;
+	}
+	if (*lno <= elno) {
+		fprintf(opt->file, "%s", buf.buf);
+		if (*ptr - p) {
+			fwrite(p, *ptr - p, 1, opt->file);
+		}
+		fprintf(opt->file, "%s\n", reset);
+	}
+	strbuf_release(&buf);
+}
+
+static void diff_flush_range(struct diff_options *opt, struct line_chunk *chunk,
+		struct range *range)
+{
+	struct print_pair *pair = &range->pair;
+	const char *old = diff_get_color_opt(opt, DIFF_FILE_OLD);
+	const char *new = diff_get_color_opt(opt, DIFF_FILE_NEW);
+	int i, cur = range->start;
+
+	for (i = 0; i < pair->nr; i++) {
+		struct print_range *pr = pair->ranges + i;
+		if (cur < pr->start)
+			flush_lines(opt, &chunk->two, chunk->two_end,
+				cur, pr->start - 1, &chunk->ltwo, "", ' ');
+
+		if (!pr->line_added)
+			flush_lines(opt, &chunk->one, chunk->one_end,
+				pr->pstart, pr->pend, &chunk->lone, old, '-');
+		flush_lines(opt, &chunk->two, chunk->two_end,
+			pr->start, pr->end, &chunk->ltwo, new, '+');
+
+		cur = pr->end + 1;
+	}
+
+	if (cur <= range->end) {
+		flush_lines(opt, &chunk->two, chunk->two_end,
+			cur, range->end, &chunk->ltwo, "", ' ');
+	}
+}
+
+static void diff_flush_chunks(struct diff_options *opt, struct line_chunk *chunk)
+{
+	struct diff_line_range *range = chunk->range;
+	const char *set = diff_get_color_opt(opt, DIFF_FRAGINFO);
+	const char *reset = diff_get_color_opt(opt, DIFF_RESET);
+	int i;
+
+	for (i = 0; i < range->nr; i++) {
+		struct range *r = range->ranges + i;
+		long lenp = r->pend - r->pstart + 1, pstart = r->pstart;
+		long len = r->end - r->start + 1;
+		if (pstart == 0)
+			lenp = 0;
+
+		fprintf(opt->file, "%s@@ -%ld,%ld +%ld,%ld @@%s\n",
+			set, pstart, lenp, r->start, len, reset);
+
+		diff_flush_range(opt, chunk, r);
+	}
+}
+
+static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *range)
+{
+	struct diff_options *opt = &rev->diffopt;
+	struct diff_filespec *one = range->prev, *two = range->spec;
+	struct diff_filepair p = {one, two, range->status, 0};
+	struct strbuf header = STRBUF_INIT, meta = STRBUF_INIT;
+	const char *a_prefix, *b_prefix;
+	const char *name_a, *name_b, *a_one, *b_two;
+	const char *lbl[2];
+	const char *set = diff_get_color_opt(opt, DIFF_METAINFO);
+	const char *reset = diff_get_color_opt(opt, DIFF_RESET);
+	struct line_chunk chunk;
+	int must_show_header;
+
+	/*
+	 * the ranges that touch no different file, in this case
+	 * the line number will not change, and of course we have
+	 * no sensible rang->pair since there is no diff run.
+	 */
+	if (one == NULL) {
+		return;
+	}
+
+	if (range->status == DIFF_STATUS_DELETED)
+		die("We are following an nonexistent file, interesting!");
+
+	name_a  = one->path;
+	name_b = two->path;
+	fill_metainfo(&meta, name_a, name_b, one, two, opt, &p, &must_show_header,
+			DIFF_OPT_TST(opt, COLOR_DIFF));
+
+	diff_set_mnemonic_prefix(opt, "a/", "b/");
+	if (DIFF_OPT_TST(opt, REVERSE_DIFF)) {
+		a_prefix = opt->b_prefix;
+		b_prefix = opt->a_prefix;
+	} else {
+		a_prefix = opt->a_prefix;
+		b_prefix = opt->b_prefix;
+	}
+
+	name_a = DIFF_FILE_VALID(one) ? name_a : name_b;
+	name_b = DIFF_FILE_VALID(two) ? name_b : name_a;
+
+	a_one = quote_two(a_prefix, name_a + (*name_a == '/'));
+	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
+	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
+	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
+	strbuf_addf(&header, "%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
+	if (lbl[0][0] == '/') {
+		strbuf_addf(&header, "%snew file mode %06o%s\n", set, two->mode, reset);
+	} else if (lbl[1][0] == '/') {
+		strbuf_addf(&header, "%sdeleted file mode %06o%s\n", set, one->mode, reset);
+	} else if (one->mode != two->mode) {
+			strbuf_addf(&header, "%sold mode %06o%s\n", set, one->mode, reset);
+			strbuf_addf(&header, "%snew mode %06o%s\n", set, two->mode, reset);
+	}
+
+	fprintf(opt->file, "%s%s", header.buf, meta.buf);
+	strbuf_release(&meta);
+	strbuf_release(&header);
+	fprintf(opt->file, "%s--- %s%s\n", set, lbl[0], reset);
+	fprintf(opt->file, "%s+++ %s%s\n", set, lbl[1], reset);
+	free((void *)a_one);
+	free((void *)b_two);
+
+	chunk.one = one->data;
+	chunk.one_end = one->data + one->size;
+	chunk.lone = 1;
+	chunk.two = two->data;
+	chunk.two_end = two->data + two->size;
+	chunk.ltwo = 1;
+	chunk.range = range;
+	diff_flush_chunks(&rev->diffopt, &chunk);
+}
+
+#define EVIL_MERGE_STR "nontrivial merge found"
+static void flush_nontrivial_merge(struct rev_info *rev, struct diff_line_range *range)
+{
+	struct diff_options *opt = &rev->diffopt;
+	const char *reset = diff_get_color_opt(opt, DIFF_RESET);
+	const char *frag = diff_get_color_opt(opt, DIFF_FRAGINFO);
+	const char *meta = diff_get_color_opt(opt, DIFF_METAINFO);
+	const char *new = diff_get_color_opt(opt, DIFF_FILE_NEW);
+
+	fprintf(opt->file, "%s%s%s\n", meta, EVIL_MERGE_STR, reset);
+
+	while (range) {
+		if (range->nr) {
+			fprintf(opt->file, "%s%s%s\n\n", meta, range->spec->path, reset);
+			int lno = 1;
+			const char *ptr = range->spec->data;
+			const char *end = range->spec->data + range->spec->size;
+			int i = 0;
+			for (; i < range->nr; i++) {
+				struct range *r = range->ranges + i;
+				fprintf(opt->file, "%s@@ %ld,%ld @@%s\n", frag, r->start,
+					r->end - r->start + 1, reset);
+				flush_lines(opt, &ptr, end, r->start, r->end,
+					&lno, new, ' ');
+			}
+			fprintf(opt->file, "\n");
+		}
+		range = range->next;
+	}
+}
+
+static void line_log_flush(struct rev_info *rev, struct commit *c)
+{
+	struct diff_line_range *range = lookup_line_range(rev, c);
+	struct diff_line_range *nontrivial = lookup_decoration(&rev->nontrivial_merge, &c->object);
+	struct log_info log;
+
+	if (range == NULL)
+		return;
+
+	log.commit = c;
+	log.parent = NULL;
+	rev->loginfo = &log;
+	show_log(rev);
+	rev->loginfo = NULL;
+	/*
+	 * Add a new line after each commit message, of course we should
+	 * add --graph alignment later when the patches comes to master.
+	 */
+	fprintf(rev->diffopt.file, "\n");
+
+	if (c->object.flags & EVIL_MERGE)
+		return flush_nontrivial_merge(rev, nontrivial);
+
+	while (range) {
+		if (range->diff)
+			diff_flush_filepair(rev, range);
+		range = range->next;
+	}
+}
+
-- 
1.7.0.2.273.gc2413.dirty
