From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/5] help: use man viewer path from "man.<tool>.path" config
 var
Date: Fri, 25 Apr 2008 08:24:22 +0200
Message-ID: <20080425082422.3a0cdd05.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>,
	Xavier Maillard <xma@gnu.org>,
	=?UTF-8?Q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97?=
	 =?UTF-8?Q?=E3=81=AA=E3=81=AA=E3=81=93?=
X-From: git-owner@vger.kernel.org Fri Apr 25 08:20:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpHI7-00013J-F3
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 08:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbYDYGTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 02:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755053AbYDYGTT
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 02:19:19 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:50979 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754994AbYDYGTS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 02:19:18 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 971DF1AB2DC;
	Fri, 25 Apr 2008 08:19:13 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id D102C1AB2CA;
	Fri, 25 Apr 2008 08:19:12 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80322>

This patch implements reading values from "man.<tool>.path"
configuration variables, and using these values as pathes to
the man viewer <tool>s when lauching them.

This makes it possible to use different version of the tools
than the one on the current PATH, or maybe a custom script.

In this patch we also try to launch "konqueror" using
"kfmclient" even if a path to a konqueror binary is given
in "man.konqueror.path".

The "man_viewer_list" becomes a simple string list to simplify
things for the following patches.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c |  143 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 124 insertions(+), 19 deletions(-)

	The main changes since previous version are:

	- "man_viewer_list" becomes a simple string list, so the function
	pointers have been removed as they are useless now,

	- "exec_man_konqueror" is more carefull when playing with a given
	path.

	So this patch is bigger than its previous version, but the following
	patch to add "man.<tool>.cmd" is smaller.

diff --git a/help.c b/help.c
index 10298fb..483e1e9 100644
--- a/help.c
+++ b/help.c
@@ -11,10 +11,16 @@
 #include "run-command.h"
 
 static struct man_viewer_list {
-	void (*exec)(const char *);
 	struct man_viewer_list *next;
+	char name[FLEX_ARRAY];
 } *man_viewer_list;
 
+static struct man_viewer_info_list {
+	struct man_viewer_info_list *next;
+	const char *info;
+	char name[FLEX_ARRAY];
+} *man_viewer_info_list;
+
 enum help_format {
 	HELP_FORMAT_MAN,
 	HELP_FORMAT_INFO,
@@ -49,6 +55,18 @@ static enum help_format parse_help_format(const char *format)
 	die("unrecognized help format '%s'", format);
 }
 
+static const char *get_man_viewer_info(const char *name)
+{
+	struct man_viewer_info_list *viewer;
+
+	for (viewer = man_viewer_info_list; viewer; viewer = viewer->next)
+	{
+		if (!strcasecmp(name, viewer->name))
+			return viewer->info;
+	}
+	return NULL;
+}
+
 static int check_emacsclient_version(void)
 {
 	struct strbuf buffer = STRBUF_INIT;
@@ -95,56 +113,126 @@ static int check_emacsclient_version(void)
 	return 0;
 }
 
-static void exec_woman_emacs(const char *page)
+static void exec_woman_emacs(const char* path, const char *page)
 {
 	if (!check_emacsclient_version()) {
 		/* This works only with emacsclient version >= 22. */
 		struct strbuf man_page = STRBUF_INIT;
+
+		if (!path)
+			path = "emacsclient";
 		strbuf_addf(&man_page, "(woman \"%s\")", page);
-		execlp("emacsclient", "emacsclient", "-e", man_page.buf, NULL);
+		execlp(path, "emacsclient", "-e", man_page.buf, NULL);
+		warning("failed to exec '%s': %s", path, strerror(errno));
 	}
 }
 
-static void exec_man_konqueror(const char *page)
+static void exec_man_konqueror(const char* path, const char *page)
 {
 	const char *display = getenv("DISPLAY");
 	if (display && *display) {
 		struct strbuf man_page = STRBUF_INIT;
+		const char *filename = "kfmclient";
+
+		/* It's simpler to launch konqueror using kfmclient. */
+		if (path) {
+			const char *file = strrchr(path, '/');
+			if (file && !strcmp(file + 1, "konqueror")) {
+				char *new = xstrdup(path);
+				char *dest = strrchr(new, '/');
+
+				/* strlen("konqueror") == strlen("kfmclient") */
+				strcpy(dest + 1, "kfmclient");
+				path = new;
+			}
+			if (file)
+				filename = file;
+		} else
+			path = "kfmclient";
 		strbuf_addf(&man_page, "man:%s(1)", page);
-		execlp("kfmclient", "kfmclient", "newTab", man_page.buf, NULL);
+		execlp(path, filename, "newTab", man_page.buf, NULL);
+		warning("failed to exec '%s': %s", path, strerror(errno));
 	}
 }
 
-static void exec_man_man(const char *page)
+static void exec_man_man(const char* path, const char *page)
 {
-	execlp("man", "man", page, NULL);
+	if (!path)
+		path = "man";
+	execlp(path, "man", page, NULL);
+	warning("failed to exec '%s': %s", path, strerror(errno));
 }
 
-static void do_add_man_viewer(void (*exec)(const char *))
+static void do_add_man_viewer(const char *name)
 {
 	struct man_viewer_list **p = &man_viewer_list;
+	size_t len = strlen(name);
 
 	while (*p)
 		p = &((*p)->next);
-	*p = xmalloc(sizeof(**p));
-	(*p)->next = NULL;
-	(*p)->exec = exec;
+	*p = xcalloc(1, (sizeof(**p) + len + 1));
+	strncpy((*p)->name, name, len);
+}
+
+static int supported_man_viewer(const char *name, size_t len)
+{
+	return (!strncasecmp("man", name, len) ||
+		!strncasecmp("woman", name, len) ||
+		!strncasecmp("konqueror", name, len));
 }
 
 static int add_man_viewer(const char *value)
 {
-	if (!strcasecmp(value, "man"))
-		do_add_man_viewer(exec_man_man);
-	else if (!strcasecmp(value, "woman"))
-		do_add_man_viewer(exec_woman_emacs);
-	else if (!strcasecmp(value, "konqueror"))
-		do_add_man_viewer(exec_man_konqueror);
+	if (supported_man_viewer(value, strlen(value)))
+		do_add_man_viewer(value);
 	else
 		warning("'%s': unsupported man viewer.", value);
 
 	return 0;
 }
 
+static void do_add_man_viewer_info(const char *name,
+				   size_t len,
+				   const char *value)
+{
+	struct man_viewer_info_list *new = xcalloc(1, sizeof(*new) + len + 1);
+
+	strncpy(new->name, name, len);
+	new->info = xstrdup(value);
+	new->next = man_viewer_info_list;
+	man_viewer_info_list = new;
+}
+
+static int add_man_viewer_path(const char *name,
+			       size_t len,
+			       const char *value)
+{
+	if (supported_man_viewer(name, len))
+		do_add_man_viewer_info(name, len, value);
+	else
+		warning("'%s': path for unsupported man viewer.", name);
+
+	return 0;
+}
+
+static int add_man_viewer_info(const char *var, const char *value)
+{
+	const char *name = var + 4;
+	const char *subkey = strrchr(name, '.');
+
+	if (!subkey)
+		return error("Config with no key for man viewer: %s", name);
+
+	if (!strcmp(subkey, ".path")) {
+		if (!value)
+			return config_error_nonbool(var);
+		return add_man_viewer_path(name, subkey - name, value);
+	}
+
+	warning("'%s': unsupported man viewer sub key.", subkey);
+	return 0;
+}
+
 static int git_help_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "help.format")) {
@@ -158,6 +246,9 @@ static int git_help_config(const char *var, const char *value)
 			return config_error_nonbool(var);
 		return add_man_viewer(value);
 	}
+	if (!prefixcmp(var, "man."))
+		return add_man_viewer_info(var, value);
+
 	return git_default_config(var, value);
 }
 
@@ -453,6 +544,20 @@ static void setup_man_path(void)
 	strbuf_release(&new_path);
 }
 
+static void exec_viewer(const char *name, const char *page)
+{
+	const char *path = get_man_viewer_info(name);
+
+	if (!strcasecmp(name, "man"))
+		exec_man_man(path, page);
+	else if (!strcasecmp(name, "woman"))
+		exec_woman_emacs(path, page);
+	else if (!strcasecmp(name, "konqueror"))
+		exec_man_konqueror(path, page);
+	else
+		warning("'%s': unsupported man viewer.", name);
+}
+
 static void show_man_page(const char *git_cmd)
 {
 	struct man_viewer_list *viewer;
@@ -461,9 +566,9 @@ static void show_man_page(const char *git_cmd)
 	setup_man_path();
 	for (viewer = man_viewer_list; viewer; viewer = viewer->next)
 	{
-		viewer->exec(page); /* will return when unable */
+		exec_viewer(viewer->name, page); /* will return when unable */
 	}
-	exec_man_man(page);
+	exec_viewer("man", page);
 	die("no man viewer handled the request");
 }
 
-- 
1.5.5.1.142.g5a727.dirty
