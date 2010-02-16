From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH v3 2/4] Refactoring: connect.c: move duplicated code to a new function 'get_host_and_port'
Date: Tue, 16 Feb 2010 23:42:53 +0000
Message-ID: <0d6d0066fecc892bd5b6afda64e1aa5591347504.1266360267.git.michael.lukashov@gmail.com>
References: <cover.1266360267.git.michael.lukashov@gmail.com>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 00:43:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhX4i-0007JW-GP
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 00:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933545Ab0BPXn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 18:43:27 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50925 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757082Ab0BPXnY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 18:43:24 -0500
Received: by mail-bw0-f219.google.com with SMTP id 19so5008437bwz.28
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 15:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=F2J9oYdGk1rDqPfOLbxCZiaqoXN5eBd7Z0BGQb1Su28=;
        b=jlW9F1GMgvimevA7sso3iBcZScLFyPyHyeuBrxRgfeJJSdsTIN5ABvqtkOjsG2jlMb
         ucvAm0/1Ree1M/EALHW4YY5Rren3aOjHGKJHUbuKA5aldwwFSBwo+rQ/lmYkHihv7WFp
         W4+TEC1MWVgLH/Imv34IiBu/jNmCMxFdokvw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WR5tXZ412lSgNFiB32Y3Tl3EmpA7GGHWQuJAPGZ1hyYoTDMykkv0oS+sUfO8gUGr6a
         R1unRzo7NmZqc7ELli9Dgto/e/3WHki7gPWBxudKrPZLmJPF/h8NL/gY1VuUMOYYWlBY
         pQuX8DkUZ0ZsXjEsjHP7Ig355xai4ltxCgzOw=
Received: by 10.204.15.4 with SMTP id i4mr1912254bka.21.1266363803520;
        Tue, 16 Feb 2010 15:43:23 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id 16sm3377369bwz.3.2010.02.16.15.43.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 15:43:22 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
In-Reply-To: <cover.1266360267.git.michael.lukashov@gmail.com>
In-Reply-To: <cover.1266360267.git.michael.lukashov@gmail.com>
References: <cover.1266360267.git.michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140173>

The following functions:

  git_tcp_connect_sock (IPV6 version)
  git_tcp_connect_sock (no IPV6 version),
  git_proxy_connect

have common block of code. Move it to a new function 'get_host_and_port'

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
---
 connect.c |   83 +++++++++++++++++++++---------------------------------------
 1 files changed, 29 insertions(+), 54 deletions(-)

diff --git a/connect.c b/connect.c
index 20054e4..cd399f4 100644
--- a/connect.c
+++ b/connect.c
@@ -152,6 +152,28 @@ static enum protocol get_protocol(const char *name)
 #define STR_(s)	# s
 #define STR(s)	STR_(s)
 
+static void get_host_and_port(char **host, const char **port)
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
+	}
+}
+
 #ifndef NO_IPV6
 
 static const char *ai_name(const struct addrinfo *ai)
@@ -170,30 +192,14 @@ static const char *ai_name(const struct addrinfo *ai)
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
+	get_host_and_port(&host, &port);
+	if (!*port)
+		*port = "<none>";
 
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
+	get_host_and_port(&host, &port);
 
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
+	get_host_and_port(&host, &port);
 
 	argv[0] = git_proxy_command;
 	argv[1] = host;
-- 
1.7.0.1571.g856c2
