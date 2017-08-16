Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AAF0208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 01:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbdHPB1t (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 21:27:49 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:38014 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753246AbdHPB1r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 21:27:47 -0400
Received: by mail-pg0-f50.google.com with SMTP id l64so15991041pge.5
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 18:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=R8E4f0YSYJVJYBYJdSev0T8VjsuZhzwSVsPu4yHNkMw=;
        b=Sl5OhnlJQYNlsLsChn2uJ8yaFzpO6RQQKJPTeAFHqfnZfP/+8ExKVQmH7Iu8Dw8Wxi
         ZihGrRqVzHMZOp8vG11PGaUq/xCWVop3JdyZ9Jc0EWQJZ7chJq0vRB3crKz/8uZiuqG3
         MDcEImUfl3HNHHqgdSQ7FaU+1wkJO5bLrR94uo70BAoUpsv2k8M8UaBdtrp8BZHEdt5V
         suShbIHagoyC4ljdMjk5FfX7cAi/f5h12sr5njpKjW5mIiWrKetET/2obGzRrYFHHfok
         69s/JQlNIMJUrSb4aY01FEjBPzanDXlA3Z+WPmRIqqySb135kntfZxE2YYOMyKSU4fiC
         pAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=R8E4f0YSYJVJYBYJdSev0T8VjsuZhzwSVsPu4yHNkMw=;
        b=lrJiEg/B0ytY1cqxILvxVb0fKfbb/6/U+v2zoPP6VClKheepvP1wSmhN1r3qmEsJng
         +k7/XPSft9xV1vBvlj4fywQr352Hmz74hwGHEse7il/F98URKkL4qn87pPr3PIGfpFgI
         b19Q68ICoaNIV9dPFz+Jivh+hCOdj5kxXEFxBUC5eW25LGcaSHzWngtZdmm4vWQ5PKoe
         4JNLf77p6dNE0dL7Lk8ePOAq91eTqnj5Ue9UMrQk0sLzM6kKJh57uYdTfgfDyWBIn0Fw
         3EDO8U6xt2HKlzS4eIYY/qRkOeQTVtTHF2WL//IgTIdL3xyywpcCF1nfcsX1fwV2LJto
         ZZGQ==
X-Gm-Message-State: AHYfb5jN5UqdGdDg8gE+wssotBahV8CWrS26D9SIsoyeG/GJUqdu3J3V
        KTMnGOEvRTXPD/fcryKJQQ==
X-Received: by 10.84.231.198 with SMTP id g6mr110102pln.36.1502846865540;
        Tue, 15 Aug 2017 18:27:45 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k8sm621845pgf.33.2017.08.15.18.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 18:27:44 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v4 2/3] diff: respect MIN_BLOCK_LENGTH for last block
Date:   Tue, 15 Aug 2017 18:27:38 -0700
Message-Id: <96f157ff9c14e27bae32e99402e5f8d4cfd79ec6.1502846454.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1502846454.git.jonathantanmy@google.com>
References: <cover.1502846454.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502846454.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com> <cover.1502846454.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, MIN_BLOCK_LENGTH is only checked when diff encounters a line
that does not belong to the current block. In particular, this means
that MIN_BLOCK_LENGTH is not checked after all lines are encountered.

Perform that check.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 diff.c                     | 29 ++++++++++++++++++++++-------
 t/t4015-diff-whitespace.sh | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 23311f9c0..f598d8a3a 100644
--- a/diff.c
+++ b/diff.c
@@ -861,6 +861,26 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 	return rp + 1;
 }
 
+/*
+ * If o->color_moved is COLOR_MOVED_PLAIN, this function does nothing.
+ *
+ * Otherwise, if the last block has fewer lines than
+ * COLOR_MOVED_MIN_BLOCK_LENGTH, unset DIFF_SYMBOL_MOVED_LINE on all lines in
+ * that block.
+ *
+ * The last block consists of the (n - block_length)'th line up to but not
+ * including the nth line.
+ */
+static void adjust_last_block(struct diff_options *o, int n, int block_length)
+{
+	int i;
+	if (block_length >= COLOR_MOVED_MIN_BLOCK_LENGTH ||
+	    o->color_moved == COLOR_MOVED_PLAIN)
+		return;
+	for (i = 1; i < block_length + 1; i++)
+		o->emitted_symbols->buf[n - i].flags &= ~DIFF_SYMBOL_MOVED_LINE;
+}
+
 /* Find blocks of moved code, delegate actual coloring decision to helper */
 static void mark_color_as_moved(struct diff_options *o,
 				struct hashmap *add_lines,
@@ -896,13 +916,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		}
 
 		if (!match) {
-			if (block_length < COLOR_MOVED_MIN_BLOCK_LENGTH &&
-			    o->color_moved != COLOR_MOVED_PLAIN) {
-				for (i = 1; i < block_length + 1; i++) {
-					l = &o->emitted_symbols->buf[n - i];
-					l->flags &= ~DIFF_SYMBOL_MOVED_LINE;
-				}
-			}
+			adjust_last_block(o, n, block_length);
 			pmb_nr = 0;
 			block_length = 0;
 			continue;
@@ -944,6 +958,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		if (flipped_block)
 			l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
 	}
+	adjust_last_block(o, n, block_length);
 
 	free(pmb);
 }
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index c3b697411..6ae62a6bf 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1382,6 +1382,43 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success '--color-moved block at end of diff output respects MIN_BLOCK_LENGTH' '
+	git reset --hard &&
+	>bar &&
+	cat <<-\EOF >foo &&
+	irrelevant_line
+	line1
+	EOF
+	git add foo bar &&
+	git commit -m x &&
+
+	cat <<-\EOF >bar &&
+	line1
+	EOF
+	cat <<-\EOF >foo &&
+	irrelevant_line
+	EOF
+
+	git diff HEAD --color-moved=zebra --no-renames |
+		grep -v "index" |
+		test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<BOLD>diff --git a/bar b/bar<RESET>
+	<BOLD>--- a/bar<RESET>
+	<BOLD>+++ b/bar<RESET>
+	<CYAN>@@ -0,0 +1 @@<RESET>
+	<GREEN>+<RESET><GREEN>line1<RESET>
+	<BOLD>diff --git a/foo b/foo<RESET>
+	<BOLD>--- a/foo<RESET>
+	<BOLD>+++ b/foo<RESET>
+	<CYAN>@@ -1,2 +1 @@<RESET>
+	 irrelevant_line<RESET>
+	<RED>-line1<RESET>
+	EOF
+
+	test_cmp expected actual
+'
+
 test_expect_success 'move detection with submodules' '
 	test_create_repo bananas &&
 	echo ripe >bananas/recipe &&
-- 
2.14.1.480.gb18f417b89-goog

