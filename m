Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BECB1FF7F
	for <e@80x24.org>; Thu,  8 Dec 2016 01:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933935AbcLHBqt (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 20:46:49 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32951 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933153AbcLHBqq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 20:46:46 -0500
Received: by mail-pf0-f175.google.com with SMTP id d2so80325113pfd.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 17:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2XLCTaTZD9eYld0SPetZYxO3mT8U/ZXbH0vgL2HiWZY=;
        b=Yg41KOBJkwoQHwL0XXA8xnFwQxur3LnY4c01yTK5aZ1AARmypL51tjizfFvSOjFrtN
         OAhc2wfsiH4I8+1DkiWepRZJPdCEK0afaBCKULOjr8kWp/Q7eg8rCMykq9WLqTGFs1oL
         TuGlw3ZzR2Bt4OBD5laKVQxUzsCg0FX4jVubciKTuJ4Y7DdAbxHTVP1Yalrkd9PMMIjy
         avYQ9cSIwb86WSaEyp3NxAJKdlG8YC+OXBGrkCfBkhKbZdNny2zODxhWJvwASgQdsJ+m
         1nADT6qLuw7ml1Y+f55SpQ4N4DvDn/TxbzkrQMn2Oe+m6yYdwRmMVe1NMvEMZFGgv1Jz
         gYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2XLCTaTZD9eYld0SPetZYxO3mT8U/ZXbH0vgL2HiWZY=;
        b=IHIqqoNypQW6nWEe9SC6En9sHrasSCRXn8TCbEeaSDupH4UZQXUgp0h2FbleFxWhog
         50CZyHgVczN5YBEXTIQadwwLBgVPMW2gTG5Xjy1F9YTrb8INd1W25aqw5V78IyKoobEI
         pLDs6msKXk7JnRuiToEb6ClbOGvu8Ov2hL3Rfw0k2nH5cA40s6KNfWh8RoEFMqYsFeZ4
         JXKBUmdAOji0FDsDxiCN4PXCsDirZsFZPL1I01RWbc7uYwbpMVLMPpTwpc6c/i7juPRN
         rNZj8Uu8o5CeurQXhU/gA3htCCDmwo2bvUef9OBhv+ytvPZHqFD1y4mh8d5Lw99xLgnD
         etsA==
X-Gm-Message-State: AKaTC00O9p6SWhb2pUcaNNmCBKWt9Nrhp9mIUdbavoU2UZY+DdRPF3J/j3PPVi4oxmZbqN9c
X-Received: by 10.99.171.10 with SMTP id p10mr126422823pgf.36.1481161605428;
        Wed, 07 Dec 2016 17:46:45 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2441:4f9a:ad0f:a8d7])
        by smtp.gmail.com with ESMTPSA id r21sm45304474pfd.44.2016.12.07.17.46.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 17:46:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv6 4/7] worktree: get worktrees from submodules
Date:   Wed,  7 Dec 2016 17:46:20 -0800
Message-Id: <20161208014623.7588-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.gc512cbd.dirty
In-Reply-To: <20161208014623.7588-1-sbeller@google.com>
References: <20161208014623.7588-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch we want to move around the the git directory of
a submodule. Both submodules as well as worktrees are involved in
placing git directories at unusual places, so their functionality
may collide. To react appropriately to situations where worktrees
in submodules are in use, offer a new function to query the
worktrees for submodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 worktree.c | 46 ++++++++++++++++++++++++++++++++++++----------
 worktree.h |  6 ++++++
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/worktree.c b/worktree.c
index eb6121263b..75db689672 100644
--- a/worktree.c
+++ b/worktree.c
@@ -72,7 +72,7 @@ static void add_head_info(struct strbuf *head_ref, struct worktree *worktree)
 /**
  * get the main worktree
  */
-static struct worktree *get_main_worktree(void)
+static struct worktree *get_main_worktree(const char *git_common_dir)
 {
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -81,12 +81,12 @@ static struct worktree *get_main_worktree(void)
 	int is_bare = 0;
 	int is_detached = 0;
 
-	strbuf_add_absolute_path(&worktree_path, get_git_common_dir());
+	strbuf_add_absolute_path(&worktree_path, git_common_dir);
 	is_bare = !strbuf_strip_suffix(&worktree_path, "/.git");
 	if (is_bare)
 		strbuf_strip_suffix(&worktree_path, "/.");
 
-	strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
+	strbuf_addf(&path, "%s/HEAD", git_common_dir);
 
 	worktree = xcalloc(1, sizeof(*worktree));
 	worktree->path = strbuf_detach(&worktree_path, NULL);
@@ -101,7 +101,8 @@ static struct worktree *get_main_worktree(void)
 	return worktree;
 }
 
-static struct worktree *get_linked_worktree(const char *id)
+static struct worktree *get_linked_worktree(const char *git_common_dir,
+					    const char *id)
 {
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -112,7 +113,7 @@ static struct worktree *get_linked_worktree(const char *id)
 	if (!id)
 		die("Missing linked worktree name");
 
-	strbuf_git_common_path(&path, "worktrees/%s/gitdir", id);
+	strbuf_addf(&path, "%s/worktrees/%s/gitdir", git_common_dir, id);
 	if (strbuf_read_file(&worktree_path, path.buf, 0) <= 0)
 		/* invalid gitdir file */
 		goto done;
@@ -125,7 +126,7 @@ static struct worktree *get_linked_worktree(const char *id)
 	}
 
 	strbuf_reset(&path);
-	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
+	strbuf_addf(&path, "%s/worktrees/%s/HEAD", git_common_dir, id);
 
 	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
 		goto done;
@@ -167,7 +168,8 @@ static int compare_worktree(const void *a_, const void *b_)
 	return fspathcmp((*a)->path, (*b)->path);
 }
 
-struct worktree **get_worktrees(unsigned flags)
+static struct worktree **get_worktrees_internal(const char *git_common_dir,
+						unsigned flags)
 {
 	struct worktree **list = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -177,9 +179,9 @@ struct worktree **get_worktrees(unsigned flags)
 
 	list = xmalloc(alloc * sizeof(struct worktree *));
 
-	list[counter++] = get_main_worktree();
+	list[counter++] = get_main_worktree(git_common_dir);
 
-	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
+	strbuf_addf(&path, "%s/worktrees", git_common_dir);
 	dir = opendir(path.buf);
 	strbuf_release(&path);
 	if (dir) {
@@ -188,7 +190,7 @@ struct worktree **get_worktrees(unsigned flags)
 			if (is_dot_or_dotdot(d->d_name))
 				continue;
 
-			if ((linked = get_linked_worktree(d->d_name))) {
+			if ((linked = get_linked_worktree(git_common_dir, d->d_name))) {
 				ALLOC_GROW(list, counter + 1, alloc);
 				list[counter++] = linked;
 			}
@@ -209,6 +211,30 @@ struct worktree **get_worktrees(unsigned flags)
 	return list;
 }
 
+struct worktree **get_worktrees(unsigned flags)
+{
+	return get_worktrees_internal(get_git_common_dir(), flags);
+}
+
+struct worktree **get_submodule_worktrees(const char *path, unsigned flags)
+{
+	char *submodule_gitdir;
+	struct strbuf sb = STRBUF_INIT;
+	struct worktree **ret;
+
+	submodule_gitdir = git_pathdup_submodule(path, "%s", "");
+	if (!submodule_gitdir)
+		return NULL;
+
+	/* the env would be set for the superproject */
+	get_common_dir_noenv(&sb, submodule_gitdir);
+	ret = get_worktrees_internal(sb.buf, flags);
+
+	strbuf_release(&sb);
+	free(submodule_gitdir);
+	return ret;
+}
+
 const char *get_worktree_git_dir(const struct worktree *wt)
 {
 	if (!wt)
diff --git a/worktree.h b/worktree.h
index d59ce1fee8..157fbc4a66 100644
--- a/worktree.h
+++ b/worktree.h
@@ -27,6 +27,12 @@ struct worktree {
  */
 extern struct worktree **get_worktrees(unsigned flags);
 
+/*
+ * Get the worktrees of a submodule named by `path`.
+ */
+extern struct worktree **get_submodule_worktrees(const char *path,
+						 unsigned flags);
+
 /*
  * Return git dir of the worktree. Note that the path may be relative.
  * If wt is NULL, git dir of current worktree is returned.
-- 
2.11.0.rc2.30.gc512cbd.dirty

