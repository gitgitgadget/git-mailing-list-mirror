From: Jeff King <peff@peff.net>
Subject: [PATCH 2/7] config: fix parsing of "git config --get-color some.key
 -1"
Date: Thu, 20 Nov 2014 10:15:51 -0500
Message-ID: <20141120151550.GB23680@peff.net>
References: <20141120151418.GA23607@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Baker <bakers@canbytel.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:15:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrTSf-000494-LF
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 16:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299AbaKTPPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 10:15:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:42768 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756527AbaKTPPx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 10:15:53 -0500
Received: (qmail 11682 invoked by uid 102); 20 Nov 2014 15:15:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 09:15:52 -0600
Received: (qmail 13028 invoked by uid 107); 20 Nov 2014 15:16:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 10:16:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 10:15:51 -0500
Content-Disposition: inline
In-Reply-To: <20141120151418.GA23607@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of git-config's command line options use OPT_BIT to
choose an action, and then parse the non-option arguments
in a context-dependent way. However, --get-color and
--get-colorbool are unlike the rest of the options, in that
they are OPT_STRING, taking the option name as a parameter.

This generally works, because we then use the presence of
those strings to set an action bit anyway. But it does mean
that the option-parser will continue looking for options
even after the key (because it is not a non-option; it is an
argument to an option). And running:

  git config --get-color some.key -1

(to use "-1" as the default color spec) will barf, claiming
that "-1" is not an option. Instead, we should treat
--get-color and --get-colorbool as action bits, just like
--add, --get, and all the other actions, and then check that
the non-option arguments we got are sane. This fixes the
weirdness above, and makes those two options like all the
others.

This "fixes" a test in t4026, which checked that feeding
"-2" as a color should fail (it does fail, but prior to this
patch, because parseopt barfed, not because we actually ever
tried to parse the color).

This also catches other errors, like:

  git config --get-color some.key black blue

which previously silently ignored "blue" (and now will
complain that you gave too many arguments).

There are some possible regressions, though. We now disallow
these, which currently do what you would expect:

  # specifying other options after the action
  git config --get-color some.key --file whatever

  # using long-arg syntax
  git config --get-color=some.key

However, we have never advertised these in the
documentation, and in fact they did not work in some older
versions of git. The behavior was apparently switched as an
accidental side effect of d64ec16 (git config: reorganize to
use parseopt, 2009-02-21).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8cc2604..fddafbb 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -69,8 +69,8 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
 	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
 	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
-	OPT_STRING(0, "get-color", &get_color_slot, N_("slot"), N_("find the color configured: [default]")),
-	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, N_("slot"), N_("find the color setting: [stdout-is-tty]")),
+	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
+	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
 	OPT_BIT(0, "bool", &types, N_("value is \"true\" or \"false\""), TYPE_BOOL),
 	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
@@ -303,8 +303,9 @@ static int git_get_color_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static void get_color(const char *def_color)
+static void get_color(const char *var, const char *def_color)
 {
+	get_color_slot = var;
 	get_color_found = 0;
 	parsed_color[0] = '\0';
 	git_config_with_options(git_get_color_config, NULL,
@@ -333,8 +334,9 @@ static int git_get_colorbool_config(const char *var, const char *value,
 	return 0;
 }
 
-static int get_colorbool(int print)
+static int get_colorbool(const char *var, int print)
 {
+	get_colorbool_slot = var;
 	get_colorbool_found = -1;
 	get_diff_color_found = -1;
 	get_color_ui_found = -1;
@@ -532,12 +534,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
-	if (get_color_slot)
-	    actions |= ACTION_GET_COLOR;
-	if (get_colorbool_slot)
-	    actions |= ACTION_GET_COLORBOOL;
-
-	if ((get_color_slot || get_colorbool_slot) && types) {
+	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && types) {
 		error("--get-color and variable type are incoherent");
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
@@ -683,12 +680,14 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			die("No such section!");
 	}
 	else if (actions == ACTION_GET_COLOR) {
-		get_color(argv[0]);
+		check_argc(argc, 1, 2);
+		get_color(argv[0], argv[1]);
 	}
 	else if (actions == ACTION_GET_COLORBOOL) {
-		if (argc == 1)
-			color_stdout_is_tty = git_config_bool("command line", argv[0]);
-		return get_colorbool(argc != 0);
+		check_argc(argc, 1, 2);
+		if (argc == 2)
+			color_stdout_is_tty = git_config_bool("command line", argv[1]);
+		return get_colorbool(argv[0], argc == 2);
 	}
 
 	return 0;
-- 
2.2.0.rc2.402.g4519813
