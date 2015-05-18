From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 03/14] pull: pass git-merge's options to git-merge
Date: Mon, 18 May 2015 23:06:00 +0800
Message-ID: <1431961571-20370-4-git-send-email-pyokagan@gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 17:07:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMdx-0004Ni-3N
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 17:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbbERPHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 11:07:40 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34853 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbbERPHg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 11:07:36 -0400
Received: by pacwv17 with SMTP id wv17so155731313pac.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n6BrkIUvr4FKmljHtgpiNMPWeYCUFAurVqOLdFGpkDk=;
        b=Jom3d1u8mSZfrC46D5PKMWQB4m5In2llJ6jvAsbhYvhq/88a897dE1FB80njMXbqNl
         B4EBtJR8n/Sv4p9z2VR60VobdAsbgnOjDr1CNDcrDNi7G4PYlOO21DLYCRDbvOqJoYgt
         UkiGqyz9lU7VMcqUP/i3e3bbtkY+OL5alExMF203kitRSaIUu48uUUk6YW1wvMB6Uy+w
         gHHbrZaZPgCW5MhjpMxkJGAjqgoLNjY0XZ/m99aIKNdg8L8f7u0QnhlVbsJMUwON3NJG
         56gfbCNhskMIlcw/3/TZMmPmJcxnRQI5tYRcpbpwXkjmEOMZbt/vDkI8CEEmOvvK/ROS
         MLBw==
X-Received: by 10.70.22.131 with SMTP id d3mr44952005pdf.67.1431961656075;
        Mon, 18 May 2015 08:07:36 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id i9sm10370062pdj.27.2015.05.18.08.07.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 08:07:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269261>

Specify git-merge's options in the option list, and pass any specified
options to git-merge.

These options are:

* -n, --stat, --summary: since d8abe14 (merge, pull: introduce
  '--(no-)stat' option, 2008-04-06)

* --log: since efb779f (merge, pull: add '--(no-)log' command line
  option, 2008-04-06)

* --squash: since 7d0c688 (git-merge --squash, 2006-06-23)

* --commit: since 5072a32 (Teach git-pull about --[no-]ff, --no-squash
  and --commit, 2007-10-29)

* --edit: since 8580830 ("git pull" doesn't know "--edit", 2012-02-11)

* --ff, --ff-only: since 5072a32 (Teach git-pull about --[no-]ff,
  --no-squash and --commit, 2007-10-29)

* --verify-signatures: since efed002 (merge/pull: verify GPG signatures
  of commits being merged, 2013-03-31)

* -s, --strategy: since 60fb5b2 (Use git-merge in git-pull (second
  try)., 2005-09-25)

* -X, --strategy-option: since ee2c795 (Teach git-pull to pass
  -X<option> to git-merge, 2009-11-25)

* -S, --gpg-sign: since ea230d8 (pull: add the --gpg-sign option.,
  2014-02-10)

While most options can be implemented through the parse_opt_passthru()
callback, --strategy and --strategy-option are implemented by
introducing argv_push_strategies() and argv_push_strategy_opts() as they
can be specified multiple times.

Also allow --log to take a value <n>, thus making the failing test
'--log=1 limits shortlog length' pass.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/pull.c               | 94 ++++++++++++++++++++++++++++++++++++++++++++
 t/t4013-diff-various.sh      |  3 --
 t/t5150-request-pull.sh      |  2 +-
 t/t5524-pull-msg.sh          |  2 +-
 t/t5572-pull-submodule.sh    |  4 --
 t/t6029-merge-subtree.sh     |  6 +--
 t/t6037-merge-ours-theirs.sh |  2 +-
 7 files changed, 100 insertions(+), 13 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index a4d9c92..573e4f6 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -44,6 +44,18 @@ static const char * const pull_usage[] = {
 static int opt_verbosity;
 static char *opt_progress;
 
+/* Options passed to git-merge */
+static char *opt_diffstat;
+static char *opt_log;
+static char *opt_squash;
+static char *opt_commit;
+static char *opt_edit;
+static char *opt_ff;
+static char *opt_verify_signatures;
+static struct string_list opt_strategies = STRING_LIST_INIT_NODUP;
+static struct string_list opt_strategy_opts = STRING_LIST_INIT_NODUP;
+static char *opt_gpg_sign;
+
 static struct option pull_options[] = {
 	/* Shared options */
 	OPT__VERBOSITY(&opt_verbosity),
@@ -51,6 +63,47 @@ static struct option pull_options[] = {
 	  N_("force progress reporting"),
 	  PARSE_OPT_NOARG, parse_opt_passthru},
 
+	/* Options passed to git-merge */
+	OPT_GROUP(N_("Options related to merging")),
+	{ OPTION_CALLBACK, 'n', NULL, &opt_diffstat, NULL,
+	  N_("do not show a diffstat at the end of the merge"),
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_passthru, (intptr_t) "no-stat" },
+	{ OPTION_CALLBACK, 0, "stat", &opt_diffstat, NULL,
+	  N_("show a diffstat at the end of the merge"),
+	  PARSE_OPT_NOARG, parse_opt_passthru, (intptr_t) "stat" },
+	{ OPTION_CALLBACK, 0, "summary", &opt_diffstat, NULL,
+	  N_("(synonym to --stat)"),
+	  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, parse_opt_passthru, (intptr_t) "stat" },
+	{ OPTION_CALLBACK, 0, "log", &opt_log, N_("n"),
+	  N_("add (at most <n>) entries from shortlog to merge commit message"),
+	  PARSE_OPT_OPTARG, parse_opt_passthru, (intptr_t) "log" },
+	{ OPTION_CALLBACK, 0, "squash", &opt_squash, NULL,
+	  N_("create a single commit instead of doing a merge"),
+	  PARSE_OPT_NOARG, parse_opt_passthru, (intptr_t) "squash" },
+	{ OPTION_CALLBACK, 0, "commit", &opt_commit, NULL,
+	  N_("perform a commit if the merge succeeds (default)"),
+	  PARSE_OPT_NOARG, parse_opt_passthru, (intptr_t) "commit" },
+	{ OPTION_CALLBACK, 0, "edit", &opt_edit, NULL,
+	  N_("edit message before committing"),
+	  PARSE_OPT_NOARG, parse_opt_passthru, (intptr_t) "edit" },
+	{ OPTION_CALLBACK, 0, "ff", &opt_ff, NULL,
+	  N_("allow fast-forward"),
+	  PARSE_OPT_NOARG, parse_opt_passthru, (intptr_t) "ff" },
+	{ OPTION_CALLBACK, 0, "ff-only", &opt_ff, NULL,
+	  N_("abort if fast-forward is not possible"),
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_passthru, (intptr_t) "ff-only" },
+	{ OPTION_CALLBACK, 0, "verify-signatures", &opt_verify_signatures, NULL,
+	  N_("verify that the named commit has a valid GPG signature"),
+	  PARSE_OPT_NOARG, parse_opt_passthru, (intptr_t) "verify-signatures" },
+	OPT_STRING_LIST('s', "strategy", &opt_strategies, N_("strategy"),
+			N_("merge strategy to use")),
+	OPT_STRING_LIST('X', "strategy-option", &opt_strategy_opts,
+			N_("option=value"),
+			N_("option for selected merge strategy")),
+	{ OPTION_CALLBACK, 'S', "gpg-sign", &opt_gpg_sign, N_("key-id"),
+	  N_("GPG sign commit"),
+	  PARSE_OPT_OPTARG, parse_opt_passthru, (intptr_t) "gpg-sign" },
+
 	OPT_END()
 };
 
@@ -69,6 +122,27 @@ static void argv_push_verbosity(struct argv_array *arr)
 }
 
 /**
+ * Pushes opt_strategies as "-s <strategy>" flags into arr.
+ */
+static void argv_push_strategies(struct argv_array *arr)
+{
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, &opt_strategies)
+		argv_array_pushl(arr, "-s", item->string, NULL);
+}
+
+/**
+ * Pushes opt_strategy_opts as "-X <option>" flags into arr.
+ */
+static void argv_push_strategy_opts(struct argv_array *arr)
+{
+	struct string_list_item *item;
+	for_each_string_list_item(item, &opt_strategy_opts)
+		argv_array_pushl(arr, "-X", item->string, NULL);
+}
+
+/**
  * Parses argv into [<repo> [<refspecs>...]], returning their values in `repo`
  * as a string and `refspecs` as a null-terminated array of strings. If `repo`
  * is not provided in argv, it is set to NULL.
@@ -123,6 +197,26 @@ static int run_merge(void)
 	if (opt_progress)
 		argv_array_push(&args, opt_progress);
 
+	/* Options passed to git-merge */
+	if (opt_diffstat)
+		argv_array_push(&args, opt_diffstat);
+	if (opt_log)
+		argv_array_push(&args, opt_log);
+	if (opt_squash)
+		argv_array_push(&args, opt_squash);
+	if (opt_commit)
+		argv_array_push(&args, opt_commit);
+	if (opt_edit)
+		argv_array_push(&args, opt_edit);
+	if (opt_ff)
+		argv_array_push(&args, opt_ff);
+	if (opt_verify_signatures)
+		argv_array_push(&args, opt_verify_signatures);
+	argv_push_strategies(&args);
+	argv_push_strategy_opts(&args);
+	if (opt_gpg_sign)
+		argv_array_push(&args, opt_gpg_sign);
+
 	argv_array_push(&args, "FETCH_HEAD");
 	ret = run_command_v_opt(args.argv, RUN_GIT_CMD);
 	argv_array_clear(&args);
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index a11e48b..6ec6072 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -7,9 +7,6 @@ test_description='Various diff formatting options'
 
 . ./test-lib.sh
 
-skip_all='setup for this test suite requires git pull -s'
-test_done
-
 LF='
 '
 
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index f5ea605..82c33b8 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -132,7 +132,7 @@ test_expect_success 'pull request when forgot to push' '
 
 '
 
-test_expect_failure 'pull request after push' '
+test_expect_success 'pull request after push' '
 
 	rm -fr downstream.git &&
 	git init --bare downstream.git &&
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index 1ba8054..eebb8c9 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -25,7 +25,7 @@ test_expect_success setup '
 	git commit -m "do not clobber $dollar signs"
 '
 
-test_expect_failure pull '
+test_expect_success pull '
 (
 	cd cloned &&
 	git pull --log &&
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 408c886..accfa5c 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -5,10 +5,6 @@ test_description='pull can handle submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
-KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES=1
-KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
-
 reset_branch_to_HEAD () {
 	git branch -D "$1" &&
 	git checkout -b "$1" HEAD &&
diff --git a/t/t6029-merge-subtree.sh b/t/t6029-merge-subtree.sh
index 54af64e..73fc240 100755
--- a/t/t6029-merge-subtree.sh
+++ b/t/t6029-merge-subtree.sh
@@ -61,7 +61,7 @@ test_expect_success 'initial merge' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'merge update' '
+test_expect_success 'merge update' '
 	cd ../git-gui &&
 	echo git-gui2 > git-gui.sh &&
 	o3=$(git hash-object git-gui.sh) &&
@@ -95,7 +95,7 @@ test_expect_success 'initial ambiguous subtree' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'merge using explicit' '
+test_expect_success 'merge using explicit' '
 	cd ../git &&
 	git reset --hard master2 &&
 	git pull -Xsubtree=git-gui gui master2 &&
@@ -108,7 +108,7 @@ test_expect_failure 'merge using explicit' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'merge2 using explicit' '
+test_expect_success 'merge2 using explicit' '
 	cd ../git &&
 	git reset --hard master2 &&
 	git pull -Xsubtree=git-gui2 gui master2 &&
diff --git a/t/t6037-merge-ours-theirs.sh b/t/t6037-merge-ours-theirs.sh
index 876e23b..3889eca 100755
--- a/t/t6037-merge-ours-theirs.sh
+++ b/t/t6037-merge-ours-theirs.sh
@@ -65,7 +65,7 @@ test_expect_success 'binary file with -Xours/-Xtheirs' '
 	git diff --exit-code master HEAD -- file
 '
 
-test_expect_failure 'pull passes -X to underlying merge' '
+test_expect_success 'pull passes -X to underlying merge' '
 	git reset --hard master && git pull -s recursive -Xours . side &&
 	git reset --hard master && git pull -s recursive -X ours . side &&
 	git reset --hard master && git pull -s recursive -Xtheirs . side &&
-- 
2.1.4
