From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 04/14] pull: pass git-fetch's options to git-fetch
Date: Mon, 18 May 2015 23:06:01 +0800
Message-ID: <1431961571-20370-5-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:07:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMdy-0004Ni-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbbERPHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:07:42 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33274 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbbERPHj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:07:39 -0400
Received: by padbw4 with SMTP id bw4so155735778pad.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=187bB8RGY2M01nSfbc5HFQ8eJUVIAM6IDj2B9MpO4lo=;
        b=kj4Q0Ys5QEFrqcRJr8kI31K+IwuxiKL9K8J47Kc9NfYMjAMFsHJqyrTPzYMpYWAhZ0
         4zWTrPHO2Wb+qFqClvclvlw31NhP5D7uwiQpaoPp5FZzxz6UaL8xHif5Yn4b3ESnIiHA
         conmiEmXMfifwDJqiGN8O88kAaFMdjB/UzHIvk3bIA/SecmX/ZjaQhpiwOQZxJIzpZNi
         wRcpcQ+kU7u2KdAMg9vJOcPxlvxo0D9qB+8KzDrsz2vQQbgSedSSJ6CcElE/f9Wn5e8Y
         oxKL3eNZfpE5hFRk3da/TRskrDI3uijrx/F9ORFBd8S7k18SB3iRUjPxcr9Pz/ZvjJzh
         UBrw==
X-Received: by 10.70.49.198 with SMTP id w6mr44233322pdn.121.1431961659427;
        Mon, 18 May 2015 08:07:39 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.07.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:07:37 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269263>

git-pull.sh passed all unknown options to git-fetch, thus supporting
git-fetch's options.

However, this led to problems as git-pull was not aware of the specifics
of the options passed to git-fetch. For example, running

	git-pull --all --dry-run

would pass the --dry-fetch option to git-fetch, but would still run
git-merge. This is because git-pull.sh is not aware of the --dry-run
option.

Fix this by parsing all of git-fetch's options at git-pull. The options
are:

* --all

* -a, --append

* --upload-pack

* -f, --force

* -t, --tags

* -p, --prune

* --recurse-submodules

* --dry-run

* -k, --keep

* --depth

* --unshallow

* --update-shallow

* --refmap

Since 29609e6 (pull: do nothing on --dry-run, 2010-05-25) git-pull
supported the --dry-run option, exiting after git-fetch if --dry-run is
set. Re-implement this behavior.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c            | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 t/t5500-fetch-pack.sh     | 10 ++---
 t/t5521-pull-options.sh   |  6 +--
 t/t7403-submodule-sync.sh |  8 ++--
 4 files changed, 107 insertions(+), 12 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 573e4f6..07ad783 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -56,6 +56,21 @@ static struct string_list opt_strategies = STRING_LIST_INIT_NODUP;
 static struct string_list opt_strategy_opts = STRING_LIST_INIT_NODUP;
 static char *opt_gpg_sign;
 
+/* Options passed to git-fetch */
+static char *opt_all;
+static char *opt_append;
+static char *opt_upload_pack;
+static int opt_force;
+static char *opt_tags;
+static char *opt_prune;
+static char *opt_recurse_submodules;
+static int opt_dry_run;
+static char *opt_keep;
+static char *opt_depth;
+static char *opt_unshallow;
+static char *opt_update_shallow;
+static char *opt_refmap;
+
 static struct option pull_options[] = {
 	/* Shared options */
 	OPT__VERBOSITY(&opt_verbosity),
@@ -104,6 +119,46 @@ static struct option pull_options[] = {
 	  N_("GPG sign commit"),
 	  PARSE_OPT_OPTARG, parse_opt_passthru, (intptr_t) "gpg-sign" },
 
+	/* Options passed to git-fetch */
+	OPT_GROUP(N_("Options related to fetching")),
+	{ OPTION_CALLBACK, 0, "all", &opt_all, 0,
+	  N_("fetch from all remotes"),
+	  PARSE_OPT_NOARG, parse_opt_passthru, (intptr_t) "all" },
+	{ OPTION_CALLBACK, 'a', "append", &opt_append, 0,
+	  N_("append to .git/FETCH_HEAD instead of overwriting"),
+	  PARSE_OPT_NOARG, parse_opt_passthru, (intptr_t) "append" },
+	{ OPTION_CALLBACK, 0, "upload-pack", &opt_upload_pack, N_("path"),
+	  N_("path to upload pack on remote end"),
+	  0, parse_opt_passthru, (intptr_t) "upload-pack" },
+	OPT__FORCE(&opt_force, N_("force overwrite of local branch")),
+	{ OPTION_CALLBACK, 't', "tags", &opt_tags, 0,
+	  N_("fetch all tags and associated objects"),
+	  PARSE_OPT_NOARG, parse_opt_passthru, (intptr_t) "tags" },
+	{ OPTION_CALLBACK, 'p', "prune", &opt_prune, 0,
+	  N_("prune remote-tracking branches no longer on remote"),
+	  PARSE_OPT_NOARG, parse_opt_passthru, (intptr_t) "prune" },
+	{ OPTION_CALLBACK, 0, "recurse-submodules", &opt_recurse_submodules,
+	  N_("on-demand"),
+	  N_("control recursive fetching of submodules"),
+	  PARSE_OPT_OPTARG, parse_opt_passthru, (intptr_t) "recurse-submodules" },
+	OPT_BOOL(0, "dry-run", &opt_dry_run,
+		N_("dry run")),
+	{ OPTION_CALLBACK, 'k', "keep", &opt_keep, 0,
+	  N_("keep downloaded pack"),
+	  PARSE_OPT_NOARG, parse_opt_passthru, (intptr_t) "keep" },
+	{ OPTION_CALLBACK, 0, "depth", &opt_depth, N_("depth"),
+	  N_("deepen history of shallow clone"),
+	  0, parse_opt_passthru, (intptr_t) "depth" },
+	{ OPTION_CALLBACK, 0, "unshallow", &opt_unshallow, 0,
+	  N_("convert to a complete repository"),
+	  PARSE_OPT_NONEG | PARSE_OPT_NOARG, parse_opt_passthru, (intptr_t) "unshallow" },
+	{ OPTION_CALLBACK, 0, "update-shallow", &opt_update_shallow, 0,
+	  N_("accept refs that update .git/shallow"),
+	  PARSE_OPT_NOARG, parse_opt_passthru, (intptr_t) "update-shallow" },
+	{ OPTION_CALLBACK, 0, "refmap", &opt_refmap, N_("refmap"),
+	  N_("specify fetch refmap"),
+	  PARSE_OPT_NONEG, parse_opt_passthru, (intptr_t) "refmap" },
+
 	OPT_END()
 };
 
@@ -143,6 +198,16 @@ static void argv_push_strategy_opts(struct argv_array *arr)
 }
 
 /**
+ * Pushes "-f" switches into arr to match the opt_force level.
+ */
+static void argv_push_force(struct argv_array *arr)
+{
+	int force = opt_force;
+	while (force-- > 0)
+		argv_array_push(arr, "-f");
+}
+
+/**
  * Parses argv into [<repo> [<refspecs>...]], returning their values in `repo`
  * as a string and `refspecs` as a null-terminated array of strings. If `repo`
  * is not provided in argv, it is set to NULL.
@@ -173,6 +238,33 @@ static int run_fetch(const char *repo, const char **refspecs)
 	if (opt_progress)
 		argv_array_push(&args, opt_progress);
 
+	/* Options passed to git-fetch */
+	if (opt_all)
+		argv_array_push(&args, opt_all);
+	if (opt_append)
+		argv_array_push(&args, opt_append);
+	if (opt_upload_pack)
+		argv_array_push(&args, opt_upload_pack);
+	argv_push_force(&args);
+	if (opt_tags)
+		argv_array_push(&args, opt_tags);
+	if (opt_prune)
+		argv_array_push(&args, opt_prune);
+	if (opt_recurse_submodules)
+		argv_array_push(&args, opt_recurse_submodules);
+	if (opt_dry_run)
+		argv_array_push(&args, "--dry-run");
+	if (opt_keep)
+		argv_array_push(&args, opt_keep);
+	if (opt_depth)
+		argv_array_push(&args, opt_depth);
+	if (opt_unshallow)
+		argv_array_push(&args, opt_unshallow);
+	if (opt_update_shallow)
+		argv_array_push(&args, opt_update_shallow);
+	if (opt_refmap)
+		argv_array_push(&args, opt_refmap);
+
 	if (repo)
 		argv_array_push(&args, repo);
 	while (*refspecs)
@@ -233,5 +325,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 	if (run_fetch(repo, refspecs))
 		return 1;
 
+	if (opt_dry_run)
+		return 0;
+
 	return run_merge();
 }
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 213b231..3a9b775 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -226,14 +226,14 @@ test_expect_success 'add two more (part 2)' '
 	add B69 $B68
 '
 
-test_expect_failure 'deepening pull in shallow repo' '
+test_expect_success 'deepening pull in shallow repo' '
 	(
 		cd shallow &&
 		git pull --depth 4 .. B
 	)
 '
 
-test_expect_failure 'clone shallow object count' '
+test_expect_success 'clone shallow object count' '
 	(
 		cd shallow &&
 		git count-objects -v
@@ -248,7 +248,7 @@ test_expect_success 'deepening fetch in shallow repo' '
 	)
 '
 
-test_expect_failure 'clone shallow object count' '
+test_expect_success 'clone shallow object count' '
 	(
 		cd shallow &&
 		git count-objects -v
@@ -272,11 +272,11 @@ test_expect_success 'additional simple shallow deepenings' '
 	)
 '
 
-test_expect_failure 'clone shallow depth count' '
+test_expect_success 'clone shallow depth count' '
 	test "`git --git-dir=shallow/.git rev-list --count HEAD`" = 11
 '
 
-test_expect_failure 'clone shallow object count' '
+test_expect_success 'clone shallow object count' '
 	(
 		cd shallow &&
 		git count-objects -v
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 89e2104..4176e11 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -78,7 +78,7 @@ test_expect_success 'git pull -q -v' '
 	test -s err)
 '
 
-test_expect_failure 'git pull --force' '
+test_expect_success 'git pull --force' '
 	mkdir clonedoldstyle &&
 	(cd clonedoldstyle && git init &&
 	cat >>.git/config <<-\EOF &&
@@ -99,7 +99,7 @@ test_expect_failure 'git pull --force' '
 	)
 '
 
-test_expect_failure 'git pull --all' '
+test_expect_success 'git pull --all' '
 	mkdir clonedmulti &&
 	(cd clonedmulti && git init &&
 	cat >>.git/config <<-\EOF &&
@@ -117,7 +117,7 @@ test_expect_failure 'git pull --all' '
 	)
 '
 
-test_expect_failure 'git pull --dry-run' '
+test_expect_success 'git pull --dry-run' '
 	test_when_finished "rm -rf clonedry" &&
 	git init clonedry &&
 	(
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index b448562..79bc135 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -96,7 +96,7 @@ test_expect_success 'change submodule url' '
 	)
 '
 
-test_expect_failure '"git submodule sync" should update submodule URLs' '
+test_expect_success '"git submodule sync" should update submodule URLs' '
 	(
 		cd super-clone &&
 		git pull --no-recurse-submodules &&
@@ -121,7 +121,7 @@ test_expect_failure '"git submodule sync" should update submodule URLs' '
 	)
 '
 
-test_expect_failure '"git submodule sync --recursive" should update all submodule URLs' '
+test_expect_success '"git submodule sync --recursive" should update all submodule URLs' '
 	(
 		cd super-clone &&
 		(
@@ -149,7 +149,7 @@ test_expect_success 'reset submodule URLs' '
 	reset_submodule_urls super-clone
 '
 
-test_expect_failure '"git submodule sync" should update submodule URLs - subdirectory' '
+test_expect_success '"git submodule sync" should update submodule URLs - subdirectory' '
 	(
 		cd super-clone &&
 		git pull --no-recurse-submodules &&
@@ -177,7 +177,7 @@ test_expect_failure '"git submodule sync" should update submodule URLs - subdire
 	)
 '
 
-test_expect_failure '"git submodule sync --recursive" should update all submodule URLs - subdirectory' '
+test_expect_success '"git submodule sync --recursive" should update all submodule URLs - subdirectory' '
 	(
 		cd super-clone &&
 		(
-- 
2.1.4
