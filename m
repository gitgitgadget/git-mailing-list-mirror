Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 583411F453
	for <e@80x24.org>; Thu,  4 Oct 2018 10:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJDRA3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 13:00:29 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:55839 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbeJDRA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 13:00:29 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 80XsgfYebVlGZ80XygOCEU; Thu, 04 Oct 2018 11:07:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1538647675;
        bh=yJ9z0HRdqdSmi/NtQyM8wtW6JjbcjX7tgdnJptc01tA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=i3yA1l8y7HWUYxwjOLxT6JbCvaGDVMWyWblwu7mYJoSGtl5wmmnPPKFc7DhaqYBM0
         HyKtYg3O/uYV4giCz1SXACxeIYiOzxvRdGUc6tRC49uOzqF69lvAz8tnUSKMazAwH8
         vItWozUtvp3QL+HOwQwfssiQA3mZ4fL6jW0RItHQ=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=evINK-nbAAAA:8 a=_rzlfNngT4RONqvaySYA:9
 a=OUBv6ERI6rX7pUnl:21 a=bcszGWiqAtblYPha:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 1/5] diff --color-moved-ws: fix double free crash
Date:   Thu,  4 Oct 2018 11:07:41 +0100
Message-Id: <20181004100745.4568-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004100745.4568-1-phillip.wood@talktalk.net>
References: <20181002175514.31495-1-phillip.wood@talktalk.net>
 <20181004100745.4568-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHnJ+W9y4dFZtsqOa2McTFttGuO7JBAetyCjRPSQTkPu9wXB7RYKSTCBZDp/711u/1mwNHU5lAZCSllyM9VRgBFnQkaw0dpycDtohRJt6tPB2k3ovKM2
 oCOP+YHc1IDkb8GQadJSJKMcbOj6GWUM2t4q4WPHiAph/SwqlOzYUMuA4S2C0btSTHGwmJRf1Eok3tvA86SkUSPPtPZPaTckuWeX2wQZI2ewhTkiYTcDIKGC
 ER/mHDK440j6B6Rk/Z5vLv9mlxsoHA9UwBEUCzTrsMs00QE760UJfbybeHsFNKHKS30XQkS1IvMGO4OUSymtSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Running
  git diff --color-moved-ws=allow-indentation-change v2.18.0 v2.19.0
results in a crash due to a double free. This happens when two
potential moved blocks start with consecutive lines. As
pmb_advance_or_null_multi_match() advances it copies the ws_delta from
the last matching line to the next. When the first of our consecutive
lines is advanced its ws_delta well be copied to the second,
overwriting the ws_delta of the block containing the second line. Then
when the second line is advanced it will copy the new ws_delta to the
line below it and so on. Eventually one of these blocks will stop
matching and the ws_delta will be freed. From then on the other block
is in a use-after-free state and when it stops matching it will try to
free the ws_delta that has already been freed by the other block.

The solution is to store the ws_delta in the array of potential moved
blocks rather than with the lines. This means that it no longer needs
to be copied around and one block cannot overwrite the ws_delta of
another. Additionally it saves some malloc/free calls as we don't keep
allocating and freeing ws_deltas.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    This applies on top of fab01ec52e ("diff: fix
    --color-moved-ws=allow-indentation-change", 2018-09-04). Note that the
    crash happens with or without that patch, but the mechanism is
    slightly different without it.
    
    Changes since v1:
     - updated comments to match new implementation.

 diff.c | 82 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/diff.c b/diff.c
index 9393993e33..02d885f039 100644
--- a/diff.c
+++ b/diff.c
@@ -751,7 +751,6 @@ struct moved_entry {
 	struct hashmap_entry ent;
 	const struct emitted_diff_symbol *es;
 	struct moved_entry *next_line;
-	struct ws_delta *wsd;
 };
 
 /**
@@ -768,6 +767,17 @@ struct ws_delta {
 };
 #define WS_DELTA_INIT { NULL, 0 }
 
+struct moved_block {
+	struct moved_entry *match;
+	struct ws_delta wsd;
+};
+
+static void moved_block_clear(struct moved_block *b)
+{
+	FREE_AND_NULL(b->wsd.string);
+	b->match = NULL;
+}
+
 static int compute_ws_delta(const struct emitted_diff_symbol *a,
 			     const struct emitted_diff_symbol *b,
 			     struct ws_delta *out)
@@ -785,7 +795,7 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 static int cmp_in_block_with_wsd(const struct diff_options *o,
 				 const struct moved_entry *cur,
 				 const struct moved_entry *match,
-				 struct moved_entry *pmb,
+				 struct moved_block *pmb,
 				 int n)
 {
 	struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
@@ -805,25 +815,24 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	if (strcmp(a, b))
 		return 1;
 
-	if (!pmb->wsd)
+	if (!pmb->wsd.string)
 		/*
-		 * No white space delta was carried forward? This can happen
-		 * when we exit early in this function and do not carry
-		 * forward ws.
+		 * The white space delta is not active? This can happen
+		 * when we exit early in this function.
 		 */
 		return 1;
 
 	/*
-	 * The indent changes of the block are known and carried forward in
+	 * The indent changes of the block are known and stored in
 	 * pmb->wsd; however we need to check if the indent changes of the
 	 * current line are still the same as before.
 	 *
 	 * To do so we need to compare 'l' to 'cur', adjusting the
 	 * one of them for the white spaces, depending which was longer.
 	 */
 
-	wslen = strlen(pmb->wsd->string);
-	if (pmb->wsd->current_longer) {
+	wslen = strlen(pmb->wsd.string);
+	if (pmb->wsd.current_longer) {
 		c += wslen;
 		cl -= wslen;
 	} else {
@@ -873,7 +882,6 @@ static struct moved_entry *prepare_entry(struct diff_options *o,
 	ret->ent.hash = xdiff_hash_string(l->line, l->len, flags);
 	ret->es = l;
 	ret->next_line = NULL;
-	ret->wsd = NULL;
 
 	return ret;
 }
@@ -913,76 +921,72 @@ static void add_lines_to_move_detection(struct diff_options *o,
 static void pmb_advance_or_null(struct diff_options *o,
 				struct moved_entry *match,
 				struct hashmap *hm,
-				struct moved_entry **pmb,
+				struct moved_block *pmb,
 				int pmb_nr)
 {
 	int i;
 	for (i = 0; i < pmb_nr; i++) {
-		struct moved_entry *prev = pmb[i];
+		struct moved_entry *prev = pmb[i].match;
 		struct moved_entry *cur = (prev && prev->next_line) ?
 				prev->next_line : NULL;
 		if (cur && !hm->cmpfn(o, cur, match, NULL)) {
-			pmb[i] = cur;
+			pmb[i].match = cur;
 		} else {
-			pmb[i] = NULL;
+			pmb[i].match = NULL;
 		}
 	}
 }
 
 static void pmb_advance_or_null_multi_match(struct diff_options *o,
 					    struct moved_entry *match,
 					    struct hashmap *hm,
-					    struct moved_entry **pmb,
+					    struct moved_block *pmb,
 					    int pmb_nr, int n)
 {
 	int i;
 	char *got_match = xcalloc(1, pmb_nr);
 
 	for (; match; match = hashmap_get_next(hm, match)) {
 		for (i = 0; i < pmb_nr; i++) {
-			struct moved_entry *prev = pmb[i];
+			struct moved_entry *prev = pmb[i].match;
 			struct moved_entry *cur = (prev && prev->next_line) ?
 					prev->next_line : NULL;
 			if (!cur)
 				continue;
-			if (!cmp_in_block_with_wsd(o, cur, match, pmb[i], n))
+			if (!cmp_in_block_with_wsd(o, cur, match, &pmb[i], n))
 				got_match[i] |= 1;
 		}
 	}
 
 	for (i = 0; i < pmb_nr; i++) {
 		if (got_match[i]) {
-			/* Carry the white space delta forward */
-			pmb[i]->next_line->wsd = pmb[i]->wsd;
-			pmb[i] = pmb[i]->next_line;
+			/* Advance to the next line */
+			pmb[i].match = pmb[i].match->next_line;
 		} else {
-			if (pmb[i]->wsd) {
-				free(pmb[i]->wsd->string);
-				FREE_AND_NULL(pmb[i]->wsd);
-			}
-			pmb[i] = NULL;
+			moved_block_clear(&pmb[i]);
 		}
 	}
 }
 
-static int shrink_potential_moved_blocks(struct moved_entry **pmb,
+static int shrink_potential_moved_blocks(struct moved_block *pmb,
 					 int pmb_nr)
 {
 	int lp, rp;
 
 	/* Shrink the set of potential block to the remaining running */
 	for (lp = 0, rp = pmb_nr - 1; lp <= rp;) {
-		while (lp < pmb_nr && pmb[lp])
+		while (lp < pmb_nr && pmb[lp].match)
 			lp++;
 		/* lp points at the first NULL now */
 
-		while (rp > -1 && !pmb[rp])
+		while (rp > -1 && !pmb[rp].match)
 			rp--;
 		/* rp points at the last non-NULL */
 
 		if (lp < pmb_nr && rp > -1 && lp < rp) {
 			pmb[lp] = pmb[rp];
-			pmb[rp] = NULL;
+			pmb[rp].match = NULL;
+			pmb[rp].wsd.string = NULL;
 			rp--;
 			lp++;
 		}
@@ -1029,7 +1033,7 @@ static void mark_color_as_moved(struct diff_options *o,
 				struct hashmap *add_lines,
 				struct hashmap *del_lines)
 {
-	struct moved_entry **pmb = NULL; /* potentially moved blocks */
+	struct moved_block *pmb = NULL; /* potentially moved blocks */
 	int pmb_nr = 0, pmb_alloc = 0;
 	int n, flipped_block = 1, block_length = 0;
 
@@ -1058,7 +1062,11 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		if (!match) {
+			int i;
+
 			adjust_last_block(o, n, block_length);
+			for(i = 0; i < pmb_nr; i++)
+				moved_block_clear(&pmb[i]);
 			pmb_nr = 0;
 			block_length = 0;
 			continue;
@@ -1086,14 +1094,12 @@ static void mark_color_as_moved(struct diff_options *o,
 				ALLOC_GROW(pmb, pmb_nr + 1, pmb_alloc);
 				if (o->color_moved_ws_handling &
 				    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
-					struct ws_delta *wsd = xmalloc(sizeof(*match->wsd));
-					if (compute_ws_delta(l, match->es, wsd)) {
-						match->wsd = wsd;
-						pmb[pmb_nr++] = match;
-					} else
-						free(wsd);
+					if (compute_ws_delta(l, match->es,
+							     &pmb[pmb_nr].wsd))
+						pmb[pmb_nr++].match = match;
 				} else {
-					pmb[pmb_nr++] = match;
+					pmb[pmb_nr].wsd.string = NULL;
+					pmb[pmb_nr++].match = match;
 				}
 			}
 
@@ -1110,6 +1116,8 @@ static void mark_color_as_moved(struct diff_options *o,
 	}
 	adjust_last_block(o, n, block_length);
 
+	for(n = 0; n < pmb_nr; n++)
+		moved_block_clear(&pmb[n]);
 	free(pmb);
 }
 
-- 
2.19.0

