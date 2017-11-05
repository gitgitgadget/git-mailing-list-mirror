Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E96E020281
	for <e@80x24.org>; Sun,  5 Nov 2017 20:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750896AbdKEUZY (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 15:25:24 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45762 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbdKEUZW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 15:25:22 -0500
Received: by mail-wm0-f67.google.com with SMTP id y80so10099773wmd.0
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 12:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5S52yfQm7FR97dg+lta0npeVyQwIF2Q2+KFQ5yw4u7I=;
        b=GwEAsYcMLoKqp1ChwexG2KCFlD3WQ0xiqO7wn+rDFnCkHwUCVAgAyPn8/UPSCH6ni5
         opNHw33SEo/V+YFRsx0+75OKeeGXfZx/qqT/feyRL9sBZ5VWoBp3Y2QmbmzMBBfxx9IN
         DOevhMkt5DB6EfBtirrtP/PVzr3wphQvhFdXy8+Zis+3APXpXapD+9HqlDF59R50cO/Q
         ufdpjokXzeMUV+Ce5eQ77Lz1XtiSQ4s4fPwdJYcDy7KLhTjY8AzzpB3u8ZHZmEPRJqiA
         ytLYDzJVkBCMKIAMlNt18pTHsgW80RilFkpboM+YD+/0AZIMGkVbA/yw1CG3SSqgle7F
         D29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5S52yfQm7FR97dg+lta0npeVyQwIF2Q2+KFQ5yw4u7I=;
        b=fmCRL7fyFopJxn2/6UUqQdZU7oTiYxsPMdqcomZ0TiDdWnLj6Vv925vtmUTsZj4GKb
         QMjXEUJJLhiHLKHJDrRMYJBXDlc2zwnIuCUKabIkRTGUwzT+LuG64Ob85gmooPxRkyku
         79Z5HAkPP9BwMhiPlTtAQ6QcRPfApwBH6pPbiw/8XgxHu4+74nzjrcVERhDwCNuYUTOs
         kl3mBnXUZXPylbBzmLJqnDBsv2H58CxwGoGS+cgHbzrhvp13dMGbEpBgKfcMv0rx8DKE
         2Temb5z/wR+bMiPL9dAyAgg7GMH3xJVXXVE7yp/BvG7RyyWK97dokE8Aw7V4MYAThJWv
         t9nA==
X-Gm-Message-State: AJaThX5Qt2Z3uc49rYZ7rcBLo29AvIj209TWrLnn3Eh87BiHVyZC5+4O
        KSSorD9eB7WKFieX3xTV6hKoSeMV
X-Google-Smtp-Source: ABhQp+Tx/fdh6H+g3vvahQwbIYS0Csg6aIa6GRdJzvA9bOa+OhG5ILJDCwcXtK5pWAIBmp6Wh2+HCA==
X-Received: by 10.28.166.143 with SMTP id p137mr4006084wme.149.1509913521195;
        Sun, 05 Nov 2017 12:25:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 71sm12917543wmg.0.2017.11.05.12.25.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 12:25:20 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 2/4] bisect: fix memory leak in `find_bisection()`
Date:   Sun,  5 Nov 2017 21:24:29 +0100
Message-Id: <d682f573f68882c9dbb359d1abb3d7868d1cd77e.1509906092.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <cover.1509906092.git.martin.agren@gmail.com>
References: <CAN0heSoBeG_8zLwS-71_ZVBF-HsVGKY1W1QiTSQ_ybwWCPauog@mail.gmail.com> <cover.1509906092.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`find_bisection()` rebuilds the commit list it is given by reversing it
and skipping uninteresting commits. The uninteresting list entries are
leaked. Free them to fix the leak.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 bisect.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index 5a3ae4971..2f4321767 100644
--- a/bisect.c
+++ b/bisect.c
@@ -379,8 +379,10 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 		unsigned flags = p->item->object.flags;
 
 		next = p->next;
-		if (flags & UNINTERESTING)
+		if (flags & UNINTERESTING) {
+			free(p);
 			continue;
+		}
 		p->next = last;
 		last = p;
 		if (!(flags & TREESAME))
-- 
2.15.0.415.gac1375d7e

