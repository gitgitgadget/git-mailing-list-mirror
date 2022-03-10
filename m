Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3425C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbiCJW5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbiCJW5T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:57:19 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A15318461D
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:56:17 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h15so10336830wrc.6
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Th2AdbwsmnnXnUwztD8pd7GCQOaYhBdxuTJfW4RTu1Q=;
        b=DkrpEM7+5m31STOoBBB8pIudC7oVCyPZnsdXIMRt4fGJWZE4UZR1TV9v5YJmQmPn17
         iE/BODFS95GBw8BDZAnp8W8oXRTM2sp+Ea4U5ySkI638D/PPmbF+OA+XrDmgqkAUOyic
         YPjHvc7D8RU9MYGCo57yvlRW7FE8Zjt7ZcxB5zgcWeoYBE68XtKVe4Po90UMccRDFJSQ
         SukucBlH1LTE6Gmhn1IABLbOq1xXMMgN6JG5FqC3NJDsE/eSCejCJ2to5g9aNPS9gN7M
         eXFIJh7cBHIJ76kTXOTQx0UzTs6R1xhEMy0d6kzWbVEbWCcEsToLyWlUyojwxyHz6X4v
         UWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Th2AdbwsmnnXnUwztD8pd7GCQOaYhBdxuTJfW4RTu1Q=;
        b=2+kT18iOuFj2S/KrCr7Z4IabCTIt6VR8o5VwjrB5tYZteBZaQ4yTRa1YhiQNHgaEk2
         Cku0nPWPrXiLHWuxON9pYEvUdTDk97FpLt8EdiQ0wokEHJ46kIPs0Dalf1OF4T7MObfh
         gQvEpDPXG5dTiCNLa5gzpsqJOgoBTPZqgTXrlngTJsWM1L1eFMmAlZ5HO6RTY70PQeld
         6W3/bLnpm/ix5BTGG/OBH7UD7mY6VrKGQxgzVC9bQ9p2ppBtxfDuLvOBvJqtsqDhhiAL
         HFBDRMLd4Yi/w21KaQdpafjulwu8WoVUUp0DfMlUDvvAGoAhGuGrVmFdSyhfG+vv8aCk
         LVWQ==
X-Gm-Message-State: AOAM5321Ju9J962ftG+g2Wgp9pYlczfssC+218Cck0LmH66Ogjt67UnP
        ReBFrzQgEUlfVBMHTNo8llOaVQHod9HC9A==
X-Google-Smtp-Source: ABdhPJx/aUrNskuC07hqWYoF0NcwAnjAnZo6PeSN6z+NYExSpwei0xmDET/Z7dflprfm2UIBGmogqw==
X-Received: by 2002:adf:fdc4:0:b0:1f1:db22:cb28 with SMTP id i4-20020adffdc4000000b001f1db22cb28mr4767979wrs.689.1646952975579;
        Thu, 10 Mar 2022 14:56:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bk19-20020a0560001d9300b001a65e479d20sm5169756wrb.83.2022.03.10.14.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:56:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] reflog: don't be noisy on empty reflogs
Date:   Thu, 10 Mar 2022 23:56:11 +0100
Message-Id: <de5e2b0e290791d0a4f58a893d8571b5fc8c4f1a.1646952843.git.avarab@gmail.com>
X-Mailer: git-send-email 2.35.GIT-dev
In-Reply-To: <571c0796-66d4-e8c7-c5a5-2e7a28132aa9@kdbg.org>
References: <571c0796-66d4-e8c7-c5a5-2e7a28132aa9@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in my daf1d8285ee (reflog expire: don't use
lookup_commit_reference_gently(), 2021-12-22), in changing from
lookup_commit_reference_gently() to lookup_commit() we stopped trying
to call deref_tag() and parse_object() on the provided OID, but we
also started returning non-NULL for the null_oid().

As a result we'd emit an error() via mark_reachable() later in this
function as we tried to invoke parse_commit() on it.

Reported-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Thu, Mar 10 2022, Johannes Sixt wrote:

> Since daf1d8285eeb ("reflog expire: don't use
> lookup_commit_reference_gently()", 2021-12-22) we see
>
> $ git reflog expire --all
> error: Could not read 0000000000000000000000000000000000000000
>
> that was not there before.
>
> The problem seem to be empty reflog files. I assume they can be created
> when reflogs expire completely. I have a handful of them in repository
> that was quiet for a long while.
>
> To reproduce:
>
> git init
> mkdir -p .git/logs/refs/heads
> touch .git/logs/refs/heads/foo
> git reflog expire --all

Thanks, and sorry about that. I believe this should fix it.

 builtin/reflog.c  | 2 ++
 t/t1410-reflog.sh | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 016466852f1..3fdf926759c 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -374,6 +374,8 @@ static void reflog_expiry_prepare(const char *refname,
 		cb->unreachable_expire_kind = UE_HEAD;
 	} else {
 		commit = lookup_commit(the_repository, oid);
+		if (commit && is_null_oid(&commit->object.oid))
+			commit = NULL;
 		cb->unreachable_expire_kind = commit ? UE_NORMAL : UE_ALWAYS;
 	}
 
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 68f69bb5431..ea8e6ac2a02 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -423,4 +423,13 @@ test_expect_success 'expire with multiple worktrees' '
 	)
 '
 
+test_expect_success REFFILES 'empty reflog' '
+	test_when_finished "rm -rf empty" &&
+	git init empty &&
+	test_commit -C empty A &&
+	>empty/.git/logs/refs/heads/foo &&
+	git -C empty reflog expire --all 2>err &&
+	test_must_be_empty err
+'
+
 test_done
-- 
2.35.GIT-dev

