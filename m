From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv11 5/7] git submodule update: have a dedicated helper for cloning
Date: Fri, 12 Feb 2016 15:34:38 -0800
Message-ID: <1455320080-14648-6-git-send-email-sbeller@google.com>
References: <1455320080-14648-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat Feb 13 00:35:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNF1-0005gz-U8
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbcBLXfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:35:05 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35820 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbcBLXev (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:34:51 -0500
Received: by mail-pf0-f171.google.com with SMTP id c10so55559628pfc.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 15:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=77Vez3hK8iTXEvQnFc1yckW28qDrHJieAZIcusdUBFo=;
        b=VKgegM9fusq06rnydTfYftJf7Dy0NhVs+oFc8ZcCCccIxt6fSrNa/9V2Tye+uLBxPB
         klx+9no5dpXdEF1sr9Cmi16dJLw9pcE0lmqKLIzjL2iUvfNZEmM1nltXfrcpJQBc2P/d
         xcN/U/Ejeso/0OvpKTnvTy7uFArvsNOPI1wJCgtcPM+SQt3MB6MGo9RW8y9npjtZI2/a
         og1ck/MkCISB3TcGcA3yi67CoXP3X2lSyYTS2mhWZJ0fBRHSwXZAgLas42EmgjWMgYsP
         PwfOMR8enO+KB+p+6qC7ZBrOlg8JbOMemyEPpvq8JERnXY7kzCsZsVJRELVZdMbNchWd
         8JiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=77Vez3hK8iTXEvQnFc1yckW28qDrHJieAZIcusdUBFo=;
        b=jia2/CkamBxNjPHj+OCBsirfrYCpnkJsU4CSxi9Qjn6qtX3cFdIUb5nb0s8cW730KV
         yOk2eDYW1TDK59hRo5xSmpfHhIVQPDV60D5r+RvkgoMPgkJpoo8B4KMIOFxyxVJNQSgA
         l0QjMhrGdFgArju2TczPso8CBt1ZHuKZQrs4xhsE/PUaL1FUujBulx0o++2RUl2G82kk
         P4+pi2nNOiXeyYVwMpd32lGmzbiuWJ2IHArEoFXL00f75JCLO1eLcfmpUBUxNIy1ADuW
         lx7AFhWNueq4OrjkPm/oAjiLz2futzuv9UIpJixWQYtwZ4Kk/0n+7X5DLD/K8wSRVTHb
         g1Rg==
X-Gm-Message-State: AG10YOTl5whJIIE3BFzArIySVK7D9ffMMf/fHML6wKcOhCJuGL1WvunSan5BI+XC4IeFiGMl
X-Received: by 10.98.68.73 with SMTP id r70mr6091430pfa.136.1455320091044;
        Fri, 12 Feb 2016 15:34:51 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f1e7:203f:9d1e:8193])
        by smtp.gmail.com with ESMTPSA id wt2sm21841329pac.48.2016.02.12.15.34.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 15:34:50 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
In-Reply-To: <1455320080-14648-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286090>

This introduces a new helper function in git submodule--helper
which takes care of cloning all submodules, which we want to
parallelize eventually.

Some tests (such as empty URL, update_mode=none) are required in the
helper to make the decision for cloning. These checks have been
moved into the C function as well (no need to repeat them in the
shell script).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 231 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  45 +++------
 2 files changed, 242 insertions(+), 34 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..7629a41 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -255,6 +255,236 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct submodule_update_clone {
+	/* states */
+	int count;
+	int print_unmatched;
+	/* configuration */
+	int quiet;
+	const char *reference;
+	const char *depth;
+	const char *recursive_prefix;
+	const char *prefix;
+	struct module_list list;
+	struct string_list projectlines;
+	struct submodule_update_strategy update;
+	struct pathspec pathspec;
+};
+#define SUBMODULE_UPDATE_CLONE_INIT {0, 0, 0, NULL, NULL, NULL, NULL, MODULE_LIST_INIT, STRING_LIST_INIT_DUP, SUBMODULE_UPDATE_STRATEGY_INIT}
+
+static int update_clone_inspect_next_task(struct child_process *cp,
+					  struct strbuf *err,
+					  struct submodule_update_clone *pp,
+					  void **pp_task_cb,
+					  const struct cache_entry *ce)
+{
+	const struct submodule *sub = NULL;
+	struct strbuf displaypath_sb = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	const char *displaypath = NULL;
+	char *url = NULL;
+	int needs_cloning = 0;
+
+	if (ce_stage(ce)) {
+		if (pp->recursive_prefix)
+			strbuf_addf(err, "Skipping unmerged submodule %s/%s\n",
+				    pp->recursive_prefix, ce->name);
+		else
+			strbuf_addf(err, "Skipping unmerged submodule %s\n",
+				    ce->name);
+		goto cleanup;
+	}
+
+	sub = submodule_from_path(null_sha1, ce->name);
+
+	if (pp->recursive_prefix)
+		displaypath = relative_path(pp->recursive_prefix,
+					    ce->name, &displaypath_sb);
+	else
+		displaypath = ce->name;
+
+	if (pp->update.type == SM_UPDATE_NONE ||
+	    (pp->update.type == SM_UPDATE_UNSPECIFIED &&
+	     sub->update_strategy.type == SM_UPDATE_NONE)) {
+		strbuf_addf(err, "Skipping submodule '%s'\n",
+			    displaypath);
+		goto cleanup;
+	}
+
+	/*
+	 * Looking up the url in .git/config.
+	 * We must not fall back to .gitmodules as we only want
+	 * to process configured submodules.
+	 */
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "submodule.%s.url", sub->name);
+	git_config_get_string(sb.buf, &url);
+	if (!url) {
+		/*
+		 * Only mention uninitialized submodules when its
+		 * path have been specified
+		 */
+		if (pp->pathspec.nr)
+			strbuf_addf(err, _("Submodule path '%s' not initialized\n"
+				    "Maybe you want to use 'update --init'?"),
+				    displaypath);
+		goto cleanup;
+	}
+
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/.git", ce->name);
+	needs_cloning = !file_exists(sb.buf);
+
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%06o %s %d %d\t%s\n", ce->ce_mode,
+			sha1_to_hex(ce->sha1), ce_stage(ce),
+			needs_cloning, ce->name);
+	string_list_append(&pp->projectlines, sb.buf);
+
+	if (needs_cloning) {
+		cp->git_cmd = 1;
+		cp->no_stdin = 1;
+		cp->stdout_to_stderr = 1;
+		cp->err = -1;
+		argv_array_push(&cp->args, "submodule--helper");
+		argv_array_push(&cp->args, "clone");
+		if (pp->quiet)
+			argv_array_push(&cp->args, "--quiet");
+
+		if (pp->prefix)
+			argv_array_pushl(&cp->args, "--prefix", pp->prefix, NULL);
+
+		argv_array_pushl(&cp->args, "--path", sub->path, NULL);
+		argv_array_pushl(&cp->args, "--name", sub->name, NULL);
+		argv_array_pushl(&cp->args, "--url", strdup(url), NULL);
+		if (pp->reference)
+			argv_array_push(&cp->args, pp->reference);
+		if (pp->depth)
+			argv_array_push(&cp->args, pp->depth);
+
+
+	}
+
+cleanup:
+	free(url);
+	strbuf_reset(&displaypath_sb);
+	strbuf_reset(&sb);
+
+	return needs_cloning;
+}
+
+static int update_clone_get_next_task(struct child_process *cp,
+				      struct strbuf *err,
+				      void *pp_cb,
+				      void **pp_task_cb)
+{
+	struct submodule_update_clone *pp = pp_cb;
+
+	for (; pp->count < pp->list.nr; pp->count++) {
+		const struct cache_entry *ce = pp->list.entries[pp->count];
+		if (update_clone_inspect_next_task(cp, err, pp,
+						   pp_task_cb, ce)) {
+			pp->count++;
+			return 1;
+		}
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
+	const char *update = NULL;
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
+		OPT_STRING(0, "update", &update,
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
+	if (update)
+		if (parse_submodule_update_strategy(update, &pp.update) < 0)
+			die(_("bad value for update parameter"));
+
+	if (module_list_compute(argc, argv, prefix, &pp.pathspec, &pp.list) < 0) {
+		printf("#unmatched\n");
+		return 1;
+	}
+
+	gitmodules_config();
+	/* Overlay the parsed .gitmodules file with .git/config */
+	git_config(submodule_config, NULL);
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
+	for_each_string_list_item(item, &pp.projectlines)
+		utf8_fprintf(stdout, "%s", item->string);
+
+	return 0;
+}
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -264,6 +494,7 @@ static struct cmd_struct commands[] = {
 	{"list", module_list},
 	{"name", module_name},
 	{"clone", module_clone},
+	{"update-clone", update_clone}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 9ee86d4..9f554fb 100755
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
-			echo >&2 "Skipping submodule '$displaypath'"
-			continue
-		fi
-
-		if test -z "$url"
-		then
-			# Only mention uninitialized submodules when its
-			# path have been specified
-			test "$#" != "0" &&
-			say >&2 "$(eval_gettext "Submodule path '\$displaypath' not initialized
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
-- 
2.7.1.292.g18a4ced.dirty
