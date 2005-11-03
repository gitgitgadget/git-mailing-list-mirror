From: Paul Collins <paul@briny.ondioline.org>
Subject: [PATCH] RFC: proxy-command support for git://
Date: Thu, 03 Nov 2005 15:55:24 +0000
Message-ID: <87fyqdbuab.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Nov 03 17:04:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXhW8-0006KA-Um
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 17:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbVKCQAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 11:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVKCQAm
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 11:00:42 -0500
Received: from jenny.ondioline.org ([66.220.1.122]:35845 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP
	id S1030362AbVKCQAl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 11:00:41 -0500
Received: by jenny.ondioline.org (Postfix, from userid 10)
	id D3E478CD5B; Thu,  3 Nov 2005 16:00:40 +0000 (GMT)
Received: by briny.internal.ondioline.org (Postfix, from userid 1000)
	id 74276F933; Thu,  3 Nov 2005 15:55:24 +0000 (GMT)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11074>

I spend some of my time using a network that only allows outgoing TCP
connections to certain ports, and the git-daemon port is not one of them.
This patch below implements an analogue to ssh's ProxyCommand feature
for git, as a less messy alternative to ssh port forwarding.  One can
use it to ssh to a bastion host and netcat to the destination:

  $ cat ~/bin/my-git-proxy-command
  #!/bin/sh
  exec ssh bastionhost nc "$1" "$2"

I've done a few pulls and a clone with it, and it seems to work.


Questions:

* Can git already do this and I just failed to notice?

* Where should git_use_proxy() look?  Some git configuration file?
  An environment variable?  Both?  Somewhere else?

It also needs to support non-default ports and probably other things I missed.


diff --git a/connect.c b/connect.c
index c2badc7..646e26f 100644
--- a/connect.c
+++ b/connect.c
@@ -448,6 +448,40 @@ static int git_tcp_connect(int fd[2], co
 
 #endif /* NO_IPV6 */
 
+static int git_proxy_connect(int fd[2], const char *prog, char *host, char *path)
+{
+	char *command = "my-git-proxy-command"; /* FIXME: cf. git_use_proxy() */
+	char *port = STR(DEFAULT_GIT_PORT);
+	int pipefd[2][2];
+	pid_t pid;
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
+		execlp(command, command, host, port, NULL);
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
+static int git_use_proxy(void)
+{
+	/* FIXME: look for the proxy command somewhere - repo's config? environment? */
+	return 1;
+}
+
 /*
  * Yeah, yeah, fixme. Need to pass in the heads etc.
  */
@@ -482,8 +516,11 @@ int git_connect(int fd[2], char *url, co
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
