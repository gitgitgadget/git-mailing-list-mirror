From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv21 07/10] git submodule update: have a dedicated helper for cloning
Date: Mon, 29 Feb 2016 18:07:17 -0800
Message-ID: <1456798040-30129-8-git-send-email-sbeller@google.com>
References: <1456798040-30129-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, pclouds@gmail.com,
	Jens.Lehmann@web.de, peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 01 03:07:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaZix-0002xr-LI
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 03:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbcCACHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 21:07:41 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33772 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbcCACHh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 21:07:37 -0500
Received: by mail-pa0-f50.google.com with SMTP id fl4so102376222pad.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 18:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GYQZasmvxFv1CZdvik6LnoyqGOy7shOw76rVIWR206Y=;
        b=AZqDaf8VSTei+G6wILTREQorCmvGinocPYSdT78k2zu3/F25zxuL4esU24JM+hUPni
         ZXhkA1FwTSNKoABgUVth99SYalCGaHo5hKrHWEr4bGyXJOej99eUwqyeWuauuTbJtFkk
         s0Mb2QZ+Ce0lPIbJ7RMQjrRVkp4oyRPjttGMQBs5EAnRMsFzxNiE1MFN/2SA3nw2JSR4
         OcYT64bJO7wR4NR3nTuLszRjVKOrbpMzk/MaVuwb727GuYGHGbfCu/0BxzwltzGvQkJE
         CXtb+4CpU97oYAuVebESKDyKNrbldFazyi600Z03ZSeoX30u0ttAoC2BSPxaci997Mvb
         0qMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GYQZasmvxFv1CZdvik6LnoyqGOy7shOw76rVIWR206Y=;
        b=WQJL6qP9eRdMBCcdduz/L0tMcWuAn/Zlw7V27Coow/pX38KOvhK3chgwNKE0l0uBbS
         5YL/3zdxCmrJZcucPWRdCcBXRkftAHrs1ItxHuDZFpukCWA7J3GR8mElnR5/iDnoUYEA
         QQu9PeyfrkUqKdV0eDlv5Sy6FMZzpVHNQuWX4Iwd0NpkMjkLhBl7yNUOVH2U4vEy67QK
         TQFvAmmoDlpFP8iF5HGcNXH9w5SL2pHWga8HHxeSWX0jmvc/m97a7e/GFpbaJEzN2X7n
         izf7Z9k8/XzY8hxWWkZGDIsVHi08CEdiLwrwWqKBRJM2EYGy4aqooqRbnZJky5blRi6t
         LIGQ==
X-Gm-Message-State: AD7BkJI5wtjK1uXRDzvMnjiKbsW0xGKufdhFvIK85TdXvrXLDr3/0EiJZzrciCCDYMv+3VKg
X-Received: by 10.66.228.97 with SMTP id sh1mr26386000pac.77.1456798055093;
        Mon, 29 Feb 2016 18:07:35 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e195:dbe1:d842:476])
        by smtp.gmail.com with ESMTPSA id l14sm40912341pfi.23.2016.02.29.18.07.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Feb 2016 18:07:34 -0800 (PST)
X-Mailer: git-send-email 2.8.0.rc0.1.g68b4e3f
In-Reply-To: <1456798040-30129-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287990>

This introduces a new helper function in git submodule--helper
which takes care of cloning all submodules, which we want to
parallelize eventually.

Some tests (such as empty URL, update_mode=none) are required in the
helper to make the decision for cloning. These checks have been
moved into the C function as well (no need to repeat them in the
shell script).

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 246 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  47 +++------
 2 files changed, 259 insertions(+), 34 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..fd2b168 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -255,6 +255,251 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct submodule_update_clone {
+	/* index into 'list', the list of submodules to look into for cloning */
+	int current;
+	struct module_list list;
+	unsigned warn_if_uninitialized : 1;
+
+	/* update parameter passed via commandline */
+	struct submodule_update_strategy update;
+
+	/* configuration parameters which are passed on to the children */
+	int quiet;
+	const char *reference;
+	const char *depth;
+	const char *recursive_prefix;
+	const char *prefix;
+
+	/* Machine-readable status lines to be consumed by git-submodule.sh */
+	struct string_list projectlines;
+
+	/* If we want to stop as fast as possible and return an error */
+	unsigned quickstop : 1;
+};
+#define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
+	SUBMODULE_UPDATE_STRATEGY_INIT, 0, NULL, NULL, NULL, NULL, \
+	STRING_LIST_INIT_DUP, 0}
+
+/**
+ * Determine whether 'ce' needs to be cloned. If so, prepare the 'child' to
+ * run the clone. Returns 1 if 'ce' needs to be cloned, 0 otherwise.
+ */
+static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
+					   struct child_process *child,
+					   struct submodule_update_clone *suc,
+					   struct strbuf *out)
+{
+	const struct submodule *sub = NULL;
+	struct strbuf displaypath_sb = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	const char *displaypath = NULL;
+	char *url = NULL;
+	int needs_cloning = 0;
+
+	if (ce_stage(ce)) {
+		if (suc->recursive_prefix)
+			strbuf_addf(&sb, "%s/%s", suc->recursive_prefix, ce->name);
+		else
+			strbuf_addf(&sb, "%s", ce->name);
+		strbuf_addf(out, _("Skipping unmerged submodule %s"), sb.buf);
+		strbuf_addch(out, '\n');
+		goto cleanup;
+	}
+
+	sub = submodule_from_path(null_sha1, ce->name);
+
+	if (suc->recursive_prefix)
+		displaypath = relative_path(suc->recursive_prefix,
+					    ce->name, &displaypath_sb);
+	else
+		displaypath = ce->name;
+
+	if (suc->update.type == SM_UPDATE_NONE
+	    || (suc->update.type == SM_UPDATE_UNSPECIFIED
+		&& sub->update_strategy.type == SM_UPDATE_NONE)) {
+		strbuf_addf(out, _("Skipping submodule '%s'"), displaypath);
+		strbuf_addch(out, '\n');
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
+		 * Only mention uninitialized submodules when their
+		 * path have been specified
+		 */
+		if (suc->warn_if_uninitialized) {
+			strbuf_addf(out,
+				_("Submodule path '%s' not initialized"),
+				displaypath);
+			strbuf_addch(out, '\n');
+			strbuf_addstr(out,
+				_("Maybe you want to use 'update --init'?"));
+			strbuf_addch(out, '\n');
+		}
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
+	string_list_append(&suc->projectlines, sb.buf);
+
+	if (!needs_cloning)
+		goto cleanup;
+
+	child->git_cmd = 1;
+	child->no_stdin = 1;
+	child->stdout_to_stderr = 1;
+	child->err = -1;
+	argv_array_push(&child->args, "submodule--helper");
+	argv_array_push(&child->args, "clone");
+	if (suc->quiet)
+		argv_array_push(&child->args, "--quiet");
+	if (suc->prefix)
+		argv_array_pushl(&child->args, "--prefix", suc->prefix, NULL);
+	argv_array_pushl(&child->args, "--path", sub->path, NULL);
+	argv_array_pushl(&child->args, "--name", sub->name, NULL);
+	argv_array_pushl(&child->args, "--url", url, NULL);
+	if (suc->reference)
+		argv_array_push(&child->args, suc->reference);
+	if (suc->depth)
+		argv_array_push(&child->args, suc->depth);
+
+cleanup:
+	free(url);
+	strbuf_reset(&displaypath_sb);
+	strbuf_reset(&sb);
+
+	return needs_cloning;
+}
+
+static int update_clone_get_next_task(struct child_process *child,
+				      struct strbuf *err,
+				      void *suc_cb,
+				      void **void_task_cb)
+{
+	struct submodule_update_clone *suc = suc_cb;
+
+	for (; suc->current < suc->list.nr; suc->current++) {
+		const struct cache_entry *ce = suc->list.entries[suc->current];
+		if (prepare_to_clone_next_submodule(ce, child, suc, err)) {
+			suc->current++;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static int update_clone_start_failure(struct strbuf *err,
+				      void *suc_cb,
+				      void *void_task_cb)
+{
+	struct submodule_update_clone *suc = suc_cb;
+	suc->quickstop = 1;
+	return 1;
+}
+
+static int update_clone_task_finished(int result,
+				      struct strbuf *err,
+				      void *suc_cb,
+				      void *void_task_cb)
+{
+	struct submodule_update_clone *suc = suc_cb;
+
+	if (!result)
+		return 0;
+
+	suc->quickstop = 1;
+	return 1;
+}
+
+static int update_clone(int argc, const char **argv, const char *prefix)
+{
+	const char *update = NULL;
+	struct string_list_item *item;
+	struct pathspec pathspec;
+	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
+
+	struct option module_update_clone_options[] = {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("path into the working tree")),
+		OPT_STRING(0, "recursive-prefix", &suc.recursive_prefix,
+			   N_("path"),
+			   N_("path into the working tree, across nested "
+			      "submodule boundaries")),
+		OPT_STRING(0, "update", &update,
+			   N_("string"),
+			   N_("rebase, merge, checkout or none")),
+		OPT_STRING(0, "reference", &suc.reference, N_("repo"),
+			   N_("reference repository")),
+		OPT_STRING(0, "depth", &suc.depth, "<depth>",
+			   N_("Create a shallow clone truncated to the "
+			      "specified number of revisions")),
+		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper update_clone [--prefix=<path>] [<path>...]"),
+		NULL
+	};
+	suc.prefix = prefix;
+
+	argc = parse_options(argc, argv, prefix, module_update_clone_options,
+			     git_submodule_helper_usage, 0);
+
+	if (update)
+		if (parse_submodule_update_strategy(update, &suc.update) < 0)
+			die(_("bad value for update parameter"));
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
+		return 1;
+
+	if (pathspec.nr)
+		suc.warn_if_uninitialized = 1;
+
+	/* Overlay the parsed .gitmodules file with .git/config */
+	gitmodules_config();
+	git_config(submodule_config, NULL);
+
+	run_processes_parallel(1,
+			       update_clone_get_next_task,
+			       update_clone_start_failure,
+			       update_clone_task_finished,
+			       &suc);
+
+	/*
+	 * We saved the output and put it out all at once now.
+	 * That means:
+	 * - the listener does not have to interleave their (checkout)
+	 *   work with our fetching.  The writes involved in a
+	 *   checkout involve more straightforward sequential I/O.
+	 * - the listener can avoid doing any work if fetching failed.
+	 */
+	if (suc.quickstop)
+		return 1;
+
+	for_each_string_list_item(item, &suc.projectlines)
+		utf8_fprintf(stdout, "%s", item->string);
+
+	return 0;
+}
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -264,6 +509,7 @@ static struct cmd_struct commands[] = {
 	{"list", module_list},
 	{"name", module_name},
 	{"clone", module_clone},
+	{"update-clone", update_clone}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 9ee86d4..a6a82d2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -664,17 +664,20 @@ cmd_update()
 		cmd_init "--" "$@" || return
 	fi
 
-	cloned_modules=
-	git submodule--helper list --prefix "$wt_prefix" "$@" | {
+	{
+	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
+		${wt_prefix:+--prefix "$wt_prefix"} \
+		${prefix:+--recursive-prefix "$prefix"} \
+		${update:+--update "$update"} \
+		${reference:+--reference "$reference"} \
+		${depth:+--depth "$depth"} \
+		"$@" || echo "#unmatched"
+	} | {
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
@@ -691,27 +694,10 @@ cmd_update()
 
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
@@ -751,13 +737,6 @@ Maybe you want to use 'update --init'?")"
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
2.8.0.rc0.1.g68b4e3f
