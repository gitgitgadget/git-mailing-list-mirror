From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] help: add "man.viewer" config var to use "woman" or
 "konqueror"
Date: Sun, 17 Feb 2008 20:52:52 +0100
Message-ID: <20080217205252.ff7ea434.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 20:47:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQpUC-0001FK-ST
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 20:47:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbYBQTrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 14:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbYBQTrH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 14:47:07 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:58019 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377AbYBQTrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 14:47:05 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B103D1AB355;
	Sun, 17 Feb 2008 20:47:03 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id DF5FB1AB352;
	Sun, 17 Feb 2008 20:47:02 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74175>

This patch makes it possible to view man pages using other tools
than the "man" program. It also implements support for emacs'
"woman" and konqueror (using the man KIO slave) to view man pages.

Note that "emacsclient" is used with option "-e" to launch "woman"
on emacs and this works only on versions >= 22, but currently
the "emacsclient" version is not checked.

It should also perhaps try to use kfmclient to launch konqueror
in a new tab, like it's done in "git-web-browse". 

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c |   40 +++++++++++++++++++++++++++++++++++-----
 1 files changed, 35 insertions(+), 5 deletions(-)

	This is a first draft to know what you think about the
	idea and if you have some suggestions about testing
	emacsclient version.

diff --git a/help.c b/help.c
index 8143dcd..6b0e599 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,7 @@
 #include "common-cmds.h"
 
 static const char *help_default_format;
+static const char *man_viewer;
 
 static enum help_format {
 	man_format,
@@ -41,6 +42,8 @@ static int git_help_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "help.format"))
 		return git_config_string(&help_default_format, var, value);
+	if (!strcmp(var, "man.viewer"))
+		return git_config_string(&man_viewer, var, value);
 	return git_default_config(var, value);
 }
 
@@ -312,11 +315,38 @@ static void setup_man_path(void)
 	strbuf_release(&new_path);
 }
 
+static void exec_woman_emacs(const char *page)
+{
+	/*
+	 * FIXME: This works only with emacsclient version >= 22.
+	 */
+	struct strbuf man_page = STRBUF_INIT;
+	strbuf_addf(&man_page, "(woman \"%s\")", page);
+	execlp("emacsclient", "emacsclient", "-e", man_page.buf, NULL);
+}
+
+static void exec_man_konqueror(const char *page)
+{
+	const char *display = getenv("DISPLAY");
+	if (display && *display) {
+		struct strbuf man_page = STRBUF_INIT;
+		strbuf_addf(&man_page, "man:%s(1)", page);
+		execlp("konqueror", "konqueror", man_page.buf, NULL);
+	} else
+		execlp("man", "man", page, NULL);
+}
+
 static void show_man_page(const char *git_cmd)
 {
 	const char *page = cmd_to_page(git_cmd);
 	setup_man_path();
-	execlp("man", "man", page, NULL);
+	if (!man_viewer || !strcmp(man_viewer, "man"))
+		execlp("man", "man", page, NULL);
+	if (!strcmp(man_viewer, "woman"))
+		exec_woman_emacs(page);
+	if (!strcmp(man_viewer, "konqueror"))
+		exec_man_konqueror(page);
+	die("'%s': unsupported man viewer.", man_viewer);
 }
 
 static void show_info_page(const char *git_cmd)
@@ -363,6 +393,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 int cmd_help(int argc, const char **argv, const char *prefix)
 {
 	const char *help_cmd = argv[1];
+	int nongit;
 
 	if (argc < 2) {
 		printf("usage: %s\n\n", git_usage_string);
@@ -370,6 +401,9 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		exit(0);
 	}
 
+	setup_git_directory_gently(&nongit);
+	git_config(git_help_config);
+
 	if (!strcmp(help_cmd, "--all") || !strcmp(help_cmd, "-a")) {
 		printf("usage: %s\n\n", git_usage_string);
 		list_commands();
@@ -388,10 +422,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	}
 
 	else {
-		int nongit;
-
-		setup_git_directory_gently(&nongit);
-		git_config(git_help_config);
 		if (help_default_format)
 			parse_help_format(help_default_format);
 
-- 
1.5.4.1.1384.gdeff
