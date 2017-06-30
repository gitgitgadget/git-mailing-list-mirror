Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11191201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbdF3Uy1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:54:27 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34015 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752868AbdF3UxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:25 -0400
Received: by mail-pg0-f48.google.com with SMTP id t186so69044152pgb.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LtOa7q4xLBPQlEN1skoBhgc/L5zUz2UJlIyQpzN0cTc=;
        b=RhXrcUixaLkB1EK9q30YKviqu1Pqy/hREU9CpqBhNwRWtWnhPFpZyjOLCZu2HGjVCp
         FleCxXPeIBGDslOzqxaX2rrvMYgojMFjv+XEMvsVfsNzSobNgN8eY7K1CthGggSLmUMV
         tSiZIqXN/gY+Vmk5UioSSd/b0elA+xNiagTP4DeLzyFGe05NT/bA1FRI0jyokeFZOMgx
         0Yy2IvwFHws/ZvxheboWlmJMN+U8VgpSD439wAvsf5ZXSQo6ns9i6WJwiaBynFVatZHu
         WwUxtfxkJdUe6ChH8jIWK1vnOn892/xwTE5x9QxqxZcPT33ZD9pKV4LpqELVUe3SAwU3
         3QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LtOa7q4xLBPQlEN1skoBhgc/L5zUz2UJlIyQpzN0cTc=;
        b=MHrOigTGjyG0pnZmT6FMdjhX4FySDZXlve7t0w4kvace2FT1F3aItgbDmNR9vm5QPo
         FT21/wJkfKJRRI0MMZS41CkBZ4nLWQu0qLBWj71jnho21X7GVKWf9ks2Q28iJM/EYJZ+
         Pf6I2FKvsXtDKJ/Z2x1MuCQTBlfOTZgjFWL4r9LtO6MbONiaaZIx0t3nI0yG+GhNigz3
         VaZvkCUBhxEg6gJuUXfBv21FZU7cRTFdzTz0xf7cYxT8p/pmWMpXe5LCltvLOgGm+l6H
         RyGRLKr0l/AG5aXmzHxB5UfbYx8JI8Ce0D/aqEXYZ23NW3wo9PaPhig1WFUrjdHVBKpa
         W2BA==
X-Gm-Message-State: AKS2vOySNkx+lnP/UHT655nEo2IEYR1NITWO4iYF/4DP7TLPLGRaJ6mB
        S5jhzj75wEuIoZ/O
X-Received: by 10.98.62.70 with SMTP id l67mr24715722pfa.114.1498855999706;
        Fri, 30 Jun 2017 13:53:19 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id l4sm17584641pgr.21.2017.06.30.13.53.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:19 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 04/25] diff.c: introduce emit_diff_symbol
Date:   Fri, 30 Jun 2017 13:52:49 -0700
Message-Id: <20170630205310.7380-5-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we want to buffer all output before emitting it as a
new feature ("markup moved lines") conceptually cannot be implemented
in a single pass over the output.

There are different approaches to buffer all output such as:
* Buffering on the char level, i.e. we'd have a char[] which would
  grow at approximately 80 characters a line. This would keep the
  output completely unstructured, but might be very easy to implement,
  such as redirecting all output to a temporary file and working off
  that. The later passes over the buffer are quite complicated though,
  because we have to parse back any output and then decide if it should
  be modified.

* Buffer on a line level. As the output is mostly line oriented already,
  this would make sense, but it still is a bit awkward as we'd have to
  make sense of it again by looking at the first characters of a line
  to decide what part of a diff a line is.

* Buffer semantically. Imagine there is a formal grammar for the diff
  output and we'd keep the symbols of this grammar around. This keeps
  the highest level of structure in the buffered data, such that the
  actual memory requirements are less than say the first option. Instead
  of buffering the characters of the line, we'll buffer what we intend
  to do plus additional information for the specifics. An output of

    diff --git a/new.txt b/new.txt
    index fa69b07..412428c 100644
    Binary files a/new.txt and b/new.txt differ

  could be buffered as
     DIFF_SYMBOL_DIFF_START + new.txt
     DIFF_SYMBOL_INDEX_MODE + fa69b07 412428c "non-executable" flag
     DIFF_SYMBOL_BINARY_FILES + new.txt

This and the following patches introduce the third option of buffering
by first moving any output to emit_diff_symbol, and then introducing the
buffering in this function.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 77ef56a6e4..4637368d59 100644
--- a/diff.c
+++ b/diff.c
@@ -560,6 +560,24 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 	emit_line_0(o, set, reset, line[0], line+1, len-1);
 }
 
+enum diff_symbol {
+	DIFF_SYMBOL_SEPARATOR
+};
+
+static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
+			     const char *line, int len)
+{
+	switch (s) {
+	case DIFF_SYMBOL_SEPARATOR:
+		fprintf(o->file, "%s%c",
+			diff_line_prefix(o),
+			o->line_termination);
+		break;
+	default:
+		die("BUG: unknown diff symbol");
+	}
+}
+
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
 {
 	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
@@ -4828,9 +4846,7 @@ void diff_flush(struct diff_options *options)
 
 	if (output_format & DIFF_FORMAT_PATCH) {
 		if (separator) {
-			fprintf(options->file, "%s%c",
-				diff_line_prefix(options),
-				options->line_termination);
+			emit_diff_symbol(options, DIFF_SYMBOL_SEPARATOR, NULL, 0);
 			if (options->stat_sep) {
 				/* attach patch instead of inline */
 				fputs(options->stat_sep, options->file);
-- 
2.13.0.31.g9b732c453e

