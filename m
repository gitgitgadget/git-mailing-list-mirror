Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CA11211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 21:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLFV1F (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 16:27:05 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:55773 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeLFV1E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 16:27:04 -0500
Received: by mail-qk1-f202.google.com with SMTP id 98so1579731qkp.22
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 13:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QeJGPiq0xZOTZTjSHDqld6JpU74QAYjkJqUG8P2Q6Bw=;
        b=KfCl3dkb+JxA0HZMnQFTXWq/WgSZ8EV+mJO2dCoYM7ajiha/8j30zTRNRPPwfT6ogq
         oHt0L06g5S2FcxkAaLHKyhXLeBzd98m74o9j7BQOYmVuLguhwSH+bCKmPDnw8caE0unG
         AxD1FLY46PBi+IcLHP90ActK6kUGtLsFbwY6ejbF7hdIFVFg/uTPuLeorOLjg64WwHMS
         Bdic3izAo7aszgHOZup1HNikTrXBIdpdz1zDHwCCF6dTowhwuNz1PJ/SGqU7BUVuPcwW
         UKJ1e8nnmzO+24YVzzpLJgeNIkwBOj5QGoe3GYKUsiqYNv7Ifjd3VlxVtyVkIpwBKGVE
         Oytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QeJGPiq0xZOTZTjSHDqld6JpU74QAYjkJqUG8P2Q6Bw=;
        b=P5Swj0tEbPdh9AFj1esXRCRoPWypArmh6rk3uQ8KAKEj/S28RyinNCCR8w4YddD/Le
         Wlf6dlZmvvmjHeeUrNP9eNGnovfLhw1XYnOlPbSIU04jDcTl7vW59lJAB8g1lJVC4xpd
         tDE3C4JiIWLqcW9hLBhNMcdzgYh0VYLxOFVJMqobPtKL2wmxs9Vez3SrnrT4I1M95jXv
         hlpPCJl67HUenXf15r3Zc2KEycjJGLyCCPNyxex8wHZ7PRDPKwbn1AjW3AxQVsLOo9Nr
         wTZFJJ8DsF6FPLW8kjUWEAOCuKDGCHbjs4uCprdxf7/ZFZW1K5u9cm3Z/sHx70xZjYqO
         gVFQ==
X-Gm-Message-State: AA+aEWYKVkiaeUlhTgPjD3MXB4NfNJ9tiHpdq4WvqtIXYCBA6yBV0+aM
        /1wDPkulzo3jKUwgS+6YkgmjU65d59kr
X-Google-Smtp-Source: AFSGD/UmI6qTQE07KzfZKkacJltPhNlgeNZ7Vup1Yq6Nv8x53o74Fh/mOc1nOJLZgFYFsJXlrIzB/gb86WFw
X-Received: by 2002:a0c:b988:: with SMTP id v8mr23288973qvf.29.1544131623416;
 Thu, 06 Dec 2018 13:27:03 -0800 (PST)
Date:   Thu,  6 Dec 2018 13:26:55 -0800
In-Reply-To: <20181205010704.84790-1-jonathantanmy@google.com>
Message-Id: <20181206212655.145586-1-sbeller@google.com>
Mime-Version: 1.0
References: <20181205010704.84790-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH] fetch: ensure submodule objects fetched
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, sbeller@google.com
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

Fetch a submodule object by id if the object that the superproject
points to, cannot be found. For now this object is fetched from the
'origin' remote as we defer getting the default remote to a later patch.

A list of new submodule commits are already generated in certain
conditions (by check_for_new_submodule_commits()); this new feature
invokes that function in more situations.

The submodule checks were done only when a ref in the superproject
changed, these checks were extended to also be performed when fetching
into FETCH_HEAD for completeness, and add a test for that too.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Thanks Jonathan for the review!
So it looks like only the last patch needs some improvements,
which is why I'd only resend the last patch here.
Also note the test with interious superproject commits.

All suggestions sounded sensible, addressing them all,
here is a range-diff to the currently queued version:

Range-diff:
1:  04eb06607b ! 1:  ac6558cbc9 fetch: try fetching submodules if needed objects were not fetched
    @@ -1,6 +1,6 @@
     Author: Stefan Beller <sbeller@google.com>
     
    -    fetch: try fetching submodules if needed objects were not fetched
    +    fetch: ensure submodule objects fetched
     
         Currently when git-fetch is asked to recurse into submodules, it dispatches
         a plain "git-fetch -C <submodule-dir>" (with some submodule related options
    @@ -14,22 +14,19 @@
         commits in that change likely point to submodule commits that have not
         been merged to a branch yet.
     
    -    Try fetching a submodule by object id if the object id that the
    -    superproject points to, cannot be found.
    +    Fetch a submodule object by id if the object that the superproject
    +    points to, cannot be found. For now this object is fetched from the
    +    'origin' remote as we defer getting the default remote to a later patch.
     
    -    builtin/fetch used to only inspect submodules when they were fetched
    -    "on-demand", as in either on/off case it was clear whether the submodule
    -    needs to be fetched. However to know whether we need to try fetching the
    -    object ids, we need to identify the object names, which is done in this
    -    function check_for_new_submodule_commits(), so we'll also run that code
    -    in case the submodule recursion is set to "on".
    +    A list of new submodule commits are already generated in certain
    +    conditions (by check_for_new_submodule_commits()); this new feature
    +    invokes that function in more situations.
     
         The submodule checks were done only when a ref in the superproject
         changed, these checks were extended to also be performed when fetching
         into FETCH_HEAD for completeness, and add a test for that too.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/builtin/fetch.c b/builtin/fetch.c
      --- a/builtin/fetch.c
    @@ -82,7 +79,7 @@
      
      	struct string_list changed_submodule_names;
     +
    -+	/* The submodules to fetch in */
    ++	/* Pending fetches by OIDs */
     +	struct fetch_task **oid_fetch_tasks;
     +	int oid_fetch_tasks_nr, oid_fetch_tasks_alloc;
      };
    @@ -97,13 +94,16 @@
      	return spf->default_option;
      }
      
    ++/*
    ++ * Fetch in progress (if callback data) or
    ++ * pending (if in oid_fetch_tasks in struct submodule_parallel_fetch)
    ++ */
     +struct fetch_task {
     +	struct repository *repo;
     +	const struct submodule *sub;
     +	unsigned free_sub : 1; /* Do we need to free the submodule? */
     +
    -+	/* fetch specific oids if set, otherwise fetch default refspec */
    -+	struct oid_array *commits;
    ++	struct oid_array *commits; /* Ensure these commits are fetched */
     +};
     +
     +/**
    @@ -176,7 +176,6 @@
      
      	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
     -		struct strbuf submodule_prefix = STRBUF_INIT;
    -+		int recurse_config;
      		const struct cache_entry *ce = spf->r->index->cache[spf->count];
      		const char *default_argv;
     -		const struct submodule *submodule;
    @@ -199,11 +198,9 @@
     +		task = fetch_task_create(spf->r, ce->name);
     +		if (!task)
     +			continue;
    -+
    -+		recurse_config = get_fetch_recurse_config(task->sub, spf);
      
     -		switch (get_fetch_recurse_config(submodule, spf))
    -+		switch (recurse_config)
    ++		switch (get_fetch_recurse_config(task->sub, spf))
      		{
      		default:
      		case RECURSE_SUBMODULES_DEFAULT:
    @@ -314,7 +311,7 @@
      	return 0;
      }
      
    -+static int commit_exists_in_sub(const struct object_id *oid, void *data)
    ++static int commit_missing_in_sub(const struct object_id *oid, void *data)
     +{
     +	struct repository *subrepo = data;
     +
    @@ -340,7 +337,7 @@
     +
     +	/* Is this the second time we process this submodule? */
     +	if (task->commits)
    -+		return 0;
    ++		goto out;
     +
     +	it = string_list_lookup(&spf->changed_submodule_names, task->sub->name);
     +	if (!it)
    @@ -349,7 +346,7 @@
     +
     +	commits = it->util;
     +	oid_array_filter(commits,
    -+			 commit_exists_in_sub,
    ++			 commit_missing_in_sub,
     +			 task->repo);
     +
     +	/* Are there commits we want, but do not exist? */
    @@ -408,7 +405,7 @@
     +	)
     +'
     +
    -+test_expect_success 'fetch new submodule commits on-demand in FETCH_HEAD' '
    ++test_expect_success 'fetch new submodule commit on-demand in FETCH_HEAD' '
     +	# depends on the previous test for setup
     +
     +	C=$(git -C submodule commit-tree -m "another change outside refs/heads" HEAD^{tree}) &&
    @@ -462,5 +459,36 @@
     +		git checkout --recurse-submodules FETCH_HEAD
     +	)
     +'
    ++
    ++test_expect_success 'fetch new submodule commit intermittently referenced by superproject' '
    ++	# depends on the previous test for setup
    ++
    ++	D=$(git -C sub1 commit-tree -m "change 10 outside refs/heads" HEAD^{tree}) &&
    ++	E=$(git -C sub1 commit-tree -m "change 11 outside refs/heads" HEAD^{tree}) &&
    ++	F=$(git -C sub1 commit-tree -m "change 12 outside refs/heads" HEAD^{tree}) &&
    ++
    ++	git -C sub1 update-ref refs/changes/10 $D &&
    ++	git update-index --cacheinfo 160000 $D sub1 &&
    ++	git commit -m "updated submodules outside of refs/heads" &&
    ++
    ++	git -C sub1 update-ref refs/changes/11 $E &&
    ++	git update-index --cacheinfo 160000 $E sub1 &&
    ++	git commit -m "updated submodules outside of refs/heads" &&
    ++
    ++	git -C sub1 update-ref refs/changes/12 $F &&
    ++	git update-index --cacheinfo 160000 $F sub1 &&
    ++	git commit -m "updated submodules outside of refs/heads" &&
    ++
    ++	G=$(git rev-parse HEAD) &&
    ++	git update-ref refs/changes/13 $G &&
    ++	(
    ++		cd downstream &&
    ++		git fetch --recurse-submodules origin refs/changes/13 &&
    ++
    ++		git -C sub1 cat-file -t $D &&
    ++		git -C sub1 cat-file -t $E &&
    ++		git -C sub1 cat-file -t $F
    ++	)
    ++'
     +
      test_done

 builtin/fetch.c             |  11 +-
 submodule.c                 | 206 +++++++++++++++++++++++++++++++-----
 t/t5526-fetch-submodules.sh | 117 ++++++++++++++++++++
 3 files changed, 296 insertions(+), 38 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e0140327aa..91f9b7d9c8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -763,9 +763,6 @@ static int update_local_ref(struct ref *ref,
 			what = _("[new ref]");
 		}
 
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref(msg, ref, 0);
 		format_display(display, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
@@ -779,9 +776,6 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref("fast-forward", ref, 1);
 		format_display(display, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
@@ -794,9 +788,6 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
-		    (recurse_submodules != RECURSE_SUBMODULES_ON))
-			check_for_new_submodule_commits(&ref->new_oid);
 		r = s_update_ref("forced-update", ref, 1);
 		format_display(display, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
@@ -892,6 +883,8 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				ref->force = rm->peer_ref->force;
 			}
 
+			if (recurse_submodules != RECURSE_SUBMODULES_OFF)
+				check_for_new_submodule_commits(&rm->old_oid);
 
 			if (!strcmp(rm->name, "HEAD")) {
 				kind = "";
diff --git a/submodule.c b/submodule.c
index d1b6646f42..b88343d977 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1231,8 +1231,14 @@ struct submodule_parallel_fetch {
 	int result;
 
 	struct string_list changed_submodule_names;
+
+	/* Pending fetches by OIDs */
+	struct fetch_task **oid_fetch_tasks;
+	int oid_fetch_tasks_nr, oid_fetch_tasks_alloc;
 };
-#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
+		  STRING_LIST_INIT_DUP, \
+		  NULL, 0, 0}
 
 static int get_fetch_recurse_config(const struct submodule *submodule,
 				    struct submodule_parallel_fetch *spf)
@@ -1259,6 +1265,76 @@ static int get_fetch_recurse_config(const struct submodule *submodule,
 	return spf->default_option;
 }
 
+/*
+ * Fetch in progress (if callback data) or
+ * pending (if in oid_fetch_tasks in struct submodule_parallel_fetch)
+ */
+struct fetch_task {
+	struct repository *repo;
+	const struct submodule *sub;
+	unsigned free_sub : 1; /* Do we need to free the submodule? */
+
+	struct oid_array *commits; /* Ensure these commits are fetched */
+};
+
+/**
+ * When a submodule is not defined in .gitmodules, we cannot access it
+ * via the regular submodule-config. Create a fake submodule, which we can
+ * work on.
+ */
+static const struct submodule *get_non_gitmodules_submodule(const char *path)
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
+static struct fetch_task *fetch_task_create(struct repository *r,
+					    const char *path)
+{
+	struct fetch_task *task = xmalloc(sizeof(*task));
+	memset(task, 0, sizeof(*task));
+
+	task->sub = submodule_from_path(r, &null_oid, path);
+	if (!task->sub) {
+		/*
+		 * No entry in .gitmodules? Technically not a submodule,
+		 * but historically we supported repositories that happen to be
+		 * in-place where a gitlink is. Keep supporting them.
+		 */
+		task->sub = get_non_gitmodules_submodule(path);
+		if (!task->sub) {
+			free(task);
+			return NULL;
+		}
+
+		task->free_sub = 1;
+	}
+
+	return task;
+}
+
+static void fetch_task_release(struct fetch_task *p)
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
@@ -1286,39 +1362,29 @@ static struct repository *get_submodule_repo_for(struct repository *r,
 static int get_next_submodule(struct child_process *cp,
 			      struct strbuf *err, void *data, void **task_cb)
 {
-	int ret = 0;
 	struct submodule_parallel_fetch *spf = data;
 
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
-		struct strbuf submodule_prefix = STRBUF_INIT;
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
 		const char *default_argv;
-		const struct submodule *submodule;
-		struct repository *repo;
-		struct submodule default_submodule = SUBMODULE_INIT;
+		struct fetch_task *task;
 
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
-		}
+		task = fetch_task_create(spf->r, ce->name);
+		if (!task)
+			continue;
 
-		switch (get_fetch_recurse_config(submodule, spf))
+		switch (get_fetch_recurse_config(task->sub, spf))
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
@@ -1329,11 +1395,11 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, ce->name);
-		repo = get_submodule_repo_for(spf->r, submodule);
-		if (repo) {
+		task->repo = get_submodule_repo_for(spf->r, task->sub);
+		if (task->repo) {
+			struct strbuf submodule_prefix = STRBUF_INIT;
 			child_process_init(cp);
-			cp->dir = xstrdup(repo->gitdir);
+			cp->dir = task->repo->gitdir;
 			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
 			cp->git_cmd = 1;
 			if (!spf->quiet)
@@ -1343,12 +1409,22 @@ static int get_next_submodule(struct child_process *cp,
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
+			fetch_task_release(task);
+			free(task);
+
 			/*
 			 * An empty directory is normal,
 			 * the submodule is not initialized
@@ -1361,12 +1437,38 @@ static int get_next_submodule(struct child_process *cp,
 					    ce->name);
 			}
 		}
+	}
+
+	if (spf->oid_fetch_tasks_nr) {
+		struct fetch_task *task =
+			spf->oid_fetch_tasks[spf->oid_fetch_tasks_nr - 1];
+		struct strbuf submodule_prefix = STRBUF_INIT;
+		spf->oid_fetch_tasks_nr--;
+
+		strbuf_addf(&submodule_prefix, "%s%s/",
+			    spf->prefix, task->sub->path);
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
+		/* NEEDSWORK: have get_default_remote from submodule--helper */
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
 
@@ -1374,20 +1476,66 @@ static int fetch_start_failure(struct strbuf *err,
 			       void *cb, void *task_cb)
 {
 	struct submodule_parallel_fetch *spf = cb;
+	struct fetch_task *task = task_cb;
 
 	spf->result = 1;
 
+	fetch_task_release(task);
 	return 0;
 }
 
+static int commit_missing_in_sub(const struct object_id *oid, void *data)
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
+	struct fetch_task *task = task_cb;
+
+	struct string_list_item *it;
+	struct oid_array *commits;
 
 	if (retvalue)
 		spf->result = 1;
 
+	if (!task || !task->sub)
+		BUG("callback cookie bogus");
+
+	/* Is this the second time we process this submodule? */
+	if (task->commits)
+		goto out;
+
+	it = string_list_lookup(&spf->changed_submodule_names, task->sub->name);
+	if (!it)
+		/* Could be an unchanged submodule, not contained in the list */
+		goto out;
+
+	commits = it->util;
+	oid_array_filter(commits,
+			 commit_missing_in_sub,
+			 task->repo);
+
+	/* Are there commits we want, but do not exist? */
+	if (commits->nr) {
+		task->commits = commits;
+		ALLOC_GROW(spf->oid_fetch_tasks,
+			   spf->oid_fetch_tasks_nr + 1,
+			   spf->oid_fetch_tasks_alloc);
+		spf->oid_fetch_tasks[spf->oid_fetch_tasks_nr] = task;
+		spf->oid_fetch_tasks_nr++;
+		return 0;
+	}
+
+out:
+	fetch_task_release(task);
+
 	return 0;
 }
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 6c2f9b2ba2..9f8c744eb5 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -600,4 +600,121 @@ test_expect_success "fetch new commits when submodule got renamed" '
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
+	git update-ref refs/changes/3 $E &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin refs/changes/3:refs/heads/my_branch &&
+		git -C submodule cat-file -t $C &&
+		git -C sub1 cat-file -t $D &&
+		git checkout --recurse-submodules FETCH_HEAD
+	)
+'
+
+test_expect_success 'fetch new submodule commit on-demand in FETCH_HEAD' '
+	# depends on the previous test for setup
+
+	C=$(git -C submodule commit-tree -m "another change outside refs/heads" HEAD^{tree}) &&
+	git -C submodule update-ref refs/changes/4 $C &&
+	git update-index --cacheinfo 160000 $C submodule &&
+	test_tick &&
+
+	D=$(git -C sub1 commit-tree -m "another change outside refs/heads" HEAD^{tree}) &&
+	git -C sub1 update-ref refs/changes/5 $D &&
+	git update-index --cacheinfo 160000 $D sub1 &&
+
+	git commit -m "updated submodules outside of refs/heads" &&
+	E=$(git rev-parse HEAD) &&
+	git update-ref refs/changes/6 $E &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin refs/changes/6 &&
+		git -C submodule cat-file -t $C &&
+		git -C sub1 cat-file -t $D &&
+		git checkout --recurse-submodules FETCH_HEAD
+	)
+'
+
+test_expect_success 'fetch new submodule commits on-demand without .gitmodules entry' '
+	# depends on the previous test for setup
+
+	git config -f .gitmodules --remove-section submodule.sub1 &&
+	git add .gitmodules &&
+	git commit -m "delete gitmodules file" &&
+	git checkout -B master &&
+	git -C downstream fetch &&
+	git -C downstream checkout origin/master &&
+
+	C=$(git -C submodule commit-tree -m "yet another change outside refs/heads" HEAD^{tree}) &&
+	git -C submodule update-ref refs/changes/7 $C &&
+	git update-index --cacheinfo 160000 $C submodule &&
+	test_tick &&
+
+	D=$(git -C sub1 commit-tree -m "yet another change outside refs/heads" HEAD^{tree}) &&
+	git -C sub1 update-ref refs/changes/8 $D &&
+	git update-index --cacheinfo 160000 $D sub1 &&
+
+	git commit -m "updated submodules outside of refs/heads" &&
+	E=$(git rev-parse HEAD) &&
+	git update-ref refs/changes/9 $E &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin refs/changes/9 &&
+		git -C submodule cat-file -t $C &&
+		git -C sub1 cat-file -t $D &&
+		git checkout --recurse-submodules FETCH_HEAD
+	)
+'
+
+test_expect_success 'fetch new submodule commit intermittently referenced by superproject' '
+	# depends on the previous test for setup
+
+	D=$(git -C sub1 commit-tree -m "change 10 outside refs/heads" HEAD^{tree}) &&
+	E=$(git -C sub1 commit-tree -m "change 11 outside refs/heads" HEAD^{tree}) &&
+	F=$(git -C sub1 commit-tree -m "change 12 outside refs/heads" HEAD^{tree}) &&
+
+	git -C sub1 update-ref refs/changes/10 $D &&
+	git update-index --cacheinfo 160000 $D sub1 &&
+	git commit -m "updated submodules outside of refs/heads" &&
+
+	git -C sub1 update-ref refs/changes/11 $E &&
+	git update-index --cacheinfo 160000 $E sub1 &&
+	git commit -m "updated submodules outside of refs/heads" &&
+
+	git -C sub1 update-ref refs/changes/12 $F &&
+	git update-index --cacheinfo 160000 $F sub1 &&
+	git commit -m "updated submodules outside of refs/heads" &&
+
+	G=$(git rev-parse HEAD) &&
+	git update-ref refs/changes/13 $G &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin refs/changes/13 &&
+
+		git -C sub1 cat-file -t $D &&
+		git -C sub1 cat-file -t $E &&
+		git -C sub1 cat-file -t $F
+	)
+'
+
 test_done
-- 
2.20.0.rc2.230.gc28305e538

