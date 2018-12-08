Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0963720A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 16:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLHQhq (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 11:37:46 -0500
Received: from 0x63.nu ([109.74.10.199]:48536 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbeLHQhp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 11:37:45 -0500
Received: from ip6-localhost ([::1] helo=moveme2.lan)
        by 0x63.nu with esmtp (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gVfbs-0000Dk-B3; Sat, 08 Dec 2018 17:37:44 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Anders Waldenborg <anders@0x63.nu>
Subject: [PATCH v4 3/7] pretty: single return path in %(trailers) handling
Date:   Sat,  8 Dec 2018 17:36:43 +0100
Message-Id: <20181208163647.19538-4-anders@0x63.nu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181208163647.19538-1-anders@0x63.nu>
References: <20181028125025.30952-1-anders@0x63.nu>
 <20181208163647.19538-1-anders@0x63.nu>
X-SA-Exim-Connect-IP: ::1
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
index 26efdba73a..044447e6c0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1337,6 +1337,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 	if (skip_prefix(placeholder, "(trailers", &arg)) {
 		struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+		size_t ret = 0;
 
 		opts.no_divider = 1;
 
@@ -1350,8 +1351,9 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
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

