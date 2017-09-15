Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5AFA20281
	for <e@80x24.org>; Fri, 15 Sep 2017 13:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdIONS6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 09:18:58 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.28]:24190 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdIONS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 09:18:57 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1dsqWE-0005Le-Fv; Fri, 15 Sep 2017 15:18:54 +0200
Date:   Fri, 15 Sep 2017 15:18:53 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
        Brandon Williams <bmwill@google.com>
Subject: [RFC PATCH v2 1/2] implement fetching of moved submodules
Message-ID: <20170915131853.GA99666@book.hvoigt.net>
References: <20170817105349.GC52233@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170817105349.GC52233@book.hvoigt.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We store the changed submodules paths to calculate which submodule needs
fetching. This does not work for moved submodules since their paths do
not stay the same in case of a moved submodules. In case of new
submodules we do not have a path in the current checkout, since they
just appeared in this fetch.

It is more general to collect the submodule names for changes instead of
their paths to include the above cases.

With the change described above we implement 'on-demand' fetching of
changes in moved submodules.

Note: This does only work when repositories have a .gitmodules file. In
other words: It breaks if we do not get a name for a repository.
IIRC, consensus was that this is a requirement to get nice submodule
handling these days?

NEEDSWORK: This breaks t5531 and t5545 because they do not use a
.gitmodules file. I will add a fallback to paths to help such users.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
This an update of the previous series[1] to the current master. The
fallback is still missing but now it should not conflict with any topics
in flight anymore (hopefully).

Cheers Heiko

[1] https://public-inbox.org/git/20170817105349.GC52233@book.hvoigt.net/

 submodule.c                 | 91 +++++++++++++++++++++++++--------------------
 t/t5526-fetch-submodules.sh | 35 +++++++++++++++++
 2 files changed, 85 insertions(+), 41 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3cea8221e0..38b9905e43 100644
--- a/submodule.c
+++ b/submodule.c
@@ -21,7 +21,7 @@
 #include "parse-options.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
-static struct string_list changed_submodule_paths = STRING_LIST_INIT_DUP;
+static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
 static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
@@ -667,11 +667,11 @@ const struct submodule *submodule_from_ce(const struct cache_entry *ce)
 }
 
 static struct oid_array *submodule_commits(struct string_list *submodules,
-					   const char *path)
+					   const char *name)
 {
 	struct string_list_item *item;
 
-	item = string_list_insert(submodules, path);
+	item = string_list_insert(submodules, name);
 	if (item->util)
 		return (struct oid_array *) item->util;
 
@@ -680,39 +680,34 @@ static struct oid_array *submodule_commits(struct string_list *submodules,
 	return (struct oid_array *) item->util;
 }
 
+struct collect_changed_submodules_cb_data {
+	struct string_list *changed;
+	const struct object_id *commit_oid;
+};
+
 static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 					  struct diff_options *options,
 					  void *data)
 {
+	struct collect_changed_submodules_cb_data *me = data;
+	struct string_list *changed = me->changed;
+	const struct object_id *commit_oid = me->commit_oid;
 	int i;
-	struct string_list *changed = data;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		struct oid_array *commits;
+		const struct submodule *submodule;
+
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
 
-		if (S_ISGITLINK(p->one->mode)) {
-			/*
-			 * NEEDSWORK: We should honor the name configured in
-			 * the .gitmodules file of the commit we are examining
-			 * here to be able to correctly follow submodules
-			 * being moved around.
-			 */
-			commits = submodule_commits(changed, p->two->path);
-			oid_array_append(commits, &p->two->oid);
-		} else {
-			/* Submodule is new or was moved here */
-			/*
-			 * NEEDSWORK: When the .git directories of submodules
-			 * live inside the superprojects .git directory some
-			 * day we should fetch new submodules directly into
-			 * that location too when config or options request
-			 * that so they can be checked out from there.
-			 */
+		submodule = submodule_from_path(commit_oid, p->two->path);
+		if (!submodule)
 			continue;
-		}
+
+		commits = submodule_commits(changed, submodule->name);
+		oid_array_append(commits, &p->two->oid);
 	}
 }
 
@@ -735,11 +730,14 @@ static void collect_changed_submodules(struct string_list *changed,
 
 	while ((commit = get_revision(&rev))) {
 		struct rev_info diff_rev;
+		struct collect_changed_submodules_cb_data data;
+		data.changed = changed;
+		data.commit_oid = &commit->object.oid;
 
 		init_revisions(&diff_rev, NULL);
 		diff_rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 		diff_rev.diffopt.format_callback = collect_changed_submodules_cb;
-		diff_rev.diffopt.format_callback_data = changed;
+		diff_rev.diffopt.format_callback_data = &data;
 		diff_tree_combined_merge(commit, 1, &diff_rev);
 	}
 
@@ -870,7 +868,7 @@ int find_unpushed_submodules(struct oid_array *commits,
 		const char *remotes_name, struct string_list *needs_pushing)
 {
 	struct string_list submodules = STRING_LIST_INIT_DUP;
-	struct string_list_item *submodule;
+	struct string_list_item *name;
 	struct argv_array argv = ARGV_ARRAY_INIT;
 
 	/* argv.argv[0] will be ignored by setup_revisions */
@@ -881,12 +879,16 @@ int find_unpushed_submodules(struct oid_array *commits,
 
 	collect_changed_submodules(&submodules, &argv);
 
-	for_each_string_list_item(submodule, &submodules) {
-		struct oid_array *commits = submodule->util;
-		const char *path = submodule->string;
+	for_each_string_list_item(name, &submodules) {
+		struct oid_array *commits = name->util;
+		const struct submodule *submodule;
+
+		submodule = submodule_from_name(&null_oid, name->string);
+		if (!submodule)
+			continue;
 
-		if (submodule_needs_pushing(path, commits))
-			string_list_insert(needs_pushing, path);
+		if (submodule_needs_pushing(submodule->path, commits))
+			string_list_insert(needs_pushing, submodule->path);
 	}
 
 	free_submodules_oids(&submodules);
@@ -1041,7 +1043,7 @@ static void calculate_changed_submodule_paths(void)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
-	const struct string_list_item *item;
+	const struct string_list_item *name;
 
 	/* No need to check if there are no submodules configured */
 	if (!submodule_from_path(NULL, NULL))
@@ -1056,16 +1058,20 @@ static void calculate_changed_submodule_paths(void)
 
 	/*
 	 * Collect all submodules (whether checked out or not) for which new
-	 * commits have been recorded upstream in "changed_submodule_paths".
+	 * commits have been recorded upstream in "changed_submodule_names".
 	 */
 	collect_changed_submodules(&changed_submodules, &argv);
 
-	for_each_string_list_item(item, &changed_submodules) {
-		struct oid_array *commits = item->util;
-		const char *path = item->string;
+	for_each_string_list_item(name, &changed_submodules) {
+		struct oid_array *commits = name->util;
+		const struct submodule *submodule;
+
+		submodule = submodule_from_name(&null_oid, name->string);
+		if (!submodule)
+			continue;
 
-		if (!submodule_has_commits(path, commits))
-			string_list_append(&changed_submodule_paths, path);
+		if (!submodule_has_commits(submodule->path, commits))
+			string_list_append(&changed_submodule_names, name->string);
 	}
 
 	free_submodules_oids(&changed_submodules);
@@ -1151,7 +1157,8 @@ static int get_next_submodule(struct child_process *cp,
 				if (fetch_recurse == RECURSE_SUBMODULES_OFF)
 					continue;
 				if (fetch_recurse == RECURSE_SUBMODULES_ON_DEMAND) {
-					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
+					if (!unsorted_string_list_lookup(&changed_submodule_names,
+									 submodule->name))
 						continue;
 					default_argv = "on-demand";
 				}
@@ -1159,13 +1166,15 @@ static int get_next_submodule(struct child_process *cp,
 				if (spf->default_option == RECURSE_SUBMODULES_OFF)
 					continue;
 				if (spf->default_option == RECURSE_SUBMODULES_ON_DEMAND) {
-					if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
+					if (!unsorted_string_list_lookup(&changed_submodule_names,
+									  submodule->name))
 						continue;
 					default_argv = "on-demand";
 				}
 			}
 		} else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
-			if (!unsorted_string_list_lookup(&changed_submodule_paths, ce->name))
+			if (!unsorted_string_list_lookup(&changed_submodule_names,
+							 submodule->name))
 				continue;
 			default_argv = "on-demand";
 		}
@@ -1258,7 +1267,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&changed_submodule_paths, 1);
+	string_list_clear(&changed_submodule_names, 1);
 	return spf.result;
 }
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 42251f7f3a..22a7358b6f 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -530,4 +530,39 @@ test_expect_success 'fetching submodule into a broken repository' '
 	test_must_fail git -C dst fetch --recurse-submodules
 '
 
+test_expect_success "fetch new commits when submodule got renamed" '
+	git clone . downstream_rename &&
+	(
+		cd downstream_rename &&
+		git submodule update --init &&
+# NEEDSWORK: we omitted --recursive for the submodule update here since
+# that does not work. See test 7001 for mv "moving nested submodules"
+# for details. Once that is fixed we should add the --recursive option
+# here.
+		git checkout -b rename &&
+		git mv submodule submodule_renamed &&
+		(
+			cd submodule_renamed &&
+			git checkout -b rename_sub &&
+			echo a >a &&
+			git add a &&
+			git commit -ma &&
+			git push origin rename_sub &&
+			git rev-parse HEAD >../../expect
+		) &&
+		git add submodule_renamed &&
+		git commit -m "update renamed submodule" &&
+		git push origin rename
+	) &&
+	(
+		cd downstream &&
+		git fetch --recurse-submodules=on-demand &&
+		(
+			cd submodule &&
+			git rev-parse origin/rename_sub >../../actual
+		)
+	) &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.14.1.145.gb3622a4

