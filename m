Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C6191F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731493AbeGQNXE (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 09:23:04 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:55275 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbeGQNXE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 09:23:04 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id w6HCoFuk029137
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 14:50:15 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6HCoEZY005172;
        Tue, 17 Jul 2018 14:50:14 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v4 4/7] gpg-interface: do not hardcode the key string len anymore
Date:   Tue, 17 Jul 2018 14:50:10 +0200
Message-Id: <8330bd5b90aec511e20d21cd0c466752e4ada4b1.1531831244.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1531831244.git.henning.schild@siemens.com>
References: <cover.1531831244.git.henning.schild@siemens.com>
In-Reply-To: <cover.1531831244.git.henning.schild@siemens.com>
References: <cover.1531831244.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gnupg does print the keyid followed by a space and the signer comes
next. The same pattern is also used in gpgsm, but there the key length
would be 40 instead of 16. Instead of hardcoding the expected length,
find the first space and calculate it.
Input that does not match the expected format will be ignored now,
before we jumped to found+17 which might have been behind the end of an
unexpected string.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 gpg-interface.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index a02db7658..51cad9081 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -95,10 +95,11 @@ static void parse_gpg_output(struct signature_check *sigc)
 		sigc->result = sigcheck_gpg_status[i].result;
 		/* The trust messages are not followed by key/signer information */
 		if (sigc->result != 'U') {
-			sigc->key = xmemdupz(found, 16);
+			next = strchrnul(found, ' ');
+			sigc->key = xmemdupz(found, next - found);
 			/* The ERRSIG message is not followed by signer information */
-			if (sigc-> result != 'E') {
-				found += 17;
+			if (*next && sigc-> result != 'E') {
+				found = next + 1;
 				next = strchrnul(found, '\n');
 				sigc->signer = xmemdupz(found, next - found);
 			}
-- 
2.16.4

