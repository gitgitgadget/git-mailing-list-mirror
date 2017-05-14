Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5AE620188
	for <e@80x24.org>; Sun, 14 May 2017 04:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbdENEBp (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:45 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33512 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbdENEBl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:41 -0400
Received: by mail-pf0-f176.google.com with SMTP id e193so47224623pfh.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=079WdL2hkX+mDZ6mvu788kT/1UfnLrnOHfTN9lktRrw=;
        b=AhFY5e/REJoqamfKS/VBGZgXiUGbV3qbuwzUkC5koCmxIF5i09+7qvOE0+ApcanVnO
         iwke+RlaG01P/mrY35iOpNf6v9eXADeEVQnUMQEuCbOLEDPj1znUZ4x51XGE3fwyjbQs
         tKw2ubjx1XfEgfCm2k0ZOxzWAOP4G9809v0zfdpKHYKUdCJB1aEDL/TmNkEYzCBZrdUZ
         NrHcn5E0ZD7V5AaSt8/OvlutFRIuHPootGcFUJKWCopn6x0czFUEBBxsnEn3GZU2W2wv
         7XNJ6bL8HMD2rD0x0RKECjKGS0V50a50cb/Up1nFq4K21B+iBEe0tYO+3N+4DWsGxcW8
         Blug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=079WdL2hkX+mDZ6mvu788kT/1UfnLrnOHfTN9lktRrw=;
        b=nX313xhdKEtojpfyaxRx1AkXN/J2XTyb6ybQy+MkGYmqXuUUQOhtF71PzNRhmE3TOL
         8xjtV+B3M70Qx+465C4FdwV96YW4C3QpZ13gw1u7qi8bLQI+8/Z5tvA6B0kXF3Aq+u3J
         Jk2BJj84FsqESLBurgsqXoS/TIC5QWxj0KcF/2VM7mPPlhbDfr6dOtycJ4d1CsW0Ibko
         ajajIdk8IBVsch/oCoN6ALs9Z6E7ip1tkN5ft+atrHmXLFCEQZer4UFwjhb61d6Kgz65
         ZyW9iqfb5M/xsEVDGCok+k0zuX5/eeW+f5iZgABl5HYd2kA/axTOrNJCmEEJ8Ook8Upx
         xd9Q==
X-Gm-Message-State: AODbwcDAFiP8Xl4PuPOnH/V27muP/UoCqyuUfwzditJ8EyR7xe+1Qj7F
        iL9OiCaUPKvmDy2V
X-Received: by 10.99.158.82 with SMTP id r18mr12045936pgo.231.1494734495680;
        Sat, 13 May 2017 21:01:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id u78sm12691384pfa.47.2017.05.13.21.01.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/19] diff.c: convert fn_out_consume to use emit_line_*
Date:   Sat, 13 May 2017 21:01:05 -0700
Message-Id: <20170514040117.25865-8-sbeller@google.com>
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

This covers the parts of fn_out_consume.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index aef159a919..93343a9ccc 100644
--- a/diff.c
+++ b/diff.c
@@ -1289,7 +1289,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *context = diff_get_color(ecbdata->color_diff, DIFF_CONTEXT);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
-	const char *line_prefix = diff_line_prefix(o);
 
 	o->found_changes = 1;
 
@@ -1301,14 +1300,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 
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
+		emit_line_fmt(o, meta, reset, "--- %s%s\n",
+			      ecbdata->label_path[0], name_a_tab);
+		emit_line_fmt(o, meta, reset, "+++ %s%s\n",
+			      ecbdata->label_path[1], name_b_tab);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
@@ -1349,7 +1346,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
 			emit_line(o, context, reset, line, len);
-			fputs("~\n", o->file);
+			emit_line(o, NULL, NULL, "~\n", 2);
 		} else {
 			/*
 			 * Skip the prefix character, if any.  With
-- 
2.13.0.18.g183880de0a

