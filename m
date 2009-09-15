From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] diff.c: shuffling code around
Date: Mon, 14 Sep 2009 23:15:03 -0700
Message-ID: <1252995306-32329-2-git-send-email-gitster@pobox.com>
References: <1252995306-32329-1-git-send-email-gitster@pobox.com>
Cc: Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 08:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnRKE-00057k-A0
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 08:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756624AbZIOGPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 02:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756585AbZIOGPR
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 02:15:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbZIOGPN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 02:15:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B42951260;
	Tue, 15 Sep 2009 02:15:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1ISV
	wuvlFsTFFRelN1I57OrjZYo=; b=QyZSuoW3dIAmVLotqKWiWAst/Ab5vi8z0hA/
	7E1O0RW+5cUR3A4Bi661mwWHlcIdv+7SN/9PfVhDf2e8Mh0ggKo7beVCmTtbS9Sh
	U7fw8r5k/VR37K9kLnJXcrSAgomy9tEPS6dyE755t1tGpXd2hLAnK3Nf21kYVULW
	sG/FI/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	lk9CHCXVkwWgDfmtpyIzaonEpjt6csr7akhuD/KsaXKQpx/OCAk7n5ytMRgAAwNA
	99BUia5x4tzoOZRSUgcfVVWgZ2KoIKpPVvM5YSagsxZbtPTV6WP8C4R8To9RRVlA
	ZNKRO0pEhMWRru00kw8xJsz/ZKy7QcPm8gryMsr7uHA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 19E805125F;
	Tue, 15 Sep 2009 02:15:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D49995125E; Tue, 15 Sep 2009
 02:15:10 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc1.54.g4aad
In-Reply-To: <1252995306-32329-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 20E8287E-A1BF-11DE-B10D-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128514>

Move function, type, and structure definitions for fill_mmfile(),
count_trailing_blank(), check_blank_at_eof(), emit_line(),
new_blank_line_at_eof(), emit_add_line(), sane_truncate_fn, and
emit_callback up in the file, so that they can be refactored into helper
functions and reused by codepath for emitting rewrite patches.

This only moves the lines around to make the next two patches easier to
read.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This obviously comes on top of the earlier fix to the "blank lines at
   eof" breakage.

 diff.c |  250 ++++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 125 insertions(+), 125 deletions(-)

diff --git a/diff.c b/diff.c
index 63a3bfc..7548966 100644
--- a/diff.c
+++ b/diff.c
@@ -241,6 +241,23 @@ static struct diff_tempfile {
 	char tmp_path[PATH_MAX];
 } diff_temp[2];
 
+typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
+
+struct emit_callback {
+	struct xdiff_emit_state xm;
+	int color_diff;
+	unsigned ws_rule;
+	int blank_at_eof_in_preimage;
+	int blank_at_eof_in_postimage;
+	int lno_in_preimage;
+	int lno_in_postimage;
+	sane_truncate_fn truncate;
+	const char **label_path;
+	struct diff_words_data *diff_words;
+	int *found_changesp;
+	FILE *file;
+};
+
 static int count_lines(const char *data, int size)
 {
 	int count, ch, completely_empty = 1, nl_just_seen = 0;
@@ -301,6 +318,114 @@ static void copy_file_with_prefix(FILE *file,
 		fprintf(file, "%s\n\\ No newline at end of file\n", reset);
 }
 
+static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
+{
+	if (!DIFF_FILE_VALID(one)) {
+		mf->ptr = (char *)""; /* does not matter */
+		mf->size = 0;
+		return 0;
+	}
+	else if (diff_populate_filespec(one, 0))
+		return -1;
+	mf->ptr = one->data;
+	mf->size = one->size;
+	return 0;
+}
+
+static int count_trailing_blank(mmfile_t *mf, unsigned ws_rule)
+{
+	char *ptr = mf->ptr;
+	long size = mf->size;
+	int cnt = 0;
+
+	if (!size)
+		return cnt;
+	ptr += size - 1; /* pointing at the very end */
+	if (*ptr != '\n')
+		; /* incomplete line */
+	else
+		ptr--; /* skip the last LF */
+	while (mf->ptr < ptr) {
+		char *prev_eol;
+		for (prev_eol = ptr; mf->ptr <= prev_eol; prev_eol--)
+			if (*prev_eol == '\n')
+				break;
+		if (!ws_blank_line(prev_eol + 1, ptr - prev_eol, ws_rule))
+			break;
+		cnt++;
+		ptr = prev_eol - 1;
+	}
+	return cnt;
+}
+
+static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
+			       struct emit_callback *ecbdata)
+{
+	int l1, l2, at;
+	unsigned ws_rule = ecbdata->ws_rule;
+	l1 = count_trailing_blank(mf1, ws_rule);
+	l2 = count_trailing_blank(mf2, ws_rule);
+	if (l2 <= l1) {
+		ecbdata->blank_at_eof_in_preimage = 0;
+		ecbdata->blank_at_eof_in_postimage = 0;
+		return;
+	}
+	at = count_lines(mf1->ptr, mf1->size);
+	ecbdata->blank_at_eof_in_preimage = (at - l1) + 1;
+
+	at = count_lines(mf2->ptr, mf2->size);
+	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
+}
+
+static void emit_line(FILE *file, const char *set, const char *reset, const char *line, int len)
+{
+	int has_trailing_newline, has_trailing_carriage_return;
+
+	has_trailing_newline = (len > 0 && line[len-1] == '\n');
+	if (has_trailing_newline)
+		len--;
+	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
+	if (has_trailing_carriage_return)
+		len--;
+
+	fputs(set, file);
+	fwrite(line, len, 1, file);
+	fputs(reset, file);
+	if (has_trailing_carriage_return)
+		fputc('\r', file);
+	if (has_trailing_newline)
+		fputc('\n', file);
+}
+
+static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
+{
+	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
+	      ecbdata->blank_at_eof_in_preimage &&
+	      ecbdata->blank_at_eof_in_postimage &&
+	      ecbdata->blank_at_eof_in_preimage <= ecbdata->lno_in_preimage &&
+	      ecbdata->blank_at_eof_in_postimage <= ecbdata->lno_in_postimage))
+		return 0;
+	return ws_blank_line(line + 1, len - 1, ecbdata->ws_rule);
+}
+
+static void emit_add_line(const char *reset, struct emit_callback *ecbdata, const char *line, int len)
+{
+	const char *ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
+	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_NEW);
+
+	if (!*ws)
+		emit_line(ecbdata->file, set, reset, line, len);
+	else if (new_blank_line_at_eof(ecbdata, line, len))
+		/* Blank line at EOF - paint '+' as well */
+		emit_line(ecbdata->file, ws, reset, line, len);
+	else {
+		/* Emit just the prefix, then the rest. */
+		emit_line(ecbdata->file, set, reset, line, 1);
+		ws_check_emit(line + 1, len - 1, ecbdata->ws_rule,
+			      ecbdata->file, set, reset, ws);
+	}
+}
+
 static void emit_rewrite_diff(const char *name_a,
 			      const char *name_b,
 			      struct diff_filespec *one,
@@ -345,20 +470,6 @@ static void emit_rewrite_diff(const char *name_a,
 		copy_file_with_prefix(o->file, '+', two->data, two->size, new, reset);
 }
 
-static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
-{
-	if (!DIFF_FILE_VALID(one)) {
-		mf->ptr = (char *)""; /* does not matter */
-		mf->size = 0;
-		return 0;
-	}
-	else if (diff_populate_filespec(one, 0))
-		return -1;
-	mf->ptr = one->data;
-	mf->size = one->size;
-	return 0;
-}
-
 struct diff_words_buffer {
 	mmfile_t text;
 	long alloc;
@@ -485,23 +596,6 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	}
 }
 
-typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
-
-struct emit_callback {
-	struct xdiff_emit_state xm;
-	int color_diff;
-	unsigned ws_rule;
-	int blank_at_eof_in_preimage;
-	int blank_at_eof_in_postimage;
-	int lno_in_preimage;
-	int lno_in_postimage;
-	sane_truncate_fn truncate;
-	const char **label_path;
-	struct diff_words_data *diff_words;
-	int *found_changesp;
-	FILE *file;
-};
-
 static void free_diff_words_data(struct emit_callback *ecbdata)
 {
 	if (ecbdata->diff_words) {
@@ -524,55 +618,6 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix)
 	return "";
 }
 
-static void emit_line(FILE *file, const char *set, const char *reset, const char *line, int len)
-{
-	int has_trailing_newline, has_trailing_carriage_return;
-
-	has_trailing_newline = (len > 0 && line[len-1] == '\n');
-	if (has_trailing_newline)
-		len--;
-	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
-	if (has_trailing_carriage_return)
-		len--;
-
-	fputs(set, file);
-	fwrite(line, len, 1, file);
-	fputs(reset, file);
-	if (has_trailing_carriage_return)
-		fputc('\r', file);
-	if (has_trailing_newline)
-		fputc('\n', file);
-}
-
-static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
-{
-	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
-	      ecbdata->blank_at_eof_in_preimage &&
-	      ecbdata->blank_at_eof_in_postimage &&
-	      ecbdata->blank_at_eof_in_preimage <= ecbdata->lno_in_preimage &&
-	      ecbdata->blank_at_eof_in_postimage <= ecbdata->lno_in_postimage))
-		return 0;
-	return ws_blank_line(line + 1, len - 1, ecbdata->ws_rule);
-}
-
-static void emit_add_line(const char *reset, struct emit_callback *ecbdata, const char *line, int len)
-{
-	const char *ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
-	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_NEW);
-
-	if (!*ws)
-		emit_line(ecbdata->file, set, reset, line, len);
-	else if (new_blank_line_at_eof(ecbdata, line, len))
-		/* Blank line at EOF - paint '+' as well */
-		emit_line(ecbdata->file, ws, reset, line, len);
-	else {
-		/* Emit just the prefix, then the rest. */
-		emit_line(ecbdata->file, set, reset, line, 1);
-		ws_check_emit(line + 1, len - 1, ecbdata->ws_rule,
-			      ecbdata->file, set, reset, ws);
-	}
-}
-
 static unsigned long sane_truncate_line(struct emit_callback *ecb, char *line, unsigned long len)
 {
 	const char *cp;
@@ -1464,51 +1509,6 @@ static const struct funcname_pattern_entry *diff_funcname_pattern(struct diff_fi
 	return NULL;
 }
 
-static int count_trailing_blank(mmfile_t *mf, unsigned ws_rule)
-{
-	char *ptr = mf->ptr;
-	long size = mf->size;
-	int cnt = 0;
-
-	if (!size)
-		return cnt;
-	ptr += size - 1; /* pointing at the very end */
-	if (*ptr != '\n')
-		; /* incomplete line */
-	else
-		ptr--; /* skip the last LF */
-	while (mf->ptr < ptr) {
-		char *prev_eol;
-		for (prev_eol = ptr; mf->ptr <= prev_eol; prev_eol--)
-			if (*prev_eol == '\n')
-				break;
-		if (!ws_blank_line(prev_eol + 1, ptr - prev_eol, ws_rule))
-			break;
-		cnt++;
-		ptr = prev_eol - 1;
-	}
-	return cnt;
-}
-
-static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
-			       struct emit_callback *ecbdata)
-{
-	int l1, l2, at;
-	unsigned ws_rule = ecbdata->ws_rule;
-	l1 = count_trailing_blank(mf1, ws_rule);
-	l2 = count_trailing_blank(mf2, ws_rule);
-	if (l2 <= l1) {
-		ecbdata->blank_at_eof_in_preimage = 0;
-		ecbdata->blank_at_eof_in_postimage = 0;
-		return;
-	}
-	at = count_lines(mf1->ptr, mf1->size);
-	ecbdata->blank_at_eof_in_preimage = (at - l1) + 1;
-
-	at = count_lines(mf2->ptr, mf2->size);
-	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
-}
-
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
-- 
1.6.5.rc1.54.g4aad
