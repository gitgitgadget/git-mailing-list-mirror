Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F321201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 20:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbdF3Ux7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 16:53:59 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34084 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753124AbdF3Uxt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 16:53:49 -0400
Received: by mail-pg0-f51.google.com with SMTP id t186so69047595pgb.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 13:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=krbagsmZ0JgNQhhLl0lxZHKq77XaW8ODdlZeJ2veR8I=;
        b=LqDt666LFYCvn6BqcNlraNtByicKKcWdV4LEcF72D4mVgd2XzYLvorhuSrGDfBCIYd
         JKIcNMowOHDT+pvv4uMy6Z37jzztPPUJl/GQgyB/2qVydU9JfNt/ezvIRWYQfmA9EUEV
         pnLR/njH23dh4WWjEcRV+xQ2X2KGugtCb3hrfo3IlGc4cQqBE6sqMztPSTSPimUqKAGN
         YcumlaJeZ2zSKJ5gBk9BcsFbECxLlLDO32mLGDbkAWhXz9sTYW8Snj8+zA7u8lDua1YR
         TPI2lTRIznMm8AQJuuOjxkaa71g1xGzcJoE0UDy23nRkFyXY3dmfFoguzh3lWFroIptr
         GKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=krbagsmZ0JgNQhhLl0lxZHKq77XaW8ODdlZeJ2veR8I=;
        b=gaIYEqyjs6citoaBml7r7lVL3P3SnuggZxd3FMlMvN+FtAJfjqm5mmc7/W6SmZMNk4
         42XrhuUlUOHgh4cHNaWarI0URTdqqFEFDl1jOtzNasdZmn06V5QWhMvuJwW5Hr3j5bzW
         Q5Zy06IipSM82C6YB09cnXmciV/5YUY27lds+x2mize20Ad5abR9DoYLxaNZwzhTvVNR
         LwKC6OS3pyhsuixdd+OSsW0SWJdr+f0e8ec2KuVR6uNoxXMcuHQ+jMIs+ulX/gucj843
         CaxyHU72Jb7ydZgWK32rXMesZ06NMEUDM1xa45y3/0BBHqz/9c4v3n7DDfo8X5Ga+CIQ
         IDjg==
X-Gm-Message-State: AKS2vOzgbQ99C3D6X23cjAbZM/Dr+VEiIz1f7XZgmTXj6NWjSIncsh/e
        e6+BITTMYQMu1Fe9
X-Received: by 10.99.107.66 with SMTP id g63mr22673965pgc.277.1498856023554;
        Fri, 30 Jun 2017 13:53:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id 28sm21804223pfq.125.2017.06.30.13.53.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 13:53:42 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, simon@ruderich.org
Subject: [PATCHv2 23/25] diff.c: color moved lines differently, plain mode
Date:   Fri, 30 Jun 2017 13:53:08 -0700
Message-Id: <20170630205310.7380-24-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630205310.7380-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
 <20170630205310.7380-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the 'plain' mode for move detection of code. This omits the checking
for adjacent blocks, so it is not as useful. If you have a lot of the
same blocks moved in the same patch, the 'Zebra' would end up slow as it
is O(n^2) (n is number of same blocks). So this may be useful there and
is generally easy to add. Instead be very literal at the move detection,
do not skip over short blocks here.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c                     | 10 +++++++--
 diff.h                     |  1 +
 t/t4015-diff-whitespace.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 084ecc5678..79ea592388 100644
--- a/diff.c
+++ b/diff.c
@@ -256,12 +256,14 @@ static int parse_color_moved(const char *arg)
 
 	if (!strcmp(arg, "no"))
 		return COLOR_MOVED_NO;
+	else if (!strcmp(arg, "plain"))
+		return COLOR_MOVED_PLAIN;
 	else if (!strcmp(arg, "zebra"))
 		return COLOR_MOVED_ZEBRA;
 	else if (!strcmp(arg, "default"))
 		return COLOR_MOVED_DEFAULT;
 	else
-		return error(_("color moved setting must be one of 'no', 'default', 'zebra'"));
+		return error(_("color moved setting must be one of 'no', 'default', 'zebra', 'plain'"));
 }
 
 int git_diff_ui_config(const char *var, const char *value, void *cb)
@@ -879,7 +881,8 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		if (!match) {
-			if (block_length < COLOR_MOVED_MIN_BLOCK_LENGTH) {
+			if (block_length < COLOR_MOVED_MIN_BLOCK_LENGTH &&
+			    o->color_moved != COLOR_MOVED_PLAIN) {
 				for (i = 0; i < block_length + 1; i++) {
 					l = &o->emitted_symbols->buf[n - i];
 					l->flags &= ~DIFF_SYMBOL_MOVED_LINE;
@@ -893,6 +896,9 @@ static void mark_color_as_moved(struct diff_options *o,
 		l->flags |= DIFF_SYMBOL_MOVED_LINE;
 		block_length++;
 
+		if (o->color_moved == COLOR_MOVED_PLAIN)
+			continue;
+
 		/* Check any potential block runs, advance each or nullify */
 		for (i = 0; i < pmb_nr; i++) {
 			struct moved_entry *p = pmb[i];
diff --git a/diff.h b/diff.h
index 3196802673..4cfd609c54 100644
--- a/diff.h
+++ b/diff.h
@@ -190,6 +190,7 @@ struct diff_options {
 	struct emitted_diff_symbols *emitted_symbols;
 	enum {
 		COLOR_MOVED_NO = 0,
+		COLOR_MOVED_PLAIN = 1,
 		COLOR_MOVED_ZEBRA = 2,
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 29704ae14e..d1d7b99990 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -986,7 +986,7 @@ test_expect_success 'detect moved code, complete file' '
 	git mv test.c main.c &&
 	test_config color.diff.oldMoved "normal red" &&
 	test_config color.diff.newMoved "normal green" &&
-	git diff HEAD --color-moved --no-renames | test_decode_color >actual &&
+	git diff HEAD --color-moved=zebra --no-renames | test_decode_color >actual &&
 	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/main.c b/main.c<RESET>
 	<BOLD>new file mode 100644<RESET>
@@ -1130,6 +1130,55 @@ test_expect_success 'detect malicious moved code, inside file' '
 	test_cmp expected actual
 '
 
+test_expect_success 'plain moved code, inside file' '
+	test_config color.diff.oldMoved "normal red" &&
+	test_config color.diff.newMoved "normal green" &&
+	test_config color.diff.oldMovedAlternative "blue" &&
+	test_config color.diff.newMovedAlternative "yellow" &&
+	# needs previous test as setup
+	git diff HEAD --no-renames --color-moved=plain| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/main.c b/main.c<RESET>
+	<BOLD>index 27a619c..7cf9336 100644<RESET>
+	<BOLD>--- a/main.c<RESET>
+	<BOLD>+++ b/main.c<RESET>
+	<CYAN>@@ -5,13 +5,6 @@<RESET> <RESET>printf("Hello ");<RESET>
+	 printf("World\n");<RESET>
+	 }<RESET>
+	 <RESET>
+	<BRED>-int secure_foo(struct user *u)<RESET>
+	<BRED>-{<RESET>
+	<BRED>-if (!u->is_allowed_foo)<RESET>
+	<BRED>-return;<RESET>
+	<BRED>-foo(u);<RESET>
+	<BRED>-}<RESET>
+	<BRED>-<RESET>
+	 int main()<RESET>
+	 {<RESET>
+	 foo();<RESET>
+	<BOLD>diff --git a/test.c b/test.c<RESET>
+	<BOLD>index 1dc1d85..2bedec9 100644<RESET>
+	<BOLD>--- a/test.c<RESET>
+	<BOLD>+++ b/test.c<RESET>
+	<CYAN>@@ -4,6 +4,13 @@<RESET> <RESET>int bar()<RESET>
+	 printf("Hello World, but different\n");<RESET>
+	 }<RESET>
+	 <RESET>
+	<BGREEN>+<RESET><BGREEN>int secure_foo(struct user *u)<RESET>
+	<BGREEN>+<RESET><BGREEN>{<RESET>
+	<BGREEN>+<RESET><BGREEN>foo(u);<RESET>
+	<BGREEN>+<RESET><BGREEN>if (!u->is_allowed_foo)<RESET>
+	<BGREEN>+<RESET><BGREEN>return;<RESET>
+	<BGREEN>+<RESET><BGREEN>}<RESET>
+	<BGREEN>+<RESET>
+	 int another_function()<RESET>
+	 {<RESET>
+	 bar();<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_expect_success 'no effect from --color-moved with --word-diff' '
 	cat <<-\EOF >text.txt &&
 	Lorem Ipsum is simply dummy text of the printing and typesetting industry.
-- 
2.13.0.31.g9b732c453e

