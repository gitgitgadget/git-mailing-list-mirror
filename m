Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639E1203C1
	for <e@80x24.org>; Tue, 15 Nov 2016 01:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941252AbcKOBT0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 20:19:26 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34663 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941140AbcKOBTG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 20:19:06 -0500
Received: by mail-pg0-f46.google.com with SMTP id x23so57338285pgx.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 17:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ktSj/w6JIPHSmT0Iz3dNcnKwsTaXGNnRdIDlImip9l0=;
        b=j5jTRE3UiFWpzXieUhSxDd+CvYC52EswsLAUZ9mvb7iPE0L0/BkmXw+LniWxCu0EBM
         0aGOrYElu614ujRJU6QLdaH5omuiVIVGkMbNi95FNxtwqKfZwu6vzeca3SACyE/SRJeN
         JkC9S4cZj7IfwBGzkRsKod1Q+m/TDniv0sUThKzxFZPsXbS+NxBPSw1D1JK3QaGDwGQv
         q9R+yJTHc5/wUiXLlossXDF+I/V1Xev6kWlsXi9BvXgWXtVU/odkwkq30YFjjuJ/rtlN
         v/Pz+fxROIYKY4ZkzT5cYGjK+wqWrJyUXdf7oPexsqb8iwi6rBGTKtuCI4MezkMbmLfU
         4Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ktSj/w6JIPHSmT0Iz3dNcnKwsTaXGNnRdIDlImip9l0=;
        b=M01Zqa5i0eq6IqWqMBQHSwPZo15tp/f3pF6j7IB1wY4hCv59hHt56ioZyaVm5h9afQ
         HpQuhhPqpxsSYtArI+qJcNuzikEA8VSgnjdCdDgdyKBqZQZk6x71F/pLsh3ZXrDm3hMo
         PksyZhbebWPl7MGKF9FGdl0ZO+ijnAJx5h6fp8kcx0H+QYcA8QsIIFeGi5Jue6rmUdpR
         J+tGNl0aqzolhpeuN8AByGJW/slq5aKyhveMuvmZ/m6nJMJercMVfXjclWTLzJmo9OAd
         t5VrgpSzmOetLmOOjO1uaiFpyB1swf3daaXEH8bGZRyEUQ1uP/1Mf1VQ/RSCcLVEIrCG
         skYw==
X-Gm-Message-State: ABUngvfljYBH79Bphq6F9tzmGwXwAHOkVK1LkgTHrAZQVJ1B4ydy5TmjPPr6P62kUWQ/l3fc
X-Received: by 10.98.73.203 with SMTP id r72mr42136867pfi.75.1479172745463;
        Mon, 14 Nov 2016 17:19:05 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id t89sm35655377pfe.50.2016.11.14.17.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Nov 2016 17:19:04 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 2/2] push: fix --dry-run to not push submodules
Date:   Mon, 14 Nov 2016 17:18:55 -0800
Message-Id: <1479172735-698-3-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1479172735-698-1-git-send-email-bmwill@google.com>
References: <1479172735-698-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach push to respect the --dry-run option when configured to
recursively push submodules 'on-demand'.  This is done by passing the
--dry-run flag to the child process which performs a push for a
submodules when performing a dry-run.

In order to preserve good user experience, the additional check for
unpushed submodules is skipped during a dry-run when
--recurse-submodules=on-demand.  The check is skipped because the submodule
pushes were performed as dry-runs and this check would always fail as the
submodules would still need to be pushed.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 submodule.c                    | 13 ++++++++-----
 submodule.h                    |  4 +++-
 t/t5531-deep-submodule-push.sh |  2 +-
 transport.c                    |  9 ++++++---
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index a05c2a3..7b9bed1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -676,16 +676,17 @@ int find_unpushed_submodules(struct sha1_array *hashes,
 	return needs_pushing->nr;
 }
 
-static int push_submodule(const char *path)
+static int push_submodule(const char *path, int dry_run)
 {
 	if (add_submodule_odb(path))
 		return 1;
 
 	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
 		struct child_process cp = CHILD_PROCESS_INIT;
-		const char *argv[] = {"push", NULL};
+		argv_array_push(&cp.args, "push");
+		if (dry_run)
+			argv_array_push(&cp.args, "--dry-run");
 
-		cp.argv = argv;
 		prepare_submodule_repo_env(&cp.env_array);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
@@ -698,7 +699,9 @@ static int push_submodule(const char *path)
 	return 1;
 }
 
-int push_unpushed_submodules(struct sha1_array *hashes, const char *remotes_name)
+int push_unpushed_submodules(struct sha1_array *hashes,
+			     const char *remotes_name,
+			     int dry_run)
 {
 	int i, ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
@@ -709,7 +712,7 @@ int push_unpushed_submodules(struct sha1_array *hashes, const char *remotes_name
 	for (i = 0; i < needs_pushing.nr; i++) {
 		const char *path = needs_pushing.items[i].string;
 		fprintf(stderr, "Pushing submodule '%s'\n", path);
-		if (!push_submodule(path)) {
+		if (!push_submodule(path, dry_run)) {
 			fprintf(stderr, "Unable to push submodule '%s'\n", path);
 			ret = 0;
 		}
diff --git a/submodule.h b/submodule.h
index 065b2f0..a38e0f3 100644
--- a/submodule.h
+++ b/submodule.h
@@ -65,7 +65,9 @@ int merge_submodule(unsigned char result[20], const char *path, const unsigned c
 		    const unsigned char a[20], const unsigned char b[20], int search);
 int find_unpushed_submodules(struct sha1_array *hashes, const char *remotes_name,
 		struct string_list *needs_pushing);
-int push_unpushed_submodules(struct sha1_array *hashes, const char *remotes_name);
+extern int push_unpushed_submodules(struct sha1_array *hashes,
+				    const char *remotes_name,
+				    int dry_run);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
 int parallel_submodules(void);
 
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index e6ccc30..54f334c 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -431,7 +431,7 @@ test_expect_success 'push unpushable submodule recursively fails' '
 	git -C work reset --hard master^
 '
 
-test_expect_failure 'push --dry-run does not recursively update submodules' '
+test_expect_success 'push --dry-run does not recursively update submodules' '
 	(
 		cd work &&
 		(
diff --git a/transport.c b/transport.c
index f6bec0d..4ad08d0 100644
--- a/transport.c
+++ b/transport.c
@@ -921,15 +921,18 @@ int transport_push(struct transport *transport,
 				if (!is_null_oid(&ref->new_oid))
 					sha1_array_append(&hashes, ref->new_oid.hash);
 
-			if (!push_unpushed_submodules(&hashes, transport->remote->name)) {
+			if (!push_unpushed_submodules(&hashes,
+						      transport->remote->name,
+						      pretend)) {
 				sha1_array_clear(&hashes);
 				die ("Failed to push all needed submodules!");
 			}
 			sha1_array_clear(&hashes);
 		}
 
-		if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
-			      TRANSPORT_RECURSE_SUBMODULES_CHECK)) && !is_bare_repository()) {
+		if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
+		     ((flags & TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND) &&
+		      !pretend)) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
 			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 			struct sha1_array hashes = SHA1_ARRAY_INIT;
-- 
2.8.0.rc3.226.g39d4020

