Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34CA21F453
	for <e@80x24.org>; Thu, 25 Oct 2018 23:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeJZIHc (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:07:32 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:53667 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeJZIHc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:07:32 -0400
Received: by mail-yb1-f201.google.com with SMTP id s13-v6so2887633ybj.20
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 16:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vtum7eNCa3t2AxSIn/heEkjb9w63WQZBcA4OB+byAB0=;
        b=Ne/l46P4zoF8oT0ZZJ0fHQuPJJnC6t1ci3PqwWg5is0W4n1Hfu7cctD1jnQKZHuEcm
         zgX4oYXnlkM53i8ZrNupsNazjiPxtPbFF9QEqpfS8I+Cs0iAiUmQxybPE/15XvSdf8MS
         5mJhQHKKxv9Hy/pYX9IUHIDssezpukV0UVSWSjpAZtdeOQJ8camOVR3rk97xd9QzfVWF
         xXTGLMzxgU9OZaPJPeIaON4R6B7oJtIOaBrxrCejhkMZDlHZ52GVfeYZ4hoAqD/0o/7o
         nHOYKFPYwgXwY/AMquRxp2MPWF4wHWOh0E51CFa6x3rWiREmVKCoWcRooQPPtlWPJHBi
         8RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vtum7eNCa3t2AxSIn/heEkjb9w63WQZBcA4OB+byAB0=;
        b=jZUHe6ih48SH0ZmLRFaBB496auqq88ag4HXZlMfyyR1G7XadZzz46PUYIO+XkNx3wB
         6fXkS4KuD3bYpaNghRWydaL1eVa0/aW3PsARPRRxATaIhv8BApWBldtyhlNkjBi2MrNO
         MjVjhzbPPw/NcBZ3COJfkVC3NYn4lv+Ic3vgkWwLs8OHb9t25h+eBhTufuE5Y16CABjF
         J0KuxhZZMERnjN4+qcn6BlK4R73xXUiVJvIC0QKMnHRuaSLCFH4/lKU506gB264kPj1s
         BRJLdnRtrACOKxPwKBo8duw9KxJohxNKypvTJTDD1rETPogO8i3VQWmmTx+K049xrhZb
         Iv2Q==
X-Gm-Message-State: AGRZ1gKXWFwR7kXcQ3eNGVlRGuHnDTKL0hCd1nyxMiU+0bOZcC4z/Lad
        qPhW0wM3DBVW8XS/uVF+ph9WjZxaIAAP
X-Google-Smtp-Source: AJdET5clqywOyTopZgKf+SrqPwZHisHgGUUUzOuXYMYtY9ssDnD0gP5v6Xe1U9ANnfL8NWQqE34cF1flKrWJ
X-Received: by 2002:a5b:18f:: with SMTP id r15-v6mr866027ybl.25.1540510374154;
 Thu, 25 Oct 2018 16:32:54 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:32:28 -0700
In-Reply-To: <20181025233231.102245-1-sbeller@google.com>
Message-Id: <20181025233231.102245-8-sbeller@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 07/10] submodule: migrate get_next_submodule to use repository structs
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We used to recurse into submodules, even if they were broken having
only an objects directory. The child process executed in the submodule
would fail though if the submodule was broken.

This patch tightens the check upfront, such that we do not need
to spawn a child process to find out if the submodule is broken.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 51 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/submodule.c b/submodule.c
index e4b494af7b..a1a32cab7d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1240,6 +1240,29 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
 	return spf->default_option;
 }
 
+static struct repository *get_submodule_repo_for(struct repository *r,
+						 const struct submodule *sub)
+{
+	struct repository *ret = xmalloc(sizeof(*ret));
+
+	if (repo_submodule_init(ret, r, sub)) {
+		/*
+		 * No entry in .gitmodules? Technically not a submodule,
+		 * but historically we supported repositories that happen to be
+		 * in-place where a gitlink is. Keep supporting them.
+		 */
+		struct strbuf gitdir = STRBUF_INIT;
+		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", sub->path);
+		if (repo_init(ret, gitdir.buf, NULL)) {
+			strbuf_release(&gitdir);
+			return NULL;
+		}
+		strbuf_release(&gitdir);
+	}
+
+	return ret;
+}
+
 static int get_next_submodule(struct child_process *cp,
 			      struct strbuf *err, void *data, void **task_cb)
 {
@@ -1247,12 +1270,11 @@ static int get_next_submodule(struct child_process *cp,
 	struct submodule_parallel_fetch *spf = data;
 
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
-		struct strbuf submodule_path = STRBUF_INIT;
-		struct strbuf submodule_git_dir = STRBUF_INIT;
 		struct strbuf submodule_prefix = STRBUF_INIT;
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
-		const char *git_dir, *default_argv;
+		const char *default_argv;
 		const struct submodule *submodule;
+		struct repository *repo;
 		struct submodule default_submodule = SUBMODULE_INIT;
 
 		if (!S_ISGITLINK(ce->ce_mode))
@@ -1287,16 +1309,12 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		strbuf_repo_worktree_path(&submodule_path, spf->r, "%s", ce->name);
-		strbuf_addf(&submodule_git_dir, "%s/.git", submodule_path.buf);
 		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
-		git_dir = read_gitfile(submodule_git_dir.buf);
-		if (!git_dir)
-			git_dir = submodule_git_dir.buf;
-		if (is_directory(git_dir)) {
+		repo = get_submodule_repo_for(spf->r, submodule);
+		if (repo) {
 			child_process_init(cp);
-			cp->dir = strbuf_detach(&submodule_path, NULL);
 			prepare_submodule_repo_env(&cp->env_array);
+			cp->dir = xstrdup(repo->worktree);
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
@@ -1306,10 +1324,19 @@ static int get_next_submodule(struct child_process *cp,
 			argv_array_push(&cp->args, default_argv);
 			argv_array_push(&cp->args, "--submodule-prefix");
 			argv_array_push(&cp->args, submodule_prefix.buf);
+
+			repo_clear(repo);
+			free(repo);
 			ret = 1;
+		} else {
+			/*
+			 * An empty directory is normal,
+			 * the submodule is not initialized
+			 */
+			if (S_ISGITLINK(ce->ce_mode) &&
+			    !is_empty_dir(ce->name))
+				die(_("Could not access submodule '%s'"), ce->name);
 		}
-		strbuf_release(&submodule_path);
-		strbuf_release(&submodule_git_dir);
 		strbuf_release(&submodule_prefix);
 		if (ret) {
 			spf->count++;
-- 
2.19.0

