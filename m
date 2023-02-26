Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB4DC6FA8E
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 18:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBZSrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 13:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBZSrA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 13:47:00 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3038A1715B
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 10:46:59 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso2573498wmp.4
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 10:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RGV/sLMWfTCfhl6B/j7Nwgu+Nfw8uboT2zE5qmKVBo=;
        b=GMB9Hd+msIL0HyzpoLXEcLXC1u5vVr1t0uuSpdP4w9AeRkXgp7muox1oZeBdw9Doku
         Jq7REJr4n5wGFJOofaXENXAEeoc3eHHQu/rnm9Abq90rJN+v+ivlPrxmd8jZHGO+IN8o
         NGGcBxoGQvs96iWZHQgJAl5PpGRcqxXQlP2e+ZA+H7RpvzvcPXMJmoz0aQNckh6QxBgR
         oX6LByyPVvQIm1x3AdJjtCVAnN82Hu/KqkjXdZha0VgR7twzPnilmbb4xNAt76rA+Tyu
         KsVOPqEuKhZbPVCtDW2gfngpmGeCUvO/A6vrek5Lu9zbJSLKU01e4x0h4mH/+/5oCy4X
         XX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RGV/sLMWfTCfhl6B/j7Nwgu+Nfw8uboT2zE5qmKVBo=;
        b=2lCGFJhSY2sttQ2yY81pJ6k3N38qiDLE8M6/54JvE2hDEtjHTNlNjoEn0tEb8mH2XG
         2+SpYgqlq/QQX9zYj+rgkf1g6JTOdHWgh4ktUOOk8bhPBvNhOuX0Cw8nmnNCoeO3oU6g
         lGR7vtv0c3UbsO1JmXPqREf3WL4iNGlvzTG3PHa40ENMALOvU6Ej3zdiDVoCHrn2XblM
         Ubpoq9YAHxeGtokYN6zDsIS8FyrI9jGgV38750KQ98ZqJwpsJtseKnIc9g8oYbYjAAJ+
         c0HOpwuolgWNjuaCJ2Dq2Dug30OV0HCJrS3+uwYG83UPPDUG3DdNqTjxzbCGCw6ndlcF
         luAA==
X-Gm-Message-State: AO0yUKUKmehMZM+Bh4FNUBxKPFrN7mSrPRNQDAurUGsiF/AVuGdniTMN
        +rgPCaSErK0GpuA4wyFH/D7URngpdEQ=
X-Google-Smtp-Source: AK7set+B+g9qdtotshK9fAzIs007dFaYgjczUP1Sjw8fhWhscoKA7hMAmyI9JuadinvNDCiv8CBO3g==
X-Received: by 2002:a05:600c:16c6:b0:3e2:589:2502 with SMTP id l6-20020a05600c16c600b003e205892502mr10306343wmn.28.1677437217559;
        Sun, 26 Feb 2023 10:46:57 -0800 (PST)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c350a00b003daffc2ecdesm11078526wmq.13.2023.02.26.10.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 10:46:57 -0800 (PST)
From:   Andy Koppe <andy.koppe@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v2] restore: fault --staged --worktree with merge opts
Date:   Sun, 26 Feb 2023 18:43:54 +0000
Message-Id: <20230226184354.221-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <xmqq356xcn5z.fsf@gitster.g>
References: <xmqq356xcn5z.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'restore' command already rejects the --merge, --conflict, --ours
and --theirs options when combined with --staged, but accepts them when
--worktree is added as well.

Unfortunately that doesn't appear to do anything useful. The --ours and
--theirs options seem to be ignored when both --staged and --worktree
are given, whereas with --merge or --conflict, the command has the same
effect as if the --staged option wasn't present.

So reject those options with '--staged --worktree' as well, using
opts->accept_ref to distinguish restore from checkout.

Add test for both '--staged' and '--staged --worktree'.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---

CI: https://github.com/ak2/git/actions/runs/4276063110

 builtin/checkout.c | 29 +++++++++++++++++++++--------
 t/t2070-restore.sh | 16 ++++++++++++++++
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a5155cf55c..17b179a797 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -489,15 +489,28 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("'%s' must be used when '%s' is not specified"),
 		    "--worktree", "--source");
 
-	if (opts->checkout_index && !opts->checkout_worktree &&
-	    opts->writeout_stage)
-		die(_("'%s' or '%s' cannot be used with %s"),
-		    "--ours", "--theirs", "--staged");
+	/*
+	 * Reject --staged option to the restore command when combined with
+	 * merge-related options. Use the accept_ref flag to distinguish it
+	 * from the checkout command, which does not accept --staged anyway.
+	 *
+	 * `restore --ours|--theirs --worktree --staged` could mean resolving
+	 * conflicted paths to one side in both the worktree and the index,
+	 * but does not currently.
+	 *
+	 * `restore --merge|--conflict=<style>` already recreates conflicts
+	 * in both the worktree and the index, so adding --staged would be
+	 * meaningless.
+	 */
+	if (!opts->accept_ref && opts->checkout_index) {
+		if (opts->writeout_stage)
+			die(_("'%s' or '%s' cannot be used with %s"),
+			    "--ours", "--theirs", "--staged");
 
-	if (opts->checkout_index && !opts->checkout_worktree &&
-	    opts->merge)
-		die(_("'%s' or '%s' cannot be used with %s"),
-		    "--merge", "--conflict", "--staged");
+		if (opts->merge)
+			die(_("'%s' or '%s' cannot be used with %s"),
+			    "--merge", "--conflict", "--staged");
+	}
 
 	if (opts->patch_mode) {
 		enum add_p_mode patch_mode;
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 7c43ddf1d9..c5d19dd973 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -137,4 +137,20 @@ test_expect_success 'restore --staged invalidates cache tree for deletions' '
 	test_must_fail git rev-parse HEAD:new1
 '
 
+test_expect_success 'restore with merge options rejects --staged' '
+	for opts in \
+		"--staged --ours" \
+		"--staged --theirs" \
+		"--staged --merge" \
+		"--staged --conflict=diff3" \
+		"--staged --worktree --ours" \
+		"--staged --worktree --theirs" \
+		"--staged --worktree --merge" \
+		"--staged --worktree --conflict=zdiff3"
+	do
+		test_must_fail git restore $opts . 2>err &&
+		grep "cannot be used with --staged" err || return
+	done
+'
+
 test_done
-- 
2.39.0

