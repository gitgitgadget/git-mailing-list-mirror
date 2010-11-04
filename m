From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v7 11/16] daemon: get remote host address from root-process
Date: Thu,  4 Nov 2010 02:35:19 +0100
Message-ID: <1288834524-2400-12-git-send-email-kusmabite@gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 02:36:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDokt-0001ds-0q
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab0KDBfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 21:35:53 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51588 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab0KDBfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:35:50 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so738623ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3nw3YwEiEfd4qF8mfAYkUICfFhOUpJGa1SQKZsNkSJw=;
        b=HZ72dovFYwe3HovvP1u7qyrM//KslZLHxi7GuJCwbhXGzzAoY1nzppgErFkFQEQmHF
         xrgHuDxoFmOMZRh5E3KEtRofcpIikHRQHRnfI+YF1W6KHnNHQEQ4ECIi/mX9lTrtNuvN
         6eD5j5t5+QxkqvAIhVQZ7ImpcUqgCJSIS5RYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ggb1ryPPw0TlFe3AfpO2gJa8da16GdEXkSd6lro7Br5swBVdmm0f/B/a8NLJm5ks/F
         nw0NGoa4uOe5YTAd6IeWcgBBCW1Xl13a6BvSoiYCOrRk+CcuqSKdIUs0f4uBfOHCAHgg
         W1yNv4nJ5ugMnYge/EWCnC4r1I/LKOYUNtWGk=
Received: by 10.213.16.75 with SMTP id n11mr100540eba.5.1288834549846;
        Wed, 03 Nov 2010 18:35:49 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id w20sm7189179eeh.12.2010.11.03.18.35.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 18:35:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160671>

Get remote host in the process that accept() and pass it through
the REMOTE_ADDR environment variable to the handler-process.
Introduce the REMOTE_PORT environmen variable for the port.

Use these variables for reporting instead of doing
getpeername(0, ...), which doesn't work on Windows.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   79 ++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/daemon.c b/daemon.c
index 941c095..8162f10 100644
--- a/daemon.c
+++ b/daemon.c
@@ -516,37 +516,14 @@ static void parse_host_arg(char *extra_args, int buflen)
 }
 
 
-static int execute(struct sockaddr *addr)
+static int execute(void)
 {
 	static char line[1000];
 	int pktlen, len, i;
+	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
 
-	if (addr) {
-		char addrbuf[256] = "";
-		int port = -1;
-
-		if (addr->sa_family == AF_INET) {
-			struct sockaddr_in *sin_addr = (void *) addr;
-			inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
-			port = ntohs(sin_addr->sin_port);
-#ifndef NO_IPV6
-		} else if (addr && addr->sa_family == AF_INET6) {
-			struct sockaddr_in6 *sin6_addr = (void *) addr;
-
-			char *buf = addrbuf;
-			*buf++ = '['; *buf = '\0'; /* stpcpy() is cool */
-			inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(addrbuf) - 1);
-			strcat(buf, "]");
-
-			port = ntohs(sin6_addr->sin6_port);
-#endif
-		}
-		loginfo("Connection from %s:%d", addrbuf, port);
-		setenv("REMOTE_ADDR", addrbuf, 1);
-	}
-	else {
-		unsetenv("REMOTE_ADDR");
-	}
+	if (addr)
+		loginfo("Connection from %s:%s", addr, port);
 
 	alarm(init_timeout ? init_timeout : timeout);
 	pktlen = packet_read_line(0, line, sizeof(line));
@@ -680,6 +657,8 @@ static char **cld_argv;
 static void handle(int incoming, struct sockaddr *addr, int addrlen)
 {
 	struct child_process cld = { 0 };
+	char addrbuf[300] = "REMOTE_ADDR=", portbuf[300];
+	char *env[] = { addrbuf, portbuf, NULL };
 
 	if (max_connections && live_children >= max_connections) {
 		kill_some_child();
@@ -692,6 +671,28 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
 		}
 	}
 
+	if (addr->sa_family == AF_INET) {
+		struct sockaddr_in *sin_addr = (void *) addr;
+		inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf + 12,
+		    sizeof(addrbuf) - 12);
+		snprintf(portbuf, sizeof(portbuf), "REMOTE_PORT=%d",
+		    ntohs(sin_addr->sin_port));
+#ifndef NO_IPV6
+	} else if (addr && addr->sa_family == AF_INET6) {
+		struct sockaddr_in6 *sin6_addr = (void *) addr;
+
+		char *buf = addrbuf + 12;
+		*buf++ = '['; *buf = '\0'; /* stpcpy() is cool */
+		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf,
+		    sizeof(addrbuf) - 13);
+		strcat(buf, "]");
+
+		snprintf(portbuf, sizeof(portbuf), "REMOTE_PORT=%d",
+		    ntohs(sin6_addr->sin6_port));
+#endif
+	}
+
+	cld.env = (const char **)env;
 	cld.argv = (const char **)cld_argv;
 	cld.in = incoming;
 	cld.out = dup(incoming);
@@ -902,9 +903,15 @@ static int service_loop(struct socketlist *socklist)
 
 		for (i = 0; i < socklist->nr; i++) {
 			if (pfd[i].revents & POLLIN) {
-				struct sockaddr_storage ss;
+				union {
+					struct sockaddr sa;
+					struct sockaddr_in sai;
+#ifndef NO_IPV6
+					struct sockaddr_in6 sai6;
+#endif
+				} ss;
 				unsigned int sslen = sizeof(ss);
-				int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
+				int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
 					case EAGAIN:
@@ -915,7 +922,7 @@ static int service_loop(struct socketlist *socklist)
 						die_errno("accept returned");
 					}
 				}
-				handle(incoming, (struct sockaddr *)&ss, sslen);
+				handle(incoming, &ss.sa, sslen);
 			}
 		}
 	}
@@ -1160,16 +1167,8 @@ int main(int argc, char **argv)
 			die_errno("failed to redirect stderr to /dev/null");
 	}
 
-	if (inetd_mode || serve_mode) {
-		struct sockaddr_storage ss;
-		struct sockaddr *peer = (struct sockaddr *)&ss;
-		socklen_t slen = sizeof(ss);
-
-		if (getpeername(0, peer, &slen))
-			return execute(NULL);
-		else
-			return execute(peer);
-	}
+	if (inetd_mode || serve_mode)
+		return execute();
 
 	if (detach) {
 		daemonize();
-- 
1.7.3.2.162.g09d37
