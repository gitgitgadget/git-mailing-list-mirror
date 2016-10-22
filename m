Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F006620986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935139AbcJVXct (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:32:49 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:38837 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756207AbcJVXcq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:32:46 -0400
Received: by mail-it0-f51.google.com with SMTP id 66so74079753itl.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qus2dvpBBzOce1fnYnJr5lmi2kaH0xSNWH8ED9yWvtE=;
        b=HI306zAs56PxmpSFzK+Q7+gaspNTug37e7oi7Nd26AUIZDVBY5SoUQQyrxzuGdIduZ
         hPFFcNaz74GsRqmPe7dgSSfukorx6ov5ni4sOjv9WVuAdTE9nG+OXdogkNXm5VTwlHe/
         A3lD+k/nc2aN9CVEMX92QrMrNdJssW5xGpzdwUaoOUsx7LxRfoyP3FKGGlwHqGT0Yhi2
         NInKNO7KvaPZm5a5CeJaeZc328u1N9i9bOTqnADWnTkRKRtxHSJXjz/wLFsq9eX6sEwn
         VHeeMQtR/E0cbQOzwa7uQHED6ysNrOD8uYn5SawxASj1imHlZunuAjuT5dJGx2AuSRmD
         SlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qus2dvpBBzOce1fnYnJr5lmi2kaH0xSNWH8ED9yWvtE=;
        b=fYKj4Phb7KA5qpXjN/zqDZXCdaidgL9YuH8KTzuQnMJ2YeL5sFTMwm7I45fsTzaXR3
         HCEind3TLI8Dv5BEyILhRMBcudt9c0RILdYLjN2WIJKfSdlIPjx4g9/8uuXBfmJiC+lC
         Z0xVhyQ9xLe5WySt/Jh2s4geDpfDP6JjUb4ru1VwkG7sozARVVeCWzB5hOPP7YHq/rAK
         5v/pv5TaMJb8+X5S3UESGRqC9OcDhP5DyJWIeR9i6pRWXJ1GS60yTHs5eGrl1Y+s+cVM
         W3OWrmkMsBkVLu/n0eIBfN19USyOgtnpRx+gYFLUe2snUPpqni0fTvaTChgLZeFwRUZr
         uSIA==
X-Gm-Message-State: ABUngvcjiUyjR4o0P4ktdmZVDJQaHpZ7aJrSGWKhV2gxFKTjfEfqd2mmKJFsCcO1LWAsPvTQ
X-Received: by 10.107.31.78 with SMTP id f75mr7667687iof.141.1477179165161;
        Sat, 22 Oct 2016 16:32:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id 70sm4579544iou.3.2016.10.22.16.32.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:32:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/36] attr.c: simplify macroexpand_one()
Date:   Sat, 22 Oct 2016 16:31:56 -0700
Message-Id: <20161022233225.8883-8-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
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
2.10.1.508.g6572022

