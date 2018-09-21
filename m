Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BFE61F453
	for <e@80x24.org>; Fri, 21 Sep 2018 22:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391492AbeIVE1t (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 00:27:49 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55259 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeIVE1t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 00:27:49 -0400
Received: by mail-pg1-f202.google.com with SMTP id o16-v6so6116017pgv.21
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 15:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EeftGsmioQiDoHwhdBwoxPT1IokguOXRXR0jEzMssgA=;
        b=pQ/JcjXZBnx8cpsXGPv6LEO+U7Si4AOZMh6Mwk4WQpkZ3qFBH+FZPvFROgD6hPz8GF
         4/mB3ro1HmCSwlI/h3nWOCQBw2o0ABh9XzVlxEmy5NwkfknR8tUWusXQ8P1a8+z+ejQs
         Bn3N4EDm3T5ABeL8Agk7S2MQwL5BjN/J5eLZJ7pbZcgZg40wXVwb3TUINwLhChPFzZA7
         h/GFQGLJp5muveJfLvgC4eGafRTLPdaNfFIa8UiI+8nMaKwgTtl/Otif2MrylnS/PNal
         4pXGMz7E7sLq0l1ejlEt+OhZEeoIdVcFJrL5zXcB68wn8g3UmzglkW8in0Ur+GYo5HcU
         J2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EeftGsmioQiDoHwhdBwoxPT1IokguOXRXR0jEzMssgA=;
        b=NBKgyFuSqHGpviH9LEwpJQtOd4NFYrZQKLoC/H2IFANCU/+CBJ9rdopoCatf7XVIM1
         nK47OThM5oKPRIIjN14WDRWYaJuZS0gpHXPUlvng3a/vkSRzKM2s1fdkQg9ZyoqFXL9W
         k9KffXtPyhzLqtweSvdwbSdepnkeUPpCKhyYizQTCvLhRkXDHVsdeL/OwolA8LUKaBzT
         XMzXccP7/+SffEV9YFJAdrwJcDa33kaZUf0U5zXidcSqvoj2MGs8o99rGUaGxzaoCYuN
         7Qxfgg3lorSP6cwkQ1RiKadfUnRhrt0iKgbseNTKx7s04YipfMI3poNrvHC6kIVtn25e
         i5DA==
X-Gm-Message-State: APzg51Af/WOKh6zLdLTjhAVPP6HFntWZ0Ey/ojqKM4a5W5iGnjhiun5i
        j7NwSxYOSo7tNHbUA4o0x8QDZnpTCi/gn9fDGghbpDmuQElMnC+ZGtgOQa2mlr1dqpka1g9G4Dm
        7IH+8s4kDkwFFlCBesFRCBa5yiBTiqKkmn16DuGfv2OVGjvZssr3xTsd129lx
X-Google-Smtp-Source: ANB0VdYI2JN+NrrXcinZ9FBswXEreNe6TlTLJeN3G19hm5yzZh+rTuGtKFY2OjmwUVk68MYJk1I9GJFOz8wt
X-Received: by 2002:a63:5504:: with SMTP id j4-v6mr2152715pgb.106.1537569412471;
 Fri, 21 Sep 2018 15:36:52 -0700 (PDT)
Date:   Fri, 21 Sep 2018 15:35:57 -0700
In-Reply-To: <20180921223558.65055-1-sbeller@google.com>
Message-Id: <20180921223558.65055-8-sbeller@google.com>
Mime-Version: 1.0
References: <20180921223558.65055-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 7/8] fetch: retry fetching submodules if needed objects were
 not fetched
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
 submodule.c                 | 182 ++++++++++++++++++++++++++++++------
 t/t5526-fetch-submodules.sh |  16 ++++
 3 files changed, 174 insertions(+), 33 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0696abfc2a1..e3b03ad3bd3 100644
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
index 8829e8d4eff..ba98a94d4db 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1128,8 +1128,12 @@ struct submodule_parallel_fetch {
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
@@ -1234,6 +1238,56 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
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
 						 const char *path)
 {
@@ -1256,39 +1310,35 @@ static struct repository *get_submodule_repo_for(struct repository *r,
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
@@ -1299,12 +1349,13 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
-		repo = get_submodule_repo_for(spf->r, ce->name);
-		if (repo) {
+		task->repo = get_submodule_repo_for(spf->r,
+						       task->sub->path);
+		if (task->repo) {
+			struct strbuf submodule_prefix = STRBUF_INIT;
 			child_process_init(cp);
 			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
-			cp->dir = xstrdup(repo->gitdir);
+			cp->dir = task->repo->gitdir;
 			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
@@ -1313,18 +1364,51 @@ static int get_next_submodule(struct child_process *cp,
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
 
@@ -1332,20 +1416,64 @@ static int fetch_start_failure(struct strbuf *err,
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
+	trace_printf("checking for submodule: needs %d more commits", commits->nr);
+	if (commits->nr) {
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
index 42692219a1a..af12c50e7dd 100755
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
2.19.0.444.g18242da7ef-goog

