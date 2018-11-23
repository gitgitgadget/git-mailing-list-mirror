Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E942F1F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 11:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503656AbeKWWBK (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 17:01:10 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:48849 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405346AbeKWWBI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 17:01:08 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id Q9SMg52vNwhzSQ9SWg6d2P; Fri, 23 Nov 2018 11:17:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542971836;
        bh=eiUgzpZGftPWgOekj+lqPVqUMkxEqjKH541Yb675OxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=hRalV0QS7DC2aNpWGHbYrbPSnIMXCdI9d85PhddPe9+eqyUYJSwiuA4X8XI1qkDQf
         Vx5k2XoqJ8x1ZiVxtQC2WOsIW0omtOap87v0uNto7SAMlL3yq2Qwb7+ZTplegZtC0V
         ggJksPqucFmOhvd98pbHQPliT9nVu7PXYY6DV81I=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=SbNmnB_ttm8jhcNlJIAA:9
 a=1hFI-J3tzZ1-M8xW:21 a=6IqgGRd-nYHMaHKe:21 a=RfR_gqz1fSpA9VikTjo0:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 8/9] diff --color-moved-ws: modify allow-indentation-change
Date:   Fri, 23 Nov 2018 11:16:57 +0000
Message-Id: <20181123111658.30342-9-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123111658.30342-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181123111658.30342-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfD2OUQI8mOdIL/FtT3wDKWInQkyalcUDJe3osrTN8QUBZPvEaCzi0FCNSkBNQmUBPEH0zUMXwJRRKkq2fi+a6t7TgdUf2kECWog5HecGSOstWDX+CJKW
 04/jvXC+0ik+M9rWC9O6RZJvFX2ptx/lYxj0gk1qVWsgQNVhgyTdP1RUUmf2aRheC+RAlygLKFgEuXTK0ZWNwEB6cS5LtH7X12fpAwEpJUGv6rfkdYycbwzE
 z5shRedDKRKbTM38v6DnnPTCMwGck+AJ1KdFHjhqn54QuvuZ+IvJRD4YFg6HyW1j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Currently diff --color-moved-ws=allow-indentation-change does not
support indentation that contains a mix of tabs and spaces. For
example in commit 546f70f377 ("convert.h: drop 'extern' from function
declaration", 2018-06-30) the function parameters in the following
lines are not colored as moved [1].

-extern int stream_filter(struct stream_filter *,
-                        const char *input, size_t *isize_p,
-                        char *output, size_t *osize_p);
+int stream_filter(struct stream_filter *,
+                 const char *input, size_t *isize_p,
+                 char *output, size_t *osize_p);

This commit changes the way the indentation is handled to track the
visual size of the indentation rather than the characters in the
indentation. This has the benefit that any whitespace errors do not
interfer with the move detection (the whitespace errors will still be
highlighted according to --ws-error-highlight). During the discussion
of this feature there were concerns about the correct detection of
indentation for python. However those concerns apply whether or not
we're detecting moved lines so no attempt is made to determine if the
indentation is 'pythonic'.

[1] Note that before the commit to fix the erroneous coloring of moved
    lines each line was colored as a different block, since that commit
    they are uncolored.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c                     | 130 +++++++++++++++++++++----------------
 t/t4015-diff-whitespace.sh |  56 ++++++++++++++++
 2 files changed, 129 insertions(+), 57 deletions(-)

diff --git a/diff.c b/diff.c
index c378ce3daf..148503e49c 100644
--- a/diff.c
+++ b/diff.c
@@ -750,6 +750,8 @@ struct emitted_diff_symbol {
 	const char *line;
 	int len;
 	int flags;
+	int indent_off;   /* Offset to first non-whitespace character */
+	int indent_width; /* The visual width of the indentation */
 	enum diff_symbol s;
 };
 #define EMITTED_DIFF_SYMBOL_INIT {NULL}
@@ -780,44 +782,68 @@ struct moved_entry {
 	struct moved_entry *next_line;
 };
 
-/**
- * The struct ws_delta holds white space differences between moved lines, i.e.
- * between '+' and '-' lines that have been detected to be a move.
- * The string contains the difference in leading white spaces, before the
- * rest of the line is compared using the white space config for move
- * coloring. The current_longer indicates if the first string in the
- * comparision is longer than the second.
- */
-struct ws_delta {
-	char *string;
-	unsigned int current_longer : 1;
-};
-#define WS_DELTA_INIT { NULL, 0 }
-
 struct moved_block {
 	struct moved_entry *match;
-	struct ws_delta wsd;
+	int wsd; /* The whitespace delta of this block */
 };
 
 static void moved_block_clear(struct moved_block *b)
 {
-	FREE_AND_NULL(b->wsd.string);
-	b->match = NULL;
+	memset(b, 0, sizeof(*b));
+}
+
+static void fill_es_indent_data(struct emitted_diff_symbol *es)
+{
+	unsigned int off = 0;
+	int width = 0, tab_width = es->flags & WS_TAB_WIDTH_MASK;
+	const char *s = es->line;
+	const int len = es->len;
+
+	/* skip any \v \f \r at start of indentation */
+	while (s[off] == '\f' || s[off] == '\v' ||
+	       (s[off] == '\r' && off < len - 1))
+		off++;
+
+	/* calculate the visual width of indentation */
+	while(1) {
+		if (s[off] == ' ') {
+			width++;
+			off++;
+		} else if (s[off] == '\t') {
+			width += tab_width - (width % tab_width);
+			while (s[++off] == '\t')
+				width += tab_width;
+		} else {
+			break;
+		}
+	}
+
+	es->indent_off = off;
+	es->indent_width = width;
 }
 
 static int compute_ws_delta(const struct emitted_diff_symbol *a,
-			     const struct emitted_diff_symbol *b,
-			     struct ws_delta *out)
+			    const struct emitted_diff_symbol *b,
+			    int *out)
 {
-	const struct emitted_diff_symbol *longer =  a->len > b->len ? a : b;
-	const struct emitted_diff_symbol *shorter = a->len > b->len ? b : a;
-	int d = longer->len - shorter->len;
+	int a_len = a->len,
+	    b_len = b->len,
+	    a_off = a->indent_off,
+	    a_width = a->indent_width,
+	    b_off = b->indent_off,
+	    b_width = b->indent_width;
+	int delta;
 
-	if (strncmp(longer->line + d, shorter->line, shorter->len))
+	if (a->s == DIFF_SYMBOL_PLUS)
+		delta = a_width - b_width;
+	else
+		delta = b_width - a_width;
+
+	if (a_len - a_off != b_len - b_off ||
+	    memcmp(a->line + a_off, b->line + b_off, a_len - a_off))
 		return 0;
 
-	out->string = xmemdupz(longer->line, d);
-	out->current_longer = (a == longer);
+	*out = delta;
 
 	return 1;
 }
@@ -833,8 +859,11 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	const char *a = cur->es->line,
 		   *b = match->es->line,
 		   *c = l->line;
-	const char *orig_a = a;
-	int wslen;
+	int a_off = cur->es->indent_off,
+	    a_width = cur->es->indent_width,
+	    c_off = l->indent_off,
+	    c_width = l->indent_width;
+	int delta;
 
 	/*
 	 * We need to check if 'cur' is equal to 'match'.  As those
@@ -848,35 +877,20 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	if (al != bl)
 		return 1;
 
-	if (!pmb->wsd.string)
-		/*
-		 * The white space delta is not active? This can happen
-		 * when we exit early in this function.
-		 */
-		return 1;
-
 	/*
-	 * The indent changes of the block are known and stored in
-	 * pmb->wsd; however we need to check if the indent changes of the
-	 * current line are still the same as before.
-	 *
-	 * To do so we need to compare 'l' to 'cur', adjusting the
-	 * one of them for the white spaces, depending which was longer.
+	 * The indent changes of the block are known and stored in pmb->wsd;
+	 * however we need to check if the indent changes of the current line
+	 * match those of the current block and that the text of 'l' and 'cur'
+	 * after the indentation match.
 	 */
+	if (cur->es->s == DIFF_SYMBOL_PLUS)
+		delta = a_width - c_width;
+	else
+		delta = c_width - a_width;
 
-	wslen = strlen(pmb->wsd.string);
-	if (pmb->wsd.current_longer) {
-		c += wslen;
-		cl -= wslen;
-	} else {
-		a += wslen;
-		al -= wslen;
-	}
-
-	if (al != cl || memcmp(orig_a, b, bl) || memcmp(a, c, al))
-		return 1;
-
-	return 0;
+	return !(delta == pmb->wsd && al - a_off == cl - c_off &&
+		 !memcmp(a, b, al) && !
+		 memcmp(a + a_off, c + c_off, al - a_off));
 }
 
 static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
@@ -942,6 +956,9 @@ static void add_lines_to_move_detection(struct diff_options *o,
 			continue;
 		}
 
+		if (o->color_moved_ws_handling &
+		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+			fill_es_indent_data(&o->emitted_symbols->buf[n]);
 		key = prepare_entry(o, n);
 		if (prev_line && prev_line->es->s == o->emitted_symbols->buf[n].s)
 			prev_line->next_line = key;
@@ -1020,8 +1037,7 @@ static int shrink_potential_moved_blocks(struct moved_block *pmb,
 
 		if (lp < pmb_nr && rp > -1 && lp < rp) {
 			pmb[lp] = pmb[rp];
-			pmb[rp].match = NULL;
-			pmb[rp].wsd.string = NULL;
+			memset(&pmb[rp], 0, sizeof(pmb[rp]));
 			rp--;
 			lp++;
 		}
@@ -1141,7 +1157,7 @@ static void mark_color_as_moved(struct diff_options *o,
 							     &pmb[pmb_nr].wsd))
 						pmb[pmb_nr++].match = match;
 				} else {
-					pmb[pmb_nr].wsd.string = NULL;
+					pmb[pmb_nr].wsd = 0;
 					pmb[pmb_nr++].match = match;
 				}
 			}
@@ -1507,7 +1523,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len, unsigned flags)
 {
-	struct emitted_diff_symbol e = {line, len, flags, s};
+	struct emitted_diff_symbol e = {line, len, flags, 0, 0, s};
 
 	if (o->emitted_symbols)
 		append_emitted_diff_symbol(o, &e);
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index fe8a2ab06e..e023839ba6 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1901,4 +1901,60 @@ test_expect_success 'compare whitespace delta incompatible with other space opti
 	test_i18ngrep allow-indentation-change err
 '
 
+test_expect_success 'compare mixed whitespace delta across moved blocks' '
+
+	git reset --hard &&
+	tr Q_ "\t " <<-EOF >text.txt &&
+	____Indented text to
+	_Q____be further indented by four spaces across
+	____Qseveral lines
+	QQ____These two lines have had their
+	____indentation reduced by four spaces
+	Qdifferent indentation change
+	____too short
+	EOF
+
+	git add text.txt &&
+	git commit -m "add text.txt" &&
+
+	tr Q_ "\t " <<-EOF >text.txt &&
+	QIndented text to
+	QQbe further indented by four spaces across
+	Q____several lines
+	Q_QThese two lines have had their
+	indentation reduced by four spaces
+	QQdifferent indentation change
+	__Qtoo short
+	EOF
+
+	git -c color.diff.whitespace="normal red" \
+		-c core.whitespace=space-before-tab \
+		diff --color --color-moved --ws-error-highlight=all \
+		--color-moved-ws=allow-indentation-change >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
+
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/text.txt b/text.txt<RESET>
+	<BOLD>--- a/text.txt<RESET>
+	<BOLD>+++ b/text.txt<RESET>
+	<CYAN>@@ -1,7 +1,7 @@<RESET>
+	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>    Indented text to<RESET>
+	<BOLD;MAGENTA>-<RESET><BRED> <RESET>	<BOLD;MAGENTA>    be further indented by four spaces across<RESET>
+	<BOLD;MAGENTA>-<RESET><BRED>    <RESET>	<BOLD;MAGENTA>several lines<RESET>
+	<BOLD;BLUE>-<RESET>		<BOLD;BLUE>    These two lines have had their<RESET>
+	<BOLD;BLUE>-<RESET><BOLD;BLUE>    indentation reduced by four spaces<RESET>
+	<BOLD;MAGENTA>-<RESET>	<BOLD;MAGENTA>different indentation change<RESET>
+	<RED>-<RESET><RED>    too short<RESET>
+	<BOLD;CYAN>+<RESET>	<BOLD;CYAN>Indented text to<RESET>
+	<BOLD;CYAN>+<RESET>		<BOLD;CYAN>be further indented by four spaces across<RESET>
+	<BOLD;CYAN>+<RESET>	<BOLD;CYAN>    several lines<RESET>
+	<BOLD;YELLOW>+<RESET>	<BRED> <RESET>	<BOLD;YELLOW>These two lines have had their<RESET>
+	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>indentation reduced by four spaces<RESET>
+	<BOLD;CYAN>+<RESET>		<BOLD;CYAN>different indentation change<RESET>
+	<GREEN>+<RESET><BRED>  <RESET>	<GREEN>too short<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
-- 
2.19.1.1690.g258b440b18

