Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D7C920985
	for <e@80x24.org>; Sun, 11 Sep 2016 05:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755515AbcIKFmq (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 01:42:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35149 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755403AbcIKFmm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 01:42:42 -0400
Received: by mail-pf0-f194.google.com with SMTP id i75so1335008pfa.2
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 22:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e1M9eeeFmu0B/i+1mkFK2Xn07cJYt/xo5YZAAztuPOs=;
        b=o2hB26VSz0ZtBkG0RjHTPeBzGmkjxTKEZaNvcKweKO1PeA7fCyasWssMdjwf5sImZt
         Bf6VvXrrkgwNAyzhzuXjg0I5DNlYq4Ds5/M6ADLJXkn31PsxwkNJ7w4fjfliCM4HO73L
         JQ/g1X/j3WjIVtnalpXqTW5/Zf0icNjrRhomQB71kPp8/OK2PmKfEuWvPkz467iSc0kP
         iWVOf3q35vUzBw6QUnL3mC7VeMzQmFkDhGASD+MuNyJJhIdNWDNALPPIw+gopDqcfvhS
         m2UddiXpxnIsBF9EvvMBH3o1YpxMaTINpKqRnrNvKQ1b4cuCogVLtVvZWPj0OtUVMhXX
         /6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e1M9eeeFmu0B/i+1mkFK2Xn07cJYt/xo5YZAAztuPOs=;
        b=NFav7mJpt4KWgBIISjpW8vAhY1xO5T4aMRV1+Sr1eOtz9IvhY9g6wALsMTruDuUBxT
         ol7C/h7LrHLQ2+bvFgejaByF1Y/J8/NcIiPBcDSPvz1kSAXUdk89jBqi0PG01H42GBYa
         rsJU0gXbI0O6PlblLo1JtzYoaW5PXTWxfbpmluUYBksDifJYY8Gx8IQrmTxsO6p4gwZ9
         NqmbH7r1EjzAzkxF1TjNjOhJJyHVliAuFEb+LoQawT11yDvEApAj6D6Ii509Wt1c9kSP
         f1qtaqEUUrVNnN+G9PuO/DFbsVyH5VcYiyEUDIqL5HivqgAwBcN3ZxX6Cy48R+4fyn4x
         XR7Q==
X-Gm-Message-State: AE9vXwMP3wLbs62MiAl8Z96lgeEL9WAPTFFRgsmB4HMMZZKz3QM+XRe9yw4BK5FL9vNm3Q==
X-Received: by 10.98.35.7 with SMTP id j7mr21331201pfj.39.1473572561741;
        Sat, 10 Sep 2016 22:42:41 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id s63sm15474547pfb.52.2016.09.10.22.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 22:42:40 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH 07/10] diff.c: convert fn_out_consume to use emit_line_*
Date:   Sat, 10 Sep 2016 22:42:07 -0700
Message-Id: <1473572530-25764-8-git-send-email-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

In the coming patches we want to eliminate writes that do not go
though emit_line_* as we later want to hook into the emit_line_*
functions to add a buffered output. To make the conversion easy,
add a function that takes a format string.

Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
---
 diff.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 2aefd0f..7dcef73 100644
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
 
@@ -1233,10 +1245,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
 		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
 
-		fprintf(o->file, "%s%s--- %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
-		fprintf(o->file, "%s%s+++ %s%s%s\n",
-			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
+		emit_line_fmt(o, meta, reset, "--- %s%s\n",
+			      ecbdata->label_path[0], name_a_tab);
+
+		emit_line_fmt(o, meta, reset, "+++ %s%s\n",
+			      ecbdata->label_path[1], name_b_tab);
+
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
-- 
2.7.4

