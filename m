Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C3301F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 11:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeKRWFr (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 17:05:47 -0500
Received: from 0x63.nu ([109.74.10.199]:54736 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbeKRWFr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 17:05:47 -0500
Received: from localhost ([127.0.0.1] helo=moveme2.lan)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gOLVx-0003J7-9z; Sun, 18 Nov 2018 12:45:21 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v3 1/5] pretty: single return path in %(trailers) handling
Date:   Sun, 18 Nov 2018 12:44:23 +0100
Message-Id: <20181118114427.1397-2-anders@0x63.nu>
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

No functional change intended.

This change may not seem useful on its own, but upcoming commits will do
memory allocation in there, and a single return path makes deallocation
easier.

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 pretty.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index b83a3ecd2..aa03d5b23 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1312,6 +1312,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (skip_prefix(placeholder, "(trailers", &arg)) {
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+		size_t ret = 0;
 
 		opts.no_divider = 1;
 
@@ -1328,8 +1329,9 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		}
 		if (*arg == ')') {
 			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
-			return arg - placeholder + 1;
+			ret = arg - placeholder + 1;
 		}
+		return ret;
 	}
 
 	return 0;	/* unknown placeholder */
-- 
2.17.1

