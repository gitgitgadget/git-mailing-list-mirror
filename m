From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 6/8] git submodule update: have a dedicated helper for cloning
Date: Wed, 28 Oct 2015 16:21:42 -0700
Message-ID: <1446074504-6014-7-git-send-email-sbeller@google.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
 <1446074504-6014-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 00:22:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zra32-00039f-I6
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 00:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480AbbJ1XWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 19:22:22 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34640 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756312AbbJ1XWH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 19:22:07 -0400
Received: by padhk11 with SMTP id hk11so20297561pad.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 16:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=usm4i73Yf8FbgP+HC1jkWNThRhWtvIxgmNupHzqvQDs=;
        b=JU4q6IXrp/nmSbJ88EeIRgPH1PLasxIWlNlazETX4srroG+TDy8r5v7ZDsKdjtntvR
         Qupj2e+Vbs2MSCel94NGBuXg+AiPqW/RPmEWP43DW4CGcRzLrjutKcm3CABzMZ0JNRMv
         +Pm5zQC575255nvhPZd4tpAwCVlagQ02sQSE8jaulbVCTvOfpc28JAHGLAfW64Ff6eFT
         odK/wse4nhh7W1oKPv1oQt+VLVOp5VSNmOOjYBtEF1tLhDZ+cw9e0nwFcA9e2uxmMZXr
         f9K/9zc7iY+Jkk6yykqdfpiG+5DJNv750BpwjLRX2aDWJ+X7RZsQk7GwLWe1EGEchx7m
         3Oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=usm4i73Yf8FbgP+HC1jkWNThRhWtvIxgmNupHzqvQDs=;
        b=ecjijDWNqLF6uwZXvWWVMVIlxZWoD2gccX3Z5+pOnqf8j08o3X0rTwLnTz0B7dLnbd
         MjsBZgHsIFmVdixeG/e4tgHuh7Ul/GMZyPJbooUbkfvXzEBcp95vHKaw44DXq0bopsCC
         07RbEpMZgPL4Y+eBh3ryXxAyKNwVubXHjJly05QlKxiLVv5z1Qzp6iXAnsA1uRtpWa0s
         7GZ6heUeHQT+S0EVBzjBubLRGCKxFog/8hMwpyzYGCjS2aDIs/WfkrfE/k8uwkoH6Zwg
         SRCCavFa+Qd8rXks/5m4gxhnxZf35tlfJBQN3ux00LShaeFkiZYcXEVdBJ2xn//YnLPq
         v4+g==
X-Gm-Message-State: ALoCoQkvu/EXGewwpjSfkSmbq4EkR/RZ7AkXJnJoUCKBZEkdwEHHb2IKvZfG/Ui7IXPFHiwOIscv
X-Received: by 10.66.164.161 with SMTP id yr1mr36705214pab.62.1446074526670;
        Wed, 28 Oct 2015 16:22:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:202f:ecb0:ea3e:b8f7])
        by smtp.gmail.com with ESMTPSA id v13sm47422442pbs.51.2015.10.28.16.22.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Oct 2015 16:22:06 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.281.g4ed9cdb
In-Reply-To: <1446074504-6014-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280429>

This introduces a new helper function in git submodule--helper
which takes care of cloning all submodules, which we want to
parallelize eventually.

Some tests (such as empty URL, update_mode=none) are required in the
helper to make the decision for cloning. These checks have been
moved into the C function as well (no need to repeat them in the
shell script).

As we can only access the stderr channel from within the parallel
processing engine, we need to reroute the error message for
specified but initialized submodules to stderr. As it is an error
message, this should have gone to stderr in the first place, so it
is a bug fix along the way.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 234 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  45 +++------
 t/t7400-submodule-basic.sh  |   4 +-
 3 files changed, 247 insertions(+), 36 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..1ec1b85 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -255,6 +255,239 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static int git_submodule_config(const char *var, const char *value, void *cb)
+{
+	return parse_submodule_config_option(var, value);
+}
+
+struct submodule_update_clone {
+	int count;
+	int quiet;
+	int print_unmatched;
+	char *reference;
+	char *depth;
+	char *update;
+	const char *recursive_prefix;
+	const char *prefix;
+	struct module_list list;
+	struct string_list projectlines;
+	struct pathspec pathspec;
+};
+#define SUBMODULE_UPDATE_CLONE_INIT {0, 0, 0, NULL, NULL, NULL, NULL, NULL, MODULE_LIST_INIT, STRING_LIST_INIT_DUP}
+
+static void fill_clone_command(struct child_process *cp, int quiet,
+			       const char *prefix, const char *path,
+			       const char *name, const char *url,
+			       const char *reference, const char *depth)
+{
+	cp->git_cmd = 1;
+	cp->no_stdin = 1;
+	cp->stdout_to_stderr = 1;
+	cp->err = -1;
+	argv_array_push(&cp->args, "submodule--helper");
+	argv_array_push(&cp->args, "clone");
+	if (quiet)
+		argv_array_push(&cp->args, "--quiet");
+
+	if (prefix) {
+		argv_array_push(&cp->args, "--prefix");
+		argv_array_push(&cp->args, prefix);
+	}
+	argv_array_push(&cp->args, "--path");
+	argv_array_push(&cp->args, path);
+
+	argv_array_push(&cp->args, "--name");
+	argv_array_push(&cp->args, name);
+
+	argv_array_push(&cp->args, "--url");
+	argv_array_push(&cp->args, url);
+	if (reference)
+		argv_array_push(&cp->args, reference);
+	if (depth)
+		argv_array_push(&cp->args, depth);
+}
+
+static int update_clone_get_next_task(void **pp_task_cb,
+				      struct child_process *cp,
+				      struct strbuf *err,
+				      void *pp_cb)
+{
+	struct submodule_update_clone *pp = pp_cb;
+
+	for (; pp->count < pp->list.nr; pp->count++) {
+		const struct submodule *sub = NULL;
+		const char *displaypath = NULL;
+		const struct cache_entry *ce = pp->list.entries[pp->count];
+		struct strbuf sb = STRBUF_INIT;
+		const char *update_module = NULL;
+		char *url = NULL;
+		int just_cloned = 0;
+
+		if (ce_stage(ce)) {
+			if (pp->recursive_prefix)
+				strbuf_addf(err, "Skipping unmerged submodule %s/%s\n",
+					pp->recursive_prefix, ce->name);
+			else
+				strbuf_addf(err, "Skipping unmerged submodule %s\n",
+					ce->name);
+			continue;
+		}
+
+		sub = submodule_from_path(null_sha1, ce->name);
+		if (!sub) {
+			strbuf_addf(err, "BUG: internal error managing submodules. "
+				    "The cache could not locate '%s'", ce->name);
+			pp->print_unmatched = 1;
+			return 0;
+		}
+
+		if (pp->recursive_prefix)
+			displaypath = relative_path(pp->recursive_prefix, ce->name, &sb);
+		else
+			displaypath = ce->name;
+
+		if (pp->update)
+			update_module = pp->update;
+		if (!update_module)
+			update_module = sub->update;
+		if (!update_module)
+			update_module = "checkout";
+		if (!strcmp(update_module, "none")) {
+			strbuf_addf(err, "Skipping submodule '%s'\n", displaypath);
+			continue;
+		}
+
+		/*
+		 * Looking up the url in .git/config.
+		 * We cannot fall back to .gitmodules as we only want to process
+		 * configured submodules. This renders the submodule lookup API
+		 * useless, as it cannot lookup without fallback.
+		 */
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "submodule.%s.url", sub->name);
+		git_config_get_string(sb.buf, &url);
+		if (!url) {
+			/*
+			 * Only mention uninitialized submodules when its
+			 * path have been specified
+			 */
+			if (pp->pathspec.nr)
+				strbuf_addf(err, _("Submodule path '%s' not initialized\n"
+					"Maybe you want to use 'update --init'?"), displaypath);
+			continue;
+		}
+
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s/.git", ce->name);
+		just_cloned = !file_exists(sb.buf);
+
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%06o %s %d %d\t%s\n", ce->ce_mode,
+				sha1_to_hex(ce->sha1), ce_stage(ce),
+				just_cloned, ce->name);
+		string_list_append(&pp->projectlines, sb.buf);
+
+		if (just_cloned) {
+			fill_clone_command(cp, pp->quiet, pp->prefix, ce->name,
+					   sub->name, url, pp->reference, pp->depth);
+			pp->count++;
+			free(url);
+			return 1;
+		} else
+			free(url);
+	}
+	return 0;
+}
+
+static int update_clone_start_failure(struct child_process *cp,
+				      struct strbuf *err,
+				      void *pp_cb,
+				      void *pp_task_cb)
+{
+	struct submodule_update_clone *pp = pp_cb;
+
+	strbuf_addf(err, "error when starting a child process");
+	pp->print_unmatched = 1;
+
+	return 1;
+}
+
+static int update_clone_task_finished(int result,
+				      struct child_process *cp,
+				      struct strbuf *err,
+				      void *pp_cb,
+				      void *pp_task_cb)
+{
+	struct submodule_update_clone *pp = pp_cb;
+
+	if (!result) {
+		return 0;
+	} else {
+		strbuf_addf(err, "error in one child process");
+		pp->print_unmatched = 1;
+		return 1;
+	}
+}
+
+static int update_clone(int argc, const char **argv, const char *prefix)
+{
+	struct string_list_item *item;
+	struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
+
+	struct option module_list_options[] = {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("path into the working tree")),
+		OPT_STRING(0, "recursive_prefix", &pp.recursive_prefix,
+			   N_("path"),
+			   N_("path into the working tree, across nested "
+			      "submodule boundaries")),
+		OPT_STRING(0, "update", &pp.update,
+			   N_("string"),
+			   N_("update command for submodules")),
+		OPT_STRING(0, "reference", &pp.reference, "<repository>",
+			   N_("Use the local reference repository "
+			      "instead of a full clone")),
+		OPT_STRING(0, "depth", &pp.depth, "<depth>",
+			   N_("Create a shallow clone truncated to the "
+			      "specified number of revisions")),
+		OPT__QUIET(&pp.quiet, N_("do't print cloning progress")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
+		NULL
+	};
+	pp.prefix = prefix;
+
+	argc = parse_options(argc, argv, prefix, module_list_options,
+			     git_submodule_helper_usage, 0);
+
+	if (module_list_compute(argc, argv, prefix, &pp.pathspec, &pp.list) < 0) {
+		printf("#unmatched\n");
+		return 1;
+	}
+
+	gitmodules_config();
+	/* Overlay the parsed .gitmodules file with .git/config */
+	git_config(git_submodule_config, NULL);
+	run_processes_parallel(1, update_clone_get_next_task,
+				  update_clone_start_failure,
+				  update_clone_task_finished,
+				  &pp);
+
+	if (pp.print_unmatched) {
+		printf("#unmatched\n");
+		return 1;
+	}
+
+	for_each_string_list_item(item, &pp.projectlines) {
+		utf8_fprintf(stdout, "%s", item->string);
+	}
+	return 0;
+}
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -264,6 +497,7 @@ static struct cmd_struct commands[] = {
 	{"list", module_list},
 	{"name", module_name},
 	{"clone", module_clone},
+	{"update-clone", update_clone}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 9bc5c5f..9f554fb 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -664,17 +664,18 @@ cmd_update()
 		cmd_init "--" "$@" || return
 	fi
 
-	cloned_modules=
-	git submodule--helper list --prefix "$wt_prefix" "$@" | {
+	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
+		${wt_prefix:+--prefix "$wt_prefix"} \
+		${prefix:+--recursive_prefix "$prefix"} \
+		${update:+--update "$update"} \
+		${reference:+--reference "$reference"} \
+		${depth:+--depth "$depth"} \
+		"$@" | {
 	err=
-	while read mode sha1 stage sm_path
+	while read mode sha1 stage just_cloned sm_path
 	do
 		die_if_unmatched "$mode"
-		if test "$stage" = U
-		then
-			echo >&2 "Skipping unmerged submodule $prefix$sm_path"
-			continue
-		fi
+
 		name=$(git submodule--helper name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		branch=$(get_submodule_config "$name" branch master)
@@ -691,27 +692,10 @@ cmd_update()
 
 		displaypath=$(relative_path "$prefix$sm_path")
 
-		if test "$update_module" = "none"
-		then
-			echo "Skipping submodule '$displaypath'"
-			continue
-		fi
-
-		if test -z "$url"
-		then
-			# Only mention uninitialized submodules when its
-			# path have been specified
-			test "$#" != "0" &&
-			say "$(eval_gettext "Submodule path '\$displaypath' not initialized
-Maybe you want to use 'update --init'?")"
-			continue
-		fi
-
-		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
+		if test $just_cloned -eq 1
 		then
-			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
-			cloned_modules="$cloned_modules;$name"
 			subsha1=
+			update_module=checkout
 		else
 			subsha1=$(clear_local_git_env; cd "$sm_path" &&
 				git rev-parse --verify HEAD) ||
@@ -751,13 +735,6 @@ Maybe you want to use 'update --init'?")"
 				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
 			fi
 
-			# Is this something we just cloned?
-			case ";$cloned_modules;" in
-			*";$name;"*)
-				# then there is no local change to integrate
-				update_module=checkout ;;
-			esac
-
 			must_die_on_failure=
 			case "$update_module" in
 			checkout)
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 540771c..5991e3c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -462,7 +462,7 @@ test_expect_success 'update --init' '
 	git config --remove-section submodule.example &&
 	test_must_fail git config submodule.example.url &&
 
-	git submodule update init > update.out &&
+	git submodule update init 2> update.out &&
 	cat update.out &&
 	test_i18ngrep "not initialized" update.out &&
 	test_must_fail git rev-parse --resolve-git-dir init/.git &&
@@ -480,7 +480,7 @@ test_expect_success 'update --init from subdirectory' '
 	mkdir -p sub &&
 	(
 		cd sub &&
-		git submodule update ../init >update.out &&
+		git submodule update ../init 2>update.out &&
 		cat update.out &&
 		test_i18ngrep "not initialized" update.out &&
 		test_must_fail git rev-parse --resolve-git-dir ../init/.git &&
-- 
2.5.0.281.g4ed9cdb
