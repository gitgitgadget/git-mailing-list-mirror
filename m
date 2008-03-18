From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] help: use man viewer path from "man.<tool>.path" config
 var
Date: Tue, 18 Mar 2008 06:22:36 +0100
Message-ID: <20080318062236.7b5e515f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>,
	Xavier Maillard <xma@gnu.org>,
	=?UTF-8?Q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97?=
	 =?UTF-8?Q?=E3=81=AA=E3=81=AA=E3=81=93?=
X-From: git-owner@vger.kernel.org Tue Mar 18 06:17:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbUCo-0001U3-9Z
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 06:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbYCRFRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 01:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbYCRFRF
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 01:17:05 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:37996 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706AbYCRFRD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 01:17:03 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BD68E1AB2B5;
	Tue, 18 Mar 2008 06:17:01 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 0C3341AB2BD;
	Tue, 18 Mar 2008 06:17:01 +0100 (CET)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77489>

This patch implements reading values from "man.<tool>.path"
configuration variables, and using these values as pathes to
the man viewer <tool>s when lauching them.

This makes it possible to use different version of the tools
than the one on the current PATH, or maybe a custom script.

In this patch we also try to launch "konqueror" using
"kfmclient" even if a path to a konqueror binary is given
in "man.konqueror.path".

And we add warnings after "exec" calls in case of exec errors. 

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/help.c b/help.c
index ecaca77..fd88c22 100644
--- a/help.c
+++ b/help.c
@@ -15,6 +15,12 @@ static struct man_viewer_list {
 	struct man_viewer_list *next;
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
@@ -48,6 +54,18 @@ static enum help_format parse_help_format(const char *format)
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
@@ -99,8 +117,13 @@ static void exec_woman_emacs(const char *page)
 	if (!check_emacsclient_version()) {
 		/* This works only with emacsclient version >= 22. */
 		struct strbuf man_page = STRBUF_INIT;
+		const char *path = get_man_viewer_info("woman");
+
+		if (!path)
+			path = "emacsclient";
 		strbuf_addf(&man_page, "(woman \"%s\")", page);
-		execlp("emacsclient", "emacsclient", "-e", man_page.buf, NULL);
+		execlp(path, "emacsclient", "-e", man_page.buf, NULL);
+		warning("failed to exec '%s': %s", path, strerror(errno));
 	}
 }
 
@@ -109,14 +132,35 @@ static void exec_man_konqueror(const char *page)
 	const char *display = getenv("DISPLAY");
 	if (display && *display) {
 		struct strbuf man_page = STRBUF_INIT;
+		const char *path = get_man_viewer_info("konqueror");
+
+		/* It's simpler to launch konqueror using kfmclient. */
+		if (path) {
+			const char *file = strrchr(path, '/') + 1;
+			if (!strcmp(file, "konqueror")) {
+				char *new = xstrdup(path);
+				char *dest = strrchr(new, '/') + 1;
+
+				/* strlen("konqueror") == strlen("kfmclient") */
+				strcpy(dest, "kfmclient");
+				path = new;
+			}
+		} else
+			path = "kfmclient";
 		strbuf_addf(&man_page, "man:%s(1)", page);
-		execlp("kfmclient", "kfmclient", "newTab", man_page.buf, NULL);
+		execlp(path, "kfmclient", "newTab", man_page.buf, NULL);
+		warning("failed to exec '%s': %s", path, strerror(errno));
 	}
 }
 
 static void exec_man_man(const char *page)
 {
-	execlp("man", "man", page, NULL);
+	const char *path = get_man_viewer_info("man");
+
+	if (!path)
+		path = "man";
+	execlp(path, "man", page, NULL);
+	warning("failed to exec '%s': %s", path, strerror(errno));
 }
 
 static void do_add_man_viewer(void (*exec)(const char *))
@@ -144,6 +188,50 @@ static int add_man_viewer(const char *value)
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
+	if (!strncasecmp("man", name, len) ||
+	    !strncasecmp("woman", name, len) ||
+	    !strncasecmp("konqueror", name, len))
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
@@ -157,6 +245,9 @@ static int git_help_config(const char *var, const char *value)
 			return config_error_nonbool(var);
 		return add_man_viewer(value);
 	}
+	if (!prefixcmp(var, "man."))
+		return add_man_viewer_info(var, value);
+
 	return git_default_config(var, value);
 }
 
-- 
1.5.4.4.685.g3070a.dirty
