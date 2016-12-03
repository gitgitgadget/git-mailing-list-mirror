Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7295E1FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932115AbcLCAbO (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:31:14 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35795 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbcLCAav (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:51 -0500
Received: by mail-pg0-f46.google.com with SMTP id p66so112894132pga.2
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mBJzXWGQQPhVRye7+3qGRJipFoBIRoNKHsPdmBz1GQI=;
        b=cTFMT+SVHgXcB0cq1BaZLYP6VkoU7DGVm+/FIQR/sAARq31M1muExGdv/F1/D6bQ08
         UE7M92d8KIOvIG/Zyb7H4zhhMs/GpTeIYaTneh56rnlGQfffCPM87Kz0jdS2oIIc4z59
         fRahyQf7BrjARXN6jBI+irX0X5O4gnyAvqbUArDUX1Z9gIp2BMyS0gZfUQC79IZbZM/D
         82tDISgkeELyPXU6cwUpAnpBeCvFuug+LTiM7JS9lst1s5SgI2iVWDgtoLzF+32vJDpg
         FEJS7cu1vuSO6EqjGh4O4NR5UrqC8WR7jDl8VUaNj6R4Lm85FHuf07E8wUA1PC60aC3O
         14FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mBJzXWGQQPhVRye7+3qGRJipFoBIRoNKHsPdmBz1GQI=;
        b=DMaX4WYjsQ8OgaiP9nRKC6rWSF4VovRbnV8MtW+V6qTx8njlhpcdjOuuy9jKXQ9MY1
         NaQKEE4/GhqplFpEnZLMakDXhsYJMbD92jHwR9GMkm/prlxw79RhOIv45JFHuVNzr09F
         JqJTPt2TB2Uitg8Ujy4oG4g8SaQwfuZLnuVif2Vg36cSAjiiX4SxOX5ilGxGpkuvM5Hc
         rpXUXQkVOxb6DdmwzpFYdYy9At3lBcVXgeyIDJpnaoseLObIXmdIX1nX1FV/l3le5NG6
         ruKu4kAdshjFVq/teF2I9ekZvQxWEDhnWT3gHhmod4QT23b1AG6UWzc0ZEUA8UwEL3Bk
         +S5A==
X-Gm-Message-State: AKaTC01Cji7oY4u50G3hjVmJKy3yQ2qrJCKScHnnwGylrOm64V8APbLJt9QoGwgoYgwEk6C7
X-Received: by 10.99.213.21 with SMTP id c21mr81772549pgg.137.1480725050711;
        Fri, 02 Dec 2016 16:30:50 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id 186sm10222059pfv.61.2016.12.02.16.30.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:50 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 15/17] checkout: recurse into submodules if asked to
Date:   Fri,  2 Dec 2016 16:30:20 -0800
Message-Id: <20161203003022.29797-16-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
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
 Documentation/git-checkout.txt |   7 ++
 builtin/checkout.c             |  31 ++++-
 t/t2013-checkout-submodule.sh  | 277 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 306 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 8e2c0662dd..a0ea2c5651 100644
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
index 512492aad9..5db0d933d1 100644
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
 
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 6847f75822..33fb2f5de3 100755
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
@@ -63,6 +70,260 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 	! test -s actual
 '
 
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
+test_expect_success 'setup the submodule config' '
+	git config -f .gitmodules submodule.submodule.path submodule &&
+	git config -f .gitmodules submodule.submodule.url ./submodule.bare &&
+	git -C submodule clone --bare . ../submodule.bare &&
+	echo submodule.bare >>.gitignore &&
+	git add .gitignore .gitmodules submodule &&
+	git commit -m "submodule registered with a gitmodules file" &&
+	git config submodule.submodule.url ./submodule.bare
+'
+
+test_expect_success '"checkout --recurse-submodules" migrates submodule git dir before deleting' '
+	git checkout -b base &&
+	git checkout -b delete_submodule &&
+	git update-index --force-remove submodule &&
+	git config -f .gitmodules --unset submodule.submodule.path &&
+	git config -f .gitmodules --unset submodule.submodule.url &&
+	git add .gitmodules &&
+	git commit -m "submodule deleted" &&
+	git checkout base &&
+	git checkout --recurse-submodules delete_submodule 2>output.err 1>output.out &&
+	test_i18ngrep "Migrating git directory" output.out &&
+	! test -d submodule
+'
+
+test_expect_success '"check --recurse-submodules" removes deleted submodule' '
+	# Make sure we have the submodule here and ready.
+	git checkout base &&
+	git submodule embedgitdirs &&
+	git submodule update -f . &&
+	test -e submodule/.git &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached base &&
+
+	# Check if the checkout deletes the submodule.
+	echo change >>submodule/first.t &&
+	test_must_fail git checkout --recurse-submodules delete_submodule &&
+	git checkout -f --recurse-submodules delete_submodule &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached delete_submodule &&
+	! test -d submodule
+'
+
+test_expect_success '"checkout --recurse-submodules" repopulates submodule' '
+	submodule_creation_must_succeed delete_submodule base
+'
+
+test_expect_success '"checkout --recurse-submodules" repopulates submodule in existing directory' '
+	git checkout --recurse-submodules delete_submodule &&
+	mkdir submodule &&
+	submodule_creation_must_succeed delete_submodule base
+'
+
+test_expect_success '"checkout --recurse-submodules" replaces submodule with files' '
+	git checkout -f base &&
+	git checkout -b replace_submodule_with_file &&
+	git rm -f submodule &&
+	echo "file instead" >submodule &&
+	git add submodule &&
+	git commit -m "submodule replaced" &&
+	git checkout -f base &&
+	git submodule update -f . &&
+	git checkout --recurse-submodules replace_submodule_with_file &&
+	test -f submodule
+'
+
+test_expect_success '"checkout --recurse-submodules" removes files and repopulates submodule' '
+	submodule_creation_must_succeed replace_submodule_with_file base
+'
+
+test_expect_success '"checkout --recurse-submodules" replaces submodule with a directory' '
+	git checkout -f base &&
+	git checkout -b replace_submodule_with_dir &&
+	git rm -f submodule &&
+	mkdir -p submodule/dir &&
+	echo content >submodule/dir/file &&
+	git add submodule &&
+	git commit -m "submodule replaced with a directory (file inside)" &&
+	git checkout -f base &&
+	git submodule update -f . &&
+	git checkout --recurse-submodules replace_submodule_with_dir &&
+	test -d submodule &&
+	! test -e submodule/.git &&
+	! test -f submodule/first.t &&
+	! test -f submodule/second.t &&
+	test -d submodule/dir
+'
+
+test_expect_success '"checkout --recurse-submodules" removes the directory and repopulates submodule' '
+	submodule_creation_must_succeed replace_submodule_with_dir base
+'
+
+test_expect_success SYMLINKS '"checkout --recurse-submodules" replaces submodule with a link' '
+	git checkout -f base &&
+	git checkout -b replace_submodule_with_link &&
+	git rm -f submodule &&
+	ln -s submodule &&
+	git add submodule &&
+	git commit -m "submodule replaced with a link" &&
+	git checkout -f base &&
+	git submodule update -f . &&
+	git checkout --recurse-submodules replace_submodule_with_link &&
+	test -L submodule
+'
+
+test_expect_success SYMLINKS '"checkout --recurse-submodules" removes the link and repopulates submodule' '
+	submodule_creation_must_succeed replace_submodule_with_link base
+'
+
+test_expect_success '"checkout --recurse-submodules" updates the submodule' '
+	git checkout --recurse-submodules base &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD &&
+	git checkout -b updated_submodule &&
+	(
+		cd submodule &&
+		echo x >>first.t &&
+		git add first.t &&
+		test_commit third
+	) &&
+	git add submodule &&
+	test_tick &&
+	git commit -m updated.superproject &&
+	git checkout --recurse-submodules base &&
+	git diff-files --quiet &&
+	git diff-index --quiet --cached HEAD
+'
+
+# In 293ab15eea34 we considered untracked ignored files in submodules
+# expendable, we may want to revisit this decision by adding user as
+# well as command specific configuration for it.
+# When building in-tree the untracked ignored files are probably ok to remove
+# in a case as tested here, but e.g. when git.git is a submodule, then a user
+# may not want to lose a well crafted (but ignored by default) "config.mak"
+# Commands like "git rm" may care less about untracked files in a submodule
+# as the checkout command that removes a submodule as well.
+test_expect_failure 'untracked file is not deleted' '
+	git checkout --recurse-submodules base &&
+	echo important >submodule/untracked &&
+	test_must_fail git checkout --recurse-submodules delete_submodule &&
+	git checkout -f --recurse-submodules delete_submodule
+'
+
+test_expect_success 'ignored file works just fine' '
+	git checkout --recurse-submodules base &&
+	echo important >submodule/ignored &&
+	echo ignored >.git/modules/submodule/info/exclude &&
+	git checkout --recurse-submodules delete_submodule
+'
+
+test_expect_success 'dirty file file is not deleted' '
+	git checkout --recurse-submodules base &&
+	echo important >submodule/first.t &&
+	test_must_fail git checkout --recurse-submodules delete_submodule &&
+	git checkout -f --recurse-submodules delete_submodule
+'
+
+test_expect_success 'added to index is not deleted' '
+	git checkout --recurse-submodules base &&
+	echo important >submodule/to_index &&
+	git -C submodule add to_index &&
+	test_must_fail git checkout --recurse-submodules delete_submodule &&
+	git checkout -f --recurse-submodules delete_submodule
+'
+
+# This is ok in theory, we just need to make sure
+# the garbage collection doesn't eat the commit.
+test_expect_success 'different commit prevents from deleting' '
+	git checkout --recurse-submodules base &&
+	echo important >submodule/to_index &&
+	git -C submodule add to_index &&
+	test_must_fail git checkout --recurse-submodules delete_submodule &&
+	git checkout -f --recurse-submodules delete_submodule
+'
+
+test_expect_failure '"checkout --recurse-submodules" needs -f to update a modifed submodule commit' '
+	git -C submodule checkout --recurse-submodules HEAD^ &&
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
 test_submodule_switch "git checkout"
 
 test_submodule_forced_switch "git checkout -f"
-- 
2.11.0.rc2.28.g2673dad

