From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule: port init from shell to C
Date: Mon, 14 Mar 2016 17:15:52 -0700
Message-ID: <1458000952-4043-3-git-send-email-sbeller@google.com>
References: <1458000952-4043-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, jrnieder@gmail.com, j6t@kdbg.org,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 01:16:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afcep-0001jE-GF
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 01:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbcCOAQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 20:16:17 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35593 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254AbcCOAQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 20:16:13 -0400
Received: by mail-pf0-f173.google.com with SMTP id n5so2224241pfn.2
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 17:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Au/q7sDNV2yFJKCoyz28kOoXZ4Ft97xuj90qwwrkMOI=;
        b=aShfv+sSHx+wYfhra5VMG3HSgo/bbrVgKXSjC2j4oX+1ttDagSPSpHBnnUOLxtzN7F
         paSLe1l0XBcsXlXkfixsprMGqHVgJ1WdfOJFHtfIdhd4w1+h/4gwV33EnkIDzfK5p0Ej
         J71VdPX2h7sbTBPdt1hIT3p3xsqlB9pj5nZUe0NBq4mtNBwru0TPXy9DHwAQeBggdZsS
         rUqKy3Ra9fKHr0Ne+FzIkQvkkY0WGBGT/xTFWzaKA4dK9B9BmpJHIJYxbAXaTHay10/b
         TJdcnDBXgn33xMN0THYQk/ZA5cy/kBHnTk2AUSOKbxubN9O0DjqJ0kUTTyXD8/1txFaW
         5rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Au/q7sDNV2yFJKCoyz28kOoXZ4Ft97xuj90qwwrkMOI=;
        b=agjD70cDL/m+wJ4sme1LMBVpVDyJujjHj7CS4CV4HV9kjSR+l3wzN+bID2LP1nf3Af
         z4kdGn9XZ+8+tfxzZB5kHMPwEuRGp5uhDhHbslYPuC5/Q+sdqXPUNnvFFx0zxk/BBAHm
         bBfXWtDgQ70bIN5H87v/oXfNZr6hfom0MAEqQhmze4eCc9CdmwRLFSw+x4is/aOyLxzl
         wBs4cVx0jwBy4SRgbiHxZDTzArRdkBn7YPk1QP6Um5fQ84IlV6DupWf/azH2n/E9taav
         Uyn3EfWBfQIYpJmkeo2SRM1jCgfhmdSXSvx/egS9kVqP3VsUaiidcxvERx/9B+w2XAOk
         OefQ==
X-Gm-Message-State: AD7BkJIpbp8ErPVHA0otXMcR09Xi41QiWHJwh/15nEAeu0X+hMeoOxJ7nw4VIwseR18j0e7b
X-Received: by 10.66.132.73 with SMTP id os9mr42390289pab.27.1458000972765;
        Mon, 14 Mar 2016 17:16:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:cd15:2957:d1ba:58])
        by smtp.gmail.com with ESMTPSA id yx4sm34812509pac.5.2016.03.14.17.16.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Mar 2016 17:16:12 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.46.g8f16ed4.dirty
In-Reply-To: <1458000952-4043-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288823>

By having the `init` functionality in C, we can reference it easier
from other parts in the code.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 107 ++++++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh            |  39 +---------------
 submodule.c                 |  21 +++++++++
 submodule.h                 |   1 +
 4 files changed, 130 insertions(+), 38 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bc7cf87..d942463 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -216,6 +216,112 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
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
@@ -724,6 +830,7 @@ static struct cmd_struct commands[] = {
 	{"update-clone", update_clone},
 	{"resolve-relative-url", resolve_relative_url},
 	{"resolve-relative-url-test", resolve_relative_url_test},
+	{"init", module_init}
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index b3290f8..97a3097 100755
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
index 4bd14de..458189c 100644
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
+		return strbuf_detach(&sb, 0);
+	}
+	return NULL;
+}
+
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
diff --git a/submodule.h b/submodule.h
index 3166608..8cdc4bc 100644
--- a/submodule.h
+++ b/submodule.h
@@ -38,6 +38,7 @@ int submodule_config(const char *var, const char *value, void *cb);
 void gitmodules_config(void);
 int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
+const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
 void show_submodule_summary(FILE *f, const char *path,
 		const char *line_prefix,
-- 
2.7.0.rc0.46.g8f16ed4.dirty
