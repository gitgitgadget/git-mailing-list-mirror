From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] help: use "man.<tool>.cmd" as custom man viewer command
Date: Fri, 21 Mar 2008 08:07:18 +0100
Message-ID: <20080321080718.315458f2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>,
	Xavier Maillard <xma@gnu.org>,
	=?UTF-8?Q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97?=
	 =?UTF-8?Q?=E3=81=AA=E3=81=AA=E3=81=93?=
X-From: git-owner@vger.kernel.org Fri Mar 21 08:02:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcbGk-0000mn-J9
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 08:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbYCUHBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 03:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753514AbYCUHBp
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 03:01:45 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:34386 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753413AbYCUHBo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 03:01:44 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id F38281AB2D8;
	Fri, 21 Mar 2008 08:01:42 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 600691AB2BB;
	Fri, 21 Mar 2008 08:01:42 +0100 (CET)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77725>

Currently "git help -m GITCMD" is restricted to a set of man
viewers defined at compile time. You can subvert the
"man.<tool>.path" to force "git help -m" to use a different man,
viewer, but if you have a man viewer whose invocation syntax does
not match one of the current tools then you would have to write a
wrapper script for it.

This patch adds a git config variable "man.<tool>.cmd" which
allows a more flexible man viewer choice.

If you run "git help -m GITCMD" with the "man.viewer" config
variable set to an unrecognized tool then it will query the
"man.<tool>.cmd" config variable. If this variable exists, then
the specified tool will be treated as a custom man viewer and it
will be run in a shell with the man page name of the GITCMD added
as extra parameter.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c |   79 +++++++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 59 insertions(+), 20 deletions(-)

	This patch applies on top of my previous patches:

	[PATCH 1/2] help: use man viewer path from "man.<tool>.path" config var
	[PATCH 2/2] documentation: help: add "man.<tool>.path" config variable


diff --git a/help.c b/help.c
index fd88c22..b907dd9 100644
--- a/help.c
+++ b/help.c
@@ -11,8 +11,9 @@
 #include "run-command.h"
 
 static struct man_viewer_list {
-	void (*exec)(const char *);
 	struct man_viewer_list *next;
+	void (*exec)(const char *, const char *);
+	char name[FLEX_ARRAY];
 } *man_viewer_list;
 
 static struct man_viewer_info_list {
@@ -112,12 +113,11 @@ static int check_emacsclient_version(void)
 	return 0;
 }
 
-static void exec_woman_emacs(const char *page)
+static void exec_woman_emacs(const char *page, const char *path)
 {
 	if (!check_emacsclient_version()) {
 		/* This works only with emacsclient version >= 22. */
 		struct strbuf man_page = STRBUF_INIT;
-		const char *path = get_man_viewer_info("woman");
 
 		if (!path)
 			path = "emacsclient";
@@ -127,12 +127,11 @@ static void exec_woman_emacs(const char *page)
 	}
 }
 
-static void exec_man_konqueror(const char *page)
+static void exec_man_konqueror(const char *page, const char *path)
 {
 	const char *display = getenv("DISPLAY");
 	if (display && *display) {
 		struct strbuf man_page = STRBUF_INIT;
-		const char *path = get_man_viewer_info("konqueror");
 
 		/* It's simpler to launch konqueror using kfmclient. */
 		if (path) {
@@ -153,37 +152,45 @@ static void exec_man_konqueror(const char *page)
 	}
 }
 
-static void exec_man_man(const char *page)
+static void exec_man_man(const char *page, const char *path)
 {
-	const char *path = get_man_viewer_info("man");
-
 	if (!path)
 		path = "man";
 	execlp(path, "man", page, NULL);
 	warning("failed to exec '%s': %s", path, strerror(errno));
 }
 
-static void do_add_man_viewer(void (*exec)(const char *))
+static void exec_man_cmd(const char *page, const char *cmd)
+{
+	struct strbuf shell_cmd = STRBUF_INIT;
+	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
+	execl("/bin/sh", "sh", "-c", shell_cmd.buf, NULL);
+	warning("failed to exec '%s': %s", cmd, strerror(errno));
+}
+
+static void do_add_man_viewer(void (*exec)(const char *, const char *),
+			      const char *name)
 {
 	struct man_viewer_list **p = &man_viewer_list;
+	size_t len = strlen(name);
 
 	while (*p)
 		p = &((*p)->next);
-	*p = xmalloc(sizeof(**p));
-	(*p)->next = NULL;
+	*p = xcalloc(1, sizeof(**p) + len + 1);
+	strncpy((*p)->name, name, len);
 	(*p)->exec = exec;
 }
 
 static int add_man_viewer(const char *value)
 {
 	if (!strcasecmp(value, "man"))
-		do_add_man_viewer(exec_man_man);
+		do_add_man_viewer(exec_man_man, value);
 	else if (!strcasecmp(value, "woman"))
-		do_add_man_viewer(exec_woman_emacs);
+		do_add_man_viewer(exec_woman_emacs, value);
 	else if (!strcasecmp(value, "konqueror"))
-		do_add_man_viewer(exec_man_konqueror);
+		do_add_man_viewer(exec_man_konqueror, value);
 	else
-		warning("'%s': unsupported man viewer.", value);
+		do_add_man_viewer(exec_man_cmd, value);
 
 	return 0;
 }
@@ -200,13 +207,18 @@ static void do_add_man_viewer_info(const char *name,
 	man_viewer_info_list = new;
 }
 
+static int supported_man_viewer(const char *name, size_t len)
+{
+	return (!strncasecmp("man", name, len) ||
+		!strncasecmp("woman", name, len) ||
+		!strncasecmp("konqueror", name, len));
+}
+
 static int add_man_viewer_path(const char *name,
 			       size_t len,
 			       const char *value)
 {
-	if (!strncasecmp("man", name, len) ||
-	    !strncasecmp("woman", name, len) ||
-	    !strncasecmp("konqueror", name, len))
+	if (supported_man_viewer(name, len))
 		do_add_man_viewer_info(name, len, value);
 	else
 		warning("'%s': path for unsupported man viewer.", name);
@@ -214,6 +226,20 @@ static int add_man_viewer_path(const char *name,
 	return 0;
 }
 
+static int add_man_viewer_cmd(const char *name,
+			      size_t len,
+			      const char *value)
+{
+	if (supported_man_viewer(name, len))
+		warning("'%s': cmd for supported man viewer.\n"
+			"Please consider using 'man.<tool>.path' instead.",
+			name);
+	else
+		do_add_man_viewer_info(name, len, value);
+
+	return 0;
+}
+
 static int add_man_viewer_info(const char *var, const char *value)
 {
 	const char *name = var + 4;
@@ -227,6 +253,11 @@ static int add_man_viewer_info(const char *var, const char *value)
 			return config_error_nonbool(var);
 		return add_man_viewer_path(name, subkey - name, value);
 	}
+	if (!strcmp(subkey, ".cmd")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return add_man_viewer_cmd(name, subkey - name, value);
+	}
 
 	warning("'%s': unsupported man viewer sub key.", subkey);
 	return 0;
@@ -546,14 +577,22 @@ static void setup_man_path(void)
 static void show_man_page(const char *git_cmd)
 {
 	struct man_viewer_list *viewer;
+	const char *info;
 	const char *page = cmd_to_page(git_cmd);
 
 	setup_man_path();
 	for (viewer = man_viewer_list; viewer; viewer = viewer->next)
 	{
-		viewer->exec(page); /* will return when unable */
+		int supported = supported_man_viewer(viewer->name,
+						     strlen(viewer->name));
+		info = get_man_viewer_info(viewer->name);
+		if (supported || info)
+			viewer->exec(page, info); /* will return when unable */
+		else
+			warning("%s: unknown man viewer", viewer->name);
 	}
-	exec_man_man(page);
+	info = get_man_viewer_info("man");
+	exec_man_man(page, info);
 	die("no man viewer handled the request");
 }
 
-- 
1.5.5.rc0.124.g91c15.dirty
