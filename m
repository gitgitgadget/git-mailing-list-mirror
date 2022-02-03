Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3274FC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 21:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355635AbiBCV7a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 16:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355617AbiBCV72 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 16:59:28 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE6AC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 13:59:28 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u185-20020a2560c2000000b0060fd98540f7so8940460ybb.0
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 13:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0bW3HvWq+MNcSsDABqymNS//hevwrVMJvogQTZn5SyI=;
        b=b+6vy1wSH+QP2rGEbAnl0bGlfFHJwFto4VW+9tSd4ughcxMHSWtSzdSxtozcQxTdRp
         y7gFj8e+A1rlSPrIOI+OJGzIvnHU/PXNRhQ7sq5ag5roveSysd5+cS0HQBQyEIwyREUU
         OLtELHFhkazHdZON98Mo/5z0jF9IQK26bLVKhcuR+Z9dOCCBJKtZx2hx1lKbtUdLnqBH
         Mbr1pvXJYiw4jYKM6I+o0UVNCpncIt6Q7Ia1fwVSmTiqQ4H60RF2oubu3fosQsm52yEa
         BvKt0N35/ZZxNZFNbbjNRtiIAqddWkC94TRJ9NUlR9Y58bUt+2JVJTd6PPas7C0aNrOR
         Z4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0bW3HvWq+MNcSsDABqymNS//hevwrVMJvogQTZn5SyI=;
        b=kLD8YrOqLLJWuzgP9/5UrnK7ufXgeF23hlm7p++8yqL476KrrJg4Z9IcRkeirTqI7I
         qI+86WhgZwleGZ1dZYq4nOYwIkIEllqR77CeSgd6Bz0sWM3plq7DX1pas11Pe0z0cPSK
         z5Tyy+v+Et0WoxGoUp00OTletX9cvQf/Q8MWxuVKm/Cu6/YqMUi8b7owyNLIttb2Gi9F
         kaa88EISEdWdBUByF1ydNhkyAFQ0TIJ2ig7mzrovHFC+bPmfVbCY3QoRERiKJCDvnah8
         4k16zOFF4npZoVF1JX3aeXq0m+CN4f+Vz6BUwqZdJN12u/57ezVqTDcoGoNyPsXwNpWD
         tkaw==
X-Gm-Message-State: AOAM533yiBhmG50ZlrAGNZg1PhcuyE4+C86l0B+26npHAbIahzfUYXtf
        pXAIxlrpGgNmlNwjV+VbLbS6L1YlcG5cGA+QaiGQ/AZxuT+MUtLvqLFvIe1lUq3L7UCcAShI3Yd
        koRqkfpUZOzZizVeOsBR5ePwAkUzzc9JOPW2euF/iQ3LVNmMFZcaMnPyowsREhBtMSX6PcJ5bQw
        ==
X-Google-Smtp-Source: ABdhPJzcq/49aov99Cdffyzl1IbcDtMBf6OO8NozNFVZfDhTaeOxmKb4QEQf+LeMCQClFjln5WCmtHNy1fnNUQD+jMs=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:662:cd2f:9dc:846b])
 (user=emilyshaffer job=sendgmr) by 2002:a25:6e8b:: with SMTP id
 j133mr214532ybc.148.1643925567519; Thu, 03 Feb 2022 13:59:27 -0800 (PST)
Date:   Thu,  3 Feb 2022 13:59:13 -0800
In-Reply-To: <20220203215914.683922-1-emilyshaffer@google.com>
Message-Id: <20220203215914.683922-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20220203215914.683922-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 3/4] submodule: record superproject gitdir during absorbgitdirs
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Already during 'git submodule add' we record a pointer to the
superproject's gitdir. However, this doesn't help brand-new
submodules created with 'git init' and later absorbed with 'git
submodule absorbgitdirs'. Let's start adding that pointer during 'git
submodule absorbgitdirs' too.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/config/submodule.txt |  3 +-
 submodule.c                        | 23 +++++++++
 t/t7412-submodule-absorbgitdirs.sh | 82 +++++++++++++++++++++++++++++-
 3 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index bebd25684e..f801f49ea1 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -98,4 +98,5 @@ submodule.superprojectGitDir::
 	reference to determine whether the current repo is a submodule to
 	another repo; if this reference is absent, Git will treat the current
 	repo as though it is not a submodule (this does not make a difference to
-	most Git commands). It is set automatically during submodule creation.
+	most Git commands). It is set automatically during submodule creation
+	and 'git submodule absorbgitdir'.
diff --git a/submodule.c b/submodule.c
index c689070524..d7395c7551 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2097,6 +2097,9 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
 	const struct submodule *sub;
+	struct config_set sub_cs;
+	struct strbuf config_path = STRBUF_INIT, sb = STRBUF_INIT;
+	int tmp;
 
 	if (submodule_uses_worktrees(path))
 		die(_("relocate_gitdir for submodule '%s' with "
@@ -2127,6 +2130,26 @@ static void relocate_single_git_dir_into_superproject(const char *path)
 
 	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
 
+	/*
+	 * Note location of superproject's gitdir. Because the submodule already
+	 * has a gitdir and local config, we can store this pointer from
+	 * worktree config to worktree config, if the submodule has
+	 * extensions.worktreeConfig set.
+	 */
+	strbuf_addf(&config_path, "%s/config", real_new_git_dir);
+	git_configset_init(&sub_cs);
+	git_configset_add_file(&sub_cs, config_path.buf);
+	/* return 0 indicates config was found - we have a worktree config */
+	if (!git_configset_get_bool(&sub_cs, "extensions.worktreeConfig", &tmp))
+		strbuf_addstr(&config_path, ".worktree");
+
+	git_config_set_in_file(config_path.buf, "submodule.superprojectGitdir",
+			       relative_path(absolute_path(get_git_dir()),
+					     real_new_git_dir, &sb));
+
+	git_configset_clear(&sub_cs);
+	strbuf_release(&config_path);
+	strbuf_release(&sb);
 	free(old_git_dir);
 	free(real_old_git_dir);
 	free(real_new_git_dir);
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 1cfa150768..5753f90268 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -30,7 +30,17 @@ test_expect_success 'absorb the git dir' '
 	git status >actual.1 &&
 	git -C sub1 rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
-	test_cmp expect.2 actual.2
+	test_cmp expect.2 actual.2 &&
+
+	# make sure the submodule cached the superproject gitdir correctly
+	submodule_gitdir="$(git -C sub1 rev-parse --path-format=absolute --git-common-dir)" &&
+	superproject_gitdir="$(git rev-parse --path-format=absolute --git-common-dir)" &&
+
+	test-tool path-utils relative_path "$superproject_gitdir" \
+		"$submodule_gitdir" >expect &&
+	git -C sub1 config submodule.superprojectGitDir >actual &&
+
+	test_cmp expect actual
 '
 
 test_expect_success 'absorbing does not fail for deinitialized submodules' '
@@ -61,7 +71,16 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	git status >actual.1 &&
 	git -C sub1/nested rev-parse HEAD >actual.2 &&
 	test_cmp expect.1 actual.1 &&
-	test_cmp expect.2 actual.2
+	test_cmp expect.2 actual.2 &&
+
+	sub1_gitdir="$(git -C sub1 rev-parse --path-format=absolute --git-common-dir)" &&
+	sub1_nested_gitdir="$(git -C sub1/nested rev-parse --path-format=absolute --git-common-dir)" &&
+
+	test-tool path-utils relative_path "$sub1_gitdir" "$sub1_nested_gitdir" \
+		>expect &&
+	git -C sub1/nested config submodule.superprojectGitDir >actual &&
+
+	test_cmp expect actual
 '
 
 test_expect_success 're-setup nested submodule' '
@@ -130,4 +149,63 @@ test_expect_success 'absorbing fails for a submodule with multiple worktrees' '
 	test_i18ngrep "not supported" error
 '
 
+test_expect_success 'absorbgitdirs works when called from a superproject worktree' '
+	# set up a worktree of the superproject
+	git worktree add wt &&
+	(
+	cd wt &&
+
+	# create a new unembedded git dir
+	git init sub4 &&
+	test_commit -C sub4 first &&
+	git submodule add ./sub4 &&
+	test_tick &&
+
+	# absorb the git dir
+	git submodule absorbgitdirs sub4 &&
+
+	# make sure the submodule noted the superproject gitdir correctly
+	submodule_gitdir="$(git -C sub4 rev-parse --absolute-git-dir)" &&
+	superproject_gitdir="$(git rev-parse --absolute-git-dir)" &&
+
+	test-tool path-utils relative_path "$superproject_gitdir" \
+		"$submodule_gitdir" >expect &&
+	git -C sub4 config submodule.superprojectGitDir >actual &&
+
+	test_cmp expect actual
+	)
+'
+
+test_expect_success 'absorbgitdirs works with a submodule with worktree config' '
+	# reuse the worktree of the superproject
+	(
+	cd wt &&
+
+	# create a new unembedded git dir
+	git init sub5 &&
+	test_commit -C sub5 first &&
+	git submodule add ./sub5 &&
+	test_tick &&
+
+	# turn on worktree configs for submodule
+	git -C sub5 config extensions.worktreeConfig true &&
+
+	# absorb the git dir
+	git submodule absorbgitdirs sub5 &&
+
+	# make sure the submodule noted the superproject gitdir correctly
+	submodule_gitdir="$(git -C sub5 rev-parse --absolute-git-dir)" &&
+	superproject_gitdir="$(git rev-parse --absolute-git-dir)" &&
+
+	test-tool path-utils relative_path "$superproject_gitdir" \
+		"$submodule_gitdir" >expect &&
+	git -C sub5 config submodule.superprojectGitDir >actual &&
+
+	test_cmp expect actual &&
+
+	# make sure the config went into the submodule config.worktree
+	test_file_not_empty "$submodule_gitdir/config.worktree"
+	)
+'
+
 test_done
-- 
2.35.0.263.gb82422642f-goog

