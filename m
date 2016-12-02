Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1E371FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 23:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755299AbcLBXnZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 18:43:25 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35054 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbcLBXnR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 18:43:17 -0500
Received: by mail-pf0-f169.google.com with SMTP id i88so54747292pfk.2
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 15:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JGLs9JpkZuoU+Vtqk1fNBjPWLd4VN7wx2+ipk1PJlI0=;
        b=lIlLn0fvlaCJfSTH1l5sz2fv1UAjk0Wtp3upXcAFdnzSo9n9iaUaRw+AnIOX+TeLb8
         45wH7z1ZhFZnTkpt3GOjacYDZj8+1S3aJ3Lob8tWTzpdkiDw4I4nht1PHsAkeGf76Wwz
         /kQw9W9X5ro3R9f/+YT8cEiKPQZFAHmEyIifMLyJyTxnM2lyd1UNX0gdptSGtDM6lzzS
         bB6KOcuJa4Nv1m05/PFDV9AP7DCxwJYT/WyFRGP5vxNXQ8X9x0Syasngp3acZOFL0DB1
         PU9009kWvLWU80Tcf1HJD2yKj6Ex4NwxV7orsKzVGbH1P1BZc03NSO98etnRy0XI4NuZ
         1uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JGLs9JpkZuoU+Vtqk1fNBjPWLd4VN7wx2+ipk1PJlI0=;
        b=JR7hrVikE/wkgUU6daikIKjCyqR5IHhNensxePoYTwX1etK+MgR2JRKqllLSPVE7Lr
         ILe77INyMywEBpPA8DxW/8w2y7wxC/YeTmJ3OQC/oCaXfsDi/Y8VBmNcvNn9nkmWOlPv
         DzdL4Rh7qtlEROvkIvYzNKCEQbuIIqCP7jr65wv9JSi9ko0RfQ2TxcQhsh/2tdJfmayw
         wuoTEQxrzrjw/icL6JAemu8sZDqw0KZOw8tpKNyOxDat8OPclwVp9zv9KGHjRpIIahqC
         QINFqAyDDiC9LIioH58tLn0pAj+BlM7pIeFiBTIIodna5QxnxL04EuLQueN4LuzxGrkS
         29/A==
X-Gm-Message-State: AKaTC03aL7sZ4egMEWjFqgkhMVWbHCob60sV1gawagHbSRsbVkJ4vGxAvkPTjDm+oeLMv2wC
X-Received: by 10.99.171.10 with SMTP id p10mr83365022pgf.36.1480722148350;
        Fri, 02 Dec 2016 15:42:28 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id p79sm10143556pfj.51.2016.12.02.15.42.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 15:42:27 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com, bmwill@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 4/5] worktree: get worktrees from submodules
Date:   Fri,  2 Dec 2016 15:42:19 -0800
Message-Id: <20161202234220.24664-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161202234220.24664-1-sbeller@google.com>
References: <20161202234220.24664-1-sbeller@google.com>
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
 worktree.c | 47 +++++++++++++++++++++++++++++++++++++----------
 worktree.h |  6 ++++++
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/worktree.c b/worktree.c
index eb6121263b..fa2b6dfa9a 100644
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
@@ -209,6 +211,31 @@ struct worktree **get_worktrees(unsigned flags)
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
+	const char *submodule_common_dir;
+	struct strbuf sb = STRBUF_INIT;
+	struct worktree **ret;
+
+	submodule_gitdir = git_pathdup_submodule(path, "%s", "");
+	if (!submodule_gitdir)
+		return NULL;
+
+	/* the env would be set for the superproject */
+	get_common_dir_noenv(&sb, submodule_gitdir);
+	submodule_common_dir = strbuf_detach(&sb, NULL);
+	ret = get_worktrees_internal(submodule_common_dir, flags);
+
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
2.11.0.rc2.28.g2673dad

