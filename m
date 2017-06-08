Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5245E1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbdFHXm3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:42:29 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33225 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdFHXmI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:42:08 -0400
Received: by mail-pg0-f47.google.com with SMTP id f185so20740307pgc.0
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QkcTh1QtQNh+Cu3QPyj9hXWLuZs48mQn0BLAGBg9jBw=;
        b=vcxCvANV92glgbwmvGb5SRiTYPaG5iTXraS2tRo26/pHwdCNw63a9vLbCuh6m6bBdE
         b+vi3CaoTPZlD01b+UVQKa1qnI9j3sDwZaMTpXD51KCp3q3UzyHyDhfstXyAuUcnQ4Md
         varp2Aa6m7dxzZXdh1sor/6ozhHqobU7Np4vnwDiKiTfvx8LJ0ALbzg/BmVarC1ENegI
         rGLHkptm8QwrYzfM8TAj6NH73+S9GW+EcExkm+5Ae7f5v2phbORaTqENX7Rz4S3+JfXK
         BOJop+B+T/ZhKWKY3IqlhBipHuPjQqm0NeTe7pUINF60s+QgFptyyCi63UFo/VOkd+Rn
         rT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QkcTh1QtQNh+Cu3QPyj9hXWLuZs48mQn0BLAGBg9jBw=;
        b=PGEbPnHH8iIoe4dpjSXYv+ennO2R/quq76OXwUCmgfYKY3qmFS5pgL8eWYP819NhtH
         CS8Il4EoUEcEGkMnIH+aZnvaSnZnRgsZO3la8FexhyS3GXljPCRkRfVSE0qZ1LZ++CAc
         Es+2CCBof9ZgbxFnlZw0TPzhDDMFk2Y67Z+RLEffCvBUrsmjklqkcjigtN/J/hTQNvR0
         dYDSUZjAEErcQ0WchyDrisqUu6KdX67K4FaHn0eRWqtkgkwbocSMNwZgRxM4+nVhPEdf
         aVKUpEzyLJCHmrLn07cT5Lekvsw/QAT/dwbSHshm7CU+1K9mniWrWTISyHng8XOS8kHK
         DMow==
X-Gm-Message-State: AODbwcAurZJHdUkKiidGZTT5KXGUXgrb2Nw4hJze1GeYJcohZMVqOqA1
        6gZbYaCwHj1QqcozmXBz2A==
X-Received: by 10.84.133.162 with SMTP id f31mr1822817plf.83.1496965327221;
        Thu, 08 Jun 2017 16:42:07 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:42:06 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 31/32] ls-files: factor out tag calculation
Date:   Thu,  8 Jun 2017 16:40:59 -0700
Message-Id: <20170608234100.188529-32-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2849c9a65..6a0302a28 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -94,6 +94,30 @@ static void write_name(const char *name)
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
@@ -264,22 +288,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
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
2.13.1.508.gb3defc5cc-goog

