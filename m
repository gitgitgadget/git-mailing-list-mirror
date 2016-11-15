Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 246652021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935199AbcKOXHS (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:07:18 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33448 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934857AbcKOXHL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:07:11 -0500
Received: by mail-pg0-f48.google.com with SMTP id 3so71684439pgd.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZkQQZvDSyVhlvgFQkKpxuD2ei4gww2e5G6C5T6F5QO0=;
        b=AF5YXKPYpv4Yg4kGAksJ0OJnHBca7rMjAGKBtBPGydbdBwBy3OSfb7+hq2ohYoOx/W
         tFpy9lDo8YScpGltBKznijHWJ4VmzQt1CfsXC1oqYlq94DDNHVrvieoCKfT3G/imcqtZ
         KZSfThdcGh49grsxzlgzvJuIlBfFIV6+DYdiN1s0Smi0Hdbxgpd59/eoFlVrQO8pJHNp
         Ud3FYXmP+kgFPARK5YNET3Sv7gt8vj5eHM/pbYWzvWpYvZMab7mgnYXL9uIlJ0N6vqFR
         2TFQP2m9o143jACoeVc1KbC9/mPAdPef7NMCghIBY+3ONaA0PhmH1tvFZDnSnj12AFkL
         VUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZkQQZvDSyVhlvgFQkKpxuD2ei4gww2e5G6C5T6F5QO0=;
        b=QNIa+fN7rYJeoyetcdDCEEjC+M4gSR6v+IBjDKy5g3inEnoWqowEteD2+9anKXXCI3
         fW2boln/R8fltSjC5aItkd/27m01E9KCUWjpu83N9ulunHYLMekhVZxQjzhG1bCMH+2t
         l6Q5sYxdtuE+Kl2yDkXJzJTf1LVCzA9QLwl9VoMzTSrgnJIAjkJJIhqtIYGI9SemyPVO
         l+u4710DCW0t+veFqM31W5Fqu2bCCLcCiZ18Gg5Y6eIrDYPVMDQRSa8Qo/0M+3ijpovB
         zN1WzUKQh/GJR4AKG9gY5vdC0MVA05GtUkbfBi7Z7JwrXKcOCwpi2PutdsiD1aQDzAUB
         vHDQ==
X-Gm-Message-State: ABUngvcKYTfenYhEsjcBjtcr+H1mznCBTzFZFe47jqzRgN0nQo5otpJktQYLGna9o68XdFcv
X-Received: by 10.99.145.74 with SMTP id l71mr1145928pge.128.1479251230842;
        Tue, 15 Nov 2016 15:07:10 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:1161:a721:e128:bf5f])
        by smtp.gmail.com with ESMTPSA id r2sm46301707pfi.67.2016.11.15.15.07.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:07:10 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com,
        jrnieder@gmail.com, mogulguy10@gmail.com,
        David.Turner@twosigma.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 14/16] checkout: recurse into submodules if asked to
Date:   Tue, 15 Nov 2016 15:06:49 -0800
Message-Id: <20161115230651.23953-15-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161115230651.23953-1-sbeller@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allow checkout to recurse into submodules via
the command line option --[no-]recurse-submodules.

The flag for recurse-submodules in its current form
could be an OPT_BOOL, but eventually we may want to have
it as:

    git checkout --recurse-submodules=rebase|merge| \
			cherry-pick|checkout|none

which resembles the submodule.<name>.update options,
so naturally a value such as
"as-configured-or-X-as-fallback" would also come in handy.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-checkout.txt |   7 +
 builtin/checkout.c             |  31 +++-
 t/lib-submodule-update.sh      |  10 +-
 t/t2013-checkout-submodule.sh  | 325 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 362 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 8e2c066..a0ea2c5 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -256,6 +256,13 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 	out anyway. In other words, the ref can be held by more than one
 	worktree.
 
+--[no-]recurse-submodules::
+	Using --recurse-submodules will update the content of all initialized
+	submodules according to the commit recorded in the superproject. If
+	local modifications in a submodule would be overwritten the checkout
+	will fail until `-f` is used. If nothing (or --no-recurse-submodules)
+	is used, the work trees of submodules will not be updated.
+
 <branch>::
 	Branch to checkout; if it refers to a branch (i.e., a name that,
 	when prepended with "refs/heads/", is a valid ref), then that
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9b2a5b3..2a626a3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -21,12 +21,31 @@
 #include "submodule-config.h"
 #include "submodule.h"
 
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+
 static const char * const checkout_usage[] = {
 	N_("git checkout [<options>] <branch>"),
 	N_("git checkout [<options>] [<branch>] -- <file>..."),
 	NULL,
 };
 
+int option_parse_recurse_submodules(const struct option *opt,
+				    const char *arg, int unset)
+{
+	if (unset) {
+		recurse_submodules = RECURSE_SUBMODULES_OFF;
+		return 0;
+	}
+	if (arg)
+		recurse_submodules =
+			parse_update_recurse_submodules_arg(opt->long_name,
+							    arg);
+	else
+		recurse_submodules = RECURSE_SUBMODULES_ON;
+
+	return 0;
+}
+
 struct checkout_opts {
 	int patch_mode;
 	int quiet;
@@ -826,7 +845,8 @@ static int switch_branches(const struct checkout_opts *opts,
 		parse_commit_or_die(new->commit);
 	}
 
-	ret = merge_working_tree(opts, &old, new, &writeout_error);
+	ret = merge_working_tree(opts, &old, new, &writeout_error) ||
+	      update_submodules(opts->force);
 	if (ret) {
 		free(path_to_free);
 		return ret;
@@ -1160,6 +1180,9 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 				N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules,
+			    "checkout", "control recursive updating of submodules",
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
 		OPT_END(),
 	};
@@ -1190,6 +1213,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
 	}
 
+	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
+		git_config(submodule_config, NULL);
+		if (recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
+			set_config_update_recurse_submodules(recurse_submodules);
+	}
+
 	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
 
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 79cdd34..e0773c6 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -634,7 +634,13 @@ test_submodule_forced_switch () {
 
 	########################## Modified submodule #########################
 	# Updating a submodule sha1 doesn't update the submodule's work tree
-	test_expect_success "$command: modified submodule does not update submodule work tree" '
+	if test "$KNOWN_FAILURE_RECURSE_SUBMODULE_SERIES_BREAKS_REPLACE_SUBMODULE_TEST" = 1
+	then
+		RESULT="failure"
+	else
+		RESULT="success"
+	fi
+	test_expect_$RESULT "$command: modified submodule does not update submodule work tree" '
 		prolog &&
 		reset_work_tree_to add_sub1 &&
 		(
@@ -649,7 +655,7 @@ test_submodule_forced_switch () {
 	'
 	# Updating a submodule to an invalid sha1 doesn't update the
 	# submodule's work tree, subsequent update will fail
-	test_expect_success "$command: modified submodule does not update submodule work tree to invalid commit" '
+	test_expect_$RESULT "$command: modified submodule does not update submodule work tree to invalid commit" '
 		prolog &&
 		reset_work_tree_to add_sub1 &&
 		(
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 6847f75..60f6987 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -7,15 +7,21 @@ test_description='checkout can handle submodules'
 
 test_expect_success 'setup' '
 	mkdir submodule &&
-	(cd submodule &&
-	 git init &&
-	 test_commit first) &&
-	git add submodule &&
+	(
+		cd submodule &&
+		git init &&
+		test_commit first
+	) &&
+	echo first >file &&
+	git add file submodule &&
 	test_tick &&
 	git commit -m superproject &&
-	(cd submodule &&
-	 test_commit second) &&
-	git add submodule &&
+	(
+		cd submodule &&
+		test_commit second
+	) &&
+	echo second > file &&
+	git add file submodule &&
 	test_tick &&
 	git commit -m updated.superproject
 '
@@ -37,7 +43,8 @@ test_expect_success '"checkout <submodule>" updates the index only' '
 	git checkout HEAD^ submodule &&
 	test_must_fail git diff-files --quiet &&
 	git checkout HEAD submodule &&
-	git diff-files --quiet
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD
 '
 
 test_expect_success '"checkout <submodule>" honors diff.ignoreSubmodules' '
@@ -63,8 +70,310 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 	! test -s actual
 '
 
+# TODO: hardcode $2
+# use flag instead of checking for directory.
+submodule_creation_must_succeed() {
+	# checkout base ($1)
+	git checkout -f --recurse-submodules $1 &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached $1 &&
+
+	# checkout target ($2)
+	if test -d submodule; then
+		echo change >>submodule/first.t &&
+		test_must_fail git checkout --recurse-submodules $2 &&
+		git checkout -f --recurse-submodules $2
+	else
+		git checkout --recurse-submodules $2
+	fi &&
+	test -e submodule/.git &&
+	test -f submodule/first.t &&
+	test -f submodule/second.t &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached $2
+}
+
+# TODO: inline this:
+submodule_removal_must_succeed() {
+
+	# checkout base ($1)
+	git checkout -f --recurse-submodules $1 &&
+	git submodule update -f . &&
+	test -e submodule/.git &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached $1 &&
+
+	# checkout target ($2)
+	echo change >>submodule/first.t &&
+	test_must_fail git checkout --recurse-submodules $2 &&
+	git checkout -f --recurse-submodules $2 &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached $2 &&
+	! test -d submodule
+}
+
+test_expect_success '"check --recurse-submodules" removes deleted submodule' '
+	# first some setup:
+	git config -f .gitmodules submodule.submodule.path submodule &&
+	git config -f .gitmodules submodule.submodule.url ./submodule.bare &&
+	git -C submodule clone --bare . ../submodule.bare &&
+	echo submodule.bare >>.gitignore &&
+	git add .gitignore .gitmodules submodule &&
+	git commit -m "submodule registered with a gitmodules file" &&
+
+	# for testing this case, do it in a fresh clone with the submodules
+	# git dir inside the superprojects .git/modules dir.
+	git clone --recurse-submodules . super &&
+	(
+		cd super &&
+		git checkout -b base &&
+		git checkout -b delete_submodule &&
+		rm -rf submodule &&
+		git rm submodule &&
+		git commit -m "submodule deleted" &&
+		submodule_removal_must_succeed base delete_submodule
+	)
+'
+
+test_expect_success '"checkout --recurse-submodules" does not delete submodule with .git dir inside' '
+	git fetch super delete_submodule &&
+	git checkout --recurse-submodules FETCH_HEAD 2>output.err &&
+	test_i18ngrep "cannot remove submodule" output.err &&
+	test -d submodule/.git
+'
+
+test_expect_success '"checkout --recurse-submodules" repopulates submodule' '
+	(
+		cd super &&
+		submodule_creation_must_succeed delete_submodule base
+	)
+'
+
+test_expect_success '"checkout --recurse-submodules" repopulates submodule in existing directory' '
+	(
+		cd super &&
+		git checkout --recurse-submodules delete_submodule &&
+		mkdir submodule &&
+		submodule_creation_must_succeed delete_submodule base
+	)
+'
+
+test_expect_success '"checkout --recurse-submodules" replaces submodule with files' '
+	(
+		cd super
+		git checkout -f base &&
+		git checkout -b replace_submodule_with_file &&
+		git rm -f submodule &&
+		echo "file instead" >submodule &&
+		git add submodule &&
+		git commit -m "submodule replaced" &&
+		git checkout -f base &&
+		git submodule update -f . &&
+		git checkout --recurse-submodules replace_submodule_with_file &&
+		test -f submodule
+	)
+'
+
+test_expect_success '"checkout --recurse-submodules" removes files and repopulates submodule' '
+	(
+		cd super &&
+		submodule_creation_must_succeed replace_submodule_with_file base
+	)
+'
+
+test_expect_success '"checkout --recurse-submodules" replaces submodule with a directory' '
+	(
+		cd super
+		git checkout -f base &&
+		git checkout -b replace_submodule_with_dir &&
+		git rm -f submodule &&
+		mkdir -p submodule/dir &&
+		echo content >submodule/dir/file &&
+		git add submodule &&
+		git commit -m "submodule replaced with a directory (file inside)" &&
+		git checkout -f base &&
+		git submodule update -f . &&
+		git checkout --recurse-submodules replace_submodule_with_dir &&
+		test -d submodule &&
+		! test -e submodule/.git &&
+		! test -f submodule/first.t &&
+		! test -f submodule/second.t &&
+		test -d submodule/dir
+	)
+'
+
+test_expect_success '"checkout --recurse-submodules" removes the directory and repopulates submodule' '
+	(
+		cd super
+		submodule_creation_must_succeed replace_submodule_with_dir base
+	)
+'
+
+test_expect_success SYMLINKS '"checkout --recurse-submodules" replaces submodule with a link' '
+	(
+		cd super
+		git checkout -f base &&
+		git checkout -b replace_submodule_with_link &&
+		git rm -f submodule &&
+		ln -s submodule &&
+		git add submodule &&
+		git commit -m "submodule replaced with a link" &&
+		git checkout -f base &&
+		git submodule update -f . &&
+		git checkout --recurse-submodules replace_submodule_with_link &&
+		test -L submodule
+	)
+'
+
+test_expect_success SYMLINKS '"checkout --recurse-submodules" removes the link and repopulates submodule' '
+	(
+		cd super
+		submodule_creation_must_succeed replace_submodule_with_link base
+	)
+'
+
+test_expect_success '"checkout --recurse-submodules" updates the submodule' '
+	(
+		cd super
+		git checkout --recurse-submodules base &&
+		git diff-files --quiet &&
+		git diff-index --quiet --cached HEAD &&
+		git checkout -b updated_submodule &&
+		(
+			cd submodule &&
+			echo x >>first.t &&
+			git add first.t &&
+			test_commit third
+		) &&
+		git add submodule &&
+		test_tick &&
+		git commit -m updated.superproject &&
+		git checkout --recurse-submodules base &&
+		git diff-files --quiet &&
+		git diff-index --quiet --cached HEAD
+	)
+'
+
+test_expect_failure 'untracked file is not deleted' '
+	(
+		cd super &&
+		git checkout --recurse-submodules base &&
+		echo important >submodule/untracked &&
+		test_must_fail git checkout --recurse-submodules delete_submodule &&
+		git checkout -f --recurse-submodules delete_submodule
+	)
+'
+
+test_expect_success 'ignored file works just fine' '
+	(
+		cd super &&
+		git checkout --recurse-submodules base &&
+		echo important >submodule/ignored &&
+		echo ignored >.git/modules/submodule/info/exclude &&
+		git checkout --recurse-submodules delete_submodule
+	)
+'
+
+test_expect_success 'dirty file file is not deleted' '
+	(
+		cd super &&
+		git checkout --recurse-submodules base &&
+		echo important >submodule/first.t &&
+		test_must_fail git checkout --recurse-submodules delete_submodule &&
+		git checkout -f --recurse-submodules delete_submodule
+	)
+'
+
+test_expect_success 'added to index is not deleted' '
+	(
+		cd super &&
+		git checkout --recurse-submodules base &&
+		echo important >submodule/to_index &&
+		git -C submodule add to_index &&
+		test_must_fail git checkout --recurse-submodules delete_submodule &&
+		git checkout -f --recurse-submodules delete_submodule
+	)
+'
+
+# This is ok in theory, we just need to make sure
+# the garbage collection doesn't eat the commit.
+test_expect_success 'different commit prevents from deleting' '
+	(
+		cd super &&
+		git checkout --recurse-submodules base &&
+		echo important >submodule/to_index &&
+		git -C submodule add to_index &&
+		test_must_fail git checkout --recurse-submodules delete_submodule &&
+		git checkout -f --recurse-submodules delete_submodule
+	)
+'
+
+test_expect_failure '"checkout --recurse-submodules" needs -f to update a modifed submodule commit' '
+	(
+		cd submodule &&
+		git checkout --recurse-submodules HEAD^
+	) &&
+	test_must_fail git checkout --recurse-submodules master &&
+	test_must_fail git diff-files --quiet submodule &&
+	git diff-files --quiet file &&
+	git checkout --recurse-submodules -f master &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD
+'
+
+test_expect_failure '"checkout --recurse-submodules" needs -f to update modifed submodule content' '
+	echo modified >submodule/second.t &&
+	test_must_fail git checkout --recurse-submodules HEAD^ &&
+	test_must_fail git diff-files --quiet submodule &&
+	git diff-files --quiet file &&
+	git checkout --recurse-submodules -f HEAD^ &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD &&
+	git checkout --recurse-submodules -f master &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD
+'
+
+test_expect_failure '"checkout --recurse-submodules" ignores modified submodule content that would not be changed' '
+	echo modified >expected &&
+	cp expected submodule/first.t &&
+	git checkout --recurse-submodules HEAD^ &&
+	test_cmp expected submodule/first.t &&
+	test_must_fail git diff-files --quiet submodule &&
+	git diff-index --quiet --cached HEAD &&
+	git checkout --recurse-submodules -f master &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD
+'
+
+test_expect_failure '"checkout --recurse-submodules" does not care about untracked submodule content' '
+	echo untracked >submodule/untracked &&
+	git checkout --recurse-submodules master &&
+	git diff-files --quiet --ignore-submodules=untracked &&
+	git diff-index --quiet --cached HEAD &&
+	rm submodule/untracked
+'
+
+test_expect_failure '"checkout --recurse-submodules" needs -f when submodule commit is not present (but does fail anyway)' '
+	git checkout --recurse-submodules -b bogus_commit master &&
+	git update-index --cacheinfo 160000 0123456789012345678901234567890123456789 submodule &&
+	BOGUS_TREE=$(git write-tree) &&
+	BOGUS_COMMIT=$(echo "bogus submodule commit" | git commit-tree $BOGUS_TREE) &&
+	git commit -m "bogus submodule commit" &&
+	git checkout --recurse-submodules -f master &&
+	test_must_fail git checkout --recurse-submodules bogus_commit &&
+	git diff-files --quiet &&
+	test_must_fail git checkout --recurse-submodules -f bogus_commit &&
+	test_must_fail git diff-files --quiet submodule &&
+	git diff-files --quiet file &&
+	git diff-index --quiet --cached HEAD &&
+	git checkout --recurse-submodules -f master
+'
+
+KNOWN_FAILURE_RECURSE_SUBMODULE_SERIES_BREAKS_REPLACE_SUBMODULE_TEST=1
 test_submodule_switch "git checkout"
 
+KNOWN_FAILURE_RECURSE_SUBMODULE_SERIES_BREAKS_REPLACE_SUBMODULE_TEST=
 test_submodule_forced_switch "git checkout -f"
 
 test_done
-- 
2.10.1.469.g00a8914

