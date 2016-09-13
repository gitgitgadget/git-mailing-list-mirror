Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E619207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbcIMEqh (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:37 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33752 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbcIMEq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:29 -0400
Received: by mail-pf0-f174.google.com with SMTP id g202so59756296pfb.0
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S+WR5MCvjeFjkdrCQYIG5Q54XJ5tSa5bW0G2UNZwjE8=;
        b=otyHgMMbwHpod5GCUbwT6zyyz66Rq6TUwYNzTXpxos/9tCD9K4OnilRmnBZ+UAKfH3
         6bkZL0I5JevfCvMn+ktO5qT6wBjXqc02IzGFgF2AsFbJ9KqrHMy8vBj1tkYvv3WMzRxQ
         YJYTNPMiNIPFdQomtQhONWMNYhDHNGGt4waI/5VnXqyR0YnyIE9ReYB1HIGpcMMQYSjc
         GQRp9OonJ1W8kTbtzKk41OEu4Cm0/cP2257253SXakmsINXg5rgqol/YnsTphr/5XbP0
         MadL3CJwPV+ngrdvculdIFDG1uCu3qqahoNIDVn+2KncFg0rsgpGm4/mO7alfHWFT8yH
         k5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S+WR5MCvjeFjkdrCQYIG5Q54XJ5tSa5bW0G2UNZwjE8=;
        b=P5LbM3zK+UpDsjgv0yXKWCpdJoyx5GBLkcM7s6HcnowsaWfSwG/mBsxpuEj5TbfEKp
         Gd7KXp0BVCqdjX7rtkszPrC3LaXlPUTfkfjy1S4qN8tyxd4t5pl5K1sseWmEiVEA9CCA
         Y2zsDfKpU1fAwaB2NrLd+F+zQwaKFh3hNOHMXcwSfDmKon4cz64UaTv4OveeEJhKLuqk
         VeW/a8UXRZKLiYc0kzI0E3xIYIlzrGibWWYgar0eb/PnBxQlV1LOyek9iiHH+8egvORO
         761lM5jIMKvWfYrfHZ5UUHjKkKndvvUwjA1qrTJmRDnY/QaWEjhNhbCkEbsP12Iv5j1r
         hgng==
X-Gm-Message-State: AE9vXwNA50gnHxYcYClVSmN4NDFQnNxig5p8r67bOVWMiFltLo7sXiVLrkusKC0Qde2+YDrk
X-Received: by 10.98.150.10 with SMTP id c10mr19388813pfe.73.1473741987654;
        Mon, 12 Sep 2016 21:46:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id o8sm27787601pfg.67.2016.09.12.21.46.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 06/17] diff.c: convert fn_out_consume to use emit_line_*
Date:   Mon, 12 Sep 2016 21:46:02 -0700
Message-Id: <20160913044613.1037-7-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.21.g1da280f.dirty
In-Reply-To: <20160913044613.1037-1-sbeller@google.com>
References: <20160913044613.1037-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, I want to propose an option to detect&color
moved lines in a diff, which cannot be done in a one-pass over
the diff. Instead we need to go over the whole diff twice,
because we cannot detect the first line of the two corresponding
lines (+ and -) that got moved.

So to prepare the diff machinery for two pass algorithms
(i.e. buffer it all up and then operate on the result),
move all emissions to places, such that the only emitting
function is emit_line_0.

This covers the remaining parts of fn_out_consume.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 5d57130..b4f4b75 100644
--- a/diff.c
+++ b/diff.c
@@ -493,6 +493,19 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 	emit_line_0(o, set, reset, line[0], line+1, len-1);
 }
 
+static void emit_line_fmt(struct diff_options *o,
+			  const char *set, const char *reset,
+			  const char *fmt, ...)
+{
+	struct strbuf sb = STRBUF_INIT;
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	va_end(ap);
+
+	emit_line(o, set, reset, sb.buf, sb.len);
+}
+
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
 {
 	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
@@ -1217,7 +1230,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *context = diff_get_color(ecbdata->color_diff, DIFF_CONTEXT);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
-	const char *line_prefix = diff_line_prefix(o);
 
 	o->found_changes = 1;
 
@@ -1229,14 +1241,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 
 	if (ecbdata->label_path[0]) {
 		const char *name_a_tab, *name_b_tab;
-
 		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
 		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
-
-		fprintf(o->file, "%s%s--- %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
-		fprintf(o->file, "%s%s+++ %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
+		emit_line_fmt(o, meta, reset, "--- %s%s\n",
+			      ecbdata->label_path[0], name_a_tab);
+		emit_line_fmt(o, meta, reset, "+++ %s%s\n",
+			      ecbdata->label_path[1], name_b_tab);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
@@ -1277,7 +1287,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
 			emit_line(o, context, reset, line, len);
-			fputs("~\n", o->file);
+			emit_line(o, 0, 0, "~\n", 2);
 		} else {
 			/*
 			 * Skip the prefix character, if any.  With
-- 
2.10.0.21.g1da280f.dirty

