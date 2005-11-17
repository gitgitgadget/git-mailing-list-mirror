From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH 3/5] Client side support for user-relative paths.
Date: Thu, 17 Nov 2005 20:37:14 +0100 (CET)
Message-ID: <20051117193714.3CCC35C7F6@nox.op5.se>
X-From: git-owner@vger.kernel.org Thu Nov 17 20:38:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcpZm-0000lW-1g
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 20:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVKQThZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 14:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVKQThY
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 14:37:24 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:36570 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964818AbVKQThP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 14:37:15 -0500
Received: from nox.op5.se (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 7C2B26BD15
	for <git@vger.kernel.org>; Thu, 17 Nov 2005 20:37:14 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 3CCC35C7F6; Thu, 17 Nov 2005 20:37:14 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12142>


With this patch, the client side passes identical paths for these two:
	ssh://host.xz/~junio/repo
	host.xz:~junio/repo

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 connect.c |   53 ++++++++++++++++++++++++++++++++---------------------
 1 files changed, 32 insertions(+), 21 deletions(-)

applies-to: cd3bc724fea293b623abee6b0b4995560dd9f32e
c460d84cc8431089ddf6a888a418826ff8248509
diff --git a/connect.c b/connect.c
index c2badc7..73187a1 100644
--- a/connect.c
+++ b/connect.c
@@ -454,34 +454,45 @@ static int git_tcp_connect(int fd[2], co
 int git_connect(int fd[2], char *url, const char *prog)
 {
 	char command[1024];
-	char *host, *path;
-	char *colon;
+	char *host, *path = url;
+	char *colon = NULL;
 	int pipefd[2][2];
 	pid_t pid;
-	enum protocol protocol;
+	enum protocol protocol = PROTO_LOCAL;
 
-	host = NULL;
-	path = url;
-	colon = strchr(url, ':');
-	protocol = PROTO_LOCAL;
-	if (colon) {
-		*colon = 0;
+	host = strstr(url, "://");
+	if(host) {
+		*host = '\0';
+		protocol = get_protocol(url);
+		host += 3;
+		path = strchr(host, '/');
+	}
+	else {
 		host = url;
-		path = colon+1;
-		protocol = PROTO_SSH;
-		if (!memcmp(path, "//", 2)) {
-			char *slash = strchr(path + 2, '/');
-			if (slash) {
-				int nr = slash - path - 2;
-				memmove(path, path+2, nr);
-				path[nr] = 0;
-				protocol = get_protocol(url);
-				host = path;
-				path = slash;
-			}
+		if ((colon = strchr(host, ':'))) {
+			protocol = PROTO_SSH;
+			*colon = '\0';
+			path = colon + 1;
 		}
 	}
 
+	if (!path || !*path)
+		die("No path specified. See 'man git-pull' for valid url syntax");
+
+	/*
+	 * null-terminate hostname and point path to ~ for URL's like this:
+	 *    ssh://host.xz/~user/repo
+	 */
+	if (protocol != PROTO_LOCAL && host != url) {
+		char *ptr = path;
+		if (path[1] == '~')
+			path++;
+		else
+			path = strdup(ptr);
+
+		*ptr = '\0';
+	}
+
 	if (protocol == PROTO_GIT)
 		return git_tcp_connect(fd, prog, host, path);
 
---
0.99.9.GIT
