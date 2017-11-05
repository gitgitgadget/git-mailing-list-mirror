Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F0C20281
	for <e@80x24.org>; Sun,  5 Nov 2017 20:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbdKEUZb (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 15:25:31 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55897 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdKEUZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 15:25:26 -0500
Received: by mail-wm0-f66.google.com with SMTP id y83so10391568wmc.4
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 12:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G6qL1xCjqw+CHwIm+Id48qA8t6oXT52m8PGLx9Q6lDA=;
        b=UGgtKnzzqaf509EEaXE+BPqtYFVEd2QWYHjyKKv6iRzPeAcWGzoQ2WuZ6BhaZQGeDe
         40tqvukfsPxRiX+y50JKA9lpEjWr/t+/VWWBi867ShVaTKNgm2aUx3DcSYW3arEG9lG0
         QyY4Gc0OYSgkPvvk5wXqxQge1BkR+ax6e0CjGT/8dGg+uy/2S/MJ7EbpQq2LY0CZcj6E
         4GJnvnzLMnq/0tq1mP2FmsnGccd3WMnV9h0vqJjOjoW85g6Nl3c28AQ614qgEznmWrEK
         tFwTsLTApNyu7RcBz9wz3Yom4Mh8Ste6WmApevbIQRkzEMZqpjjUbs5VCmikCV/WAiLI
         rGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G6qL1xCjqw+CHwIm+Id48qA8t6oXT52m8PGLx9Q6lDA=;
        b=VgPwhrb+pEemhF5UVorvy6OTkLUmv6uDSUfEAeCY6PkcTYM8j5ztiFYjAdfUX7YZFL
         vNOgZJPAm8lbiRjHY7XJF5TCRgWtUqAvEWYN9QMf50p+B08kAvHxpc2SLUspj9xPvmb3
         DmVyR1f7EPqowSBfAIyDkoU+6wletRYSsZgtv9JPr05P/mNh6h4ehVZgm/zIzR7U3HEC
         MXSWlKf3GWFqJ8QfM95j/7DY3Fq48gBs0IUjAtg7vgxTtE0cl/xolP2z8ZkVAIevS9lx
         jRiREqaKvqjHbZR2SHV8aZYr+YkxNObATtC5j8L4OMquBKz+jQP5OvQZtdiLVwWP4uRy
         toUA==
X-Gm-Message-State: AJaThX4pZJ2eJiMZfc96EQut02pOaiQApHPAQSpuBWnUEM7zz0u+1n8+
        h/PmajQRVq+4jipoHPrLSMd8vDKj
X-Google-Smtp-Source: ABhQp+SATj/08wbOApTNH+GxV18z7BPJigaGVnG4lMOb61RJlRcInswf6e/H36yF6npXZttMLxndRg==
X-Received: by 10.28.216.5 with SMTP id p5mr4105789wmg.155.1509913525249;
        Sun, 05 Nov 2017 12:25:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id 71sm12917543wmg.0.2017.11.05.12.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 12:25:24 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 4/4] bisect: fix memory leak when returning best element
Date:   Sun,  5 Nov 2017 21:24:31 +0100
Message-Id: <106187fd063f3eb21ec979d8a59f662d77c4b2f4.1509906092.git.martin.agren@gmail.com>
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

When `find_bisection()` returns a single list entry, it leaks the other
entries. Move the to-be-returned item to the front and free the
remainder.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bisect.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index b1941505b..3756f127b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -399,8 +399,12 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	/* Do the real work of finding bisection commit. */
 	best = do_find_bisection(list, nr, weights, find_all);
 	if (best) {
-		if (!find_all)
+		if (!find_all) {
+			list->item = best->item;
+			free_commit_list(list->next);
+			best = list;
 			best->next = NULL;
+		}
 		*reaches = weight(best);
 	}
 	free(weights);
-- 
2.15.0.415.gac1375d7e

