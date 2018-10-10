Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7A11F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeJKFPC (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:15:02 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:40130 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeJKFPC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:15:02 -0400
Received: by mail-qt1-f201.google.com with SMTP id y23-v6so6562532qtc.7
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8+MnwU3zOWclwq8TrnY01lM/pbzmVmbeMUUf9s3ONxA=;
        b=D+0wA9an+P6xNpRfY8lVvZFpnYALqYBHGJKVF2XJoAVlG9rSwbchn2QzD0WYkQuPRw
         ad718G1THsbsx0HKrQ6bLCMLQ0DktkbQmytdhyXWgr4HUIHTSwXohdGP3Gbb4pZDfykY
         /lVqOX2vH+a3OjFDeychkku8jtLt5hOUU4bA5KJxJZVnBYWIPPsAykGsC2pg8PkQjkt8
         xJ46NJZdsorSB2qSpjjhIsvDUD8JdAOs5/Y0ILkNNxYGcD8Q0qjmwEIK+pLjcL0T+x2j
         eQtrF9AHnEeLAez5I+qdbXc15/fRVi9BmKhBvL0ybzPIz1eZXpV7OvivowFnI/Zui5U3
         6HSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8+MnwU3zOWclwq8TrnY01lM/pbzmVmbeMUUf9s3ONxA=;
        b=Z/cp1KNR4xc+cDOC9P5k6uObvJXQ2E/GQLPocTVjF9yauQ/nCwZZbOKgnQ01INNsQc
         yM9398CbdP1tPqLgtScuAmDrWKIsXuRR98i/faBCSBnSgGst8qLbiehCekWNFVNl2lbf
         uxSPM6EYeHhRg4ZKmQ7Tdy8CNcVMJYwD/8o7gY1xemklFpI1YLTeBWs8blBli3UXPdNl
         DCdHP93idLEVS5WWPP6bcqh6hGsQWTQU7A026ypKqADUY+DxEyqtHCvj1rqN6ahyOGIp
         jc23DJlA+37Ze56lmXk87b3sZn488wvKKdpb1qoESRcd38A1ULih1FMcbDhFCuwpkYra
         ojSw==
X-Gm-Message-State: ABuFfogVfNn5uW/0rLhQe49DpVXH7Kpz6VfqZl1eDYtfEIoYq8fDS3f/
        kFDQMMBp4TG2WvmVMrPBXEgCWJkxPeYJknahpbRdyWU3gPatq3QIeiI/T2iP4v4fToGJtOXHDUZ
        xnQFM2C+Q7U0++qPyVSI57/WScIR6bMp3+PmIdZKyiAXrVyzIgC4YoKtLxcsu
X-Google-Smtp-Source: ACcGV61GflzDNqndPEi2j1YmWOgSGOq1BJcWBmZSFxcwjLZP96j2d4H/7FU3iOPJdjYpbM3gsYtngb5L2Ci6
X-Received: by 2002:ac8:347d:: with SMTP id v58-v6mr1870557qtb.6.1539208255904;
 Wed, 10 Oct 2018 14:50:55 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:50:07 -0700
In-Reply-To: <20181010215008.233529-1-sbeller@google.com>
Message-Id: <20181010215008.233529-9-sbeller@google.com>
Mime-Version: 1.0
References: <20181010215008.233529-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH v5 8/9] fetch: retry fetching submodules if needed objects
 were not fetched
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when git-fetch is asked to recurse into submodules, it dispatches
a plain "git-fetch -C <submodule-dir>" (with some submodule related options
such as prefix and recusing strategy, but) without any information of the
remote or the tip that should be fetched.

This works surprisingly well in some workflows (such as using submodules
as a third party library), while not so well in other scenarios, such
as in a Gerrit topic-based workflow, that can tie together changes
(potentially across repositories) on the server side. One of the parts
of such a Gerrit workflow is to download a change when wanting to examine
it, and you'd want to have its submodule changes that are in the same
topic downloaded as well. However these submodule changes reside in their
own repository in their own ref (refs/changes/<int>).

Retry fetching a submodule by object name if the object id that the
superproject points to, cannot be found.

This retrying does not happen when the "git fetch" done at the
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
 submodule.c                 | 185 ++++++++++++++++++++++++++++++------
 t/t5526-fetch-submodules.sh |  16 ++++
 3 files changed, 177 insertions(+), 33 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0696abfc2a..e3b03ad3bd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -707,8 +707,7 @@ static int update_local_ref(struct ref *ref,
 			what = _("[new ref]");
 		}
 
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
 			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref(msg, ref, 0);
 		format_display(display, r ? '!' : '*', what,
@@ -723,8 +722,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
+		if (recurse_submodules != RECURSE_SUBMODULES_OFF)
 			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref("fast-forward", ref, 1);
 		format_display(display, r ? '!' : ' ', quickref.buf,
@@ -738,8 +736,7 @@ static int update_local_ref(struct ref *ref,
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
index 3f791f2277..05799362e0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1127,8 +1127,12 @@ struct submodule_parallel_fetch {
 	int result;
 
 	struct string_list changed_submodule_names;
+	struct get_next_submodule_task **retry;
+	int retry_nr, retry_alloc;
 };
-#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
+		  STRING_LIST_INIT_DUP, \
+		  NULL, 0, 0}
 
 static void calculate_changed_submodule_paths(
 	struct submodule_parallel_fetch *spf)
@@ -1233,6 +1237,56 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
 	return spf->default_option;
 }
 
+struct get_next_submodule_task {
+	struct repository *repo;
+	const struct submodule *sub;
+	unsigned free_sub : 1; /* Do we need to free the submodule? */
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
@@ -1259,39 +1313,35 @@ static struct repository *get_submodule_repo_for(struct repository *r,
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
@@ -1302,12 +1352,12 @@ static int get_next_submodule(struct child_process *cp,
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
@@ -1316,18 +1366,51 @@ static int get_next_submodule(struct child_process *cp,
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
-		}
-		strbuf_release(&submodule_prefix);
-		if (ret) {
 			spf->count++;
+			*task_cb = task;
+
+			strbuf_release(&submodule_prefix);
 			return 1;
+		} else {
+			get_next_submodule_task_release(task);
+			free(task);
 		}
 	}
+
+	if (spf->retry_nr) {
+		struct get_next_submodule_task *task = spf->retry[spf->retry_nr - 1];
+		struct strbuf submodule_prefix = STRBUF_INIT;
+		spf->retry_nr--;
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
+		strbuf_release(&submodule_prefix);
+		return 1;
+	}
+
 	return 0;
 }
 
@@ -1335,20 +1418,68 @@ static int fetch_start_failure(struct strbuf *err,
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
+		ALLOC_GROW(spf->retry, spf->retry_nr + 1, spf->retry_alloc);
+		spf->retry[spf->retry_nr] = task;
+		spf->retry_nr++;
+		return 0;
+	}
+
+out:
+	get_next_submodule_task_release(task);
+
 	return 0;
 }
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 42692219a1..af12c50e7d 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -605,4 +605,20 @@ test_expect_success "fetch new commits when submodule got renamed" '
 	test_cmp expect actual
 '
 
+test_expect_success "fetch new commits on-demand when they are not reachable" '
+	git checkout --detach &&
+	C=$(git -C submodule commit-tree -m "new change outside refs/heads" HEAD^{tree}) &&
+	git -C submodule update-ref refs/changes/1 $C &&
+	git update-index --cacheinfo 160000 $C submodule &&
+	git commit -m "updated submodule outside of refs/heads" &&
+	D=$(git rev-parse HEAD) &&
+	git update-ref refs/changes/2 $D &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&
+		git -C submodule cat-file -t $C &&
+		git checkout --recurse-submodules FETCH_HEAD
+	)
+'
+
 test_done
-- 
2.19.0

