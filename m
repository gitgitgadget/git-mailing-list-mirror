Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EBF61F453
	for <e@80x24.org>; Mon, 24 Sep 2018 10:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbeIXQHn (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 12:07:43 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:23140 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbeIXQHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 12:07:42 -0400
Received: from lindisfarne.localdomain ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id 4NkrgLWW7VlGZ4Nl0gJ4t2; Mon, 24 Sep 2018 11:06:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1537783583;
        bh=HspFNSLmTDRGUrPImNysDWU/diDc37DQMBhOEACKGA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=eftOTc7bliLsNkadGEP7kfIHF6Py2Yw38fRYRYxL+62hMnZpw8riNYz4R1syK+wFB
         51T+HADsF7x5wNilIALO0ysmANZzLcJyOcXuMQRxKGo4u+Ii9OxBgEFk811htybxJo
         Tb4RdRGMqrz9LvEVOFO0296/lK4oLB6FshqAvN3Y=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=evINK-nbAAAA:8 a=5rxgeBVgAAAA:8
 a=pGLkceISAAAA:8 a=nyiV9DaaKwamI5fiTRwA:9 a=wxDFKLatdRnlK-lf:21
 a=8b6LPyszy7AXvmLs:21 a=RfR_gqz1fSpA9VikTjo0:22 a=PwKx63F5tFurRwaNxrlG:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 3/3] diff: add --color-moved-ws=allow-mixed-indentation-change
Date:   Mon, 24 Sep 2018 11:06:04 +0100
Message-Id: <20180924100604.32208-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924100604.32208-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEyWkvXXvy2UcBteCOwm0JwwEjZ0yNQ/aPlviE4NeEcNZxaB3qmP/opcx/2XjvTyRzYFePt8AOzlZPULFljcMUSqyODtbbSAv/JXRVRIppd9QG9fO7Lr
 XI8lxBMPO33INqW0L9RZBDGF4qiAj1rbjEOURpQOKusnVJO8PTwV026ZSqBAsdMTDALYeiNECLSLfMdOW7wt4gTyjFGvlBQSqMUERfVOCYnbUl4hGhmUdS9N
 XprGpAmFtTSO+dQ5D/r5DQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This adds another mode for highlighting lines that have moved with an
indentation change. Unlike the existing
--color-moved-ws=allow-indentation-change setting this mode uses the
visible change in the indentation to group lines, rather than the
indentation string. This means it works with files that use a mix of
tabs and spaces for indentation and can cope with whitespace errors
where there is a space before a tab (it's the job of
--ws-error-highlight to deal with those errors, it should affect the
move detection). It will also group the lines either
side of a blank line if their indentation change matches so short
lines followed by a blank line followed by more lines with the same
indentation change will be correctly highlighted.

This is a RFC as there are a number of questions about how to proceed
from here:
 1) Do we need a second option or should this implementation replace
    --color-moved-ws=allow-indentation-change. I'm unclear if that mode
    has any advantages for some people. There seems to have been an
    intention [1] to get it working with mixes of tabs and spaces but
    nothing ever came of it.
 2) If we keep two options what should this option be called, the name
    is long and ambiguous at the moment - mixed could refer to mixed
    indentation length rather than a mix of tabs and spaces.
 3) Should we support whitespace flags with this mode?
    --ignore-space-at-eol and --ignore-cr-at eol would be fairly simple
    to support and I can see a use for them, --ignore-all-space and
    --ignore-space-change would need some changes to xdiff to allow them
    to apply only after the indentation. I think --ignore-blank-lines
    would need a bit of work to get it working as well. (Note the
    existing mode does not support any of these flags either)

[1] https://public-inbox.org/git/CAGZ79kasAqE+=7ciVrdjoRdu0UFjVBr8Ma502nw+3hZL=ebXYQ@mail.gmail.com/

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c                     | 122 +++++++++++++++++++++++++++++++++----
 diff.h                     |   1 +
 t/t4015-diff-whitespace.sh |  89 +++++++++++++++++++++++++++
 3 files changed, 199 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index 0a652e28d4..45f33daa60 100644
--- a/diff.c
+++ b/diff.c
@@ -304,7 +304,11 @@ static int parse_color_moved_ws(const char *arg)
 		else if (!strcmp(sb.buf, "ignore-all-space"))
 			ret |= XDF_IGNORE_WHITESPACE;
 		else if (!strcmp(sb.buf, "allow-indentation-change"))
-			ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
+			ret = COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE |
+			 (ret & ~COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE);
+		else if (!strcmp(sb.buf, "allow-mixed-indentation-change"))
+			ret = COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE |
+			 (ret & ~COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE);
 		else
 			error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
 
@@ -314,6 +318,9 @@ static int parse_color_moved_ws(const char *arg)
 	if ((ret & COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) &&
 	    (ret & XDF_WHITESPACE_FLAGS))
 		die(_("color-moved-ws: allow-indentation-change cannot be combined with other white space modes"));
+	else if ((ret & COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE) &&
+		 (ret & XDF_WHITESPACE_FLAGS))
+		die(_("color-moved-ws: allow-mixed-indentation-change cannot be combined with other white space modes"));
 
 	string_list_clear(&l, 0);
 
@@ -763,11 +770,65 @@ struct moved_entry {
  * comparision is longer than the second.
  */
 struct ws_delta {
-	char *string;
+	union {
+		int delta;
+		char *string;
+	};
 	unsigned int current_longer : 1;
+	unsigned int have_string : 1;
 };
 #define WS_DELTA_INIT { NULL, 0 }
 
+static int compute_mixed_ws_delta(const struct emitted_diff_symbol *a,
+				  const struct emitted_diff_symbol *b,
+				  int *delta)
+{
+	unsigned int i = 0, j = 0;
+	int la, lb;
+	int ta = a->flags & WS_TAB_WIDTH_MASK;
+	int tb = b->flags & WS_TAB_WIDTH_MASK;
+	const char *sa = a->line;
+	const char *sb = b->line;
+
+	if (xdiff_is_blankline(sa, a->len, 0) &&
+	    xdiff_is_blankline(sb, b->len, 0)) {
+		*delta = INT_MIN;
+		return 1;
+	}
+
+	/* skip any \v \f \r at start of indentation */
+	while (sa[i] == '\f' || sa[i] == '\v' ||
+	       (sa[i] == '\r' && i < a->len - 1))
+		i++;
+	while (sb[j] == '\f' || sb[j] == '\v' ||
+	       (sb[j] == '\r' && j < b->len - 1))
+		j++;
+
+	for (la = 0; ; i++) {
+		if (sa[i] == ' ')
+			la++;
+		else if (sa[i] == '\t')
+			la = ((la + ta) / ta) * ta;
+		else
+			break;
+	}
+	for (lb = 0; ; j++) {
+		if (sb[j] == ' ')
+			lb++;
+		else if (sb[j] == '\t')
+			lb = ((lb + tb) / tb) * tb;
+		else
+			break;
+	}
+	if (a->s == DIFF_SYMBOL_PLUS)
+		*delta = la - lb;
+	else
+		*delta = lb - la;
+
+	return (a->len - i == b->len - j) &&
+		!memcmp(sa + i, sb + j, a->len - i);
+}
+
 static int compute_ws_delta(const struct emitted_diff_symbol *a,
 			     const struct emitted_diff_symbol *b,
 			     struct ws_delta *out)
@@ -778,6 +839,7 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 
 	out->string = xmemdupz(longer->line, d);
 	out->current_longer = (a == longer);
+	out->have_string = 1;
 
 	return !strncmp(longer->line + d, shorter->line, shorter->len);
 }
@@ -820,15 +882,34 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	 * To do so we need to compare 'l' to 'cur', adjusting the
 	 * one of them for the white spaces, depending which was longer.
 	 */
+	if (o->color_moved_ws_handling &
+	    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) {
+		wslen = strlen(pmb->wsd->string);
+		if (pmb->wsd->current_longer)
+			c += wslen;
+		else
+			a += wslen;
 
-	wslen = strlen(pmb->wsd->string);
-	if (pmb->wsd->current_longer)
-		c += wslen;
-	else
-		a += wslen;
+		if (strcmp(a, c))
+			return 1;
 
-	if (strcmp(a, c))
-		return 1;
+		return 0;
+	} else if (o->color_moved_ws_handling &
+		   COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE) {
+		int delta;
+
+		if (!compute_mixed_ws_delta(cur->es, l, &delta))
+		    return 1;
+
+		if (pmb->wsd->delta == INT_MIN) {
+			pmb->wsd->delta = delta;
+			return 0;
+		}
+
+		return !(delta == pmb->wsd->delta || delta == INT_MIN);
+	} else {
+		BUG("no color_moved_ws_allow_indentation_change set");
+	}
 
 	return 0;
 }
@@ -845,7 +926,8 @@ static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
 			 & XDF_WHITESPACE_FLAGS;
 
 	if (diffopt->color_moved_ws_handling &
-	    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+	    (COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE |
+	     COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE))
 		/*
 		 * As there is not specific white space config given,
 		 * we'd need to check for a new block, so ignore all
@@ -953,7 +1035,8 @@ static void pmb_advance_or_null_multi_match(struct diff_options *o,
 			pmb[i] = pmb[i]->next_line;
 		} else {
 			if (pmb[i]->wsd) {
-				free(pmb[i]->wsd->string);
+				if (pmb[i]->wsd->have_string)
+					free(pmb[i]->wsd->string);
 				FREE_AND_NULL(pmb[i]->wsd);
 			}
 			pmb[i] = NULL;
@@ -1066,7 +1149,8 @@ static void mark_color_as_moved(struct diff_options *o,
 			continue;
 
 		if (o->color_moved_ws_handling &
-		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+		    (COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE |
+		     COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE))
 			pmb_advance_or_null_multi_match(o, match, hm, pmb, pmb_nr, n);
 		else
 			pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
@@ -1088,6 +1172,17 @@ static void mark_color_as_moved(struct diff_options *o,
 						pmb[pmb_nr++] = match;
 					} else
 						free(wsd);
+				} else if (o->color_moved_ws_handling &
+					   COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE) {
+					int delta;
+
+					if (compute_mixed_ws_delta(l, match->es, &delta)) {
+						struct ws_delta *wsd = xmalloc(sizeof(*match->wsd));
+						wsd->delta = delta;
+						wsd->have_string = 0;
+						match->wsd = wsd;
+						pmb[pmb_nr++] = match;
+					}
 				} else {
 					pmb[pmb_nr++] = match;
 				}
@@ -5740,7 +5835,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 			struct hashmap add_lines, del_lines;
 
 			if (o->color_moved_ws_handling &
-			    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
+			    (COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE |
+			     COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE))
 				o->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE;
 
 			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
diff --git a/diff.h b/diff.h
index 5e6bcf0926..03628cda45 100644
--- a/diff.h
+++ b/diff.h
@@ -217,6 +217,7 @@ struct diff_options {
 
 	/* XDF_WHITESPACE_FLAGS regarding block detection are set at 2, 3, 4 */
 	#define COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE (1<<5)
+	#define COLOR_MOVED_WS_ALLOW_MIXED_INDENTATION_CHANGE (1<<6)
 	int color_moved_ws_handling;
 };
 
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 41facf7abf..737dbd4a42 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1902,4 +1902,93 @@ test_expect_success 'compare whitespace delta incompatible with other space opti
 	test_i18ngrep allow-indentation-change err
 '
 
+NUL=''
+test_expect_success 'compare mixed whitespace delta across moved blocks' '
+
+	git reset --hard &&
+	tr Q_ "\t " <<-EOF >text.txt &&
+	${NUL}
+	____too short without
+	${NUL}
+	____being grouped across blank line
+	${NUL}
+	context
+	lines
+	to
+	anchor
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
+	context
+	lines
+	to
+	anchor
+	QIndented text to
+	QQbe further indented by four spaces across
+	Q____several lines
+	${NUL}
+	QQtoo short without
+	${NUL}
+	QQbeing grouped across blank line
+	${NUL}
+	Q_QThese two lines have had their
+	indentation reduced by four spaces
+	QQdifferent indentation change
+	__Qtoo short
+	EOF
+
+	git -c color.diff.whitespace="normal red" \
+		-c core.whitespace=space-before-tab \
+		diff --color --color-moved --ws-error-highlight=all \
+		--color-moved-ws=allow-mixed-indentation-change >actual.raw &&
+	grep -v "index" actual.raw | test_decode_color >actual &&
+
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/text.txt b/text.txt<RESET>
+	<BOLD>--- a/text.txt<RESET>
+	<BOLD>+++ b/text.txt<RESET>
+	<CYAN>@@ -1,16 +1,16 @@<RESET>
+	<BOLD;MAGENTA>-<RESET>
+	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>    too short without<RESET>
+	<BOLD;MAGENTA>-<RESET>
+	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>    being grouped across blank line<RESET>
+	<BOLD;MAGENTA>-<RESET>
+	 <RESET>context<RESET>
+	 <RESET>lines<RESET>
+	 <RESET>to<RESET>
+	 <RESET>anchor<RESET>
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
+	<BOLD;YELLOW>+<RESET>
+	<BOLD;YELLOW>+<RESET>		<BOLD;YELLOW>too short without<RESET>
+	<BOLD;YELLOW>+<RESET>
+	<BOLD;YELLOW>+<RESET>		<BOLD;YELLOW>being grouped across blank line<RESET>
+	<BOLD;YELLOW>+<RESET>
+	<BOLD;CYAN>+<RESET>	<BRED> <RESET>	<BOLD;CYAN>These two lines have had their<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>indentation reduced by four spaces<RESET>
+	<BOLD;YELLOW>+<RESET>		<BOLD;YELLOW>different indentation change<RESET>
+	<GREEN>+<RESET><BRED>  <RESET>	<GREEN>too short<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
-- 
2.19.0

