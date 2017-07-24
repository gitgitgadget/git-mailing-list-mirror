Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F1F203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbdGXUfc (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:35:32 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38634 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754352AbdGXUfa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:35:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id c23so11301690pfe.5
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a8UD636F9YErC6Z4kotmz5nQXTRoj7sywcuP/ZJml0E=;
        b=Z9Et3X87Ho9fkBai8sW3FcImwB9qBP1oXoBeyfnhccxKCiXhTq3rmAhhPorWUEUKVh
         CJRFaFgpd1iQ/eLFP+t5DpMFu28OqcyVkJimoKxcE6qrauQbDtAGoSxJ/+hCxQI3aa73
         V4JmKyOV5vXs16ktkjHno5g4HScdKFtd/9fHGEaHI2xHOLhkzKBtyFYwJeheKZvxKvwW
         qzDhEvpMzHmPquQTDcQuVsBq9MvVLkRX27xHWDmwB5vHdyiODNG4Jpqyl6ZieztzJLF1
         sOZf//y9m37KjTC9Cm6ZsPJcgGMywBrTO7OsS5jiOzVdOljRe6PQTxhagRB9NgKvx43r
         hsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a8UD636F9YErC6Z4kotmz5nQXTRoj7sywcuP/ZJml0E=;
        b=gJipEaME1TJk1fljTKRBferrobbPkdCkoJpOSIO2yRaX0/OvazKri1CbeF6x3NLWHj
         wmfxzS401n06YpC5h3Tb2YnHnFqfjhQfVqIFPY9Gzc+t4TZ/DXBsFlleqaEH3GlRTrxZ
         TNbvUHv87ES+SDTqwyMOl5F/BYHqvljlp0YWsCugIxwB+FraYG55iFEr4TljtjjcrulC
         70s41jh065rFZzxrKZzG+K/5R9eKjogmNXTN02X33Of04U5QmXHsslYwqtpFZ+17I/h5
         8f6r5oVKx8bSTR2u0u+4OwLJ5m0RPM6gKLm/lGK4DBySyfEuna9hAMb+dGMAqdrdxDRs
         FOZA==
X-Gm-Message-State: AIVw111ctwrMTS+ETdD1P2MTXjSXilNQ4HXZWYJrNF3aRhvA++G5hd1X
        kdSS+ZzxSvIu5HTDurw=
X-Received: by 10.99.119.139 with SMTP id s133mr16846182pgc.256.1500928529907;
        Mon, 24 Jul 2017 13:35:29 -0700 (PDT)
Received: from localhost.localdomain ([47.11.10.170])
        by smtp.gmail.com with ESMTPSA id d19sm24313984pfe.24.2017.07.24.13.35.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 13:35:29 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 04/13] submodule: port submodule subcommand 'status' from shell to C
Date:   Tue, 25 Jul 2017 02:04:45 +0530
Message-Id: <20170724203454.13947-5-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170724203454.13947-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aims to make git-submodule 'status' a built-in. Hence, the function
cmd_status() is ported from shell to C. This is done by introducing
three functions: module_status(), submodule_status() and print_status().

The function module_status() acts as the front-end of the subcommand.
It parses subcommand's options and then calls the function
module_list_compute() for computing the list of submodules. Then
this functions calls for_each_submodule_list() looping through the
list obtained.

Then for_each_submodule_list() calls submodule_status() for each of the
submodule in its list. The function submodule_status() is responsible
for generating the status each submodule it is called for, and
then calls print_status().

Finally, the function print_status() handles the printing of submodule's
status.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
In this new version of patch, following changes were made:
* instead of using the ce_match_stat(), cmd_diff_files is used.
* currently, no comment about future scope of optimization wrt the
  cmd_diff_files() usage was added as currently, I'm not fully sure of
  the way to optimize the function.

 builtin/submodule--helper.c | 151 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  49 +-------------
 2 files changed, 152 insertions(+), 48 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 80f744407..b39828174 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -560,6 +560,156 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct status_cb {
+	const char *prefix;
+	unsigned int quiet: 1;
+	unsigned int recursive: 1;
+	unsigned int cached: 1;
+};
+#define STATUS_CB_INIT { NULL, 0, 0, 0 }
+
+static void print_status(struct status_cb *info, char state, const char *path,
+			 char *sub_sha1, char *displaypath)
+{
+	if (info->quiet)
+		return;
+
+	printf("%c%s %s", state, sub_sha1, displaypath);
+
+	if (state == ' ' || state == '+') {
+		struct argv_array name_rev_args = ARGV_ARRAY_INIT;
+
+		argv_array_pushl(&name_rev_args, "print-name-rev",
+				 path, sub_sha1, NULL);
+		print_name_rev(name_rev_args.argc, name_rev_args.argv,
+			       info->prefix);
+	} else {
+		printf("\n");
+	}
+}
+
+static int handle_submodule_head_ref(const char *refname,
+				     const struct object_id *oid, int flags,
+				     void *cb_data)
+{
+	struct strbuf *output = cb_data;
+	if (oid)
+		strbuf_addstr(output, oid_to_hex(oid));
+	return 0;
+}
+
+static void status_submodule(const struct cache_entry *list_item, void *cb_data)
+{
+	struct status_cb *info = cb_data;
+	char *sub_sha1 = xstrdup(oid_to_hex(&list_item->oid));
+	char *displaypath;
+	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
+
+	if (!submodule_from_path(null_sha1, list_item->name))
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
+		      list_item->name);
+
+	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
+
+	if (list_item->ce_flags) {
+		print_status(info, 'U', list_item->name,
+			     sha1_to_hex(null_sha1), displaypath);
+		goto cleanup;
+	}
+
+	if (!is_submodule_active(the_repository, list_item->name)) {
+		print_status(info, '-', list_item->name, sub_sha1, displaypath);
+		goto cleanup;
+	}
+
+	argv_array_pushl(&diff_files_args, "diff-files",
+			 "--ignore-submodules=dirty", "--quiet", "--",
+			 list_item->name, NULL);
+
+	if (!cmd_diff_files(diff_files_args.argc, diff_files_args.argv,
+			    info->prefix)) {
+		print_status(info, ' ', list_item->name, sub_sha1, displaypath);
+	} else {
+		if (!info->cached) {
+			struct strbuf sb = STRBUF_INIT;
+			if (head_ref_submodule(list_item->name,
+					       handle_submodule_head_ref, &sb))
+				die(_("could not resolve HEAD ref inside the"
+				      "submodule '%s'"), list_item->name);
+			print_status(info, '+', list_item->name, sb.buf,
+				     displaypath);
+			strbuf_release(&sb);
+		} else {
+			print_status(info, '+', list_item->name, sub_sha1,
+				     displaypath);
+		}
+	}
+
+	if (info->recursive) {
+		struct child_process cpr = CHILD_PROCESS_INIT;
+
+		cpr.git_cmd = 1;
+		cpr.dir = list_item->name;
+		prepare_submodule_repo_env(&cpr.env_array);
+
+		argv_array_pushl(&cpr.args, "--super-prefix", displaypath,
+				 "submodule--helper", "status", "--recursive",
+				 NULL);
+
+		if (info->cached)
+			argv_array_push(&cpr.args, "--cached");
+
+		if (info->quiet)
+			argv_array_push(&cpr.args, "--quiet");
+
+		if (run_command(&cpr))
+			die(_("failed to recurse into submodule '%s'"),
+			      list_item->name);
+	}
+
+cleanup:
+	free(displaypath);
+	free(sub_sha1);
+}
+
+static int module_status(int argc, const char **argv, const char *prefix)
+{
+	struct status_cb info = STATUS_CB_INIT;
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	int quiet = 0;
+	int cached = 0;
+	int recursive = 0;
+
+	struct option module_status_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress submodule status output")),
+		OPT_BOOL(0, "cached", &cached, N_("Use commit stored in the index instead of the one stored in the submodule HEAD")),
+		OPT_BOOL(0, "recursive", &recursive, N_("Recurse into nested submodules")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_status_options,
+			     git_submodule_helper_usage, 0);
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		return 1;
+
+	info.prefix = prefix;
+	info.quiet = !!quiet;
+	info.recursive = !!recursive;
+	info.cached = !!cached;
+
+	gitmodules_config();
+	for_each_submodule_list(list, status_submodule, &info);
+
+	return 0;
+}
+
 static int module_name(int argc, const char **argv, const char *prefix)
 {
 	const struct submodule *sub;
@@ -1306,6 +1456,7 @@ static struct cmd_struct commands[] = {
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
 	{"print-name-rev", print_name_rev, 0},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
+	{"status", module_status, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"push-check", push_check, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index e988167e0..51b057d82 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1005,54 +1005,7 @@ cmd_status()
 		shift
 	done
 
-	{
-		git submodule--helper list --prefix "$wt_prefix" "$@" ||
-		echo "#unmatched" $?
-	} |
-	while read -r mode sha1 stage sm_path
-	do
-		die_if_unmatched "$mode" "$sha1"
-		name=$(git submodule--helper name "$sm_path") || exit
-		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-		if test "$stage" = U
-		then
-			say "U$sha1 $displaypath"
-			continue
-		fi
-		if ! git submodule--helper is-active "$sm_path" ||
-		{
-			! test -d "$sm_path"/.git &&
-			! test -f "$sm_path"/.git
-		}
-		then
-			say "-$sha1 $displaypath"
-			continue;
-		fi
-		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
-		then
-			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
-			say " $sha1 $displaypath$revname"
-		else
-			if test -z "$cached"
-			then
-				sha1=$(sanitize_submodule_env; cd "$sm_path" && git rev-parse --verify HEAD)
-			fi
-			revname=$(git submodule--helper print-name-rev "$sm_path" "$sha1")
-			say "+$sha1 $displaypath$revname"
-		fi
-
-		if test -n "$recursive"
-		then
-			(
-				prefix="$displaypath/"
-				sanitize_submodule_env
-				wt_prefix=
-				cd "$sm_path" &&
-				eval cmd_status
-			) ||
-			die "$(eval_gettext "Failed to recurse into submodule path '\$sm_path'")"
-		fi
-	done
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} "$@"
 }
 #
 # Sync remote urls for submodules
-- 
2.13.0

