From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule: port init from shell to C
Date: Fri, 15 Apr 2016 17:50:13 -0700
Message-ID: <1460767813-25916-3-git-send-email-sbeller@google.com>
References: <1460767813-25916-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, pclouds@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 02:50:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arERS-0004WZ-1Q
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 02:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbcDPAuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 20:50:20 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35613 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbcDPAuT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 20:50:19 -0400
Received: by mail-pa0-f46.google.com with SMTP id fs9so41197382pac.2
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 17:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZoQBKht+OtJYy+gTCcCfhXtLGZSnZV7KiFH4ySUll9g=;
        b=L7v6xxlmY3Yp7sW1sIs9XePzRclf3/bhjOrOwuebg3W4BkVfXSfhPH973gNCPf2RIO
         Yb9dbF9CwAag37hZ0bdAK5LryckB1F0q56qnG+WDEPw1f7dl3/yOVSDpbif7qsNbOqEm
         KSfCgaxLyTQkMRDVjRabe+X3WHKLaJjJK9xYdayhWzyJ3O+FemzHcwys+WFOUECPiae4
         H0PiF5V+ieQ1JJUiDLRCOgxhvKBLMrQLBXo1Bk0fwy9vwOvjUxiST6tnQHB+q38bXcTw
         CuEg/tF57X3g6ie1IMeiJfebKzJf4441vyUwRpYOa6ll37WX1/IdDqt7EvJJhdOeTyng
         qFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZoQBKht+OtJYy+gTCcCfhXtLGZSnZV7KiFH4ySUll9g=;
        b=Z+vT3hBrNEGKnINYvwNyB7PljS9nBwQHKV/nijZ58ZJS0dRjUyPEMzi5pXfNuTLest
         uENxKBSap1C1BQoni8wlwFF/x7fsAM3sYcrLPyACwHk1VCAQEcaQfVJK8OebRy4Nfo0T
         mvm8ZVoaaWqsbr5nwHzGRrT8hZ7c7LTMpw4iAi1Hhqu4twLVDe1ZvMuD9RkRbn/YDyoG
         505TYLGusqncy/JVmKZat0/IoedtRHbDeIgrl9IrCHU+L84fGlYMQ4hGO7+GQJim8CUk
         MkWwi5fK3g9K3eK61T93QHT8jQoX2jt/3Nb2F9rAeLJZPEDrky5lBFsC0XNMLsuaE8a5
         VNxg==
X-Gm-Message-State: AOPr4FVQPJn+n4kDRwB6ylyG9zAnDWcg/LB5wLY8NTwpoeNKBi8C1S7/kwNSSfvUAT41wDtF
X-Received: by 10.66.236.232 with SMTP id ux8mr33361974pac.145.1460767818116;
        Fri, 15 Apr 2016 17:50:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c97d:dddf:ab88:e90])
        by smtp.gmail.com with ESMTPSA id yj1sm67407203pac.16.2016.04.15.17.50.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Apr 2016 17:50:17 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.26.gba39a1b.dirty
In-Reply-To: <1460767813-25916-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291711>

By having the `submodule init` functionality in C, we can reference it
easier from other parts in the code in later patches. The code is split
up to have one function to initialize one submodule and a calling function
that takes care of the rest, such as argument handling and translating the
arguments to the paths of the submodules.

This is the first submodule subcommand that is fully converted to C
except for the usage string, so this is actually removing a call to
the `submodule--helper list` function, which is supposed to be used in
this transition. Instead we'll make a direct call to `module_list_compute`.

An explanation why we need to edit the prefixes in cmd_update in
git-submodule.sh in this patch:

By having no processing in the shell part, we need to convey the notion
of wt_prefix and prefix to the C parts, which former patches punted on
and did the processing of displaying path in the shell.

`wt_prefix` used to hold the path from the repository root to the current
directory, e.g. wt_prefix would be t/ if the user invoked the
`git submodule` command in ~/repo/t and ~repo is the GIT_DIR.

`prefix` used to hold the relative path from the repository root to the
operation, e.g. if you have recursive submodules, the shell script would
modify the `prefix` in each recursive step by adding the submodule path.

We will pass `wt_prefix` into the C helper via `git -C <dir>` as that
will setup git in the directory the user actually called git-submodule.sh
from. The `prefix` will be passed in via the `--prefix` option.

Having `prefix` and `wt_prefix` relative to the GIT_DIR of the
calling superproject is unfortunate with this patch as the C code doesn't
know about a possible recursion from a superproject via `submodule update
--init --recursive`.

To fix this, we change the meaning of `wt_prefix` to point to the current
project instead of the superproject and `prefix` to include any relative
paths issues in the superproject. That way `prefix` will become the leading
part for displaying paths and `wt_prefix` will be empty in recursive
calls for now.

The new notion of `wt_prefix` and `prefix` still allows us to reconstruct
the calling directory in the superproject by just traveling reverse of
`prefix`.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 115 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  48 ++----------------
 submodule.c                 |  21 ++++++++
 submodule.h                 |   1 +
 4 files changed, 140 insertions(+), 45 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 46946b0..b6d4f27 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -305,6 +305,120 @@ static int module_list(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static void init_submodule(const char *path, const char *prefix, int quiet)
+{
+	const struct submodule *sub;
+	struct strbuf sb = STRBUF_INIT;
+	char *upd = NULL, *url = NULL, *displaypath;
+
+	/* Only loads from .gitmodules, no overlay with .git/config */
+	gitmodules_config();
+
+	sub = submodule_from_path(null_sha1, path);
+
+	if (prefix) {
+		strbuf_addf(&sb, "%s%s", prefix, path);
+		displaypath = strbuf_detach(&sb, NULL);
+	} else
+		displaypath = xstrdup(sub->path);
+
+	/*
+	 * Copy url setting when it is not set yet.
+	 * To look up the url in .git/config, we must not fall back to
+	 * .gitmodules, so look it up directly.
+	 */
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "submodule.%s.url", sub->name);
+	if (git_config_get_string(sb.buf, &url)) {
+		url = xstrdup(sub->url);
+
+		if (!url)
+			die(_("No url found for submodule path '%s' in .gitmodules"),
+				displaypath);
+
+		/* Possibly a url relative to parent */
+		if (starts_with_dot_dot_slash(url) ||
+		    starts_with_dot_slash(url)) {
+			char *remoteurl, *relurl;
+			char *remote = get_default_remote();
+			struct strbuf remotesb = STRBUF_INIT;
+			strbuf_addf(&remotesb, "remote.%s.url", remote);
+			free(remote);
+
+			if (git_config_get_string(remotesb.buf, &remoteurl))
+				/*
+				 * The repository is its own
+				 * authoritative upstream
+				 */
+				remoteurl = xgetcwd();
+			relurl = relative_url(remoteurl, url, NULL);
+			strbuf_release(&remotesb);
+			free(remoteurl);
+			free(url);
+			url = relurl;
+		}
+
+		if (git_config_set_gently(sb.buf, url))
+			die(_("Failed to register url for submodule path '%s'"),
+			    displaypath);
+		if (!quiet)
+			printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
+				sub->name, url, displaypath);
+	}
+
+	/* Copy "update" setting when it is not set yet */
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "submodule.%s.update", sub->name);
+	if (git_config_get_string(sb.buf, &upd) &&
+	    sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
+		if (sub->update_strategy.type == SM_UPDATE_COMMAND) {
+			fprintf(stderr, _("warning: command update mode suggested for submodule '%s'\n"),
+				sub->name);
+			upd = xstrdup("none");
+		} else
+			upd = xstrdup(submodule_strategy_to_string(&sub->update_strategy));
+
+		if (git_config_set_gently(sb.buf, upd))
+			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
+	}
+	strbuf_release(&sb);
+	free(displaypath);
+	free(url);
+	free(upd);
+}
+
+static int module_init(int argc, const char **argv, const char *prefix)
+{
+	struct pathspec pathspec;
+	struct module_list list = MODULE_LIST_INIT;
+	int quiet = 0;
+	int i;
+
+	struct option module_init_options[] = {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("alternative anchor for relative paths")),
+		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
+		OPT_END()
+	};
+
+	const char *const git_submodule_helper_usage[] = {
+		N_("git submodule--helper init [<path>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, prefix, module_init_options,
+			     git_submodule_helper_usage, 0);
+
+	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+		return 1;
+
+	for (i = 0; i < list.nr; i++)
+		init_submodule(list.entries[i]->name, prefix, quiet);
+
+	return 0;
+}
+
 static int module_name(int argc, const char **argv, const char *prefix)
 {
 	const struct submodule *sub;
@@ -712,6 +826,7 @@ static struct cmd_struct commands[] = {
 	{"update-clone", update_clone},
 	{"resolve-relative-url", resolve_relative_url},
 	{"resolve-relative-url-test", resolve_relative_url_test},
+	{"init", module_init}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 2423d7c..82e95a9 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -394,50 +394,7 @@ cmd_init()
 		shift
 	done
 
-	git submodule--helper list --prefix "$wt_prefix" "$@" |
-	while read mode sha1 stage sm_path
-	do
-		die_if_unmatched "$mode"
-		name=$(git submodule--helper name "$sm_path") || exit
-
-		displaypath=$(relative_path "$prefix$sm_path")
-
-		# Copy url setting when it is not set yet
-		if test -z "$(git config "submodule.$name.url")"
-		then
-			url=$(git config -f .gitmodules submodule."$name".url)
-			test -z "$url" &&
-			die "$(eval_gettext "No url found for submodule path '\$displaypath' in .gitmodules")"
-
-			# Possibly a url relative to parent
-			case "$url" in
-			./*|../*)
-				url=$(git submodule--helper resolve-relative-url "$url") || exit
-				;;
-			esac
-			git config submodule."$name".url "$url" ||
-			die "$(eval_gettext "Failed to register url for submodule path '\$displaypath'")"
-
-			say "$(eval_gettext "Submodule '\$name' (\$url) registered for path '\$displaypath'")"
-		fi
-
-		# Copy "update" setting when it is not set yet
-		if upd="$(git config -f .gitmodules submodule."$name".update)" &&
-		   test -n "$upd" &&
-		   test -z "$(git config submodule."$name".update)"
-		then
-			case "$upd" in
-			checkout | rebase | merge | none)
-				;; # known modes of updating
-			*)
-				echo >&2 "warning: unknown update mode '$upd' suggested for submodule '$name'"
-				upd=none
-				;;
-			esac
-			git config submodule."$name".update "$upd" ||
-			die "$(eval_gettext "Failed to register update mode for submodule path '\$displaypath'")"
-		fi
-	done
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper init ${GIT_QUIET:+--quiet} ${prefix:+--prefix "$prefix"} "$@"
 }
 
 #
@@ -740,7 +697,8 @@ cmd_update()
 		if test -n "$recursive"
 		then
 			(
-				prefix="$prefix$sm_path/"
+				prefix=$(relative_path "$prefix$sm_path/")
+				wt_prefix=
 				clear_local_git_env
 				cd "$sm_path" &&
 				eval cmd_update
diff --git a/submodule.c b/submodule.c
index 90825e1..4cc1c27 100644
--- a/submodule.c
+++ b/submodule.c
@@ -237,6 +237,27 @@ int parse_submodule_update_strategy(const char *value,
 	return 0;
 }
 
+const char *submodule_strategy_to_string(const struct submodule_update_strategy *s)
+{
+	struct strbuf sb = STRBUF_INIT;
+	switch (s->type) {
+	case SM_UPDATE_CHECKOUT:
+		return "checkout";
+	case SM_UPDATE_MERGE:
+		return "merge";
+	case SM_UPDATE_REBASE:
+		return "rebase";
+	case SM_UPDATE_NONE:
+		return "none";
+	case SM_UPDATE_UNSPECIFIED:
+		return NULL;
+	case SM_UPDATE_COMMAND:
+		strbuf_addf(&sb, "!%s", s->command);
+		return strbuf_detach(&sb, NULL);
+	}
+	return NULL;
+}
+
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
diff --git a/submodule.h b/submodule.h
index 7ef3775..ff4c4f3 100644
--- a/submodule.h
+++ b/submodule.h
@@ -39,6 +39,7 @@ int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
+const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
-- 
2.8.0.26.gba39a1b.dirty
