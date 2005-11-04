From: Paul Collins <paul@briny.ondioline.org>
Subject: Re: [PATCH] v2: proxy-command support for git://
Date: Fri, 04 Nov 2005 14:57:16 +0000
Message-ID: <871x1wbgvn.fsf_-_@briny.internal.ondioline.org>
References: <87fyqdbuab.fsf@briny.internal.ondioline.org>
	<7v8xw5h898.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 16:02:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY33N-0006bK-3q
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 16:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVKDPA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 10:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbVKDPA0
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 10:00:26 -0500
Received: from jenny.ondioline.org ([66.220.1.122]:56850 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP id S932069AbVKDPA0
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Nov 2005 10:00:26 -0500
Received: by jenny.ondioline.org (Postfix, from userid 10)
	id 42B508CD5B; Fri,  4 Nov 2005 15:00:24 +0000 (GMT)
Received: by briny.internal.ondioline.org (Postfix, from userid 1000)
	id 75706F93E; Fri,  4 Nov 2005 14:57:16 +0000 (GMT)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7v8xw5h898.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 03 Nov 2005 10:54:43 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11132>

Junio C Hamano <junkio@cox.net> writes:

> Paul Collins <paul@briny.ondioline.org> writes:
>
>> * Where should git_use_proxy() look?  Some git configuration file?
>>   An environment variable?  Both?  Somewhere else?
>
> My preference is put something in .git/config to describe which
> proxy command (maybe the same one with different argument) to
> use depending on where you are going.  When you have internal
> hosts and external hosts you would want this to apply only to
> external hosts.  Maybe you have two or more gateways and
> depending on which external host you are going you may want to
> use different proxied connection.  On top of the config file,
> making it overridable from an environment variable would be
> sensible.

Here is an updated patch that first looks for GIT_PROXY_COMMAND in the
environment and then git.proxycommand in the repository's
configuration file.  I have left the calling convention the same --
argv[1] is the host and argv[2] is the port.

I've taken the hostname parsing verbatim from git_tcp_connect(), so it
should now support an explicit port number and whatever that business
with the square brackets is.  (Should I move this to a helper function?)

Regarding internal vs. external hosts, the proxy command can simply
run netcat locally to internal hosts, so perhaps that is sufficient.


diff --git a/connect.c b/connect.c
index c2badc7..43eec67 100644
--- a/connect.c
+++ b/connect.c
@@ -448,6 +448,73 @@ static int git_tcp_connect(int fd[2], co
 
 #endif /* NO_IPV6 */
 
+static char *git_proxy_command = NULL;
+
+static int git_proxy_command_options(const char *var, const char *value)
+{
+	if (git_proxy_command == NULL) {
+		if (!strcmp(var, "git.proxycommand")) {
+			git_proxy_command = xmalloc(strlen(value) + 1);
+			strcpy(git_proxy_command, value);
+			return 0;
+		}
+	}
+
+	return git_default_config(var, value);
+}
+
+static int git_use_proxy(void)
+{
+	git_proxy_command = getenv("GIT_PROXY_COMMAND");
+	git_config(git_proxy_command_options);
+	return git_proxy_command != NULL;
+}
+
+static int git_proxy_connect(int fd[2], const char *prog, char *host, char *path)
+{
+	char *port = STR(DEFAULT_GIT_PORT);
+	char *colon, *end;
+	int pipefd[2][2];
+	pid_t pid;
+
+	if (host[0] == '[') {
+		end = strchr(host + 1, ']');
+		if (end) {
+			*end = 0;
+			end++;
+			host++;
+		} else
+			end = host;
+	} else
+		end = host;
+	colon = strchr(end, ':');
+
+	if (colon) {
+		*colon = 0;
+		port = colon + 1;
+	}
+
+	if (pipe(pipefd[0]) < 0 || pipe(pipefd[1]) < 0)
+		die("unable to create pipe pair for communication");
+	pid = fork();
+	if (!pid) {
+		dup2(pipefd[1][0], 0);
+		dup2(pipefd[0][1], 1);
+		close(pipefd[0][0]);
+		close(pipefd[0][1]);
+		close(pipefd[1][0]);
+		close(pipefd[1][1]);
+		execlp(git_proxy_command, git_proxy_command, host, port, NULL);
+		die("exec failed");
+	}
+	fd[0] = pipefd[0][0];
+	fd[1] = pipefd[1][1];
+	close(pipefd[0][1]);
+	close(pipefd[1][0]);
+	packet_write(fd[1], "%s %s\n", prog, path);
+	return pid;
+}
+
 /*
  * Yeah, yeah, fixme. Need to pass in the heads etc.
  */
@@ -482,8 +549,11 @@ int git_connect(int fd[2], char *url, co
 		}
 	}
 
-	if (protocol == PROTO_GIT)
+	if (protocol == PROTO_GIT) {
+		if (git_use_proxy())
+			return git_proxy_connect(fd, prog, host, path);
 		return git_tcp_connect(fd, prog, host, path);
+	}
 
 	if (pipe(pipefd[0]) < 0 || pipe(pipefd[1]) < 0)
 		die("unable to create pipe pair for communication");


-- 
Dag vijandelijk luchtschip de huismeester is dood
