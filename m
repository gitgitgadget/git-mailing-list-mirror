Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF976207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753416AbcIMEqq (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:46 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36056 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752917AbcIMEqm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:42 -0400
Received: by mail-pf0-f169.google.com with SMTP id 128so59455964pfb.3
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DgqnwcsyoufC3pWWikCJUDKHHVVzpC8pbqV51rUNqRQ=;
        b=ezP95E3eZsWJVmwI/gzZFst/IRpU4SPwcZkLuHOgkik3RaiHFrg4uhlXYQvOeLYP9k
         Kx1+xmm8Cn0W/CTIo+XfPKjodw0X2KSmJFrI8fl/OCKmXJmCcfsxTh3W5kpx0VK5m7sR
         DBSz2m7TOhIzaiJMavKkueCkSCZqsftZWlV9LDiE+gvG67W85uSyDqV3FQjIQBe3xK5W
         PJ1+PbFx6nptU3MOsqz877/qncVJJFnMLe/aBevbLIjWXdzzWwkLbQd//PE0OPzmKmcn
         YEWpWNhBi8sj1jgep8Z8lol7QeSI9he/oA3KYbeD8we+++NqzKC5FzdTFM/bC4jePeYm
         dcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DgqnwcsyoufC3pWWikCJUDKHHVVzpC8pbqV51rUNqRQ=;
        b=TfMBoiDsa5bFp2bgbetRilQLMkxc0hCzimlKk8LH1f5GgRHhLDADZq2J2QMTUsFiIY
         1QAlaP1/KjO5MeaGuabdDtgb1MwoAXobAucn2Qa/qvJpZL78i6KxCfBkc+USiJt56pYp
         P61uRQa1BxDDuNvccEZHmqDBJSTTn/NYDi5GqYPptoznF1ZN9Q2qiONCf7ti0PuodMW9
         AzfUlDIDiTswmCJcxbSlDhdEyhd1vHL8XBQtfxVo1GHU39T1p4lCT6Hm2F5RKq2rpGKr
         Jg2uh4ms4GF4aAkJClY7jc7bgp5JAUQMH9yqWOxDYt1bQ3ZAroeotw7wty0U2sXIN/Ol
         +C6Q==
X-Gm-Message-State: AE9vXwNh3hDoJ8DMXlePUDMiTJvpUBPBk7Etr+qXEsVSJy0VygpC/vssLB2s2snBG4Z1Qjd8
X-Received: by 10.98.130.137 with SMTP id w131mr40265360pfd.5.1473742001028;
        Mon, 12 Sep 2016 21:46:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id h66sm27796034pfc.47.2016.09.12.21.46.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 13/17] diff.c: convert word diffing to use emit_line_*
Date:   Mon, 12 Sep 2016 21:46:09 -0700
Message-Id: <20160913044613.1037-14-sbeller@google.com>
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

This covers all code related to diffing words.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 56 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/diff.c b/diff.c
index 00a5a4e..3940f79 100644
--- a/diff.c
+++ b/diff.c
@@ -828,37 +828,38 @@ struct diff_words_data {
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
+		emit_line_0(o, 0, 0, 0, sb.buf, sb.len);
+		strbuf_reset(&sb);
 		count -= p + 1 - buf;
 		buf = p + 1;
-		print = 1;
 	}
+out:
+	if (sb.len)
+		emit_line_0(o, 0, 0, 0, sb.buf, sb.len);
+	strbuf_release(&sb);
 	return 0;
 }
 
@@ -936,25 +937,25 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	} else
 		plus_begin = plus_end = diff_words->plus.orig[plus_first].end;
 
-	if (color_words_output_graph_prefix(diff_words)) {
-		fputs(line_prefix, diff_words->opt->file);
-	}
+	if (color_words_output_graph_prefix(diff_words))
+		emit_line_0(diff_words->opt, 0, 0, 0, "", 0);
+
 	if (diff_words->current_plus != plus_begin) {
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words->opt,
 				&style->ctx, style->newline,
 				plus_begin - diff_words->current_plus,
 				diff_words->current_plus, line_prefix);
 		if (*(plus_begin - 1) == '\n')
-			fputs(line_prefix, diff_words->opt->file);
+			emit_line_0(diff_words->opt, 0, 0, 0, "", 0);
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
@@ -1050,8 +1051,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	/* special case: only removal */
 	if (!diff_words->plus.text.size) {
-		fputs(line_prefix, diff_words->opt->file);
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->old, style->newline,
 			diff_words->minus.text.size,
 			diff_words->minus.text.ptr, line_prefix);
@@ -1077,8 +1077,8 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
 			diff_words->plus.text.size) {
 		if (color_words_output_graph_prefix(diff_words))
-			fputs(line_prefix, diff_words->opt->file);
-		fn_out_diff_words_write_helper(diff_words->opt->file,
+			emit_line_0(diff_words->opt, 0, 0, 0, "", 0);
+		fn_out_diff_words_write_helper(diff_words->opt,
 			&style->ctx, style->newline,
 			diff_words->plus.text.ptr + diff_words->plus.text.size
 			- diff_words->current_plus, diff_words->current_plus,
-- 
2.10.0.21.g1da280f.dirty

