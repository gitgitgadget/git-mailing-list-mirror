Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECCF22082E
	for <e@80x24.org>; Fri, 23 Jun 2017 01:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754055AbdFWB3g (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:36 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35673 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbdFWB3e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:34 -0400
Received: by mail-pf0-f182.google.com with SMTP id c73so16587265pfk.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=37AJgChe2bt8ksP/rfHSoBxlLp8pvTaeKxBbDKfNfQY=;
        b=qKBxWLYGAjX8/DlEtpm0R22px68NeieWbSXlI5k5czwzMkYsTqemrK5zi3o6SRebIW
         FiXp3klHDlGAheQXgUyAzS02gWfnu/cGIIrjOSmxGD6NRJN23r8I0W6IJKjwSQAfe7QW
         mOTPV5IZPVsRB3ar1ywAEzS7F4KBiQ6gPrVap5sjk7S5T6APQeTR3+3hwqqwNsVC6/em
         APT3C27hFvUiZ6upZkisdKPKSncGSpSSfuYoVVeDswqm9qk9KHYKEkxZ1cprsmk9V+8s
         DL6L6PKttdu/kmJBMkqbWiYmdvdGLINMQURU8osaNveQlbC7ihXaOdeySfGVnbBABUoz
         ituw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=37AJgChe2bt8ksP/rfHSoBxlLp8pvTaeKxBbDKfNfQY=;
        b=LpYxRHgeXivHLws+Ej4elgioB0+/ggF0afyWCnLcv8bb8D69+JyasRc5eMT7ZzjPLk
         7z5jW4PPvB1vPJJKBbZoUjn+7KmfHVqCxredMFYgGDA8QzfW1n3I0EN7SqrZopAD/6BP
         VOXjH9xuf3SEKbgOhoqnfDuqHyuUsplFSDXj6xOeUK3ADenmBTUOaUrP4gj76qPhxm0B
         a3W3Hw1A5aNZrV7x1UP+W/R39bOqvS85ZCbfPKBTeKNXTEIE1n3EK+kUsepRxLAN1+M7
         ogJ971ES6qqNdN6I/kjWCMkp7mv13l92XjnBOxAgMTmBdKzUejnteFwGTQvUD/528tNf
         GyLQ==
X-Gm-Message-State: AKS2vOy49paiWiAlyvGYXsFhM7A4j7lmdgH30C8XHSYjv8sxrnmHKpZN
        TmPfPKwMZQlb6jGQ
X-Received: by 10.98.80.139 with SMTP id g11mr5715269pfj.146.1498181373653;
        Thu, 22 Jun 2017 18:29:33 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id t4sm6190446pfa.68.2017.06.22.18.29.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 04/25] diff.c: introduce emit_diff_symbol
Date:   Thu, 22 Jun 2017 18:28:58 -0700
Message-Id: <20170623012919.28693-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
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
---
 diff.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 2f9722b382..2257d44e2c 100644
--- a/diff.c
+++ b/diff.c
@@ -559,6 +559,24 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
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
@@ -4833,9 +4851,7 @@ void diff_flush(struct diff_options *options)
 
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
2.12.2.575.gb14f27f917

