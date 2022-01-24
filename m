Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB0FC433FE
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 22:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348570AbiAXWdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 17:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585432AbiAXWXd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 17:23:33 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EEBC041898
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:53:47 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t1-20020a6564c1000000b002e7f31cf59fso10519171pgv.14
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 12:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rqUylm9VdgmZYhEmcAxZx2Bvna1gA7GqrDXblBRBUZ0=;
        b=U83c3NmWLdWC3JTNA0PdjAyO2Ro0UL7pNYyR1kTmb6svqs3ETcVtRlar2NmBPCASYL
         kWllslcrq3POZjmhTqINeLlJVhcLWXsF7hh+FJXtqskJPVPDuZY63gqpp9J0Cpn+EFzA
         +549s0HI3dcE8HCWSIlq+y1Zdbpa+NkWzf5q3SPDAMv+eUp9sfePM9ePrHTXIWiXAuY5
         nu+C1t4e+IQ5uM98CD4YAMwVpg95rM1oFW0bLoLgfw160OL3vesOrp1Sv1SpVVciyuS5
         JnOS4kqvRLp7oz/bFfcwS288byxnRR1Q1kQ2nHOEtTCtpSeNOXYKDPx5obgbcAlCYQad
         Vy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rqUylm9VdgmZYhEmcAxZx2Bvna1gA7GqrDXblBRBUZ0=;
        b=qGKd5AWo65D/+wVbLislYHgEBaecW4jQ0Iowym6hYKzZ0GPdUC11QeLQvKlTNM9hk/
         SBkG4nA1kJuWtfNaPlyKPnZXZIeFw/LX3qNKlEGCefUQk7ykpO24JHLOGAbCTAOIb3yK
         b0n4ZZjHd/3myTREdkbCOUpIPxTTDTtWxJsexTm+U7Man7AYLzdnOjXU9ODV6Zi097Ko
         iFACesxj+VNpfM4jNNcBavPINdXF7bIuXtCLO/re63qTyybBd5i+0fES8B0w96f27AdF
         K5iZle1iCO7oi40l2gXRunVozjTzTZ4b4/CDt98FkVA61f8CwSs1jed9zOBCcypOfysG
         uA5A==
X-Gm-Message-State: AOAM5338LoyhkALIVdcSx6ha71QfCdhVkfcCyHoAddlqzbBKIysEGu19
        wdCTTR2YcoAaDth+CgCveq+vwD0BMXBqU3KI6dHBEym7iyirAWPhv8ZYOiikgN5UeVLf/A1nBzP
        +M4nusOjc9LZWMPaVSaGbMck6zyBIRHdUGSUaA5wf7ABUy4Ao7EjnSVy/1d8eACc=
X-Google-Smtp-Source: ABdhPJyo09cXBTY5xxPj+v9BIIEW4nNehIA31RxWzmwwReGJUOuloC8MIePASJ9gZcHzvbT7VRFEOXkUNnM2EQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1d10:b0:4c8:d23:2151 with SMTP
 id a16-20020a056a001d1000b004c80d232151mr9295443pfx.63.1643057626590; Mon, 24
 Jan 2022 12:53:46 -0800 (PST)
Date:   Mon, 24 Jan 2022 12:53:42 -0800
In-Reply-To: <YYwxVO7A29FcN+hN@coredump.intra.peff.net>
Message-Id: <20220124205342.41450-1-chooglen@google.com>
Mime-Version: 1.0
References: <YYwxVO7A29FcN+hN@coredump.intra.peff.net>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH] stash: strip "refs/heads/" with skip_prefix
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Kraymer <kraymer@gmail.com>,
        Daniel Hahler <git@thequod.de>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When generating a message for a stash, "git stash" only records the
part of the branch name to the right of the last "/". e.g. if HEAD is at
"foo/bar/baz", "git stash" generates a message prefixed with "WIP on
baz:" instead of "WIP on foo/bar/baz:".

Fix this by using skip_prefix() to skip "refs/heads/" instead of looking
for the last instance of "/".

Reported-by: Kraymer <kraymer@gmail.com>
Reported-by: Daniel Hahler <git@thequod.de>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Glen Choo <chooglen@google.com>
---
I prepared this fix before checking the mailing list for any bug
reports; turns out that there are at least two existing reports.

My fix happens to be exactly the same as what Peff suggested, with the
additional test that he asked for.

 builtin/stash.c  |  2 +-
 t/t3903-stash.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 1ef2017c59..01f072a2fb 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1332,7 +1332,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 
 	branch_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
 	if (flags & REF_ISSYMREF)
-		branch_name = strrchr(branch_ref, '/') + 1;
+		skip_prefix(branch_ref, "refs/heads/", &branch_name);
 	head_short_sha1 = find_unique_abbrev(&head_commit->object.oid,
 					     DEFAULT_ABBREV);
 	strbuf_addf(&msg, "%s: %s ", branch_name, head_short_sha1);
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 686747e55a..bf83fb940e 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1042,6 +1042,17 @@ test_expect_success 'create stores correct message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create when branch name has /' '
+	test_when_finished "git checkout main" &&
+	git checkout -b some/topic &&
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create "create test message") &&
+	echo "On some/topic: create test message" >expect &&
+	git show --pretty=%s -s ${STASH_ID} >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'create with multiple arguments for the message' '
 	>foo &&
 	git add foo &&

base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
-- 
2.33.GIT

