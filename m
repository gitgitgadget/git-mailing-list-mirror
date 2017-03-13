Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82FD20373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbdCMVn7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:43:59 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34047 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753633AbdCMVny (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:43:54 -0400
Received: by mail-pg0-f41.google.com with SMTP id 77so70561973pgc.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vCEwXfK8iQla/9/ZrbyrZ8Q0SBdOOBBgju2l1d/Om7g=;
        b=MPc/mQQrDCtlCbGQD5192uypYoHwRx2gK1taiO04Qu0aiW5gvbvk3id9BNWlJGuYWF
         6s85IXW4PoRk+mZ7G5zmdAKDq1I/NzD4tr73N1p0tJ55EWItnrpL4EokSt8nppc3dJkx
         l2pbsRfrKcxYq6FZlVwj/2D23mBNi7jZ/hhmFXr3bvHcL0sRMc++Brtfwx4YZNBb31BT
         f9D2/JeZqaeIEWOx7jm8wziKAh45d4V2xpXRiVtCFyNuPKqrXKw/ND11atBmH617YiBH
         FMCW2UDnQKignUOqpdZCosVwzGsesjZeCVB0822fi9b63DENf+eDt1lEKYeUOaIN1nnk
         DQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vCEwXfK8iQla/9/ZrbyrZ8Q0SBdOOBBgju2l1d/Om7g=;
        b=rwUU9yICLod1iz62iG3Yxr8m4TXHR+HSNiIo5qIamu8/8lrQg2cAocw7g59EM5p1PS
         tdbUZVknCwzBCB/oWHnUEffmcGC9wA2kp6iMyoOeHEI/sT0Bt9zre98gBETtIv7Cr66u
         KmghMm996+3UDIXGoo+Sap34kcarPmn+8TYvh7g6HG4k2dkgBopaXiTzHQZOEvn3tG0H
         uVKMEplO2+vpo8CKXsGQ5k+jXpOUdb+ty/vrje4/zFd98UPss/2bgFnk4LPICi09Itd2
         srtDH163au8PDy/LBshdhYuVlBcUda/Nuqr1DAj/W2cVqFtNsTlU9raCqUnYPob9QmfP
         Z5lA==
X-Gm-Message-State: AMke39nK2ierMNFv9ns5Jkwx90JS4Juv5WB0IslBhkNlwvmqAEhZRR+5ueOIo6sX64nSAGu/
X-Received: by 10.99.5.82 with SMTP id 79mr39502106pgf.8.1489441433242;
        Mon, 13 Mar 2017 14:43:53 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id 129sm34525937pgj.59.2017.03.13.14.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Mar 2017 14:43:52 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v3 05/10] submodule: decouple url and submodule existence
Date:   Mon, 13 Mar 2017 14:43:36 -0700
Message-Id: <20170313214341.172676-6-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170313214341.172676-1-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the submodule.<name>.url config option is used to determine
if a given submodule exists and is interesting to the user.  This
however doesn't work very well because the URL is a config option for
the scope of a repository, whereas the existence of a submodule is an
option scoped to the working tree.

In a future with worktree support for submodules, there will be multiple
working trees, each of which may only need a subset of the submodules
checked out.  The URL (which is where the submodule repository can be
obtained) should not differ between different working trees.

It may also be convenient for users to more easily specify groups of
submodules they are interested in as apposed to running "git submodule
init <path>" on each submodule they want checked out in their working
tree.

To this end two config options are introduced, submodule.active and
submodule.<name>.active.  The submodule.active config holds a pathspec
that specifies which submodules should exist in the working tree.  The
submodule.<name>.active config is a boolean flag used to indicate if
that particular submodule should exist in the working tree.

Given these multiple ways to check for a submodule's existence the more
fine-grained submodule.<name>.active option has the highest order of
precedence followed by the pathspec check against submodule.active. To
ensure backwards compatibility, if neither of these options are set git
falls back to checking the submodule.<name>.url option to determine a
submodule's existence.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/config.txt       | 15 ++++++++++--
 submodule.c                    | 36 ++++++++++++++++++++++++---
 t/t7413-submodule-is-active.sh | 55 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5e5c2ae5f..d2d79b9d4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2920,8 +2920,9 @@ submodule.<name>.url::
 	The URL for a submodule. This variable is copied from the .gitmodules
 	file to the git config via 'git submodule init'. The user can change
 	the configured URL before obtaining the submodule via 'git submodule
-	update'. After obtaining the submodule, the presence of this variable
-	is used as a sign whether the submodule is of interest to git commands.
+	update'. If neither submodule.<name>.active or submodule.active are
+	set, the presence of this variable is used as a fallback to indicate
+	whether the submodule is of interest to git commands.
 	See linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
 
 submodule.<name>.update::
@@ -2959,6 +2960,16 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
+submodule.<name>.active::
+	Boolean value indicating if the submodule is of interest to git
+	commands.  This config option takes precedence over the
+	submodule.active config option.
+
+submodule.active::
+	A repeated field which contains a pathspec used to match against a
+	submodule's path to determine if the submodule is of interest to git
+	commands.
+
 submodule.fetchJobs::
 	Specifies how many submodules are fetched/cloned at the same time.
 	A positive integer allows up to that number of submodules fetched
diff --git a/submodule.c b/submodule.c
index 0a2831d84..2b33bd70f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -217,13 +217,41 @@ void gitmodules_config_sha1(const unsigned char *commit_sha1)
 int is_submodule_initialized(const char *path)
 {
 	int ret = 0;
-	const struct submodule *module = NULL;
+	char *key;
+	const struct string_list *sl;
+	const struct submodule *module = submodule_from_path(null_sha1, path);
 
-	module = submodule_from_path(null_sha1, path);
+	/* early return if there isn't a path->module mapping */
+	if (!module)
+		return 0;
+
+	/* submodule.<name>.active is set */
+	key = xstrfmt("submodule.%s.active", module->name);
+	if (!git_config_get_bool(key, &ret)) {
+		free(key);
+		return ret;
+	}
+	free(key);
+
+	sl = git_config_get_value_multi("submodule.active");
 
-	if (module) {
-		char *key = xstrfmt("submodule.%s.url", module->name);
+	if (sl) {
+		struct pathspec ps;
+		struct argv_array args = ARGV_ARRAY_INIT;
+		const struct string_list_item *item;
+
+		for_each_string_list_item(item, sl) {
+			argv_array_push(&args, item->string);
+		}
+
+		parse_pathspec(&ps, 0, 0, 0, args.argv);
+		ret = match_pathspec(&ps, path, strlen(path), 0, NULL, 1);
+
+		argv_array_clear(&args);
+		clear_pathspec(&ps);
+	} else {
 		char *value = NULL;
+		key = xstrfmt("submodule.%s.url", module->name);
 
 		ret = !git_config_get_string(key, &value);
 
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index f18e0c925..c41b899ab 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -28,4 +28,59 @@ test_expect_success 'is-active works with urls' '
 	git -C super submodule--helper is-active sub1
 '
 
+test_expect_success 'is-active works with submodule.<name>.active config' '
+	git -C super config --bool submodule.sub1.active "false" &&
+	test_must_fail git -C super submodule--helper is-active sub1 &&
+
+	git -C super config --bool submodule.sub1.active "true" &&
+	git -C super config --unset submodule.sub1.URL &&
+	git -C super submodule--helper is-active sub1 &&
+
+	git -C super config submodule.sub1.URL ../sub &&
+	git -C super config --unset submodule.sub1.active
+'
+
+test_expect_success 'is-active works with basic submodule.active config' '
+	git -C super config --add submodule.active "." &&
+	git -C super config --unset submodule.sub1.URL &&
+
+	git -C super submodule--helper is-active sub1 &&
+	git -C super submodule--helper is-active sub2 &&
+
+	git -C super config submodule.sub1.URL ../sub &&
+	git -C super config --unset-all submodule.active
+'
+
+test_expect_success 'is-active correctly works with paths that are not submodules' '
+	test_must_fail git -C super submodule--helper is-active not-a-submodule &&
+
+	git -C super config --add submodule.active "." &&
+	test_must_fail git -C super submodule--helper is-active not-a-submodule &&
+
+	git -C super config --unset-all submodule.active
+'
+
+test_expect_success 'is-active works with exclusions in submodule.active config' '
+	git -C super config --add submodule.active "." &&
+	git -C super config --add submodule.active ":(exclude)sub1" &&
+
+	test_must_fail git -C super submodule--helper is-active sub1 &&
+	git -C super submodule--helper is-active sub2 &&
+
+	git -C super config --unset-all submodule.active
+'
+
+test_expect_success 'is-active with submodule.active and submodule.<name>.active' '
+	git -C super config --add submodule.active "sub1" &&
+	git -C super config --bool submodule.sub1.active "false" &&
+	git -C super config --bool submodule.sub2.active "true" &&
+
+	test_must_fail git -C super submodule--helper is-active sub1 &&
+	git -C super submodule--helper is-active sub2 &&
+
+	git -C super config --unset-all submodule.active &&
+	git -C super config --unset submodule.sub1.active &&
+	git -C super config --unset submodule.sub2.active
+'
+
 test_done
-- 
2.12.0.246.ga2ecc84866-goog

