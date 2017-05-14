Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6104120188
	for <e@80x24.org>; Sun, 14 May 2017 04:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbdENEBy (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:54 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35711 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdENEBv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:51 -0400
Received: by mail-pg0-f49.google.com with SMTP id q125so26489201pgq.2
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t6YU27BigvRms8SwU/HG71oCs7z6cyfgHLIrexBwnvc=;
        b=E/p+PMLWMjfFh2vx0mEOxywSoROddjIDHXcTXTsTyoJQuXEN8ErkZxLVyBqlzEN58w
         8EptLxxKQ14zIpAUHNCQ1qhAMNoebCj+F5sugSwkQrvkngSqRb2XEP5d85HPnMJp45vA
         4Nrk+HdOoZe8sYX+BFLZySpUDenwSgJeewwZYuI7Rf3ZAnQB1phuCBdG0hJYJM/uH6Oj
         QX/a7JmyVwbhkRuqJUPxJO9nYCz747UusaPmCmld5dh/DJcOXDnRRKoCQ57Se2J0HcfM
         WKXr7rR3MWytBatv2GRUdm1//Q3kIgXAuIhZ6RCF/utva4o/eBYKapXAzd8MXbCiKaSg
         vncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t6YU27BigvRms8SwU/HG71oCs7z6cyfgHLIrexBwnvc=;
        b=C+/VSh12gNX7TkHaY9Sd2btAEPUocnoPz93QrmjD4V53M1utSQODWCZkpEVvTyTlhZ
         sOI+R6Lhyne9dOq3WAiHx2xhsVT0S//eqFjkU88qKrnutnEDWN1EDLfPWFufdBgKLyKL
         //fOOepDlwGYjFUJDx9X7OEzSXrMd1Swxsdn9LC35cnPs1Yws/AHaJCUAvPD51ciVng4
         aJJI5ITNwDdvmP0Z5CNT/ApCKjrhHYvVbioqrTuVvRt+XhLVDbv395+JwjL0rd65tb8j
         6d/ra8KqiCzWZBbppOgvfM6KEPGsZZi0mftOgjGKp0SbeDJ0JTm4eHG4kM1Wl2KgfME2
         dGgA==
X-Gm-Message-State: AODbwcA0JD5XAT7J3KdeMAn5+M/tPkW0cQ05R2N0pSG9ZQQvoK6CIiNw
        WHUqBG0k0mSK+7qO
X-Received: by 10.84.222.133 with SMTP id x5mr16228772pls.36.1494734510520;
        Sat, 13 May 2017 21:01:50 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id b68sm11750237pfa.127.2017.05.13.21.01.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 18/19] diff: buffer all output if asked to
Date:   Sat, 13 May 2017 21:01:16 -0700
Message-Id: <20170514040117.25865-19-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
In-Reply-To: <20170514040117.25865-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new option 'use_buffer' in the struct diff_options which
controls whether all output is buffered up until all output is available.

We'll have two new structs in diff.h, one of them 'buffered_patch_line'
will be used to buffer each line, and the other 'buffered_patch_file_pair'
will store information about information relevant on a per file basis.
The buffered_patch_line will duplicate the memory of the line to buffer
as that is easiest to reason about for now.  In a future patch we may want
to decrease the memory usage by not duplicating all output for buffering
but rather we may want to store offsets into the file or in case of hunk
descriptions such as the similarity score, we could just store the relevant
number and reproduce the text later on.

This approach was chosen as a first step because it is quite simple
compared to the alternative with less memory footprint.

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
 diff.c | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 diff.h |  39 ++++++++++++++++
 2 files changed, 181 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index 08dcc56bb9..dbab7fb44e 100644
--- a/diff.c
+++ b/diff.c
@@ -516,29 +516,29 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
-			int sign, const char *line, int len)
+static void emit_buffered_patch_line(struct diff_options *o,
+				     struct buffered_patch_line *e)
 {
-	int has_trailing_newline, has_trailing_carriage_return;
+	int has_trailing_newline, has_trailing_carriage_return, len = e->len;
 	FILE *file = o->file;
 
 	fputs(diff_line_prefix(o), file);
 
-	has_trailing_newline = (len > 0 && line[len-1] == '\n');
+	has_trailing_newline = (len > 0 && e->line[len-1] == '\n');
 	if (has_trailing_newline)
 		len--;
-	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
+	has_trailing_carriage_return = (len > 0 && e->line[len-1] == '\r');
 	if (has_trailing_carriage_return)
 		len--;
 
-	if (len || sign) {
-		if (set)
-			fputs(set, file);
-		if (sign)
-			fputc(sign, file);
-		fwrite(line, len, 1, file);
-		if (reset)
-			fputs(reset, file);
+	if (len || e->sign) {
+		if (e->set)
+			fputs(e->set, file);
+		if (e->sign)
+			fputc(e->sign, file);
+		fwrite(e->line, len, 1, file);
+		if (e->reset)
+			fputs(e->reset, file);
 	}
 	if (has_trailing_carriage_return)
 		fputc('\r', file);
@@ -546,6 +546,65 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 		fputc('\n', file);
 }
 
+static void emit_buffered_patch_line_ws(struct diff_options *o,
+					struct buffered_patch_line *e,
+					const char *ws, unsigned ws_rule)
+{
+	struct buffered_patch_line s = {e->set, e->reset, "", 0, e->sign};
+
+	emit_buffered_patch_line(o, &s);
+	ws_check_emit(e->line, e->len, ws_rule,
+		      o->file, e->set, e->reset, ws);
+}
+
+static void process_next_buffered_patch_line(struct diff_options *o, int line_no)
+{
+	struct buffered_patch_line *e = &o->line_buffer[line_no];
+
+	const char *ws = o->current_filepair->ws;
+	unsigned ws_rule = o->current_filepair->ws_rule;
+
+	switch (e->state) {
+		case BPL_EMIT_LINE_ASIS:
+			emit_buffered_patch_line(o, e);
+			break;
+		case BPL_EMIT_LINE_WS:
+			emit_buffered_patch_line_ws(o, e, ws, ws_rule);
+			break;
+		case BPL_HANDOVER:
+			o->current_filepair++;
+			break;
+		default:
+			die("BUG: malformatted buffered patch line: '%d'", e->state);
+	}
+}
+
+static void append_buffered_patch_line(struct diff_options *o,
+				       struct buffered_patch_line *e)
+{
+	struct buffered_patch_line *f;
+	ALLOC_GROW(o->line_buffer,
+		   o->line_buffer_nr + 1,
+		   o->line_buffer_alloc);
+	f = &o->line_buffer[o->line_buffer_nr];
+	o->line_buffer_nr++;
+
+	memcpy(f, e, sizeof(struct buffered_patch_line));
+	f->line = e->line ? xmemdupz(e->line, e->len) : NULL;
+}
+
+static void emit_line_0(struct diff_options *o,
+			const char *set, const char *reset,
+			int sign, const char *line, int len)
+{
+	struct buffered_patch_line e = {set, reset, line, len, sign, BPL_EMIT_LINE_ASIS};
+
+	if (o->use_buffer)
+		append_buffered_patch_line(o, &e);
+	else
+		emit_buffered_patch_line(o, &e);
+}
+
 void emit_line(struct diff_options *o, const char *set, const char *reset,
 	       const char *line, int len)
 {
@@ -557,9 +616,12 @@ static void emit_line_ws(struct diff_options *o,
 			 const char *line, int len,
 			 const char *ws, unsigned ws_rule)
 {
-	emit_line_0(o, set, reset, sign, "", 0);
-	ws_check_emit(line, len, ws_rule,
-		      o->file, set, reset, ws);
+	struct buffered_patch_line e = {set, reset, line, len, sign, BPL_EMIT_LINE_WS};
+
+	if (o->use_buffer)
+		append_buffered_patch_line(o, &e);
+	else
+		emit_buffered_patch_line_ws(o, &e, ws, ws_rule);
 }
 
 void emit_line_fmt(struct diff_options *o,
@@ -1160,6 +1222,16 @@ static void diff_words_flush(struct emit_callback *ecbdata)
 	if (ecbdata->diff_words->minus.text.size ||
 	    ecbdata->diff_words->plus.text.size)
 		diff_words_show(ecbdata->diff_words);
+
+	if (ecbdata->diff_words->opt->line_buffer_nr) {
+		int i;
+		for (i = 0; i < ecbdata->diff_words->opt->line_buffer_nr; i++)
+			append_buffered_patch_line(ecbdata->opt,
+				&ecbdata->diff_words->opt->line_buffer[i]);
+
+		ecbdata->diff_words->opt->line_buffer_nr = 0;
+		/* TODO: free memory as well */
+	}
 }
 
 static void diff_filespec_load_driver(struct diff_filespec *one)
@@ -1195,6 +1267,11 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 		xcalloc(1, sizeof(struct diff_words_data));
 	ecbdata->diff_words->type = o->word_diff;
 	ecbdata->diff_words->opt = o;
+
+	o->line_buffer = NULL;
+	o->line_buffer_nr = 0;
+	o->line_buffer_alloc = 0;
+
 	if (!o->word_regex)
 		o->word_regex = userdiff_word_regex(one);
 	if (!o->word_regex)
@@ -2568,9 +2645,25 @@ static void builtin_diff(const char *name_a,
 			xecfg.ctxlen = strtoul(v, NULL, 10);
 		if (o->word_diff)
 			init_diff_words_data(&ecbdata, o, one, two);
+		if (o->use_buffer) {
+			ALLOC_GROW(o->filepair_buffer,
+				   o->filepair_buffer_nr + 1,
+				   o->filepair_buffer_alloc);
+			o->current_filepair =
+				&o->filepair_buffer[o->filepair_buffer_nr++];
+
+			o->current_filepair->ws_rule = ecbdata.ws_rule;
+			o->current_filepair->ws =
+				diff_get_color(ecbdata.color_diff, DIFF_WHITESPACE);
+		}
 		if (xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
 				  &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
+		if (o->use_buffer) {
+			struct buffered_patch_line e = BUFFERED_PATCH_LINE_INIT;
+			e.state = BPL_HANDOVER; /* handover to next file pair */
+			append_buffered_patch_line(o, &e);
+		}
 		if (o->word_diff)
 			free_diff_words_data(&ecbdata);
 		if (textconv_one)
@@ -4785,11 +4878,44 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 {
 	int i;
 	struct diff_queue_struct *q = &diff_queued_diff;
+	/*
+	 * For testing purposes we want to make sure the diff machinery
+	 * works completely with the buffer. If there is anything emitted
+	 * outside the emit_buffered_patch_line, then the order is screwed
+	 * up and the tests will fail.
+	 *
+	 * TODO (later in this series):
+	 * We'll unset this flag in a later patch.
+	 */
+	o->use_buffer = 1;
+
+	if (o->use_buffer) {
+		ALLOC_GROW(o->filepair_buffer,
+			   o->filepair_buffer_nr + 1,
+			   o->filepair_buffer_alloc);
+		o->current_filepair = &o->filepair_buffer[o->filepair_buffer_nr];
+	}
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (check_pair_status(p))
 			diff_flush_patch(p, o);
 	}
+
+	if (o->use_buffer) {
+		o->current_filepair = &o->filepair_buffer[0];
+		for (i = 0; i < o->line_buffer_nr; i++)
+			process_next_buffered_patch_line(o, i);
+
+		for (i = 0; i < o->line_buffer_nr; i++);
+			free((void*)o->line_buffer[i].line);
+
+		o->line_buffer = NULL;
+		o->line_buffer_nr = 0;
+		free(o->line_buffer);
+		o->filepair_buffer = NULL;
+		o->filepair_buffer_nr = 0;
+		free(o->filepair_buffer);
+	}
 }
 
 void diff_flush(struct diff_options *options)
diff --git a/diff.h b/diff.h
index 5e89481769..c334aac02e 100644
--- a/diff.h
+++ b/diff.h
@@ -115,6 +115,36 @@ enum diff_submodule_format {
 	DIFF_SUBMODULE_INLINE_DIFF
 };
 
+/*
+ * This struct is used when we need to buffer the output of the diff output.
+ *
+ * NEEDSWORK: Instead of storing a copy of the line, add an offset pointer
+ * into the pre/post image file. This pointer could be a union with the
+ * line pointer. By storing an offset into the file instead of the literal line,
+ * we can decrease the memory footprint for the buffered output. At first we
+ * may want to only have indirection for the content lines, but we could
+ * also have an enum (based on sign?) that stores prefabricated lines, e.g.
+ * the similarity score line or hunk/file headers.
+ */
+struct buffered_patch_line {
+	const char *set;
+	const char *reset;
+	const char *line;
+	int len;
+	int sign;
+	enum {
+		BPL_EMIT_LINE_WS,
+		BPL_EMIT_LINE_ASIS,
+		BPL_HANDOVER
+	} state;
+};
+#define BUFFERED_PATCH_LINE_INIT {NULL, NULL, NULL, 0, 0, 0}
+
+struct buffered_filepair {
+	const char *ws;
+	unsigned ws_rule;
+};
+
 struct diff_options {
 	const char *orderfile;
 	const char *pickaxe;
@@ -186,6 +216,15 @@ struct diff_options {
 	void *output_prefix_data;
 
 	int diff_path_counter;
+
+	int use_buffer;
+
+	struct buffered_patch_line *line_buffer;
+	int line_buffer_nr, line_buffer_alloc;
+
+	struct buffered_filepair *filepair_buffer;
+	int filepair_buffer_nr, filepair_buffer_alloc;
+	struct buffered_filepair *current_filepair;
 };
 
 void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
-- 
2.13.0.18.g183880de0a

