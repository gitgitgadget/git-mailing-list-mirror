Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58DD1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 11:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389600AbeKPVQL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 16:16:11 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:2587 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeKPVQK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 16:16:10 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id NbuxgXotudJAeNbv6gYs2F; Fri, 16 Nov 2018 11:04:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542366256;
        bh=Ybb2WxuG9R6AQpZe/70h95LQM8DXSfowrxXxs8QshCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Ufzal6plxu1U2ArXddIEo9CHlQpctFA6ZDdaEc4Ol6ZiEFoFRFmoBeMVcnQgvW1OH
         SIqtR51GzGYoZT2n7A1N0bG8HzL34aWwtrLV6HHy0x0UTnI3+rpyas2GOozR3TG00r
         14DtxUN/R+ncCDv7qKU40zgnl2j3a0zsuqWrFNs4=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=Nbu-zAE6nu2wUbsJxWQA:9
 a=1d2RWCUnR49FZvp_:21 a=HjStBrHOCDc9-LPD:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 9/9] diff --color-moved-ws: handle blank lines
Date:   Fri, 16 Nov 2018 11:03:56 +0000
Message-Id: <20181116110356.12311-10-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116110356.12311-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJvPkpcYyVkhsfTtLK+MfomBFfXPkZE80XBtYVvu5wVZtVwL6rv6BGnV+nGgdGphA0F/lw9DZrYUk62QCRlZ6nGJINizwnuhKjd2LL41cxc86AGWe4l4
 yc34IfeIy0Iv3esO5fg+h7mnTV3+5Es21VuezncTqqE+jNZ3YF8/I8vw0GpkcERC+LVWmR9hINz6BusA6fjO/og0X/t8g/oGgdgaUApoR7KCXX/t37vUkLYC
 v0zGIk53aq+WFqHshKQUWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When using --color-moved-ws=allow-indentation-change allow lines with
the same indentation change to be grouped across blank lines. For now
this only works if the blank lines have been moved as well, not for
blocks that have just had their indentation changed.

This completes the changes to the implementation of
--color-moved=allow-indentation-change. Running

  git diff --color-moved=allow-indentation-change v2.18.0 v2.19.0

now takes 5.0s. This is a saving of 41% from 8.5s for the optimized
version of the previous implementation and 66% from the original which
took 14.6s.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    Changes since rfc:
     - Split these changes into a separate commit.
     - Detect blank lines when processing the indentation rather than
       parsing each line twice.
     - Tweaked the test to make it harder as suggested by Stefan.
     - Added timing data to the commit message.

 diff.c                     | 34 ++++++++++++++++++++++++++++---
 t/t4015-diff-whitespace.sh | 41 ++++++++++++++++++++++++++++++++++----
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 89559293e7..072b5bced6 100644
--- a/diff.c
+++ b/diff.c
@@ -792,9 +792,11 @@ static void moved_block_clear(struct moved_block *b)
 	memset(b, 0, sizeof(*b));
 }
 
+#define INDENT_BLANKLINE INT_MIN
+
 static void fill_es_indent_data(struct emitted_diff_symbol *es)
 {
-	unsigned int off = 0;
+	unsigned int off = 0, i;
 	int width = 0, tab_width = es->flags & WS_TAB_WIDTH_MASK;
 	const char *s = es->line;
 	const int len = es->len;
@@ -818,8 +820,18 @@ static void fill_es_indent_data(struct emitted_diff_symbol *es)
 		}
 	}
 
-	es->indent_off = off;
-	es->indent_width = width;
+	/* check if this line is blank */
+	for (i = off; i < len; i++)
+		if (!isspace(s[i]))
+		    break;
+
+	if (i == len) {
+		es->indent_width = INDENT_BLANKLINE;
+		es->indent_off = len;
+	} else {
+		es->indent_off = off;
+		es->indent_width = width;
+	}
 }
 
 static int compute_ws_delta(const struct emitted_diff_symbol *a,
@@ -834,6 +846,11 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 	    b_width = b->indent_width;
 	int delta;
 
+	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE) {
+		*out = INDENT_BLANKLINE;
+		return 1;
+	}
+
 	if (a->s == DIFF_SYMBOL_PLUS)
 		delta = a_width - b_width;
 	else
@@ -877,6 +894,10 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	if (al != bl)
 		return 1;
 
+	/* If 'l' and 'cur' are both blank then they match. */
+	if (a_width == INDENT_BLANKLINE && c_width == INDENT_BLANKLINE)
+		return 0;
+
 	/*
 	 * The indent changes of the block are known and stored in pmb->wsd;
 	 * however we need to check if the indent changes of the current line
@@ -888,6 +909,13 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	else
 		delta = c_width - a_width;
 
+	/*
+	 * If the previous lines of this block were all blank then set its
+	 * whitespace delta.
+	 */
+	if (pmb->wsd == INDENT_BLANKLINE)
+		pmb->wsd = delta;
+
 	return !(delta == pmb->wsd && al - a_off == cl - c_off &&
 		 !memcmp(a, b, al) && !
 		 memcmp(a + a_off, c + c_off, al - a_off));
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index e023839ba6..9d6f88b07f 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1901,10 +1901,20 @@ test_expect_success 'compare whitespace delta incompatible with other space opti
 	test_i18ngrep allow-indentation-change err
 '
 
+EMPTY=''
 test_expect_success 'compare mixed whitespace delta across moved blocks' '
 
 	git reset --hard &&
 	tr Q_ "\t " <<-EOF >text.txt &&
+	${EMPTY}
+	____too short without
+	${EMPTY}
+	___being grouped across blank line
+	${EMPTY}
+	context
+	lines
+	to
+	anchor
 	____Indented text to
 	_Q____be further indented by four spaces across
 	____Qseveral lines
@@ -1918,9 +1928,18 @@ test_expect_success 'compare mixed whitespace delta across moved blocks' '
 	git commit -m "add text.txt" &&
 
 	tr Q_ "\t " <<-EOF >text.txt &&
+	context
+	lines
+	to
+	anchor
 	QIndented text to
 	QQbe further indented by four spaces across
 	Q____several lines
+	${EMPTY}
+	QQtoo short without
+	${EMPTY}
+	Q_______being grouped across blank line
+	${EMPTY}
 	Q_QThese two lines have had their
 	indentation reduced by four spaces
 	QQdifferent indentation change
@@ -1937,7 +1956,16 @@ test_expect_success 'compare mixed whitespace delta across moved blocks' '
 	<BOLD>diff --git a/text.txt b/text.txt<RESET>
 	<BOLD>--- a/text.txt<RESET>
 	<BOLD>+++ b/text.txt<RESET>
-	<CYAN>@@ -1,7 +1,7 @@<RESET>
+	<CYAN>@@ -1,16 +1,16 @@<RESET>
+	<BOLD;MAGENTA>-<RESET>
+	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>    too short without<RESET>
+	<BOLD;MAGENTA>-<RESET>
+	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>   being grouped across blank line<RESET>
+	<BOLD;MAGENTA>-<RESET>
+	 <RESET>context<RESET>
+	 <RESET>lines<RESET>
+	 <RESET>to<RESET>
+	 <RESET>anchor<RESET>
 	<BOLD;MAGENTA>-<RESET><BOLD;MAGENTA>    Indented text to<RESET>
 	<BOLD;MAGENTA>-<RESET><BRED> <RESET>	<BOLD;MAGENTA>    be further indented by four spaces across<RESET>
 	<BOLD;MAGENTA>-<RESET><BRED>    <RESET>	<BOLD;MAGENTA>several lines<RESET>
@@ -1948,9 +1976,14 @@ test_expect_success 'compare mixed whitespace delta across moved blocks' '
 	<BOLD;CYAN>+<RESET>	<BOLD;CYAN>Indented text to<RESET>
 	<BOLD;CYAN>+<RESET>		<BOLD;CYAN>be further indented by four spaces across<RESET>
 	<BOLD;CYAN>+<RESET>	<BOLD;CYAN>    several lines<RESET>
-	<BOLD;YELLOW>+<RESET>	<BRED> <RESET>	<BOLD;YELLOW>These two lines have had their<RESET>
-	<BOLD;YELLOW>+<RESET><BOLD;YELLOW>indentation reduced by four spaces<RESET>
-	<BOLD;CYAN>+<RESET>		<BOLD;CYAN>different indentation change<RESET>
+	<BOLD;YELLOW>+<RESET>
+	<BOLD;YELLOW>+<RESET>		<BOLD;YELLOW>too short without<RESET>
+	<BOLD;YELLOW>+<RESET>
+	<BOLD;YELLOW>+<RESET>	<BOLD;YELLOW>       being grouped across blank line<RESET>
+	<BOLD;YELLOW>+<RESET>
+	<BOLD;CYAN>+<RESET>	<BRED> <RESET>	<BOLD;CYAN>These two lines have had their<RESET>
+	<BOLD;CYAN>+<RESET><BOLD;CYAN>indentation reduced by four spaces<RESET>
+	<BOLD;YELLOW>+<RESET>		<BOLD;YELLOW>different indentation change<RESET>
 	<GREEN>+<RESET><BRED>  <RESET>	<GREEN>too short<RESET>
 	EOF
 
-- 
2.19.1

