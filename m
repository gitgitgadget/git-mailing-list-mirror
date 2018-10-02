Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585FE1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 00:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeJBG5k (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 02:57:40 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:55566 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeJBG5j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 02:57:39 -0400
Received: by mail-qk1-f202.google.com with SMTP id d200-v6so195808qkc.22
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 17:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DC40ShPJyNLtRaSIf/YsVwmdxvV2dMGrhgwEOWCb4fY=;
        b=ToGbZQubA8PCODSJizb+rmr20OiyrN2C8R8PusptyhpELsHpIPfrqyU4ukrpIyt0ZO
         oolofyfBEZe4VutW+0NYag5MCS3qzcfo/5GGqiNRYESGduaYYMgfNafnCYr+upQdOPSj
         95rJ3SQ26CY4ecxcK6gQYyPYx56xKTljfy6JbFbrqd+FHW6qXZkzq1+ZZsU6mc3JMbXx
         tD41ltBvezTLH9WtXK+GJBgrs8a+n84VkD4NGpFQqhgCtUyuAzuOoob3gyd8FxhpzJNu
         59BJgZlWYEqk+qgMzsgNrGEGW/hNvEWlL9o7OThLfgUQtrM6gp6ckeO4LZweVUKpzftH
         rwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DC40ShPJyNLtRaSIf/YsVwmdxvV2dMGrhgwEOWCb4fY=;
        b=CzpXstv8VHhnT+a0qYa/gOU9hqPF/XIYbtWyBHZGPDcp0ZaSNDOvOkv1D6eoeSALve
         7+MXcDfq3luh5d0HOx+m2TsNzkayx3a4AJ4eswrPyoG+JxNUmLjuq7Y3DuO6Uhetq9e7
         PgCTqf5XLtuXPS6pzIbLBBKaBxE4gzDeGRqeON/y1oQhcwq+j2ntW2E1Rnd9eTHwSRy3
         Go9twBeT8Q9gbGlbIyHLeqRaByXul7Ssy57vr0jOWRX+apKZhPirhmGytV80FaKDqUFB
         VBy8yz2hzmi/RK0iS12UfSZrzb9dzVSDKZoibGUb4zHNdUWUYr7KqQkQber7ALzGwcG0
         T15w==
X-Gm-Message-State: ABuFfoiY8SXGNuC/58dx6+z+WR1QUpW64JsOXBbASiOqMPTPLblX1Pcw
        lczD07uqu1K17CmxsWpUAWouHfsQA6Sl
X-Google-Smtp-Source: ACcGV63RhdNFDt1Y/+34/YSHimqcQuxu1oAyqrGRXSwI+gM6YQ/zab+CSOPvJHlYjC/fhg52c10RvfXhYuq3
X-Received: by 2002:a0c:9468:: with SMTP id i37-v6mr5234682qvi.21.1538439436904;
 Mon, 01 Oct 2018 17:17:16 -0700 (PDT)
Date:   Mon,  1 Oct 2018 17:17:13 -0700
In-Reply-To: <20180906225423.GB81412@aiede.svl.corp.google.com>
Message-Id: <20181002001713.137087-1-sbeller@google.com>
Mime-Version: 1.0
References: <20180906225423.GB81412@aiede.svl.corp.google.com>
X-Mailer: git-send-email 2.19.0
Subject: [PATCH] submodule update --remote: introduce pinning
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitmodules(5) sayeth:

   submodule.<name>.branch
       A remote branch name for tracking updates in the upstream
       submodule. If the option is not specified, it defaults to master.

This doesn't allow having a "pinned" submodule that should not be updated
from upstream. We should change this to have no default --- if branch is
not specified, don't update that submodule, just like in Gerrit's
corresponding feature[1].

[1] https://gerrit-review.googlesource.com/Documentation/user-submodules.html#_defining_the_submodule_branch


However changing defaults is difficult as it may surprise the user,
Jonathan came up with a 4 step plan:
Step 0: introduce

	# current behavior:
        git submodule update --remote --remote-default-to-master

	# new behavior:
        git submodule update --remote --remote-pinned

and treat plain "git submodule update --remote" as --default-to-master.

Step 1: when neither --default-to-master nor --no-default-to-master
has been passed, warn when encountering a submodule with no branch
and treat it as "master".

Step 2: when neither --default-to-master nor --no-default-to-master
has been passed, error out when encountering a submodule with no
branch.

Step 3: when neither --default-to-master nor --no-default-to-master
has been passed, warn when encountering a submodule with no branch
and treat it as pinned.

Step 4: eliminate the warning.

This implements step 0 and 1.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Sorry that this took so long, this is a rough patch for steps 0 & 1,
I'd still need to update docs.

Stefan


 Documentation/gitmodules.txt | 11 ++++++-----
 builtin/submodule--helper.c  | 36 +++++++++++++++++++++++++++++-------
 git-submodule.sh             | 34 +++++++++++++++++++++++++---------
 t/t7406-submodule-update.sh  | 29 +++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 21 deletions(-)

diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 4d63def206..fe42dbdb3e 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -50,11 +50,12 @@ submodule.<name>.update::
 
 submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream submodule.
-	If the option is not specified, it defaults to 'master'.  A special
-	value of `.` is used to indicate that the name of the branch in the
-	submodule should be the same name as the current branch in the
-	current repository.  See the `--remote` documentation in
-	linkgit:git-submodule[1] for details.
+	A special value of `.` is used to indicate that the name of the
+	branch in the submodule should be the same name as the current
+	branch in the current repository.  See the `--remote` documentation
+	in linkgit:git-submodule[1] for details.
+	If not set, the default for `git submodule update --remote` is
+	to update the submodule to the superproject's recorded object id.
 
 submodule.<name>.fetchRecurseSubmodules::
 	This option can be used to control recursive fetching of this
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 40844870cf..6413f2b410 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1889,7 +1889,7 @@ static int resolve_relative_path(int argc, const char **argv, const char *prefix
 	return 0;
 }
 
-static const char *remote_submodule_branch(const char *path)
+static const char *remote_submodule_branch(const char *path, int default_pinned)
 {
 	const struct submodule *sub;
 	const char *branch = NULL;
@@ -1904,8 +1904,12 @@ static const char *remote_submodule_branch(const char *path)
 		branch = sub->branch;
 	free(key);
 
-	if (!branch)
-		return "master";
+	if (!branch) {
+		if (default_pinned)
+			return "";
+		else
+			return "master";
+	}
 
 	if (!strcmp(branch, ".")) {
 		const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
@@ -1932,12 +1936,30 @@ static int resolve_remote_submodule_branch(int argc, const char **argv,
 {
 	const char *ret;
 	struct strbuf sb = STRBUF_INIT;
-	if (argc != 2)
-		die("submodule--helper remote-branch takes exactly one arguments, got %d", argc);
+	int default_pinned = 0;
+
+	struct option remote_options[] = {
+		OPT_SET_INT(0, "default-master", &default_pinned,
+				N_("unconfigured submodules default to master branch"), 0),
+		OPT_SET_INT(0, "default-pinned", &default_pinned,
+				N_("unconfigured submodules default to superproject object id"), 1),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper remote-branch [--default-{master, pinned}]  -- <path>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, remote_options,
+			     git_submodule_helper_usage, 0);
+
+	if (argc != 1)
+		die("submodule--helper remote-branch takes exactly one path, got %d", argc);
 
-	ret = remote_submodule_branch(argv[1]);
+	ret = remote_submodule_branch(argv[0], default_pinned);
 	if (!ret)
-		die("submodule %s doesn't exist", argv[1]);
+		die("submodule %s doesn't exist", argv[0]);
 
 	printf("%s", ret);
 	strbuf_release(&sb);
diff --git a/git-submodule.sh b/git-submodule.sh
index 1b568e29b9..829b90ea97 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -431,6 +431,7 @@ fetch_in_submodule () (
 #
 cmd_update()
 {
+	remote_default_option=
 	# parse $args after "submodule ... update".
 	while test $# -ne 0
 	do
@@ -450,6 +451,12 @@ cmd_update()
 		--remote)
 			remote=1
 			;;
+		--remote-default-to-master)
+			remote_default_option=--default-master
+			;;
+		--remote-pinned)
+			remote_default_option=--default-pinned
+			;;
 		-N|--no-fetch)
 			nofetch=1
 			;;
@@ -555,17 +562,26 @@ cmd_update()
 
 		if test -n "$remote"
 		then
-			branch=$(git submodule--helper remote-branch "$sm_path")
-			if test -z "$nofetch"
+			if test -z $remote_default_option
 			then
-				# Fetch remote before determining tracking $sha1
-				fetch_in_submodule "$sm_path" $depth ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
+				say "--remote needs clarification: --remote-pinned or --remote-default-to-master?"
+				say "assuming --remote-default-to-master for now"
+				remote_default_option=--default-master
+			fi
+			branch=$(git submodule--helper remote-branch ${remote_default_option} -- "$sm_path")
+			if test -n "$branch"
+			then
+				if test -z "$nofetch"
+				then
+					# Fetch remote before determining tracking $sha1
+					fetch_in_submodule "$sm_path" $depth ||
+					die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
+				fi
+				remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
+				sha1=$(sanitize_submodule_env; cd "$sm_path" &&
+					git rev-parse --verify "${remote_name}/${branch}") ||
+				die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 			fi
-			remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
-			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
-				git rev-parse --verify "${remote_name}/${branch}") ||
-			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 		fi
 
 		if test "$subsha1" != "$sha1" || test -n "$force"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 10dc91620a..3019978211 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -260,6 +260,35 @@ test_expect_success 'submodule update --remote should fetch upstream changes wit
 	)
 '
 
+test_expect_success 'submodule update --remote should not fetch upstream when no branch is set' '
+	(
+		cd super &&
+		test_might_fail git config --unset -f .gitmodules submodule.submodule.branch &&
+		git add .gitmodules &&
+		git commit --allow-empty -m "submodules: pin in superproject branch" &&
+		git -C ../submodule checkout -f master
+	) &&
+	(
+		cd submodule &&
+		echo line4b >>file &&
+		git add file &&
+		test_tick &&
+		git commit -m "upstream line4b"
+	) &&
+	(
+		cd super &&
+
+		git submodule update --remote-pinned --remote --force submodule &&
+		git status --porcelain --untracked=no --ignore-submodules=none >actual &&
+		test_must_be_empty actual &&
+
+		git submodule update --remote-default-to-master --remote --force submodule &&
+		git -C submodule log -1 --oneline >actual &&
+		git -C ../submodule log -1 --oneline >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'local config should override .gitmodules branch' '
 	(cd submodule &&
 	 git checkout test-branch &&
-- 
2.19.0

