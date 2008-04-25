From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/5] help: use "man.<tool>.cmd" as custom man viewer command
Date: Fri, 25 Apr 2008 08:24:58 +0200
Message-ID: <20080425082458.bfc113ac.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>,
	Xavier Maillard <xma@gnu.org>,
	=?UTF-8?Q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97?=
	 =?UTF-8?Q?=E3=81=AA=E3=81=AA=E3=81=93?=
X-From: git-owner@vger.kernel.org Fri Apr 25 08:20:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpHIU-00018T-QD
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 08:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390AbYDYGTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 02:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755386AbYDYGTv
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 02:19:51 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:51244 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274AbYDYGTu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 02:19:50 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 857E01AB2D5;
	Fri, 25 Apr 2008 08:19:49 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 32AF11AB2C5;
	Fri, 25 Apr 2008 08:19:49 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80324>

Currently "git help -m GITCMD" is restricted to a set of man viewers
defined at compile time. You can subvert the "man.<tool>.path" to
force "git help -m" to use a different man, viewer, but if you have a
man viewer whose invocation syntax does not match one of the current
tools then you would have to write a wrapper script for it.

This patch adds a git config variable "man.<tool>.cmd" which allows a
more flexible man viewer choice.

If you run "git help -m GITCMD" with the "man.viewer" config variable
set to an unrecognized tool then it will query the "man.<tool>.cmd"
config variable. If this variable exists, then the specified tool will
be treated as a custom man viewer and it will be run in a shell with
the man page name of the GITCMD added as extra parameter.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c |   58 ++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/help.c b/help.c
index 7373aa2..eb13e9a 100644
--- a/help.c
+++ b/help.c
@@ -160,7 +160,15 @@ static void exec_man_man(const char* path, const char *page)
 	warning("failed to exec '%s': %s", path, strerror(errno));
 }
 
-static void do_add_man_viewer(const char *name)
+static void exec_man_cmd(const char *cmd, const char *page)
+{
+	struct strbuf shell_cmd = STRBUF_INIT;
+	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
+	execl("/bin/sh", "sh", "-c", shell_cmd.buf, NULL);
+	warning("failed to exec '%s': %s", cmd, strerror(errno));
+}
+
+static void add_man_viewer(const char *name)
 {
 	struct man_viewer_list **p = &man_viewer_list;
 	size_t len = strlen(name);
@@ -178,16 +186,6 @@ static int supported_man_viewer(const char *name, size_t len)
 		!strncasecmp("konqueror", name, len));
 }
 
-static int add_man_viewer(const char *value)
-{
-	if (supported_man_viewer(value, strlen(value)))
-		do_add_man_viewer(value);
-	else
-		warning("'%s': unsupported man viewer.", value);
-
-	return 0;
-}
-
 static void do_add_man_viewer_info(const char *name,
 				   size_t len,
 				   const char *value)
@@ -207,7 +205,23 @@ static int add_man_viewer_path(const char *name,
 	if (supported_man_viewer(name, len))
 		do_add_man_viewer_info(name, len, value);
 	else
-		warning("'%s': path for unsupported man viewer.", name);
+		warning("'%s': path for unsupported man viewer.\n"
+			"Please consider using 'man.<tool>.cmd' instead.",
+			name);
+
+	return 0;
+}
+
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
 
 	return 0;
 }
@@ -225,6 +239,11 @@ static int add_man_viewer_info(const char *var, const char *value)
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
@@ -241,7 +260,8 @@ static int git_help_config(const char *var, const char *value)
 	if (!strcmp(var, "man.viewer")) {
 		if (!value)
 			return config_error_nonbool(var);
-		return add_man_viewer(value);
+		add_man_viewer(value);
+		return 0;
 	}
 	if (!prefixcmp(var, "man."))
 		return add_man_viewer_info(var, value);
@@ -543,16 +563,18 @@ static void setup_man_path(void)
 
 static void exec_viewer(const char *name, const char *page)
 {
-	const char *path = get_man_viewer_info(name);
+	const char *info = get_man_viewer_info(name);
 
 	if (!strcasecmp(name, "man"))
-		exec_man_man(path, page);
+		exec_man_man(info, page);
 	else if (!strcasecmp(name, "woman"))
-		exec_woman_emacs(path, page);
+		exec_woman_emacs(info, page);
 	else if (!strcasecmp(name, "konqueror"))
-		exec_man_konqueror(path, page);
+		exec_man_konqueror(info, page);
+	else if (info)
+		exec_man_cmd(info, page);
 	else
-		warning("'%s': unsupported man viewer.", name);
+		warning("'%s': unknown man viewer.", name);
 }
 
 static void show_man_page(const char *git_cmd)
-- 
1.5.5.130.g3ab1e.dirty
