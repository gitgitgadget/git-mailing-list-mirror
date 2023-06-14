Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C3BEB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 04:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242492AbjFNERs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 00:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbjFNERq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 00:17:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA9019BC
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 21:17:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bc505a8dd60so329853276.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 21:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686716265; x=1689308265;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kMNJl2r8nQJRzf86Q66NkkgNYf5WsXfIbOns2VyFMlo=;
        b=FdeVPJCauBKIvN0YFguTiaNuqt0bJhvNOv7a+e6mSPrdpqfTKXyjNHiRlo5k/5cWeW
         VU1LyqM9w+/upZBQZJWhEjnBkrCQ/j4aSfn4f38UsPvyiX58iHqc2aejFmqJBEzqsg81
         PIBAByDr9icCmlJ++TG+k8DEtOQzGvEgn1l80369fnSFYnybOdi5TfKCJWnd1dIcrMCH
         7FD+kAgmSnhhIfyXJOvy6e175SQtotXiAjMVS1bMG33V9gxo6Q+ZvSr9UNV+aqd3/jOJ
         dNxlhH6YrBEA2h4LQiHGHoMPaGdSIExrI3ahi0rRa27GWsmgGwi/rUkMZsuxYHIgMKDl
         DxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686716265; x=1689308265;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kMNJl2r8nQJRzf86Q66NkkgNYf5WsXfIbOns2VyFMlo=;
        b=TT4DOca/Z3P+1i3sFs8sUxn9j2qmn3dxtRUDt8H5IfJkyogKhUo1jrKvG9LqZwpKYW
         dXsUqfZUzYOvraecjiyskmxTqQ996thr4yAj2NLGeMtsJjeRFjeGsMskNyES06NlxIz0
         gF+uUuenbcLhpxe47ug4+Lq5E4QKVzvHZxOQzuKBQSHTdB35CtpRbTV5I1sCFZHgP5i5
         ewxB34cjtMLU6YNVcyDmlv8yDmVC70Xch+MZt3IgMMr3IJWUGBCNE9vgnUZzFMAOp311
         4Oy6nD/Nm/yfwGj0wTCcAdq07EigqOx2Q+69AlpNhcPeUouKz7+t3luxGUfXMSvgY0z+
         bb9Q==
X-Gm-Message-State: AC+VfDxxfRvfIclukGSXJvLlGRcBrTbKbyLZtAPmkrK3svqJpAH4g0AW
        n63c6nSDSEaHXaX5WgLbpa+t3MnGZLMVxAGe8WVzaLSUmFyD1QJdomq6eckjbZRjTc/pOSJx173
        SRG/p2OSZyN/CS4hip9F1v7WporSZsTm65+szzXmX4pdDQjcN9rZDUtX/BwW34iI=
X-Google-Smtp-Source: ACHHUZ4iRnvq18MYSybVZFjdpyCKC75RinH94BodI7XsWv2S42dHn4dvD0vNbFa7NrqBAm7L3HYE93TQi7uaWw==
X-Received: from sokac.sfo.corp.google.com ([2620:15c:11a:202:c840:d0a6:cdac:7ad4])
 (user=sokcevic job=sendgmr) by 2002:a25:8206:0:b0:ba8:6dc0:cacf with SMTP id
 q6-20020a258206000000b00ba86dc0cacfmr141750ybk.12.1686716264937; Tue, 13 Jun
 2023 21:17:44 -0700 (PDT)
Date:   Tue, 13 Jun 2023 21:16:27 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614041626.2979067-2-sokcevic@google.com>
Subject: [PATCH] diff-lib: honor override_submodule_config flag bit
From:   Josip Sokcevic <sokcevic@google.com>
To:     git@vger.kernel.org
Cc:     Josip Sokcevic <sokcevic@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `diff.ignoreSubmodules = all` is set and a submodule commit is
manually staged, `git-commit` should accept it.

`index_differs_from` is called from `prepare_to_commit` with flags set to
`override_submodule_config = 1`. `index_differs_from` then merges the
default diff flags and passed flags.

When `diff.ignoreSubmodules` is set to "all", `flags` ends up having
both `override_submodule_config` and `ignore_submodules` set to 1. This
results in `git-commit` ignoring staged commits.

This patch restores original `flags.ignore_submodule` if
`flags.override_submodule_config` is set.
---
 diff-lib.c                  |  7 ++++++-
 t/t7406-submodule-update.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index 60e979dc1b..75859bd159 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -669,8 +669,13 @@ int index_differs_from(struct repository *r,
 	setup_revisions(0, NULL, &rev, &opt);
 	rev.diffopt.flags.quick = 1;
 	rev.diffopt.flags.exit_with_status = 1;
-	if (flags)
+	if (flags) {
 		diff_flags_or(&rev.diffopt.flags, flags);
+		// Now that flags are merged, honor override_submodule_config
+		// and ignore_submodules from passed flags.
+		if ((*flags).override_submodule_config)
+			rev.diffopt.flags.ignore_submodules = (*flags).ignore_submodules;
+	}
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
 	has_changes = rev.diffopt.flags.has_changes;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index f094e3d7f3..0e3fa642dd 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1179,4 +1179,32 @@ test_expect_success 'submodule update --recursive skip submodules with strategy=
 	test_cmp expect.err actual.err
 '
 
+add_submodule_commits_and_validate () {
+	HASH=$(git rev-parse HEAD) &&
+	git update-index --add --cacheinfo 160000,$HASH,sub &&
+	git commit -m "create submodule" &&
+	git ls-tree HEAD >output &&
+	test_i18ngrep "$HASH" output &&
+
+	rm output
+}
+
+
+test_expect_success 'commit with staged submodule change' '
+	add_submodule_commits_and_validate
+'
+
+
+test_expect_success 'commit with staged submodule change with ignoreSubmodules dirty' '
+	git config diff.ignoreSubmodules dirty &&
+	add_submodule_commits_and_validate &&
+	git config --unset diff.ignoreSubmodules
+'
+
+test_expect_success 'commit with staged submodule change with ignoreSubmodules all' '
+	git config diff.ignoreSubmodules all &&
+	add_submodule_commits_and_validate &&
+	git config --unset diff.ignoreSubmodules
+'
+
 test_done
-- 
2.41.0.162.gfafddb0af9-goog

