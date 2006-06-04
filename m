From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git: handle aliases defined in $GIT_DIR/config
Date: Sun, 4 Jun 2006 20:47:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606042047160.1598@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Jun 04 20:48:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmxdl-0002dB-Dd
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 20:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWFDSru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 14:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWFDSru
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 14:47:50 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:15566 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750961AbWFDSrt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 14:47:49 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 77156D04;
	Sun,  4 Jun 2006 20:47:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 6B072CF4;
	Sun,  4 Jun 2006 20:47:48 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 4E361BC7;
	Sun,  4 Jun 2006 20:47:48 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21277>


If you have a config containing something like this:

	[alias]
		l = "log --stat -M ORIG_HEAD.."

you can call

	git l

and it will do the same as

	git log --stat -M ORIG_HEAD..

This also works with hard links.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	For me, short cuts have to be easy to type, so they never
	include digits, and they are never case sensitive, so I do not
	need any fancy config stuff...

 git.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index bc463c9..846062f 100644
--- a/git.c
+++ b/git.c
@@ -10,6 +10,7 @@ #include <limits.h>
 #include <stdarg.h>
 #include "git-compat-util.h"
 #include "exec_cmd.h"
+#include "cache.h"
 
 #include "builtin.h"
 
@@ -32,6 +33,60 @@ static void prepend_to_path(const char *
 	setenv("PATH", path, 1);
 }
 
+static const char *alias_command;
+static char *alias_string = NULL;
+
+static int git_alias_config(const char *var, const char *value)
+{
+	if (!strncmp(var, "alias.", 6) && !strcmp(var + 6, alias_command)) {
+		alias_string = strdup(value);
+	}
+	return 0;
+}
+
+#define MAX_ALIAS_ARGS 32
+
+static int handle_alias(int *argcp, const char **argv, char **envp)
+{
+	int i, i2, j = 0;
+	char *new_argv[MAX_ALIAS_ARGS];
+
+	alias_command = argv[0];
+	git_config(git_alias_config);
+	if (!alias_string)
+		return 0;
+
+	/* split alias_string */
+	new_argv[j++] = alias_string;
+	for (i = i2 = 0; alias_string[i]; i++, i2++) {
+		if (isspace(alias_string[i])) {
+			alias_string[i2] = 0;
+			while (alias_string[++i] && isspace(alias_string[i]));
+			new_argv[j++] = alias_string + i;
+			i2 = i;
+			if (j >= MAX_ALIAS_ARGS)
+				die("too many args in alias %s",
+						alias_command);
+		} else {
+			if (alias_string[i] == '\\')
+				i++;
+			if (i != i2)
+				alias_string[i2] = alias_string[i];
+		}
+	}
+
+	if (j < 1)
+		die("empty alias: %s", alias_command);
+
+	/* insert after command name */
+	if (j > 1)
+		memmove(argv + j, argv + 1, (*argcp - 1) * sizeof(char*));
+	memcpy(argv, new_argv, j * sizeof(char*));
+	*argcp += j - 1;
+
+	return 1;
+}
+
 const char git_version_string[] = GIT_VERSION;
 
 static void handle_internal_command(int argc, const char **argv, char **envp)
@@ -121,6 +176,7 @@ int main(int argc, const char **argv, ch
 	if (!strncmp(cmd, "git-", 4)) {
 		cmd += 4;
 		argv[0] = cmd;
+		handle_alias(&argc, argv, envp);
 		handle_internal_command(argc, argv, envp);
 		die("cannot handle %s internally", cmd);
 	}
@@ -178,6 +234,8 @@ int main(int argc, const char **argv, ch
 	exec_path = git_exec_path();
 	prepend_to_path(exec_path, strlen(exec_path));
 
+	handle_alias(&argc, argv, envp);
+
 	/* See if it's an internal command */
 	handle_internal_command(argc, argv, envp);
 
-- 
1.3.3.ga182-dirty
