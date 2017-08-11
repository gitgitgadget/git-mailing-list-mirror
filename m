Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 278A020899
	for <e@80x24.org>; Fri, 11 Aug 2017 22:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753690AbdHKWt2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 18:49:28 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36233 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753817AbdHKWtY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 18:49:24 -0400
Received: by mail-pf0-f169.google.com with SMTP id c28so20872300pfe.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 15:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=E3udfjwISb6x62uSeUZZ9B+Qkuouz74V38q4t7YEIe8=;
        b=MzQte95XHLHB8ldZEjpTNLW/gA3tFchiV3v2vUMf/YQr9fFMmBO7V/8sch/ODeXzUq
         3EG3ht2+gXR1SyXLDbBQgb9f44lQLuPmtydNiQw8okU3BQMeOaKapSb6BMNlqH14jhlb
         SEEvnu0y7Sghhsk4b3RGwOjDBoBrMaY4sPGGQbAwDKdNO4yRS46xG00oHYRzMPDCo5sS
         Pu/zWeEw0upN3D3KuM/c2oxzFTLBw71Jj4QOm9lYu0bgCxX5ZJnHD8VZpRZb0D9BsD3F
         NftrsmywZfR03K1I9dAqmBt7zK8eP5EDDFXmVlT0d3DyG/fGJpbUSYLjULiWVB1mTSWU
         JAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=E3udfjwISb6x62uSeUZZ9B+Qkuouz74V38q4t7YEIe8=;
        b=uXPQaRqJd4sgidXTBwR8RKB2ImVnAnkKpGDIXvyKB+ODMNBLJD3paTC0Zrmhqxvyjj
         wf1BWdZx6o93MGZ8xe6Hg7bqFHnvrL4MptKLOX+W08GTnsDM6H4EHUh1yZ+d22jXhs/r
         RsI/FfPifvIyJXW6ieFeRq66xH/Yr+pW8lr5j7txtTzNnH1Bw7lwgqVjhESCXV/RcilC
         QD8aZ7+WHtHgT57oh+b7wgOXTjbGxbX5OgdK6Sg2BhPIezUsNe0DuNrxR79zcfeaIqyk
         YXib0ydJSzVkRgF6hos57HO62hdZjyTpb7HRCPQ+RnQj1yoOaSTtrPwrLK0ha6hlwAq5
         9Zdw==
X-Gm-Message-State: AHYfb5j+HC+13TcrtJkg1R8SMl0QtQr/6/XbBMNyQKVmfwg4/zmgBn3S
        2Vk8me4Ef+wxiiwassXe6w==
X-Received: by 10.84.215.208 with SMTP id g16mr19706701plj.191.1502491763059;
        Fri, 11 Aug 2017 15:49:23 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id j9sm3780502pfk.30.2017.08.11.15.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Aug 2017 15:49:22 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com
Subject: [RFC PATCH 2/3] diff: respect MIN_BLOCK_LENGTH for last block
Date:   Fri, 11 Aug 2017 15:49:15 -0700
Message-Id: <ca94745f8d72a1d472462e9cb25ef3d2e1285f86.1502491372.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502491372.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502491372.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com>
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
 t/t4015-diff-whitespace.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 4965ffbc4..95620b130 100644
--- a/diff.c
+++ b/diff.c
@@ -858,6 +858,26 @@ static int shrink_potential_moved_blocks(struct moved_entry **pmb,
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
@@ -893,13 +913,7 @@ static void mark_color_as_moved(struct diff_options *o,
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
@@ -941,6 +955,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		if (flipped_block)
 			l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
 	}
+	adjust_last_block(o, n, block_length);
 
 	free(pmb);
 }
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index c3b697411..6f7758e5c 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1382,6 +1382,41 @@ EOF
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
+	git diff HEAD --color-moved=zebra --no-renames | grep -v "index" | test_decode_color >actual &&
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
2.14.0.434.g98096fd7a8-goog

