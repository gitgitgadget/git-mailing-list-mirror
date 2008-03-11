From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] help: implement multi-valued "man.viewer" config option
Date: Tue, 11 Mar 2008 08:51:12 +0100
Message-ID: <20080311085113.176df1af.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>,
	Xavier Maillard <xma@gnu.org>,
	=?UTF-8?Q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97?=
	 =?UTF-8?Q?=E3=81=AA=E3=81=AA=E3=81=93?=
X-From: git-owner@vger.kernel.org Tue Mar 11 08:46:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYzBf-00083h-Hu
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 08:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbYCKHph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 03:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbYCKHph
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 03:45:37 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:43495 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbYCKHpg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 03:45:36 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5C6681AB2C9;
	Tue, 11 Mar 2008 08:45:32 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id B23F81AB30F;
	Tue, 11 Mar 2008 08:45:31 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76808>

Junio suggested:
> How about allowing multi-valued man.viewer like this:
>
>        [man]
>                viewer = woman
>                viewer = konqueror
>                viewer = man
>
> and have:
>
>        static struct man_viewer {
>                char *name;
>                void (*exec)(const char *);
>        } viewers[] = {
>                { "woman", exec_woman },
>                { "konqueror", exec_konqueror },
>                { "man", exec_man },
>                { NULL, },
>        };
>
> Then you can iterate the man.viewer values, ask the viewer's
> exec() function to show the page (or return when it is not
> in an environment that it can be useful).
>
> show_man_page() would become:
>
>        for (each viewer in user's config)
>                viewer.exec(page); /* will return when unable */
>        die("no man viewer handled the request");

This patch implements the above using a list of exec functions that
is filled when reading the config.

To do that the exec functions have been moved before reading the
config. This makes the patch much longer than it would be otherwise.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c |  191 ++++++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 113 insertions(+), 78 deletions(-)

	This is on top of my previous "man.viewer" patches:

	[PATCH 1/2] help: add "man.viewer" config var to use "woman" or "konqueror"
	[PATCH 2/2] Documentation: help: describe 'man.viewer' config variable

diff --git a/help.c b/help.c
index 2cb152d..5da8c9c 100644
--- a/help.c
+++ b/help.c
@@ -10,7 +10,10 @@
 #include "parse-options.h"
 #include "run-command.h"
 
-static const char *man_viewer;
+static struct man_viewer_list {
+	void (*exec)(const char *);
+	struct man_viewer_list *next;
+} *man_viewer_list;
 
 enum help_format {
 	HELP_FORMAT_MAN,
@@ -45,6 +48,102 @@ static enum help_format parse_help_format(const char *format)
 	die("unrecognized help format '%s'", format);
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
+	}
+}
+
+static void exec_man_konqueror(const char *page)
+{
+	const char *display = getenv("DISPLAY");
+	if (display && *display) {
+		struct strbuf man_page = STRBUF_INIT;
+		strbuf_addf(&man_page, "man:%s(1)", page);
+		execlp("kfmclient", "kfmclient", "newTab", man_page.buf, NULL);
+	}
+}
+
+static void exec_man_man(const char *page)
+{
+	execlp("man", "man", page, NULL);
+}
+
+static void do_add_man_viewer(void (*exec)(const char *))
+{
+	struct man_viewer_list **p = &man_viewer_list;
+
+	while (*p)
+		p = &((*p)->next);
+	*p = xmalloc(sizeof(**p));
+	(*p)->next = NULL;
+	(*p)->exec = exec;
+}
+
+static int add_man_viewer(const char *value)
+{
+	if (!strcasecmp(value, "man"))
+		do_add_man_viewer(exec_man_man);
+	else if (!strcasecmp(value, "woman"))
+		do_add_man_viewer(exec_woman_emacs);
+	else if (!strcasecmp(value, "konqueror"))
+		do_add_man_viewer(exec_man_konqueror);
+	else
+		return error("'%s': unsupported man viewer.", value);
+
+	return 0;
+}
+
 static int git_help_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "help.format")) {
@@ -53,8 +152,11 @@ static int git_help_config(const char *var, const char *value)
 		help_format = parse_help_format(value);
 		return 0;
 	}
-	if (!strcmp(var, "man.viewer"))
-		return git_config_string(&man_viewer, var, value);
+	if (!strcmp(var, "man.viewer")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return add_man_viewer(value);
+	}
 	return git_default_config(var, value);
 }
 
@@ -350,85 +452,18 @@ static void setup_man_path(void)
 	strbuf_release(&new_path);
 }
 
-static int check_emacsclient_version(void)
-{
-	struct strbuf buffer = STRBUF_INIT;
-	struct child_process ec_process;
-	const char *argv_ec[] = { "emacsclient", "--version", NULL };
-	int version;
-
-	/* emacsclient prints its version number on stderr */
-	memset(&ec_process, 0, sizeof(ec_process));
-	ec_process.argv = argv_ec;
-	ec_process.err = -1;
-	ec_process.stdout_to_stderr = 1;
-	if (start_command(&ec_process)) {
-		fprintf(stderr, "Failed to start emacsclient.\n");
-		return -1;
-	}
-	strbuf_read(&buffer, ec_process.err, 20);
-	close(ec_process.err);
-
-	/*
-	 * Don't bother checking return value, because "emacsclient --version"
-	 * seems to always exits with code 1.
-	 */
-	finish_command(&ec_process);
-
-	if (prefixcmp(buffer.buf, "emacsclient")) {
-		fprintf(stderr, "Failed to parse emacsclient version.\n");
-		strbuf_release(&buffer);
-		return -1;
-	}
-
-	strbuf_remove(&buffer, 0, strlen("emacsclient"));
-	version = atoi(buffer.buf);
-
-	if (version < 22) {
-		fprintf(stderr,
-			"emacsclient version '%d' too old (< 22).\n",
-			version);
-		strbuf_release(&buffer);
-		return -1;
-	}
-
-	strbuf_release(&buffer);
-	return 0;
-}
-
-static void exec_woman_emacs(const char *page)
-{
-	if (!check_emacsclient_version()) {
-		/* This works only with emacsclient version >= 22. */
-		struct strbuf man_page = STRBUF_INIT;
-		strbuf_addf(&man_page, "(woman \"%s\")", page);
-		execlp("emacsclient", "emacsclient", "-e", man_page.buf, NULL);
-	} else
-		execlp("man", "man", page, NULL);
-}
-
-static void exec_man_konqueror(const char *page)
-{
-	const char *display = getenv("DISPLAY");
-	if (display && *display) {
-		struct strbuf man_page = STRBUF_INIT;
-		strbuf_addf(&man_page, "man:%s(1)", page);
-		execlp("kfmclient", "kfmclient", "newTab", man_page.buf, NULL);
-	} else
-		execlp("man", "man", page, NULL);
-}
-
 static void show_man_page(const char *git_cmd)
 {
+	struct man_viewer_list *viewer;
 	const char *page = cmd_to_page(git_cmd);
+
 	setup_man_path();
-	if (!man_viewer || !strcmp(man_viewer, "man"))
-		execlp("man", "man", page, NULL);
-	if (!strcmp(man_viewer, "woman"))
-		exec_woman_emacs(page);
-	if (!strcmp(man_viewer, "konqueror"))
-		exec_man_konqueror(page);
-	die("'%s': unsupported man viewer.", man_viewer);
+	for (viewer = man_viewer_list; viewer; viewer = viewer->next)
+	{
+		viewer->exec(page); /* will return when unable */
+	}
+	exec_man_man(page);
+	die("no man viewer handled the request");
 }
 
 static void show_info_page(const char *git_cmd)
-- 
1.5.4.4.595.g9c65
