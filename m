Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBD081F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 11:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbeKRWFy (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 17:05:54 -0500
Received: from 0x63.nu ([109.74.10.199]:54742 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbeKRWFy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 17:05:54 -0500
Received: from localhost ([127.0.0.1] helo=moveme2.lan)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gOLVy-0003J7-I5; Sun, 18 Nov 2018 12:45:22 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v3 4/5] strbuf: separate callback for strbuf_expand:ing literals
Date:   Sun, 18 Nov 2018 12:44:26 +0100
Message-Id: <20181118114427.1397-5-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181118114427.1397-1-anders@0x63.nu>
References: <20181104152232.20671-1-anders@0x63.nu>
 <20181118114427.1397-1-anders@0x63.nu>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Expanding '%n' and '%xNN' is generic functionality, so extract that from
the pretty.c formatter into a callback that can be reused.

No functional change intended

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 pretty.c | 16 +++++-----------
 strbuf.c | 21 +++++++++++++++++++++
 strbuf.h |  8 ++++++++
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/pretty.c b/pretty.c
index 2e99f2418..819c5c50a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1094,9 +1094,13 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	const char *msg = c->message;
 	struct commit_list *p;
 	const char *arg;
-	int ch;
+	size_t res;
 
 	/* these are independent of the commit */
+	res = strbuf_expand_literal_cb(sb, placeholder, NULL);
+	if (res)
+		return res;
+
 	switch (placeholder[0]) {
 	case 'C':
 		if (starts_with(placeholder + 1, "(auto)")) {
@@ -1115,16 +1119,6 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
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
diff --git a/strbuf.c b/strbuf.c
index f6a6cf78b..78eecd29f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -380,6 +380,27 @@ void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn,
 	}
 }
 
+size_t strbuf_expand_literal_cb(struct strbuf *sb,
+				const char *placeholder,
+				void *context)
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
 size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
 		void *context)
 {
diff --git a/strbuf.h b/strbuf.h
index fc40873b6..52e44c9ab 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -320,6 +320,14 @@ void strbuf_expand(struct strbuf *sb,
 		   expand_fn_t fn,
 		   void *context);
 
+/**
+ * Used as callback for `strbuf_expand` to only expand literals
+ * (i.e. %n and %xNN). The context argument is ignored.
+ */
+size_t strbuf_expand_literal_cb(struct strbuf *sb,
+				const char *placeholder,
+				void *context);
+
 /**
  * Used as callback for `strbuf_expand()`, expects an array of
  * struct strbuf_expand_dict_entry as context, i.e. pairs of
-- 
2.17.1

