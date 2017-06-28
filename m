Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D82320209
	for <e@80x24.org>; Wed, 28 Jun 2017 00:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753557AbdF1A5S (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 20:57:18 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36797 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbdF1A5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 20:57:16 -0400
Received: by mail-pf0-f175.google.com with SMTP id q86so24635108pfl.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 17:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eDjEQKBmvWhoD7WmvGnrN2A4h1l7wQgMtnii9mbchcU=;
        b=dr1GI4JihP5JTBWt0KF61BwbrlXaa3B5TCU6/4GjgfZq2JYkFgns89I9bt1gqN3GzD
         kUSpfny8rXA4gNIxUsBD0LLwAaqRPbop9i7W++OjWvzO2oUitVWRc0Ls7+zlQgcUToun
         C5szLm8UEC5KLJksM2SXXYFNCstMTOzrj33uLT8wqT6rx49VDJDgEzuVyqvoNDhn9tbM
         2yDgJ7igzHwf06/u0GeaqQK5rpNyBfkwILttEqLkv13QxG1vv1LjIIHS9nzxmC8YKTSI
         CENLAYgZJAV+aQP7sxZKo559rml3YEpDH09qfwXwTxg3XNhR2YhClVJQebbePukQ13h7
         TERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eDjEQKBmvWhoD7WmvGnrN2A4h1l7wQgMtnii9mbchcU=;
        b=VrwLQQiIAc92A9HxZMWbzmHSR+ZgSoBD/Egkaq/qwpMhTgnADh202O1f+Dt+/iUHcf
         EI3sHe4iISiMpON70g7HfODuWT0v2xUFWmiHznu1vMb4FEABPH3jl0vjBUcGhTEZ8OSb
         Stv1gP6HPA9aMS2p0X+myJ9gWYntfyOvowR21KnDBODJKiM3bp32VnQ0L0temO7MlKeU
         +R3w9KDNZcSv3k0bnLuPtqf7v52Zq5gmE477Ku4ohe5SZK5YS7VIGqG1fMp9kD3Etaud
         7lHaMJ7vCWqLfkY9eDCHrL7Hhe3vLiDdPsh0oS6rYRO5iR0j/UbaT4bJuJCROHCeww7x
         6yNw==
X-Gm-Message-State: AKS2vOxhq1Tm9JuOZpe/uXP630lvwg+fjk+AOuu6y50DnIrF19nFVNII
        4sm0BbjSRlaS3ivx
X-Received: by 10.99.94.70 with SMTP id s67mr7778587pgb.82.1498611425217;
        Tue, 27 Jun 2017 17:57:05 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ac62:ae13:b066:f242])
        by smtp.gmail.com with ESMTPSA id u73sm796079pfi.105.2017.06.27.17.57.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 17:57:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/6] diff.c: detect blocks despite whitespace changes
Date:   Tue, 27 Jun 2017 17:56:51 -0700
Message-Id: <20170628005651.8110-7-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170628005651.8110-1-sbeller@google.com>
References: <20170628005651.8110-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reuse the compare function from the hash map instead of calling the
compare function directly. Then we pick the correct compare function
when told to compare ignoring white space.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c                     |  3 +--
 t/t4015-diff-whitespace.sh | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 1d93e98e3a..4bcf938e3a 100644
--- a/diff.c
+++ b/diff.c
@@ -903,8 +903,7 @@ static void mark_color_as_moved(struct diff_options *o,
 			struct moved_entry *p = pmb[i];
 			struct moved_entry *pnext = (p && p->next_line) ?
 					p->next_line : NULL;
-			if (pnext &&
-			    !emitted_symbol_cmp(pnext->es, l, o)) {
+			if (pnext && !hm->cmpfn(pnext, match, NULL)) {
 				pmb[i] = p->next_line;
 			} else {
 				pmb[i] = NULL;
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index ae8c686f3c..c3b697411a 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1317,6 +1317,71 @@ test_expect_success 'no effect from --color-moved with --word-diff' '
 	test_cmp expect actual
 '
 
+test_expect_success 'move detection ignoring whitespace ' '
+	git reset --hard &&
+	cat <<\EOF >lines.txt &&
+line 1
+line 2
+line 3
+line 4
+line 5
+line 6
+line 7
+EOF
+	git add lines.txt &&
+	git commit -m "add poetry" &&
+	cat <<\EOF >lines.txt &&
+	line 5
+	line 6
+	line 7
+line 1
+line 2
+line 3
+line 4
+EOF
+	test_config color.diff.oldMoved "magenta" &&
+	test_config color.diff.newMoved "cyan" &&
+	git diff HEAD --no-renames --color-moved| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>index 734156d..eb89ead 100644<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,7 +1,7 @@<RESET>
+	<GREEN>+<RESET>	<GREEN>line 5<RESET>
+	<GREEN>+<RESET>	<GREEN>line 6<RESET>
+	<GREEN>+<RESET>	<GREEN>line 7<RESET>
+	 line 1<RESET>
+	 line 2<RESET>
+	 line 3<RESET>
+	 line 4<RESET>
+	<RED>-line 5<RESET>
+	<RED>-line 6<RESET>
+	<RED>-line 7<RESET>
+	EOF
+	test_cmp expected actual &&
+
+	git diff HEAD --no-renames -w --color-moved| test_decode_color >actual &&
+	cat <<-\EOF >expected &&
+	<BOLD>diff --git a/lines.txt b/lines.txt<RESET>
+	<BOLD>index 734156d..eb89ead 100644<RESET>
+	<BOLD>--- a/lines.txt<RESET>
+	<BOLD>+++ b/lines.txt<RESET>
+	<CYAN>@@ -1,7 +1,7 @@<RESET>
+	<CYAN>+<RESET>	<CYAN>line 5<RESET>
+	<CYAN>+<RESET>	<CYAN>line 6<RESET>
+	<CYAN>+<RESET>	<CYAN>line 7<RESET>
+	 line 1<RESET>
+	 line 2<RESET>
+	 line 3<RESET>
+	 line 4<RESET>
+	<MAGENTA>-line 5<RESET>
+	<MAGENTA>-line 6<RESET>
+	<MAGENTA>-line 7<RESET>
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'move detection with submodules' '
 	test_create_repo bananas &&
 	echo ripe >bananas/recipe &&
-- 
2.13.0.31.g9b732c453e

