Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DDAB207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 21:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755140AbdDRVhq (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 17:37:46 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33650 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdDRVhl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 17:37:41 -0400
Received: by mail-pg0-f44.google.com with SMTP id 63so2661096pgh.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 14:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8TDHQcQ1LpoA/Mg53UhCUNZHjW1R1qBUqtAHkQ8dV+E=;
        b=OeU3yUDeiIfEgSI0JIjwDjuBCPl7RnEGcGcSqUxKeRtK7YdA4OkfVLtNPUkGn2wSRc
         sFdQy3i34CFgdwkl68x0PIWWEqgKFsI8EKipPQ+nBGNOUlboUndfk0X6rS7+FYbY+qTU
         8DSqTxYOfA3ATjt368/YHxSZUfRl5SObSGx7XWmU9HAc7T2EGK1IYBujY4ubo10Vb/R4
         3OctlVYsuc+3P+7FkH9aRWqFfaW93el5EPfFCJRNFyDGP1Jm/BjP+KoqNo1V2ep7r2tu
         1w3jzXoRzl3o/Utg4wX6kyJ4J31t1WIcVU6dI2epJhmR5vC0+0AqBfTrcKAO5OT96a8q
         Wf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8TDHQcQ1LpoA/Mg53UhCUNZHjW1R1qBUqtAHkQ8dV+E=;
        b=JnweblKOydXjvAJmoG70kZLU9rW4VAc4Ejr6n/WCu18hwseI4u2JBxWPXY2LZesc3r
         kWq7Ip9cQqBTTcGheR1rUfsq6Ca5CIk5e+RGxTNwgFKDkpjrMO+hA1eJzjfbPskMqu+d
         YguLkm88ZrfolxWt8KFH5hFLt77ChiQZMMQARXCzC/ffVbvSrW6EADtoDxHqlpyThXW7
         tmHGXjEfLaHyZN6DJdxjftWGbmP2lG2OylFbMXc9KWQmAI9PhGb3saJg+SwONVrXwJRl
         akMVppe2giL9rFj24xylofl/S6RAbRp5rVt0tbPEC0K0OHA8VCWepZjZf1OuCbKgmqz2
         K2tg==
X-Gm-Message-State: AN3rC/5g4wkbNJYgREwNEtXDyh2UweSWCyF5/UbzmZwJkhtWVL0vtwH3
        0rSG0lkhv3xtQ+zM
X-Received: by 10.99.64.69 with SMTP id n66mr20317479pga.197.1492551461011;
        Tue, 18 Apr 2017 14:37:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c47b:4f4d:6233:ff9f])
        by smtp.gmail.com with ESMTPSA id o7sm326146pga.36.2017.04.18.14.37.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 14:37:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, philipoakley@iee.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/4] submodule.c: submodule_move_head works with broken submodules
Date:   Tue, 18 Apr 2017 14:37:24 -0700
Message-Id: <20170418213725.7901-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.642.g1b8cc69eee.dirty
In-Reply-To: <20170418213725.7901-1-sbeller@google.com>
References: <20170418213725.7901-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Early on in submodule_move_head just after the check if the submodule is
initialized, we need to check if the submodule is populated correctly.

If the submodule is initialized but doesn't look like it is populated,
this is a red flag and can indicate multiple sorts of failures:
(1) The submodule may be recorded at an object name, that is missing.
(2) The submodule '.git' file link may be broken and it is not pointing
    at a repository.

In both cases we want to complain to the user in the non-forced mode,
and in the forced mode ignoring the old state and just moving the
submodule into its new state with a fixed '.git' file link.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c               | 28 ++++++++++++++++++++++++----
 t/lib-submodule-update.sh | 23 ++++++++++++++++++++---
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/submodule.c b/submodule.c
index ccf8932731..20ed5b5681 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1332,10 +1332,24 @@ int submodule_move_head(const char *path,
 	int ret = 0;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	const struct submodule *sub;
+	int *error_code_ptr, error_code;
 
 	if (!is_submodule_initialized(path))
 		return 0;
 
+	if (flags & SUBMODULE_MOVE_HEAD_FORCE)
+		/*
+		 * Pass non NULL pointer to is_submodule_populated_gently
+		 * to prevent die()-ing. We'll use connect_work_tree_and_git_dir
+		 * to fixup the submodule in the force case later.
+		 */
+		error_code_ptr = &error_code;
+	else
+		error_code_ptr = NULL;
+
+	if (old && !is_submodule_populated_gently(path, error_code_ptr))
+		return 0;
+
 	sub = submodule_from_path(null_sha1, path);
 
 	if (!sub)
@@ -1353,15 +1367,21 @@ int submodule_move_head(const char *path,
 				absorb_git_dir_into_superproject("", path,
 					ABSORB_GITDIR_RECURSE_SUBMODULES);
 		} else {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_addf(&sb, "%s/modules/%s",
+			char *gitdir = xstrfmt("%s/modules/%s",
 				    get_git_common_dir(), sub->name);
-			connect_work_tree_and_git_dir(path, sb.buf);
-			strbuf_release(&sb);
+			connect_work_tree_and_git_dir(path, gitdir);
+			free(gitdir);
 
 			/* make sure the index is clean as well */
 			submodule_reset_index(path);
 		}
+
+		if (old && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
+			char *gitdir = xstrfmt("%s/modules/%s",
+				    get_git_common_dir(), sub->name);
+			connect_work_tree_and_git_dir(path, gitdir);
+			free(gitdir);
+		}
 	}
 
 	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 22dd9e060c..f0b1b18206 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -1213,14 +1213,31 @@ test_submodule_forced_switch_recursing () {
 		)
 	'
 	# Updating a submodule from an invalid sha1 updates
-	test_expect_success "$command: modified submodule does not update submodule work tree from invalid commit" '
+	test_expect_success "$command: modified submodule does update submodule work tree from invalid commit" '
 		prolog &&
 		reset_work_tree_to_interested invalid_sub1 &&
 		(
 			cd submodule_update &&
 			git branch -t valid_sub1 origin/valid_sub1 &&
-			test_must_fail $command valid_sub1 &&
-			test_superproject_content origin/invalid_sub1
+			$command valid_sub1 &&
+			test_superproject_content origin/valid_sub1 &&
+			test_submodule_content sub1 origin/valid_sub1
+		)
+	'
+
+	# Old versions of Git were buggy writing the .git link file
+	# (e.g. before f8eaa0ba98b and then moving the superproject repo
+	# whose submodules contained absolute paths)
+	test_expect_success "$command: updating submodules fixes .git links" '
+		prolog &&
+		reset_work_tree_to_interested add_sub1 &&
+		(
+			cd submodule_update &&
+			git branch -t modify_sub1 origin/modify_sub1 &&
+			echo "gitdir: bogus/path" >sub1/.git &&
+			$command modify_sub1 &&
+			test_superproject_content origin/modify_sub1 &&
+			test_submodule_content sub1 origin/modify_sub1
 		)
 	'
 }
-- 
2.12.2.642.g1b8cc69eee.dirty

