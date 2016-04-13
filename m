From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule: port init from shell to C
Date: Tue, 12 Apr 2016 17:18:30 -0700
Message-ID: <1460506710-23994-3-git-send-email-sbeller@google.com>
References: <1460506710-23994-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, pclouds@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 02:18:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8WC-0005wf-Rc
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757483AbcDMASn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 20:18:43 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33885 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175AbcDMASl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:18:41 -0400
Received: by mail-pf0-f181.google.com with SMTP id c20so23168988pfc.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uCUXCaHOJhx/nI8hxcJmZUz7nAP9uUwRqaNa17n0Hrs=;
        b=XxPmkK/X+cxJzvKV1LDawHrUD56I62rb3GtfL55e1mX+c/cdVXSjOf9qhxrqA44kGq
         cPQrP/fZiXSXKaCW87fFobYRsvr+i1TRLTTKOt4Ii/IySNplN+gp90ToU6E11rUu8hFt
         Es6pskG5K64OhtVz0W23aWIwekIIDo0t6FRFKgqejYH+BrscpgDcOe4RUByBtlfz61Ya
         8b0HYMn4xBn98ALETvHvWrzV2lWSReCDL//FXI/MoquPt+QECJqKsb4sRKlLNOy6RTQl
         ioEWpg/8cKbVtPo708Z9KgXz1O61LYQConCLpSQcFXIJUd9ZSQy0rB9SCLShBu/0fLcy
         Cw1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uCUXCaHOJhx/nI8hxcJmZUz7nAP9uUwRqaNa17n0Hrs=;
        b=FczBSZKd2nJTB2TL9YENRhFw7O1JCe44x79ZjO0Om+8irs4lRIuLen8GfAzbCrtBYm
         lrth1NGYsI9nl7/MihSLETLnJGlDN1qmj2xouEQuJwDS9A7loFK8eqv4ft9/W54mRBj9
         FM9MqJhkstFEfQzVNjOblSYye7G2uEA1HwZXtDGIRX1DLcieJUPqujsbLvmQhgoJbCeU
         HuLF/TilZx75CUyGnP7gjfsDmjgUUmunzKphZGgcXCmcYCnAN/WgmV4CJbm/Dq4GMa5P
         ndmilrlVjI9Lll9EcmHw08UzP/vGgiRwiz+Kafiioguv10KQ6Wp4s26wds2AC+Czqp06
         l7fg==
X-Gm-Message-State: AOPr4FXDdzEd9Bjj94181y7MmQN7zMBu5yXImKA8HF0v516iXKGxvwHi3bKovWeRFuUAD4Pl
X-Received: by 10.98.89.22 with SMTP id n22mr8664619pfb.55.1460506715204;
        Tue, 12 Apr 2016 17:18:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:705c:1d3d:8d56:4629])
        by smtp.gmail.com with ESMTPSA id q20sm46206826pfi.63.2016.04.12.17.18.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 12 Apr 2016 17:18:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.gc776916.dirty
In-Reply-To: <1460506710-23994-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291335>

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
index 2ab3662..3078790 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -215,6 +215,112 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
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
@@ -723,6 +829,7 @@ static struct cmd_struct commands[] = {
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
2.5.0.264.gc776916.dirty
