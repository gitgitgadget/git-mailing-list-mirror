Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DF6C1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 17:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965427AbeF0Rcm (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 13:32:42 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:38128 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965055AbeF0Rcl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 13:32:41 -0400
Received: by mail-vk0-f73.google.com with SMTP id o142-v6so1067409vke.5
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 10:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=yxSINc/tiBfXOxeh9ml1RedjrgSfoTEns/XXwqyOlf4=;
        b=f0KfwxZ6ahfLVZPmnwNzkIPg9VgOC8RlbXANM4kGOIsTkjvz49qbdUD2DcHvpIGEuJ
         cvAUVoiBaLU2qMCBgT2CyDPI0e50YYwK+zw9Lz72dY35kiBoNJOXzVQ2AgpU7aazXVti
         7X42dndGo3GE4JzWkTZ1s4X2CakuhSMHRpE1lbE3x695fSg81E8eYG7IU/DOZs+tFFNR
         Kxiu/fya6gejQxczAnEVXqMB9wbAoGg6unRr2kufXIEXFZXj+fQuASeyouOa+vOs18oM
         nMv62mlAAqJ/vlJsZ+2vS6z3etzwHwOqfbvx9K8YL4baEuS++9xVylY8csLSpbCdGlIL
         gZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=yxSINc/tiBfXOxeh9ml1RedjrgSfoTEns/XXwqyOlf4=;
        b=QJtgoF2bYS89SvlUHKteOQ+hf/48hx8ZqPqwD9PTdVTgJgiciIjWKEN4kQc076j17/
         sJl9BlDoevhmHg0eiX6CTIXFnkgnOs2qlO7EkATQRbj8xQcfisJKyGvp3Cf1gCn2THut
         +/aPfLJVUNbqg5otjlTNQ5K9W7iIUcCEdVSqjyhJDygk8RdPiv3hYJNDVozGjdjhTLBp
         yKjsoCl+HdDYNUfKzNidC53udOl5c0GsHmF9Vku7Vd1NkHBIOs5wiiPsAxILoJIEYZan
         7FjlBWYZ1QjIRK3ryfVZHeabo8wScwUoAcY3W7Da3elCTs0q9UU1spRVTOS8ZtGYDYJw
         iAPg==
X-Gm-Message-State: APt69E0RodCEBUN3YyNQKFiEQwiWPR3tb4KXWJwinbzDmA9DdoOQauZA
        mIAvIyBhNiV/krQ5/Z7lgmgPzKFbrkY0f3dsYRoUyWU9nb2fi/NaKswuWXOFsCJbtCMY/GiHa1D
        np3BnoW6jGJ+D9ws3PBoWNYuOQgIbWto6wy1mfyW8iftq1orp2x94Jm+OyqnRDovQcXi+qaLSYw
        KJ
X-Google-Smtp-Source: AAOMgpcqxgvVvSCw5Cj+xDd0rPV7vyAs1oYM+fcLLr6Whje4W7EbDbMrmbbUuqifPSUe38c4fmRAh9ui4b0Cc0JFEJaK
MIME-Version: 1.0
X-Received: by 2002:ab0:853:: with SMTP id b19-v6mr2743804uaf.2.1530120760101;
 Wed, 27 Jun 2018 10:32:40 -0700 (PDT)
Date:   Wed, 27 Jun 2018 10:32:37 -0700
Message-Id: <20180627173237.25620-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH] fetch: when deepening, check connectivity fully
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do not stop at ancestors of our refs when deepening during fetching.
This is because when performing such a fetch, shallow entries may have
been updated; the client can reasonably assume that the existing refs
are connected up to the old shallow points, but not the new.

This was noticed when a user tried to deepen an existing repository by
fetching with --no-shallow from a server that did not send all necessary
objects - the connectivity check as run by "git fetch" succeeded, but a
subsequent "git fsck" failed.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c          |  5 ++++-
 connected.c              |  6 ++++--
 connected.h              |  7 +++++++
 t/t5537-fetch-shallow.sh | 23 +++++++++++++++++++++++
 4 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ea5b9669ad..2cfd13342f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -780,6 +780,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head();
 	int want_status;
 	int summary_width = transport_summary_width(ref_map);
+	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 
 	fp = fopen(filename, "a");
 	if (!fp)
@@ -791,7 +792,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		url = xstrdup("foreign");
 
 	rm = ref_map;
-	if (check_connected(iterate_ref_map, &rm, NULL)) {
+	if (deepen)
+		opt.is_deepening_fetch = 1;
+	if (check_connected(iterate_ref_map, &rm, &opt)) {
 		rc = error(_("%s did not send all necessary objects\n"), url);
 		goto abort;
 	}
diff --git a/connected.c b/connected.c
index 91feb78815..1bba888eff 100644
--- a/connected.c
+++ b/connected.c
@@ -58,8 +58,10 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	argv_array_push(&rev_list.args, "--stdin");
 	if (repository_format_partial_clone)
 		argv_array_push(&rev_list.args, "--exclude-promisor-objects");
-	argv_array_push(&rev_list.args, "--not");
-	argv_array_push(&rev_list.args, "--all");
+	if (!opt->is_deepening_fetch) {
+		argv_array_push(&rev_list.args, "--not");
+		argv_array_push(&rev_list.args, "--all");
+	}
 	argv_array_push(&rev_list.args, "--quiet");
 	if (opt->progress)
 		argv_array_pushf(&rev_list.args, "--progress=%s",
diff --git a/connected.h b/connected.h
index a53f03a61a..322dc76372 100644
--- a/connected.h
+++ b/connected.h
@@ -38,6 +38,13 @@ struct check_connected_options {
 	 * Insert these variables into the environment of the child process.
 	 */
 	const char **env;
+
+	/*
+	 * If non-zero, check the ancestry chain completely, not stopping at
+	 * any existing ref. This is necessary when deepening existing refs
+	 * during a fetch.
+	 */
+	unsigned is_deepening_fetch : 1;
 };
 
 #define CHECK_CONNECTED_INIT { 0 }
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index df8d2f095a..ac4beac96b 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -186,4 +186,27 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'shallow fetches check connectivity without stopping at existing refs' '
+	cp -R .git server.git &&
+
+	# Normally, the connectivity check stops at ancestors of existing refs.
+	git init client &&
+	GIT_TRACE="$(pwd)/trace" git -C client fetch "$(pwd)/server.git" &&
+	grep "run_command: git rev-list" trace >rev-list-command &&
+	grep -e "--not --all" rev-list-command &&
+
+	# But it does not for a shallow fetch...
+	rm -rf client trace &&
+	git init client &&
+	GIT_TRACE="$(pwd)/trace" git -C client fetch --depth=1 "$(pwd)/server.git" &&
+	grep "run_command: git rev-list" trace >rev-list-command &&
+	! grep -e "--not --all" rev-list-command &&
+
+	# ...and when deepening.
+	rm trace &&
+	GIT_TRACE="$(pwd)/trace" git -C client fetch --unshallow "$(pwd)/server.git" &&
+	grep "run_command: git rev-list" trace >rev-list-command &&
+	! grep -e "--not --all" rev-list-command
+'
+
 test_done
-- 
2.18.0.rc2.346.g013aa6912e-goog

