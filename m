From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv15 3/5] git submodule update: have a dedicated helper for cloning
Date: Tue, 23 Feb 2016 19:20:15 -0800
Message-ID: <1456284017-26141-4-git-send-email-sbeller@google.com>
References: <1456284017-26141-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 24 04:22:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYQ23-0006kB-9L
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 04:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755166AbcBXDW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 22:22:28 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34705 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430AbcBXDWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 22:22:16 -0500
Received: by mail-pf0-f176.google.com with SMTP id x65so4372027pfb.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 19:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/NmB6s8FZh4JYhBr1IJamcHXKfhRNCiqfn1PQlY2K7Q=;
        b=jzrUh6NEZN/Ix3itzc/Doj8Lsyt2DHRwQNS/8QmYT6AP2PGOlyIPv5WBEOwZ9hTtYA
         lXe/cmB+ySojkCGxzLWt+7ZDU7pB12d8oRVQK6kqtTFD2aBgSKQzJVN5+fHvrwAmKPQh
         /6OHXUiXLUOtGuFOxDxfwGTJT8LWuJecsIv4aYC2FH8jT85h5Yvrg3tYjHxHPAhYK7vY
         pdI89mtvAGoHQOe+QTBfbJTihg4LKeQ4MW0sZoZCwhwbjB69coh8/KIrNiXTb/mxCbhk
         XTGlG+1yTQNWQMFCN5Cs3SoZYtgP2xClmcU/V/JrlezEKbjV1MflPTVRJqdNk5vpYvt2
         uITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/NmB6s8FZh4JYhBr1IJamcHXKfhRNCiqfn1PQlY2K7Q=;
        b=cwDlNdTW1tRpnKcMy/hlvWO2oe5wbb/F21R5aaYchJpOfyF/T6on6fQueLCNPEyCqW
         2npF5rryh7yVo8hHHBkaZ3lCvLOPhpEGIfo1IwYY5OdmV6nkL2r39zCD3p9XSAWeH/N5
         lGyQyiGst5WSemAkh6MqWyIdnf0M/+mPsCZZi5sSbkvURou1UIjwHuPywX6Z4MHWLS0V
         B3SU6KK43aawOKmoi3G2lrhGjsQL99iGhXfFjQ4p4VsaQVWqklb+ps1s5Wgc+aMrjFjf
         cx+9kBjmcwLQfcZrgS+7AaRDCgUMkq6K9jIPj6z+/uTtidB3yhUX16BYQUVqXEXPr+p0
         xFpA==
X-Gm-Message-State: AG10YOSdYNqXM5MvF7w9+304aGhadFXz7kNSNi6n8g3+aplB0u6t5CizNlVJIhqV0H3hq2WM
X-Received: by 10.98.32.150 with SMTP id m22mr51044881pfj.27.1456284135334;
        Tue, 23 Feb 2016 19:22:15 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a8b2:5b44:5b58:45af])
        by smtp.gmail.com with ESMTPSA id y15sm747096pfi.16.2016.02.23.19.22.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 Feb 2016 19:22:13 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
In-Reply-To: <1456284017-26141-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287168>

This introduces a new helper function in git submodule--helper
which takes care of cloning all submodules, which we want to
parallelize eventually.

Some tests (such as empty URL, update_mode=none) are required in the
helper to make the decision for cloning. These checks have been
moved into the C function as well (no need to repeat them in the
shell script).

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 243 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  47 +++------
 2 files changed, 256 insertions(+), 34 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..85fb702 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -255,6 +255,248 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+struct submodule_update_clone {
+	/* index into 'list', the list of submodules to look into for cloning */
+	int current;
+	struct module_list list;
+	int warn_if_uninitialized : 1;
+	/* update parameter passed via commandline*/
+	struct submodule_update_strategy update;
+	/* configuration parameters which are passed on to the children */
+	int quiet;
+	const char *reference;
+	const char *depth;
+	const char *recursive_prefix;
+	const char *prefix;
+	/* lines to be output */
+	struct string_list projectlines;
+	/* If we want to stop as fast as possible and return an error */
+	int quickstop : 1;
+};
+#define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
+	SUBMODULE_UPDATE_STRATEGY_INIT, 0, NULL, NULL, NULL, NULL, \
+	STRING_LIST_INIT_DUP, 0}
+
+/**
+ * Inspect if 'ce' needs to be cloned. If so, prepare the 'child' to be running
+ * the clone and return non zero.
+ */
+static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
+					   struct child_process *child,
+					   struct submodule_update_clone *suc,
+					   struct strbuf *err)
+{
+	const struct submodule *sub = NULL;
+	struct strbuf displaypath_sb = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	const char *displaypath = NULL;
+	char *url = NULL;
+	int needs_cloning = 0;
+
+	if (ce_stage(ce)) {
+		if (suc->recursive_prefix) {
+			strbuf_addf(err, "Skipping unmerged submodule %s/%s\n",
+				    suc->recursive_prefix, ce->name);
+		} else {
+			strbuf_addf(err, "Skipping unmerged submodule %s\n",
+				    ce->name);
+		}
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
+		if (suc->warn_if_uninitialized)
+			strbuf_addf(err, _("Submodule path '%s' not initialized\n"
+				    "Maybe you want to use 'update --init'?\n"),
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
+static int update_clone_start_failure(struct child_process *child,
+				      struct strbuf *err,
+				      void *suc_cb,
+				      void *void_task_cb)
+{
+	struct submodule_update_clone *suc = suc_cb;
+
+	default_start_failure(child, err, suc_cb, void_task_cb);
+	suc->quickstop = 1;
+
+	return 1;
+}
+
+static int update_clone_task_finished(int result,
+				      struct child_process *child,
+				      struct strbuf *err,
+				      void *suc_cb,
+				      void *void_task_cb)
+{
+	struct submodule_update_clone *suc = suc_cb;
+
+	if (!result)
+		return 0;
+
+	default_task_finished(result, child, err, suc_cb, void_task_cb);
+	suc->quickstop = 1;
+
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
+	gitmodules_config();
+	/* Overlay the parsed .gitmodules file with .git/config */
+	git_config(submodule_config, NULL);
+	run_processes_parallel(1, update_clone_get_next_task,
+				  update_clone_start_failure,
+				  update_clone_task_finished,
+				  &suc);
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
@@ -264,6 +506,7 @@ static struct cmd_struct commands[] = {
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
2.7.0.rc0.34.ga06e0b3.dirty
