From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git: handle aliases defined in $GIT_DIR/config
Date: Mon, 5 Jun 2006 19:43:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606051941450.29608@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606042047160.1598@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3bekacts.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606051847480.18604@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0606051902210.20820@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 19:44:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnJ7M-0000qw-Tk
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 19:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWFERny (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 13:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWFERny
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 13:43:54 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:41611 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751241AbWFERnx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 13:43:53 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 76E90E13;
	Mon,  5 Jun 2006 19:43:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 6B5C6D7A;
	Mon,  5 Jun 2006 19:43:52 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 421AABBC;
	Mon,  5 Jun 2006 19:43:52 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0606051902210.20820@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21324>

Hi,

On Mon, 5 Jun 2006, Johannes Schindelin wrote:

> Hi,
> 
> sorry, I did not test with the subdir=... stuff I copied from Pasky's 
> patch. It breaks things for me. Looking into it...

There were actually two bugs: I did not change the subdir back in all 
cases, and git_setup_directory_gently had a bug (will send patch 
separately). The updated patch:

---

 git.c |  111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 111 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index bc463c9..8854472 100644
--- a/git.c
+++ b/git.c
@@ -10,6 +10,7 @@ #include <limits.h>
 #include <stdarg.h>
 #include "git-compat-util.h"
 #include "exec_cmd.h"
+#include "cache.h"
 
 #include "builtin.h"
 
@@ -32,6 +33,113 @@ static void prepend_to_path(const char *
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
+	int nongit = 0, ret = 0;
+	const char *subdir;
+
+	subdir = setup_git_directory_gently(&nongit);
+	if (!nongit) {
+		int count;
+		const char** new_argv;
+
+		alias_command = (*argv)[0];
+		git_config(git_alias_config);
+		if (alias_string) {
+
+			count = split_cmdline(alias_string, &new_argv);
+
+			if (count < 1)
+				die("empty alias for %s", alias_command);
+
+			if (!strcmp(alias_command, new_argv[0]))
+				die("recursive alias: %s", alias_command);
+
+			/* insert after command name */
+			if (*argcp > 1) {
+				new_argv = realloc(new_argv, sizeof(char*) *
+						(count + *argcp - 1));
+				memcpy(new_argv + count, *argv, sizeof(char*) *
+						(*argcp - 1));
+			}
+
+			*argv = new_argv;
+			*argcp += count - 1;
+
+			ret = 1;
+		}
+	}
+
+	if (subdir)
+		chdir(subdir);
+
+	return ret;
+}
+
 const char git_version_string[] = GIT_VERSION;
 
 static void handle_internal_command(int argc, const char **argv, char **envp)
@@ -121,6 +229,7 @@ int main(int argc, const char **argv, ch
 	if (!strncmp(cmd, "git-", 4)) {
 		cmd += 4;
 		argv[0] = cmd;
+		handle_alias(&argc, &argv);
 		handle_internal_command(argc, argv, envp);
 		die("cannot handle %s internally", cmd);
 	}
@@ -178,6 +287,8 @@ int main(int argc, const char **argv, ch
 	exec_path = git_exec_path();
 	prepend_to_path(exec_path, strlen(exec_path));
 
+	handle_alias(&argc, &argv);
+
 	/* See if it's an internal command */
 	handle_internal_command(argc, argv, envp);
 
