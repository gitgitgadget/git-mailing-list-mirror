Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 882F21FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbdAMACC (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:02:02 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32909 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdAMACB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:02:01 -0500
Received: by mail-pf0-f178.google.com with SMTP id y143so20793274pfb.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XogatsF9sagbgrjco7C4R+063dZyQYm7Cd2j+bsYFBE=;
        b=FHY5orIrZXwtxCk9ib3Tpg/iYOrRuPgG4vSAcbgTseza8T2S+BdFCvT4R7Wvdz05Fh
         inzeSBOH9/F+gZMo/TW/YkHYWRrw7QX7ACHgwIEkmmcPxBIsMaSQ64qBRHUIgETLHkYL
         qGLINcUYrdxXSELPOESpPmtgmhgY18L+2B969cY41HW9/lMa+5ZhMeQhewxKldOBOduW
         5pW/zH6FCBmullNdOOCP3n/zCrADRCKQmB51bHgUj6cFWzmTtEGPr2JJOFOhidc2Rcq5
         kF9hPcBmma8JpXBiVcQmHiVDmCF0lbMhcjwW3JstPoAc+5hbn9t8DCc411asNpvOvWt9
         faog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XogatsF9sagbgrjco7C4R+063dZyQYm7Cd2j+bsYFBE=;
        b=IbnjYJVyWp5zoJ+gMqKKwjwfRQkOWcv4gP2+CdXjsuDkLpe5Z1towmkiMAUVisM5Tf
         GuHZTwaCeBY+uAlyFHSZxigTutBQjzx8kjjB9UgGgzJyrT8stklvCGBTlGebVffOtJUi
         DDK0uFPcprE3tx2Ipxyo4TUzG/xamB4nqN3U/rbBQu60V3NesreEcBExlZ0hF7ni+Tho
         /b4wY99PTpUeT1rcl9iyE5jXCtXGqlTksEaUBy4hkU9IPZzuGnPLy3eLQmXbqw+6oArH
         sGeMs6BWQ2rULbc79RdbmPd84ZUxq9aybLy0wsJ/R7zpGuoOwZJ0aipSbQykF0TATcxY
         RzVA==
X-Gm-Message-State: AIkVDXJyppOlmwNCLS69+ZRXTpXRiPJqo3Rn7hu/h0lg4AvOtRMmFTdjKDsttCRQebj0ltWX
X-Received: by 10.99.235.10 with SMTP id t10mr20445900pgh.95.1484265252563;
        Thu, 12 Jan 2017 15:54:12 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:11 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 07/27] attr.c: simplify macroexpand_one()
Date:   Thu, 12 Jan 2017 15:53:34 -0800
Message-Id: <20170112235354.153403-8-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
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
2.11.0.390.gc69c2f50cf-goog

