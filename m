From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2 resend] help: add "man.viewer" config var to use "woman"
 or "konqueror"
Date: Fri, 7 Mar 2008 08:46:28 +0100
Message-ID: <20080307084628.0b311793.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>,
	Xavier Maillard <xma@gnu.org>,
	=?UTF-8?Q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97?=
	 =?UTF-8?Q?=E3=81=AA=E3=81=AA=E3=81=93?=
X-From: git-owner@vger.kernel.org Fri Mar 07 08:41:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXXCn-0002t9-J5
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 08:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163AbYCGHkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 02:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753731AbYCGHkr
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 02:40:47 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:60387 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022AbYCGHkq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 02:40:46 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 554F21AB2EA;
	Fri,  7 Mar 2008 08:40:44 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 743131AB2E3;
	Fri,  7 Mar 2008 08:40:43 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76465>

This patch makes it possible to view man pages using other tools
than the "man" program. It also implements support for emacs'
"woman" and konqueror with the man KIO slave to view man pages.

Note that "emacsclient" is used with option "-e" to launch "woman"
on emacs and this works only on versions >= 22.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 80 insertions(+), 1 deletions(-)

	Now that the run-command patch has been integrated, this
	seems to work as expected for me with emacsclient 21 and 22.

	Thanks.

diff --git a/help.c b/help.c
index e57a50e..2cb152d 100644
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
 
@@ -345,11 +350,85 @@ static void setup_man_path(void)
 	strbuf_release(&new_path);
 }
 
+static int check_emacsclient_version(void)
+{
+	struct strbuf buffer = STRBUF_INIT;
+	struct child_process ec_process;
+	const char *argv_ec[] = { "emacsclient", "--version", NULL };
+	int version;
+
+	/* emacsclient prints its version number on stderr */
+	memset(&ec_process, 0, sizeof(ec_process));
+	ec_process.argv = argv_ec;
+	ec_process.err = -1;
+	ec_process.stdout_to_stderr = 1;
+	if (start_command(&ec_process)) {
+		fprintf(stderr, "Failed to start emacsclient.\n");
+		return -1;
+	}
+	strbuf_read(&buffer, ec_process.err, 20);
+	close(ec_process.err);
+
+	/*
+	 * Don't bother checking return value, because "emacsclient --version"
+	 * seems to always exits with code 1.
+	 */
+	finish_command(&ec_process);
+
+	if (prefixcmp(buffer.buf, "emacsclient")) {
+		fprintf(stderr, "Failed to parse emacsclient version.\n");
+		strbuf_release(&buffer);
+		return -1;
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
+	} else
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
1.5.4.3.328.gcaed.dirty
