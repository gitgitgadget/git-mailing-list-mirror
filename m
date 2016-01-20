From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/2] submodule: port init from shell to C
Date: Tue, 19 Jan 2016 19:24:34 -0800
Message-ID: <1453260274-31005-1-git-send-email-sbeller@google.com>
References: <1453255396-31942-3-git-send-email-sbeller@google.com>
Cc: j6t@kdbg.org, sunshine@sunshineco.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 20 04:24:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLjO0-00017y-0b
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 04:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935005AbcATDYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 22:24:41 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33192 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935000AbcATDYi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 22:24:38 -0500
Received: by mail-pa0-f45.google.com with SMTP id cy9so462459617pac.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 19:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k4w3uhp9jrE988qaid/eKpFCpUjl+BtnZiRcjpPv2aU=;
        b=c7JjmJZ0PKaYJLdmYt+7T1DWQbMwLhsobNwS9wdLsW7W+9ev0I8lsd7binxVex3qdB
         msb6R8ZtREj3+v3ZPiLErNGJlB8/WNxWS9YpExI64fciPxCdbVdm70fQnWmVFN/ceSgN
         KN7q9n+dfnjneFlU+5/93nXtNhyauvN+UbYXJgfJVlD2PNBAAT552vEIbngFcHlWalyj
         HiiRBrBokgUt+Znp0dJ9lHmrYfTrpeZ5Q1+JwBZxGmRWUHdMDsPJO2x2KD13ltvq3YxV
         O9Zp/ZYhivHHHF+gGIPXPgho0udxhLlkQO+74W3yFAsRvs8AwY1coi2eGlLAs3YlmaOa
         TxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k4w3uhp9jrE988qaid/eKpFCpUjl+BtnZiRcjpPv2aU=;
        b=ML2xgs30nMidHDFCbPq2cgirSElqQw0VE/XUZr/oJroMMfcI1FzoiL1jyvflEMysGI
         T56wIGsTkhVOjLv/bP/TH/KWk7M3wBjyNIHjVqMQ/9y1UxUYBYjRRR6OlLJktlhK/uQc
         2nN03vL8J5AQ641KcLLVZfhWCru3gcX5aivkYwVgn2fE75h9jnYYI2AdTPA/RrqTZp5U
         HprV+o7lPNPReWtpudfsjzKVBA6k70n3KJ6yhXjw2fAKC1jnhsc7hmofsN3oV8ExLdrL
         h3APp2SV+AAdTj21UqTj+SB+47uZ8ojsoVtlUGU5he6uaHA4JXHsDD1Kk0henz84Vy7m
         tRLA==
X-Gm-Message-State: ALoCoQluND79CkX95kPA8eEaZwg4evZCLGcr7w1xehX2ogloQyfa3+s3kCbq5WBRyxOq/WAWZwFDnnsgaej8hYVHFu5jbjUdXQ==
X-Received: by 10.66.163.7 with SMTP id ye7mr48296479pab.55.1453260277733;
        Tue, 19 Jan 2016 19:24:37 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:25db:c0:235a:551d])
        by smtp.gmail.com with ESMTPSA id c86sm44547429pfd.75.2016.01.19.19.24.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 19:24:37 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.g89994f2.dirty
In-Reply-To: <1453255396-31942-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284419>

By having the `init` functionality in C, we can reference it easier
from other parts in the code.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

I noticed a syntactical mistake in this patch, interdiff to v2:

    diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
    index bcfcbdf..def382e 100644
    --- a/builtin/submodule--helper.c
    +++ b/builtin/submodule--helper.c
    @@ -247,7 +247,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
            strbuf_reset(&sb);
            strbuf_addf(&sb, "submodule.%s.url", sub->name);
            if (git_config_get_string(sb.buf, &url)) {
    -               url = xstrdup(sub->url); // as overlayed by .gitmodules
    +               url = xstrdup(sub->url);




 builtin/submodule--helper.c | 115 ++++++++++++++++++++++++++++++++++++++++++--
 git-submodule.sh            |  39 +--------------
 2 files changed, 111 insertions(+), 43 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1484b36..4684f16 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -221,6 +221,115 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+static int git_submodule_config(const char *var, const char *value, void *cb)
+{
+	return parse_submodule_config_option(var, value);
+}
+
+static void init_submodule(const char *path, const char *prefix, int quiet)
+{
+	const struct submodule *sub;
+	struct strbuf sb = STRBUF_INIT;
+	char *url = NULL;
+	const char *upd = NULL;
+	const char *displaypath = relative_path(xgetcwd(), prefix, &sb);;
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
+		}
+
+		if (git_config_set(sb.buf, url))
+			die(_("Failed to register url for submodule path '%s'"),
+			    displaypath);
+		if (!quiet)
+			fprintf(stderr, _("Submodule '%s' (%s) registered for path '%s'\n"),
+				sub->name, url, displaypath);
+		free(url);
+	}
+
+	/* Copy "update" setting when it is not set yet */
+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "submodule.%s.update", sub->name);
+	if (git_config_get_string_const(sb.buf, &upd) && sub->update) {
+		upd = sub->update;
+		if (strcmp(sub->update, "checkout") &&
+		    strcmp(sub->update, "rebase") &&
+		    strcmp(sub->update, "merge") &&
+		    strcmp(sub->update, "none")) {
+			fprintf(stderr, _("warning: unknown update mode '%s' suggested for submodule '%s'\n"),
+				upd, sub->name);
+			upd = "none";
+		}
+		if (git_config_set(sb.buf, upd))
+			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
+	}
+	strbuf_release(&sb);
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
@@ -466,11 +575,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int git_submodule_config(const char *var, const char *value, void *cb)
-{
-	return parse_submodule_config_option(var, value);
-}
-
 struct submodule_update_clone {
 	/* states */
 	int count;
@@ -716,6 +820,7 @@ static struct cmd_struct commands[] = {
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
 
-- 
2.7.0.rc0.41.g89994f2.dirty
