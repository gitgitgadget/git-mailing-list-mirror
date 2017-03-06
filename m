Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76CA920133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754348AbdCFVHB (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:07:01 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33468 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754023AbdCFVGx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:06:53 -0500
Received: by mail-pf0-f181.google.com with SMTP id w189so65058991pfb.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 13:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V0JhAcnpxiM2VlG5w6+xKaTGafiEhdH/XQ0qDFL/cdE=;
        b=Cy8lMQ401uRp5kBZoIfzzhQzRT8gHMxxAsUmRyGHMjdI9eAbix10voRTSPIX+gLvWP
         LeIUsi0igFjOaTFtdaPusaiBPQ/243SR1LXLj4rYZJ2fURsr3F964cwozaFbgwLBhfJc
         ZFLFhjkBaIlIoV9gdw40q17qAswvaJGifb60BWL3sdaiP3m5OF0hHqpDEKtu0q3tEjKJ
         SzOGVLMLT6iYxD/d67AMf3G/nEOamE0F6zYShbwI+BoPMOSee+pCzojbhKTpCRn9HR+e
         6I2oHY7XOv/6H5vjT9uB13YjbM8UQKgiz/gvM/r/6/jCpKeM7HTEGcTip/dIxj4l8Gzc
         RUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V0JhAcnpxiM2VlG5w6+xKaTGafiEhdH/XQ0qDFL/cdE=;
        b=uO3DQTso4bY8E0XsHOTacC2etLy4KLJACl5ehKExmZCzMGPFpwmQddxQoY582apFCz
         QEQ2Ym2wRyB9hPuyWV39QwHNKFyvDvvK+Lmcik93MAOMBZORwePOj3SyVclIrnEj35rc
         STxSOypPmi1/rKEoywUte/OfSrbRQP+QgAlTyvJethYujVVGxQWhj/OQpr7WDJ7KQtJR
         ri7iz0p9N3oVVehJExNF71d7QaQSTc860ggJTOOWxOrQYkAAWrEz3ZconlH8MWoDzpXm
         JA6ahUegzDjQX4aHzcPHvC0TPmHz3eLY/oDVIa+inua08Y92IgEHyULZB4h5LAjJe6zV
         PVIA==
X-Gm-Message-State: AMke39l7jtu5hRQ+d9t5vFz9uG2Ty+zVx+G/iSolZgeOvPeJCIjsFsiZw3ij0LOv4WHXO97q
X-Received: by 10.99.131.198 with SMTP id h189mr23233639pge.161.1488833972419;
        Mon, 06 Mar 2017 12:59:32 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id y184sm41528804pgd.45.2017.03.06.12.59.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:31 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 07/18] connect_work_tree_and_git_dir: safely create leading directories
Date:   Mon,  6 Mar 2017 12:59:08 -0800
Message-Id: <20170306205919.9713-8-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
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

