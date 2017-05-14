Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CDB220188
	for <e@80x24.org>; Sun, 14 May 2017 04:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbdENEBi (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 00:01:38 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33510 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdENEBf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 00:01:35 -0400
Received: by mail-pf0-f178.google.com with SMTP id e193so47224497pfh.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 21:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ThTO7/8yKss3LjCG+jhCu1/nn/HkYciD39mGBS8cYS4=;
        b=dNs1sI6URz8KdoZLyFQHUbJQAg9izDXXoqY3WrUft2ARlCq3QG230oKFwH/u1JT14g
         xLMDzO8wEebo02tElzYl9IZfwMnjzNcChQifcwQuayEAmoPcplOM3Fn5QEhsJLgiLtA8
         ZjhSI4gEHK6YMWfeGmLEa8gdIuu7Q2eJzHWJB+QnB7P8lSwPkqWuS9hDdevFhU5tWzcJ
         /7zgjAn1A7DIyzG3VM56DGAJUXOKThK00cF6HOG4l5y9wM2PtYtNyVnsHFlScOoIE2x8
         S/1vM0TZtFs+yeF3OAMtVY5Lc8JcVIM1CBDyffcWp0yV2vdToSZFy8SHfCErwh6cWlQK
         BhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ThTO7/8yKss3LjCG+jhCu1/nn/HkYciD39mGBS8cYS4=;
        b=haek3aW7dcKS7SJEe47n1z4TJll09EjcWKOkOzEBBoqFWUchgRcuoymiO74u8rcs/9
         TPsHeNpA0TknzUG/vX0SBw9FIYogkSuRGwAz76PUm7w+Xd14ZXJB883uSkfCkcbKwKsi
         tsytoiGAzdL+KKLP5jR5YWKP5TgOLe4ukBfobexuuTG9ifOl22oHTLYhEUTNOx5tx6B3
         34NhS/gg+kAuv6VeCAL9zHl2T3/Sv3AOA3sNjfgZFdpdCJ5dp4CUQBV18qLSEJTGWU+y
         l2IggriOiYDsrv7iGeOUvY20G0SaszTU/lKoSskrMjNHqGt/zpZG/EpPW9c7xeYEv/Pz
         nLaQ==
X-Gm-Message-State: AODbwcBjmkdCakZ5TXqb54KAPb2vZwR4hwXcm+Hho7H20y78v5M8CWiL
        n+003jqagpDG0wq4
X-Received: by 10.84.232.205 with SMTP id x13mr16156927plm.7.1494734494359;
        Sat, 13 May 2017 21:01:34 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:19fd:7796:6ff9:70d4])
        by smtp.gmail.com with ESMTPSA id d3sm12739351pfb.110.2017.05.13.21.01.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2017 21:01:33 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, peff@peff.net, gitster@pobox.com,
        mhagger@alum.mit.edu, jrnieder@gmail.com, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/19] diff: add emit_line_fmt
Date:   Sat, 13 May 2017 21:01:04 -0700
Message-Id: <20170514040117.25865-7-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g183880de0a
In-Reply-To: <20170514040117.25865-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the following patches we'll convert all printing functions to use
the emit_line_* family of functions.

Many of the printing functions to be converted are formatted. So offer
a formatted function in the emit_line function family as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/diff.c b/diff.c
index 48f0fb98dc..aef159a919 100644
--- a/diff.c
+++ b/diff.c
@@ -552,6 +552,20 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 	emit_line_0(o, set, reset, 0, line, len);
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
+	strbuf_release(&sb);
+}
+
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
 {
 	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
-- 
2.13.0.18.g183880de0a

