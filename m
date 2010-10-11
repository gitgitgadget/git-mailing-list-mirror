From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v4 11/15] daemon: report connection from root-process
Date: Mon, 11 Oct 2010 23:50:25 +0200
Message-ID: <1286833829-5116-12-git-send-email-kusmabite@gmail.com>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, avarab@gmail.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 23:52:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5QIa-0006gZ-K0
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 23:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631Ab0JKVwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 17:52:42 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36668 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565Ab0JKVwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 17:52:41 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so833577ewy.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 14:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=v1wuAYqnwYFW0we+3KZ7xRzybiq736dhXZP37EXcomc=;
        b=csnlFl2jGWjE0YH2L26NbJFKqlagKwSyryn3aX0nykYFJ9tjfy4KSwjZKuu3eRfm66
         Ex0hhg3g3uhuHDwB8P3ycpzk4iR522RiPsX1D58uWKEx/D/fOUHdK7XRwOZ7jkYPOQRi
         zwKLgSy16HswqN7ANhm+Ny5rNgbuBlfxCWOBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I63i9yrhsy1SN/GEm14YObEoYfDc8fuPqXIAEZqV6TWbdBoThSheP9+DDzunBSz2aY
         CArkWSqOvwvg1WmlgOHj2+zJqUbo9/dhWkb9khKruJ9ReWdFzdGuQitcn9WF+66I9WGE
         wwG4PvgI95JnZv6V5a7UsqRI6/KLOdICyCnYA=
Received: by 10.213.44.129 with SMTP id a1mr3540171ebf.57.1286833960896;
        Mon, 11 Oct 2010 14:52:40 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v8sm11653762eeh.14.2010.10.11.14.52.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 14:52:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158803>

Report incoming connections from the process that
accept() the connection instead of the handling
process.

This enables "Connection from"-reporting on
Windows, where getpeername(0, ...) consistently
fails.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   72 ++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/daemon.c b/daemon.c
index 8a44fb9..1574f75 100644
--- a/daemon.c
+++ b/daemon.c
@@ -516,38 +516,11 @@ static void parse_host_arg(char *extra_args, int buflen)
 }
 
 
-static int execute(struct sockaddr *addr)
+static int execute(void)
 {
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
 static char **cld_argv;
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
 
@@ -1157,17 +1162,10 @@ int main(int argc, char **argv)
 		    base_path);
 
 	if (serve_mode) {
-		struct sockaddr_storage ss;
-		struct sockaddr *peer = (struct sockaddr *)&ss;
-		socklen_t slen = sizeof(ss);
-
 		if (inetd_mode && !freopen("/dev/null", "w", stderr))
 			die_errno("failed to redirect stderr to /dev/null");
 
-		if (getpeername(0, peer, &slen))
-			peer = NULL;
-
-		return execute(peer);
+		return execute();
 	}
 
 	if (detach) {
-- 
1.7.3.1.199.g72340
