Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC7C01F85B
	for <e@80x24.org>; Tue, 10 Jul 2018 21:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbeGJVzs (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 17:55:48 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:49786 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732274AbeGJVzs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 17:55:48 -0400
Received: by mail-qt0-f201.google.com with SMTP id b8-v6so22443121qto.16
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=KpBfc8futXpj0osbqTlPOvZF+kE88GiTJ5zE6TFYiWo=;
        b=R1pJnLJX27bolCekgIONBuUWLToQgyILEnSI5QhKpxMrUlXQs0fXTzSvKgxGY0eF46
         qK2yrEotBbEAfcMO5SHOgYzFmIHbk9MlS7ZX4F1vCrY1uwsIfVAqCzUHAKT2DWFBSZTG
         f+ZC9BN0K+Dsr1dvNK9JUV64yazWCHff1WkfMINjUV70rlsfOr9DJIrPpNdKhpMA52iQ
         GjBxJgGn5jSORk59DXm+q/K68rZM/SMZgCH3JRExxBOcjBOjT5kIA/56yO4udpy4rOqr
         rWfL7/X221gLrYTEYs0ccXW0kw4TugJwA14qmau2d+kcR4ONBNT7MayflV8anmV/26SM
         0UCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=KpBfc8futXpj0osbqTlPOvZF+kE88GiTJ5zE6TFYiWo=;
        b=UtMRB5qOl1L9iuGoXHoSap9MgNE2vTNnSIulvGFzNV9g1Xmb2Z8sH0gXRMa66tt/l+
         /nu7ROfDuZ9JA5ImmyO/jixhZZZW76dz+X2Zid98jNwfzQSWOf+12HnMxGndKn3zIx7L
         gVyxvK4rtZw1PS28HlANmhyGNq4pNKvEWrolvRxsBHqlpHTdXqCW4HGq4cdbXaCcApQE
         +pikYJR0D0TwIvH/agx/PhdsjptpbY+LBMog1QG5GClvsAqCUBFbHZSLaQWNscxzf2zG
         dVFS6J2g9gFTN/Dx3VTkrl2GMGKG06JpmsY2oRvRnLDvda4jYJRAyKzJszpGSnJv8/xs
         KiHQ==
X-Gm-Message-State: APt69E2Ru+D9qIPl333bvoI+XU4CF679HR7nl98GVqKBtf5TrCJ9/eYw
        daRzsczNFwvKb1fVoAO+ocxptc+kDbRb
X-Google-Smtp-Source: AAOMgpcxEwjWVNVX28CtueqZSPHT1mTIpSWxLq3rf8K8aGOSYNYBlCYHSMZobxqS0gv+2di8sRzyyWbYqom2
MIME-Version: 1.0
X-Received: by 2002:ac8:2758:: with SMTP id h24-v6mr15458518qth.39.1531259683695;
 Tue, 10 Jul 2018 14:54:43 -0700 (PDT)
Date:   Tue, 10 Jul 2018 14:54:37 -0700
In-Reply-To: <20180710195921.131548-1-sbeller@google.com>
Message-Id: <20180710215437.33904-1-sbeller@google.com>
References: <20180710195921.131548-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] ws: do not reset and set color twice
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When outputting lines that are checked for white space, we first use
emit_line_0 to emit the prefix, and then the ws specific code. The code
at each site carefully sets the color and then resets it, though it is
the same color.

Avoid setting the color twice by passing a newly introduced flag that
indicates if the color is already set.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

  The whole series is also available via
  git fetch http://github.com/stefanbeller/git ws_cleanup-ontop-range-diff
  and concludes my cleanup on top of the range-diff series for now.
  
  What is left is to refactor the diff-diff from the range-diff series
  to utilize the marker at the beginning of the line that can be more than
  one character. I left that as I do not want to collide with your work.
  
  Thanks,
  Stefan
  

 cache.h                    |   2 +-
 diff.c                     |   8 +--
 t/t4015-diff-whitespace.sh | 122 ++++++++++++++++++-------------------
 ws.c                       |  28 +++++++--
 4 files changed, 89 insertions(+), 71 deletions(-)

diff --git a/cache.h b/cache.h
index d49092d94d1..8f53a65fa36 100644
--- a/cache.h
+++ b/cache.h
@@ -1807,7 +1807,7 @@ extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
 extern unsigned ws_check(const char *line, int len, unsigned ws_rule);
-extern void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws);
+extern void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws, int already_set);
 extern char *whitespace_error_string(unsigned ws);
 extern void ws_fix_copy(struct strbuf *, const char *, int, unsigned, int *);
 extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
diff --git a/diff.c b/diff.c
index 0b00df7b3c8..34d02f4095b 100644
--- a/diff.c
+++ b/diff.c
@@ -993,11 +993,11 @@ static void emit_line_ws_markup(struct diff_options *o,
 		/* Blank line at EOF - paint '+' as well */
 		emit_line_0(o, ws, set_sign, reset, sign, line, len);
 	else {
-		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set, set_sign, reset,
+		/* Emit just the prefix (with no RESET), then the rest. */
+		emit_line_0(o, set, set_sign, NULL,
 			    sign, "", 0);
 		ws_check_emit(line, len, ws_rule,
-			      o->file, set, reset, ws);
+			      o->file, set, reset, ws, 1);
 	}
 }
 
@@ -2918,7 +2918,7 @@ static void checkdiff_consume(void *priv, char *line, unsigned long len)
 		free(err);
 		emit_line(data->o, set, reset, line, 1);
 		ws_check_emit(line + 1, len - 1, data->ws_rule,
-			      data->o->file, set, reset, ws);
+			      data->o->file, set, reset, ws, 0);
 	} else if (line[0] == ' ') {
 		data->lineno++;
 	} else if (line[0] == '@') {
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 95baf237a83..8834f2040c0 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -874,9 +874,9 @@ test_expect_success 'diff that introduces a line with only tabs' '
 	<BOLD>+++ b/x<RESET>
 	<CYAN>@@ -1 +1,4 @@<RESET>
 	 test<RESET>
-	<GREEN>+<RESET><GREEN>{<RESET>
+	<GREEN>+{<RESET>
 	<GREEN>+<RESET><BLUE>	<RESET>
-	<GREEN>+<RESET><GREEN>}<RESET>
+	<GREEN>+}<RESET>
 	EOF
 
 	test_cmp expected current
@@ -906,8 +906,8 @@ test_expect_success 'diff that introduces and removes ws breakages' '
 	<CYAN>@@ -1,2 +1,3 @@<RESET>
 	 0. blank-at-eol <RESET>
 	<RED>-1. blank-at-eol <RESET>
-	<GREEN>+<RESET><GREEN>1. still-blank-at-eol<RESET><BLUE> <RESET>
-	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
+	<GREEN>+1. still-blank-at-eol<RESET><BLUE> <RESET>
+	<GREEN>+2. and a new line<RESET><BLUE> <RESET>
 	EOF
 
 	test_cmp expected current
@@ -934,9 +934,9 @@ test_expect_success 'ws-error-highlight test setup' '
 	<BOLD>+++ b/x<RESET>
 	<CYAN>@@ -1,2 +1,3 @@<RESET>
 	 0. blank-at-eol <RESET>
-	<RED>-<RESET><RED>1. blank-at-eol<RESET><BLUE> <RESET>
-	<GREEN>+<RESET><GREEN>1. still-blank-at-eol<RESET><BLUE> <RESET>
-	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
+	<RED>-1. blank-at-eol<RESET><BLUE> <RESET>
+	<GREEN>+1. still-blank-at-eol<RESET><BLUE> <RESET>
+	<GREEN>+2. and a new line<RESET><BLUE> <RESET>
 	EOF
 
 	cat >expect.all <<-\EOF &&
@@ -946,9 +946,9 @@ test_expect_success 'ws-error-highlight test setup' '
 	<BOLD>+++ b/x<RESET>
 	<CYAN>@@ -1,2 +1,3 @@<RESET>
 	 0. blank-at-eol<RESET><BLUE> <RESET>
-	<RED>-<RESET><RED>1. blank-at-eol<RESET><BLUE> <RESET>
-	<GREEN>+<RESET><GREEN>1. still-blank-at-eol<RESET><BLUE> <RESET>
-	<GREEN>+<RESET><GREEN>2. and a new line<RESET><BLUE> <RESET>
+	<RED>-1. blank-at-eol<RESET><BLUE> <RESET>
+	<GREEN>+1. still-blank-at-eol<RESET><BLUE> <RESET>
+	<GREEN>+2. and a new line<RESET><BLUE> <RESET>
 	EOF
 
 	cat >expect.none <<-\EOF
@@ -1038,11 +1038,11 @@ test_expect_success 'detect moved code, complete file' '
 	<BOLD>--- /dev/null<RESET>
 	<BOLD>+++ b/main.c<RESET>
 	<CYAN>@@ -0,0 +1,5 @@<RESET>
-	<BGREEN>+<RESET><BGREEN>#include<stdio.h><RESET>
-	<BGREEN>+<RESET><BGREEN>main()<RESET>
-	<BGREEN>+<RESET><BGREEN>{<RESET>
-	<BGREEN>+<RESET><BGREEN>printf("Hello World");<RESET>
-	<BGREEN>+<RESET><BGREEN>}<RESET>
+	<BGREEN>+#include<stdio.h><RESET>
+	<BGREEN>+main()<RESET>
+	<BGREEN>+{<RESET>
+	<BGREEN>+printf("Hello World");<RESET>
+	<BGREEN>+}<RESET>
 	<BOLD>diff --git a/test.c b/test.c<RESET>
 	<BOLD>deleted file mode 100644<RESET>
 	<BOLD>index a986c57..0000000<RESET>
@@ -1159,12 +1159,12 @@ test_expect_success 'detect malicious moved code, inside file' '
 	 printf("Hello World, but different\n");<RESET>
 	 }<RESET>
 	 
-	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
-	<BGREEN>+<RESET><BGREEN>{<RESET>
-	<GREEN>+<RESET><GREEN>foo(u);<RESET>
-	<BGREEN>+<RESET><BGREEN>if (!u->is_allowed_foo)<RESET>
-	<BGREEN>+<RESET><BGREEN>return;<RESET>
-	<GREEN>+<RESET><GREEN>}<RESET>
+	<BGREEN>+int secure_foo(struct user *u)<RESET>
+	<BGREEN>+{<RESET>
+	<GREEN>+foo(u);<RESET>
+	<BGREEN>+if (!u->is_allowed_foo)<RESET>
+	<BGREEN>+return;<RESET>
+	<GREEN>+}<RESET>
 	<GREEN>+<RESET>
 	 int another_function()<RESET>
 	 {<RESET>
@@ -1208,12 +1208,12 @@ test_expect_success 'plain moved code, inside file' '
 	 printf("Hello World, but different\n");<RESET>
 	 }<RESET>
 	 
-	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
-	<BGREEN>+<RESET><BGREEN>{<RESET>
-	<BGREEN>+<RESET><BGREEN>foo(u);<RESET>
-	<BGREEN>+<RESET><BGREEN>if (!u->is_allowed_foo)<RESET>
-	<BGREEN>+<RESET><BGREEN>return;<RESET>
-	<BGREEN>+<RESET><BGREEN>}<RESET>
+	<BGREEN>+int secure_foo(struct user *u)<RESET>
+	<BGREEN>+{<RESET>
+	<BGREEN>+foo(u);<RESET>
+	<BGREEN>+if (!u->is_allowed_foo)<RESET>
+	<BGREEN>+return;<RESET>
+	<BGREEN>+}<RESET>
 	<BGREEN>+<RESET>
 	 int another_function()<RESET>
 	 {<RESET>
@@ -1288,12 +1288,12 @@ test_expect_success 'detect permutations inside moved code -- dimmed_zebra' '
 	 line 7<RESET>
 	 line 8<RESET>
 	 line 9<RESET>
-	<BCYAN>+<RESET><BCYAN>long line 1<RESET>
-	<BCYAN>+<RESET><BCYAN>long line 2<RESET>
-	<CYAN>+<RESET><CYAN>long line 3<RESET>
-	<YELLOW>+<RESET><YELLOW>long line 14<RESET>
-	<BYELLOW>+<RESET><BYELLOW>long line 15<RESET>
-	<BYELLOW>+<RESET><BYELLOW>long line 16<RESET>
+	<BCYAN>+long line 1<RESET>
+	<BCYAN>+long line 2<RESET>
+	<CYAN>+long line 3<RESET>
+	<YELLOW>+long line 14<RESET>
+	<BYELLOW>+long line 15<RESET>
+	<BYELLOW>+long line 16<RESET>
 	 line 10<RESET>
 	 line 11<RESET>
 	 line 12<RESET>
@@ -1332,12 +1332,12 @@ test_expect_success 'cmd option assumes configured colored-moved' '
 	 line 7<RESET>
 	 line 8<RESET>
 	 line 9<RESET>
-	<CYAN>+<RESET><CYAN>long line 1<RESET>
-	<CYAN>+<RESET><CYAN>long line 2<RESET>
-	<CYAN>+<RESET><CYAN>long line 3<RESET>
-	<YELLOW>+<RESET><YELLOW>long line 14<RESET>
-	<YELLOW>+<RESET><YELLOW>long line 15<RESET>
-	<YELLOW>+<RESET><YELLOW>long line 16<RESET>
+	<CYAN>+long line 1<RESET>
+	<CYAN>+long line 2<RESET>
+	<CYAN>+long line 3<RESET>
+	<YELLOW>+long line 14<RESET>
+	<YELLOW>+long line 15<RESET>
+	<YELLOW>+long line 16<RESET>
 	 line 10<RESET>
 	 line 11<RESET>
 	 line 12<RESET>
@@ -1467,10 +1467,10 @@ test_expect_success 'move detection ignoring whitespace changes' '
 	<BOLD>--- a/lines.txt<RESET>
 	<BOLD>+++ b/lines.txt<RESET>
 	<CYAN>@@ -1,9 +1,9 @@<RESET>
-	<GREEN>+<RESET><GREEN>long	line 6<RESET>
-	<GREEN>+<RESET><GREEN>long	line 7<RESET>
-	<GREEN>+<RESET><GREEN>long	line 8<RESET>
-	<GREEN>+<RESET><GREEN>long li	ne 9<RESET>
+	<GREEN>+long	line 6<RESET>
+	<GREEN>+long	line 7<RESET>
+	<GREEN>+long	line 8<RESET>
+	<GREEN>+long li	ne 9<RESET>
 	 line 1<RESET>
 	 line 2<RESET>
 	 line 3<RESET>
@@ -1491,10 +1491,10 @@ test_expect_success 'move detection ignoring whitespace changes' '
 	<BOLD>--- a/lines.txt<RESET>
 	<BOLD>+++ b/lines.txt<RESET>
 	<CYAN>@@ -1,9 +1,9 @@<RESET>
-	<CYAN>+<RESET><CYAN>long	line 6<RESET>
-	<CYAN>+<RESET><CYAN>long	line 7<RESET>
-	<CYAN>+<RESET><CYAN>long	line 8<RESET>
-	<GREEN>+<RESET><GREEN>long li	ne 9<RESET>
+	<CYAN>+long	line 6<RESET>
+	<CYAN>+long	line 7<RESET>
+	<CYAN>+long	line 8<RESET>
+	<GREEN>+long li	ne 9<RESET>
 	 line 1<RESET>
 	 line 2<RESET>
 	 line 3<RESET>
@@ -1534,10 +1534,10 @@ test_expect_success 'move detection ignoring whitespace at eol' '
 	<BOLD>--- a/lines.txt<RESET>
 	<BOLD>+++ b/lines.txt<RESET>
 	<CYAN>@@ -1,9 +1,9 @@<RESET>
-	<GREEN>+<RESET><GREEN>long line 6	<RESET>
-	<GREEN>+<RESET><GREEN>long line 7	<RESET>
-	<GREEN>+<RESET><GREEN>long line 8	<RESET>
-	<GREEN>+<RESET><GREEN>long	line 9	<RESET>
+	<GREEN>+long line 6	<RESET>
+	<GREEN>+long line 7	<RESET>
+	<GREEN>+long line 8	<RESET>
+	<GREEN>+long	line 9	<RESET>
 	 line 1<RESET>
 	 line 2<RESET>
 	 line 3<RESET>
@@ -1558,10 +1558,10 @@ test_expect_success 'move detection ignoring whitespace at eol' '
 	<BOLD>--- a/lines.txt<RESET>
 	<BOLD>+++ b/lines.txt<RESET>
 	<CYAN>@@ -1,9 +1,9 @@<RESET>
-	<CYAN>+<RESET><CYAN>long line 6	<RESET>
-	<CYAN>+<RESET><CYAN>long line 7	<RESET>
-	<CYAN>+<RESET><CYAN>long line 8	<RESET>
-	<GREEN>+<RESET><GREEN>long	line 9	<RESET>
+	<CYAN>+long line 6	<RESET>
+	<CYAN>+long line 7	<RESET>
+	<CYAN>+long line 8	<RESET>
+	<GREEN>+long	line 9	<RESET>
 	 line 1<RESET>
 	 line 2<RESET>
 	 line 3<RESET>
@@ -1605,7 +1605,7 @@ test_expect_success '--color-moved block at end of diff output respects MIN_ALNU
 	<BOLD>--- a/bar<RESET>
 	<BOLD>+++ b/bar<RESET>
 	<CYAN>@@ -0,0 +1 @@<RESET>
-	<GREEN>+<RESET><GREEN>line1<RESET>
+	<GREEN>+line1<RESET>
 	<BOLD>diff --git a/foo b/foo<RESET>
 	<BOLD>--- a/foo<RESET>
 	<BOLD>+++ b/foo<RESET>
@@ -1644,8 +1644,8 @@ test_expect_success '--color-moved respects MIN_ALNUM_COUNT' '
 	<BOLD>--- a/bar<RESET>
 	<BOLD>+++ b/bar<RESET>
 	<CYAN>@@ -0,0 +1,2 @@<RESET>
-	<BOLD;CYAN>+<RESET><BOLD;CYAN>twenty chars 234567890<RESET>
-	<GREEN>+<RESET><GREEN>nineteen chars 456789<RESET>
+	<BOLD;CYAN>+twenty chars 234567890<RESET>
+	<GREEN>+nineteen chars 456789<RESET>
 	<BOLD>diff --git a/foo b/foo<RESET>
 	<BOLD>--- a/foo<RESET>
 	<BOLD>+++ b/foo<RESET>
@@ -1685,9 +1685,9 @@ test_expect_success '--color-moved treats adjacent blocks as separate for MIN_AL
 	<BOLD>--- a/bar<RESET>
 	<BOLD>+++ b/bar<RESET>
 	<CYAN>@@ -0,0 +1,3 @@<RESET>
-	<GREEN>+<RESET><GREEN>7charsB<RESET>
-	<GREEN>+<RESET><GREEN>7charsC<RESET>
-	<GREEN>+<RESET><GREEN>7charsA<RESET>
+	<GREEN>+7charsB<RESET>
+	<GREEN>+7charsC<RESET>
+	<GREEN>+7charsA<RESET>
 	<BOLD>diff --git a/foo b/foo<RESET>
 	<BOLD>--- a/foo<RESET>
 	<BOLD>+++ b/foo<RESET>
diff --git a/ws.c b/ws.c
index a07caedd5a5..cb4a95c25dc 100644
--- a/ws.c
+++ b/ws.c
@@ -139,10 +139,19 @@ char *whitespace_error_string(unsigned ws)
 	return strbuf_detach(&err, NULL);
 }
 
+static inline void optional_reset(FILE *stream, const char *reset, int *already_set)
+{
+	if (*already_set) {
+		fputs(reset, stream);
+		*already_set = 0;
+	}
+}
+
 /* If stream is non-NULL, emits the line after checking. */
 static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 				FILE *stream, const char *set,
-				const char *reset, const char *ws)
+				const char *reset, const char *ws,
+				int already_set)
 {
 	unsigned result = 0;
 	int written = 0;
@@ -186,6 +195,7 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 		if ((ws_rule & WS_SPACE_BEFORE_TAB) && written < i) {
 			result |= WS_SPACE_BEFORE_TAB;
 			if (stream) {
+				optional_reset(stream, reset, &already_set);
 				fputs(ws, stream);
 				fwrite(line + written, i - written, 1, stream);
 				fputs(reset, stream);
@@ -194,12 +204,14 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 		} else if (ws_rule & WS_TAB_IN_INDENT) {
 			result |= WS_TAB_IN_INDENT;
 			if (stream) {
+				optional_reset(stream, reset, &already_set);
 				fwrite(line + written, i - written, 1, stream);
 				fputs(ws, stream);
 				fwrite(line + i, 1, 1, stream);
 				fputs(reset, stream);
 			}
 		} else if (stream) {
+			optional_reset(stream, reset, &already_set);
 			fwrite(line + written, i - written + 1, 1, stream);
 		}
 		written = i + 1;
@@ -209,6 +221,7 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 	if ((ws_rule & WS_INDENT_WITH_NON_TAB) && i - written >= ws_tab_width(ws_rule)) {
 		result |= WS_INDENT_WITH_NON_TAB;
 		if (stream) {
+			optional_reset(stream, reset, &already_set);
 			fputs(ws, stream);
 			fwrite(line + written, i - written, 1, stream);
 			fputs(reset, stream);
@@ -224,19 +237,24 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 
 		/* Emit non-highlighted (middle) segment. */
 		if (trailing_whitespace - written > 0) {
-			fputs(set, stream);
+			if (!already_set)
+				fputs(set, stream);
 			fwrite(line + written,
 			    trailing_whitespace - written, 1, stream);
 			fputs(reset, stream);
+			already_set = 0;
 		}
 
 		/* Highlight errors in trailing whitespace. */
 		if (trailing_whitespace != len) {
+			optional_reset(stream, reset, &already_set);
 			fputs(ws, stream);
 			fwrite(line + trailing_whitespace,
 			    len - trailing_whitespace, 1, stream);
 			fputs(reset, stream);
 		}
+		if (already_set)
+			fputs(reset, stream);
 		if (trailing_carriage_return)
 			fputc('\r', stream);
 		if (trailing_newline)
@@ -247,14 +265,14 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 
 void ws_check_emit(const char *line, int len, unsigned ws_rule,
 		   FILE *stream, const char *set,
-		   const char *reset, const char *ws)
+		   const char *reset, const char *ws, int already_set)
 {
-	(void)ws_check_emit_1(line, len, ws_rule, stream, set, reset, ws);
+	(void)ws_check_emit_1(line, len, ws_rule, stream, set, reset, ws, already_set);
 }
 
 unsigned ws_check(const char *line, int len, unsigned ws_rule)
 {
-	return ws_check_emit_1(line, len, ws_rule, NULL, NULL, NULL, NULL);
+	return ws_check_emit_1(line, len, ws_rule, NULL, NULL, NULL, NULL, 0);
 }
 
 int ws_blank_line(const char *line, int len, unsigned ws_rule)
-- 
2.18.0.203.gfac676dfb9-goog

