From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule: port init from shell to C
Date: Fri, 12 Feb 2016 15:39:16 -0800
Message-ID: <1455320356-15778-3-git-send-email-sbeller@google.com>
References: <1455320356-15778-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat Feb 13 00:39:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNJB-00009c-Gn
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:39:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbcBLXjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 18:39:23 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33539 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbcBLXjW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:39:22 -0500
Received: by mail-pa0-f52.google.com with SMTP id fl4so41948157pad.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 15:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G971UuKy9BAcNm7INITXsnqIpXsiUwWpNldY0F8cnaE=;
        b=GlYmlgrIp4yyw7D0rAn1e4prEuHaYlqzJ7Wo8v+ihcLJ2qgbkJ5CvglKftInfj8G60
         CcRO3TdT8T4/460u3Q8k0JIQs+qN1o2rAGgOjXCFSIx5uYblWkXdEGzNuDlG+L27f6gy
         ws2STvqF6LyTevgwoFg4yone2oXdrmpIXT8Xx3orMTAYP65vboVz+HcqVv+yFiKwxXw8
         TKa6ow2JI8xtnd/YD+LutpuXB+whCcR0+zE43NFO/gstX7CZVY2NIitA042uGrh2SPPE
         M6mQiS0D3hfzCpHT3YSCT7JPmN6qJ3u/78EEjnpebevNvjDIGWQqF3KCCVT7VoVEWsJ0
         6ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G971UuKy9BAcNm7INITXsnqIpXsiUwWpNldY0F8cnaE=;
        b=Ocg3RPwcM56wU+b8WnpYQCxkKSnsh+Wqxnl+tsbgzqIOdh6fFfCZnlN2aDAhcjdr+J
         zAUkeEXpjZG2d2VREFxpTCRyleau/QUN2kojeQ2w1i/6CL/dG68hfuzkzJA7WsSOt+g9
         BRy4vB+dHB1krsiYvZLxbJTItIoU8S7tqBuXAjvXBxr+ovZli/LU/dmgGuLakUGPDDyu
         xPPSeETnjoJ2M3USynHvT6YlZi9+odsfWEbMxfJr2ZY7zHmEFsdjucv9u8qE9FYmjmuS
         kQiJU6ZWaKMJh/ZuKu9ReTSGHVAKaSLAkDVinXZWc6kB5P/HhGiIYuJn1hDK/8O3LNax
         z9aA==
X-Gm-Message-State: AG10YOScviAZJehG6zrEWB40r1lAnv6b7zykDYg8lu4MIPJfYOd3Djim2PIdrn5YmfAlaNz7
X-Received: by 10.66.250.199 with SMTP id ze7mr5986147pac.103.1455320361582;
        Fri, 12 Feb 2016 15:39:21 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f1e7:203f:9d1e:8193])
        by smtp.gmail.com with ESMTPSA id e14sm21881174pap.24.2016.02.12.15.39.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 Feb 2016 15:39:20 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
In-Reply-To: <1455320356-15778-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286093>

By having the `init` functionality in C, we can reference it easier
from other parts in the code.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 107 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  39 +---------------
 submodule.c                 |  21 +++++++++
 submodule.h                 |   1 +
 4 files changed, 130 insertions(+), 38 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d1e9118..30e623a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -214,6 +214,112 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+static void init_submodule(const char *path, const char *prefix, int quiet)
+{
+	const struct submodule *sub;
+	struct strbuf sb = STRBUF_INIT;
+	char *url = NULL;
+	const char *upd = NULL;
+	char *cwd = xgetcwd();
+	const char *displaypath = relative_path(cwd, prefix, &sb);
+
+	/* Only loads from .gitmodules, no overlay with .git/config */
+	gitmodules_config();
+
+	sub = submodule_from_path(null_sha1, path);
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
+			char *remoteurl;
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
+			url = relative_url(remoteurl, url, NULL);
+			strbuf_release(&remotesb);
+			free(remoteurl);
+		}
+
+		if (git_config_set(sb.buf, url))
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
+	if (git_config_get_string_const(sb.buf, &upd) &&
+	    sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
+		if (sub->update_strategy.type == SM_UPDATE_COMMAND) {
+			fprintf(stderr, _("warning: command update mode suggested for submodule '%s'\n"),
+				sub->name);
+			upd = "none";
+		} else
+			upd = submodule_strategy_to_string(&sub->update_strategy);
+
+		if (git_config_set(sb.buf, upd))
+			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
+	}
+	strbuf_release(&sb);
+	free(cwd);
+	free(url);
+}
+
+static int module_init(int argc, const char **argv, const char *prefix)
+{
+	int quiet = 0;
+	int i;
+
+	struct option module_init_options[] = {
+		OPT_STRING(0, "prefix", &prefix,
+			   N_("path"),
+			   N_("alternative anchor for relative paths")),
+		OPT__QUIET(&quiet, "Suppress output for initialzing a submodule"),
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
+	if (argc == 0)
+		die(_("Pass at least one submodule"));
+
+	for (i = 0; i < argc; i++)
+		init_submodule(argv[i], prefix, quiet);
+
+	return 0;
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -709,6 +815,7 @@ static struct cmd_struct commands[] = {
 	{"update-clone", update_clone},
 	{"resolve-relative-url", resolve_relative_url},
 	{"resolve-relative-url-test", resolve_relative_url_test},
+	{"init", module_init}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 615ef9b..6fce0dc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -398,45 +398,8 @@ cmd_init()
 	while read mode sha1 stage sm_path
 	do
 		die_if_unmatched "$mode"
-		name=$(git submodule--helper name "$sm_path") || exit
-
-		displaypath=$(relative_path "$sm_path")
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
+		git submodule--helper init ${GIT_QUIET:+--quiet} "$sm_path" || exit
 	done
 }
 
diff --git a/submodule.c b/submodule.c
index 263cb2a..37d6b8d 100644
--- a/submodule.c
+++ b/submodule.c
@@ -235,6 +235,27 @@ int parse_submodule_update_strategy(const char *value,
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
+		return strbuf_detach(&sb, 0);
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
2.7.1.292.g18a4ced.dirty
