From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH 2/4] Refactoring: connect.c: move duplicated code to get_host_and_port
Date: Sun, 14 Feb 2010 21:27:41 +0000
Message-ID: <1266182863-5048-2-git-send-email-michael.lukashov@gmail.com>
References: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 22:30:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngm2r-0001K3-K2
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 22:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404Ab0BNV2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 16:28:19 -0500
Received: from mail-bw0-f216.google.com ([209.85.218.216]:51098 "EHLO
	mail-bw0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab0BNV2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 16:28:17 -0500
Received: by bwz8 with SMTP id 8so2302859bwz.38
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 13:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4HvI+FbdOAuUYPx6H+RLeRvUib2fgnuSRz7yMvGlIew=;
        b=nZJMIQKkgBmSz2mx2+x2kQ9DfWAwuZH4AXKwqUUhFV2flb6YmCuvPxbXPgbk6ckWFA
         SPOWrDPq+WjGnjX5eU+26onSJ4USqKSYe0suXqtYOaqB5/ptli5rSyJSn10Duc5B7TUQ
         jQGEMgqxNX5NzgwqkbxJUqzAHFSUeyiOYhiSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XcNw9HqKqs0ngaEc70ghzBKPBXp6neckWYD02rlYNogsAcPbhV9C4KIS/5ockCFb0L
         VinTToZENBeg0WpoAEIZ5Ibt8b2YFDLR5dTOY+9FU/R8fQu0MogAcU5sqFOUFoc4F/DT
         HClK5zC2jcZzf/F0cD6Itzl5qWJi11wZzCSgs=
Received: by 10.204.48.144 with SMTP id r16mr2679492bkf.176.1266182896453;
        Sun, 14 Feb 2010 13:28:16 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 14sm2392541bwz.13.2010.02.14.13.28.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Feb 2010 13:28:15 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
In-Reply-To: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139942>

The following functions:

  git_tcp_connect_sock
  git_tcp_connect_sock,
  git_proxy_connect

have common block of code, which is moved to get_host_and_port

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 connect.c |   83 +++++++++++++++++++++---------------------------------------
 1 files changed, 29 insertions(+), 54 deletions(-)

diff --git a/connect.c b/connect.c
index 20054e4..616b312 100644
--- a/connect.c
+++ b/connect.c
@@ -152,6 +152,30 @@ static enum protocol get_protocol(const char *name)
 #define STR_(s)	# s
 #define STR(s)	STR_(s)
 
+static void get_host_and_port(char **host, const char **port, int set_port_none)
+{
+	char *colon, *end;
+
+	if (*host[0] == '[') {
+		end = strchr(*host + 1, ']');
+		if (end) {
+			*end = 0;
+			end++;
+			(*host)++;
+		} else
+			end = *host;
+	} else
+		end = *host;
+	colon = strchr(end, ':');
+
+	if (colon) {
+		*colon = 0;
+		*port = colon + 1;
+		if (set_port_none && !**port)
+			*port = "<none>";
+	}
+}
+
 #ifndef NO_IPV6
 
 static const char *ai_name(const struct addrinfo *ai)
@@ -170,30 +194,12 @@ static const char *ai_name(const struct addrinfo *ai)
 static int git_tcp_connect_sock(char *host, int flags)
 {
 	int sockfd = -1, saved_errno = 0;
-	char *colon, *end;
 	const char *port = STR(DEFAULT_GIT_PORT);
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
 	int cnt = 0;
 
-	if (host[0] == '[') {
-		end = strchr(host + 1, ']');
-		if (end) {
-			*end = 0;
-			end++;
-			host++;
-		} else
-			end = host;
-	} else
-		end = host;
-	colon = strchr(end, ':');
-
-	if (colon) {
-		*colon = 0;
-		port = colon + 1;
-		if (!*port)
-			port = "<none>";
-	}
+	get_host_and_port(&host, &port, 1);
 
 	memset(&hints, 0, sizeof(hints));
 	hints.ai_socktype = SOCK_STREAM;
@@ -251,30 +257,15 @@ static int git_tcp_connect_sock(char *host, int flags)
 static int git_tcp_connect_sock(char *host, int flags)
 {
 	int sockfd = -1, saved_errno = 0;
-	char *colon, *end;
-	char *port = STR(DEFAULT_GIT_PORT), *ep;
+	const char *port = STR(DEFAULT_GIT_PORT);
+	char *ep;
 	struct hostent *he;
 	struct sockaddr_in sa;
 	char **ap;
 	unsigned int nport;
 	int cnt;
 
-	if (host[0] == '[') {
-		end = strchr(host + 1, ']');
-		if (end) {
-			*end = 0;
-			end++;
-			host++;
-		} else
-			end = host;
-	} else
-		end = host;
-	colon = strchr(end, ':');
-
-	if (colon) {
-		*colon = 0;
-		port = colon + 1;
-	}
+	get_host_and_port(&host, &port, 0);
 
 	if (flags & CONNECT_VERBOSE)
 		fprintf(stderr, "Looking up %s ... ", host);
@@ -406,26 +397,10 @@ static int git_use_proxy(const char *host)
 static void git_proxy_connect(int fd[2], char *host)
 {
 	const char *port = STR(DEFAULT_GIT_PORT);
-	char *colon, *end;
 	const char *argv[4];
 	struct child_process proxy;
 
-	if (host[0] == '[') {
-		end = strchr(host + 1, ']');
-		if (end) {
-			*end = 0;
-			end++;
-			host++;
-		} else
-			end = host;
-	} else
-		end = host;
-	colon = strchr(end, ':');
-
-	if (colon) {
-		*colon = 0;
-		port = colon + 1;
-	}
+	get_host_and_port(&host, &port, 0);
 
 	argv[0] = git_proxy_command;
 	argv[1] = host;
-- 
1.7.0.1571.g856c2
