From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Subject: [PATCH] GIT: Support [address] in URLs
Date: Wed, 21 Dec 2005 19:23:42 +0900 (JST)
Organization: USAGI/WIDE Project
Message-ID: <20051221.192342.132228413.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, yoshfuji@linux-ipv6.org
X-From: git-owner@vger.kernel.org Wed Dec 21 11:26:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep18p-0000pW-Hw
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 11:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVLUKXW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 05:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVLUKXW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 05:23:22 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:2824 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S932351AbVLUKXW
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 05:23:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by yue.st-paulia.net (Postfix) with ESMTP
	id AF55533CC2; Wed, 21 Dec 2005 19:23:43 +0900 (JST)
To: junkio@cox.net
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13873>

Hello.

Allow address enclosed by [] in URLs, like:
   git push '[3ffe:ffff:...:1]:GIT/git'
or
   git push 'ssh://[3ffe:ffff:...:1]/GIT/git'

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

diff --git a/connect.c b/connect.c
index 93f6f80..49f93c6 100644
--- a/connect.c
+++ b/connect.c
@@ -561,7 +561,8 @@ int git_connect(int fd[2], char *url, co
 {
 	char command[1024];
 	char *host, *path = url;
-	char *colon = NULL;
+	char *end;
+	int c;
 	int pipefd[2][2];
 	pid_t pid;
 	enum protocol protocol = PROTO_LOCAL;
@@ -571,15 +572,26 @@ int git_connect(int fd[2], char *url, co
 		*host = '\0';
 		protocol = get_protocol(url);
 		host += 3;
-		path = strchr(host, '/');
-	}
-	else {
+		c = '/';
+	} else {
 		host = url;
-		if ((colon = strchr(host, ':'))) {
-			protocol = PROTO_SSH;
-			*colon = '\0';
-			path = colon + 1;
-		}
+		c = ':';
+	}
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
+
+	if ((path = strchr(end, c)) && c == ':') {
+		protocol = PROTO_SSH;
+		*path++ = '\0';
 	}
 
 	if (!path || !*path)

-- 
YOSHIFUJI Hideaki @ USAGI Project  <yoshfuji@linux-ipv6.org>
GPG-FP  : 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
