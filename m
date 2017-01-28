Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525B91FAAD
	for <e@80x24.org>; Sat, 28 Jan 2017 02:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751181AbdA1CCp (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:02:45 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:32927 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdA1CCj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:39 -0500
Received: by mail-pf0-f181.google.com with SMTP id y143so77086940pfb.0
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OidI08ztzC8twGL+ojqQ4k9kD/lgAxRVEx5QFt8Jaqg=;
        b=swuLynVa8Ae+5VB0TzJan9UJnMAeVQFC2soZKQ7FnvA8jQGEN2yn9eCoCuPHdPRdL8
         obOvV4ZeJ1IJoFNuoFtcCTDUa4sCoeiej0okREhKMS8xV7ODx6CeN7c82kPHXIu3w99u
         Q6rx6XVpQqeQGA6TG2NOIfXIQTVyo5jD56J/dbhD3hC1dowDV9b0hNh9z9pyXojstDGD
         UlocHXckejn3NMvHNI0PCxUyf096LCsZRQC89ae+iMw54ZNXGHKwJS4Kcgcd/lZsKvCU
         Ninag6967hzLd9K1TwpedcLHV8Kkds1C6bbQXotcq8nyPvcuRR64gyoGgIawHNheHFiZ
         lpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OidI08ztzC8twGL+ojqQ4k9kD/lgAxRVEx5QFt8Jaqg=;
        b=cQa+cz+/gh/+RrK+LhzIasf56fYePLN/GQfrju9ocxUEO1mi7Jfbr01gtOnZ36WuFO
         zTLpReKYiD8sQ3cei0KfuRNsHqrSrrdLkZcxqBmBCA/4UrFn0biHuruf47YCGBFKFcdo
         wlRpbMk8AC8Kbb5BT4Fd0GyrqUHAJ7qR0s0kg0fTBCLGszsfYXiHYvETb04scSb9chGR
         EN2PZ3mR5kUuxc/jJsDhq1YZZihX2TdCaTvkqAaVspml7OjTSh9Ty1DKAtIu6kdMM5Kj
         gnPvMAF5UA/NWvpqE7BTpAdA95Zg/n46v3S9b4Y98XyBkMfhU7gIFsi9TwVt0n5abAND
         m9qw==
X-Gm-Message-State: AIkVDXLKoY8IHW+8FCZYgZwoOCjvbIRuPVSVX7VrT+bMq5T6aqWZPIAXyuv56/jL01hQbKxx
X-Received: by 10.99.234.83 with SMTP id l19mr12713560pgk.114.1485568958616;
        Fri, 27 Jan 2017 18:02:38 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:37 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 07/27] attr.c: simplify macroexpand_one()
Date:   Fri, 27 Jan 2017 18:01:47 -0800
Message-Id: <20170128020207.179015-8-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
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

