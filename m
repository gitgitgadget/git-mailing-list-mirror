From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] diff -B: colour whitespace errors
Date: Mon, 14 Sep 2009 23:15:06 -0700
Message-ID: <1252995306-32329-5-git-send-email-gitster@pobox.com>
References: <1252995306-32329-1-git-send-email-gitster@pobox.com>
Cc: Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 08:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnRKE-00057k-Q6
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 08:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756795AbZIOGPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 02:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756632AbZIOGP1
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 02:15:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756603AbZIOGPT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 02:15:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2497032A5B;
	Tue, 15 Sep 2009 02:15:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=alxG
	nL2aZ0f+mtFgUmHNSPFC7Fo=; b=mXweAsg02PpJA/3AKMYzphuIsd1/5wOEcK55
	cefy05eL9II2z4HhtOsTh9dz4mFMjtHquTKd1Rcq9SvF2JFZMusGvAqI4U1xYtze
	lStnf6KHsLJM/rjAmxhpR4clmO6T3aBrNJxFeeSzxHcg62hPG/D/QaGcoS2xtzlD
	xa+6Wnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	b1ZV7y0A6GoeGQiBsPoRwYGtKqFjz3v4FNKsF8TpYh66kRwNZ34AXE5sA6yeC4IY
	sSN0iY/BiG+2rPtWpVC6dil+5Vx9Sfmn9llmtRzsReUdTrFe3X0Om3aN36m4d+sh
	DNdDLOIqYjp2HxSk1W/3AEke002eIOarAy1ftFLeGeY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 155A532A5A;
	Tue, 15 Sep 2009 02:15:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 557E332A58; Tue, 15 Sep
 2009 02:15:20 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc1.54.g4aad
In-Reply-To: <1252995306-32329-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 26459108-A1BF-11DE-B84A-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128515>

We used to send the old and new contents more or less straight out to the
output with only the original "old is red, new is green" colouring.  Now
all the necessary support routines have been prepared, call them with a
line of data at a time from the output code and have them check and color
whitespace errors in exactly the same way as they are called from the low
level diff callback routines.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |   75 +++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/diff.c b/diff.c
index baf46ab..b6d40d7 100644
--- a/diff.c
+++ b/diff.c
@@ -296,28 +296,6 @@ static void print_line_count(FILE *file, int count)
 	}
 }
 
-static void copy_file_with_prefix(FILE *file,
-				  int prefix, const char *data, int size,
-				  const char *set, const char *reset)
-{
-	int ch, nl_just_seen = 1;
-	while (0 < size--) {
-		ch = *data++;
-		if (nl_just_seen) {
-			fputs(set, file);
-			putc(prefix, file);
-		}
-		if (ch == '\n') {
-			nl_just_seen = 1;
-			fputs(reset, file);
-		} else
-			nl_just_seen = 0;
-		putc(ch, file);
-	}
-	if (!nl_just_seen)
-		fprintf(file, "%s\n\\ No newline at end of file\n", reset);
-}
-
 static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 {
 	if (!DIFF_FILE_VALID(one)) {
@@ -436,6 +414,38 @@ static void emit_add_line(const char *reset,
 	}
 }
 
+static void emit_rewrite_lines(struct emit_callback *ecb,
+			       int prefix, const char *data, int size)
+{
+	const char *endp = NULL;
+	static const char *nneof = " No newline at end of file\n";
+	const char *old = diff_get_color(ecb->color_diff, DIFF_FILE_OLD);
+	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
+
+	while (0 < size) {
+		int len;
+
+		endp = memchr(data, '\n', size);
+		len = endp ? (endp - data + 1) : size;
+		if (prefix != '+') {
+			ecb->lno_in_preimage++;
+			emit_line_0(ecb->file, old, reset, '-',
+				    data, len);
+		} else {
+			ecb->lno_in_postimage++;
+			emit_add_line(reset, ecb, data, len);
+		}
+		size -= len;
+		data += len;
+	}
+	if (!endp) {
+		const char *plain = diff_get_color(ecb->color_diff,
+						   DIFF_PLAIN);
+		emit_line_0(ecb->file, plain, reset, '\\',
+			    nneof, strlen(nneof));
+	}
+}
+
 static void emit_rewrite_diff(const char *name_a,
 			      const char *name_b,
 			      struct diff_filespec *one,
@@ -447,10 +457,23 @@ static void emit_rewrite_diff(const char *name_a,
 	const char *name_a_tab, *name_b_tab;
 	const char *metainfo = diff_get_color(color_diff, DIFF_METAINFO);
 	const char *fraginfo = diff_get_color(color_diff, DIFF_FRAGINFO);
-	const char *old = diff_get_color(color_diff, DIFF_FILE_OLD);
-	const char *new = diff_get_color(color_diff, DIFF_FILE_NEW);
 	const char *reset = diff_get_color(color_diff, DIFF_RESET);
 	static struct strbuf a_name = STRBUF_INIT, b_name = STRBUF_INIT;
+	struct emit_callback ecbdata;
+
+	memset(&ecbdata, 0, sizeof(ecbdata));
+	ecbdata.color_diff = color_diff;
+	ecbdata.found_changesp = &o->found_changes;
+	ecbdata.ws_rule = whitespace_rule(name_b ? name_b : name_a);
+	ecbdata.file = o->file;
+	if (ecbdata.ws_rule & WS_BLANK_AT_EOF) {
+		mmfile_t mf1, mf2;
+		fill_mmfile(&mf1, one);
+		fill_mmfile(&mf2, two);
+		check_blank_at_eof(&mf1, &mf2, &ecbdata);
+	}
+	ecbdata.lno_in_preimage = 1;
+	ecbdata.lno_in_postimage = 1;
 
 	name_a += (*name_a == '/');
 	name_b += (*name_b == '/');
@@ -475,9 +498,9 @@ static void emit_rewrite_diff(const char *name_a,
 	print_line_count(o->file, lc_b);
 	fprintf(o->file, " @@%s\n", reset);
 	if (lc_a)
-		copy_file_with_prefix(o->file, '-', one->data, one->size, old, reset);
+		emit_rewrite_lines(&ecbdata, '-', one->data, one->size);
 	if (lc_b)
-		copy_file_with_prefix(o->file, '+', two->data, two->size, new, reset);
+		emit_rewrite_lines(&ecbdata, '+', two->data, two->size);
 }
 
 struct diff_words_buffer {
-- 
1.6.5.rc1.54.g4aad
