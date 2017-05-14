Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD0320188
	for <e@80x24.org>; Sun, 14 May 2017 04:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbdENEBw (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:52 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33531 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751982AbdENEBu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:50 -0400
Received: by mail-pf0-f174.google.com with SMTP id e193so47225806pfh.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0R3BUBtBtvQV5WL9gI8Gdkg0cZKuREYbJ4byoPaZDI0=;
        b=OBiNNpqHEyVBVAaGfgrzGBnm9K0Zjrx2Z+DAKRehc3T2OXJgkqPMFKxIVKmNPLyGqU
         iqR2GmJhi13fQHpEulhSaYTrbFyh1rCGKd3eVkm5Ix+ffBY9wzUzmBcOjQVifiVk+CP8
         XFsYU3l1HomcdjERzY/DLmv+CIR9tW0mMtEF7JJwwVTkkb0nSQ4c7X1qjlePWHkRAtu7
         rUWtq2ILX+Ml1QZaVCVis8EGeypOXVRH8ugeuCo+w08qchNGr1MwnaDBdj3h8DyUNMWs
         FsrDFlHWZYr1nPeKWa11IwKRc+ZQTsX1zc9ukT0j3IHLTmYFC3c86cRX1Nckl29T91eL
         mpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0R3BUBtBtvQV5WL9gI8Gdkg0cZKuREYbJ4byoPaZDI0=;
        b=bYj5IPe59muJsoh4tPtvuTRDxZHwoLXQc2ChCLjCwI32SYJ0Zxtyt/paOIn+Z7mEc1
         oPDi/Z73HJNyzjLJ8d8AuG7mcUbwTp6cQVR02Rl91eN0Ee0TubYk1AuO8CXHv7DNwuYa
         ycVNjqomv7YAYWnDmdHa1gID/YqM3qcu7W/ETJ6V6EpO7yFX99NPjvkj2kL9KXQ8QEn4
         2WrQBA2Po4moysPY4YyIFWQmt0I7HjmZRjwL+rgvrvdI3cdcTdopXwrN9ig6wj2BeQCA
         oX5vrDGg/xRHlo/iZeJ1avDs8E+UBcssU0DVVamxHS7QuYSajj18js3ZYSOo8hQxLc1X
         jXsg==
X-Gm-Message-State: AODbwcAGW58FBIcs4kOHiJ4CAh7z2GhgBMWm5JFISvHR/BR7V9NS8gnw
        NEumzCX9Jor9glyB
X-Received: by 10.84.136.70 with SMTP id 64mr16296810plk.82.1494734509197;
        Sat, 13 May 2017 21:01:49 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id t187sm14517367pfb.116.2017.05.13.21.01.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:48 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 17/19] diff.c: factor out emit_line_ws for coloring whitespaces
Date:   Sat, 13 May 2017 21:01:15 -0700
Message-Id: <20170514040117.25865-18-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
In-Reply-To: <20170514040117.25865-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a helper that calls ws_check_emit. We'll have it as a helper
as in a later patch we'll add buffering in there.

In a later patch we want to buffer up all output and to do that
we'll need to keep around information for outputting a line such
as the whitespace information. We choose to put this information into
a new struct 'buffered_filepair', which later will be persisting longer
than builtin_diff.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 899dc69dff..08dcc56bb9 100644
--- a/diff.c
+++ b/diff.c
@@ -552,6 +552,16 @@ void emit_line(struct diff_options *o, const char *set, const char *reset,
 	emit_line_0(o, set, reset, 0, line, len);
 }
 
+static void emit_line_ws(struct diff_options *o,
+			 const char *set, const char *reset, int sign,
+			 const char *line, int len,
+			 const char *ws, unsigned ws_rule)
+{
+	emit_line_0(o, set, reset, sign, "", 0);
+	ws_check_emit(line, len, ws_rule,
+		      o->file, set, reset, ws);
+}
+
 void emit_line_fmt(struct diff_options *o,
 		   const char *set, const char *reset,
 		   const char *fmt, ...)
@@ -598,12 +608,10 @@ static void emit_line_checked(const char *reset,
 	else if (sign == '+' && new_blank_line_at_eof(ecbdata, line, len))
 		/* Blank line at EOF - paint '+' as well */
 		emit_line_0(ecbdata->opt, ws, reset, sign, line, len);
-	else {
+	else
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->opt, set, reset, sign, "", 0);
-		ws_check_emit(line, len, ecbdata->ws_rule,
-			      ecbdata->opt->file, set, reset, ws);
-	}
+		emit_line_ws(ecbdata->opt, set, reset, sign, line, len,
+			     ws, ecbdata->ws_rule);
 }
 
 static void emit_add_line(const char *reset,
-- 
2.13.0.18.g183880de0a

