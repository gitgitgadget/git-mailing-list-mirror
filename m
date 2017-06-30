Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60E48202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbdF3AH6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:07:58 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36648 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbdF3AHv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:51 -0400
Received: by mail-pg0-f49.google.com with SMTP id u62so55122009pgb.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hr9Ge1pr1ZK0kbsb/rwJH+KioD+GeDGYc/XuqQPBVPk=;
        b=UtxmKHPxbrMqnPvdw4Ih5N9v2lgLDROlBNCP7fA1P6+ckOul4wCBBW436m8scZgMyx
         YYeDkDYCjKTVQrhrk9FiVVK7/7OXRGwj44cAIYWHuLJ45kggy72HkXCq8oxhqWJfpCWm
         jwnLEkmjZGCYe0ztrA+zElD8sglYdhpz9tJFOnsWratL66/sgJgT9JPm+Xwlfq2Pl5Li
         mBYOFA9ls0cd2kf5oNSkzxFUg7NEmNhw8two3ThYUHufRXgPctFtapgPweIn6lmEVt4m
         gFD+sjvljgsYDq5PI/i6mXBLPJXzQ8w5/OrkAqGtLIfvAvxkp3KsdolFSimAbIOvDG39
         iQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hr9Ge1pr1ZK0kbsb/rwJH+KioD+GeDGYc/XuqQPBVPk=;
        b=gIggXM4DfAf3ODAXdhKiemB06W4FI74VVFafEjkClIogdY4XzshhrKyKY7zzaXbC9C
         WjZqblydUBdH382EVzE5+bw0adTUDXRNpd4DDg5yR7o25QOOxRDKhs8mnp1c0URrBHfh
         Jto7HQ98DOlJn9N5Nj6NTOkeT4nT3ZYbkANVdgxJHKfquxKUVSt+KKk7Vggfhhb6jtWk
         hr+uz+WuHCfVRqFqG8d5c6Kn/bRTSz+T+lOXDoNeqNTogNLKoIFbUEc5yqSrmiBZGuJ0
         E0fNC8qXsQiAUVZC3G3O1BtR2YtyrJx5axhoZoBvX2fcchUauPHZndH9svrCzY2jSJ6o
         FYXQ==
X-Gm-Message-State: AKS2vOzYQ1T3ekNK0m7+xrYbuNWQ+wSs5k9xD9l4AZtUaDE3X/g1R7JA
        mg18K9GUnLlU55kW
X-Received: by 10.98.9.205 with SMTP id 74mr19010114pfj.77.1498781270002;
        Thu, 29 Jun 2017 17:07:50 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id d24sm14873405pfk.43.2017.06.29.17.07.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 21/25] diff.c: buffer all output if asked to
Date:   Thu, 29 Jun 2017 17:07:06 -0700
Message-Id: <20170630000710.10601-22-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 diff.h |   2 ++
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 2db0d7c0f5..31720abf8f 100644
--- a/diff.c
+++ b/diff.c
@@ -605,6 +605,47 @@ enum diff_symbol {
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
@@ -631,12 +672,18 @@ static void emit_line_ws_markup(struct diff_options *o,
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
 	case DIFF_SYMBOL_NO_LF_EOF:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
@@ -778,6 +825,17 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
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
@@ -1374,9 +1432,29 @@ static void diff_words_show(struct diff_words_data *diff_words)
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
@@ -1412,6 +1490,11 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
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
@@ -1446,6 +1529,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 {
 	if (ecbdata->diff_words) {
 		diff_words_flush(ecbdata);
+		free (ecbdata->diff_words->opt->emitted_symbols);
 		free (ecbdata->diff_words->opt);
 		free (ecbdata->diff_words->minus.text.ptr);
 		free (ecbdata->diff_words->minus.orig);
@@ -4996,16 +5080,37 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
 static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 {
 	int i;
+	static struct emitted_diff_symbols esm = EMITTED_DIFF_SYMBOLS_INIT;
 	struct diff_queue_struct *q = &diff_queued_diff;
 
 	if (WSEH_NEW & WS_RULE_MASK)
 		die("BUG: WS rules bit mask overlaps with diff symbol flags");
 
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
index d6094a1eed..4a3b9bde40 100644
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
2.13.0.31.g9b732c453e

