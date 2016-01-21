From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/2] submodule: port init from shell to C
Date: Thu, 21 Jan 2016 15:18:43 -0800
Message-ID: <1453418323-29587-1-git-send-email-sbeller@google.com>
References: <1453260274-31005-1-git-send-email-sbeller@google.com>
Cc: j6t@kdbg.org, sunshine@sunshineco.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 22 00:19:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMOVS-0001Sq-AX
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 00:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbcAUXTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 18:19:05 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34455 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbcAUXTD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 18:19:03 -0500
Received: by mail-pa0-f48.google.com with SMTP id uo6so31328958pac.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 15:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tQI0W0xx7YgOAH7QJZuxCw9XETh7fjJ0PIEC2+pg7Xs=;
        b=ehRme3zZi+/Jh6F+eYF4pJbhLJkSKYJkKC68HFEBC2Z7AGytFJmEeqeYUe5ne3AhjO
         ca5+r2VHiDit14f3efXECDvZkVVxPRZwxAjArIA+GWk3PgfyUvmliKkeRXv9Wk7eXUBo
         tpr7SHBha794jGYX4uYvYqci1Huew70hsN3gueiZ6gbZdbctQNJcoKp5XRJpGxAYmxEX
         0yPhXDu/FM8hIisuC7ZKaeo4XwFM7yGn2F8Ae3EUHgpJeD/7xse7jMab4xsYUFAkQ9NG
         ak92piAjxaKHwju+Js0Z6JKLtz1anX+fRTL7fbDEKwmTFt016wOuu/ydfC6bMKp7qCui
         XnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tQI0W0xx7YgOAH7QJZuxCw9XETh7fjJ0PIEC2+pg7Xs=;
        b=dTVns8BJ+OwrDZ6rr2mMhZGXKV2065WsB/aOzBppwADzPaE10ry+r/Ddt0QVG83wZn
         a7dCsvw/0vXSSMAHf8LawfphDe3ZqxFbbB8iwBrRmRqUuLoTyCsdf3Su/Rb+72Sv2NeQ
         29v5TtMjsgmhhK6Fl0x/DaG1Ruljf7jGevuIToLmb1zsQ5qVd611uY0SSn6iJHKpp91i
         YAsd9KPVJT6u/yCAx444cUuXXIXy411Qj98yf8zPWRO4mWwoY4XmDegkREEqH9DbMkAd
         QXUDimhA2gJ4aY45dipqM7pbyAh6M2fUHoUXAMrdkYDhWXtt/c7GBbWqMHgqg1oB8xcL
         XLBA==
X-Gm-Message-State: ALoCoQlTR4Pbt7+UtvTkKDtTiZ92twtFV0eUnGUaDCzL8dfiUtSvz+u8Fp76Zu/o7Q8ENZ/csBxeEn1fXYRN4mH4SwXZgv18xw==
X-Received: by 10.66.100.198 with SMTP id fa6mr65261861pab.123.1453418342599;
        Thu, 21 Jan 2016 15:19:02 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9984:c67d:7b5e:7c95])
        by smtp.gmail.com with ESMTPSA id n2sm4991143pfj.16.2016.01.21.15.19.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 21 Jan 2016 15:19:01 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.g89994f2.dirty
In-Reply-To: <1453260274-31005-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284541>

By having the `init` functionality in C, we can reference it easier
from other parts in the code.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Hi Junio,

please replace the top-most patch of sb/submodule-init with this patch.

This will print to stdout instead of stderr, as it's the most
faithful shell -> translation. The s/printf/fprintf(stderr, / patch
will come with the series that needs the behavior, i.e. as one of the
first patches in the groups series (that is under heavy mental
construction currently).

Thanks,
Stefan

Interdiff to the top of sb/submodule-init (6a514f75c25, submodule: port
init from shell to C, Committed: 2016-01-20 12:55:30):

#        diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
#        index 4684f16..6323048 100644
#        --- a/builtin/submodule--helper.c
#        +++ b/builtin/submodule--helper.c
#        @@ -232,7 +232,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
#                struct strbuf sb = STRBUF_INIT;
#                char *url = NULL;
#                const char *upd = NULL;
#        -       const char *displaypath = relative_path(xgetcwd(), prefix, &sb);;
#        +       const char *displaypath = relative_path(xgetcwd(), prefix, &sb);
#         
#                /* Only loads from .gitmodules, no overlay with .git/config */
#                gitmodules_config();
#        @@ -276,7 +276,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
#                                die(_("Failed to register url for submodule path '%s'"),
#                                    displaypath);
#                        if (!quiet)
#        -                       fprintf(stderr, _("Submodule '%s' (%s) registered for path '%s'\n"),
#        +                       printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
#                                        sub->name, url, displaypath);
#                        free(url);
#                }


 builtin/submodule--helper.c | 115 ++++++++++++++++++++++++++++++++++++++++++--
 git-submodule.sh            |  39 +--------------
 2 files changed, 111 insertions(+), 43 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1484b36..6323048 100644
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
+	const char *displaypath = relative_path(xgetcwd(), prefix, &sb);
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
+			printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
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
