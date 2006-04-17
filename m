From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: [PATCH 2/7] cleanups: Fix potential bugs in connect.c
Date: Mon, 17 Apr 2006 10:14:47 -0500 (CDT)
Message-ID: <20060417151447.E2A5919B90F@sergelap.hallyn.com>
References: <20060417145148.2F3CB19C90D@sergelap.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 17 17:15:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVVRM-0006b0-2r
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 17:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWDQPOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 11:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWDQPOw
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 11:14:52 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:32158 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751092AbWDQPOt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 11:14:49 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3HFEnEa008844
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:49 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3HFIBb9180884
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 09:18:11 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3HFEm9r019202
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 09:14:49 -0600
Received: from sergelap.hallyn.com ([9.49.218.134])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k3HFEmi7019154
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 09:14:48 -0600
Received: by sergelap.hallyn.com (Postfix, from userid 1000)
	id E2A5919B90F; Mon, 17 Apr 2006 10:14:47 -0500 (CDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Mutt-Fcc: =SENT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18825>

The strncmp for ACK was ACK does not include the final space.
Presumably either we should either remove the trailing space,
or compare 4 chars (as this patch does).

'path' is sometimes strdup'ed, but never freed.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 connect.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

1b4f45918d8c1f7d579840c7bb1fe3fe1967b6c5
diff --git a/connect.c b/connect.c
index 3f2d65c..6a8f8a6 100644
--- a/connect.c
+++ b/connect.c
@@ -74,7 +74,7 @@ int get_ack(int fd, unsigned char *resul
 		line[--len] = 0;
 	if (!strcmp(line, "NAK"))
 		return 0;
-	if (!strncmp(line, "ACK ", 3)) {
+	if (!strncmp(line, "ACK ", 4)) {
 		if (!get_sha1_hex(line+4, result_sha1)) {
 			if (strstr(line+45, "continue"))
 				return 2;
@@ -567,6 +567,7 @@ int git_connect(int fd[2], char *url, co
 	int pipefd[2][2];
 	pid_t pid;
 	enum protocol protocol = PROTO_LOCAL;
+	int free_path = 0;
 
 	host = strstr(url, "://");
 	if(host) {
@@ -610,16 +611,23 @@ int git_connect(int fd[2], char *url, co
 		char *ptr = path;
 		if (path[1] == '~')
 			path++;
-		else
+		else {
 			path = strdup(ptr);
+			free_path = 1;
+		}
 
 		*ptr = '\0';
 	}
 
 	if (protocol == PROTO_GIT) {
+		int ret;
 		if (git_use_proxy(host))
-			return git_proxy_connect(fd, prog, host, path);
-		return git_tcp_connect(fd, prog, host, path);
+			ret = git_proxy_connect(fd, prog, host, path);
+		else
+			ret = git_tcp_connect(fd, prog, host, path);
+		if (free_path)
+			free(path);
+		return ret;
 	}
 
 	if (pipe(pipefd[0]) < 0 || pipe(pipefd[1]) < 0)
@@ -659,6 +667,8 @@ int git_connect(int fd[2], char *url, co
 	fd[1] = pipefd[1][1];
 	close(pipefd[0][1]);
 	close(pipefd[1][0]);
+	if (free_path)
+		free(path);
 	return pid;
 }
 
-- 
1.2.5
