Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5F6E20209
	for <e@80x24.org>; Wed, 24 May 2017 21:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164170AbdEXVlC (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 17:41:02 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34554 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163618AbdEXVkx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 17:40:53 -0400
Received: by mail-pf0-f176.google.com with SMTP id 9so147334899pfj.1
        for <git@vger.kernel.org>; Wed, 24 May 2017 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Brm3MfwaEKWB6t28QGW9VCIBdjQUVtDGaBPJc0irauo=;
        b=nnaGMJM/YgRPPoYttIcsCFdhJlv399+Bv+CbDRJ1YJfdAkKvLrVh4YM1ygcS8ay3P2
         SjiehdeBZPltCeCm6loxg80AuFBVgrcYx3vuIObBr9S8lNNB4qOAE2Ai2u1i+TWTBKGL
         e6Bf+JzVV3ABUq5Hj1fECk8DHvIy+BYPeNcvy9g5zbWiyIz1tBFoCG0DptMZtiZ/wfGG
         YZypwT+dCx5dCjep4usY9fRO+madsvb+RxWui2Yrck6Am+YY8/1QpHEMAEkYneBm8I25
         t8r/3FjZ+BuY8UTil6eqewsLEmRbhbDQO8XWFn8AivTopKqsKe9uU/oISAgUlM5fNAM9
         XLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Brm3MfwaEKWB6t28QGW9VCIBdjQUVtDGaBPJc0irauo=;
        b=Vq8bbASUcMECou/YOb/dlFtJkAzjKXZXeDIeFjYnAKWHa2AbGXZPxxts0PmsG8eskD
         ZEY2GU8A1eWYhLy5GVRGQJRfk7rlJ7hWKZG6TJTysFhq12NWuhseatFxLAtMQQcO5ape
         VvsJxOtP+4r9kb5MUmr6NX2bINveO2OmdVxoL9TNw0VhZ8QoVFf56bh0DZ2V4e3/5bS0
         d+wajcB9rAk4kecxsW6ADXcu1vpSfYa9FEPTxTbOHYaTt103Y1ejcnK1Jk+HIZyR/DOi
         74Nnjg464X53SQTcBrQ6/GCUljzXrOVP1exxj8fZGFE2iGBb0cDSsxlrqx/O10SgEaim
         sfSA==
X-Gm-Message-State: AODbwcD2WGFN0f2ZusQo3JpY/8+WGkii4hxjAwizenCTvMxMSjF8WSoH
        62yLjyFsuIm9hoRf
X-Received: by 10.99.24.66 with SMTP id 2mr4555538pgy.105.1495662047512;
        Wed, 24 May 2017 14:40:47 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:70df:e59:d409:fbba])
        by smtp.gmail.com with ESMTPSA id b195sm7719890pfb.29.2017.05.24.14.40.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 14:40:46 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 05/17] diff.c: convert fn_out_consume to use emit_line
Date:   Wed, 24 May 2017 14:40:24 -0700
Message-Id: <20170524214036.29623-6-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170524214036.29623-1-sbeller@google.com>
References: <20170523024048.16879-1-sbeller@google.com/>
 <20170524214036.29623-1-sbeller@google.com>
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
function is emit_line.

This covers the parts of fn_out_consume.  In the next
patches we'll convert more functions that want to emit
formatted output, so we'd want to have a formatted emit
function. Add it here.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 3569857818..8186289734 100644
--- a/diff.c
+++ b/diff.c
@@ -547,6 +547,21 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 		fputc('\n', file);
 }
 
+static void emit_line_fmt(struct diff_options *o,
+			  const char *set, const char *reset,
+			  int add_line_prefix,
+			  const char *fmt, ...)
+{
+	struct strbuf sb = STRBUF_INIT;
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	va_end(ap);
+
+	emit_line(o, set, reset, add_line_prefix, 0, sb.buf, sb.len);
+	strbuf_release(&sb);
+}
+
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
 {
 	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
@@ -1270,7 +1285,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *context = diff_get_color(ecbdata->color_diff, DIFF_CONTEXT);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
-	const char *line_prefix = diff_line_prefix(o);
 
 	o->found_changes = 1;
 
@@ -1282,14 +1296,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 
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
+		emit_line_fmt(o, meta, reset, 1, "--- %s%s\n",
+			      ecbdata->label_path[0], name_a_tab);
+		emit_line_fmt(o, meta, reset, 1, "+++ %s%s\n",
+			      ecbdata->label_path[1], name_b_tab);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
@@ -1330,7 +1342,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
 			emit_line(o, context, reset, 1, 0, line, len);
-			fputs("~\n", o->file);
+			emit_line(o, NULL, NULL, 0, 0, "~\n", 2);
 		} else {
 			/*
 			 * Skip the prefix character, if any.  With
-- 
2.13.0.18.g7d86cc8ba0

