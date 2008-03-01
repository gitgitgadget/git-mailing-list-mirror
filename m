From: Xavier Maillard <xma@gnu.org>
Subject: [PATCH AMENDED] help: add "man.viewer" config var to use "woman" or "konqueror"
Date: Sat, 1 Mar 2008 02:00:31 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803010100.m2110ULs008889@localhost.localdomain>
References: <200802290814.39366.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 02:35:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVGcw-0001az-Pi
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 02:35:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985AbYCABe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 20:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbYCABe0
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 20:34:26 -0500
Received: from master.uucpssh.org ([193.218.105.66]:34187 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbYCABeY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 20:34:24 -0500
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 26983C9363; Sat,  1 Mar 2008 02:33:01 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2110e4o008915
	for <git@vger.kernel.org>; Sat, 1 Mar 2008 02:00:41 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2110ULs008889;
	Sat, 1 Mar 2008 02:00:31 +0100
In-Reply-To: <200802290814.39366.chriscool@tuxfamily.org>
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.4,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -2.60,
	SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75599>


This patch makes it possible to view man pages using other tools
than the "man" program. It also implements support for emacs'
"woman" and konqueror with the man KIO slave to view man pages.

Note that "emacsclient" is used with option "-e" to launch "woman"
on GNU emacs and this works only on versions >= 22.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Amended-by: Xavier Maillard <xma@gnu.org>
---
I have tested it with emacsclient 22.x and 23.x. Previous
versions won't work at the moment.

 help.c |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 84 insertions(+), 1 deletions(-)

diff --git a/help.c b/help.c
index e57a50e..eb138f0 100644
--- a/help.c
+++ b/help.c
@@ -8,6 +8,9 @@
 #include "exec_cmd.h"
 #include "common-cmds.h"
 #include "parse-options.h"
+#include "run-command.h"
+
+static const char *man_viewer;
 
 enum help_format {
 	HELP_FORMAT_MAN,
@@ -50,6 +53,8 @@ static int git_help_config(const char *var, const char *value)
 		help_format = parse_help_format(value);
 		return 0;
 	}
+	if (!strcmp(var, "man.viewer"))
+		return git_config_string(&man_viewer, var, value);
 	return git_default_config(var, value);
 }
 
@@ -345,11 +350,89 @@ static void setup_man_path(void)
 	strbuf_release(&new_path);
 }
 
+static int check_emacsclient_version(void)
+{
+	struct strbuf buffer = STRBUF_INIT;
+	struct child_process ec_process;
+
+	const char *argv_ec[] = { "emacsclient", "--version", NULL };
+	int version;
+	size_t len;
+
+	/* emacsclient prints its version number on stdout */
+	memset(&ec_process, 0, sizeof(ec_process));
+	ec_process.argv = argv_ec;
+	ec_process.out = -1;
+	ec_process.stdout_to_stderr = 0;
+
+	if (start_command(&ec_process))
+		return error("Failed to start emacsclient.");
+
+	len = strbuf_read(&buffer, ec_process.out, 20);
+	close(ec_process.out);
+
+	/*
+	 * Don't bother checking return value, because "emacsclient --version"
+	 * always exits with code 0.
+	 */
+	finish_command(&ec_process);
+
+	if (!&buffer)
+		return -1;
+
+	if (!len || len < 0 || prefixcmp(buffer.buf, "emacsclient")) {
+		strbuf_release(&buffer);
+		return error("Failed to parse emacsclient version.");
+	}
+
+	strbuf_remove(&buffer, 0, strlen("emacsclient"));
+	version = atoi(buffer.buf);
+
+	if (version < 22) {
+		fprintf(stderr,
+			"emacsclient version '%d' too old (< 22).\n",
+			version);
+		strbuf_release(&buffer);
+		return -1;
+	}
+
+	strbuf_release(&buffer);
+	return 0;
+}
+
+static void exec_woman_emacs(const char *page)
+{
+	if (!check_emacsclient_version()) {
+		/* This works only with emacsclient version >= 22. */
+		struct strbuf man_page = STRBUF_INIT;
+		strbuf_addf(&man_page, "(woman \"%s\")", page);
+		execlp("emacsclient", "emacsclient", "-e", man_page.buf, NULL);
+	} else // revert to old good man program
+		execlp("man", "man", page, NULL);
+}
+
+static void exec_man_konqueror(const char *page)
+{
+	const char *display = getenv("DISPLAY");
+	if (display && *display) {
+		struct strbuf man_page = STRBUF_INIT;
+		strbuf_addf(&man_page, "man:%s(1)", page);
+		execlp("kfmclient", "kfmclient", "newTab", man_page.buf, NULL);
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
-- 
1.5.4.3.343.gc696
