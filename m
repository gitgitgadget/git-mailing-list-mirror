Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D8CC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 04:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiBJEmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 23:42:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiBJEl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 23:41:58 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4983113E
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 20:42:00 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id a15-20020a17090ad80f00b001b8a1e1da50so3329115pjv.6
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 20:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HKgOTLFGE50cSv+qQN0vXG7pGzl1KoId7DOuDb7YA7Y=;
        b=Tvgq8OnGwZIXYEmhgW6IlA+wK6ONa/Mkplc30pPem549+6vbCNBlEq+88L0pUcz6nW
         JQfFp/brMnnuRHRAsriyzNS3txE272K4iQQxIglVl6E8eoiYt9qAYEIXrkQ3qrt8eEQJ
         ng8j4f+E0x1Lco1WkG2L1jbvbWQjZ0zv0wDitVBqnHamfJ1HP8le/q1GMFB7puCK7tus
         IEmH1y5+j6YEFpMTRZCJvM/uA9hHFiqQliZK9bmbWWVfxMA8PrQW7c6Ngws0CygNd/nA
         SMeLzMenUfqOTT7ZUJOM6kzNmkjY8inMRmzsct3XKJ+QBP1KtpsbjHB36wtENqnVSTpc
         QAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HKgOTLFGE50cSv+qQN0vXG7pGzl1KoId7DOuDb7YA7Y=;
        b=JuDH2U+ngOE31api5Hf+v+a9ZtS/d+7BVbekURwccOfiuU1Q+wpNqulkuMGPyZDe2e
         xyY2sG3DXtQylW4ueXaEl9IlLosLM28I6JTP7UrVjTgYzhePPYZGgUlcMlzu78Hhandk
         MLmSa9IFy727LZSsiGCIHWxQpDWYhYKOMcsj+NAFWc28341zksIv59xd7LJHSxPCpU5L
         O5VTixOHMKGcyKDLUEUSZvgUIq27dpK0YdNUVIrjU8ObRXC/QcQRx0UwzQFI/hnXt6uV
         qRaU8olafzF3Xq8ENJ3wNN8VzXRc0FqZE/VqTn0VV7dVF9a0qUoCPWOJidb+JB1JjHCt
         XWmQ==
X-Gm-Message-State: AOAM531DAdnemQDlModR6W7reTCM3XEtYtug/sm/ovUCcBuikeTzaj6u
        milo9b6hR3ndN7ZBawQQVyTvJIseK7rhXgZU6iqfSzazyMDU38EUb7gjmRRugo8l20YRjMYNrvd
        upRayUWphf+tfftdUXlHv1G7MRg80BVJwONJmP+Q7iHOEkwQ91iO28/IYCrGKfGE=
X-Google-Smtp-Source: ABdhPJzpTI6dCB21u4uS9o1KqwJPLidKEDc0e2gKmrc/3MBTJp8FR06Yjg8YIMO54tSG4RR2dvZp8HV1UoMRTw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a65:6d89:: with SMTP id
 bc9mr4731136pgb.260.1644468119687; Wed, 09 Feb 2022 20:41:59 -0800 (PST)
Date:   Thu, 10 Feb 2022 12:41:46 +0800
In-Reply-To: <20220210044152.78352-1-chooglen@google.com>
Message-Id: <20220210044152.78352-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH 2/8] submodule: store new submodule commits oid_array in a struct
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit prepares for a future commit that will teach `git fetch
--recurse-submodules` how to fetch submodules that are present in
<gitdir>/modules, but are not populated. To do this, we need to store
more information about the changed submodule so that we can read the
submodule configuration from the superproject commit instead of the
filesystem.

Refactor the changed submodules string_list.util to hold a struct
instead of an oid_array. This struct only holds the new_commits
oid_array for now; more information will be added later.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 60 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/submodule.c b/submodule.c
index 49f9dc5d23..e2405c9f15 100644
--- a/submodule.c
+++ b/submodule.c
@@ -806,6 +806,21 @@ static const char *default_name_or_path(const char *path_or_name)
 	return path_or_name;
 }
 
+/*
+ * Holds relevant information for a changed submodule. Used as the .util
+ * member of the changed submodule string_list_item.
+ */
+struct changed_submodule_data {
+	/* The submodule commits that have changed in the rev walk. */
+	struct oid_array *new_commits;
+};
+
+static void changed_submodule_data_clear(struct changed_submodule_data *cs_data)
+{
+	oid_array_clear(cs_data->new_commits);
+	free(cs_data->new_commits);
+}
+
 static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 					  struct diff_options *options,
 					  void *data)
@@ -820,6 +835,7 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 		const struct submodule *submodule;
 		const char *name;
 		struct string_list_item *item;
+		struct changed_submodule_data *cs_data;
 
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
@@ -847,10 +863,15 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
 			continue;
 
 		item = string_list_insert(changed, name);
-		if (!item->util)
+		if (item->util)
+			cs_data = item->util;
+		else {
+			cs_data = xcalloc(1, sizeof(struct changed_submodule_data));
 			/* NEEDSWORK: should we have oid_array_init()? */
-			item->util = xcalloc(1, sizeof(struct oid_array));
-		oid_array_append(item->util, &p->two->oid);
+			cs_data->new_commits = xcalloc(1, sizeof(struct oid_array));
+			item->util = cs_data;
+		}
+		oid_array_append(cs_data->new_commits, &p->two->oid);
 	}
 }
 
@@ -897,11 +918,12 @@ static void collect_changed_submodules(struct repository *r,
 	reset_revision_walk();
 }
 
-static void free_submodules_oids(struct string_list *submodules)
+static void free_submodules_data(struct string_list *submodules)
 {
 	struct string_list_item *item;
-	for_each_string_list_item(item, submodules)
-		oid_array_clear((struct oid_array *) item->util);
+	for_each_string_list_item(item, submodules) {
+		changed_submodule_data_clear(item->util);
+	}
 	string_list_clear(submodules, 1);
 }
 
@@ -1067,7 +1089,7 @@ int find_unpushed_submodules(struct repository *r,
 	collect_changed_submodules(r, &submodules, &argv);
 
 	for_each_string_list_item(name, &submodules) {
-		struct oid_array *commits = name->util;
+		struct changed_submodule_data *cs_data = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
 
@@ -1080,11 +1102,11 @@ int find_unpushed_submodules(struct repository *r,
 		if (!path)
 			continue;
 
-		if (submodule_needs_pushing(r, path, commits))
+		if (submodule_needs_pushing(r, path, cs_data->new_commits))
 			string_list_insert(needs_pushing, path);
 	}
 
-	free_submodules_oids(&submodules);
+	free_submodules_data(&submodules);
 	strvec_clear(&argv);
 
 	return needs_pushing->nr;
@@ -1254,7 +1276,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 	collect_changed_submodules(r, changed_submodule_names, &argv);
 
 	for_each_string_list_item(name, changed_submodule_names) {
-		struct oid_array *commits = name->util;
+		struct changed_submodule_data *cs_data = name->util;
 		const struct submodule *submodule;
 		const char *path = NULL;
 
@@ -1267,8 +1289,8 @@ static void calculate_changed_submodule_paths(struct repository *r,
 		if (!path)
 			continue;
 
-		if (submodule_has_commits(r, path, commits)) {
-			oid_array_clear(commits);
+		if (submodule_has_commits(r, path, cs_data->new_commits)) {
+			oid_array_clear(cs_data->new_commits);
 			*name->string = '\0';
 		}
 	}
@@ -1305,7 +1327,7 @@ int submodule_touches_in_range(struct repository *r,
 
 	strvec_clear(&args);
 
-	free_submodules_oids(&subs);
+	free_submodules_data(&subs);
 	return ret;
 }
 
@@ -1587,7 +1609,7 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 	struct fetch_task *task = task_cb;
 
 	struct string_list_item *it;
-	struct oid_array *commits;
+	struct changed_submodule_data *cs_data;
 
 	if (!task || !task->sub)
 		BUG("callback cookie bogus");
@@ -1615,14 +1637,14 @@ static int fetch_finish(int retvalue, struct strbuf *err,
 		/* Could be an unchanged submodule, not contained in the list */
 		goto out;
 
-	commits = it->util;
-	oid_array_filter(commits,
+	cs_data = it->util;
+	oid_array_filter(cs_data->new_commits,
 			 commit_missing_in_sub,
 			 task->repo);
 
 	/* Are there commits we want, but do not exist? */
-	if (commits->nr) {
-		task->commits = commits;
+	if (cs_data->new_commits->nr) {
+		task->commits = cs_data->new_commits;
 		ALLOC_GROW(spf->oid_fetch_tasks,
 			   spf->oid_fetch_tasks_nr + 1,
 			   spf->oid_fetch_tasks_alloc);
@@ -1680,7 +1702,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	strvec_clear(&spf.args);
 out:
-	free_submodules_oids(&spf.changed_submodule_names);
+	free_submodules_data(&spf.changed_submodule_names);
 	return spf.result;
 }
 
-- 
2.33.GIT

