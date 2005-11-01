From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH 1/4] Client side of user-relative paths, take two.
Date: Tue,  1 Nov 2005 23:59:21 +0100 (CET)
Message-ID: <20051101225921.245595BF70@nox.op5.se>
X-From: git-owner@vger.kernel.org Wed Nov 02 00:00:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX56F-0003RJ-Uz
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 23:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbVKAW7Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 17:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbVKAW7Y
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 17:59:24 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:48364 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751380AbVKAW7W
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 17:59:22 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 51E016BD00
	for <git@vger.kernel.org>; Tue,  1 Nov 2005 23:59:21 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 245595BF70; Tue,  1 Nov 2005 23:59:21 +0100 (CET)
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10963>

See this discussion, "[RFC] GIT paths", on the git-list:
http://www.gelato.unsw.edu.au/archives/git/0510/10924.html

In particular, the client side now passes identical paths for these two:
	ssh://host.xz/~junio/repo
	host.xz:~junio/repo

A friendly error message is produced if no path is specified.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 connect.c |   53 ++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 34 insertions(+), 19 deletions(-)

applies-to: e39c96179f2cc5064a0255057b8e8a8863594536
22ca6db517baf2bb4824a971408543d9bd956209
diff --git a/connect.c b/connect.c
index c2badc7..9150ad2 100644
--- a/connect.c
+++ b/connect.c
@@ -460,26 +460,41 @@ int git_connect(int fd[2], char *url, co
 	pid_t pid;
 	enum protocol protocol;
 
-	host = NULL;
-	path = url;
-	colon = strchr(url, ':');
-	protocol = PROTO_LOCAL;
-	if (colon) {
-		*colon = 0;
+	protocol = PROTO_SSH;
+	host = strstr(url, "://");
+	if(host) {
+		*host = '\0';
+		protocol = get_protocol(url);
+		host += 3;
+	}
+	else
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
-		}
+
+	path = strchr(host, '/');
+	colon = strchr(host, ':');
+
+	/* We keep server-side code simple by handling the difference
+	 * between these two on the client side:
+	 *    ssh://host.xz/~user/repo
+	 *    host.xz:~repo
+	 */
+	if (protocol == PROTO_SSH && colon && (!path || colon < path)) {
+		*colon = 0;
+		path = colon + 1;
+	}
+
+	if(!path || !*path)
+		die("No path specified. Try '%s%s/path/to/repo'", url, colon ? ":" : "");
+
+	/* null-terminate host part and point path to ~ for URL's like this:
+	 *    ssh://host.xz/~user/repo
+	 */
+	if(!colon && *(path + 1) == '~')
+		*path++ = '\0';
+	else {
+		colon = path;
+		path = strdup(path);
+		*colon = '\0';
 	}
 
 	if (protocol == PROTO_GIT)
---
0.99.9.GIT
