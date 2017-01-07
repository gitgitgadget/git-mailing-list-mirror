Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0C91FEB3
	for <e@80x24.org>; Sat,  7 Jan 2017 00:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034419AbdAGAUO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 19:20:14 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36307 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030244AbdAGAUH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 19:20:07 -0500
Received: by mail-pg0-f47.google.com with SMTP id f188so256374609pgc.3
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 16:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LghiFxtFmg2pzrMFttKG2vuR8IWhHzQpPDd2YNWGJ1o=;
        b=a++hhQY46oIygwXZMNF6wCXjOhCPVn00W7XF2k2QiuHE+FSZFGEjL+WLtk3PqdUseD
         27LKGDHTJXJ0JGGjaI8of0ECgJnuj62Lddyuem7lqzPlwAgPVqPiaQM3gwk6dK2cLP9A
         dn1O0BiAcFdvaKZFZC3wKBGpDWhrsqEr6+odfPSY4BSyxEIN13HssXkkLe1gVVRcnCbG
         EFGyzxA8wyBSDAzilu24IVk1TuZWwqcGYaWLSoLJGrdMq8sBDzV+T5udMmEXSSSEHtK0
         w8V+zUF1UlhSbDRrJ4Hcl/TjfxJEPp8t7IQCKxcxTmvk6TBlUoyUo+h3J4SjfcjARFwX
         /w+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LghiFxtFmg2pzrMFttKG2vuR8IWhHzQpPDd2YNWGJ1o=;
        b=tLje2+vHcXB/HmoSlIwG/hSjGO54hxO1EhzEXIg8EXEFVpHsIXS6PnKv0ULdC2VGCd
         jhOMeqsOfR8uRkpY6Nf36x0noMQR/UYfu8QELNble0jZitjnHaV8+EbbXvnmgwMFgezY
         i4fUwzr3oQja/lmvg3wWsaNKF/VZNZXnOsKSi+QC67tfYoJKLHL6rOG5oEUWDu3uSBtc
         T+wf5EvlebH+KuVd7m27HFBaLW46j5WFh65vCJEI2C8mdJAv7BKeeNClN2QZPy/jj5K8
         B0m7Alfo4rxH3ExMV7Y61BPr5uiX6XVQrXqHiPIRW1BhzjHSP2xtEdls7MR1QMGYJUnG
         +MVA==
X-Gm-Message-State: AIkVDXK3/z+E/ho+QJBE0k1B7PMyWsksCz0owh4dRd3GFDxwKO59w+L1uF8rAeOqwxK2jcxp
X-Received: by 10.84.210.233 with SMTP id a96mr171062334pli.72.1483748406564;
        Fri, 06 Jan 2017 16:20:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:adc3:a23:991a:f67c])
        by smtp.gmail.com with ESMTPSA id q23sm114353192pfg.47.2017.01.06.16.20.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Jan 2017 16:20:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     novalis@novalis.org, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule update --init: displays correct path from submodule
Date:   Fri,  6 Jan 2017 16:19:53 -0800
Message-Id: <20170107001953.3196-1-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.30.g7c4be45.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the submodule helper we did not correctly handled the display path
for initializing submodules when both the submodule is inside a
subdirectory as well as the command being invoked from a subdirectory
(as viewed from the superproject).

This was broken in 3604242f080, which was written at a time where
there was no super-prefix available, so we abused the --prefix option
for the same purpose and could get only one case right (the call from
within a subdirectory, not the submodule being in a subdirectory).

Test-provided-by: David Turner <novalis@novalis.org>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

  applies on sb/submodule-embed-gitdir as that contains 89c862655
  (submodule helper: support super prefix)

 builtin/submodule--helper.c | 13 +++++++------
 git-submodule.sh            |  2 +-
 t/t7406-submodule-update.sh | 17 +++++++++++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 242d9911a6..7b3f9fc293 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -305,32 +305,36 @@ static int module_list(int argc, const char **argv, const char *prefix)
 
 		utf8_fprintf(stdout, "%s\n", ce->name);
 	}
 	return 0;
 }
 
 static void init_submodule(const char *path, const char *prefix, int quiet)
 {
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
 	/* Only loads from .gitmodules, no overlay with .git/config */
 	gitmodules_config();
 
-	if (prefix) {
-		strbuf_addf(&sb, "%s%s", prefix, path);
+	if (prefix && get_super_prefix())
+		die("BUG: cannot have prefix and superprefix");
+	else if (prefix)
+		displaypath = xstrdup(relative_path(path, prefix, &sb));
+	else if (get_super_prefix()) {
+		strbuf_addf(&sb, "%s%s", get_super_prefix(), path);
 		displaypath = strbuf_detach(&sb, NULL);
 	} else
 		displaypath = xstrdup(path);
 
 	sub = submodule_from_path(null_sha1, path);
 
 	if (!sub)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
 			displaypath);
 
 	/*
 	 * Copy url setting when it is not set yet.
 	 * To look up the url in .git/config, we must not fall back to
 	 * .gitmodules, so look it up directly.
 	 */
@@ -391,33 +395,30 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	}
 	strbuf_release(&sb);
 	free(displaypath);
 	free(url);
 	free(upd);
 }
 
 static int module_init(int argc, const char **argv, const char *prefix)
 {
 	struct pathspec pathspec;
 	struct module_list list = MODULE_LIST_INIT;
 	int quiet = 0;
 	int i;
 
 	struct option module_init_options[] = {
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("alternative anchor for relative paths")),
 		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
 		OPT_END()
 	};
 
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper init [<path>]"),
 		NULL
 	};
 
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);
 
 	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
 		return 1;
 
@@ -1117,31 +1118,31 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
 	unsigned option;
 };
 
 static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
 	{"name", module_name, 0},
 	{"clone", module_clone, 0},
 	{"update-clone", update_clone, 0},
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
-	{"init", module_init, 0},
+	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	if (argc < 2)
 		die(_("submodule--helper subcommand must be "
 		      "called with a subcommand"));
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		if (!strcmp(argv[1], commands[i].cmd)) {
 			if (get_super_prefix() &&
 			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
diff --git a/git-submodule.sh b/git-submodule.sh
index 9285b5c43d..4e47ff8ad8 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -362,31 +362,31 @@ cmd_init()
 			;;
 		--)
 			shift
 			break
 			;;
 		-*)
 			usage
 			;;
 		*)
 			break
 			;;
 		esac
 		shift
 	done
 
-	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper init ${GIT_QUIET:+--quiet}  "$@"
 }
 
 #
 # Unregister submodules from .git/config and remove their work tree
 #
 cmd_deinit()
 {
 	# parse $args after "submodule ... deinit".
 	deinit_all=
 	while test $# -ne 0
 	do
 		case "$1" in
 		-f|--force)
 			force=$1
 			;;
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 64f322c4cc..725bbed1f8 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -128,30 +128,47 @@ done.
 Cloning into '$pwd/recursivesuper/super/submodule'...
 done.
 EOF
 
 test_expect_success 'submodule update --init --recursive from subdirectory' '
 	git -C recursivesuper/super reset --hard HEAD^ &&
 	(cd recursivesuper &&
 	 mkdir tmp &&
 	 cd tmp &&
 	 git submodule update --init --recursive ../super >../../actual 2>../../actual2
 	) &&
 	test_i18ncmp expect actual &&
 	test_i18ncmp expect2 actual2
 '
 
+cat <<EOF >expect2
+Submodule 'foo/sub' ($pwd/withsubs/../rebasing) registered for path 'sub'
+EOF
+
+test_expect_success 'submodule update --init from and of subdirectory' '
+	git init withsubs &&
+	(cd withsubs &&
+	 mkdir foo &&
+	 git submodule add "$(pwd)/../rebasing" foo/sub &&
+	 (cd foo &&
+	  git submodule deinit -f sub &&
+	  git submodule update --init sub 2>../../actual2
+	 )
+	) &&
+	test_i18ncmp expect2 actual2
+'
+
 apos="'";
 test_expect_success 'submodule update does not fetch already present commits' '
 	(cd submodule &&
 	  echo line3 >> file &&
 	  git add file &&
 	  test_tick &&
 	  git commit -m "upstream line3"
 	) &&
 	(cd super/submodule &&
 	  head=$(git rev-parse --verify HEAD) &&
 	  echo "Submodule path ${apos}submodule$apos: checked out $apos$head$apos" > ../../expected &&
 	  git reset --hard HEAD~1
 	) &&
 	(cd super &&
 	  git submodule update > ../actual 2> ../actual.err
-- 
2.11.0.rc2.30.g7c4be45.dirty

