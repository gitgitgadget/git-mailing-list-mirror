Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA47220209
	for <e@80x24.org>; Wed, 28 Jun 2017 00:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbdF1A5D (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 20:57:03 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35958 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbdF1A5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 20:57:00 -0400
Received: by mail-pg0-f43.google.com with SMTP id u62so23445727pgb.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 17:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2iADLIDS4sVQktmp9g+zRomZ0ZCpPKVTmc5ml6X3i+Y=;
        b=wXK9U2rrb2kq+u67DVQkiOZXmyGO9o6NBxoHszun5xLw5g8MJsMFQ55zMr+AGlnRTO
         dfIOm3yDdh1JgjAaG8pY2NKnwuxr+ZZO89IT1d4q8djgisMdo6pzBhUM/uSvVLXyEWGf
         I+JNo/bO/CbAF5lfN+C1XfWnWDmDYxE41iStzLZNqJz8/8zjMoTaMUalKv2AjS9q0fzw
         c7fuUhNHoLvLPZ8dYLBGKrNvszb6/Ydpc9iK9I7DG+SCzarQvGaPFauNugY86+Pfh/ed
         MVcZfJ+0SEAsIn74kUDKJq4gg5ZmXpKbJvHihGvyNeqK6j2HUaACOMGtEPs+kky7qwlZ
         MkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2iADLIDS4sVQktmp9g+zRomZ0ZCpPKVTmc5ml6X3i+Y=;
        b=PAUttHTqrR3KXxoZ7gwFptreAIHVLR7mlnwGsbQNVxdzQlfqLqIooYv/XFGzedIXO8
         XyJQkehSUlUEuoVIChN8uy6GQHgptzavG8EKagsXWPgKBtbgQ20gwRYsRlx9vdSziO8q
         dEDW8dQ2ZNUekXwSC4NOML3QxNZHNuCTFK4JISmqrvX29UknfXQSQ44vKbYKL7pb6nlc
         lcHJZUhwCPVYw0+lgZdP6JhjHPK6vU1LwzeZHJzkc79sJVR1xQvXDhC4jPNr5/PHLvma
         bymYNDaXS8wR9VMgaBSXZSB22IhBhbDnh7uz/CGwutkaTdK2pbQ93XJNkbZeCrFzyD6B
         pKiw==
X-Gm-Message-State: AKS2vOxOg83snd6Er7IZVDfdW9wOZcRjQ9g0Cnml++rnjibAnvYTzySD
        ScouNGpatZPGGO2l
X-Received: by 10.84.233.204 with SMTP id m12mr8703826pln.292.1498611419440;
        Tue, 27 Jun 2017 17:56:59 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ac62:ae13:b066:f242])
        by smtp.gmail.com with ESMTPSA id 10sm817483pfj.61.2017.06.27.17.56.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 17:56:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/6] diff.c: factor out shrinking of potential moved line blocks
Date:   Tue, 27 Jun 2017 17:56:46 -0700
Message-Id: <20170628005651.8110-2-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170628005651.8110-1-sbeller@google.com>
References: <20170628005651.8110-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is cleaner and keeps the rather large function
that performs the move detection smaller.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/diff.c b/diff.c
index 82ace48c38..5311dcf133 100644
--- a/diff.c
+++ b/diff.c
@@ -808,6 +808,33 @@ static void add_lines_to_move_detection(struct diff_options *o,
 	}
 }
 
+static int shrink_potential_moved_blocks(struct moved_entry **pmb,
+					 int pmb_nr)
+{
+	int lp, rp;
+
+	/* Shrink the set of potential block to the remaining running */
+	for (lp = 0, rp = pmb_nr - 1; lp <= rp;) {
+		while (lp < pmb_nr && pmb[lp])
+			lp++;
+		/* lp points at the first NULL now */
+
+		while (rp > -1 && !pmb[rp])
+			rp--;
+		/* rp points at the last non-NULL */
+
+		if (lp < pmb_nr && rp > -1 && lp < rp) {
+			pmb[lp] = pmb[rp];
+			pmb[rp] = NULL;
+			rp--;
+			lp++;
+		}
+	}
+
+	/* Remember the number of running sets */
+	return rp + 1;
+}
+
 /* Find blocks of moved code, delegate actual coloring decision to helper */
 static void mark_color_as_moved(struct diff_options *o,
 				struct hashmap *add_lines,
@@ -822,7 +849,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		struct moved_entry *key;
 		struct moved_entry *match = NULL;
 		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
-		int i, lp, rp;
+		int i;
 
 		switch (l->s) {
 		case DIFF_SYMBOL_PLUS:
@@ -864,26 +891,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			}
 		}
 
-		/* Shrink the set of potential block to the remaining running */
-		for (lp = 0, rp = pmb_nr - 1; lp <= rp;) {
-			while (lp < pmb_nr && pmb[lp])
-				lp++;
-			/* lp points at the first NULL now */
-
-			while (rp > -1 && !pmb[rp])
-				rp--;
-			/* rp points at the last non-NULL */
-
-			if (lp < pmb_nr && rp > -1 && lp < rp) {
-				pmb[lp] = pmb[rp];
-				pmb[rp] = NULL;
-				rp--;
-				lp++;
-			}
-		}
-
-		/* Remember the number of running sets */
-		pmb_nr = rp + 1;
+		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
 		if (pmb_nr == 0) {
 			/*
-- 
2.13.0.31.g9b732c453e

