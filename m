Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C2120135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932144AbdCIBab (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:30:31 -0500
Received: from forward7j.cmail.yandex.net ([5.255.227.108]:46842 "EHLO
        forward7j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754732AbdCIBaa (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2017 20:30:30 -0500
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [IPv6:2a02:6b8:0:801::ab])
        by forward7j.cmail.yandex.net (Yandex) with ESMTP id B6DA9221E7;
        Thu,  9 Mar 2017 04:27:48 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp1j.mail.yandex.net (Yandex) with ESMTP id B4A6C3C807F1;
        Thu,  9 Mar 2017 04:27:44 +0300 (MSK)
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id OBpXAf9TTu-RimK1CYI;
        Thu, 09 Mar 2017 04:27:44 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489022864;
        bh=qiYuF2A+xRSHiV79b2UBkppqWCDiuiO9d/pmscHXk4E=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=x11R9fBoFWF1vkP20OpxWnF8D+M6b3hTfsePW0lbIMpeYV4a0uFIQCnsrthMXuH3Z
         1FoY0S5GauUs7Abonvx5AM2Sk0m9ck1c11QaW89aGZk81pUPBGiEAE/YbgiAYQJGYa
         Ozgi0qLs12A9+xJz5NLkJVpJRk7kg0xXqjbMaA+8=
Authentication-Results: smtp1j.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-ForeignMX:  US
X-Yandex-Suid-Status: 1 0,1 0,1 0,1 1130000030716801,1 0
From:   Valery Tolstov <me@vtolstov.org>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, sbeller@google.com, me@vtolstov.org,
        gitster@pobox.com
Subject: [PATCH v3 1/2] connect_work_tree_and_git_dir: safely create leading directories
Date:   Thu,  9 Mar 2017 04:27:33 +0300
Message-Id: <20170309012734.21541-2-me@vtolstov.org>
X-Mailer: git-send-email 2.12.0.192.gbdb9d28a5
In-Reply-To: <20170309012734.21541-1-me@vtolstov.org>
References: <20170309003858.GB153031@google.com>
 <20170309012734.21541-1-me@vtolstov.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

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
index 4541f9e14..6f52af7ab 100644
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
index 3b98766a6..45e93a1d5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1445,8 +1445,6 @@ void absorb_git_dir_into_superproject(const char *prefix,
 
 	/* Not populated? */
 	if (!sub_git_dir) {
-		char *real_new_git_dir;
-		const char *new_git_dir;
 		const struct submodule *sub;
 
 		if (err_code == READ_GITFILE_ERR_STAT_FAILED) {
@@ -1469,13 +1467,8 @@ void absorb_git_dir_into_superproject(const char *prefix,
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
2.12.0.192.gbdb9d28a5

