Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF85620229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966145AbcKJUgH (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:36:07 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33047 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964859AbcKJUep (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:34:45 -0500
Received: by mail-pf0-f181.google.com with SMTP id d2so152088404pfd.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hODH+QCZJlnEqmeQs73Bp8JMN+sajnujmRL08X+Z0kU=;
        b=aKosIMF+q09QSNRyNSsw7ks6qtnMBfKOXEgwS9sfijFvnA+zKahVnMyl+ID1xepBpJ
         +GaTUq4vGozmKTdqtlwY8A6vpr0rg2FyD1rj1Bhkpcwh8iI/MkqA7M/QHTnWlP3yaEoW
         dCDAFdCM2s5DZyM1lk/y1T4wOliSnsi1TCBsYAJw6gte+2wuveuji3H1TbX202skvnkR
         s1xlp9JxON+uXpwDBh5fFQHdU/qPOi+C/GrBJbEqsCBV2/c/SH4DjxN1f2IA8lyngkGQ
         hXHq/cqH5OzxBztf/pnOSQQoGMfCESQN2lh0OLkUV9ne0DtjtFzRMvXqPP+z4hnxsHHA
         1oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hODH+QCZJlnEqmeQs73Bp8JMN+sajnujmRL08X+Z0kU=;
        b=a7KeKxyQBFpkvtt0A7zGJW6jKxgTfqZ5J70/yq428YW9L8t4OPIJA26BssV4HcvAZi
         Jwo09g6EEJScD+H1fijyyYjDooGjcxlpimQ6KoANKslyml5r9P3mQahD3Covii7WRxY9
         HxxZBq3U64s1B/DCQ5x3ovx4KHI/9gbhf7GRqcAbdcoL58SAa/Ndnw7T5wiDwyVv6y1W
         yXrGMd08hUUDdpAkbOwIKeddk0y4d0E/ZgGoOTib4Ofc1pltVy0FM3k5yiTUX3ZlPDIw
         N8c/WP7A9J7+98eFwiMcLHd7PyxMXBjA+6vV9yaul/eAYgs/BTm2fWDxsWlYXkzQf0ol
         aBDg==
X-Gm-Message-State: ABUngvecI0r8ssdIMBtUE7LUkMXZPOHX28ZdzxgarPKPCBBVGatbwbd7onG4PoWJ5MCPxy+1
X-Received: by 10.98.16.132 with SMTP id 4mr7000130pfq.163.1478810084203;
        Thu, 10 Nov 2016 12:34:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id l187sm9359754pfc.0.2016.11.10.12.34.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:43 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/35] attr.c: simplify macroexpand_one()
Date:   Thu, 10 Nov 2016 12:34:00 -0800
Message-Id: <20161110203428.30512-8-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index 95416d3..7bfeef3 100644
--- a/attr.c
+++ b/attr.c
@@ -701,24 +701,21 @@ static int fill(const char *path, int pathlen, int basename_offset,
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
2.10.1.469.g00a8914

