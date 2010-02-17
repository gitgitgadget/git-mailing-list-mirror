From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: [PATCH v4 2/4] Refactoring: connect.c: move duplicated code to a new function 'get_host_and_port'
Date: Wed, 17 Feb 2010 20:56:02 +0000
Message-ID: <1266440162-3500-1-git-send-email-michael.lukashov@gmail.com>
References: <20100217000456.GA28433@cthulhu>
Cc: Michael Lukashov <michael.lukashov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 21:56:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhqwY-0001S3-2F
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 21:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124Ab0BQU4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 15:56:16 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:58642 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873Ab0BQU4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 15:56:16 -0500
Received: by fg-out-1718.google.com with SMTP id 19so393710fgg.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 12:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JmNPn6wKROo69iK6LVNDQNpBAC6d/ODW5q6Llk4UuaU=;
        b=ZdlJteDcAW3CYYf2uT6UbjPPPGxnfcokFfqqTsITKrgWRhy6ogrRS4LKn0mOELTxtn
         pC9wJi5on4Cd6F7o368lngfgMZb1TnMjvsvhGFvZAxAx/+UIUuFMt7V7F/+IizYuC5/d
         4fUy2yyhNb+G2vxyJ2xkb6+NDPVpKDSERc8o0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XDlmzq5VmAK4qn23LeiZsjimKJIYwaHeSrQIMg73wcZXrmFYcUxM0pcKNo5m/Oni/4
         H9VBOo116q8zNDhr1KeaNO4PRVSA0OfnUoUONckNkW+VrkFBEpT4zVMt+2HYxq4HC2cg
         pWwPZbwn7ECoSL77SlZfE+Rwn6ZLiGcqDV/xU=
Received: by 10.87.67.10 with SMTP id u10mr15389601fgk.28.1266440174504;
        Wed, 17 Feb 2010 12:56:14 -0800 (PST)
Received: from localhost (nat-nz.wwwcom.ru [195.62.62.242])
        by mx.google.com with ESMTPS id e11sm14418516fga.24.2010.02.17.12.56.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Feb 2010 12:56:12 -0800 (PST)
X-Mailer: git-send-email 1.7.0.14.g7e948
In-Reply-To: <20100217000456.GA28433@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140262>

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
index 20054e4..f4563f9 100644
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
+		port = "<none>";
 
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
