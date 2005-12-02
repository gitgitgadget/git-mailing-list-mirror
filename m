From: Andreas Jochens <aj@andaco.de>
Subject: How can I specify a non-standard TCP port for a git+ssh connection?
Date: Fri, 2 Dec 2005 13:48:01 +0100
Message-ID: <20051202124801.GA20332@andaco.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 02 13:50:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiAKp-0005zK-N0
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 13:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVLBMsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 07:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVLBMsN
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 07:48:13 -0500
Received: from e182064067.adsl.alicedsl.de ([85.182.64.67]:30701 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750720AbVLBMsM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2005 07:48:12 -0500
Received: from aj by localhost.localdomain with local (Exim 4.60)
	(envelope-from <aj@andaco.de>)
	id 1EiAKX-0005MN-HE; Fri, 02 Dec 2005 13:48:01 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13115>

Hello,

is there a simple way to specify a non-standard TCP port for a git+ssh
connection? 

The following small patch would allow to use an URL like 
'git+ssh://user@hostname:port/path' to specify an arbitrary 
port for the ssh connection.

Regards
Andreas Jochens

 connect.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/connect.c b/connect.c
index 93f6f80..4b640dd 100644
--- a/connect.c
+++ b/connect.c
@@ -560,7 +560,7 @@ static int git_proxy_connect(int fd[2], 
 int git_connect(int fd[2], char *url, const char *prog)
 {
 	char command[1024];
-	char *host, *path = url;
+	char *host, *port = NULL, *path = url;
 	char *colon = NULL;
 	int pipefd[2][2];
 	pid_t pid;
@@ -597,6 +597,10 @@ int git_connect(int fd[2], char *url, co
 			path = strdup(ptr);
 
 		*ptr = '\0';
+		if ((colon = strchr(host, ':'))) {
+			*colon = '\0';
+			port = colon + 1;
+		}
 	}
 
 	if (protocol == PROTO_GIT) {
@@ -626,7 +630,11 @@ int git_connect(int fd[2], char *url, co
 				ssh_basename = ssh;
 			else
 				ssh_basename++;
-			execlp(ssh, ssh_basename, host, command, NULL);
+			if (port)
+				execlp(ssh, ssh_basename, "-p", port, host, 
+				       command, NULL);
+			else
+				execlp(ssh, ssh_basename, host, command, NULL);
 		}
 		else
 			execlp("sh", "sh", "-c", command, NULL);
