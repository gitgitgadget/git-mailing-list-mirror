Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51A77206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 19:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbcLLTEs (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:04:48 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33766 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753235AbcLLTEq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:04:46 -0500
Received: by mail-pf0-f180.google.com with SMTP id d2so13955043pfd.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 11:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qvP1fQLdTFQsMlVmMmCNUmug/HgNS1AvtrY2ziByn3U=;
        b=WJhv2tA8RYywIIKqtcvi8zda4XiK/4uIytRmvROvcPxB0jgX74eIFOy9vOW5F0xgqL
         29uxE2tdvEiM1yj+B8mZbbK1C/sO4etF77gFf5ZFUhrFv+uEKdsv8zPlPbMvsbS2Y/yl
         iOGzzh/IGsnAPpe3UNjFRflo2StahbYiNU5cBxGXgHLLSSxT3t9qq9iFAY7lr9u+LZjn
         c4ttFEAyrATXqLA2hjxRTInpFD8O6BtXe6OYk2yn5Hf8Eu4xIKfu8tXcE/DFdYRYtuWm
         ba+0TVm0/JzwpcPJacfvE7yUkR83cqed6UbHWEsGMM/4q1gtpysQf5e5XyCpu92fRKpw
         suSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qvP1fQLdTFQsMlVmMmCNUmug/HgNS1AvtrY2ziByn3U=;
        b=WFpUde5y85otC/kJV3jtDgCXxku4ziTj07ngTxrKUeiu0+DNI3/Ly0RgWjs/Zn0X7L
         6Rl2egU1b8ueCM/xik0pLmdEhhtWcV+cB38OHGR6BHRbksWryQ/MykpOJKql6LeEYJi7
         uY7+2/SP+hFcvtLJNZqkCmQmcpm4UtCJ8FQ9gLlbaNnnRkZQYGtTbbaZ7kr4OyMAcjOK
         2wS/ZThSRTu/wrKFZ3vVLxsd9AxrP2ZSCgqp9PKc5b922cqp/5ooOrC11kCfBcIeh3LI
         EGlRKvIaW9s/QkvYpzjHI+RsP2rIHhLPawtqvPXUn4vBDXrwzU9Tzl09QMeIAKnagvjj
         b1+A==
X-Gm-Message-State: AKaTC01TlVcGV83zKWq73MbvbIbd5dNdRAMCn9Fu+fgKP+eojvegbe2VOuQqxJRqTrP01veX
X-Received: by 10.98.211.135 with SMTP id z7mr98233714pfk.109.1481569485728;
        Mon, 12 Dec 2016 11:04:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:642c:37a4:3709:a2b3])
        by smtp.gmail.com with ESMTPSA id z9sm77319891pfd.29.2016.12.12.11.04.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Dec 2016 11:04:45 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 4/6] worktree: check if a submodule uses worktrees
Date:   Mon, 12 Dec 2016 11:04:33 -0800
Message-Id: <20161212190435.10358-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.49.ge1f3b0c.dirty
In-Reply-To: <20161212190435.10358-1-sbeller@google.com>
References: <20161212190435.10358-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we want to move around the the git directory of
a submodule. Both submodules as well as worktrees are involved in
placing git directories at unusual places, so their functionality
may collide. To react appropriately to situations where worktrees
in submodules are in use, offer a new function to query the
a submodule if it uses the worktree feature.

An earlier approach:
  "Implement submodule_get_worktrees and just count them", however:
  This can be done cheaply (both in new code to write as well as run time)
  by obtaining the list of worktrees based off that submodules git
  directory. However as we have loaded the variables for the current
  repository, the values in the submodule worktree
  can be wrong, e.g.
  * core.ignorecase may differ between these two repositories
  * the ref resolution is broken (refs/heads/branch in the submodule
    resolves to the sha1 value of the `branch` in the current repository
    that may not exist or have another sha1)

The implementation here is just checking for any files in
$GIT_COMMON_DIR/worktrees for the submodule, which ought to be sufficient
if the submodule is using the current repository format, which we also
check.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 worktree.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h |  5 +++++
 2 files changed, 55 insertions(+)

diff --git a/worktree.c b/worktree.c
index eb6121263b..d4606aa8cd 100644
--- a/worktree.c
+++ b/worktree.c
@@ -380,3 +380,53 @@ const struct worktree *find_shared_symref(const char *symref,
 
 	return existing;
 }
+
+int submodule_uses_worktrees(const char *path)
+{
+	char *submodule_gitdir;
+	struct strbuf sb = STRBUF_INIT;
+	DIR *dir;
+	struct dirent *d;
+	int ret;
+	struct repository_format format;
+
+	submodule_gitdir = git_pathdup_submodule(path, "%s", "");
+	if (!submodule_gitdir)
+		return 0;
+
+	/* The env would be set for the superproject. */
+	get_common_dir_noenv(&sb, submodule_gitdir);
+
+	/*
+	 * The check below is only known to be good for repository format
+	 * version 0 at the time of writing this code.
+	 */
+	strbuf_addstr(&sb, "/config");
+	read_repository_format(&format, sb.buf);
+	if (format.version != 0) {
+		strbuf_release(&sb);
+		return 1;
+	}
+
+	/* Replace config by worktrees. */
+	strbuf_setlen(&sb, sb.len - strlen("config"));
+	strbuf_addstr(&sb, "worktrees");
+
+	/* See if there is any file inside the worktrees directory. */
+	dir = opendir(sb.buf);
+	strbuf_release(&sb);
+	free(submodule_gitdir);
+
+	if (!dir)
+		return 0;
+
+	while ((d = readdir(dir)) != NULL) {
+		if (is_dot_or_dotdot(d->d_name))
+			continue;
+
+		ret = 1;
+		break;
+	}
+	closedir(dir);
+	return ret;
+}
diff --git a/worktree.h b/worktree.h
index d59ce1fee8..6bfb985203 100644
--- a/worktree.h
+++ b/worktree.h
@@ -27,6 +27,11 @@ struct worktree {
  */
 extern struct worktree **get_worktrees(unsigned flags);
 
+/*
+ * Returns 1 if linked worktrees exist, 0 otherwise.
+ */
+extern int submodule_uses_worktrees(const char *path);
+
 /*
  * Return git dir of the worktree. Note that the path may be relative.
  * If wt is NULL, git dir of current worktree is returned.
-- 
2.11.0.rc2.49.ge1f3b0c.dirty

