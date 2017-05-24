Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6293120209
	for <e@80x24.org>; Wed, 24 May 2017 21:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163618AbdEXVlc (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 17:41:32 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34608 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164164AbdEXVlB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 17:41:01 -0400
Received: by mail-pf0-f178.google.com with SMTP id 9so147337523pfj.1
        for <git@vger.kernel.org>; Wed, 24 May 2017 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XeXOBs/zWHwhwEF3I4CQJNL8/ylne6/zxvsJE7tmkeg=;
        b=YxlkFny+Bi5ZwuEWSWBoq75Ky92nNXYrULHwy9yE5U4jxK/XxmwXBXtGYu/cyna0A1
         wZE4Td3cOqIJ7omTm9VKZvVP/X1xS95YXYEkm2dvIN9abV/bNVW/os35d8bLFMTfn5zK
         xDymRGsmxRDnTjStUtHJ05lL0u1I68JOjZoTfdrmZa5cTQb4XxPbIA+3KwxTQTO6LinG
         UwASUpZBDFOd+H8bYJps0BOJa7yf4+YFjCDC477e65p+GbjscX2yX9eprCVZUY1ejsy9
         e6mUJb9kBbdCmPO/nRAftiTQnZshlhTYM+zaB8W0N+qTYemAXyRm4Lrld0xxCibid6dN
         PviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XeXOBs/zWHwhwEF3I4CQJNL8/ylne6/zxvsJE7tmkeg=;
        b=WxP3WBLXT7wg1ZflTWWeUO2dYs6eA5fTS5qKsUNCFVUKFAz3YPpM61occS8dbLIsLN
         mBnqZn89b0hl87ae6yeuat+H5qQc9zB+fEm154MFU+fGWzgN70MlmXEZHjldTxLmwxIW
         1K0QiyOVqwCyMuQh17yHWsJ9lK3W1niyNlBRX1x9P4PQYBJJ9F048pKN4e/Z1lsHtFT7
         cj1D/8vUjWFIlr7UieLYr6LZ6vxs4UpJz7vC7DQAB/ZTKVrtYWAYcn+UGt5+07v7x9Ci
         kEpHkG3JHzATCnTiQf/QuJ0igdMoOgAPF744KwHgRndUM8R/SX23Gr3ifHpo+aJ33Trk
         hgLw==
X-Gm-Message-State: AODbwcA2U9N+EYbKfuyvsvcDryxV2b9I+hA0djUnB1n+RYjW43yfWvOf
        nBco0mO56nDnUKzo
X-Received: by 10.84.143.36 with SMTP id 33mr44922698ply.45.1495662055816;
        Wed, 24 May 2017 14:40:55 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:70df:e59:d409:fbba])
        by smtp.gmail.com with ESMTPSA id r69sm9292154pfi.33.2017.05.24.14.40.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 14:40:55 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 12/17] diff.c: convert word diffing to use emit_line_*
Date:   Wed, 24 May 2017 14:40:31 -0700
Message-Id: <20170524214036.29623-13-sbeller@google.com>
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
function is emit_line_0.

This covers all code related to diffing words.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 73 +++++++++++++++++++++++++++++-------------------------------------
 1 file changed, 32 insertions(+), 41 deletions(-)

diff --git a/diff.c b/diff.c
index a76abf5f69..8317824963 100644
--- a/diff.c
+++ b/diff.c
@@ -897,37 +897,42 @@ struct diff_words_data {
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
+			emit_line(o, NULL, NULL, 1, 0, "", 0);
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
+			strbuf_addstr(&sb, st_el->prefix);
+			strbuf_add(&sb, buf, p ? p - buf : count);
+			strbuf_addstr(&sb, st_el->suffix);
+			emit_line(o, st_el->color, reset,
+				  0, 0, sb.buf, sb.len);
+			strbuf_reset(&sb);
 		}
 		if (!p)
-			return 0;
-		if (fputs(newline, fp) < 0)
-			return -1;
+			goto out;
+
+		strbuf_addstr(&sb, newline);
+		emit_line(o, NULL, NULL, 0, 0, sb.buf, sb.len);
+		strbuf_reset(&sb);
 		count -= p + 1 - buf;
 		buf = p + 1;
 		print = 1;
 	}
+
+out:
+	strbuf_release(&sb);
 	return 0;
 }
 
@@ -981,14 +986,12 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	int minus_first, minus_len, plus_first, plus_len;
 	const char *minus_begin, *minus_end, *plus_begin, *plus_end;
 	struct diff_options *opt = diff_words->opt;
-	const char *line_prefix;
 
 	if (line[0] != '@' || parse_hunk_header(line, len,
 			&minus_first, &minus_len, &plus_first, &plus_len))
 		return;
 
 	assert(opt);
-	line_prefix = diff_line_prefix(opt);
 
 	/* POSIX requires that first be decremented by one if len == 0... */
 	if (minus_len) {
@@ -1005,28 +1008,21 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	} else
 		plus_begin = plus_end = diff_words->plus.orig[plus_first].end;
 
-	if (color_words_output_graph_prefix(diff_words)) {
-		fputs(line_prefix, diff_words->opt->file);
-	}
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
@@ -1113,18 +1109,14 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	struct diff_words_style *style = diff_words->style;
 
 	struct diff_options *opt = diff_words->opt;
-	const char *line_prefix;
-
 	assert(opt);
-	line_prefix = diff_line_prefix(opt);
 
 	/* special case: only removal */
 	if (!diff_words->plus.text.size) {
-		fputs(line_prefix, diff_words->opt->file);
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->old, style->newline,
 			diff_words->minus.text.size,
-			diff_words->minus.text.ptr, line_prefix);
+			diff_words->minus.text.ptr);
 		diff_words->minus.text.size = 0;
 		return;
 	}
@@ -1147,12 +1139,11 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
 			diff_words->plus.text.size) {
 		if (color_words_output_graph_prefix(diff_words))
-			fputs(line_prefix, diff_words->opt->file);
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+			emit_line(diff_words->opt, NULL, NULL, 1, 0, "", 0);
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
2.13.0.18.g7d86cc8ba0

