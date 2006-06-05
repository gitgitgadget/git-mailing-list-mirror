From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git: handle aliases defined in $GIT_DIR/config
Date: Mon, 5 Jun 2006 18:51:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606051847480.18604@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606042047160.1598@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bekacts.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 18:51:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnIIm-0007sy-MH
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 18:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWFEQvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 12:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWFEQvi
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 12:51:38 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:11964 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751003AbWFEQvh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 12:51:37 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 2E51D2C92;
	Mon,  5 Jun 2006 18:51:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 2259D2C90;
	Mon,  5 Jun 2006 18:51:36 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id F200AC4E;
	Mon,  5 Jun 2006 18:51:35 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bekacts.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21321>

Hi,

On Sun, 4 Jun 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	For me, short cuts have to be easy to type, so they never
> > 	include digits, and they are never case sensitive, so I do not
> > 	need any fancy config stuff...
> 
> Fair enough, and the spirit is the same as what Pasky suggested
> earlier, I think.
> 
> However, I am not sure about some parts of the code.  I started
> mucking with it myself, but realized it is far easier for me to
> just let the original submitter, especially the capable one like
> you, do a bit more work ;-).

Are you trying to butter me up? If so, it's working ;-)

Here is a revised patch which addresses all of your comments (and Pasky's 
implicit ones) except the move of split_cmdline to somewhere central (I 
am not sure if that function is really needed elsewhere...):

---

 git.c |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index bc463c9..db6ac61 100644
--- a/git.c
+++ b/git.c
@@ -10,6 +10,7 @@ #include <limits.h>
 #include <stdarg.h>
 #include "git-compat-util.h"
 #include "exec_cmd.h"
+#include "cache.h"
 
 #include "builtin.h"
 
@@ -32,6 +33,115 @@ static void prepend_to_path(const char *
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
+static int split_cmdline(char *cmdline, const char ***argv)
+{
+	int src, dst, count = 0, size = 16;
+	char quoted = 0;
+
+	*argv = malloc(sizeof(char*) * size);
+
+	/* split alias_string */
+	(*argv)[count++] = cmdline;
+	for (src = dst = 0; cmdline[src];) {
+		char c = cmdline[src];
+		if (!quoted && isspace(c)) {
+			cmdline[dst++] = 0;
+			while (cmdline[++src]
+					&& isspace(cmdline[src]))
+				; /* skip */
+			if (count >= size) {
+				size += 16;
+				*argv = realloc(*argv, sizeof(char*) * size);
+			}
+			(*argv)[count++] = cmdline + dst;
+		} else if(!quoted && (c == '\'' || c == '"')) {
+			quoted = c;
+			src++;
+		} else if (c == quoted) {
+			quoted = 0;
+			src++;
+		} else {
+			if (c == '\\' && quoted != '\'') {
+				src++;
+				c = cmdline[src];
+				if (!c) {
+					free(*argv);
+					*argv = NULL;
+					return error("cmdline ends with \\");
+				}
+			}
+			cmdline[dst++] = c;
+			src++;
+		}
+	}
+
+	cmdline[dst] = 0;
+
+	if (quoted) {
+		free(*argv);
+		*argv = NULL;
+		return error("unclosed quote");
+	}
+
+	return count;
+}
+
+static int handle_alias(int *argcp, const char ***argv)
+{
+	int nongit = 0;
+	const char *subdir;
+
+	subdir = setup_git_directory_gently(&nongit);
+	if (!nongit) {
+		int count;
+		const char** new_argv;
+
+		alias_command = (*argv)[0];
+		git_config(git_alias_config);
+		if (!alias_string)
+			return 0;
+
+		count = split_cmdline(alias_string, &new_argv);
+
+		if (count < 1)
+			die("empty alias for %s", alias_command);
+
+		if (!strcmp(alias_command, new_argv[0]))
+			die("recursive alias: %s", alias_command);
+
+		/* insert after command name */
+		if (*argcp > 1) {
+			new_argv = realloc(new_argv,
+					sizeof(char*) * (count + *argcp - 1));
+			memcpy(new_argv + count, *argv, sizeof(char*) * (*argcp - 1));
+		}
+
+		*argv = new_argv;
+		*argcp += count - 1;
+
+		if (subdir)
+			chdir(subdir);
+
+		return 1;
+	}
+
+	if (subdir)
+		chdir(subdir);
+
+	return 0;
+}
+
 const char git_version_string[] = GIT_VERSION;
 
 static void handle_internal_command(int argc, const char **argv, char **envp)
@@ -121,6 +231,7 @@ int main(int argc, const char **argv, ch
 	if (!strncmp(cmd, "git-", 4)) {
 		cmd += 4;
 		argv[0] = cmd;
+		handle_alias(&argc, &argv);
 		handle_internal_command(argc, argv, envp);
 		die("cannot handle %s internally", cmd);
 	}
@@ -178,6 +289,8 @@ int main(int argc, const char **argv, ch
 	exec_path = git_exec_path();
 	prepend_to_path(exec_path, strlen(exec_path));
 
+	handle_alias(&argc, &argv);
+
 	/* See if it's an internal command */
 	handle_internal_command(argc, argv, envp);
 
