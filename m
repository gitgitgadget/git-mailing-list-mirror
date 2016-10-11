Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC2112098A
	for <e@80x24.org>; Tue, 11 Oct 2016 00:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbcJKAVh (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:37 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35866 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbcJKAVf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:35 -0400
Received: by mail-pa0-f44.google.com with SMTP id ry6so3886109pac.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eQ6yy/RmwoZy1QwoFKo1ZtTr5JKY/4q7osB4j5O792U=;
        b=gkvSAGVkrFLhSPcQahYt7K1eAcxhMBY28tR0/ZOgI+8noXANVC2CxkiQ23odFMUEV2
         p7j4tQNAZEQgTKf7pxRLRHfobeENmVf0xd4Rn/hAi2eayhvveF7wuR4FNgdnL2UXEEze
         1iGfUrfu4MwQsBMyYorrJqSvMDR/MLSJBS+1/ICHkUJNYlaqx1HfTOsEnhtqZSqLnWKN
         KCCAZxE95kvQX4PoB8wKP9FF6u2QP5rDQrhKqN/dTBHHPhHKzV0xPCxofzbIoLCJvwZ+
         ZvvyBFKdxAFURdA/HT56euykh/f8KdflNBubUISeDEfT107UUZAV6/PhnAYZ7OkPg/DX
         MT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eQ6yy/RmwoZy1QwoFKo1ZtTr5JKY/4q7osB4j5O792U=;
        b=WFfUN0vrpehjZ9QWbSsGvYsq/HksCEaZOdxlHyCXIAO/H1/gvxxMPF1GtDrFVT0TL9
         7zhrR+rYGt129V1rknq6LUIpLDhfQyjiAwN7HUMKQ2fFtTanrNgVpl8IR6ObuGgrBwit
         ChyzFDViX/l7hdNWJWDVaXtseWzZxEIZac9OE9L3p91e/5fpRKNXnf25kQ3g0/cxKZsh
         lvKzMJeeG9KujVqeFmB9ypv5i25n9kBu8GHzRVxD82MPb2ftja20atkTmcR+/sF1svwv
         MiFlf98/A50H1iD1aCtIT2vF/Hb6pgrjy3oJGK76lCRZ3Qrla1OH1VBSGGlvEoPsJ2Os
         rryw==
X-Gm-Message-State: AA6/9RnrYIYPGJvOWAy4k/jaEfYS7dPl+qsgwtL947OmdH1ZHqkhLdv9wiaZ9nExmAUqYJD6
X-Received: by 10.66.232.106 with SMTP id tn10mr1743540pac.17.1476145295026;
        Mon, 10 Oct 2016 17:21:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id 4sm509230pfg.66.2016.10.10.17.21.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/28] attr.c: simplify macroexpand_one()
Date:   Mon, 10 Oct 2016 17:20:54 -0700
Message-Id: <20161011002115.23312-8-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
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
2.10.1.382.ga23ca1b.dirty

