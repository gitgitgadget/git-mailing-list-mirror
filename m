Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C111C1F454
	for <e@80x24.org>; Sun,  4 Nov 2018 15:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbeKEAjz (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 19:39:55 -0500
Received: from 0x63.nu ([109.74.10.199]:37242 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729996AbeKEAjz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 19:39:55 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gJKGP-0005Wk-Ci; Sun, 04 Nov 2018 16:24:33 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v2 4/5] pretty: extract fundamental placeholders to separate function
Date:   Sun,  4 Nov 2018 16:22:31 +0100
Message-Id: <20181104152232.20671-5-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104152232.20671-1-anders@0x63.nu>
References: <20181028125025.30952-1-anders@0x63.nu>
 <20181104152232.20671-1-anders@0x63.nu>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No functional change intended

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 pretty.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/pretty.c b/pretty.c
index f87ba4f18..9fdddce9d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1074,6 +1074,27 @@ static int match_placeholder_arg(const char *to_parse, const char *candidate,
 	return 0;
 }
 
+static size_t format_fundamental(struct strbuf *sb, /* in UTF-8 */
+				 const char *placeholder,
+				 void *context)
+{
+	int ch;
+
+	switch (placeholder[0]) {
+	case 'n':		/* newline */
+		strbuf_addch(sb, '\n');
+		return 1;
+	case 'x':
+		/* %x00 == NUL, %x0a == LF, etc. */
+		ch = hex2chr(placeholder + 1);
+		if (ch < 0)
+			return 0;
+		strbuf_addch(sb, ch);
+		return 3;
+	}
+	return 0;
+}
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1083,9 +1104,13 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	const char *msg = c->message;
 	struct commit_list *p;
 	const char *arg;
-	int ch;
+	size_t res;
 
 	/* these are independent of the commit */
+	res = format_fundamental(sb, placeholder, NULL);
+	if (res)
+		return res;
+
 	switch (placeholder[0]) {
 	case 'C':
 		if (starts_with(placeholder + 1, "(auto)")) {
@@ -1104,16 +1129,6 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 			 */
 			return ret;
 		}
-	case 'n':		/* newline */
-		strbuf_addch(sb, '\n');
-		return 1;
-	case 'x':
-		/* %x00 == NUL, %x0a == LF, etc. */
-		ch = hex2chr(placeholder + 1);
-		if (ch < 0)
-			return 0;
-		strbuf_addch(sb, ch);
-		return 3;
 	case 'w':
 		if (placeholder[1] == '(') {
 			unsigned long width = 0, indent1 = 0, indent2 = 0;
-- 
2.17.1

