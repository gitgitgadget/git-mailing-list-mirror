From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 11/14] daemon: report connection from root-process
Date: Sun, 10 Oct 2010 15:20:51 +0200
Message-ID: <1286716854-5744-12-git-send-email-kusmabite@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 15:23:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vrq-0005D6-QX
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757741Ab0JJNXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 09:23:00 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54307 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757689Ab0JJNXA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:23:00 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so255794ewy.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9jgvboXYW5ZweI2a/CwnEEf/7+ngw9KI44IRpi4/WTU=;
        b=HrdtIJr0+pb7Puta9otZ/aPEPgzgO3Yr/J8vgPCVq8P8OS2Ij6xt4cXfYKz6gmcfqK
         HqYTGHrbAVIpZZXojBzYtWsVJ3F4vSTpP+bypVXJNeKZOshR+EVFT6t/hmUb9zdSiLKG
         hsTOloDrb44DdhK6Y8lAs6MtR/dYZ/Qxga40Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EC3b66PFi1UQdqi1lF/+q5tG8xSIcu/HQENx8vSVPPnitzquIwhBnISO94cZwZgvgX
         fTf+soYKAqx0+KxdTxCEOb4910/WAYT1zmHTTx5GrTMsfEtIXJsjEz2LX/Ed6fLP94aY
         IUeF0DvplGMnQFmUZTsk0BEDhXUfE6ogubf/4=
Received: by 10.14.37.7 with SMTP id x7mr2804115eea.3.1286716979501;
        Sun, 10 Oct 2010 06:22:59 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q54sm5197153eeh.18.2010.10.10.06.22.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:22:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158670>

Report incoming connections from the process that
accept() the connection instead of the handling
process.

This enables "Connection from"-reporting on
Windows, where getpeername(0, ...) consistently
fails.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   70 +++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 40 insertions(+), 30 deletions(-)

diff --git a/daemon.c b/daemon.c
index 82ba5c7..54bbec2 100644
--- a/daemon.c
+++ b/daemon.c
@@ -521,33 +521,6 @@ static int execute(struct sockaddr *addr)
 	static char line[1000];
 	int pktlen, len, i;
 
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
-
 	alarm(init_timeout ? init_timeout : timeout);
 	pktlen = packet_read_line(0, line, sizeof(line));
 	alarm(0);
@@ -676,10 +649,35 @@ static void check_dead_children(void)
 			cradle = &blanket->next;
 }
 
+static char *get_addrstr(int *port, struct sockaddr *addr)
+{
+	static char addrbuf[256] = "";
+	if (addr->sa_family == AF_INET) {
+		struct sockaddr_in *sin_addr = (void *) addr;
+		inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
+		*port = ntohs(sin_addr->sin_port);
+#ifndef NO_IPV6
+	} else if (addr && addr->sa_family == AF_INET6) {
+		struct sockaddr_in6 *sin6_addr = (void *) addr;
+
+		char *buf = addrbuf;
+		*buf++ = '['; *buf = '\0'; /* stpcpy() is cool */
+		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(addrbuf) - 1);
+		strcat(buf, "]");
+
+		*port = ntohs(sin6_addr->sin6_port);
+#endif
+	}
+	return addrbuf;
+}
+
 char **cld_argv;
 static void handle(int incoming, struct sockaddr *addr, int addrlen)
 {
 	struct child_process cld = { 0 };
+	char *addrstr, envbuf[300] = "REMOTE_ADDR=";
+	char *env[] = { envbuf, NULL };
+	int port = -1;
 
 	if (max_connections && live_children >= max_connections) {
 		kill_some_child();
@@ -692,14 +690,21 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
 		}
 	}
 
+	addrstr = get_addrstr(&port, addr);
+	strcat(envbuf, addrstr);
+
+	cld.env = (const char **)env;
 	cld.argv = (const char **)cld_argv;
 	cld.in = incoming;
 	cld.out = dup(incoming);
 
 	if (start_command(&cld))
 		logerror("unable to fork");
-	else
+	else {
+		loginfo("[%"PRIuMAX"] Connection from %s:%d",
+		    (uintmax_t)cld.pid, addrstr, port);
 		add_child(&cld, addr, addrlen);
+	}
 	close(incoming);
 }
 
@@ -1164,8 +1169,13 @@ int main(int argc, char **argv)
 		if (inetd_mode && !freopen("/dev/null", "w", stderr))
 			die_errno("failed to redirect stderr to /dev/null");
 
-		if (getpeername(0, peer, &slen))
-			peer = NULL;
+		if (!getpeername(0, peer, &slen)) {
+			int port = -1;
+			char *addrstr = get_addrstr(&port, peer);
+			setenv("REMOTE_ADDR", addrstr, 1);
+			loginfo("[%"PRIuMAX"] Connection from %s:%d",
+			    (uintmax_t)getpid(), addrstr, port);
+		}
 
 		return execute(peer);
 	}
-- 
1.7.3.1.51.ge462f.dirty
