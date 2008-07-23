From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 6/9] builtin-init-db.c: use parse_options()
Date: Wed, 23 Jul 2008 23:42:09 +0200
Message-ID: <1216849332-26813-7-git-send-email-barra_cuda@katamail.com>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 23:37:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLm1b-00026o-Pu
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbYGWVf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755023AbYGWVf6
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:35:58 -0400
Received: from smtp.katamail.com ([62.149.157.154]:37046 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755011AbYGWVfx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:35:53 -0400
Received: (qmail 11577 invoked by uid 89); 23 Jul 2008 21:35:44 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.10)
  by smtp2-pc with SMTP; 23 Jul 2008 21:35:43 -0000
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89772>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-init-db.c |   56 +++++++++++++++++++++++++++++++++-------------------
 1 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 38b4fcb..ea1bed7 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
+#include "parse-options.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates"
@@ -353,8 +354,17 @@ static int guess_repository_type(const char *git_dir)
 	return 1;
 }
 
-static const char init_db_usage[] =
-"git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]]";
+static const char * const init_db_usage[] = {
+	"git init [-q | --quiet] [--bare] [--template=<dir>] [--shared[=<type>]]",
+	NULL
+};
+
+static int parse_opt_shared_cb(const struct option *opt, const char *arg,
+			       int unset)
+{
+	*(int *)(opt->value) = unset ? 0 : git_config_perm("arg", arg);
+	return 0;
+}
 
 /*
  * If you want to, you can share the DB area with any number of branches.
@@ -367,25 +377,29 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	const char *git_dir;
 	const char *template_dir = NULL;
 	unsigned int flags = 0;
-	int i;
-
-	for (i = 1; i < argc; i++, argv++) {
-		const char *arg = argv[1];
-		if (!prefixcmp(arg, "--template="))
-			template_dir = arg+11;
-		else if (!strcmp(arg, "--bare")) {
-			static char git_dir[PATH_MAX+1];
-			is_bare_repository_cfg = 1;
-			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir,
-						sizeof(git_dir)), 0);
-		} else if (!strcmp(arg, "--shared"))
-			shared_repository = PERM_GROUP;
-		else if (!prefixcmp(arg, "--shared="))
-			shared_repository = git_config_perm("arg", arg+9);
-		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
-			flags |= INIT_DB_QUIET;
-		else
-			usage(init_db_usage);
+	int bare = 0;
+
+	const struct option options[] = {
+		OPT_STRING(0, "template", &template_dir, "dir",
+			   "directory from which templates will be used"),
+		OPT_BOOLEAN(0, "bare", &bare, "set up a bare repo"),
+		{ OPTION_CALLBACK, 0, "shared", &shared_repository,
+		  "type", "type of shared repository",
+		  PARSE_OPT_OPTARG, parse_opt_shared_cb, PERM_GROUP },
+		OPT_BIT('q', "quiet", &flags, "be quiet", INIT_DB_QUIET),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, options, init_db_usage, 0);
+
+	if (argc > 0)
+		usage_with_options(init_db_usage, options);
+
+	if (bare) {
+		static char git_dir[PATH_MAX+1];
+		is_bare_repository_cfg = 1;
+		setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir,
+					sizeof(git_dir)), 0);
 	}
 
 	/*
-- 
1.5.6.3
