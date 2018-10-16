Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A5C1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 18:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbeJQCFt (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 22:05:49 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:38790 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCFt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 22:05:49 -0400
Received: by mail-it1-f202.google.com with SMTP id d10so26860754itk.3
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 11:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cwEaVOQsZKeLZkIk0ya0bf1ynrWZWRCKcmUMzgnv1dc=;
        b=gELAxh+6BFQrzX2XKmAcAU8tePVnMlzt0vRtu1R9sbYcMZwu4r6X6VLRnyypn5W7De
         uR5HqawZyZuMcyK7ouAdVZecSY8y2Q08AZBEbuuKaDMZxhkv5etJsosv2J6EZfse48g5
         gISYa8dWEIHR7ja1zPtaArg+fIvqzuhij6crgw0AzUHvkye+7xv2ex/apBeRIX2TPx6R
         CroF47rsBJ9s9I74jU5vuEdRoo3USwIeD+lPgi+8zAU8YiZV9UUZZVqMvCnIdPbzaVw9
         sWPXZ4GxtheSKPtBT3fNpiYdSyYi+yufuutwB0Xa+IGGMD8ge1/qsocPfOhT9x1V5Los
         X4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cwEaVOQsZKeLZkIk0ya0bf1ynrWZWRCKcmUMzgnv1dc=;
        b=lY7f18SqbhkExo38MJCrCAxFi2Zl0nGd2S9t05uJdqof+gLBecFrEfhACNUjaZk9ms
         EmkU69cher7GrJe03zVlwEmchaq7Y7bJJrJE99AMatMSYZ7xS+jtJSC0GRg9Fynru479
         BgGWDjCv7Npeig5NnrrAA2qJzGZUiXNwYOo/yeoIGs2EFRsWylLMFSDM7enSwjqCFnYm
         rx3itjAUlaFzXbfFOV2k0j9MM0Nvl85iqEciaAKD87tDq7WlbLjmLpB8bphD+RiD4V+G
         +OlFQGreDXV4XyxPB1PHjqnwHTPl3wR1IPfENhvk46LXfwO5IyStIHtIOKcYDax8ukXi
         0UsQ==
X-Gm-Message-State: ABuFfogKVmlSoVQVXAUern/jxXUIKMdAvOHzTYf6skpX4pVgy5zuNZdf
        9+p3SO/NHhEbBkGNbY9lsf48dFp/4Q9B
X-Google-Smtp-Source: ACcGV62lDM5CoAmXiCN51Z5IivJr+sQ/KbZAOy4jM87ynX+B/Ru70uyj2UELlb2YccXzlusfEYea5V8QeHjp
X-Received: by 2002:a24:8903:: with SMTP id s3-v6mr17738771itd.26.1539713648969;
 Tue, 16 Oct 2018 11:14:08 -0700 (PDT)
Date:   Tue, 16 Oct 2018 11:13:25 -0700
In-Reply-To: <20181016181327.107186-1-sbeller@google.com>
Message-Id: <20181016181327.107186-8-sbeller@google.com>
Mime-Version: 1.0
References: <20181016181327.107186-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 7/9] submodule: fetch in submodules git directory instead of
 in worktree
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch started as a refactoring to make 'get_next_submodule' more
readable, but upon doing so, I realized that "git fetch" of the submodule
actually doesn't need to be run in the submodules worktree. So let's run
it in its git dir instead.

That should pave the way towards fetching submodules that are currently
not checked out.

This patch leaks the cp->dir in get_next_submodule, as any further
callback in run_processes_parallel doesn't have access to the child
process any more. In an early iteration of this patch, the function
get_submodule_repo_for directly returned the string containing the
git directory, which would be a better design choice for this patch.

However the next patch both fixes the memory leak of cp->dir and also has
a use case for using the full repository handle of the submodule, so
it makes sense to introduce the get_submodule_repo_for here already.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c                 | 51 +++++++++++++++++++++++++++----------
 t/t5526-fetch-submodules.sh |  7 ++++-
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/submodule.c b/submodule.c
index cbefe5f54d..30c06507e3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -495,6 +495,12 @@ void prepare_submodule_repo_env(struct argv_array *out)
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
+static void prepare_submodule_repo_env_in_gitdir(struct argv_array *out)
+{
+	prepare_submodule_repo_env_no_git_dir(out);
+	argv_array_pushf(out, "%s=.", GIT_DIR_ENVIRONMENT);
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
@@ -1241,6 +1247,29 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
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
@@ -1248,12 +1277,11 @@ static int get_next_submodule(struct child_process *cp,
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
@@ -1288,16 +1316,12 @@ static int get_next_submodule(struct child_process *cp,
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
-			prepare_submodule_repo_env(&cp->env_array);
+			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+			cp->dir = xstrdup(repo->gitdir);
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
@@ -1307,10 +1331,11 @@ static int get_next_submodule(struct child_process *cp,
 			argv_array_push(&cp->args, default_argv);
 			argv_array_push(&cp->args, "--submodule-prefix");
 			argv_array_push(&cp->args, submodule_prefix.buf);
+
+			repo_clear(repo);
+			free(repo);
 			ret = 1;
 		}
-		strbuf_release(&submodule_path);
-		strbuf_release(&submodule_git_dir);
 		strbuf_release(&submodule_prefix);
 		if (ret) {
 			spf->count++;
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 6c2f9b2ba2..42692219a1 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -566,7 +566,12 @@ test_expect_success 'fetching submodule into a broken repository' '
 
 	test_must_fail git -C dst status &&
 	test_must_fail git -C dst diff &&
-	test_must_fail git -C dst fetch --recurse-submodules
+
+	# git-fetch cannot find the git directory of the submodule,
+	# so it will do nothing, successfully, as it cannot distinguish between
+	# this broken submodule and a submodule that was just set active but
+	# not cloned yet
+	git -C dst fetch --recurse-submodules
 '
 
 test_expect_success "fetch new commits when submodule got renamed" '
-- 
2.19.0

