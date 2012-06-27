From: Chris Webb <chris@arachsys.com>
Subject: [PATCH 3/3] Add a help format 'usage' to provide brief command usage
Date: Wed, 27 Jun 2012 21:55:14 +0100
Message-ID: <d568dccf0563742181269aa9a675b3c87d54ef01.1340830514.git.chris@arachsys.com>
References: <20120627205459.GC11498@arachsys.com>
Cc: chris@arachsys.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 22:55:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjzGr-0002rq-CN
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 22:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142Ab2F0UzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 16:55:25 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:43625 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756761Ab2F0UzY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 16:55:24 -0400
Received: from [81.2.114.212] (helo=miranda.home.)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SjzGl-0002NM-0F; Wed, 27 Jun 2012 21:55:23 +0100
X-Mailer: git-send-email 1.7.10
In-Reply-To: <20120627205459.GC11498@arachsys.com>
In-Reply-To: <8d3c71d21710c66e4d5560cec958552b69a22338.1340830514.git.chris@arachsys.com>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340830514.git.chris@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200748>

Configuring the new help.format = usage makes git foo --help exactly
equivalent to git foo -h, displaying brief command-line usage info
instead of full documentation in the form of a man/html page.

This is useful on stripped-down servers where man pages and viewer
aren't present, or if your fingers are trained to type COMMAND --help
instead of COMMAND -h to get usage info and the man page behaviour is
disturbing.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 builtin/help.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 60b3251..d4c3f5d 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -31,7 +31,8 @@ enum help_format {
 	HELP_FORMAT_NONE,
 	HELP_FORMAT_MAN,
 	HELP_FORMAT_INFO,
-	HELP_FORMAT_WEB
+	HELP_FORMAT_WEB,
+	HELP_FORMAT_USAGE
 };
 
 static char *html_path = NULL;
@@ -46,11 +47,12 @@ static struct option builtin_help_options[] = {
 			HELP_FORMAT_WEB),
 	OPT_SET_INT('i', "info", &help_format, "show info page",
 			HELP_FORMAT_INFO),
+	OPT_SET_INT('u', "usage", &help_format, "show usage", HELP_FORMAT_USAGE),
 	OPT_END(),
 };
 
 static const char * const builtin_help_usage[] = {
-	"git help [--all] [--man|--web|--info] [command]",
+	"git help [--all] [--man|--web|--info|--usage] [command]",
 	NULL
 };
 
@@ -62,6 +64,8 @@ static enum help_format parse_help_format(const char *format)
 		return HELP_FORMAT_INFO;
 	if (!strcmp(format, "web") || !strcmp(format, "html"))
 		return HELP_FORMAT_WEB;
+	if (!strcmp(format, "usage"))
+		return HELP_FORMAT_USAGE;
 	die(_("unrecognized help format '%s'"), format);
 }
 
@@ -431,6 +435,11 @@ static void show_html_page(const char *git_cmd)
 	open_html(page_path.buf);
 }
 
+static void show_usage(const char *git_cmd)
+{
+	execl_git_cmd(git_cmd, "-h", NULL);
+}
+
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	int nongit;
@@ -482,6 +491,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	case HELP_FORMAT_WEB:
 		show_html_page(argv[0]);
 		break;
+	case HELP_FORMAT_USAGE:
+		show_usage(argv[0]);
+		break;
 	}
 
 	return 0;
-- 
1.7.10
