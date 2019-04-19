Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEB6420248
	for <e@80x24.org>; Fri, 19 Apr 2019 18:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfDSSma (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 14:42:30 -0400
Received: from cisrsmtp.univ-lyon1.fr ([134.214.188.146]:38664 "EHLO
        cisrsmtp.univ-lyon1.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfDSSma (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 14:42:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTP id 2294BA01A5;
        Fri, 19 Apr 2019 20:42:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at cisrsmtp.univ-lyon1.fr
Received: from cisrsmtp.univ-lyon1.fr ([127.0.0.1])
        by localhost (cisrsmtp.univ-lyon1.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5zdPHWqDzwOh; Fri, 19 Apr 2019 20:42:25 +0200 (CEST)
Received: from BEMBX2013-01.univ-lyon1.fr (bembx2013-01.univ-lyon1.fr [134.214.201.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by cisrsmtp.univ-lyon1.fr (Postfix) with ESMTPS id D1A02A00E7;
        Fri, 19 Apr 2019 20:42:25 +0200 (CEST)
Received: from Corentin-Linux.lan (134.214.126.172) by
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247) with Microsoft SMTP Server (TLS)
 id 15.0.1263.5; Fri, 19 Apr 2019 20:42:25 +0200
From:   Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
To:     <corentin.bompard@etu.univ-lyon1.fr>
CC:     <git@vger.kernel.org>, <gitster@pobox.com>,
        <matthieu.moy@univ-lyon1.fr>, <nathan.berbezier@etu.univ-lyon1.fr>,
        <pablo.chabanne@etu.univ-lyon1.fr>
Subject: [PATCH] [WIP/RFC] add git pull and git fetch --set-upstream
Date:   Fri, 19 Apr 2019 20:42:03 +0200
Message-ID: <20190419184203.14726-1-corentin.bompard@etu.univ-lyon1.fr>
X-Mailer: git-send-email 2.21.0-rc0
In-Reply-To: <20190419160046.5283-1-corentin.bompard@etu.univ-lyon1.fr>
References: <20190419160046.5283-1-corentin.bompard@etu.univ-lyon1.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [134.214.126.172]
X-ClientProxiedBy: JEMBX2013-01.univ-lyon1.fr (134.214.201.249) To
 BEMBX2013-01.univ-lyon1.fr (134.214.201.247)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the --set-upstream option to git pull/fetch
which lets the user set the upstream configuration
(branch.<current-branch-name>.merge and
branch.<current-branch-name>.remote) for the current branch.

For example a typical use-case like

    git clone http://example.com/my-public-fork

    git remote add main http://example.com/project-main-repo

    git pull --set-upstream main master

or, instead of the last line

    git fetch --set-upstream main master

    git merge # or git rebase

This fonctionality works like git push --set-upstream.

Signed-off-by: Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>
Signed-off-by: Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>
Signed-off-by: Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>
Signed-off-by: Matthieu MOY <matthieu.moy@univ-lyon1.fr>
---
 Documentation/fetch-options.txt |   6 ++
 builtin/fetch.c                 |  49 +++++++++++-
 builtin/pull.c                  |   6 ++
 t/t5553-set-upstream.sh         | 137 ++++++++++++++++++++++++++++++++
 4 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100755 t/t5553-set-upstream.sh

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index fa0a3151b..a00705ea4 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -165,6 +165,12 @@ ifndef::git-pull[]
 	Disable recursive fetching of submodules (this has the same effect as
 	using the `--recurse-submodules=no` option).
 
+--set-upstream::
+	If the new URL remote is correct, pull and add upstream (tracking) 
+	reference, used by argument-less linkgit:git-push[1] and other commands.
+	For more information, see `branch.<name>.merge` and `branch.<name>.remote`
+	in linkgit:git-config[1].
+
 --submodule-prefix=<path>::
 	Prepend <path> to paths printed in informative messages
 	such as "Fetching submodule foo".  This option is used
diff --git a/builtin/fetch.c b/builtin/fetch.c
index b620fd54b..760630f11 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -23,6 +23,7 @@
 #include "packfile.h"
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
+#include "branch.h"
 
 static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
@@ -46,7 +47,7 @@ static int fetch_prune_tags_config = -1; /* unspecified */
 static int prune_tags = -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
 
-static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity, deepen_relative;
+static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity, deepen_relative, set_upstream;
 static int progress = -1;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
 static int max_children = 1;
@@ -113,6 +114,8 @@ static struct option builtin_fetch_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "all", &all,
 		 N_("fetch from all remotes")),
+	OPT_BOOL(0, "set-upstream", &set_upstream,
+		 N_("set upstream for git pull/fetch")),
 	OPT_BOOL('a', "append", &append,
 		 N_("append to .git/FETCH_HEAD instead of overwriting")),
 	OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
@@ -1317,6 +1320,50 @@ static int do_fetch(struct transport *transport,
 		retcode = 1;
 		goto cleanup;
 	}
+
+	if (set_upstream) {
+		struct branch *branch = branch_get("HEAD");
+		struct ref *rm;
+		struct ref *source_ref = NULL;
+
+		/*
+		 * We're setting the upstream configuration for the current branch. The
+		 * relevent upstream is the fetched branch that is meant to be merged with
+		 * the current one, i.e. the one fetched to FETCH_HEAD.
+		 *
+		 * When there are several such branches, consider the request ambiguous and
+		 * err on the safe side by doing nothing and just emit a waring.
+		 */
+		for (rm = ref_map; rm; rm = rm->next) {
+			if (!rm->peer_ref) {
+				if (source_ref) {
+					warning(_("multiple branch detected, incompatible with set-upstream"));
+					source_ref = NULL;
+					goto skip;
+				} else {
+					source_ref = rm;
+				}
+			}
+		}
+		if (source_ref) {
+			if (!strcmp(source_ref->name, "HEAD") || 
+				starts_with(source_ref->name, "refs/heads/")) {
+				install_branch_config(0, branch->name,
+							 transport->remote->name,
+							 source_ref->name);
+			} else if (starts_with(source_ref->name, "refs/remotes/")) {
+				warning(_("not setting upstream for a remote remote-tracking branch"));
+			} else if (starts_with(source_ref->name, "refs/tags/")) {
+				warning(_("tag upstream not set"));
+			} else {
+				warning(_("unknown branch type"));
+			}
+		} else {
+			warning(_("no source branch found. \n" 
+				"you need to specify exactly one branch with the set-upstream option."));
+		}
+	}
+ skip:
 	free_refs(ref_map);
 
 	/* if neither --no-tags nor --tags was specified, do automated tag
diff --git a/builtin/pull.c b/builtin/pull.c
index 701d1473d..06d7cddce 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -122,6 +122,7 @@ static char *opt_update_shallow;
 static char *opt_refmap;
 static char *opt_ipv4;
 static char *opt_ipv6;
+static char *set_upstream;
 
 static struct option pull_options[] = {
 	/* Shared options */
@@ -233,6 +234,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU('6',  "ipv6", &opt_ipv6, NULL,
 		N_("use IPv6 addresses only"),
 		PARSE_OPT_NOARG),
+	OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
+		N_("set upstream for git pull/fetch"),
+		PARSE_OPT_NOARG),
 
 	OPT_END()
 };
@@ -541,6 +545,8 @@ static int run_fetch(const char *repo, const char **refspecs)
 		argv_array_push(&args, opt_ipv4);
 	if (opt_ipv6)
 		argv_array_push(&args, opt_ipv6);
+	if (set_upstream)
+		argv_array_push(&args, set_upstream);
 
 	if (repo) {
 		argv_array_push(&args, repo);
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
new file mode 100755
index 000000000..62ff77342
--- /dev/null
+++ b/t/t5553-set-upstream.sh
@@ -0,0 +1,137 @@
+#!/bin/sh
+
+test_description='"git fetch/pull --set-upstream" basic tests.
+
+'
+. ./test-lib.sh
+
+check_config () {
+	printf "%s\n" "$2" "$3" >"expect.$1" &&
+	{
+		git config "branch.$1.remote" && git config "branch.$1.merge"
+	} >"actual.$1" &&
+	test_cmp "expect.$1" "actual.$1"
+}
+
+check_config_empty () {
+	test_expect_code 1 git config "branch.$1.remote" &&
+	test_expect_code 1 git config "branch.$1.merge"
+}
+
+clear_config () {
+	git config --unset "branch.$1.remote" &&
+	git config --unset "branch.$1.merge"
+}
+
+ensure_fresh_upstream () {
+	rm -rf parent && git init --bare parent
+}
+
+test_expect_success 'setup bare parent fetch' '
+	ensure_fresh_upstream &&
+	git remote add upstream parent &&
+	git remote add up parent
+'
+
+test_expect_success 'setup commit on master and other fetch' '
+	test_commit one &&
+	git push upstream master &&
+	git checkout -b other &&
+	test_commit two &&
+	git push upstream other
+'
+
+#tests for fetch --set-upstream
+
+test_expect_success 'fetch --set-upstream does not set upstream w/o branch' '
+	git checkout master &&
+	git fetch --set-upstream upstream &&
+	check_config_empty master &&
+	check_config_empty other
+'
+
+test_expect_success 'fetch --set-upstream upstream master sets branch master but not other' '
+	git fetch --set-upstream upstream master &&
+	check_config master upstream refs/heads/master &&
+	check_config_empty other
+'
+
+test_expect_success 'fetch --set-upstream upstream other sets branch other' '
+	git fetch --set-upstream upstream other &&
+	check_config master upstream refs/heads/other &&
+	check_config_empty other
+'
+
+test_expect_success 'fetch --set-upstream master:other does not set the branch other2' '
+	git fetch --set-upstream upstream master:other2 &&
+	check_config_empty other2
+'
+
+test_expect_success 'fetch --set-upstream http://nosuchdomain.example.com fails with the bad url' '
+	test_must_fail git fetch --set-upstream http://nosuchdomain.example.com &&
+	check_config master upstream refs/heads/other &&
+	check_config_empty other &&
+	check_config_empty other2
+'
+
+#tests for pull --set-upstream
+
+test_expect_success 'setup bare parent pull' '
+	git remote rm upstream &&
+	ensure_fresh_upstream &&
+	git remote add upstream parent
+'
+
+test_expect_success 'setup commit on master and other pull' '
+	test_commit three &&
+	git push --tags upstream master &&
+	test_commit four &&
+	git push upstream other
+'
+
+test_expect_success 'pull --set-upstream upstream master sets branch master but not other' '
+	git pull --set-upstream upstream master &&
+	check_config master upstream refs/heads/master &&
+	check_config_empty other
+'
+
+test_expect_success 'pull --set-upstream master:other2 does not set the branch other2' '
+	git pull --set-upstream upstream master:other2 &&
+	check_config_empty other2
+'
+
+test_expect_success 'pull --set-upstream upstream other sets branch master' '
+	git pull --set-upstream upstream other &&
+	check_config master upstream refs/heads/other &&
+	check_config_empty other
+'
+
+test_expect_success 'pull --set-upstream upstream tag does not set the tag' '
+	git pull --tags --set-upstream upstream three &&
+	check_config_empty three
+'
+
+test_expect_success 'pull --set-upstream http://nosuchdomain.example.com fails with the bad url' '
+	test_must_fail git pull --set-upstream http://nosuchdomain.example.com &&
+	check_config master upstream refs/heads/other &&
+	check_config_empty other &&
+	check_config_empty other2 &&
+	check_config_empty three
+'
+
+test_expect_success 'pull --set-upstream upstream HEAD sets branch HEAD' '
+	git pull --set-upstream upstream HEAD &&
+	check_config master upstream HEAD &&
+	git checkout other &&
+	git pull --set-upstream upstream HEAD &&
+	check_config other upstream HEAD
+'
+
+test_expect_success 'pull --set-upstream upstream with more than one branch does nothing' '
+	clear_config master &&
+	git pull --set-upstream upstream master three &&
+	check_config_empty master &&
+	check_config_empty three
+'
+
+test_done
-- 
2.21.0-rc0

