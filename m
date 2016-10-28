Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4ADB2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966245AbcJ1Szf (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:55:35 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33319 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966136AbcJ1Szc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:32 -0400
Received: by mail-pf0-f181.google.com with SMTP id 197so41753573pfu.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5WxPV3OLM0aEXY/EiVJa3i51qgQ3cIDtnVLVRjRJ2aQ=;
        b=Ndq8MyJUj//+6pdWdVaG7zSDX5nExTB1nn1R46IAhsi8txwQ/MzkaE941B6/dQn6yE
         lBCFmSHBpKLOzQLMd8miluKx7v5YGHwTlCidWSnJogob5VhkyBwfIQStCNwCAh7CPw9D
         crlz41YGZmkcvT2+ny+PRXTiZHZ8fk1WPP+ri1tlaoQVBlZUXr0xmffZtRvBJJJ+VbIQ
         2eOcuoZN1xmOSQUUvtRpq+nSegnAOxa/bkiHN0WsmaavlCPuL+PvSoc3wqNMrZQC+YUy
         aszCGPfh0e/6utDmbWSGXww36Ey/4r8iklstmzO4tAmXNzS9ppvTZm/V8kjr2CJd8jfu
         4JAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5WxPV3OLM0aEXY/EiVJa3i51qgQ3cIDtnVLVRjRJ2aQ=;
        b=RL7gnQv/cZwt6doAZe6NRa3s8ZDJ5INVrbRET7PhWXDslGG4KzuARhqiHN4BD3sZvO
         IY8j2FxLQyklrOwst41FrdTFj8B79ePG8r4+yGGDoB+FI2HwWfDsQXKZCwwcQyq9K0LN
         Oldijx5GSEgBmUUf2FupNgvqqq3n0Ic78VrAsGduK0LBuMZyIH29Pj1dmiMgz3ACOy7q
         9DsSeWYXMWEl6sX9vbJ2qdrLKq0KNLEMQdgDU51eMVQXWL5uccF+9FUP7zGAAdex9MEq
         Ek56Dq/o5z79fDuALM1CXwoKGKsvVuvfo0dEZCkOU/BGKz58gNj3tC5yyXLTe+Uxfggj
         myeg==
X-Gm-Message-State: ABUngvdFAF4GyCeZo0bGQOHM/zkVVUpkC1JkbXYSWKfNNQWZXbtTuHGKpLiUkBQUkPoygWQt
X-Received: by 10.98.76.7 with SMTP id z7mr27127822pfa.143.1477680931481;
        Fri, 28 Oct 2016 11:55:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id s25sm20526603pfj.93.2016.10.28.11.55.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 07/36] attr.c: simplify macroexpand_one()
Date:   Fri, 28 Oct 2016 11:54:33 -0700
Message-Id: <20161028185502.8789-8-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
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
---
 attr.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index 17297fffee..e42f931b35 100644
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
2.10.1.714.ge3da0db

