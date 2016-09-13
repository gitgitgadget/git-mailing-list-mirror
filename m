Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3935E207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 04:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753988AbcIMErA (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:47:00 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35295 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752917AbcIMEqr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:47 -0400
Received: by mail-pa0-f50.google.com with SMTP id b2so57816956pat.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kVMZ9oMsMfS5pUaXz/nxBFzCxubVmlr/+NR6rpOmvfU=;
        b=G0lFGjvAFKE96sQjy+Y+Dn/wP7159np925kGEkMLrqxnSAVuIwLRsAyc2B1+FYVzoj
         iXsRzLaFCCGowqTUQqhTFaTNnjLTKtfkJ6TbYGVZdie/e1ZHR97XbqjjjZNJc14aFYst
         FE2vNVu7rCXTsO/GB6RwY50h7xa+jIqrwyzjeJNLR1DIJAuOxOa+Iikq2mdUidXDIfdW
         uPZDqwYPP6+yyLP5r/7VyL4W9xj+fJmEtsCX6vhsRHzScMVM/Mk1kqw4s/tW8XMHAIhN
         8dHQRCUbc2rycCrZDDAZzbjpCJqhCJfI63iT50jCU5gmTebW5ZZUmVlcRr67D0CGFu7Q
         pRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kVMZ9oMsMfS5pUaXz/nxBFzCxubVmlr/+NR6rpOmvfU=;
        b=R/hG+Jzudslm1JnesGpJfOT6FZwPJvXOWQ74l/ynVkoQTufzF0rYLfSLSUwJUrXTV6
         zdEMf5QfAhe/rlfNQLdjMB7cDKEWE9doMrvl4pwZt1470igP/x35rWhGJa2TAtUmdXhJ
         yMttENFCnqjO5EqQWk6v6zEwDL66xvalNgz8IVDl7RPF7JnMfW00cwLGjKQOXD93Z8sP
         eOF0sgPOQcbvca9i7Xeo/6wXPt+FA/tSiXnjS4Ar5ODlLBH5KcNhNb1aAVULHbuGs5cO
         h0dQwO81guTZoX7ctY8PCAu2ONQ4O9Aqydcmd3RA77JsCOJYfviVhymmbAuDPftGlBy+
         RxSA==
X-Gm-Message-State: AE9vXwMgana524vDz7MuW6W5nyxTulygMoOP0BKHoWktEG5JaXDNbbcLvaGA26glY5aJWDkc
X-Received: by 10.67.23.70 with SMTP id hy6mr40058713pad.75.1473742006740;
        Mon, 12 Sep 2016 21:46:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id x126sm27804963pfx.61.2016.09.12.21.46.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:46 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 16/17] diff: buffer output in emit_line_0
Date:   Mon, 12 Sep 2016 21:46:12 -0700
Message-Id: <20160913044613.1037-17-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.21.g1da280f.dirty
In-Reply-To: <20160913044613.1037-1-sbeller@google.com>
References: <20160913044613.1037-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

emit_line_0 factors out the emission part into emit_line_emission,
and depending on the diff_options->use_buffer the emission
will be performed directly when calling emit_line_0 or after the
whole process is done, i.e. by buffering we have add the possibility
for a second pass over the whole output before doing the actual
output.

In 6440d34 (2012-03-14, diff: tweak a _copy_ of diff_options with
word-diff) we introduced a duplicate diff options struct for word
emissions as we may have different regex settings in there.

When buffering the output, we need to operate on just one buffer,
so we have to copy back the emissions of the word buffer into the main
buffer.

Unconditionally enable output via buffer in this patch as it yields
a great opportunity for testing, i.e. all the diff tests from the
test suite pass without having reordering issues (i.e. only parts
of the output got buffered, and we forgot to buffer other parts).
The test suite passes, which gives confidence that we converted all
functions to use emit_line_* for output.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 diff.h |  18 ++++++++
 2 files changed, 142 insertions(+), 27 deletions(-)

diff --git a/diff.c b/diff.c
index 68da135..e240e89 100644
--- a/diff.c
+++ b/diff.c
@@ -449,42 +449,86 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
-			int first, const char *line, int len)
+static void emit_line_emission(struct diff_options *o, struct line_emission *e)
 {
-	int has_trailing_newline, has_trailing_carriage_return;
-	int nofirst;
 	FILE *file = o->file;
 
 	fputs(diff_line_prefix(o), file);
 
+	if (e->len || e->first) {
+		if (e->set)
+			fputs(e->set, file);
+		if (e->first)
+			fputc(e->first, file);
+		if (e->whitespace_check) {
+			if (e->reset)
+				fputs(e->reset, file);
+			ws_check_emit(e->line, e->len, e->ws_rule,
+				      file, e->set, e->reset, e->ws);
+		} else {
+			fwrite(e->line, e->len, 1, file);
+			if (e->reset)
+				fputs(e->reset, file);
+		}
+	}
+	if (e->has_trailing_carriage_return)
+		fputc('\r', file);
+	if (e->has_trailing_newline)
+		fputc('\n', file);
+}
+
+static void free_line_emission(struct line_emission *e)
+{
+	/*
+	 * No need to free set, reset, ws as they always point to the
+	 * diff_colors[] static array. We don't own that memory.
+	 */
+	free((char*)e->line);
+}
+
+static void append_line_emission_to_buffer(struct diff_options *o,
+			     struct line_emission *e)
+{
+	struct line_emission *f;
+	ALLOC_GROW(o->line_buffer,
+		   o->line_buffer_nr + 1,
+		   o->line_buffer_alloc);
+	f = &o->line_buffer[o->line_buffer_nr++];
+	memcpy(f, e, sizeof(*e));
+
+	/* duplicate the line for now as it is not a stable pointer */
+	f->line = xmemdupz(e->line, e->len);
+}
+
+static void emit_line_0(struct diff_options *o, const char *set,
+			const char *reset, int first, const char *line, int len)
+{
+	int nofirst;
+	struct line_emission e = LINE_EMISSION_INIT;
+
 	if (len == 0) {
-		has_trailing_newline = (first == '\n');
-		has_trailing_carriage_return = (first == '\r');
-		nofirst = has_trailing_newline || has_trailing_carriage_return;
+		e.has_trailing_newline = (first == '\n');
+		e.has_trailing_carriage_return = (first == '\r');
+		nofirst = e.has_trailing_newline || e.has_trailing_carriage_return;
 	} else {
-		has_trailing_newline = (len > 0 && line[len-1] == '\n');
-		if (has_trailing_newline)
+		e.has_trailing_newline = (len > 0 && line[len-1] == '\n');
+		if (e.has_trailing_newline)
 			len--;
-		has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
-		if (has_trailing_carriage_return)
+		e.has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
+		if (e.has_trailing_carriage_return)
 			len--;
 		nofirst = 0;
 	}
 
-	if (len || !nofirst) {
-		if (set)
-			fputs(set, file);
-		if (!nofirst)
-			fputc(first, file);
-		fwrite(line, len, 1, file);
-		if (reset)
-			fputs(reset, file);
-	}
-	if (has_trailing_carriage_return)
-		fputc('\r', file);
-	if (has_trailing_newline)
-		fputc('\n', file);
+	e.set = set;
+	e.first = !nofirst ? first : 0;
+	e.line = line;
+	e.len = len;
+	e.reset = reset;
+	if (!o->use_buffer)
+		emit_line_emission(o, &e);
+	else
+		append_line_emission_to_buffer(o, &e);
 }
 
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
@@ -540,9 +584,22 @@ static void emit_line_checked(const char *reset,
 		emit_line_0(ecbdata->opt, ws, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->opt, set, reset, sign, "", 0);
-		ws_check_emit(line, len, ecbdata->ws_rule,
-			      ecbdata->opt->file, set, reset, ws);
+		if (ecbdata->opt->use_buffer) {
+			struct line_emission e;
+			e.line = line;
+			e.len = len;
+			e.ws_rule = ecbdata->ws_rule;
+			e.set = set;
+			e.reset = reset;
+			e.ws = ws;
+			e.whitespace_check = 1;
+			e.first = sign;
+			append_line_emission_to_buffer(ecbdata->opt, &e);
+		} else {
+			emit_line_0(ecbdata->opt, set, reset, sign, "", 0);
+			ws_check_emit(line, len, ecbdata->ws_rule,
+				      ecbdata->opt->file, set, reset, ws);
+		}
 	}
 }
 
@@ -1093,6 +1150,22 @@ static void diff_words_flush(struct emit_callback *ecbdata)
 	if (ecbdata->diff_words->minus.text.size ||
 	    ecbdata->diff_words->plus.text.size)
 		diff_words_show(ecbdata->diff_words);
+
+	if (ecbdata->diff_words->opt->line_buffer_nr) {
+		int i;
+		for (i = 0; i < ecbdata->diff_words->opt->line_buffer_nr; i++) {
+			struct line_emission *e =
+				&ecbdata->diff_words->opt->line_buffer[i];
+			ALLOC_GROW(ecbdata->opt->line_buffer,
+				   ecbdata->opt->line_buffer_nr + 1,
+				   ecbdata->opt->line_buffer_alloc);
+			memcpy(&ecbdata->opt->line_buffer
+					[ecbdata->opt->line_buffer_nr],
+				e, sizeof(*e));
+			ecbdata->opt->line_buffer_nr++;
+		}
+		ecbdata->diff_words->opt->line_buffer_nr = 0;
+	}
 }
 
 static void diff_filespec_load_driver(struct diff_filespec *one)
@@ -1128,6 +1201,12 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 		xcalloc(1, sizeof(struct diff_words_data));
 	ecbdata->diff_words->type = o->word_diff;
 	ecbdata->diff_words->opt = o;
+
+	/* Create our own buffer if needed. */
+	o->line_buffer = NULL;
+	o->line_buffer_nr = 0;
+	o->line_buffer_alloc = 0;
+
 	if (!o->word_regex)
 		o->word_regex = userdiff_word_regex(one);
 	if (!o->word_regex)
@@ -4649,11 +4728,29 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 {
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
+	/*
+	 * TODO:
+	 * For testing purposes we want to make sure the diff machinery
+	 * works with the buffer. If there is anything emitted outside the
+	 * emit_line_emission, then the order is screwed up and the tests
+	 * will fail.
+	 *
+	 * We'll unset this flag in a later patch.
+	 */
+	o->use_buffer = 1;
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (check_pair_status(p))
 			diff_flush_patch(p, o);
 	}
+
+	if (o->use_buffer) {
+		for (i = 0; i < o->line_buffer_nr; i++) {
+			emit_line_emission(o, &o->line_buffer[i]);
+			free_line_emission(&o->line_buffer[i]);
+		}
+		o->line_buffer_nr = 0;
+	}
 }
 
 void diff_flush(struct diff_options *options)
diff --git a/diff.h b/diff.h
index cc5d038..4df6aa5 100644
--- a/diff.h
+++ b/diff.h
@@ -110,6 +110,20 @@ enum diff_words_type {
 	DIFF_WORDS_COLOR
 };
 
+struct line_emission {
+	const char *set;
+	const char *line;
+	const char *ws;
+	const char *reset;
+	int first;
+	int len;
+	int whitespace_check;
+	unsigned ws_rule;
+	int has_trailing_carriage_return;
+	int has_trailing_newline;
+};
+#define LINE_EMISSION_INIT {NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0 }
+
 struct diff_options {
 	const char *orderfile;
 	const char *pickaxe;
@@ -178,6 +192,10 @@ struct diff_options {
 	void *output_prefix_data;
 
 	int diff_path_counter;
+
+	int use_buffer;
+	struct line_emission *line_buffer;
+	int line_buffer_nr, line_buffer_alloc;
 };
 
 void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
-- 
2.10.0.21.g1da280f.dirty

