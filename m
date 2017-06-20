Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3385B1FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbdFTCs5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:57 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35920 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFTCsr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:47 -0400
Received: by mail-pf0-f179.google.com with SMTP id x63so62653600pff.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VUEBmzIZx82F7BX4G1ztdfr8kktt3g4OEqjYUBFghrg=;
        b=QZI1xPqNqmeUyP4GTy39ckf/SIncGYJ2+GZ+cbLw4EOkKXYMoZqh01J3nm1mnuzxcV
         8umGR8wQXFz3dNGcez1Erc5TiObnb2Fiad1dfBlK6fIZe2pLx2XMP9N/cTBWZalxIqjS
         VVlocuWRFb8hFpNOMflogdpmrtIgwQLVeAQuxY8r5PClr0trSkRsR08HsjTisMvD0ms6
         OpelPwgiLd32/zNxia55ApmeDeytVIh+o1GkcumZ1qu9J63tj7/YukO7rCzTKIrmNzsR
         wj5aiXkm1hTR+e+XUnr9SjcS0EiVP9PQEY7bPCQQOVaLcgbVsJtG5NPRLL/o4ne9AdjL
         o3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VUEBmzIZx82F7BX4G1ztdfr8kktt3g4OEqjYUBFghrg=;
        b=Z9cugAxT1eg/ZidlbvFZ821BHkTy82lB+edmoiIxVIv+mvne+rjdOj49z13ZolyBxB
         X0RxWG3RXJtiuQ4RWGL1M51AHn0GqgCj0NN17jveV6mluPlXD5gWiaSu4zia6yeu1hyV
         xPxm+E43qikli2ikrkBwgZVvlfZNuWQ5Hw29T9m+R/1Z1DjTLANt5uZeUMEiJ53ZinIM
         1Y4k8X8/lzZ3R5BRBv7GTAlxRsIrOO3uQsWXH+wKLCfvK2429bNa6nZZXTj16PS3TYZJ
         fxbXVBNfesjDpBLGs4PKHZWaHC8wve6J+r+v2VBYphVqqn56tKhBYpx6g20vikkzOzNJ
         cX8A==
X-Gm-Message-State: AKS2vOzMzc5G/14nGczNumP499n0oINuA07w2Y9KqjdKOpY34TavUUkB
        6n3l0CohF5jmzpqR
X-Received: by 10.84.131.71 with SMTP id 65mr5866496pld.35.1497926926651;
        Mon, 19 Jun 2017 19:48:46 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id 71sm10937149pge.45.2017.06.19.19.48.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:45 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 18/26] diff.c: convert word diffing to use emit_diff_symbol
Date:   Mon, 19 Jun 2017 19:48:08 -0700
Message-Id: <20170620024816.20021-19-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The word diffing is not line oriented and would need some serious
effort to be transformed into a line oriented approach, so
just go with a symbol DIFF_SYMBOL_WORD_DIFF that is a partial line.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 79 ++++++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/diff.c b/diff.c
index 0a5ff2500f..5b46baa12a 100644
--- a/diff.c
+++ b/diff.c
@@ -590,6 +590,7 @@ enum diff_symbol {
 	DIFF_SYMBOL_STATS_SUMMARY_ABBREV,
 	DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES,
 	DIFF_SYMBOL_STATS_LINE,
+	DIFF_SYMBOL_WORD_DIFF,
 };
 /*
  * Flags for content lines:
@@ -772,6 +773,9 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES:
 		emit_line(o, "", "", line, len);
 		break;
+	case DIFF_SYMBOL_WORD_DIFF:
+		fprintf(o->file, "%.*s", len, line);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -1100,37 +1104,49 @@ struct diff_words_data {
 	struct diff_words_style *style;
 };
 
-static int fn_out_diff_words_write_helper(FILE *fp,
+static int fn_out_diff_words_write_helper(struct diff_options *o,
 					  struct diff_words_style_elem *st_el,
 					  const char *newline,
-					  size_t count, const char *buf,
-					  const char *line_prefix)
+					  size_t count, const char *buf)
 {
 	int print = 0;
+	struct strbuf sb = STRBUF_INIT;
 
 	while (count) {
 		char *p = memchr(buf, '\n', count);
 		if (print)
-			fputs(line_prefix, fp);
+			strbuf_addstr(&sb, diff_line_prefix(o));
+
 		if (p != buf) {
-			if (st_el->color && fputs(st_el->color, fp) < 0)
-				return -1;
-			if (fputs(st_el->prefix, fp) < 0 ||
-			    fwrite(buf, p ? p - buf : count, 1, fp) != 1 ||
-			    fputs(st_el->suffix, fp) < 0)
-				return -1;
-			if (st_el->color && *st_el->color
-			    && fputs(GIT_COLOR_RESET, fp) < 0)
-				return -1;
+			const char *reset = st_el->color && *st_el->color ?
+					    GIT_COLOR_RESET : NULL;
+			if (st_el->color && *st_el->color)
+				strbuf_addstr(&sb, st_el->color);
+			strbuf_addstr(&sb, st_el->prefix);
+			strbuf_add(&sb, buf, p ? p - buf : count);
+			strbuf_addstr(&sb, st_el->suffix);
+			if (reset)
+				strbuf_addstr(&sb, reset);
 		}
 		if (!p)
-			return 0;
-		if (fputs(newline, fp) < 0)
-			return -1;
+			goto out;
+
+		strbuf_addstr(&sb, newline);
 		count -= p + 1 - buf;
 		buf = p + 1;
 		print = 1;
+		if (count) {
+			emit_diff_symbol(o, DIFF_SYMBOL_WORD_DIFF,
+					 sb.buf, sb.len, 0);
+			strbuf_reset(&sb);
+		}
 	}
+
+out:
+	if (sb.len)
+		emit_diff_symbol(o, DIFF_SYMBOL_WORD_DIFF,
+				 sb.buf, sb.len, 0);
+	strbuf_release(&sb);
 	return 0;
 }
 
@@ -1212,24 +1228,20 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 		fputs(line_prefix, diff_words->opt->file);
 	}
 	if (diff_words->current_plus != plus_begin) {
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words->opt,
 				&style->ctx, style->newline,
 				plus_begin - diff_words->current_plus,
-				diff_words->current_plus, line_prefix);
-		if (*(plus_begin - 1) == '\n')
-			fputs(line_prefix, diff_words->opt->file);
+				diff_words->current_plus);
 	}
 	if (minus_begin != minus_end) {
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words->opt,
 				&style->old, style->newline,
-				minus_end - minus_begin, minus_begin,
-				line_prefix);
+				minus_end - minus_begin, minus_begin);
 	}
 	if (plus_begin != plus_end) {
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words->opt,
 				&style->new, style->newline,
-				plus_end - plus_begin, plus_begin,
-				line_prefix);
+				plus_end - plus_begin, plus_begin);
 	}
 
 	diff_words->current_plus = plus_end;
@@ -1323,11 +1335,12 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	/* special case: only removal */
 	if (!diff_words->plus.text.size) {
-		fputs(line_prefix, diff_words->opt->file);
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		emit_diff_symbol(diff_words->opt, DIFF_SYMBOL_WORD_DIFF,
+				 line_prefix, strlen(line_prefix), 0);
+		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->old, style->newline,
 			diff_words->minus.text.size,
-			diff_words->minus.text.ptr, line_prefix);
+			diff_words->minus.text.ptr);
 		diff_words->minus.text.size = 0;
 		return;
 	}
@@ -1350,12 +1363,12 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
 			diff_words->plus.text.size) {
 		if (color_words_output_graph_prefix(diff_words))
-			fputs(line_prefix, diff_words->opt->file);
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+			emit_diff_symbol(diff_words->opt, DIFF_SYMBOL_WORD_DIFF,
+					 line_prefix, strlen(line_prefix), 0);
+		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->ctx, style->newline,
 			diff_words->plus.text.ptr + diff_words->plus.text.size
-			- diff_words->current_plus, diff_words->current_plus,
-			line_prefix);
+			- diff_words->current_plus, diff_words->current_plus);
 	}
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
 }
-- 
2.12.2.575.gb14f27f917

