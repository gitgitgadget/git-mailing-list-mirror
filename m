Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4BA320A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751574AbdAWUfv (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:35:51 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35947 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbdAWUfs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:48 -0500
Received: by mail-pf0-f171.google.com with SMTP id 189so43792646pfu.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OidI08ztzC8twGL+ojqQ4k9kD/lgAxRVEx5QFt8Jaqg=;
        b=ZbRnvVoky+EG3M/sSQh3R7MR0+HClk1jy/YJyQvDHHxcmvEWdCry+RCj7zYreeJnUy
         O58yuO9gS4Z4Y8SaNiQwsZrtl4DahNVcU/F85eVOsaLDFKn4Hqd8J6FKq2By6Sd2X94z
         6/keR9gVd1CLhL0+HA9P9j9JIzCQ1kqdSZVsHr/e4o1x1uw0115N6ajqrkEofZt9+xJx
         YgZvKqpJ6pVuG5XKMmLS+chZs8oemZfgzeuKNiSggyOccAFW9QQfocWPhFZ9X/OLUNOw
         Is1dq2yLkuKPWRHfAxt6XCK+JrFbMWGelFqreX8wgIra9+NlILoVuIzaqGvjxSyZY2Yx
         cgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OidI08ztzC8twGL+ojqQ4k9kD/lgAxRVEx5QFt8Jaqg=;
        b=G8FTDGUK3YCQHaKZFzUbQPwVRtaPgggncZz3yKpAMDU+kNOk3m0roLjlmsESSrowpN
         /h29xDkioyhn60HG9NbZFi5giZqmzT0xvOJLAxBtjFfWG90mfdZw0iEDONgupmp4ije7
         uviVLHYMPTqrh/iAh0p8UupN+8u/3zBleAEUSuhyP9Be5zhTIyxz3YzXCO+RWLT1SAlx
         2Mvc0yJQc+HUYYMp5l/4HlbYwlL73/tkPCVI4ZvOEFJItmpOu8e8dUjjeugoZewCdCUo
         +TsRa5GPDAg5tpB80KaZksUSlKlCw+ciBNW5zI31sYCYDgreaKxaayQF0R+bA2gz6kEu
         PN6Q==
X-Gm-Message-State: AIkVDXIxFgRAiOrwJ2LUqXQ+LR5ORN17AZFN1xNFpMLAKsmi9LuD4VjKE6f7nKdz6vYCFD9j
X-Received: by 10.84.170.67 with SMTP id i61mr44951666plb.88.1485203747373;
        Mon, 23 Jan 2017 12:35:47 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:46 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 07/27] attr.c: simplify macroexpand_one()
Date:   Mon, 23 Jan 2017 12:35:05 -0800
Message-Id: <20170123203525.185058-8-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

The double-loop wants to do an early return immediately when one
matching macro is found.  Eliminate the extra variable 'a' used for
that purpose and rewrite the "assign the found item to 'a' to make
it non-NULL and force the loop(s) to terminate" with a direct return
from there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index 17297fffe..e42f931b3 100644
--- a/attr.c
+++ b/attr.c
@@ -705,24 +705,21 @@ static int fill(const char *path, int pathlen, int basename_offset,
 static int macroexpand_one(int nr, int rem)
 {
 	struct attr_stack *stk;
-	struct match_attr *a = NULL;
 	int i;
 
 	if (check_all_attr[nr].value != ATTR__TRUE ||
 	    !check_all_attr[nr].attr->maybe_macro)
 		return rem;
 
-	for (stk = attr_stack; !a && stk; stk = stk->prev)
-		for (i = stk->num_matches - 1; !a && 0 <= i; i--) {
+	for (stk = attr_stack; stk; stk = stk->prev) {
+		for (i = stk->num_matches - 1; 0 <= i; i--) {
 			struct match_attr *ma = stk->attrs[i];
 			if (!ma->is_macro)
 				continue;
 			if (ma->u.attr->attr_nr == nr)
-				a = ma;
+				return fill_one("expand", ma, rem);
 		}
-
-	if (a)
-		rem = fill_one("expand", a, rem);
+	}
 
 	return rem;
 }
-- 
2.11.0.483.g087da7b7c-goog

