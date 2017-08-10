Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD9DC208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbdHJSyW (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:54:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38752 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbdHJSyV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:54:21 -0400
Received: by mail-pf0-f194.google.com with SMTP id h75so1404140pfh.5
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Gi2qeNu/+zbYQrgeVshLLBbZZwHIT5al3oA7Vvg5Pq8=;
        b=Qct0c03PT8ZCAokLglHztomq19soshOFw2oLlxYBEOtX9nBsTixr70X1gE0/aoGPmc
         AI6mse2vxXrEVYvQUHh9zz/ZcS/nRG/yTC/NpgkAH1DmvPpWZAKZI+xKw1IdV9cTwvkz
         R2MVpkssdXfhVnT+gZF46FFIR3hL9hp2xa8QJOrmBauc+mup5sFwZjkUcyGyTN+fbvgZ
         Qxy1Ybd7cnoh3HFBKHWQC/ZqxdAnUYuwtbNaCDcIHk3zRHYDJOUp9FikNqoyfUJoNppY
         VO+59rY2yfmVijQRjJanS/cEBmIy7KICoMVxUMZnhCVPdCR5bpNUnG3GUR/j1F7ng0nl
         4/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gi2qeNu/+zbYQrgeVshLLBbZZwHIT5al3oA7Vvg5Pq8=;
        b=UlRb4c8KNgaV+sQWDFJOj4/xxgNuObFrpzYF7Vu5ssZws4U0byPaLiUQ7AGM3B/kZK
         ynTevbPrVoCD7EukGN60/Q3h2sefprbBObgvJqxomvTtlntVke3JOuBFVynoeh8aSa9i
         0Cpllfek8qYhO2oIhmu/W6iJtJmsoH96bB2HFucg5YqPJlzdeZaPS7ctEFa1380gc6iA
         bjohxEX8KSVEwmUMmcPNzOK8kBhYmKAUjiG1tZWmFgn7xNoE0IqWk5e6ORvzaVpARVAE
         J64OiFZBGP1s6N/7cIQtO2t/1NrcNi/oy4rArcRYpzCMY9QDW+vWUfagDzvg51UDzyTT
         ALsw==
X-Gm-Message-State: AHYfb5gh2IDTotQWR+saYnHzXRtT4uh+u5Pl9Ybk5/W7oIZPWn9LioKx
        cwkqnaejDbaRS7q1B98=
X-Received: by 10.99.106.193 with SMTP id f184mr408319pgc.290.1502391260745;
        Thu, 10 Aug 2017 11:54:20 -0700 (PDT)
Received: from kewillf-git01.redmond.corp.microsoft.com ([2001:4898:80e8:7::54f])
        by smtp.gmail.com with ESMTPSA id k185sm12458574pgc.31.2017.08.10.11.54.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Aug 2017 11:54:20 -0700 (PDT)
From:   Kevin Willford <kcwillford@gmail.com>
X-Google-Original-From: Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, peartben@gmail.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH] commit: skip discarding the index if there is no pre-commit hook
Date:   Thu, 10 Aug 2017 14:54:16 -0400
Message-Id: <20170810185416.8224-1-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.0.rc0.286.g44127d70e4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If there is not a pre-commit hook, there is no reason to discard
the index and reread it.

This change checks to presence of a pre-commit hook and then only
discards the index if there was one.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 builtin/commit.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index e7a2cb6285..443949d87b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -671,12 +671,22 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
 	int old_display_comment_prefix;
+	const char *precommit_hook = NULL;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
-		return 0;
+
+	if (!no_verify) {
+		/*
+		 * Check to see if there is a pre-commit hook
+		 * If there not one we can skip discarding the index later on
+		 */
+		precommit_hook = find_hook("pre-commit");
+		if (precommit_hook &&
+		    run_commit_hook(use_editor, index_file, "pre-commit", NULL))
+			return 0;
+	}
 
 	if (squash_message) {
 		/*
@@ -940,12 +950,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	/*
-	 * Re-read the index as pre-commit hook could have updated it,
-	 * and write it out as a tree.  We must do this before we invoke
-	 * the editor and after we invoke run_status above.
-	 */
-	discard_cache();
+	if (!no_verify && precommit_hook) {
+		/*
+		 * Re-read the index as pre-commit hook could have updated it,
+		 * and write it out as a tree.  We must do this before we invoke
+		 * the editor and after we invoke run_status above.
+		 */
+		discard_cache();
+	}
+
 	read_cache_from(index_file);
 	if (update_main_cache_tree(0)) {
 		error(_("Error building trees"));
-- 
2.14.0.rc0.286.g44127d70e4

