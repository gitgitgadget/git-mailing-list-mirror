Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A46C433FE
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 04:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiBJEmX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 23:42:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiBJEmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 23:42:14 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CBB1D9
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 20:42:10 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id s207-20020a6277d8000000b004e0300e14f7so3402575pfc.23
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 20:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e28xifxc0TecP0d2abvh2V44aTg63b/t34PT8APBmdc=;
        b=RYnIt+jfE2OoWXJsAJ8aiBYa5sy91wiPHW2FuOS1fbSDQuXEWY19YcclM5OdlrAKYh
         mfvvesvHGzR4YLAaZ7gtr40KYgNISejSYwoNX5b3LAkBJexupqRQ02KRRScMrlqT4TM/
         BEB8t+cvslGg/JaVHTFOnp4rSVdNSoQdl2ezGBWVJ8pf0Gf9zpgMXPbcc/HKRUcxB/X0
         DM2eQXMbKESlupoGk5+J9VO/FOjzrOJ89oZP/ufi5DbAOuvk2gl07wWvVDqUPzFYbXv7
         55baNNLbkNkfY0+DesjoQcIsczKdzkqca0TaKJOChR4MZe1y4Y1IjwVNdGGno3CUJWhj
         eeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e28xifxc0TecP0d2abvh2V44aTg63b/t34PT8APBmdc=;
        b=yMecIjEaehnTmApCd/2Gbtj9lYN3yUlgL25G6UBb5W44dO3nBjnYiPjwhRUHiSdbx3
         WE7kmk5VdfbYqMd6pANnQ8bNMLZfchU7ckyoQqsDRZdbFrNy71pzkJkDKL4ffGlTFia9
         dD/IeoU8y+HquqSVhboBXVeM1QDjeiWzx6sjHFRT/UMtEae8AhEvyAEaA48Z0Rt54YYG
         xRCNthrjVKH2oTTfJo1y5P2YJ2F+8mCPp/ThqW0G5U48gVdF1p2RMObUZ5UpwpstplEV
         mc32JfzfDexE7vBFKJqUxUjpLrEWcWtqDUCcYnzBPAferKSwS6so14Uu2gIiJpgJgpyq
         GLTA==
X-Gm-Message-State: AOAM531fliRAV8x2dd/+rAzBrtYFFB7KJgxrZAmmA3WSMsfdtcWPEIUW
        FNsHrXjEQWyPZAP/AozGDZiRP9x++KMhKFkXajHHSTY0m7OtE5E2ri3nxrWpjeiAE0irya7qpSY
        VYCy8/xWK/+BC1f7PYEIne9HqNyPp4nfMrZSMmZnwf9zEku93jGdWUBWZLAZpE7Y=
X-Google-Smtp-Source: ABdhPJzlbGq7Hs2aachtSUMOhNt4N+UKrWi6aeUXZrp+g7gSZUmyTIMlX1wKavVePrXF2kqewLuzGd1x7/XaHw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d34b:: with SMTP id
 l11mr5646685plk.137.1644468130362; Wed, 09 Feb 2022 20:42:10 -0800 (PST)
Date:   Thu, 10 Feb 2022 12:41:51 +0800
In-Reply-To: <20220210044152.78352-1-chooglen@google.com>
Message-Id: <20220210044152.78352-8-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 7/8] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git fetch --recurse-submodules" only considers populated
submodules (i.e. submodules that can be found by iterating the index),
which makes "git fetch" behave differently based on which commit is
checked out. As a result, even if the user has initialized all submodules
correctly, they may not fetch the necessary submodule commits, and
commands like "git checkout --recurse-submodules" might fail.

Teach "git fetch" to fetch cloned, changed submodules regardless of
whether they are populated (this is in addition to the current behavior
of fetching populated submodules).

Since a submodule may be encountered multiple times (via the list of
populated submodules or via the list of changed submodules), maintain a
list of seen submodules to avoid fetching a submodule more than once.

Signed-off-by: Glen Choo <chooglen@google.com>
---
submodule.c has a seemingly-unrelated change that teaches the "find
changed submodules" rev walk to call is_repository_shallow(). This fixes
what I believe is a legitimate bug - the rev walk would fail on a
shallow repo.

Our test suite did not catch this prior to this commit because we skip
the rev walk if .gitmodules is not found, and thus the test suite did
not attempt the rev walk on a shallow clone. After this commit,
we always attempt to find changed submodules (regardless of whether
there is a .gitmodules file), and the test suite noticed the bug.

 Documentation/fetch-options.txt |  26 ++--
 Documentation/git-fetch.txt     |  10 +-
 submodule.c                     | 101 +++++++++++++--
 t/t5526-fetch-submodules.sh     | 217 ++++++++++++++++++++++++++++++++
 4 files changed, 328 insertions(+), 26 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index e967ff1874..38dad13683 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -185,15 +185,23 @@ endif::git-pull[]
 ifndef::git-pull[]
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
-	populated submodules should be fetched too. It can be used as a
-	boolean option to completely disable recursion when set to 'no' or to
-	unconditionally recurse into all populated submodules when set to
-	'yes', which is the default when this option is used without any
-	value. Use 'on-demand' to only recurse into a populated submodule
-	when the superproject retrieves a commit that updates the submodule's
-	reference to a commit that isn't already in the local submodule
-	clone. By default, 'on-demand' is used, unless
-	`fetch.recurseSubmodules` is set (see linkgit:git-config[1]).
+	submodules should be fetched too. When recursing through submodules,
+	`git fetch` always attempts to fetch "changed" submodules, that is, a
+	submodule that has commits that are referenced by a newly fetched
+	superproject commit but are missing in the local submodule clone. A
+	changed submodule can be fetched as long as it is present locally e.g.
+	in `$GIT_DIR/modules/` (see linkgit:gitsubmodules[7]); if the upstream
+	adds a new submodule, that submodule cannot be fetched until it is
+	cloned e.g. by `git submodule update`.
++
+When set to 'on-demand', only changed submodules are fetched. When set
+to 'yes', all populated submodules are fetched and submodules that are
+both unpopulated and changed are fetched. When set to 'no', submodules
+are never fetched.
++
+When unspecified, this uses the value of `fetch.recurseSubmodules` if it
+is set (see linkgit:git-config[1]), defaulting to 'on-demand' if unset.
+When this option is used without any value, it defaults to 'yes'.
 endif::git-pull[]
 
 -j::
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 550c16ca61..e9d364669a 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -287,12 +287,10 @@ include::transfer-data-leaks.txt[]
 
 BUGS
 ----
-Using --recurse-submodules can only fetch new commits in already checked
-out submodules right now. When e.g. upstream added a new submodule in the
-just fetched commits of the superproject the submodule itself cannot be
-fetched, making it impossible to check out that submodule later without
-having to do a fetch again. This is expected to be fixed in a future Git
-version.
+Using --recurse-submodules can only fetch new commits in submodules that are
+present locally e.g. in `$GIT_DIR/modules/`. If the upstream adds a new
+submodule, that submodule cannot be fetched until it is cloned e.g. by `git
+submodule update`. This is expected to be fixed in a future Git version.
 
 SEE ALSO
 --------
diff --git a/submodule.c b/submodule.c
index d695dcadf4..0c02bbc9c3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -22,6 +22,7 @@
 #include "parse-options.h"
 #include "object-store.h"
 #include "commit-reach.h"
+#include "shallow.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int initialized_fetch_ref_tips;
@@ -907,6 +908,9 @@ static void collect_changed_submodules(struct repository *r,
 
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
+	/* make sure shallows are read */
+	is_repository_shallow(the_repository);
+
 	repo_init_revisions(r, &rev, NULL);
 	setup_revisions(argv->nr, argv->v, &rev, &s_r_opt);
 	warn_on_object_refname_ambiguity = save_warning;
@@ -1273,10 +1277,6 @@ static void calculate_changed_submodule_paths(struct repository *r,
 	struct strvec argv = STRVEC_INIT;
 	struct string_list_item *name;
 
-	/* No need to check if there are no submodules configured */
-	if (!submodule_from_path(r, NULL, NULL))
-		return;
-
 	strvec_push(&argv, "--"); /* argv[0] program name */
 	oid_array_for_each_unique(&ref_tips_after_fetch,
 				   append_oid_to_argv, &argv);
@@ -1347,7 +1347,8 @@ int submodule_touches_in_range(struct repository *r,
 }
 
 struct submodule_parallel_fetch {
-	int count;
+	int index_count;
+	int changed_count;
 	struct strvec args;
 	struct repository *r;
 	const char *prefix;
@@ -1357,6 +1358,7 @@ struct submodule_parallel_fetch {
 	int result;
 
 	struct string_list changed_submodule_names;
+	struct string_list seen_submodule_names;
 
 	/* Pending fetches by OIDs */
 	struct fetch_task **oid_fetch_tasks;
@@ -1367,6 +1369,7 @@ struct submodule_parallel_fetch {
 #define SPF_INIT { \
 	.args = STRVEC_INIT, \
 	.changed_submodule_names = STRING_LIST_INIT_DUP, \
+	.seen_submodule_names = STRING_LIST_INIT_DUP, \
 	.submodules_with_errors = STRBUF_INIT, \
 }
 
@@ -1481,11 +1484,12 @@ static struct repository *get_submodule_repo_for(struct repository *r,
 }
 
 static struct fetch_task *
-get_fetch_task(struct submodule_parallel_fetch *spf,
-	       const char **default_argv, struct strbuf *err)
+get_fetch_task_from_index(struct submodule_parallel_fetch *spf,
+			  const char **default_argv, struct strbuf *err)
 {
-	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
-		const struct cache_entry *ce = spf->r->index->cache[spf->count];
+	for (; spf->index_count < spf->r->index->cache_nr; spf->index_count++) {
+		const struct cache_entry *ce =
+			spf->r->index->cache[spf->index_count];
 		struct fetch_task *task;
 
 		if (!S_ISGITLINK(ce->ce_mode))
@@ -1495,6 +1499,15 @@ get_fetch_task(struct submodule_parallel_fetch *spf,
 		if (!task)
 			continue;
 
+		/*
+		 * We might have already considered this submodule
+		 * because we saw it when iterating the changed
+		 * submodule names.
+		 */
+		if (string_list_lookup(&spf->seen_submodule_names,
+				       task->sub->name))
+			continue;
+
 		switch (get_fetch_recurse_config(task->sub, spf))
 		{
 		default:
@@ -1542,7 +1555,69 @@ get_fetch_task(struct submodule_parallel_fetch *spf,
 			strbuf_addf(err, _("Fetching submodule %s%s\n"),
 				    spf->prefix, ce->name);
 
-		spf->count++;
+		spf->index_count++;
+		return task;
+	}
+	return NULL;
+}
+
+static struct fetch_task *
+get_fetch_task_from_changed(struct submodule_parallel_fetch *spf,
+			    const char **default_argv, struct strbuf *err)
+{
+	for (; spf->changed_count < spf->changed_submodule_names.nr;
+	     spf->changed_count++) {
+		struct string_list_item item =
+			spf->changed_submodule_names.items[spf->changed_count];
+		struct changed_submodule_data *cs_data = item.util;
+		struct fetch_task *task;
+
+		/*
+		 * We might have already considered this submodule
+		 * because we saw it in the index.
+		 */
+		if (string_list_lookup(&spf->seen_submodule_names, item.string))
+			continue;
+
+		task = fetch_task_create(spf->r, cs_data->path,
+					 cs_data->super_oid);
+		if (!task)
+			continue;
+
+		switch (get_fetch_recurse_config(task->sub, spf)) {
+		default:
+		case RECURSE_SUBMODULES_DEFAULT:
+		case RECURSE_SUBMODULES_ON_DEMAND:
+			*default_argv = "on-demand";
+			break;
+		case RECURSE_SUBMODULES_ON:
+			*default_argv = "yes";
+			break;
+		case RECURSE_SUBMODULES_OFF:
+			continue;
+		}
+
+		task->repo = get_submodule_repo_for(spf->r, task->sub->path,
+						    cs_data->super_oid);
+		if (!task->repo) {
+			fetch_task_release(task);
+			free(task);
+
+			strbuf_addf(err, _("Could not access submodule '%s'\n"),
+				    cs_data->path);
+			continue;
+		}
+		if (!is_tree_submodule_active(spf->r, cs_data->super_oid,
+					      task->sub->path))
+			continue;
+
+		if (!spf->quiet)
+			strbuf_addf(err,
+				    _("Fetching submodule %s%s at commit %s\n"),
+				    spf->prefix, task->sub->path,
+				    find_unique_abbrev(cs_data->super_oid,
+						       DEFAULT_ABBREV));
+		spf->changed_count++;
 		return task;
 	}
 	return NULL;
@@ -1553,7 +1628,10 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 {
 	struct submodule_parallel_fetch *spf = data;
 	const char *default_argv = NULL;
-	struct fetch_task *task = get_fetch_task(spf, &default_argv, err);
+	struct fetch_task *task =
+		get_fetch_task_from_index(spf, &default_argv, err);
+	if (!task)
+		task = get_fetch_task_from_changed(spf, &default_argv, err);
 
 	if (task) {
 		struct strbuf submodule_prefix = STRBUF_INIT;
@@ -1573,6 +1651,7 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 		*task_cb = task;
 
 		strbuf_release(&submodule_prefix);
+		string_list_insert(&spf->seen_submodule_names, task->sub->name);
 		return 1;
 	}
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index cb18f0ac21..f37dca4e09 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -399,6 +399,223 @@ test_expect_success "'--recurse-submodules=on-demand' recurses as deep as necess
 	verify_fetch_result actual.err
 '
 
+# Cleans up after tests that checkout branches other than the main ones
+# in the tests.
+checkout_main_branches() {
+	git -C downstream checkout --recurse-submodules super &&
+	git -C downstream/submodule checkout --recurse-submodules sub &&
+	git -C downstream/submodule/subdir/deepsubmodule checkout --recurse-submodules deep
+}
+
+# Test that we can fetch submodules in other branches by running fetch
+# in a branch that has no submodules.
+test_expect_success 'setup downstream branch without submodules' '
+	(
+		cd downstream &&
+		git checkout --recurse-submodules -b no-submodules &&
+		rm .gitmodules &&
+		git rm submodule &&
+		git add .gitmodules &&
+		git commit -m "no submodules" &&
+		git checkout --recurse-submodules super
+	)
+'
+
+test_expect_success "'--recurse-submodules=on-demand' should fetch submodule commits if the submodule is changed but the index has no submodules" '
+	test_when_finished "checkout_main_branches" &&
+	git -C downstream fetch --recurse-submodules &&
+	# Create new superproject commit with updated submodules
+	add_upstream_commit &&
+	(
+		cd submodule &&
+		(
+			cd subdir/deepsubmodule &&
+			git fetch &&
+			git checkout -q FETCH_HEAD
+		) &&
+		git add subdir/deepsubmodule &&
+		git commit -m "new deep submodule"
+	) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+
+	# Fetch the new superproject commit
+	(
+		cd downstream &&
+		git switch --recurse-submodules no-submodules &&
+		git fetch --recurse-submodules=on-demand >../actual.out 2>../actual.err &&
+		git checkout --recurse-submodules origin/super 2>../actual-checkout.err
+	) &&
+	test_must_be_empty actual.out &&
+	git rev-parse --short HEAD >superhead &&
+	git -C submodule rev-parse --short HEAD >subhead &&
+	git -C deepsubmodule rev-parse --short HEAD >deephead &&
+	verify_fetch_result actual.err &&
+
+	# Assert that the fetch happened at the non-HEAD commits
+	grep "Fetching submodule submodule at commit $superhead" actual.err &&
+	grep "Fetching submodule submodule/subdir/deepsubmodule at commit $subhead" actual.err &&
+
+	# Assert that we can checkout the superproject commit with --recurse-submodules
+	! grep -E "error: Submodule .+ could not be updated" actual-checkout.err
+'
+
+test_expect_success "'--recurse-submodules' should fetch submodule commits if the submodule is changed but the index has no submodules" '
+	test_when_finished "checkout_main_branches" &&
+	# Fetch any leftover commits from other tests.
+	git -C downstream fetch --recurse-submodules &&
+	# Create new superproject commit with updated submodules
+	add_upstream_commit &&
+	(
+		cd submodule &&
+		(
+			cd subdir/deepsubmodule &&
+			git fetch &&
+			git checkout -q FETCH_HEAD
+		) &&
+		git add subdir/deepsubmodule &&
+		git commit -m "new deep submodule"
+	) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+
+	# Fetch the new superproject commit
+	(
+		cd downstream &&
+		git switch --recurse-submodules no-submodules &&
+		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
+		git checkout --recurse-submodules origin/super 2>../actual-checkout.err
+	) &&
+	test_must_be_empty actual.out &&
+	git rev-parse --short HEAD >superhead &&
+	git -C submodule rev-parse --short HEAD >subhead &&
+	git -C deepsubmodule rev-parse --short HEAD >deephead &&
+	verify_fetch_result actual.err &&
+
+	# Assert that the fetch happened at the non-HEAD commits
+	grep "Fetching submodule submodule at commit $superhead" actual.err &&
+	grep "Fetching submodule submodule/subdir/deepsubmodule at commit $subhead" actual.err &&
+
+	# Assert that we can checkout the superproject commit with --recurse-submodules
+	! grep -E "error: Submodule .+ could not be updated" actual-checkout.err
+'
+
+test_expect_success "'--recurse-submodules' should ignore changed, inactive submodules" '
+	test_when_finished "checkout_main_branches" &&
+	# Fetch any leftover commits from other tests.
+	git -C downstream fetch --recurse-submodules &&
+	# Create new superproject commit with updated submodules
+	add_upstream_commit &&
+	(
+		cd submodule &&
+		(
+			cd subdir/deepsubmodule &&
+			git fetch &&
+			git checkout -q FETCH_HEAD
+		) &&
+		git add subdir/deepsubmodule &&
+		git commit -m "new deep submodule"
+	) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+
+	# Fetch the new superproject commit
+	(
+		cd downstream &&
+		git switch --recurse-submodules no-submodules &&
+		git -c submodule.submodule.active=false fetch --recurse-submodules >../actual.out 2>../actual.err
+	) &&
+	test_must_be_empty actual.out &&
+	git rev-parse --short HEAD >superhead &&
+	# Neither should be fetched because the submodule is inactive
+	rm subhead &&
+	rm deephead &&
+	verify_fetch_result actual.err
+'
+
+# Test that we properly fetch the submodules in the index as well as
+# submodules in other branches.
+test_expect_success 'setup downstream branch with other submodule' '
+	mkdir submodule2 &&
+	(
+		cd submodule2 &&
+		git init &&
+		echo sub2content >sub2file &&
+		git add sub2file &&
+		git commit -a -m new &&
+		git branch -M sub2
+	) &&
+	git checkout -b super-sub2-only &&
+	git submodule add "$pwd/submodule2" submodule2 &&
+	git commit -m "add sub2" &&
+	git checkout super &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules origin &&
+		git checkout super-sub2-only &&
+		# Explicitly run "git submodule update" because sub2 is new
+		# and has not been cloned.
+		git submodule update --init &&
+		git checkout --recurse-submodules super
+	)
+'
+
+test_expect_success "'--recurse-submodules' should fetch submodule commits in changed submodules and the index" '
+	test_when_finished "checkout_main_branches" &&
+	# Fetch any leftover commits from other tests.
+	git -C downstream fetch --recurse-submodules &&
+	# Create new commit in origin/super
+	add_upstream_commit &&
+	(
+		cd submodule &&
+		(
+			cd subdir/deepsubmodule &&
+			git fetch &&
+			git checkout -q FETCH_HEAD
+		) &&
+		git add subdir/deepsubmodule &&
+		git commit -m "new deep submodule"
+	) &&
+	git add submodule &&
+	git commit -m "new submodule" &&
+
+	# Create new commit in origin/super-sub2-only
+	git checkout super-sub2-only &&
+	(
+		cd submodule2 &&
+		test_commit --no-tag foo
+	) &&
+	git add submodule2 &&
+	git commit -m "new submodule2" &&
+
+	git checkout super &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
+		git checkout --recurse-submodules origin/super-sub2-only 2>../actual-checkout.err
+	) &&
+	test_must_be_empty actual.out &&
+
+	# Assert that the submodules in the super branch are fetched
+	git rev-parse --short HEAD >superhead &&
+	git -C submodule rev-parse --short HEAD >subhead &&
+	git -C deepsubmodule rev-parse --short HEAD >deephead &&
+	verify_fetch_result actual.err &&
+	# Assert that submodule is read from the index, not from a commit
+	! grep "Fetching submodule submodule at commit" actual.err &&
+
+	# Assert that super-sub2-only and submodule2 were fetched even
+	# though another branch is checked out
+	super_sub2_only_head=$(git rev-parse --short super-sub2-only) &&
+	grep -E "\.\.${super_sub2_only_head}\s+super-sub2-only\s+-> origin/super-sub2-only" actual.err &&
+	grep "Fetching submodule submodule2 at commit $super_sub2_only_head" actual.err &&
+	sub2head=$(git -C submodule2 rev-parse --short HEAD) &&
+	grep -E "\.\.${sub2head}\s+sub2\s+-> origin/sub2" actual.err &&
+
+	# Assert that we can checkout the superproject commit with --recurse-submodules
+	! grep -E "error: Submodule .+ could not be updated" actual-checkout.err
+'
+
 test_expect_success "'--recurse-submodules=on-demand' stops when no new submodule commits are found in the superproject (and ignores config)" '
 	add_upstream_commit &&
 	echo a >> file &&
-- 
2.33.GIT

