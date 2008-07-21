From: Fredrik Tolf <fredrik@dolda2000.com>
Subject: [PATCH v2] Ensure that SSH runs in non-interactive mode
Date: Mon, 21 Jul 2008 02:00:32 +0200
Message-ID: <1216598432-18553-1-git-send-email-fredrik@dolda2000.com>
Cc: Fredrik Tolf <fredrik@dolda2000.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 02:01:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKiqY-0005Jd-Bi
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 02:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbYGUAAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 20:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754230AbYGUAAq
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 20:00:46 -0400
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20]:53705 "EHLO
	nerv.dolda2000.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbYGUAAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 20:00:46 -0400
Received: from localhost.localdomain (fredrik@pc7.dolda2000.com [192.168.1.132])
	(authenticated bits=0)
	by nerv.dolda2000.com (8.13.8/8.13.8/Debian-3) with ESMTP id m6L00WAh013215;
	Mon, 21 Jul 2008 02:00:34 +0200
X-Mailer: git-send-email 1.5.6.2
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (nerv.dolda2000.com [192.168.1.1]); Mon, 21 Jul 2008 02:00:34 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89270>

OpenSSH has the nice feature that it sets the IP TOS value of its
connection depending on usage. When used in interactive mode, it
is set to Minimize-Delay, and other wise to Maximize-Throughput. Its
usage by Git is best served by Maximize-Throughput, for obvious
reasons.

However, it seems to use a DWIM heuristic for detecting interactive
mode. The current implementation enters interactive mode if either
a PTY is allocated or X11 forwarding is enabled, and even though Git
SSH:ing does not allocate a PTY, X11 forwarding is often turned on
by default.

This patch allows the Git config file to specify the SSH command to
use and its parameters in a rather flexible manner. It should also be
enough to configure Git to use other SSH implementations than OpenSSH.

Signed-off-by: Fredrik Tolf <fredrik@dolda2000.com>
---

I'm following my previous SSH patch up with this one, which should at
least solve the problems discussed, and probably some more. If anything,
it might be considered a bit overkill for the problem at hand.

I assume it might have to be documented as well, if people approve of it.

 connect.c |  130 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 117 insertions(+), 13 deletions(-)

diff --git a/connect.c b/connect.c
index 574f42f..46379fa 100644
--- a/connect.c
+++ b/connect.c
@@ -474,6 +474,114 @@ char *get_port(char *host)
 	return NULL;
 }
 
+static char *git_ssh_command;
+static struct {
+	char *name;
+	char *exp;
+} ssh_templates[] = {
+	{"openssh", "ssh -xT %P-p %p %h"},
+	{"plink", "plink %P-P %p %h"},
+	{NULL, NULL}
+};
+
+static int git_ssh_command_options(const char *var, const char *value, void *cb)
+{
+	int i;
+	
+	if(!strcmp(var, "core.sshcommand")) {
+		if(git_ssh_command)
+			return 0;
+		if(!value)
+			return config_error_nonbool(var);
+		if(strchr(value, ' ')) {
+			git_ssh_command = xstrdup(value);
+		} else {
+			for(i = 0; ssh_templates[i].name; i++) {
+				if(!strcmp(ssh_templates[i].name, value)) {
+					git_ssh_command = xstrdup(ssh_templates[i].exp);
+					break;
+				}
+			}
+			if(git_ssh_command == NULL)
+				git_ssh_command = xstrdup(value);
+		}
+	}
+	
+	return git_default_config(var, value, cb);
+}
+
+static char *ssh_arg_subst(char *arg, const char *host, const char *port)
+{
+	if(!strncmp(arg, "%P", 2)) {
+		if(!port)
+			return NULL;
+		return xstrdup(arg + 2);
+	} else if(!strcmp(arg, "%p")) {
+		if(!port)
+			return NULL;
+		return xstrdup(port);
+	} else if(!strcmp(arg, "%h")) {
+		return xstrdup(host);
+	}
+	return arg;
+}
+
+static const char **setup_ssh_command(const char *host, const char *port, int extra_args)
+{
+	char **argv;
+	char *tok, *buf;
+	int i, sz;
+	
+	if((buf = getenv("GIT_SSH")) != NULL) {
+		if(port) {
+			argv = xcalloc(5 + extra_args, sizeof(*argv));
+			argv[0] = xstrdup(buf);
+			argv[1] = xstrdup("-p");
+			argv[2] = xstrdup(port);
+			argv[3] = xstrdup(host);
+		} else {
+			argv = xcalloc(3 + extra_args, sizeof(*argv));
+			argv[0] = xstrdup(buf);
+			argv[1] = xstrdup(host);
+		}
+		return (const char **)argv;
+	}
+
+	git_config(git_ssh_command_options, NULL);
+	if(git_ssh_command == NULL)
+		buf = xstrdup(ssh_templates[0].exp);
+	else
+		buf = xstrdup(git_ssh_command);
+	
+	argv = xmalloc((sz = 5) * sizeof(*argv));
+	for(i = 0, tok = strtok(buf, " "); tok != NULL; tok = strtok(NULL, " ")) {
+		argv[i++] = xstrdup(tok);
+		if(sz - i < 1)
+			argv = xrealloc(argv, (sz += 5) * sizeof(*argv));
+	}
+	argv[i] = NULL;
+	argv = xrealloc(argv, ((sz = i) + extra_args + 1) * sizeof(*argv));
+	free(buf);
+	
+	for(i = 0; i < sz;) {
+		buf = ssh_arg_subst(argv[i], host, port);
+		if(buf == argv[i]) {
+			i++;
+			continue;
+		} else if(buf == NULL) {
+			free(argv[i]);
+			memmove(argv + i, argv + i + 1, sizeof(*argv) * (sz-- - i));
+			continue;
+		} else {
+			free(argv[i]);
+			argv[i] = buf;
+			i++;
+		}
+	}
+
+	return (const char **)argv;
+}
+
 static struct child_process no_fork;
 
 /*
@@ -596,19 +704,12 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		die("command line too long");
 
 	conn->in = conn->out = -1;
-	conn->argv = arg = xcalloc(6, sizeof(*arg));
 	if (protocol == PROTO_SSH) {
-		const char *ssh = getenv("GIT_SSH");
-		if (!ssh) ssh = "ssh";
-
-		*arg++ = ssh;
-		if (port) {
-			*arg++ = "-p";
-			*arg++ = port;
-		}
-		*arg++ = host;
+		conn->argv = setup_ssh_command(host, port, 1);
+		for(arg = conn->argv; *arg; arg++);
 	}
 	else {
+		conn->argv = arg = xcalloc(6, sizeof(*arg));
 		/* remove these from the environment */
 		const char *env[] = {
 			ALTERNATE_DB_ENVIRONMENT,
@@ -620,10 +721,10 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 			NULL
 		};
 		conn->env = env;
-		*arg++ = "sh";
-		*arg++ = "-c";
+		*arg++ = xstrdup("sh");
+		*arg++ = xstrdup("-c");
 	}
-	*arg++ = cmd.buf;
+	*arg++ = xstrdup(cmd.buf);
 	*arg = NULL;
 
 	if (start_command(conn))
@@ -640,11 +741,14 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 
 int finish_connect(struct child_process *conn)
 {
+	const char **argp;
 	int code;
 	if (!conn || conn == &no_fork)
 		return 0;
 
 	code = finish_command(conn);
+	for(argp = conn->argv; *argp; argp++)
+		free((void *)*argp);
 	free(conn->argv);
 	free(conn);
 	return code;
-- 
1.5.6.2
