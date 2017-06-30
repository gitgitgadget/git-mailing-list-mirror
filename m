Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53370202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbdF3AHq (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:07:46 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35657 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752162AbdF3AHn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:43 -0400
Received: by mail-pf0-f179.google.com with SMTP id c73so58095800pfk.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O2w77kzES0r2Dh8U1J8do2+uyPpqXAd63LY55cj4cmQ=;
        b=MoB2WFTcv3/2izOEPMjUHNX062oJNK08PJbkBVt92vl8jIMuEI2p2+lnFojIpeHz6V
         3GqlHq5lWKTnzubXmSSmY/EhBasVqX2AGkdq11eXgLpLjLezhB1c9rxU+Oh0NqMF7/+U
         SMyFsIXpDF+sfnQEDT8aYd5Q3d7WhlhbPJGCyaQxojg5P+CYORJD3pPmnn5Ac/YpRV56
         Dh0GU83Y0cfuwJJe0LGe/lQU3p2WnZBIYE0v67dq61Diefewm11AheGPfV1+tqLsGgi4
         mbIcM8WczVljRaef74RA78pgc3W/PLKW83y15Ti2MoBATWOig4CoenFtRNYv05y6DOqt
         N3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O2w77kzES0r2Dh8U1J8do2+uyPpqXAd63LY55cj4cmQ=;
        b=n0amnd49O/hn5XVFnYmfXg1s7f5XZcc5c7P6B44gje2sZErflDTrXmXULX3nQ3hxHU
         crtHb2BSCcy8bAZcOo3bmUxcHgbyBfp/WSAnA3fWHqZpdG+zXMCxJmxUGIUIXRP8/Ckt
         fOQaMM0E3JGy2gteK4S+qPqN6o2y7Y2J2UJoN16SGoO6jtuOiyVe+oHqkr8YHs89F1CB
         6OrwwQse1QXzdipITOgHXsylRcVFGKPUoV+2aTiLIQrXRWNPEjrZKzAR87PFsOD1ZAaG
         DPAzMbAlrapO3P+MMkTASg1O/fe6GB/EHbpYA3H7hQuVd5eXs2ok4qHZnHZgEfvmbmUb
         rB2w==
X-Gm-Message-State: AKS2vOzTAxdt5lanGMQnlnL+TlcdbZOZJA03aDK8ULK/m9tC68U5ksft
        6K1+iPYwF8kPr3LF
X-Received: by 10.99.158.18 with SMTP id s18mr18308865pgd.113.1498781257734;
        Thu, 29 Jun 2017 17:07:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id g10sm9295620pgr.18.2017.06.29.17.07.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR_{PLUS, MINUS}
Date:   Thu, 29 Jun 2017 17:06:56 -0700
Message-Id: <20170630000710.10601-12-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have to use fprintf instead of emit_line, because we want to emit the
tab after the color. This is important for ancient versions of gnu patch
AFAICT, although we probably do not want to feed colored output to the
patch utility, such that it would not matter if the trailing tab is
colored. Keep the corner case as-is though.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 51 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/diff.c b/diff.c
index b2b2a19fcf..49b45fef29 100644
--- a/diff.c
+++ b/diff.c
@@ -561,6 +561,8 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_FILEPAIR_PLUS,
+	DIFF_SYMBOL_FILEPAIR_MINUS,
 	DIFF_SYMBOL_WORDS_PORCELAIN,
 	DIFF_SYMBOL_WORDS,
 	DIFF_SYMBOL_CONTEXT,
@@ -611,7 +613,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len, unsigned flags)
 {
 	static const char *nneof = " No newline at end of file\n";
-	const char *context, *reset, *set;
+	const char *context, *reset, *set, *meta;
 	switch (s) {
 	case DIFF_SYMBOL_NO_LF_EOF:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
@@ -673,6 +675,20 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 		}
 		emit_line(o, context, reset, line, len);
 		break;
+	case DIFF_SYMBOL_FILEPAIR_PLUS:
+		meta = diff_get_color_opt(o, DIFF_METAINFO);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		fprintf(o->file, "%s%s+++ %s%s%s\n", diff_line_prefix(o), meta,
+			line, reset,
+			strchr(line, ' ') ? "\t" : "");
+		break;
+	case DIFF_SYMBOL_FILEPAIR_MINUS:
+		meta = diff_get_color_opt(o, DIFF_METAINFO);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		fprintf(o->file, "%s%s--- %s%s%s\n", diff_line_prefix(o), meta,
+			line, reset,
+			strchr(line, ' ') ? "\t" : "");
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -844,8 +860,6 @@ static void emit_rewrite_diff(const char *name_a,
 			      struct diff_options *o)
 {
 	int lc_a, lc_b;
-	const char *name_a_tab, *name_b_tab;
-	const char *metainfo = diff_get_color(o->use_color, DIFF_METAINFO);
 	const char *fraginfo = diff_get_color(o->use_color, DIFF_FRAGINFO);
 	const char *reset = diff_get_color(o->use_color, DIFF_RESET);
 	static struct strbuf a_name = STRBUF_INIT, b_name = STRBUF_INIT;
@@ -865,8 +879,6 @@ static void emit_rewrite_diff(const char *name_a,
 
 	name_a += (*name_a == '/');
 	name_b += (*name_b == '/');
-	name_a_tab = strchr(name_a, ' ') ? "\t" : "";
-	name_b_tab = strchr(name_b, ' ') ? "\t" : "";
 
 	strbuf_reset(&a_name);
 	strbuf_reset(&b_name);
@@ -893,11 +905,13 @@ static void emit_rewrite_diff(const char *name_a,
 
 	lc_a = count_lines(data_one, size_one);
 	lc_b = count_lines(data_two, size_two);
-	fprintf(o->file,
-		"%s%s--- %s%s%s\n%s%s+++ %s%s%s\n%s%s@@ -",
-		line_prefix, metainfo, a_name.buf, name_a_tab, reset,
-		line_prefix, metainfo, b_name.buf, name_b_tab, reset,
-		line_prefix, fraginfo);
+
+	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_MINUS,
+			 a_name.buf, a_name.len, 0);
+	emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_PLUS,
+			 b_name.buf, b_name.len, 0);
+
+	fprintf(o->file, "%s%s@@ -", line_prefix, fraginfo);
 	if (!o->irreversible_delete)
 		print_line_count(o->file, lc_a);
 	else
@@ -1365,10 +1379,8 @@ static void find_lno(const char *line, struct emit_callback *ecbdata)
 static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	struct emit_callback *ecbdata = priv;
-	const char *meta = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
-	const char *line_prefix = diff_line_prefix(o);
 
 	o->found_changes = 1;
 
@@ -1379,15 +1391,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 
 	if (ecbdata->label_path[0]) {
-		const char *name_a_tab, *name_b_tab;
-
-		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
-		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
-
-		fprintf(o->file, "%s%s--- %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
-		fprintf(o->file, "%s%s+++ %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
+		emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_MINUS,
+				 ecbdata->label_path[0],
+				 strlen(ecbdata->label_path[0]), 0);
+		emit_diff_symbol(o, DIFF_SYMBOL_FILEPAIR_PLUS,
+				 ecbdata->label_path[1],
+				 strlen(ecbdata->label_path[1]), 0);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
-- 
2.13.0.31.g9b732c453e

