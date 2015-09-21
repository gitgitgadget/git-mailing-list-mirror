From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 13/13] Rewrite submodule update in C
Date: Mon, 21 Sep 2015 15:39:19 -0700
Message-ID: <1442875159-13027-14-git-send-email-sbeller@google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:39:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9kU-0006e0-To
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933060AbbIUWjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 18:39:45 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34457 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933090AbbIUWjl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:39:41 -0400
Received: by padhy16 with SMTP id hy16so128492881pad.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aFSEPf1l8p5lY62aIQnMgNTXFWHNXo1uufP9/RUR2Zg=;
        b=dG7MV+bm70bDShZ4MEanPD6tzMdGqI89q9j6W4LwEudKg9xaF9mNu8NxeCRMtAWoga
         SfE7cnVdRxybEv/rfKjwH2qQv8jy9rYTbvqJM/+AnYfB+kYGCR0h4BIoE2E2IA/TlWaZ
         hWluFcmxCN9xpIdPj74ucdca7IWe9P8RPLJgf/jI18DJJ53PkYNyz44u+oK1OvHCwZ+f
         i8dSvaCBvB7jTBK5ign/EK4xhOfnl7rRVT5obXo1CWOGHufiS/bAzBKczCfYL9WM5zRN
         FjN/FMnemBxkzp0fy/qS1OxHw7OylXK8VxCr1aFStlIxsS1Iehby5XKID5Xfc7Y2zntw
         piZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=aFSEPf1l8p5lY62aIQnMgNTXFWHNXo1uufP9/RUR2Zg=;
        b=dpq28dqNMC5TTDj4iRtmMhYX+cteFgbiZecvWN1w6Omy9JYTJRMDozGtyc12C5kPtK
         Jfzcp5d6pNwLwnh7yZV93tLixDR7Uswhww1LUDVbb93y/Q+SswZxSeumyMlXVqNpRnmf
         Or3AhNMedEFngVigiccbG1iH6SkrCvq9pOan+e2Z4/Vmn/EG+7jExGmb4HOsYsbmvNSO
         1CWIaLYHIQwKMbrvRhmbPTxw8l5ou0eZ8yuZKkfnSJ7z7ltqCLqbu66jYAZG3LISty4o
         uP2hLsPCORr2El3emjT9xE2aSQ4tUnRfHYz7IvRMV7SYNWqjOZgVissOaiuzNmtqk8zv
         gZQg==
X-Gm-Message-State: ALoCoQmbSpv8o/MrxqawL72I//pjJhtoVD+L9GV4rc0j1opbWJZ6FhHtbSu+fEIx8/QaCPc2pg1/
X-Received: by 10.68.69.108 with SMTP id d12mr27170171pbu.137.1442875180945;
        Mon, 21 Sep 2015 15:39:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:a032:5a54:ea65:75ca])
        by smtp.gmail.com with ESMTPSA id y5sm10682992pbt.77.2015.09.21.15.39.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 21 Sep 2015 15:39:40 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.ge015d2a
In-Reply-To: <1442875159-13027-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278346>

This will make parallelisation easier in a followup patch. This is just
a translation from shell to C, hopefully not introducing any bugs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 247 ++++++++++++++++++++++++++++++++++++=
++++++++
 git-submodule.sh            | 135 +-----------------------
 run-command.h               |   2 +
 3 files changed, 252 insertions(+), 132 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f4c3eff..baa7563 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -255,6 +255,252 @@ static int module_clone(int argc, const char **ar=
gv, const char *prefix)
 	return 0;
 }
=20
+struct module_update_data {
+	struct module_list list;
+	int count;
+
+	struct pathspec pathspec;
+
+	int no_fetch;
+	int force;
+	int update;
+	int quiet;
+	int recursive;
+	int remote;
+	char *prefix;
+	char *reference;
+	char *depth;
+
+	struct argv_array args;
+
+	int result;
+};
+
+static void module_update_data_init(struct module_update_data *mud)
+{
+	mud->list.entries =3D NULL;
+	mud->list.alloc =3D 0;
+	mud->list.nr =3D 0;
+
+	memset(&mud->pathspec, 0, sizeof(mud->pathspec));
+
+	mud->count =3D 0;
+	mud->no_fetch =3D 0;
+	mud->force =3D 0;
+	mud->update =3D 0;
+	mud->quiet =3D 0;
+	mud->remote =3D 0;
+	mud->recursive =3D 0;
+	mud->result =3D 0;
+
+	mud->prefix =3D NULL;
+	mud->reference =3D NULL;
+	mud->depth =3D NULL;
+
+	argv_array_init(&mud->args);
+}
+
+static int update_next_task(void *data,
+		     struct child_process *cp,
+		     struct strbuf *err)
+{
+	int i;
+	struct module_update_data *mud =3D data;
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *displaypath;
+
+	for (; mud->count < mud->list.nr; mud->count++) {
+		const char *update_module;
+		const char *sm_gitdir;
+		const struct submodule *sub;
+		const struct cache_entry *ce =3D mud->list.entries[mud->count];
+
+		displaypath =3D relative_path(ce->name, mud->prefix, &sb);
+		strbuf_reset(&sb);
+
+		if (ce_stage(ce)) {
+			strbuf_addf(err, "Skipping unmerged submodule %s",
+				    displaypath);
+			continue;
+		}
+
+		sub =3D submodule_from_path(null_sha1, ce->name);
+		if (!sub) {
+			mud->result =3D 1;
+			return 0;
+		}
+
+		switch (mud->update) {
+		case 'r':
+			update_module =3D "rebase";
+			break;
+		case 'c':
+			update_module =3D "checkout";
+			break;
+		case 'm':
+			update_module =3D "merge";
+			break;
+		case 0:
+			/* not specified by command line */
+			if (sub->update)
+				update_module =3D sub->update;
+			else
+				update_module =3D "checkout";
+			break;
+		default:
+			die("BUG: update mode not covered");
+		}
+
+		if (!strcmp(update_module, "none")) {
+			strbuf_addf(err, "Skipping submodule '%s'", displaypath);
+			continue;
+		}
+
+		if (!sub->url) {
+			/*
+			 * Only mention uninitialized submodules when its
+			 * path have been specified
+			 */
+			if (!mud->pathspec.nr)
+				continue;
+
+			strbuf_addf(err,
+				    _("Submodule path '%s' not initialized \n"
+				    "Maybe you want to use 'update --init'?"),
+				    displaypath);
+			continue;
+		}
+
+		strbuf_addf(&sb, "%s/.git", ce->name);
+		sm_gitdir =3D strbuf_detach(&sb, NULL);
+
+		child_process_init(cp);
+		for (i =3D 0; local_repo_env[i]; i++)
+			argv_array_pushf(&cp->env_array, "%s", local_repo_env[i]);
+
+		argv_array_pushf(&cp->env_array, "displaypath=3D%s", displaypath);
+		argv_array_pushf(&cp->env_array, "sm_path=3D%s", sub->path);
+		argv_array_pushf(&cp->env_array, "name=3D%s", sub->name);
+		argv_array_pushf(&cp->env_array, "url=3D%s", sub->url);
+		argv_array_pushf(&cp->env_array, "update_module=3D%s", update_module=
);
+
+		cp->git_cmd =3D 1;
+		cp->stdout_to_stderr =3D 1;
+		argv_array_push(&cp->args, "submodule");
+		if (!file_exists(sm_gitdir))
+			argv_array_push(&cp->args, "update_clone");
+		else
+			argv_array_push(&cp->args, "update_fetch");
+
+		argv_array_pushf(&cp->args, "%s", ce->name);
+		mud->count++;
+		return 1;
+	}
+	return 0;
+}
+
+void update_subcommand_failure(void *data,
+			       struct child_process *cp,
+			       struct strbuf *err)
+{
+	struct module_update_data *mud =3D data;
+	strbuf_addf(err, _("Could not start child process"));
+	mud->result =3D 1;
+}
+
+void update_child_return(void *data,
+			 struct child_process *cp,
+			 int result)
+{
+	struct module_update_data *mud =3D data;
+	mud->result =3D 1;
+}
+
+static int module_update(int argc, const char **argv, const char *pref=
ix)
+{
+	int init;
+	struct module_update_data mud;
+
+	struct option module_list_options[] =3D {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("alternative anchor for relative paths")),
+		OPT_BOOL('i', "init", &init,
+			N_("Initialize the submodule if not yet done")),
+		OPT_BOOL(0, "remote", &mud.remote,
+			N_("Update the submodule to the remote branch instead "
+			   "of the superprojects specification")),
+		OPT_BOOL('N', "no-fetch", &mud.no_fetch,
+			N_("Don=E2=80=99t fetch new objects from the remote site.")),
+		OPT_BOOL('f', "force", &mud.force,
+			N_("Ignore local changes in submodules")),
+		OPT_CMDMODE('r', "rebase", &mud.update,
+			N_("Rebase local changes in submodules"), 'r'),
+		OPT_CMDMODE('m', "merge", &mud.update,
+			N_("Merge local changes in submodules"), 'm'),
+		OPT_CMDMODE(0, "checkout", &mud.update,
+			N_("Checkout to a detached HEAD in submodules"), 'c'),
+		OPT_BOOL(0, "recursive", &mud.recursive,
+			N_("Update nested submodules")),
+		OPT_STRING(0, "reference", &mud.reference, "<repository>",
+			N_("Use the local reference repository "
+			   "instead of a full clone")),
+		OPT_STRING(0, "depth", &mud.depth, "<depth>",
+			N_("Create a shallow clone truncated to the "
+			   "specified number of revisions")),
+		OPT__QUIET(&mud.quiet, N_("be quiet")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] =3D {
+		N_("git submodule--helper list [--prefix=3D<path>] [<path>...]"),
+		NULL
+	};
+
+	module_update_data_init(&mud);
+	gitmodules_config();
+
+	argc =3D parse_options(argc, argv, prefix, module_list_options,
+			     git_submodule_helper_usage, 0);
+
+	if (mud.force)
+		argv_array_push(&mud.args, "force=3D1");
+	if (mud.quiet)
+		argv_array_push(&mud.args, "GIT_QUIET=3D1");
+	if (mud.recursive)
+		argv_array_push(&mud.args, "recursive=3D1");
+	if (mud.prefix)
+		argv_array_pushf(&mud.args, "prefix=3D%s", mud.prefix);
+	if (mud.reference)
+		argv_array_pushf(&mud.args, "reference=3D%s", mud.reference);
+	if (mud.depth)
+		argv_array_pushf(&mud.args, "depth=3D%s", mud.depth);
+
+	if (module_list_compute(argc, argv, prefix, &mud.pathspec, &mud.list)=
 < 0)
+		return 1;
+
+	if (init) {
+		const char **argv_init =3D xmalloc((2 + mud.list.nr) * sizeof(char*)=
);
+		int argc =3D 0, i, code;
+		argv_init[argc++] =3D "submodule";
+		argv_init[argc++] =3D "init";
+
+		for (i =3D 0; i < mud.list.nr; i++) {
+			const struct cache_entry *ce =3D mud.list.entries[i];
+			argv_init[argc++] =3D ce->name;
+		}
+		code =3D run_command_v_opt(argv_init, RUN_GIT_CMD);
+			if (code)
+				return code;
+	}
+
+	run_processes_parallel(1, &mud,
+			       update_next_task,
+			       update_subcommand_failure,
+			       update_child_return);
+	return 0;
+}
+
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
@@ -264,6 +510,7 @@ static struct cmd_struct commands[] =3D {
 	{"list", module_list},
 	{"name", module_name},
 	{"clone", module_clone},
+	{"update", module_update}
 };
=20
 int cmd_submodule__helper(int argc, const char **argv, const char *pre=
fix)
diff --git a/git-submodule.sh b/git-submodule.sh
index a1bc8d5..63e9b3b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -640,6 +640,7 @@ cmd_update_fetch()
 			die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'"=
)"
 		fi
 		remote_name=3D$(clear_local_git_env; cd "$sm_path" && get_default_re=
mote)
+		branch=3D$(get_submodule_config "$name" branch master)
 		sha1=3D$(clear_local_git_env; cd "$sm_path" &&
 			git rev-parse --verify "${remote_name}/${branch}") ||
 		die "$(eval_gettext "Unable to find current ${remote_name}/${branch}=
 revision in submodule path '\$sm_path'")"
@@ -715,137 +716,7 @@ cmd_update_fetch()
 #
 cmd_update()
 {
-	# parse $args after "submodule ... update".
-	while test $# -ne 0
-	do
-		case "$1" in
-		-q|--quiet)
-			GIT_QUIET=3D1
-			;;
-		-i|--init)
-			init=3D1
-			;;
-		--remote)
-			remote=3D1
-			;;
-		-N|--no-fetch)
-			nofetch=3D1
-			;;
-		-f|--force)
-			force=3D$1
-			;;
-		-r|--rebase)
-			update=3D"rebase"
-			;;
-		--reference)
-			case "$2" in '') usage ;; esac
-			reference=3D"--reference=3D$2"
-			shift
-			;;
-		--reference=3D*)
-			reference=3D"$1"
-			;;
-		-m|--merge)
-			update=3D"merge"
-			;;
-		--recursive)
-			recursive=3D1
-			;;
-		--checkout)
-			update=3D"checkout"
-			;;
-		--depth)
-			case "$2" in '') usage ;; esac
-			depth=3D"--depth=3D$2"
-			shift
-			;;
-		--depth=3D*)
-			depth=3D$1
-			;;
-		--)
-			shift
-			break
-			;;
-		-*)
-			usage
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	if test -n "$init"
-	then
-		cmd_init "--" "$@" || return
-	fi
-
-	git submodule--helper list --prefix "$wt_prefix" "$@" | {
-	err=3D
-	while read mode sha1 stage sm_path
-	do
-		die_if_unmatched "$mode"
-		if test "$stage" =3D U
-		then
-			echo >&2 "Skipping unmerged submodule $prefix$sm_path"
-			continue
-		fi
-		name=3D$(git submodule--helper name "$sm_path") || exit
-		url=3D$(git config submodule."$name".url)
-		branch=3D$(get_submodule_config "$name" branch master)
-		if ! test -z "$update"
-		then
-			update_module=3D$update
-		else
-			update_module=3D$(git config submodule."$name".update)
-			if test -z "$update_module"
-			then
-				update_module=3D"checkout"
-			fi
-		fi
-
-		displaypath=3D$(relative_path "$prefix$sm_path")
-
-		if test "$update_module" =3D "none"
-		then
-			echo "Skipping submodule '$displaypath'"
-			continue
-		fi
-
-		if test -z "$url"
-		then
-			# Only mention uninitialized submodules when its
-			# path have been specified
-			test "$#" !=3D "0" &&
-			say "$(eval_gettext "Submodule path '\$displaypath' not initialized
-Maybe you want to use 'update --init'?")"
-			continue
-		fi
-
-		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
-		then
-			cmd_update_clone
-		else
-			cmd_update_fetch
-		fi
-	done
-
-	if test -n "$err"
-	then
-		OIFS=3D$IFS
-		IFS=3D';'
-		for e in $err
-		do
-			if test -n "$e"
-			then
-				echo >&2 "$e"
-			fi
-		done
-		IFS=3D$OIFS
-		exit 1
-	fi
-	}
+	git submodule--helper update ${prefix:+--prefix "$prefix"} "$@"
 }
=20
 set_name_rev () {
@@ -1243,7 +1114,7 @@ cmd_sync()
 while test $# !=3D 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | deinit | update | status | summary | sync)
+	add | foreach | init | deinit | update | update_fetch | update_clone =
| status | summary | sync)
 		command=3D$1
 		;;
 	-q|--quiet)
diff --git a/run-command.h b/run-command.h
index 3807fd1..0c1b363 100644
--- a/run-command.h
+++ b/run-command.h
@@ -155,4 +155,6 @@ int run_processes_parallel(int n, void *data,
 			   start_failure_fn,
 			   return_value_fn);
=20
+void run_processes_parallel_schedule_error(struct strbuf *err);
+
 #endif
--=20
2.5.0.275.ge015d2a
