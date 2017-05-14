Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68B1220188
	for <e@80x24.org>; Sun, 14 May 2017 04:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbdENEBz (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:55 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33526 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbdENEBv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:51 -0400
Received: by mail-pf0-f171.google.com with SMTP id e193so47225468pfh.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U/4h9/qw1psJnCS7TwnXR3sFecX7eLwZcBOijRxJnLE=;
        b=KjIz5hMfA6VYCRhwWFY0cSXMbRK4phXwn3VoZLMon0w4vOhIHoC4jJNFdB5y/8Xygm
         xoAk/WjF/v4ld6oh/W30MrEsId7WSw2seaPVaZ7EntPoo9LREQWBSFfCLkKJen+qfEJZ
         eHFd6oNy2GWZBy/Mfo6xu5ThdiGDREf5Ig8ocL3tacyUf/Za6xfNmI8Lbnd/Nja6YK/z
         6rZIF2EpHF0bI6EarbOsakC3zdkWLrQ1q77xsXegFJHPOHaor3yX00f6zWbwlx6S7J18
         lzOjvbyKS8lG2nAu6LJ6PnBidzgEyPVAeqd4Ij/fOHHpMZEmjQwYmZ1gseNhKawt5MlO
         1tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U/4h9/qw1psJnCS7TwnXR3sFecX7eLwZcBOijRxJnLE=;
        b=hKYNOBxt1kOHtOD9FTszsFDps+Na8vHclR2Wy3jnju43x0rgw9XzdXqNONUfsdB63O
         Ttgs4ge5UN5+FhWETxa5idz2t5lSqaYxGSSUrq2A60NFVu4BQGWZhenZroHyD3MIcwXM
         EOGHpkVBtAtyfUMsy4K0xoaHux6p9YjhbVfvNdr5c7DyvGQw4x5EbcDp7c/JvIvYZclY
         aO2Uyy01yfu/hQk/YUeBkqz+13VvG8ffxYQevSB0bagkrI2CYCSHvYbwSpLuKOVkXtqn
         V/sgUR02nB+lNT+ouTf63gOT4vssIhZ5bXVvmS1gQqS0DZjp1XTLALgAyN8JxtO5yJOM
         skhw==
X-Gm-Message-State: AODbwcCYLrMTEv0ht62NISSz37OHDQi/oj+lEdRw9L4FSfyRNF3Sg8Gw
        EHRQuof6kuSCAme5
X-Received: by 10.84.172.1 with SMTP id m1mr15906335plb.84.1494734505220;
        Sat, 13 May 2017 21:01:45 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id 194sm10533279pgf.62.2017.05.13.21.01.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 14/19] diff.c: convert word diffing to use emit_line_*
Date:   Sat, 13 May 2017 21:01:12 -0700
Message-Id: <20170514040117.25865-15-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
In-Reply-To: <20170514040117.25865-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
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
---
 diff.c | 56 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/diff.c b/diff.c
index 91dc045a45..07041a35ad 100644
--- a/diff.c
+++ b/diff.c
@@ -886,37 +886,38 @@ struct diff_words_data {
 	struct diff_words_style *style;
 };
 
-static int fn_out_diff_words_write_helper(FILE *fp,
+static int fn_out_diff_words_write_helper(struct diff_options *o,
 					  struct diff_words_style_elem *st_el,
 					  const char *newline,
 					  size_t count, const char *buf,
 					  const char *line_prefix)
 {
-	int print = 0;
+	struct strbuf sb = STRBUF_INIT;
 
 	while (count) {
 		char *p = memchr(buf, '\n', count);
-		if (print)
-			fputs(line_prefix, fp);
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
+			if (st_el->color)
+				strbuf_addstr(&sb, st_el->color);
+			strbuf_addstr(&sb, st_el->prefix);
+			strbuf_add(&sb, buf, p ? p - buf : count);
+			strbuf_addstr(&sb, st_el->suffix);
+			if (st_el->color && *st_el->color)
+			    strbuf_addstr(&sb, GIT_COLOR_RESET);
 		}
 		if (!p)
-			return 0;
-		if (fputs(newline, fp) < 0)
-			return -1;
+			goto out;
+		strbuf_addstr(&sb, newline);
+		emit_line(o, NULL, NULL, sb.buf, sb.len);
+		strbuf_reset(&sb);
 		count -= p + 1 - buf;
 		buf = p + 1;
-		print = 1;
 	}
+out:
+	if (sb.len)
+		emit_line(o, NULL, NULL, sb.buf, sb.len);
+	strbuf_release(&sb);
 	return 0;
 }
 
@@ -994,25 +995,25 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	} else
 		plus_begin = plus_end = diff_words->plus.orig[plus_first].end;
 
-	if (color_words_output_graph_prefix(diff_words)) {
-		fputs(line_prefix, diff_words->opt->file);
-	}
+	if (color_words_output_graph_prefix(diff_words))
+		emit_line(diff_words->opt, NULL, NULL, "", 0);
+
 	if (diff_words->current_plus != plus_begin) {
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words->opt,
 				&style->ctx, style->newline,
 				plus_begin - diff_words->current_plus,
 				diff_words->current_plus, line_prefix);
 		if (*(plus_begin - 1) == '\n')
-			fputs(line_prefix, diff_words->opt->file);
+			emit_line(diff_words->opt, NULL, NULL, "", 0);
 	}
 	if (minus_begin != minus_end) {
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words->opt,
 				&style->old, style->newline,
 				minus_end - minus_begin, minus_begin,
 				line_prefix);
 	}
 	if (plus_begin != plus_end) {
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words->opt,
 				&style->new, style->newline,
 				plus_end - plus_begin, plus_begin,
 				line_prefix);
@@ -1109,8 +1110,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	/* special case: only removal */
 	if (!diff_words->plus.text.size) {
-		fputs(line_prefix, diff_words->opt->file);
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->old, style->newline,
 			diff_words->minus.text.size,
 			diff_words->minus.text.ptr, line_prefix);
@@ -1136,8 +1136,8 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
 			diff_words->plus.text.size) {
 		if (color_words_output_graph_prefix(diff_words))
-			fputs(line_prefix, diff_words->opt->file);
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+			emit_line(diff_words->opt, NULL, NULL, "", 0);
+		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->ctx, style->newline,
 			diff_words->plus.text.ptr + diff_words->plus.text.size
 			- diff_words->current_plus, diff_words->current_plus,
-- 
2.13.0.18.g183880de0a

