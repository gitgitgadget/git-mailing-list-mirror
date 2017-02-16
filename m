Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D982013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756078AbdBPAi3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:38:29 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34240 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbdBPAi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:38:26 -0500
Received: by mail-pg0-f50.google.com with SMTP id z67so898562pgb.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ab+pmprdXVtKp0GRIqfmcH8Ei/YuCeO4vd/fPyYat7k=;
        b=vVphsGqwkCdXJoak0mxUc+zSMIV3UOE7o3QRIM8Er4G4zY64xN3+83OA+rUwZOXNge
         5klQHMGJgv36qPLmptZLUM2UlpxNcfYwEIaej1rBRmJY9hjfcFd6IGl7k3So8miJ3lFA
         hZu5PMMQ26bihgxGYtQ2oBX568FIK/6L4J50PEteQk6ICooQy+V5/rntcQpOwr4zEuK1
         N1cqmK7dkK/KjkY4Nb/rQ1Dw87P3c5l3jeA9WcW3eJcNyLiblBi9sygzd54qhFvikZpv
         IqfQ0mnvSPpiuQozsfeSBshXyVLorRQkD5j5EioUx9PhNxPxoxsU4c9cc06A+PElJVI6
         esgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ab+pmprdXVtKp0GRIqfmcH8Ei/YuCeO4vd/fPyYat7k=;
        b=es/KuLFJOZY6RnfRHUVd1qfRQXxTws9dblWSWA192vUiHuYxRU3xZGRqOJagXJoix4
         WBpwQpLXrQYVYzbXgZnLvNMT97GSAEd7lu2eNT0CqyoTpvy3bXpYiwtnDVWpbnXU0vcR
         bsg6mbH02Ix1oM0Kso/NoXroQfA0PpUZeU9NgwFWSEVYaSSYOM8CHj/gZjz876FNye/C
         UXQUqhbfaeGb8PcmLL7uJ9IJxpXel5u6yQDsrIlyTdIYZ3JB5Dm6sKt8WzbGDPsCHoyV
         rtBzlgdCfqABupEjfYok1IXVuaVoKFSWVXsQ5gObpzDCrPUNlZOhm7kwoutDce7QEZGE
         p8Aw==
X-Gm-Message-State: AMke39m7LrsLyIWukreW5i5fI/WxrEyjILC7bgGAVL9eY8R88Ewl1ygTJ9rkKniBjOhiJiwl
X-Received: by 10.98.138.155 with SMTP id o27mr40920318pfk.113.1487205505878;
        Wed, 15 Feb 2017 16:38:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2ca1:506:4965:89ed])
        by smtp.gmail.com with ESMTPSA id h14sm9626766pgn.41.2017.02.15.16.38.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:38:25 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/15] connect_work_tree_and_git_dir: safely create leading directories
Date:   Wed, 15 Feb 2017 16:38:01 -0800
Message-Id: <20170216003811.18273-6-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170216003811.18273-1-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
 <20170216003811.18273-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we'll use connect_work_tree_and_git_dir when the
directory for the gitlink file doesn't exist yet. Safely create
the directory first.

One of the two users of 'connect_work_tree_and_git_dir' already checked
for the directory being there, so we can loose that check.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 dir.c       | 32 +++++++++++++++++++++-----------
 submodule.c | 11 ++---------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/dir.c b/dir.c
index 4541f9e146..6f52af7abb 100644
--- a/dir.c
+++ b/dir.c
@@ -2728,23 +2728,33 @@ void untracked_cache_add_to_index(struct index_state *istate,
 /* Update gitfile and core.worktree setting to connect work tree and git dir */
 void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
 {
-	struct strbuf file_name = STRBUF_INIT;
+	struct strbuf gitfile_sb = STRBUF_INIT;
+	struct strbuf cfg_sb = STRBUF_INIT;
 	struct strbuf rel_path = STRBUF_INIT;
-	char *git_dir = real_pathdup(git_dir_);
-	char *work_tree = real_pathdup(work_tree_);
+	char *git_dir, *work_tree;
 
-	/* Update gitfile */
-	strbuf_addf(&file_name, "%s/.git", work_tree);
-	write_file(file_name.buf, "gitdir: %s",
-		   relative_path(git_dir, work_tree, &rel_path));
+	/* Prepare .git file */
+	strbuf_addf(&gitfile_sb, "%s/.git", work_tree_);
+	if (safe_create_leading_directories_const(gitfile_sb.buf))
+		die(_("could not create directories for %s"), gitfile_sb.buf);
+
+	/* Prepare config file */
+	strbuf_addf(&cfg_sb, "%s/config", git_dir_);
+	if (safe_create_leading_directories_const(cfg_sb.buf))
+		die(_("could not create directories for %s"), cfg_sb.buf);
 
+	git_dir = real_pathdup(git_dir_);
+	work_tree = real_pathdup(work_tree_);
+
+	/* Write .git file */
+	write_file(gitfile_sb.buf, "gitdir: %s",
+		   relative_path(git_dir, work_tree, &rel_path));
 	/* Update core.worktree setting */
-	strbuf_reset(&file_name);
-	strbuf_addf(&file_name, "%s/config", git_dir);
-	git_config_set_in_file(file_name.buf, "core.worktree",
+	git_config_set_in_file(cfg_sb.buf, "core.worktree",
 			       relative_path(work_tree, git_dir, &rel_path));
 
-	strbuf_release(&file_name);
+	strbuf_release(&gitfile_sb);
+	strbuf_release(&cfg_sb);
 	strbuf_release(&rel_path);
 	free(work_tree);
 	free(git_dir);
diff --git a/submodule.c b/submodule.c
index 0e55372f37..04d185738f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1442,8 +1442,6 @@ void absorb_git_dir_into_superproject(const char *prefix,
 
 	/* Not populated? */
 	if (!sub_git_dir) {
-		char *real_new_git_dir;
-		const char *new_git_dir;
 		const struct submodule *sub;
 
 		if (err_code == READ_GITFILE_ERR_STAT_FAILED) {
@@ -1466,13 +1464,8 @@ void absorb_git_dir_into_superproject(const char *prefix,
 		sub = submodule_from_path(null_sha1, path);
 		if (!sub)
 			die(_("could not lookup name for submodule '%s'"), path);
-		new_git_dir = git_path("modules/%s", sub->name);
-		if (safe_create_leading_directories_const(new_git_dir) < 0)
-			die(_("could not create directory '%s'"), new_git_dir);
-		real_new_git_dir = real_pathdup(new_git_dir);
-		connect_work_tree_and_git_dir(path, real_new_git_dir);
-
-		free(real_new_git_dir);
+		connect_work_tree_and_git_dir(path,
+			git_path("modules/%s", sub->name));
 	} else {
 		/* Is it already absorbed into the superprojects git dir? */
 		char *real_sub_git_dir = real_pathdup(sub_git_dir);
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

