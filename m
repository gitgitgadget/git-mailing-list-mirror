Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E16FC47423
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031B7207F7
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 16:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=adoakley.name header.i=@adoakley.name header.b="nNGm9Con"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgI2QNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbgI2QNc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 12:13:32 -0400
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE97C0613D2
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 09:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BXIUv+zsxtx4ABKQyaukq1T2gF94dYYyrxn8roAG+XY=; b=nNGm9ConHfMfedlVXhIkMbY6ir
        c2uLBKik2AQKhTlf/oV5WTpsKiCqZ7kEkQC0bcj1xkzWzt0Aky1fWxkJx7nNL2CfbT5GVqQ2g8ZVx
        GbAqbhylO9R+ekRo5SqEw7DLrHkuz7wMDUOQZwrbbwY9M0+R2HjcouYfKcZ1o7VqpcSg=;
Received: from [2001:8b0:14bb:e93b::df1] (helo=ado-tr.ado-tr.lan)
        by adoakley.name with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.2)
        (envelope-from <andrew@adoakley.name>)
        id 1kNHx9-0004AY-DV; Tue, 29 Sep 2020 15:54:07 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Andrew Oakley <andrew@adoakley.name>
Subject: [PATCH 7/7] submodule: use partial clone filter
Date:   Tue, 29 Sep 2020 16:53:50 +0100
Message-Id: <20200929155350.49066-8-andrew@adoakley.name>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929155350.49066-1-andrew@adoakley.name>
References: <20200929155350.49066-1-andrew@adoakley.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the --filter option down when fetching submodules.

Signed-off-by: Andrew Oakley <andrew@adoakley.name>
---
 builtin/clone.c             |  5 +++++
 builtin/submodule--helper.c | 21 ++++++++++++++++-----
 git-submodule.sh            | 20 +++++++++++++++++++-
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index fbfd6568cd..354dadc544 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -844,6 +844,11 @@ static int checkout(int submodule_progress)
 					       "--single-branch" :
 					       "--no-single-branch");
 
+		if (filter_options.choice)
+			strvec_pushf(&args, "--filter=%s",
+				     expand_list_objects_filter_spec(
+					&filter_options));
+
 		err = run_command_v_opt(args.v, RUN_GIT_CMD);
 		strvec_clear(&args);
 	}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index de5ad73bb8..1ca03ec08b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1658,7 +1658,8 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 }
 
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
-			   const char *depth, struct string_list *reference, int dissociate,
+			   const char *depth, const char *filter,
+			   struct string_list *reference, int dissociate,
 			   int quiet, int progress, int single_branch)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1671,6 +1672,8 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 		strvec_push(&cp.args, "--progress");
 	if (depth && *depth)
 		strvec_pushl(&cp.args, "--depth", depth, NULL);
+	if (filter && *filter)
+		strvec_pushl(&cp.args, "--filter", filter, NULL);
 	if (reference->nr) {
 		struct string_list_item *item;
 		for_each_string_list_item(item, reference)
@@ -1803,7 +1806,7 @@ static void prepare_possible_alternates(const char *sm_name,
 
 static int module_clone(int argc, const char **argv, const char *prefix)
 {
-	const char *name = NULL, *url = NULL, *depth = NULL;
+	const char *name = NULL, *url = NULL, *depth = NULL, *filter = NULL;
 	int quiet = 0;
 	int progress = 0;
 	char *p, *path = NULL, *sm_gitdir;
@@ -1834,6 +1837,9 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &depth,
 			   N_("string"),
 			   N_("depth for shallow clones")),
+		OPT_STRING(0, "filter", &filter,
+			   N_("string"),
+			   N_("object filtering")),
 		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
 		OPT_BOOL(0, "progress", &progress,
 			   N_("force cloning progress")),
@@ -1847,7 +1853,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
-		   "[--single-branch] "
+		   "[--filter <filter>] [--single-branch] "
 		   "--url <url> --path <path>"),
 		NULL
 	};
@@ -1879,8 +1885,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 		prepare_possible_alternates(name, &reference);
 
-		if (clone_submodule(path, sm_gitdir, url, depth, &reference, dissociate,
-				    quiet, progress, single_branch))
+		if (clone_submodule(path, sm_gitdir, url, depth, filter, &reference,
+				    dissociate, quiet, progress, single_branch))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
 	} else {
@@ -2002,6 +2008,7 @@ struct submodule_update_clone {
 	int dissociate;
 	unsigned require_init;
 	const char *depth;
+	const char *filter;
 	const char *recursive_prefix;
 	const char *prefix;
 	int single_branch;
@@ -2165,6 +2172,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		strvec_push(&child->args, "--dissociate");
 	if (suc->depth)
 		strvec_push(&child->args, suc->depth);
+	if (suc->filter)
+		strvec_push(&child->args, suc->filter);
 	if (suc->single_branch >= 0)
 		strvec_push(&child->args, suc->single_branch ?
 					      "--single-branch" :
@@ -2339,6 +2348,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
 			   N_("Create a shallow clone truncated to the "
 			      "specified number of revisions")),
+		OPT_STRING(0, "filter", &suc.filter, "<filter>",
+			   N_("object filtering")),
 		OPT_INTEGER('j', "jobs", &suc.max_jobs,
 			    N_("parallel jobs")),
 		OPT_BOOL(0, "recommend-shallow", &suc.recommend_shallow,
diff --git a/git-submodule.sh b/git-submodule.sh
index 6fb12585cb..029f7e7f44 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -45,6 +45,7 @@ update=
 prefix=
 custom_name=
 depth=
+filter=
 progress=
 dissociate=
 single_branch=
@@ -132,6 +133,14 @@ cmd_add()
 		--depth=*)
 			depth=$1
 			;;
+		--filter)
+			case "$2" in '') usage ;; esac
+			filter="--filter=$2"
+			shift
+			;;
+		--filter=*)
+			filter=$1
+			;;
 		--)
 			shift
 			break
@@ -268,7 +277,7 @@ or you are unsure what this means choose another name with the '--name' option."
 				eval_gettextln "Reactivating local git directory for submodule '\$sm_name'."
 			fi
 		fi
-		git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"--progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
+		git submodule--helper clone ${GIT_QUIET:+--quiet} ${progress:+"--progress"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} ${filter:+"$filter"} || exit
 		(
 			sanitize_submodule_env
 			cd "$sm_path" &&
@@ -498,6 +507,14 @@ cmd_update()
 		--depth=*)
 			depth=$1
 			;;
+		--filter)
+			case "$2" in '') usage ;; esac
+			filter="--depth=$2"
+			shift
+			;;
+		--filter=*)
+			filter=$1
+			;;
 		-j|--jobs)
 			case "$2" in '') usage ;; esac
 			jobs="--jobs=$2"
@@ -540,6 +557,7 @@ cmd_update()
 		${reference:+"$reference"} \
 		${dissociate:+"--dissociate"} \
 		${depth:+--depth "$depth"} \
+		${filter:+--filter "$filter"} \
 		${require_init:+--require-init} \
 		$single_branch \
 		$recommend_shallow \
-- 
2.26.2

