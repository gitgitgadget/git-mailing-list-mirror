Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317331FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbdFTCs4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:56 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36715 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdFTCsv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:51 -0400
Received: by mail-pg0-f42.google.com with SMTP id u62so37278408pgb.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B89jzmmN7QOrNUuwXEBqaJDaR+o6h06Y5+KiCLqgoFU=;
        b=fi0AIPRlRGKLLdkXrhZgx5TBcw1VnA4MupHc1wfqGsmD4Or44Fft/MVyoUH5Faftod
         u7hsgsVY9uUrh1VCNnDhK1GvhJcGryzJ/L73jrBULsyUzlmFJgiqBuIgtmPMBBLGsGnk
         RSiQJKQedwfJsZCY+JW2sjM+7hVlRmHKsj5zAFehc6EYckiOddBRNE37ini3I6ARaoOG
         g9IJPF1LzS7bIlqrkgIQSQXDXvCefI5+3Tacl7TQTkLetK/omAqaQoA5YTn7Sqsc/wGO
         m6DTmgYWy08LzQHzs/08WiWZvNg2lp2K/pSrL9LZKVcu2oLNXicia4L69hixRpkAk5hf
         O6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B89jzmmN7QOrNUuwXEBqaJDaR+o6h06Y5+KiCLqgoFU=;
        b=BvJuoi6VuuxOWIMRebZ3RiJ8KPzB4vbfb9KSm4mZtO9fWzMd4/awKqkSg6fn7uin7v
         GD8W+Wyv/DLMC0BC0WObKNQ8fD+zVYE5FBZPmwLDl3Hpd+JNuOq7NZ8i0OH3VaPZiSGW
         cWIhrSvkvZNwh4DXr7j3eulj0T//OYMLpxWbN/DQ/kZEQjqfqaphTXsRSc3tBpdi6OhN
         F+TYn8l9NuEyOR/0wN3fAYIrpM9UOIHwtB22iUMxNRdl0bjX6X1BO/DNSKKWNvfmvWu/
         zDeUu2Fopp2LM64OKYqP7qMrWrf2zkUuVCrCSnRN6FgQpqIjt1Lw8vsZPr2u61FM4E1E
         1k9Q==
X-Gm-Message-State: AKS2vOx0Aep9Nc/uI2TH6s+Mk7Wys1xXN50WcJWxrA1WLuJYi/3d8job
        G5inaR8mz0pF1vIT
X-Received: by 10.84.148.203 with SMTP id y11mr1413645plg.211.1497926930352;
        Mon, 19 Jun 2017 19:48:50 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id t6sm13586261pgs.33.2017.06.19.19.48.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 21/26] diff.c: buffer all output if asked to
Date:   Mon, 19 Jun 2017 19:48:11 -0700
Message-Id: <20170620024816.20021-22-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a new option 'emitted_symbols' in the struct diff_options which
controls whether all output is buffered up until all output is available.
It is set internally in diff.c when necessary.

We'll have a new struct 'emitted_string' in diff.c which will be used to
buffer each line.  The emitted_string will duplicate the memory of the
line to buffer as that is easiest to reason about for now. In a future
patch we may want to decrease the memory usage by not duplicating all
output for buffering but rather we may want to store offsets into the
file or in case of hunk descriptions such as the similarity score, we
could just store the relevant number and reproduce the text later on.

This approach was chosen as a first step because it is quite simple
compared to the alternative with less memory footprint.

emit_diff_symbol factors out the emission part and depending on the
diff_options->emitted_symbols the emission will be performed directly
when calling emit_diff_symbol or after the whole process is done, i.e.
by buffering we have add the possibility for a second pass over the
whole output before doing the actual output.

In 6440d34 (2012-03-14, diff: tweak a _copy_ of diff_options with
word-diff) we introduced a duplicate diff options struct for word
emissions as we may have different regex settings in there.
When buffering the output, we need to operate on just one buffer,
so we have to copy back the emissions of the word buffer into the
main buffer.

Unconditionally enable output via buffer in this patch as it yields
a great opportunity for testing, i.e. all the diff tests from the
test suite pass without having reordering issues (i.e. only parts
of the output got buffered, and we forgot to buffer other parts).
The test suite passes, which gives confidence that we converted all
functions to use emit_string for output.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 diff.h |   2 ++
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index f2f7a4da79..35b5924ff2 100644
--- a/diff.c
+++ b/diff.c
@@ -603,6 +603,47 @@ enum diff_symbol {
 #define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF (1<<16)
 #define DIFF_SYMBOL_CONTENT_WS_MASK (WSEH_NEW | WSEH_OLD | WSEH_CONTEXT | WS_RULE_MASK)
 
+/*
+ * This struct is used when we need to buffer the output of the diff output.
+ *
+ * NEEDSWORK: Instead of storing a copy of the line, add an offset pointer
+ * into the pre/post image file. This pointer could be a union with the
+ * line pointer. By storing an offset into the file instead of the literal line,
+ * we can decrease the memory footprint for the buffered output. At first we
+ * may want to only have indirection for the content lines, but we could also
+ * enhance the state for emitting prefabricated lines, e.g. the similarity
+ * score line or hunk/file headers would only need to store a number or path
+ * and then the output can be constructed later on depending on state.
+ */
+struct emitted_diff_symbol {
+	const char *line;
+	int len;
+	int flags;
+	enum diff_symbol s;
+};
+#define EMITTED_DIFF_SYMBOL_INIT {NULL}
+
+struct emitted_diff_symbols {
+	struct emitted_diff_symbol *buf;
+	int nr, alloc;
+};
+#define EMITTED_DIFF_SYMBOLS_INIT {NULL, 0, 0}
+
+static void append_emitted_diff_symbol(struct diff_options *o,
+				       struct emitted_diff_symbol *e)
+{
+	struct emitted_diff_symbol *f;
+
+	ALLOC_GROW(o->emitted_symbols->buf,
+		   o->emitted_symbols->nr + 1,
+		   o->emitted_symbols->alloc);
+	f = &o->emitted_symbols->buf[o->emitted_symbols->nr++];
+
+	memcpy(f, e, sizeof(struct emitted_diff_symbol));
+	f->line = e->line ? xmemdupz(e->line, e->len) : NULL;
+}
+
+
 static void emit_line_ws_markup(struct diff_options *o,
 				const char *set, const char *reset,
 				const char *line, int len, char sign,
@@ -629,12 +670,18 @@ static void emit_line_ws_markup(struct diff_options *o,
 	}
 }
 
-static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
-			     const char *line, int len, unsigned flags)
+static void emit_diff_symbol_from_struct(struct diff_options *o,
+					 struct emitted_diff_symbol *eds)
 {
 	static const char *nneof = " No newline at end of file\n";
 	const char *context, *reset, *set, *meta, *fraginfo;
 	struct strbuf sb = STRBUF_INIT;
+
+	enum diff_symbol s = eds->s;
+	const char *line = eds->line;
+	int len = eds->len;
+	unsigned flags = eds->flags;
+
 	switch (s) {
 	case DIFF_SYMBOL_SEPARATOR:
 		fprintf(o->file, "%s%c",
@@ -790,6 +837,17 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	strbuf_release(&sb);
 }
 
+static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
+			     const char *line, int len, unsigned flags)
+{
+	struct emitted_diff_symbol e = {line, len, flags, s};
+
+	if (o->emitted_symbols)
+		append_emitted_diff_symbol(o, &e);
+	else
+		emit_diff_symbol_from_struct(o, &e);
+}
+
 void diff_emit_submodule_del(struct diff_options *o, const char *line)
 {
 	emit_diff_symbol(o, DIFF_SYMBOL_SUBMODULE_DEL, line, strlen(line), 0);
@@ -1384,9 +1442,29 @@ static void diff_words_show(struct diff_words_data *diff_words)
 /* In "color-words" mode, show word-diff of words accumulated in the buffer */
 static void diff_words_flush(struct emit_callback *ecbdata)
 {
+	struct diff_options *wo = ecbdata->diff_words->opt;
+
 	if (ecbdata->diff_words->minus.text.size ||
 	    ecbdata->diff_words->plus.text.size)
 		diff_words_show(ecbdata->diff_words);
+
+	if (wo->emitted_symbols) {
+		struct diff_options *o = ecbdata->opt;
+		struct emitted_diff_symbols *wol = wo->emitted_symbols;
+		int i;
+
+		/*
+		 * NEEDSWORK:
+		 * Instead of appending each, concat all words to a line?
+		 */
+		for (i = 0; i < wol->nr; i++)
+			append_emitted_diff_symbol(o, &wol->buf[i]);
+
+		for (i = 0; i < wol->nr; i++)
+			free((void *)wol->buf[i].line);
+
+		wol->nr = 0;
+	}
 }
 
 static void diff_filespec_load_driver(struct diff_filespec *one)
@@ -1422,6 +1500,11 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 		xcalloc(1, sizeof(struct diff_words_data));
 	ecbdata->diff_words->type = o->word_diff;
 	ecbdata->diff_words->opt = o;
+
+	if (orig_opts->emitted_symbols)
+		o->emitted_symbols =
+			xcalloc(1, sizeof(struct emitted_diff_symbols));
+
 	if (!o->word_regex)
 		o->word_regex = userdiff_word_regex(one);
 	if (!o->word_regex)
@@ -1456,6 +1539,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 {
 	if (ecbdata->diff_words) {
 		diff_words_flush(ecbdata);
+		free (ecbdata->diff_words->opt->emitted_symbols);
 		free (ecbdata->diff_words->opt);
 		free (ecbdata->diff_words->minus.text.ptr);
 		free (ecbdata->diff_words->minus.orig);
@@ -5008,12 +5092,33 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 {
 	int i;
+	static struct emitted_diff_symbols esm = EMITTED_DIFF_SYMBOLS_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
+	/*
+	 * For testing purposes we want to make sure the diff machinery
+	 * works completely with the buffer. If there is anything emitted
+	 * outside the emit_string, then the order is screwed
+	 * up and the tests will fail.
+	 *
+	 * TODO (later in this series):
+	 * We'll unset this pointer in a later patch.
+	 */
+	o->emitted_symbols = &esm;
+
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (check_pair_status(p))
 			diff_flush_patch(p, o);
 	}
+
+	if (o->emitted_symbols) {
+		for (i = 0; i < esm.nr; i++)
+			emit_diff_symbol_from_struct(o, &esm.buf[i]);
+
+		for (i = 0; i < esm.nr; i++)
+			free((void *)esm.buf[i].line);
+	}
+	esm.nr = 0;
 }
 
 void diff_flush(struct diff_options *options)
diff --git a/diff.h b/diff.h
index b73f7a1e75..65fc9dbb4b 100644
--- a/diff.h
+++ b/diff.h
@@ -186,6 +186,8 @@ struct diff_options {
 	void *output_prefix_data;
 
 	int diff_path_counter;
+
+	struct emitted_diff_symbols *emitted_symbols;
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
-- 
2.12.2.575.gb14f27f917

