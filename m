Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ECCE203C1
	for <e@80x24.org>; Sun, 24 Jul 2016 03:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbcGXDPV (ORCPT <rfc822;e@80x24.org>);
	Sat, 23 Jul 2016 23:15:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33834 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751AbcGXDPT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2016 23:15:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990BA203C1;
	Sun, 24 Jul 2016 03:15:18 +0000 (UTC)
Date:	Sun, 24 Jul 2016 03:15:18 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] mailinfo: extract is_from_line from mailsplit
Message-ID: <20160724031518.GB32480@starla>
References: <20160722224739.GA22961@whir>
 <alpine.DEB.2.20.1607231056150.14111@virtualbox>
 <20160724031409.GA32480@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160724031409.GA32480@starla>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We will be reusing is_from_line for quoting format-patch output
in the next commit.

Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/mailsplit.c | 32 +-------------------------------
 mailinfo.c          | 31 +++++++++++++++++++++++++++++++
 mailinfo.h          |  1 +
 3 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 3068168..bb8f9c9 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -8,41 +8,11 @@
 #include "builtin.h"
 #include "string-list.h"
 #include "strbuf.h"
+#include "mailinfo.h"
 
 static const char git_mailsplit_usage[] =
 "git mailsplit [-d<prec>] [-f<n>] [-b] [--keep-cr] -o<directory> [(<mbox>|<Maildir>)...]";
 
-static int is_from_line(const char *line, int len)
-{
-	const char *colon;
-
-	if (len < 20 || memcmp("From ", line, 5))
-		return 0;
-
-	colon = line + len - 2;
-	line += 5;
-	for (;;) {
-		if (colon < line)
-			return 0;
-		if (*--colon == ':')
-			break;
-	}
-
-	if (!isdigit(colon[-4]) ||
-	    !isdigit(colon[-2]) ||
-	    !isdigit(colon[-1]) ||
-	    !isdigit(colon[ 1]) ||
-	    !isdigit(colon[ 2]))
-		return 0;
-
-	/* year */
-	if (strtol(colon+3, NULL, 10) <= 90)
-		return 0;
-
-	/* Ok, close enough */
-	return 1;
-}
-
 static struct strbuf buf = STRBUF_INIT;
 static int keep_cr;
 static int mboxrd;
diff --git a/mailinfo.c b/mailinfo.c
index 9f19ca1..0ebd953 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1035,3 +1035,34 @@ void clear_mailinfo(struct mailinfo *mi)
 
 	strbuf_release(&mi->log_message);
 }
+
+int is_from_line(const char *line, int len)
+{
+	const char *colon;
+
+	if (len < 20 || memcmp("From ", line, 5))
+		return 0;
+
+	colon = line + len - 2;
+	line += 5;
+	for (;;) {
+		if (colon < line)
+			return 0;
+		if (*--colon == ':')
+			break;
+	}
+
+	if (!isdigit(colon[-4]) ||
+	    !isdigit(colon[-2]) ||
+	    !isdigit(colon[-1]) ||
+	    !isdigit(colon[ 1]) ||
+	    !isdigit(colon[ 2]))
+		return 0;
+
+	/* year */
+	if (strtol(colon+3, NULL, 10) <= 90)
+		return 0;
+
+	/* Ok, close enough */
+	return 1;
+}
diff --git a/mailinfo.h b/mailinfo.h
index 93776a7..c1430a0 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -37,5 +37,6 @@ struct mailinfo {
 extern void setup_mailinfo(struct mailinfo *);
 extern int mailinfo(struct mailinfo *, const char *msg, const char *patch);
 extern void clear_mailinfo(struct mailinfo *);
+int is_from_line(const char *line, int len);
 
 #endif /* MAILINFO_H */
-- 
EW
