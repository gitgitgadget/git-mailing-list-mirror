Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77CE71F453
	for <e@80x24.org>; Thu, 25 Oct 2018 23:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeJZIHj (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 04:07:39 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:54771 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeJZIHj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 04:07:39 -0400
Received: by mail-io1-f74.google.com with SMTP id q26-v6so6766341ioi.21
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 16:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xnFFld3YqPX5nlx/Ef4tpPqOz7dO5K9t9tQOaql7OTE=;
        b=BoZBFQurDp/GgnGyNG9gGGdCOScOVM/RYgCND9sP9yPh4o6FPjYKDm+Tv7u0upY3dn
         YL9UdQ44SBldYcir8KZC1lDDMfQySty9p3gtGRHdqlrRJ7NPb561qaoBFO49PKJX71Fs
         5l+CjN+o6lO/eDVVvMAweLtYe0MyvYDhr2Kt/u8xVPq5M6oySQR0Vnd+Fam5YxUZzQ71
         x3zAOZ/1+B5Qp2iW8GD1Wdic+HhFGrDn5YBng+eb8zUXynsOcgri3HYAeazx8/x+CrtQ
         QcXtOIcB+7xjV2kfnK0IpCd4NvaXqz+pL+CsMBC5mPFYuiw0woRLjqAiTvzj8Jf6qNxa
         ziPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xnFFld3YqPX5nlx/Ef4tpPqOz7dO5K9t9tQOaql7OTE=;
        b=F6E1m4usb4mZ7rTiv/4v6RDpOPYpFDhryGeVrkUMx7t64Z5s9AvJdzOis5b3xOypzS
         cyIwa8iEGm91QWumFLqx92G9y7nNiWH5UDwuSrqWPcL7Ou2irDTxJxv1unyHOWu04OBF
         fUIiN40VKvoA20Si7NbDe8Se6M8qRjyC/xUlpgPwaGBHJS52jhAvGRQsF/yKvHR4PmIw
         I/Pzeg93gZ94mTsC7xfvuMfb1WaTX3jZtxJmjVNyfj6AuvCbAOnokwMpyxvcr8HV62J/
         AdCpYYLz2cMC9GUzOPk1MPXyrHPD34XHy128D9ktgnNux5wtGZSpbRZ7rH1I1DgLNRg7
         V6kg==
X-Gm-Message-State: AGRZ1gLgPi8EgYabkutcHk7+fhnOzaiYNUqqnVHG0/Ug4y8njNVSVuV0
        S7svlMPVsytZbMM74R2EckJF1uccrEub
X-Google-Smtp-Source: AJdET5fOxpWbCMn+m3NUTOd5Em1mXFG+Ls9jCn70DLaHikEJ8MaVvbexGh/362ukBw4w+0g9551JPZk9M7ct
X-Received: by 2002:a24:8082:: with SMTP id g124-v6mr1087917itd.12.1540510379790;
 Thu, 25 Oct 2018 16:32:59 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:32:30 -0700
In-Reply-To: <20181025233231.102245-1-sbeller@google.com>
Message-Id: <20181025233231.102245-10-sbeller@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH 09/10] fetch: try fetching submodules if needed objects were
 not fetched
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when git-fetch is asked to recurse into submodules, it dispatches
a plain "git-fetch -C <submodule-dir>" (with some submodule related options
such as prefix and recusing strategy, but) without any information of the
remote or the tip that should be fetched.

But this default fetch is not sufficient, as a newly fetched commit in
the superproject could point to a commit in the submodule that is not
in the default refspec. This is common in workflows like Gerrit's.
When fetching a Gerrit change under review (from refs/changes/??), the
commits in that change likely point to submodule commits that have not
been merged to a branch yet.

Try fetching a submodule by object id if the object id that the
superproject points to, cannot be found.

The try does not happen when the "git fetch" done at the
superproject is not storing the fetched results in remote
tracking branches (i.e. instead just recording them to
FETCH_HEAD) in this step. A later patch will fix this.

builtin/fetch used to only inspect submodules when they were fetched
"on-demand", as in either on/off case it was clear whether the submodule
needs to be fetched. However to know whether we need to try fetching the
object ids, we need to identify the object names, which is done in this
function check_for_new_submodule_commits(), so we'll also run that code
in case the submodule recursion is set to "on".

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c             |   9 +-
 submodule.c                 | 192 ++++++++++++++++++++++++++++++------
 t/t5526-fetch-submodules.sh |  31 ++++++
 3 files changed, 198 insertions(+), 34 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61bec5d213..95c44bf6ff 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -700,8 +700,7 @@ static int update_local_ref(struct ref *ref,
 			what = _("[new ref]");
 		}
 
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
 			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref(msg, ref, 0);
 		format_display(display, r ? '!' : '*', what,
@@ -716,8 +715,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
 			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref("fast-forward", ref, 1);
 		format_display(display, r ? '!' : ' ', quickref.buf,
@@ -731,8 +729,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
 			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref("forced-update", ref, 1);
 		format_display(display, r ? '!' : '+', quickref.buf,
diff --git a/submodule.c b/submodule.c
index 67813fbe78..c978a38c81 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1218,8 +1218,12 @@ struct submodule_parallel_fetch {
 	int result;
 
 	struct string_list changed_submodule_names;
+	struct get_next_submodule_task **fetch_specific_oids;
+	int fetch_specific_oids_nr, fetch_specific_oids_alloc;
 };
-#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
+		  STRING_LIST_INIT_DUP, \
+		  NULL, 0, 0}
 
 static int get_fetch_recurse_config(const struct submodule *submodule,
 				    struct submodule_parallel_fetch *spf)
@@ -1246,6 +1250,58 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
 	return spf->default_option;
 }
 
+struct get_next_submodule_task {
+	struct repository *repo;
+	const struct submodule *sub;
+	unsigned free_sub : 1; /* Do we need to free the submodule? */
+
+	/* fetch specific oids if set, otherwise fetch default refspec */
+	struct oid_array *commits;
+};
+
+static const struct submodule *get_default_submodule(const char *path)
+{
+	struct submodule *ret = NULL;
+	const char *name = default_name_or_path(path);
+
+	if (!name)
+		return NULL;
+
+	ret = xmalloc(sizeof(*ret));
+	memset(ret, 0, sizeof(*ret));
+	ret->path = name;
+	ret->name = name;
+
+	return (const struct submodule *) ret;
+}
+
+static struct get_next_submodule_task *get_next_submodule_task_create(
+	struct repository *r, const char *path)
+{
+	struct get_next_submodule_task *task = xmalloc(sizeof(*task));
+	memset(task, 0, sizeof(*task));
+
+	task->sub = submodule_from_path(r, &null_oid, path);
+	if (!task->sub) {
+		task->sub = get_default_submodule(path);
+		task->free_sub = 1;
+	}
+
+	return task;
+}
+
+static void get_next_submodule_task_release(struct get_next_submodule_task *p)
+{
+	if (p->free_sub)
+		free((void*)p->sub);
+	p->free_sub = 0;
+	p->sub = NULL;
+
+	if (p->repo)
+		repo_clear(p->repo);
+	FREE_AND_NULL(p->repo);
+}
+
 static struct repository *get_submodule_repo_for(struct repository *r,
 						 const struct submodule *sub)
 {
@@ -1272,39 +1328,35 @@ static struct repository *get_submodule_repo_for(struct repository *r,
 static int get_next_submodule(struct child_process *cp,
 			      struct strbuf *err, void *data, void **task_cb)
 {
-	int ret = 0;
 	struct submodule_parallel_fetch *spf = data;
 
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
-		struct strbuf submodule_prefix = STRBUF_INIT;
+		int recurse_config;
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
 		const char *default_argv;
-		const struct submodule *submodule;
-		struct repository *repo;
-		struct submodule default_submodule = SUBMODULE_INIT;
+		struct get_next_submodule_task *task;
 
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		submodule = submodule_from_path(spf->r, &null_oid, ce->name);
-		if (!submodule) {
-			const char *name = default_name_or_path(ce->name);
-			if (name) {
-				default_submodule.path = name;
-				default_submodule.name = name;
-				submodule = &default_submodule;
-			}
+		task = get_next_submodule_task_create(spf->r, ce->name);
+
+		if (!task->sub) {
+			free(task);
+			continue;
 		}
 
-		switch (get_fetch_recurse_config(submodule, spf))
+		recurse_config = get_fetch_recurse_config(task->sub, spf);
+
+		switch (recurse_config)
 		{
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!submodule ||
+			if (!task->sub ||
 			    !string_list_lookup(
 					&spf->changed_submodule_names,
-					submodule->name))
+					task->sub->name))
 				continue;
 			default_argv = "on-demand";
 			break;
@@ -1315,12 +1367,12 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
-		repo = get_submodule_repo_for(spf->r, submodule);
-		if (repo) {
+		task->repo = get_submodule_repo_for(spf->r, task->sub);
+		if (task->repo) {
+			struct strbuf submodule_prefix = STRBUF_INIT;
 			child_process_init(cp);
 			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
-			cp->dir = xstrdup(repo->gitdir);
+			cp->dir = task->repo->gitdir;
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
@@ -1329,12 +1381,22 @@ static int get_next_submodule(struct child_process *cp,
 			argv_array_pushv(&cp->args, spf->args.argv);
 			argv_array_push(&cp->args, default_argv);
 			argv_array_push(&cp->args, "--submodule-prefix");
+
+			strbuf_addf(&submodule_prefix, "%s%s/",
+						       spf->prefix,
+						       task->sub->path);
 			argv_array_push(&cp->args, submodule_prefix.buf);
 
-			repo_clear(repo);
-			free(repo);
-			ret = 1;
+			spf->count++;
+			*task_cb = task;
+
+			strbuf_release(&submodule_prefix);
+			return 1;
 		} else {
+
+			get_next_submodule_task_release(task);
+			free(task);
+
 			/*
 			 * An empty directory is normal,
 			 * the submodule is not initialized
@@ -1343,12 +1405,36 @@ static int get_next_submodule(struct child_process *cp,
 			    !is_empty_dir(ce->name))
 				die(_("Could not access submodule '%s'"), ce->name);
 		}
+	}
+
+	if (spf->fetch_specific_oids_nr) {
+		struct get_next_submodule_task *task = spf->fetch_specific_oids[spf->fetch_specific_oids_nr - 1];
+		struct strbuf submodule_prefix = STRBUF_INIT;
+		spf->fetch_specific_oids_nr--;
+
+		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, task->sub->path);
+
+		child_process_init(cp);
+		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+		cp->git_cmd = 1;
+		cp->dir = task->repo->gitdir;
+
+		argv_array_init(&cp->args);
+		argv_array_pushv(&cp->args, spf->args.argv);
+		argv_array_push(&cp->args, "on-demand");
+		argv_array_push(&cp->args, "--submodule-prefix");
+		argv_array_push(&cp->args, submodule_prefix.buf);
+
+		/* NEEDSWORK: have get_default_remote from s--h */
+		argv_array_push(&cp->args, "origin");
+		oid_array_for_each_unique(task->commits,
+					  append_oid_to_argv, &cp->args);
+
+		*task_cb = task;
 		strbuf_release(&submodule_prefix);
-		if (ret) {
-			spf->count++;
-			return 1;
-		}
+		return 1;
 	}
+
 	return 0;
 }
 
@@ -1356,20 +1442,70 @@ static int fetch_start_failure(struct strbuf *err,
 			       void *cb, void *task_cb)
 {
 	struct submodule_parallel_fetch *spf = cb;
+	struct get_next_submodule_task *task = task_cb;
 
 	spf->result = 1;
 
+	get_next_submodule_task_release(task);
 	return 0;
 }
 
+static int commit_exists_in_sub(const struct object_id *oid, void *data)
+{
+	struct repository *subrepo = data;
+
+	enum object_type type = oid_object_info(subrepo, oid, NULL);
+
+	return type != OBJ_COMMIT;
+}
+
 static int fetch_finish(int retvalue, struct strbuf *err,
 			void *cb, void *task_cb)
 {
 	struct submodule_parallel_fetch *spf = cb;
+	struct get_next_submodule_task *task = task_cb;
+	const struct submodule *sub;
+
+	struct string_list_item *it;
+	struct oid_array *commits;
 
 	if (retvalue)
 		spf->result = 1;
 
+	if (!task)
+		return 0;
+
+	sub = task->sub;
+	if (!sub)
+		goto out;
+
+	it = string_list_lookup(&spf->changed_submodule_names, sub->name);
+	if (!it)
+		goto out;
+
+	commits = it->util;
+	oid_array_filter(commits,
+			 commit_exists_in_sub,
+			 task->repo);
+
+	/* Are there commits that do not exist? */
+	if (commits->nr) {
+		/* We already tried fetching them, do not try again. */
+		if (task->commits)
+			return 0;
+
+		task->commits = commits;
+		ALLOC_GROW(spf->fetch_specific_oids,
+			   spf->fetch_specific_oids_nr + 1,
+			   spf->fetch_specific_oids_alloc);
+		spf->fetch_specific_oids[spf->fetch_specific_oids_nr] = task;
+		spf->fetch_specific_oids_nr++;
+		return 0;
+	}
+
+out:
+	get_next_submodule_task_release(task);
+
 	return 0;
 }
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 6c2f9b2ba2..5a75b57852 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -600,4 +600,35 @@ test_expect_success "fetch new commits when submodule got renamed" '
 	test_cmp expect actual
 '
 
+test_expect_success "fetch new submodule commits on-demand outside standard refspec" '
+	# add a second submodule and ensure it is around in downstream first
+	git clone submodule sub1 &&
+	git submodule add ./sub1 &&
+	git commit -m "adding a second submodule" &&
+	git -C downstream pull &&
+	git -C downstream submodule update --init --recursive &&
+
+	git checkout --detach &&
+
+	C=$(git -C submodule commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
+	git -C submodule update-ref refs/changes/1 $C &&
+	git update-index --cacheinfo 160000 $C submodule &&
+	test_tick &&
+
+	D=$(git -C sub1 commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
+	git -C sub1 update-ref refs/changes/2 $D &&
+	git update-index --cacheinfo 160000 $D sub1 &&
+
+	git commit -m "updated submodules outside of refs/heads" &&
+	E=$(git rev-parse HEAD) &&
+	git update-ref refs/changes/2 $E &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin refs/changes/2:refs/heads/my_branch &&
+		git -C submodule cat-file -t $C &&
+		git -C sub1 cat-file -t $D &&
+		git checkout --recurse-submodules FETCH_HEAD
+	)
+'
+
 test_done
-- 
2.19.0

