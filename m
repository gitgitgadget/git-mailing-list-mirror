Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466EF1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755513AbcLAU0R (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:26:17 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34251 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752008AbcLAU0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:26:14 -0500
Received: by mail-pg0-f49.google.com with SMTP id x23so98605290pgx.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 12:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OdzCpQEFctaqVjZBra2gvwOXrefO8PepYBKrpa8ozq4=;
        b=c8uu2MMdmzmHKSArfJzeV11EcyVNwNQr0w9c0ybzW43U7rA3A5hJcpeCfzd3hyW/AD
         L2YkP3szdaNB4HViyIE44FBxhJ4UlXEugnXWtJc3dxGJXIyr5J0Zyi6Crg/hiw55p9Cd
         qnBzeOIxbd83ER7Q4ZvStqXpTCO2izEkgju/znRAk/YsCjqc6faEpVveNEzLrkpCHJIm
         BMppnuXC1wlE8XBZv12oz+9RTSknUdvmkx9YaQFHOu9NCFQIl9xoTgXcUi6a270Vqmjk
         rdFAKoBT4m80/h10ZiFNCPZDcVCWm6p5WwiTCNjapIsU9s/rtsYdFU4sHdhRSG2dFf0y
         vTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OdzCpQEFctaqVjZBra2gvwOXrefO8PepYBKrpa8ozq4=;
        b=C9LTbxnUbRAnLg+9UHZ38L/HzjXkAJuWAx444lgpqpluKMUrx/tw51OCpvzUqzzrKO
         bq/k8eaEfz5bKHPV+uQIsXke7+tdI811u9ygYats1lT/oQ2dpOU+S8B1ZGtw2eAycmME
         rXyWhZfSIG4GUE68+Vn0r49As1xhtba4gjlFMTjf2RORzHHZ9LlpVbaIVwdzmXUQbzC3
         M9ur8J3JMFsIzT0GIZAT4hzHNbq5RbFkyG58nZZ1MK2wsul6gHXb8ChDycbTkr/GAjr/
         l3P6AxJogbHULbhReZLLjzhAqlnABYo3o4JrBCLGEKWJaE5iwVKeJdrGsu0/pZ48pbjh
         yuDw==
X-Gm-Message-State: AKaTC00ZEUmlwALmWFFkujIBIZP8HKfXhsVZ+BruKO+is02ij56jAxXYSKGCIM1vaqveBOZY
X-Received: by 10.98.68.84 with SMTP id r81mr40228308pfa.174.1480623973224;
        Thu, 01 Dec 2016 12:26:13 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:18d1:181b:bbf2:e96f])
        by smtp.gmail.com with ESMTPSA id s3sm2174721pfe.27.2016.12.01.12.26.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 12:26:12 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 4/5] worktree: get worktrees from submodules
Date:   Thu,  1 Dec 2016 12:25:53 -0800
Message-Id: <20161201202554.19944-5-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.613.g22f2156
In-Reply-To: <20161201202554.19944-1-sbeller@google.com>
References: <20161201202554.19944-1-sbeller@google.com>
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
 worktree.c | 40 ++++++++++++++++++++++++++++++----------
 worktree.h |  5 +++++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/worktree.c b/worktree.c
index f7869f8d60..fb1f72bbf3 100644
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
 
 	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
 		goto done;
@@ -109,7 +109,8 @@ static struct worktree *get_main_worktree(void)
 	return worktree;
 }
 
-static struct worktree *get_linked_worktree(const char *id)
+static struct worktree *get_linked_worktree(const char *git_common_dir,
+					    const char *id)
 {
 	struct worktree *worktree = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -120,7 +121,7 @@ static struct worktree *get_linked_worktree(const char *id)
 	if (!id)
 		die("Missing linked worktree name");
 
-	strbuf_git_common_path(&path, "worktrees/%s/gitdir", id);
+	strbuf_addf(&path, "%s/worktrees/%s/gitdir", git_common_dir, id);
 	if (strbuf_read_file(&worktree_path, path.buf, 0) <= 0)
 		/* invalid gitdir file */
 		goto done;
@@ -133,7 +134,7 @@ static struct worktree *get_linked_worktree(const char *id)
 	}
 
 	strbuf_reset(&path);
-	strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
+	strbuf_addf(&path, "%s/worktrees/%s/HEAD", git_common_dir, id);
 
 	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
 		goto done;
@@ -173,7 +174,7 @@ static void mark_current_worktree(struct worktree **worktrees)
 	free(git_dir);
 }
 
-struct worktree **get_worktrees(void)
+struct worktree **get_worktrees_internal(const char *git_common_dir)
 {
 	struct worktree **list = NULL;
 	struct strbuf path = STRBUF_INIT;
@@ -183,10 +184,10 @@ struct worktree **get_worktrees(void)
 
 	list = xmalloc(alloc * sizeof(struct worktree *));
 
-	if ((list[counter] = get_main_worktree()))
+	if ((list[counter] = get_main_worktree(git_common_dir)))
 		counter++;
 
-	strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
+	strbuf_addf(&path, "%s/worktrees", git_common_dir);
 	dir = opendir(path.buf);
 	strbuf_release(&path);
 	if (dir) {
@@ -195,7 +196,7 @@ struct worktree **get_worktrees(void)
 			if (is_dot_or_dotdot(d->d_name))
 				continue;
 
-			if ((linked = get_linked_worktree(d->d_name))) {
+			if ((linked = get_linked_worktree(git_common_dir, d->d_name))) {
 				ALLOC_GROW(list, counter + 1, alloc);
 				list[counter++] = linked;
 			}
@@ -209,6 +210,25 @@ struct worktree **get_worktrees(void)
 	return list;
 }
 
+struct worktree **get_worktrees(void)
+{
+	return get_worktrees_internal(get_git_common_dir());
+}
+
+struct worktree **get_submodule_worktrees(const char *path)
+{
+	const char *submodule_common_dir;
+	struct strbuf sb = STRBUF_INIT;
+	struct worktree **ret;
+	strbuf_addf(&sb, "%s/.git", path);
+	submodule_common_dir = resolve_gitdir(sb.buf);
+
+	ret = get_worktrees_internal(submodule_common_dir);
+
+	strbuf_release(&sb);
+	return ret;
+}
+
 const char *get_worktree_git_dir(const struct worktree *wt)
 {
 	if (!wt)
diff --git a/worktree.h b/worktree.h
index 90e1311fa7..c93845516c 100644
--- a/worktree.h
+++ b/worktree.h
@@ -25,6 +25,11 @@ struct worktree {
  */
 extern struct worktree **get_worktrees(void);
 
+/*
+ * Get the worktrees of a submodule named by `path`.
+ */
+extern struct worktree **get_submodule_worktrees(const char *path);
+
 /*
  * Return git dir of the worktree. Note that the path may be relative.
  * If wt is NULL, git dir of current worktree is returned.
-- 
2.10.2.613.g22f2156

