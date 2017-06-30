Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACCE7201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbdF3UyR (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:54:17 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34039 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752940AbdF3Ux2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:28 -0400
Received: by mail-pg0-f43.google.com with SMTP id t186so69045406pgb.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O2w77kzES0r2Dh8U1J8do2+uyPpqXAd63LY55cj4cmQ=;
        b=t6dn8IU5SOFpA865KNxGhBfZmBK1cBe2PG/Y5O6q9nIwNo0OtFlYDt/6J+NMa955Iv
         e0sGoi2uFmo8lu1+0ihcbIafOZSEDhQ1Zsn506Islx7OENzDG2KJbDrRVAUhle2vyOyz
         TaFD5BxFEu+ZF4CVV8NiiizmO9erQUT88I2sYYl/4pz9/Ws8JGXuL1AY58Tz3sFhdUuW
         ECuCpEjAl4avBhGJQ028f6Za5rBe0dKpFRqOe2SBfHzEUK+jkc0qUWN2iez0FcEjjPQR
         CnsuWsFupTTz3ajSNtoXzTObtS+zAtSzJivNYzM5tXcBgr2Kiz8tNZE/BncXUiFlamnX
         2HdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O2w77kzES0r2Dh8U1J8do2+uyPpqXAd63LY55cj4cmQ=;
        b=QfzQ78Nzl5SgM0IYq9AOytWcLRwG32zPiSV5/aw+BAQN/GUQrQZsbU6u87Nluy5Bp7
         nwlQIp/kEK3dSqNM6imRWcDQDe1UHVEKEPqEo5svK5QKp4xUxB4Lg6dxdTcPv2uX0FOr
         BuTFTjKrRpOH4+meS5ujZfgPUYmAqENqY0Ce3jP5INYOik4F8BYVNnZNuiTNUPXvk3Lx
         DMlffTZc6zII79WFCFhiPKNJhbwiY/UMc6ZS7YWZTdexfywBm/Yn/Qpl79Q3kUa5VTU3
         +d4EbPX1ChsJKRvgkJE8hp7uErKulYbw3fG89YamOhpP6/LC4Q5RCFyprPkzpXe2SXHu
         jFWQ==
X-Gm-Message-State: AKS2vOwcYxKi8FSwitGJmYmvzdai6CCDXNAuaQB/57i7/hijOeKerjcd
        87C6tVIYDHzseoGj
X-Received: by 10.98.87.195 with SMTP id i64mr24019245pfj.51.1498856007852;
        Fri, 30 Jun 2017 13:53:27 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id 188sm15019951pgc.49.2017.06.30.13.53.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:27 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 11/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_FILEPAIR_{PLUS, MINUS}
Date:   Fri, 30 Jun 2017 13:52:56 -0700
Message-Id: <20170630205310.7380-12-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
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

