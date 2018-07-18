Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06FBB1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeGRULn (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:11:43 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:36290 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRULn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:11:43 -0400
Received: by mail-it0-f73.google.com with SMTP id m185-v6so3530307itm.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=15k82WBKHCQ6W1i6oabDa6R7POVsciVQqHlXqAgnOhA=;
        b=vqh+rEOXhK4Ams44kbNrnzD151d1dren3/RFydMdQja3nqQT0kPvUy996kww8pEh1D
         a0XCvlMMf84fd+KdP+V8Fr5IrrDbLlijUNU9D2tU4W2jD5tmi7/ERUqQ1MuyvLp6D9C4
         MT/6zM9O31V/CxCxdun1pbjAlDtaSuG0bsvmZTBZGCicP2c7LYGL2JCRs+U/239YUEG7
         nibyD9kuDPcywis3ttx4LR6D6+ShxQewt/Tp5R65sQAQEyQgsqUDUAHabHzXONwDnzdF
         R9OlSskAtRci/O8apMky0RVZHszipcPultvV06tFtFdvgdJNJ7JDf5WQl35cLzf3tspE
         ez2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=15k82WBKHCQ6W1i6oabDa6R7POVsciVQqHlXqAgnOhA=;
        b=RhwjjE0xuCokeFscgUxOhLGieAShUUfjoPY4bpY91zvvJM+fbSRPrHqVimj47AoCfB
         K9RlwIGMr34RIyxAxq4xpA4pYYOxCE/6WuJ6eU6CZSrQPlkR9A1b4JG8TurOnqg4wVpZ
         dkvPIP5bbQH7aaUPRyxBkxdFBdRmRMBXcY+o2KlgORvHse7KMyIj+Hc85C7ecghubXv/
         TZS9xhIfDUb6RnFqfHaXeZjYt4aFxbZYxlR2xfU/3QebpddCyxd9NTmiAI1JTuKF6Ahi
         m5+FIF2bNUaEFvUSqh9DQ59JdW12nt8lfiHUwuqlfCoMrp6yPiUoO84IOmjAq1ZHiXO9
         oz+g==
X-Gm-Message-State: AOUpUlHOAJ5ljre77/xoLhSnGcz5FYUTKXOm1jHvQwnTH4dtlEe7St4m
        MAcB11AdIP8L8E8XbYdqWBNFONsM8tvq3AUTTuf+rtNGAJhavfbD9lfwyEIsh7FKs9nswv4LuCo
        zB6nhoUPTwip1JD6cdsb9k6cXmmHousPYPi4KG1D7sJ57ENQamZaEAUS4gSao
X-Google-Smtp-Source: AAOMgpd4j6sZhFdEHOqWe4WpOmtlpsjuCMn6EiCRtuyno7VB1jv09yuTeJz3UdkwzFfPEHWC5zGUoeBSNOBe
MIME-Version: 1.0
X-Received: by 2002:a24:7d0b:: with SMTP id b11-v6mr1614083itc.30.1531942342428;
 Wed, 18 Jul 2018 12:32:22 -0700 (PDT)
Date:   Wed, 18 Jul 2018 12:31:54 -0700
In-Reply-To: <20180718193156.47365-1-sbeller@google.com>
Message-Id: <20180718193156.47365-9-sbeller@google.com>
References: <20180718193156.47365-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 08/10] diff.c: factor advance_or_nullify out of mark_color_as_moved
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, rybak.a.v@gmail.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the part of code that checks if we're still in a block
into its own function.  We'll need a different approach on advancing
the blocks in a later patch, so having it as a separate function will
prove useful.

While at it rename the variable `p` to `prev` to indicate that it refers
to the previous line. This is as pmb[i] was assigned in the last iteration
of the outmost for loop.

Further rename `pnext` to `cur` to indicate that this should match up with
the current line of the outmost for loop.

Also replace the advancement of pmb[i] to reuse `cur` instead of
using `p->next` (which is how the name for pnext could be explained.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 70eeb40c5fd..4963819e530 100644
--- a/diff.c
+++ b/diff.c
@@ -801,6 +801,25 @@ static void add_lines_to_move_detection(struct diff_options *o,
 	}
 }
 
+static void pmb_advance_or_null(struct diff_options *o,
+				struct moved_entry *match,
+				struct hashmap *hm,
+				struct moved_entry **pmb,
+				int pmb_nr)
+{
+	int i;
+	for (i = 0; i < pmb_nr; i++) {
+		struct moved_entry *prev = pmb[i];
+		struct moved_entry *cur = (prev && prev->next_line) ?
+				prev->next_line : NULL;
+		if (cur && !hm->cmpfn(o, cur, match, NULL)) {
+			pmb[i] = cur;
+		} else {
+			pmb[i] = NULL;
+		}
+	}
+}
+
 static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 					 int pmb_nr)
 {
@@ -875,7 +894,6 @@ static void mark_color_as_moved(struct diff_options *o,
 		struct moved_entry *key;
 		struct moved_entry *match = NULL;
 		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
-		int i;
 
 		switch (l->s) {
 		case DIFF_SYMBOL_PLUS:
@@ -906,17 +924,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		if (o->color_moved == COLOR_MOVED_PLAIN)
 			continue;
 
-		/* Check any potential block runs, advance each or nullify */
-		for (i = 0; i < pmb_nr; i++) {
-			struct moved_entry *p = pmb[i];
-			struct moved_entry *pnext = (p && p->next_line) ?
-					p->next_line : NULL;
-			if (pnext && !hm->cmpfn(o, pnext, match, NULL)) {
-				pmb[i] = p->next_line;
-			} else {
-				pmb[i] = NULL;
-			}
-		}
+		pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
 
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
-- 
2.18.0.233.g985f88cf7e-goog

