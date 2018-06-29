Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D28A1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 00:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030295AbeF2AUg (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 20:20:36 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:45245 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030292AbeF2AUb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 20:20:31 -0400
Received: by mail-yb0-f202.google.com with SMTP id s16-v6so5310730ybp.12
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 17:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=HAaZD0v/7hCFYMARphP9nWXDNejn/bJYVi26Yvumabw=;
        b=Zsc4qGXTvu2K7l4fP49yaCS10a5qOO6oEJqMHvEg6HsIQssaH9776l2N2cl8gh5R3G
         Vm+2yjBkEXrVk2VeDQf5bBkRWXPnwPPFHi9eo0d6pNPiUJq0vEBbmb4s6uUJuzaQVMfS
         q1QVBBttBFVkPdXl/FgpYhoIdTKuK/NA+1nvBqd+Bu+N24JhUexo3WJkLJfWyeMNR+nQ
         OdEqXIASt0n0PcEPZE8KVzz0sGpbvZSec1voUEFoONgYzvID1Mu//fdt3zlspq4QPnFF
         Ormcx6z8Pr7cewqtS37oQeM98lXvNE9ANRt5SwbOyrm1tNFeb21JFEdqM0tpSUfbJh59
         2m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=HAaZD0v/7hCFYMARphP9nWXDNejn/bJYVi26Yvumabw=;
        b=hrXYxpCC1juVvNyJIbkZ0qEzWqv1IUO66ZImrL5v6ZbfuF+5CoPsF+BS8uoIbCcnSX
         1fTSXYxDR4AVfw40Vw819g7Ev73pGEucPMmY19N13NducHTU/3x3Nk7qAy8CIdrmFvPO
         RdI4lnXDrqp4QwJHDSOb38Hj6iU9PPVRs1LceeilkhKr3M9B6Nkr5NiJQPfzHwexzwnX
         T/vNYY0D2KC5cbY9pcXlUgrUJnRE2Pd1qNEvhf98QLOMpU2KYPilFGQetd0PDZBIru1N
         z0Py/Vf/pJzsHMITRG0UfOp95eMMpUy6ossOZvhNpNR5L2rJDpwwj5G7vX7KO1kxllA5
         yKSg==
X-Gm-Message-State: APt69E3nLFSARj10KRba8WbgRbfEQadfl3Arwyaga1LhFo7qAqhyWZ5C
        2k2Evxn5lvVgEkYBYfR1hJFVyTtNyhPM
X-Google-Smtp-Source: AAOMgpc4wGOTHBA9FU1GZFnCOyvAlHSegELAqNQ79uz3mOAWsIAuDRNc+mFtuYM4NCPf7Rn/faABgxEpVhqM
MIME-Version: 1.0
X-Received: by 2002:a25:664d:: with SMTP id z13-v6mr646381ybm.69.1530231630495;
 Thu, 28 Jun 2018 17:20:30 -0700 (PDT)
Date:   Thu, 28 Jun 2018 17:19:57 -0700
In-Reply-To: <20180629001958.85143-1-sbeller@google.com>
Message-Id: <20180629001958.85143-9-sbeller@google.com>
References: <20180622015725.219575-1-sbeller@google.com> <20180629001958.85143-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v4 8/9] diff.c: factor advance_or_nullify out of mark_color_as_moved
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org, bmwill@google.com,
        Junio C Hamano <gitster@pobox.com>
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
2.18.0.399.gad0ab374a1-goog

