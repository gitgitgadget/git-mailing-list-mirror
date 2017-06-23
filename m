Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4972620836
	for <e@80x24.org>; Fri, 23 Jun 2017 01:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754141AbdFWBaP (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:30:15 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34077 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754094AbdFWB3z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:55 -0400
Received: by mail-pg0-f43.google.com with SMTP id e187so15008485pgc.1
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xQEf27/VhnmeoLFYU14nrDOBJIrgi3rye6zJHjQNaBw=;
        b=Ci3s4plqItvmrAbwx7Nh+UcKSv2cM2kQSNMi7aPew6SRBcoDboKhuFY+N2RmUFLQyG
         mvOwQLHaQFS0fWVr0z+MRb4+qW4ZvuiIOFZ5lD+0Pao6RpkOeWR0WzJLQwG4GU1wmuju
         EADnw6/Jsg3RE8i8Qs/07zPH08KiGCbz0cwqQFeIa4kPqSFj2vd7JMs7lJiowvJ6uqLy
         QQn5p4lXxKJrCPIsFiq+hkRD8szsOYoivlRTI0oDwjaQ6XrGGBCHeRSBAitItyamcDUt
         XJTGGJbQmkmQsMazB0tBYBSwuAHOM7zuwvch8bhuBcrmTw933t70qTRfJhbEjn86KLub
         c5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xQEf27/VhnmeoLFYU14nrDOBJIrgi3rye6zJHjQNaBw=;
        b=c0MF7MhP3B6i1Cp3g9vE45KaIah/CnGrXlWe/nZpNMND1AuHI+odwhzkWHSXH8kiP9
         gO+oX9xoz9tm7WYHhn+REuYB2LHn5CuAOlvlB0IGkMMVQE1cShJdN//WwwV2J/z9pUyQ
         BYz6WDp7m9cDJRSDGEqPJmXq2zooJalu5SQi6lPg5MyMB4QZ1uROdtIWuhuDQkn/uhh/
         5wPXqEGyW7K5xIWu/IAK54SKRfBnT/GE+997+KGGfo4RZFCA5ZWksEuQgFr2YOAJL7Hv
         veZXXOrlKQdZJYLYyL7t3yQmlGnmbnbaZgtt7zvV8U+N3MQ5+JOR1xWmfAWFGb2US83I
         JIiQ==
X-Gm-Message-State: AKS2vOzX+S85TCfEfb9jgz9rxd2nZeQ4DfbsxYUYunlQRGDaF/ESZPj9
        kq39gu2Y3jKJrv8/
X-Received: by 10.101.69.142 with SMTP id o14mr5655768pgq.0.1498181394632;
        Thu, 22 Jun 2017 18:29:54 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id a187sm5767489pgc.37.2017.06.22.18.29.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:54 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 21/25] diff.c: buffer all output if asked to
Date:   Thu, 22 Jun 2017 18:29:15 -0700
Message-Id: <20170623012919.28693-22-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
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
index f9fb94b0d3..b344808c20 100644
--- a/diff.c
+++ b/diff.c
@@ -604,6 +604,47 @@ enum diff_symbol {
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
@@ -630,12 +671,18 @@ static void emit_line_ws_markup(struct diff_options *o,
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
@@ -777,6 +824,17 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
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
@@ -1373,9 +1431,29 @@ static void diff_words_show(struct diff_words_data *diff_words)
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
@@ -1411,6 +1489,11 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
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
@@ -1445,6 +1528,7 @@ static void free_diff_words_data(struct emit_callback *ecbdata)
 {
 	if (ecbdata->diff_words) {
 		diff_words_flush(ecbdata);
+		free (ecbdata->diff_words->opt->emitted_symbols);
 		free (ecbdata->diff_words->opt);
 		free (ecbdata->diff_words->minus.text.ptr);
 		free (ecbdata->diff_words->minus.orig);
@@ -4999,16 +5083,37 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
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

