Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405DEC433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 284FD20767
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgFVVsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:48:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:39352 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730694AbgFVVsG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:48:06 -0400
Received: (qmail 1943 invoked by uid 109); 22 Jun 2020 21:48:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Jun 2020 21:48:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8591 invoked by uid 111); 22 Jun 2020 21:48:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jun 2020 17:48:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Jun 2020 17:48:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 3/4] fast-export: refactor path printing to not rely on
 stdout
Message-ID: <20200622214805.GC3303964@coredump.intra.peff.net>
References: <20200622214745.GA3302779@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622214745.GA3302779@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'll be using print_path_1() in more places in a subsequent patch, so
let's teach it to take the output handle as a parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index faaab6c7e9..aa7ac9761d 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -369,15 +369,15 @@ static int depth_first(const void *a_, const void *b_)
 	return (a->status == 'R') - (b->status == 'R');
 }
 
-static void print_path_1(const char *path)
+static void print_path_1(FILE *out, const char *path)
 {
 	int need_quote = quote_c_style(path, NULL, NULL, 0);
 	if (need_quote)
-		quote_c_style(path, NULL, stdout, 0);
+		quote_c_style(path, NULL, out, 0);
 	else if (strchr(path, ' '))
-		printf("\"%s\"", path);
+		fprintf(out, "\"%s\"", path);
 	else
-		printf("%s", path);
+		fprintf(out, "%s", path);
 }
 
 static void *anonymize_path_component(const void *path, size_t *len)
@@ -391,13 +391,13 @@ static void *anonymize_path_component(const void *path, size_t *len)
 static void print_path(const char *path)
 {
 	if (!anonymize)
-		print_path_1(path);
+		print_path_1(stdout, path);
 	else {
 		static struct hashmap paths;
 		static struct strbuf anon = STRBUF_INIT;
 
 		anonymize_path(&anon, path, &paths, anonymize_path_component);
-		print_path_1(anon.buf);
+		print_path_1(stdout, anon.buf);
 		strbuf_reset(&anon);
 	}
 }
-- 
2.27.0.517.gbc32778fa3

