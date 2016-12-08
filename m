Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DB751FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 21:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932340AbcLHVEM (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 16:04:12 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35568 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752379AbcLHVEF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 16:04:05 -0500
Received: by mail-pg0-f50.google.com with SMTP id p66so177697240pga.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 13:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B+YS5CgNxT7kwfV4k6vHg0TQOtxFWiJ0C597cSm6RYw=;
        b=Jm4nHgt8HvGwiNnLoLkyenl52hDa9GToMBDtJ+AsVIayjwaA/oTZprwwM1KV7HUT3e
         bPWVFuhhYJimTnlwciC5h7SMfN4NWvo4QN7Swwk6Lhux6PwjqLfeGY09oMY6kwT/1L/H
         aMea7NFtSUWM2S/YaTNhrDA2qmslTme/a5EnJgVlht1QCw9Tc1PVMlH9BDdVgEIDMMXe
         A7KAU9palVqUkVstsnLa0oeXeDMA2f6zJdiY0bs73YgDmZci5iJZdcAzNIeSY6G/+OCP
         vMvTRTkODHej9eeE8ydkBWSOnssZambXOxC1l597FPKM7pU2BhQAh9qJmQEe/L3n55l/
         +CZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B+YS5CgNxT7kwfV4k6vHg0TQOtxFWiJ0C597cSm6RYw=;
        b=Bf+FqzzrH9cmtgONsRLoaNjxxSDVQjbe/ByOXq2hqUvu/OkCBA6dc/1DaMUwDOGsLR
         i4Zadpg42A8XC0W9sfI8fCtPciVrrGUQcyCUK5VFTozRfD9UMvl3TyI+jaVOS++9HSbU
         gthZyPBy3l74z8KX30W3WlBfUZRqgvG8J6PaqJiMd5/KNt4C6DjTWeA8oawC5Wj5YatU
         UkLySkUwsc2ksGKSo/M4zkhteAfKYzeepaZD1ehcKCc/T57bE/r72sz6h2LY7co3FF20
         Z8RBv02qwgQxc3HwRmwYzvW50dTOwsCW533IhCDzV+Hq6bZpAZzfpOukDOHfgiWDVT3g
         SWWw==
X-Gm-Message-State: AKaTC007Zif7bWNZG7mjyjMRy8oBJRHEqDgnfIayQM6O5NNXJ9+NJCHvKhKAJYoU8KbdBkol
X-Received: by 10.99.185.1 with SMTP id z1mr51204810pge.179.1481231017685;
        Thu, 08 Dec 2016 13:03:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6884:a3d1:aaf8:234b])
        by smtp.gmail.com with ESMTPSA id 131sm52075951pfx.92.2016.12.08.13.03.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 13:03:37 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv7 4/6] worktree: have a function to check if worktrees are in use
Date:   Thu,  8 Dec 2016 13:03:27 -0800
Message-Id: <20161208210329.12919-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.29.g7c00390.dirty
In-Reply-To: <20161208210329.12919-1-sbeller@google.com>
References: <20161208210329.12919-1-sbeller@google.com>
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

This can be done cheaply (both in new code to write as well as run time)
by obtaining the list of worktrees based off that submodules git
directory. However as we have loaded the variables for the current
repository, the values in the submodule worktree
can be wrong, e.g.
* core.ignorecase may differ between these two repositories
* the ref resolution is broken (refs/heads/branch in the submodule
  resolves to the sha1 value of the `branch` in the current repository
  that may not exist or have another sha1)

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 worktree.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 worktree.h |  7 +++++++
 2 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/worktree.c b/worktree.c
index eb6121263b..1c46fcf25f 100644
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
@@ -177,9 +179,10 @@ struct worktree **get_worktrees(unsigned flags)
 
 	list = xmalloc(alloc * sizeof(struct worktree *));
 
-	list[counter++] = get_main_worktree();
+	if (!(flags & GWT_LINKED_ONLY))
+		list[counter++] = get_main_worktree(git_common_dir);
 
-	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
+	strbuf_addf(&path, "%s/worktrees", git_common_dir);
 	dir = opendir(path.buf);
 	strbuf_release(&path);
 	if (dir) {
@@ -188,7 +191,7 @@ struct worktree **get_worktrees(unsigned flags)
 			if (is_dot_or_dotdot(d->d_name))
 				continue;
 
-			if ((linked = get_linked_worktree(d->d_name))) {
+			if ((linked = get_linked_worktree(git_common_dir, d->d_name))) {
 				ALLOC_GROW(list, counter + 1, alloc);
 				list[counter++] = linked;
 			}
@@ -209,6 +212,34 @@ struct worktree **get_worktrees(unsigned flags)
 	return list;
 }
 
+struct worktree **get_worktrees(unsigned flags)
+{
+	return get_worktrees_internal(get_git_common_dir(), flags);
+}
+
+/*
+ * NEEDSWORK: The values in the returned worktrees are broken, e.g.
+ * the refs or path resolution is influenced by the current repository.
+ */
+static struct worktree **get_submodule_worktrees(const char *path, unsigned flags)
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
@@ -380,3 +411,20 @@ const struct worktree *find_shared_symref(const char *symref,
 
 	return existing;
 }
+
+int uses_worktrees(void)
+{
+	struct worktree **worktrees = get_worktrees(GWT_LINKED_ONLY);
+	int retval = (worktrees != NULL && worktrees[0] != NULL);
+	free_worktrees(worktrees);
+	return retval;
+}
+
+int submodule_uses_worktrees(const char *path)
+{
+	struct worktree **worktrees =
+			get_submodule_worktrees(path, GWT_LINKED_ONLY);
+	int retval = (worktrees != NULL && worktrees[0] != NULL);
+	free_worktrees(worktrees);
+	return retval;
+}
diff --git a/worktree.h b/worktree.h
index d59ce1fee8..ebe0856330 100644
--- a/worktree.h
+++ b/worktree.h
@@ -16,6 +16,7 @@ struct worktree {
 /* Functions for acting on the information about worktrees. */
 
 #define GWT_SORT_LINKED (1 << 0) /* keeps linked worktrees sorted */
+#define GWT_LINKED_ONLY (1 << 1) /* do not include the main worktree */
 
 /*
  * Get the worktrees.  The primary worktree will always be the first returned,
@@ -27,6 +28,12 @@ struct worktree {
  */
 extern struct worktree **get_worktrees(unsigned flags);
 
+/*
+ * Returns 1 if linked worktrees exist, 0 otherwise.
+ */
+extern int uses_worktrees(void);
+extern int submodule_uses_worktrees(const char *path);
+
 /*
  * Return git dir of the worktree. Note that the path may be relative.
  * If wt is NULL, git dir of current worktree is returned.
-- 
2.11.0.rc2.29.g7c00390.dirty

