Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2B2E1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 08:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeGJIxX (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 04:53:23 -0400
Received: from gecko.sbs.de ([194.138.37.40]:43919 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751267AbeGJIxK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 04:53:10 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id w6A8qhkS018334
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 10:52:43 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6A8qgGT024364;
        Tue, 10 Jul 2018 10:52:43 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 6/9] gpg-interface: do not hardcode the key string len anymore
Date:   Tue, 10 Jul 2018 10:52:28 +0200
Message-Id: <7300c85a1c6d484c781cc80b307b5e7f085ac226.1531208187.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1531208187.git.henning.schild@siemens.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
In-Reply-To: <cover.1531208187.git.henning.schild@siemens.com>
References: <cover.1531208187.git.henning.schild@siemens.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gnupg does print the keyid followed by a space and the signer comes
next. The same pattern is also used in gpgsm, but there the key length
would be 40 instead of 16. Instead of hardcoding the expected length,
find the first space and calculate it.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 gpg-interface.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 0a8d1bff3..ac2df498d 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -88,10 +88,11 @@ static void parse_gpg_output(struct signature_check *sigc)
 		sigc->result = sigcheck_gpg_status[i].result;
 		/* The trust messages are not followed by key/signer information */
 		if (sigc->result != 'U') {
-			sigc->key = xmemdupz(found, 16);
+			next = strchrnul(found, ' ');
+			sigc->key = xmemdupz(found, next - found);
 			/* The ERRSIG message is not followed by signer information */
 			if (sigc-> result != 'E') {
-				found += 17;
+				found = next + 1;
 				next = strchrnul(found, '\n');
 				sigc->signer = xmemdupz(found, next - found);
 			}
-- 
2.16.4

