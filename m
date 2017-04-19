Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85B201FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 17:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967882AbdDSRGc (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 13:06:32 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34533 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967206AbdDSRFp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 13:05:45 -0400
Received: by mail-io0-f194.google.com with SMTP id h41so5241851ioi.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 10:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/A6i6kIotEgyDPq0xumeTy4lnaM7JfdzqlG+xoB8eCo=;
        b=t6vxaPOdIcHsfAvZAZxdlVJGrPIitBLh/N1OU6bNaY1/8ccYs0BDzvpK2OcGVgsWsm
         LIw8+WPOj9FVR9mx0QYS6wqtGahqAHLMYObPllZZXbY9dfbNuwVvGn3fMPlRZ8P4oUFc
         ih33lOP/+VTV4iamU6GotsjDfWJR+CgpPuWSKSFQwqssFkPknlDbGuajYpZD0EkYZBHX
         oaFVRXg9N+siDwGEnON2EbM6jCyxnqy1/wb4VZ3TSEt/u7u3qIZPqERM2oMZkjSAKXpb
         /3sIq+m+fug77F2nrBBCRO++XgYGqO7fS2OUhRmaaBFu7ykw1fEoDOgvQwF6TIYuVTcU
         LPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/A6i6kIotEgyDPq0xumeTy4lnaM7JfdzqlG+xoB8eCo=;
        b=jvB1kPy7KbyTxUemJikDgS0Pdrl6YychTs3gZEBdeGUUxRpvJT01uV94yD2O9YP4tx
         ps88C8vLv2UuOpOTa+DuUJoRFnudXRFy/7D832yS3//fLspCYLmYzAtGsUerOwKkRWFL
         0vQASsFRqJBxbYYN75VkotfjhfJXyz40difq92qxmmlP1JFZrBUFMf3YzL9ZJPu2Ajej
         1/ossDRYHZDaquFeCxwNyHWqLTkrteyl7+6D8LrOwTpZ6nrtdj4gFWdbMFvNIkUzyNpM
         R3aLE/Rpx2SMItY6qUaF+vHu33gXdfEkLnKxLlgkgdgHFVqehBhhFUGjmKSuYBjTCS19
         1D5A==
X-Gm-Message-State: AN3rC/6Id7Ba0lrM85FRaBxuNp/CoQ9fYKuoooXfrOHxXVSmPknZgkTc
        fLCSvJonu+2mjjxDw7A=
X-Received: by 10.84.215.143 with SMTP id l15mr5036252pli.31.1492621544509;
        Wed, 19 Apr 2017 10:05:44 -0700 (PDT)
Received: from localhost.localdomain ([47.11.13.219])
        by smtp.gmail.com with ESMTPSA id b8sm5668207pgn.51.2017.04.19.10.05.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Apr 2017 10:05:44 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][RFC/PATCH] submodule: port subcommand foreach from shell to C
Date:   Wed, 19 Apr 2017 22:35:13 +0530
Message-Id: <20170419170513.16475-1-pc44800@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This aims to make git-submodule foreach a builtin. This is the very
first step taken in this direction. Hence, 'foreach' is ported to
submodule--helper, and submodule--helper is called from git-submodule.sh.
The code is split up to have one function to obtain all the list of
submodules and a calling function that takes care of running the command
in that submodule, and recursively perform the same when --recursive is
flagged.

The First function module_foreach first parses the options present in
argv, and then with the help of read_cache, generates the list of
submodules present in the current working tree. Traversing through the
list, foreach_submodule function is called for each entry.

The second function foreach_submodule, generates a submodule struct sub
for $name, $path values and then later prepends name=sub->name;
path=sub-> path; and other value assignment to an argv_array structure.
Also the <command> of submodule-foreach is appended to this structure
and finally, using run_command_v_opt the commands are executed in a
single but separate shell.

The second function also takes care of the recursive flag, by creating
a saperate argv_array structure and prepending "--super-prefix displaypath",
and other required arguments to the structure and then appending the
input <command> of submodule-foreach to the argument's array.


Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---

The build report of this patch is available at: 
https://travis-ci.org/pratham-pc/git/builds/223573936

Clearly, there are still some tests which are failing. I have
submitted this as RFC patch for getting suggestions on debugging these
errors and for reviewing the approach taken for porting submodule
'foreach' subcommand to C.

Also, I have based my branch on gitster/jk/ls-files-recurse-submodules-fix,
since while using --super-prefix in recursively calling the foreach
command, it produced results indicating that a --super-prefix can't
be used from a subdirectory:

  fatal: can't use --super-prefix from a subdirectory

The patch and the discussion related to it can be found at: 
https://public-inbox.org/git/20170412003911.1142-1-jacob.e.keller@intel.com/T/#u

Also, I would like to ask is there are any more changes required in my microproject for getting it merged.
https://public-inbox.org/git/20170403213557.27724-1-pc44800@gmail.com/


 builtin/submodule--helper.c | 153 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  40 +-----------
 2 files changed, 154 insertions(+), 39 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 85aafe46a..276ed6025 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -487,6 +487,158 @@ static int module_name(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static void foreach_submodule(int argc, const char **argv, const char *path,
+			      const unsigned char *sha1, const char *prefix,
+			      int quiet, int recursive)
+{
+	const char *toplevel = xgetcwd();
+	const struct submodule *sub;
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf sub_sha1 = STRBUF_INIT;
+	struct strbuf cmd = STRBUF_INIT;
+	char *displaypath;
+	int i;
+
+	/* Only loads from .gitmodules, no overlay with .git/config */
+	gitmodules_config();
+
+	if (prefix && get_super_prefix()) {
+		die("BUG: cannot have prefix and superprefix");
+	} else if (prefix) {
+		displaypath = xstrdup(relative_path(prefix, path,  &sb));
+	} else if (get_super_prefix()) {
+		strbuf_addf(&sb, "%s/%s", get_super_prefix(), path);
+		displaypath = strbuf_detach(&sb, NULL);
+	} else {
+		displaypath = xstrdup(path);
+	}
+
+	sub = submodule_from_path(null_sha1, path);
+
+	if (!sub)
+		die(_("No url found for submodule path '%s' in .gitmodules"),
+		      displaypath);
+	strbuf_add_unique_abbrev(&sub_sha1, sha1 , 40);
+
+	if (!chdir(path)) {
+		if (!access_or_warn(".git", R_OK, 0)) {
+			if (!quiet)
+				printf(_("Entering '%s'\n"), displaypath);
+
+			if (argc == 1) {
+				struct argv_array argcp1 = ARGV_ARRAY_INIT;
+
+				strbuf_addstr(&cmd, "name=");
+				strbuf_addstr(&cmd, sub->name);
+				strbuf_addstr(&cmd, "; ");
+				strbuf_addstr(&cmd, "toplevel=");
+				strbuf_addstr(&cmd, toplevel);
+				strbuf_addstr(&cmd, "; ");
+				strbuf_addstr(&cmd, "sha1=");
+				strbuf_addstr(&cmd, sub_sha1.buf);
+				strbuf_addstr(&cmd, "; ");
+				strbuf_addstr(&cmd, "path=");
+				strbuf_addstr(&cmd, sub->path);
+				strbuf_addstr(&cmd, "; ");
+				strbuf_addstr(&cmd, argv[0]);
+
+				argv_array_push(&argcp1, cmd.buf);
+				run_command_v_opt(argcp1.argv, RUN_USING_SHELL);
+			} else {
+				run_command_v_opt(argv, RUN_USING_SHELL);
+			}
+
+			if (recursive) {
+				struct argv_array argcp = ARGV_ARRAY_INIT;
+
+				argv_array_push(&argcp, "git");
+				argv_array_push(&argcp, "--super-prefix");
+				argv_array_push(&argcp, displaypath);
+				argv_array_push(&argcp, "submodule--helper");
+
+				if (quiet)
+					argv_array_push(&argcp, "--quiet");
+				argv_array_push(&argcp, "foreach");
+				argv_array_push(&argcp, "--recursive");
+
+				for (i = 0; i < argc; i++)
+					argv_array_push(&argcp, argv[i]);
+
+				run_command_v_opt(argcp.argv, RUN_USING_SHELL);
+			}
+
+			if (chdir(toplevel))
+				die_errno(_("cannot chdir to %s"), toplevel);
+		}
+	} else {
+		die_errno(_("cannot chdir to %s"), path);
+	}
+
+	strbuf_release(&cmd);
+	strbuf_release(&sub_sha1);
+	strbuf_release(&sb);
+	free(displaypath);
+	return;
+}
+
+static int module_foreach(int argc, const char **argv, const char *prefix)
+{
+	struct module_list list = MODULE_LIST_INIT;
+	int quiet = 0;
+	int recursive = 0;
+	int i;
+
+	struct option module_foreach_options[] = {
+		OPT__QUIET(&quiet, N_("Suppress output of Entering each submodule command")),
+		OPT_BOOL(0, "recursive", &recursive,
+			 N_("Traverse submodules ercursively and apply the command for all nested submodules")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper foreach [--recursive] <command>"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_foreach_options,
+			     git_submodule_helper_usage, 0);
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	for (i = 0; i < active_nr; i++) {
+		const struct cache_entry *ce = active_cache[i];
+
+		if (!S_ISGITLINK(ce->ce_mode))
+				continue;
+
+		ALLOC_GROW(list.entries, list.nr + 1, list.alloc);
+		list.entries[list.nr++] = ce;
+		while (i + 1 < active_nr &&
+			!strcmp(ce->name, active_cache[i + 1]->name))
+			 /*
+			  * Skip entries with the same name in different stages
+			  * to make sure an entry is returned only once.
+			  */
+			i++;
+	}
+
+	for (i = 0; i < list.nr; i++) {
+		if (prefix) {
+			const char *out = NULL;
+			if (skip_prefix(prefix, list.entries[i]->name, &out)) {
+				if (out && out[0] == '/' && !out + 1) 
+					return 0;
+			}
+		}
+
+		foreach_submodule(argc, argv, list.entries[i]->name,
+				  list.entries[i]->oid.hash, prefix,
+				  quiet, recursive);
+	}
+	return 0;
+}
+
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, struct string_list *reference,
 			   int quiet, int progress)
@@ -1168,6 +1320,7 @@ static struct cmd_struct commands[] = {
 	{"relative-path", resolve_relative_path, 0},
 	{"resolve-relative-url", resolve_relative_url, 0},
 	{"resolve-relative-url-test", resolve_relative_url_test, 0},
+	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
 	{"init", module_init, SUPPORT_SUPER_PREFIX},
 	{"remote-branch", resolve_remote_submodule_branch, 0},
 	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
diff --git a/git-submodule.sh b/git-submodule.sh
index 6ec35e5fc..e2c2b40f4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -321,46 +321,8 @@ cmd_foreach()
 		esac
 		shift
 	done
+	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper foreach ${GIT_QUIET:+--quiet} ${recursive:+--recursive} "$@"
 
-	toplevel=$(pwd)
-
-	# dup stdin so that it can be restored when running the external
-	# command in the subshell (and a recursive call to this function)
-	exec 3<&0
-
-	{
-		git submodule--helper list --prefix "$wt_prefix" ||
-		echo "#unmatched" $?
-	} |
-	while read mode sha1 stage sm_path
-	do
-		die_if_unmatched "$mode" "$sha1"
-		if test -e "$sm_path"/.git
-		then
-			displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
-			say "$(eval_gettext "Entering '\$displaypath'")"
-			name=$(git submodule--helper name "$sm_path")
-			(
-				prefix="$prefix$sm_path/"
-				sanitize_submodule_env
-				cd "$sm_path" &&
-				sm_path=$(git submodule--helper relative-path "$sm_path" "$wt_prefix") &&
-				# we make $path available to scripts ...
-				path=$sm_path &&
-				if test $# -eq 1
-				then
-					eval "$1"
-				else
-					"$@"
-				fi &&
-				if test -n "$recursive"
-				then
-					cmd_foreach "--recursive" "$@"
-				fi
-			) <&3 3<&- ||
-			die "$(eval_gettext "Stopping at '\$displaypath'; script returned non-zero status.")"
-		fi
-	done
 }
 
 #
-- 
2.11.0

