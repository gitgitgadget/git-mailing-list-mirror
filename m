From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 11/16] daemon: get remote host address from root-process
Date: Wed,  3 Nov 2010 17:31:29 +0100
Message-ID: <1288801894-1168-12-git-send-email-kusmabite@gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:32:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgGU-0002aC-VN
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087Ab0KCQcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:32:15 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55502 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab0KCQcL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:32:11 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so386169eye.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=x4hJi7OpmAoWPPKg9lWBvt4fRuYPcV4AtrT9DcHAwqA=;
        b=HibK2h8KcChVOPQC+6TdtQc/T1PzUN4KwO5MPBLhhDN+o/hgig85VrBakaZRRDig2o
         +1OliqkSZ+Hg5L83hvDhlm2ydlTDRAj9xW8I3iS3GyAaXlzZ6ilEvs2dlvKQKahwI2Er
         Pq2Cc0frjovxITQyl66uRKXqORBqfYRr7iMZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=muQtpI5TLlkOuUmrKuT7MAvcy0ZIN2lHL5bvMjgblJjy/GHJz13eUHVEJXqIupWpS3
         OXYgOfM1Z5kjvPzWTpF5dhFcQ5Z5ku4p8oLxFQKJhbFYqcmVsYzsBPL44OpdhA9nK+Rj
         KteQTiu82bj+YDTs1XilKGcXJSQMleCCeiDks=
Received: by 10.14.45.76 with SMTP id o52mr811689eeb.43.1288801930871;
        Wed, 03 Nov 2010 09:32:10 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id x54sm6709966eeh.17.2010.11.03.09.32.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:32:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160618>

Get remote host in the process that accept() and pass it through
the REMOTE_ADDR environment variable to the handler-process.
Introduce the REMOTE_PORT environmen variable for the port.

Use these variables for reporting instead of doing
getpeername(0, ...), which doesn't work on Windows.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   67 +++++++++++++++++++++++++++----------------------------------
 1 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/daemon.c b/daemon.c
index 9a4884a..3d8f6e6 100644
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
@@ -1160,16 +1161,8 @@ int main(int argc, char **argv)
 			die_errno("failed to redirect stderr to /dev/null");
 	}
 
-	if (inetd_mode || serve_mode) {
-		struct sockaddr_storage ss;
-		struct sockaddr *peer = (struct sockaddr *)&ss;
-		socklen_t slen = sizeof(ss);
-
-		if (getpeername(0, peer, &slen))
-			peer = NULL;
-
-		return execute(peer);
-	}
+	if (inetd_mode || serve_mode)
+		return execute();
 
 	if (detach) {
 		daemonize();
-- 
1.7.3.2.161.gd6e00
