Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793AB2023D
	for <e@80x24.org>; Thu,  2 Mar 2017 00:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753907AbdCBA5F (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 19:57:05 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33707 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbdCBA4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 19:56:50 -0500
Received: by mail-pg0-f49.google.com with SMTP id 25so25858445pgy.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 16:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V0JhAcnpxiM2VlG5w6+xKaTGafiEhdH/XQ0qDFL/cdE=;
        b=s0hhSp07Ggb41jfhwjKFT0p88Vg3BdvcKAOgytqP26rayVCFy78HdjGj59LZm0g6S+
         cHjifjLHDg72sw/Ykr7Ul12bTgpUBvby8Ialn8duNOkxILVNIttofVDC0IDo40yAxs3G
         UaGz/Rw73muwNXYjXCcGrl95H2WplJavFbKhQw0OQBl7EldL7XDk1QDIgq0FKebOdfvH
         XUSrflhiCUykI977pF56/7ujsYTEnk+WPQKpj+/myc0wd6+Rcf0cV2OMf+sbORUHda6Q
         lCQrLuZPbTTfaNIqMwIXWhzR8F+grZQPSa1Hu/MGwLrP95Wew1hlRlREJpf0PlBefAkE
         nutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V0JhAcnpxiM2VlG5w6+xKaTGafiEhdH/XQ0qDFL/cdE=;
        b=DSQmI4T44JpN8NwZXh9ohLZBgfduO0t5k1s+SwvlgozWndTRAds11KN96duRdeCec5
         xHM1ksuUU8etFUI7Un5ZCWrGJ/4rb95V21q/njzx9owH+TDo4lWG3PZ9oLiYBEtNdQwg
         nfhqnWFP68gvh5Qku8dRS0jkl9k9TwvVmbI7EUL1AGG0rmyH1WVTAIbQhv6+lt4fCdPV
         VxERzuEDWOw4AQOI7xTXGkNNL9FUGW1h1LyMqHWg1hmT2bKhdqUXHsUY4JuiOjjDdAIa
         6cFwLdZb2ghykXBrnQkZi/f87vgFEL3/ulPVkWoFyPztuiuZVN/zr5hDSyhtxBtvG/9F
         ZGJg==
X-Gm-Message-State: AMke39lGMag8wpPRJxQk2s2uXuK57k0+K+c6BYOiLCu8OE3s4BBMOg1q8Abi9E7LrValSZFL
X-Received: by 10.99.142.193 with SMTP id k184mr12250332pge.176.1488415692619;
        Wed, 01 Mar 2017 16:48:12 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id o26sm12843074pgd.25.2017.03.01.16.48.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:11 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 07/18] connect_work_tree_and_git_dir: safely create leading directories
Date:   Wed,  1 Mar 2017 16:47:48 -0800
Message-Id: <20170302004759.27852-8-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we'll use connect_work_tree_and_git_dir when the
directory for the gitlink file doesn't exist yet. This patch makes
connect_work_tree_and_git_dir safe to use for both cases of
either the git dir or the working dir missing.

To do so, we need to call safe_create_leading_directories[_const]
on both directories. However this has to happen before we construct
the absolute paths as real_pathdup assumes the directories to
be there already.

So for both the config file in the git dir as well as the .git link
file we need to
a) construct the name
b) call SCLD
c) get the absolute path
d) once a-c is done for both we can consume the absolute path
   to compute the relative path to each other and store those
   relative paths.

The implementation provided here puts a) and b) for both cases first,
and then performs c and d after.

One of the two users of 'connect_work_tree_and_git_dir' already checked
for the directory being there, so we can loose that check as
connect_work_tree_and_git_dir handles this functionality now.

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
2.12.0.rc1.52.ge239d7e709.dirty

