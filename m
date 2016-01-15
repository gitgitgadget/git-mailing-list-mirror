From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule: Port init from shell to C
Date: Fri, 15 Jan 2016 15:37:15 -0800
Message-ID: <1452901035-1802-3-git-send-email-sbeller@google.com>
References: <1452901035-1802-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, j6t@kdbg.org, sunshine@sunshineco.com,
	Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 16 00:38:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKDwP-0007Sl-HX
	for gcvg-git-2@plane.gmane.org; Sat, 16 Jan 2016 00:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbcAOXhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 18:37:31 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34197 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbcAOXhV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 18:37:21 -0500
Received: by mail-pa0-f52.google.com with SMTP id uo6so386763420pac.1
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 15:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZDzMqj0iNvTr/WskWZdzVH7lgz1+PM+5E0Sie3cqtA=;
        b=cdTGoSsjUSfJqh9LnoQOepbIofbFvkKQCz+F9GKp88+H7lospyUYgYFMkiRYLxC+Pl
         CFyPc99dh0TSPx9Moeo7VplKxBCcqD2ZE2uDIWED9o1nR51gH7PSk4DM9nHeZD1ZH7DI
         OkH5cnq28Ydm/ygrXKzxu0rS80B67K89qYlntDQOi+PiHte5QrHr7v4FRUBKx/heWBxj
         YRl2/WqDIpFh3i2EUDyb41oYoenUPmR4MQqzvZl05u44RgwnaW1dde41vwsxpCURJ7Bm
         UFIrUi/9lTp9Ao02Boh7+6uoCkb2P7/BeJhYp3ddxnDbSP6qJ5rRBGwaoAYGNsZKR7ZL
         6XDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tZDzMqj0iNvTr/WskWZdzVH7lgz1+PM+5E0Sie3cqtA=;
        b=jA16KtaYC0XAc2+YiIpj6f7mep7+RHbGLyYq1JZdGTI59SOC4ud1DL1pQNI3/Thm06
         ayHtitpZIL5ysz3/MbP1ACNZWUwy+0i8R6bGMRMPFIvQREwHzgmxHbdYqqL4Fbn005WT
         9yGH9DNQCpVM0AnFElDaTJd/jcaJT6DEFGGssQz2g3oLfrGb6SOoTO4rx3nOdWqb+1Zw
         FdeNbKobOsiM2VgdCFBkUjOaBF/D0v1SuipHLyhL5Jrb7jbvuC4rmjlCmpRRFXWH23Qt
         kYNE5oFbmpR0oImteRdNxGfzfAzuAn0JOeNf79zncLEV5mFLqEwsm3/Ncw3mSD/BsKql
         KfYQ==
X-Gm-Message-State: ALoCoQngj2ILtvTYPUfXyfJtcw0rY3cXjOxa9IIl1OSiwD7XbrzpECFeKZY78K4xmNgKud8OPOpRM3rTZRQbuZojsTeQg0HmIQ==
X-Received: by 10.66.148.167 with SMTP id tt7mr18955186pab.62.1452901040904;
        Fri, 15 Jan 2016 15:37:20 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:698b:ab72:c6a:e39c])
        by smtp.gmail.com with ESMTPSA id v26sm17739198pfi.56.2016.01.15.15.37.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Jan 2016 15:37:20 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.37.gb4a0220.dirty
In-Reply-To: <1452901035-1802-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284233>

By having the `init` functionality in C, we can reference it easier from
other parts in the code.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 115 ++++++++++++++++++++++++++++++++++++++++++--
 git-submodule.sh            |  39 +--------------
 2 files changed, 111 insertions(+), 43 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1484b36..c7bd38a 100644
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
+static void init_submodule(const char *path, const char *prefix)
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
+		url = xstrdup(sub->url); // as overlayed by .gitmodules
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
+
+		printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
+			sub->name, url, displaypath);
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
+		init_submodule(argv[i], prefix);
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
2.7.0.rc0.37.gb4a0220.dirty
