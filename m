From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] help: use parseopt
Date: Sun, 24 Feb 2008 17:16:55 -0500
Message-ID: <20080224221655.GB31309@coredump.intra.peff.net>
References: <cover.1203890846.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:17:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTPA7-0002uG-W2
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 23:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbYBXWQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 17:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbYBXWQ6
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 17:16:58 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4543 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbYBXWQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 17:16:57 -0500
Received: (qmail 2355 invoked by uid 111); 24 Feb 2008 22:16:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Feb 2008 17:16:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Feb 2008 17:16:55 -0500
Content-Disposition: inline
In-Reply-To: <cover.1203890846.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74968>

This patch converts cmd_help to use parseopt, along with a
few style cleanups, including:

  - enum constants are now ALL_CAPS

  - parse_help_format returns an enum value rather than
    setting a global as a side effect

Signed-off-by: Jeff King <peff@peff.net>
---
Sorry, the diff turned out quite messy because of the cleanups. It's
probably easier to just read the result.

 help.c |  123 ++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 59 insertions(+), 64 deletions(-)

diff --git a/help.c b/help.c
index 8143dcd..5feb849 100644
--- a/help.c
+++ b/help.c
@@ -7,40 +7,49 @@
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "common-cmds.h"
-
-static const char *help_default_format;
-
-static enum help_format {
-	man_format,
-	info_format,
-	web_format,
-} help_format = man_format;
-
-static void parse_help_format(const char *format)
+#include "parse-options.h"
+
+enum help_format {
+	HELP_FORMAT_MAN,
+	HELP_FORMAT_INFO,
+	HELP_FORMAT_WEB,
+};
+
+static int show_all = 0;
+static enum help_format help_format = HELP_FORMAT_MAN;
+static struct option builtin_help_options[] = {
+	OPT_BOOLEAN('a', "all", &show_all, "print all available commands"),
+	OPT_SET_INT('m', "man", &help_format, "show man page", HELP_FORMAT_MAN),
+	OPT_SET_INT('w', "web", &help_format, "show manual in web browser",
+			HELP_FORMAT_WEB),
+	OPT_SET_INT('i', "info", &help_format, "show info page",
+			HELP_FORMAT_INFO),
+};
+
+static const char * const builtin_help_usage[] = {
+	"git-help [--all] [--man|--web|--info] [command]",
+	NULL
+};
+
+static enum help_format parse_help_format(const char *format)
 {
-	if (!format) {
-		help_format = man_format;
-		return;
-	}
-	if (!strcmp(format, "man")) {
-		help_format = man_format;
-		return;
-	}
-	if (!strcmp(format, "info")) {
-		help_format = info_format;
-		return;
-	}
-	if (!strcmp(format, "web") || !strcmp(format, "html")) {
-		help_format = web_format;
-		return;
-	}
+	if (!strcmp(format, "man"))
+		return HELP_FORMAT_MAN;
+	if (!strcmp(format, "info"))
+		return HELP_FORMAT_INFO;
+	if (!strcmp(format, "web") || !strcmp(format, "html"))
+		return HELP_FORMAT_WEB;
 	die("unrecognized help format '%s'", format);
 }
 
 static int git_help_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "help.format"))
-		return git_config_string(&help_default_format, var, value);
+	if (!strcmp(var, "help.format")) {
+		if (!value)
+			return config_error_nonbool(var);
+		help_format = parse_help_format(value);
+		return 0;
+	}
 	return git_default_config(var, value);
 }
 
@@ -362,50 +371,36 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
-	const char *help_cmd = argv[1];
+	int nongit;
 
-	if (argc < 2) {
-		printf("usage: %s\n\n", git_usage_string);
-		list_common_cmds_help();
-		exit(0);
-	}
+	setup_git_directory_gently(&nongit);
+	git_config(git_help_config);
 
-	if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
+	argc = parse_options(argc, argv, builtin_help_options,
+			builtin_help_usage, 0);
+
+	if (show_all) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_commands();
+		return 0;
 	}
 
-	else if (!strcmp(help_cmd, "--web") || !strcmp(help_cmd, "-w")) {
-		show_html_page(argc > 2 ? argv[2] : NULL);
-	}
-
-	else if (!strcmp(help_cmd, "--info") || !strcmp(help_cmd, "-i")) {
-		show_info_page(argc > 2 ? argv[2] : NULL);
-	}
-
-	else if (!strcmp(help_cmd, "--man") || !strcmp(help_cmd, "-m")) {
-		show_man_page(argc > 2 ? argv[2] : NULL);
+	if (!argv[0]) {
+		printf("usage: %s\n\n", git_usage_string);
+		list_common_cmds_help();
+		return 0;
 	}
 
-	else {
-		int nongit;
-
-		setup_git_directory_gently(&nongit);
-		git_config(git_help_config);
-		if (help_default_format)
-			parse_help_format(help_default_format);
-
-		switch (help_format) {
-		case man_format:
-			show_man_page(help_cmd);
-			break;
-		case info_format:
-			show_info_page(help_cmd);
-			break;
-		case web_format:
-			show_html_page(help_cmd);
-			break;
-		}
+	switch (help_format) {
+	case HELP_FORMAT_MAN:
+		show_man_page(argv[0]);
+		break;
+	case HELP_FORMAT_INFO:
+		show_info_page(argv[0]);
+		break;
+	case HELP_FORMAT_WEB:
+		show_html_page(argv[0]);
+		break;
 	}
 
 	return 0;
-- 
1.5.4.3.305.g073a4
