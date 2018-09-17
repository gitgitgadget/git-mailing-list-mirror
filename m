Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38E551F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeIRDFb (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:05:31 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:52549 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbeIRDFb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:05:31 -0400
Received: by mail-ua1-f74.google.com with SMTP id w10-v6so5867765uam.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sGlQMWR/00T+OpNMQAada+MpF2Y0Rc76PclyfAqDQTQ=;
        b=jNPKAHIsc8Jqqj8/jCACy2GRKFO1SXclCey1qfieySgWzr0vhweacqoLzqeqV9bP/q
         ddAW6EoJHF4DRSHyWekEK2bI46nhR2tT92SRgTAqg8a0CyGAcMa0QT15r3ABx3et+8w4
         3DL9SQfXmE/7+d4G8Zo4Vy0iTjPZGr8jNvAJlO9QUEnOCBnRGcalcEPQrQhAlxH/iDyz
         iAs9YcACwwIwouDjcqa5L96y+69TfnDh7azNp5XQNaeP40jyAU19UxWraC5WQt+mDSGo
         Ws7xxjLvJl1a14NFkNtBWH0w0iZk5mqiP39smTIZ8sgnP1Am1boSaoxyhIpGKl4zKdvk
         pehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sGlQMWR/00T+OpNMQAada+MpF2Y0Rc76PclyfAqDQTQ=;
        b=RCN9vzzrFAYxqp+LWN//WOpM0jfTFY+6m6eNvDHUYKzlaOuDFdnMfrLidjqc9i3waE
         NlA7rrZ6YqIdHK1Y+eTlzaGUtDypiXDo2q44QsDgRUQmv1uHyxyRnxG98vWuLm6Okhcw
         Lc/yKIUuAZokN4s4NAj/WEMbx17rxy2BhI4G+/jr2p3nnNJD78Ya8PJ9pI59xBKCFX7g
         MUKLZqhx8i4q0liF4v4t3adikeBDf7CxLOIItF8axpSdWx2mlGJWWMav9X+BrkbvLWEk
         AB54tUj2tcNfPe3MlZp1yzYIktN7MEMBkyg/2qCvuswr7YNp8imcvDmAx9p2xLzY1qoI
         161w==
X-Gm-Message-State: APzg51AeHXWjNsrj7SqurvpetGYEf8scCAPufv+4aJZr/mHCV/5pShR2
        JL4VTgYv+9vqAf/oTU8VB/ByZ1rquWLO
X-Google-Smtp-Source: ANB0VdaSzL796oNwmoXvXDe7nlmBdHS0pUKwAPeBrzqHn1R5wYeNRlrq5xMGO5GotiamwXN9eY+KZQJvxDnK
X-Received: by 2002:a9f:3aca:: with SMTP id q10-v6mr4815597uag.31.1537220181271;
 Mon, 17 Sep 2018 14:36:21 -0700 (PDT)
Date:   Mon, 17 Sep 2018 14:35:58 -0700
In-Reply-To: <20180917213559.126404-1-sbeller@google.com>
Message-Id: <20180917213559.126404-9-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com> <20180917213559.126404-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 8/9] fetch: retry fetching submodules if needed objects were
 not fetched
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
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
 builtin/fetch.c             |  9 ++--
 submodule.c                 | 87 ++++++++++++++++++++++++++++++++++++-
 t/t5526-fetch-submodules.sh | 16 +++++++
 3 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61bec5d213d..95c44bf6ffa 100644
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
index 88bce534268..7d59e56171f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1127,8 +1127,11 @@ struct submodule_parallel_fetch {
 	int result;
 
 	struct string_list changed_submodule_names;
+	struct string_list retry;
 };
-#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
+		  STRING_LIST_INIT_DUP, \
+		  STRING_LIST_INIT_NODUP}
 
 static void calculate_changed_submodule_paths(
 	struct submodule_parallel_fetch *spf)
@@ -1259,8 +1262,10 @@ static int get_next_submodule(struct child_process *cp,
 {
 	int ret = 0;
 	struct submodule_parallel_fetch *spf = data;
+	struct string_list_item *it;
 
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
+		int recurse_config;
 		struct strbuf submodule_prefix = STRBUF_INIT;
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
 		const char *git_dir, *default_argv;
@@ -1280,7 +1285,9 @@ static int get_next_submodule(struct child_process *cp,
 			}
 		}
 
-		switch (get_fetch_recurse_config(submodule, spf))
+		recurse_config = get_fetch_recurse_config(submodule, spf);
+
+		switch (recurse_config)
 		{
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
@@ -1321,9 +1328,50 @@ static int get_next_submodule(struct child_process *cp,
 		strbuf_release(&submodule_prefix);
 		if (ret) {
 			spf->count++;
+			if (submodule != &default_submodule)
+				/* discard const-ness: */
+				*task_cb = (void*)submodule;
 			return 1;
 		}
 	}
+
+retry_next:
+
+	if (spf->retry.nr) {
+		struct strbuf submodule_prefix = STRBUF_INIT;
+		const struct submodule *sub;
+
+		it = string_list_last(&spf->retry);
+		sub = submodule_from_name(spf->r, &null_oid,
+					  it->string);
+
+		child_process_init(cp);
+		cp->dir = get_submodule_git_dir(spf->r, sub->path);
+		if (!cp->dir) {
+			string_list_pop(&spf->retry, 0);
+			goto retry_next;
+		}
+		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+		cp->git_cmd = 1;
+
+		strbuf_addf(&submodule_prefix, "%s%s/", spf->prefix, sub->path);
+		argv_array_init(&cp->args);
+		argv_array_pushv(&cp->args, spf->args.argv);
+		argv_array_push(&cp->args, "on-demand");
+		argv_array_push(&cp->args, "--submodule-prefix");
+		argv_array_push(&cp->args, submodule_prefix.buf);
+
+		/* NEEDSWORK: have get_default_remote from s--h */
+		argv_array_push(&cp->args, "origin");
+		oid_array_for_each_unique(it->util,
+					  append_oid_to_argv, &cp->args);
+
+		*task_cb = NULL; /* make sure we do not recurse forever */
+		strbuf_release(&submodule_prefix);
+		string_list_pop(&spf->retry, 0);
+		return 1;
+	}
+
 	return 0;
 }
 
@@ -1337,14 +1385,49 @@ static int fetch_start_failure(struct strbuf *err,
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
+	struct submodule *sub = task_cb;
+	struct repository subrepo;
 
 	if (retvalue)
 		spf->result = 1;
 
+	if (!sub)
+		return 0;
+
+	if (repo_submodule_init(&subrepo, spf->r, sub->path) < 0)
+		warning(_("Could not get submodule repository for submodule '%s' in repository '%s'"),
+			  sub->path, spf->r->worktree);
+	else {
+		struct string_list_item *it;
+		struct oid_array *commits;
+
+		it = string_list_lookup(&spf->changed_submodule_names, sub->name);
+		if (!it)
+			return 0;
+
+		commits = it->util;
+		oid_array_filter(commits,
+				 commit_exists_in_sub,
+				 &subrepo);
+
+		if (commits->nr)
+			string_list_append(&spf->retry, sub->name)
+				->util = commits;
+	}
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
2.19.0.397.gdd90340f6a-goog

