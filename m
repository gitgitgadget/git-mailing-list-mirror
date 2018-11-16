Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D031F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 11:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389574AbeKPVQJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 16:16:09 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:58498 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeKPVQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 16:16:09 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id NbuxgXotudJAeNbv4gYs26; Fri, 16 Nov 2018 11:04:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542366255;
        bh=OTR/H6NakOiBQ69M8u4LwmfEJNnINNrIYKXSLtISpg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=e0yCcHBF4mTZQjrrW/OPFjit1gqR604jLFf/K4Af1LF2TyOlQrtlGGWU0tuCZUfGy
         hldo2O6sZs9X1frU9V7dYrprh5+nwsBCDqw8Vy3vDn/OvwTI3YE4c6hL0y+g+lC1oS
         Bcvtse2dw/Q5AXj/WexSeHP42WxbdptMdRMUHKrk=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=8tmxEoxX9vgNpZSW_XIA:9
 a=jri4uTMte0vmbGdR:21 a=N_oBjOoJZiyhpR-H:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 6/9] diff --color-moved=zebra: be stricter with color alternation
Date:   Fri, 16 Nov 2018 11:03:53 +0000
Message-Id: <20181116110356.12311-7-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116110356.12311-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfGR0wL9TKyky2d6ojQUWA/yGrsTXVt4XMvS1uE8I78QcB+ruygCbCrmO1O3+C7bKuv/jA4ziIojaFnGgB8tDwSIv7zjnvdiQ6mV+Pys1bO96sONJXj9d
 KuxTtFFjrH1jdMM/NplFoqlAU6o6VsaLNygoVk3aqtZzKP75iRRLUVVUfBKluKuqcME+xaEDHOTiJBteQFBqrvamCMRJXTq9OxkylbBN0+aSgLtH5ES/K6L/
 hZeo/C4d0kQ3t1ultXBzgQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Currently when using --color-moved=zebra the color of moved blocks
depends on the number of lines separating them. This means that adding
an odd number of unmoved lines between blocks that are already separated
by one or more unmoved lines will change the color of subsequent moved
blocks. This does not make much sense as the blocks were already
separated by unmoved lines and causes problems when adding lines to test
cases.

Fix this by only using the alternate colors for adjacent moved blocks.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    An alternative would be to always alternate the color of blocks whether
    are not they are adjacent to each other.

 diff.c                     | 27 +++++++++++++++++++--------
 t/t4015-diff-whitespace.sh |  6 +++---
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 53a7ab5aca..8c08dd68df 100644
--- a/diff.c
+++ b/diff.c
@@ -1038,26 +1038,30 @@ static int shrink_potential_moved_blocks(struct moved_block *pmb,
  * The last block consists of the (n - block_length)'th line up to but not
  * including the nth line.
  *
+ * Returns 0 if the last block is empty or is unset by this function, non zero
+ * otherwise.
+ *
  * NEEDSWORK: This uses the same heuristic as blame_entry_score() in blame.c.
  * Think of a way to unify them.
  */
-static void adjust_last_block(struct diff_options *o, int n, int block_length)
+static int adjust_last_block(struct diff_options *o, int n, int block_length)
 {
 	int i, alnum_count = 0;
 	if (o->color_moved == COLOR_MOVED_PLAIN)
-		return;
+		return block_length;
 	for (i = 1; i < block_length + 1; i++) {
 		const char *c = o->emitted_symbols->buf[n - i].line;
 		for (; *c; c++) {
 			if (!isalnum(*c))
 				continue;
 			alnum_count++;
 			if (alnum_count >= COLOR_MOVED_MIN_ALNUM_COUNT)
-				return;
+				return 1;
 		}
 	}
 	for (i = 1; i < block_length + 1; i++)
 		o->emitted_symbols->buf[n - i].flags &= ~DIFF_SYMBOL_MOVED_LINE;
+	return 0;
 }
 
 /* Find blocks of moved code, delegate actual coloring decision to helper */
@@ -1067,14 +1071,15 @@ static void mark_color_as_moved(struct diff_options *o,
 {
 	struct moved_block *pmb = NULL; /* potentially moved blocks */
 	int pmb_nr = 0, pmb_alloc = 0;
-	int n, flipped_block = 1, block_length = 0;
+	int n, flipped_block = 0, block_length = 0;
 
 
 	for (n = 0; n < o->emitted_symbols->nr; n++) {
 		struct hashmap *hm = NULL;
 		struct moved_entry *key;
 		struct moved_entry *match = NULL;
 		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
+		enum diff_symbol last_symbol = 0;
 
 		switch (l->s) {
 		case DIFF_SYMBOL_PLUS:
@@ -1090,7 +1095,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			free(key);
 			break;
 		default:
-			flipped_block = 1;
+			flipped_block = 0;
 		}
 
 		if (!match) {
@@ -1101,10 +1106,13 @@ static void mark_color_as_moved(struct diff_options *o,
 				moved_block_clear(&pmb[i]);
 			pmb_nr = 0;
 			block_length = 0;
+			flipped_block = 0;
+			last_symbol = l->s;
 			continue;
 		}
 
 		if (o->color_moved == COLOR_MOVED_PLAIN) {
+			last_symbol = l->s;
 			l->flags |= DIFF_SYMBOL_MOVED_LINE;
 			continue;
 		}
@@ -1135,19 +1143,22 @@ static void mark_color_as_moved(struct diff_options *o,
 				}
 			}
 
-			flipped_block = (flipped_block + 1) % 2;
+			if (adjust_last_block(o, n, block_length) &&
+			    pmb_nr && last_symbol != l->s)
+				flipped_block = (flipped_block + 1) % 2;
+			else
+				flipped_block = 0;
 
-			adjust_last_block(o, n, block_length);
 			block_length = 0;
 		}
 
 		if (pmb_nr) {
 			block_length++;
-
 			l->flags |= DIFF_SYMBOL_MOVED_LINE;
 			if (flipped_block && o->color_moved != COLOR_MOVED_BLOCKS)
 				l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
 		}
+		last_symbol = l->s;
 	}
 	adjust_last_block(o, n, block_length);
 
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index eee81a1987..fe8a2ab06e 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1802,14 +1802,14 @@ test_expect_success 'only move detection ignores white spaces' '
 	<BOLD;MAGENTA>-a long line to exceed per-line minimum<RESET>
 	<BOLD;MAGENTA>-another long line to exceed per-line minimum<RESET>
 	<RED>-original file<RESET>
-	<BOLD;YELLOW>+<RESET>Q<BOLD;YELLOW>a long line to exceed per-line minimum<RESET>
-	<BOLD;YELLOW>+<RESET>Q<BOLD;YELLOW>another long line to exceed per-line minimum<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>a long line to exceed per-line minimum<RESET>
+	<BOLD;CYAN>+<RESET>Q<BOLD;CYAN>another long line to exceed per-line minimum<RESET>
 	<GREEN>+<RESET><GREEN>new file<RESET>
 	EOF
 	test_cmp expected actual
 '
 
-test_expect_failure 'compare whitespace delta across moved blocks' '
+test_expect_success 'compare whitespace delta across moved blocks' '
 
 	git reset --hard &&
 	q_to_tab <<-\EOF >text.txt &&
-- 
2.19.1

