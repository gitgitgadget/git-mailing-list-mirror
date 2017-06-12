Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAE5420401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbdFLWOu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:50 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33589 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752891AbdFLWOq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:46 -0400
Received: by mail-pf0-f179.google.com with SMTP id 83so57297217pfr.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X1Ut+MxrTavWNPm3FJrLz/YrPRkvMJ2xNLcRAobneDg=;
        b=GtLDrvgZIu9eUMLwl1W5n2SpXUGjIbpzYOTtaQoCuUovETEI1pKaxnva8g6d8x4gjp
         bJzZP+lupowE/fpf1XUfQK4fcLAsbt7uSGMtndfCrqekwQRxHG0wMp1CLGOEtQEfkrDU
         tmwKNQBumHTmH/fbWd+CxiINiqVpvXXffGSAwrpjqvqBRgHwqx7kX1Ynqm0dEZ5nl9Rn
         8D0lrQeFOzJ/jpgMi9O01+vzPa6ggM2uzrB++ftb8qu/hK4mKWqtlXPIIZbaLc6rHNhY
         XNASZW0IwUoTH+GJ3qnkUf3/n1RdTTAZ3kpLpDIj7RBQ5oQoW282Ar+Tk3R9xOKbQY5p
         55NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X1Ut+MxrTavWNPm3FJrLz/YrPRkvMJ2xNLcRAobneDg=;
        b=LPUrQtuNFGBAdQYbnXa9OU7CXPWds8t0eaDHMKnjGSEvXDfy/NcRi97ORkIZMaNwz5
         tEnAv7fj5KgqewXJk0uWAUdOZ8HLGndHJ+Z0TfJQeyZiHq9NjzAVSiiO3kSPhM/p3WxR
         Pw6Jjukg5UaiQyaD73qgoguBp+RjpO3WsmXXAcyEX0kacAnqGRoF8RdFu2H17mQsol5b
         9o1Hmw7LJpFgZ59M90KLYuyxCftEIp/Q50nIycXDpLvLNjJ2ah7pNfkSXYkLne/r/65D
         KQUU/bUCzYfr1V/9pjrqOnbDiiMRDG2fLpNKRcQ9+kUQtI8S1s27oA8TFVmEWpjymALv
         POcw==
X-Gm-Message-State: AODbwcD7oB+xG7rMbhwc1F6hd+lrBF4zEsPa8T6jCkaMYqtgfJWngpUK
        Om1ilBy/7qBzmj/gL89+Xw==
X-Received: by 10.98.100.8 with SMTP id y8mr38469511pfb.79.1497305685535;
        Mon, 12 Jun 2017 15:14:45 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:44 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 17/17] ls-files: factor out tag calculation
Date:   Mon, 12 Jun 2017 15:14:08 -0700
Message-Id: <20170612221408.173876-18-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c9307f9ef..cdc1cfdd2 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -93,6 +93,30 @@ static void write_name(const char *name)
 	strbuf_release(&full_name);
 }
 
+static const char *get_tag(const struct cache_entry *ce, const char *tag)
+{
+	static char alttag[4];
+
+	if (tag && *tag && show_valid_bit && (ce->ce_flags & CE_VALID)) {
+		memcpy(alttag, tag, 3);
+
+		if (isalpha(tag[0])) {
+			alttag[0] = tolower(tag[0]);
+		} else if (tag[0] == '?') {
+			alttag[0] = '!';
+		} else {
+			alttag[0] = 'v';
+			alttag[1] = tag[0];
+			alttag[2] = ' ';
+			alttag[3] = 0;
+		}
+
+		tag = alttag;
+	}
+
+	return tag;
+}
+
 static void print_debug(const struct cache_entry *ce)
 {
 	if (debug_mode) {
@@ -264,22 +288,7 @@ static void show_ce_entry(const struct index_state *istate,
 				  len, ps_matched,
 				  S_ISDIR(ce->ce_mode) ||
 				  S_ISGITLINK(ce->ce_mode))) {
-		if (tag && *tag && show_valid_bit &&
-		    (ce->ce_flags & CE_VALID)) {
-			static char alttag[4];
-			memcpy(alttag, tag, 3);
-			if (isalpha(tag[0]))
-				alttag[0] = tolower(tag[0]);
-			else if (tag[0] == '?')
-				alttag[0] = '!';
-			else {
-				alttag[0] = 'v';
-				alttag[1] = tag[0];
-				alttag[2] = ' ';
-				alttag[3] = 0;
-			}
-			tag = alttag;
-		}
+		tag = get_tag(ce, tag);
 
 		if (!show_stage) {
 			fputs(tag, stdout);
-- 
2.13.1.518.g3df882009-goog

