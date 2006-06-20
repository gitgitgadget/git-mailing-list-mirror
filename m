From: David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] Log peer address when git-daemon called from inetd
Date: Tue, 20 Jun 2006 15:38:13 +0100
Message-ID: <1150814294.17609.68.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jdl@jdl.com
X-From: git-owner@vger.kernel.org Tue Jun 20 16:38:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FshMs-0000Yu-2U
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 16:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWFTOiL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Jun 2006 10:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWFTOiL
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 10:38:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15835 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751110AbWFTOiK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 10:38:10 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1FshMi-0001Xi-P7; Tue, 20 Jun 2006 15:38:04 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22204>

When we run git-daemon from inetd, even with the --verbose option, it
doesn't log the peer address. That logic was only in the standalone
d=C3=A6mon code -- move it to the execute() function instead. Tested wi=
th
both IPv6 and Legacy IP clients, in both inetd and d=C3=A6mon mode.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Acked-by: Jon Loeliger <jdl@jdl.com>

diff --git a/daemon.c b/daemon.c
index 2f03f99..7d30302 100644
--- a/daemon.c
+++ b/daemon.c
@@ -264,11 +264,34 @@ static int upload(char *dir)
 	return -1;
 }
=20
-static int execute(void)
+static int execute(struct sockaddr *addr)
 {
 	static char line[1000];
 	int pktlen, len;
=20
+	if (addr) {
+		char addrbuf[256] =3D "";
+		int port =3D -1;
+
+		if (addr->sa_family =3D=3D AF_INET) {
+			struct sockaddr_in *sin_addr =3D (void *) addr;
+			inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf, sizeof(add=
rbuf));
+			port =3D sin_addr->sin_port;
+#ifndef NO_IPV6
+		} else if (addr && addr->sa_family =3D=3D AF_INET6) {
+			struct sockaddr_in6 *sin6_addr =3D (void *) addr;
+		=09
+			char *buf =3D addrbuf;
+			*buf++ =3D '['; *buf =3D '\0'; /* stpcpy() is cool */
+			inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(addrbuf) - 1=
);
+			strcat(buf, "]");
+
+			port =3D sin6_addr->sin6_port;
+#endif
+		}
+		loginfo("Connection from %s:%d", addrbuf, port);
+	}
+
 	alarm(init_timeout ? init_timeout : timeout);
 	pktlen =3D packet_read_line(0, line, sizeof(line));
 	alarm(0);
@@ -414,8 +437,6 @@ static void check_max_connections(void)
 static void handle(int incoming, struct sockaddr *addr, int addrlen)
 {
 	pid_t pid =3D fork();
-	char addrbuf[256] =3D "";
-	int port =3D -1;
=20
 	if (pid) {
 		unsigned idx;
@@ -436,26 +457,7 @@ static void handle(int incoming, struct=20
 	dup2(incoming, 1);
 	close(incoming);
=20
-	if (addr->sa_family =3D=3D AF_INET) {
-		struct sockaddr_in *sin_addr =3D (void *) addr;
-		inet_ntop(AF_INET, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
-		port =3D sin_addr->sin_port;
-
-#ifndef NO_IPV6
-	} else if (addr->sa_family =3D=3D AF_INET6) {
-		struct sockaddr_in6 *sin6_addr =3D (void *) addr;
-
-		char *buf =3D addrbuf;
-		*buf++ =3D '['; *buf =3D '\0'; /* stpcpy() is cool */
-		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(addrbuf) - 1)=
;
-		strcat(buf, "]");
-
-		port =3D sin6_addr->sin6_port;
-#endif
-	}
-	loginfo("Connection from %s:%d", addrbuf, port);
-
-	exit(execute());
+	exit(execute(addr));
 }
=20
 static void child_handler(int signo)
@@ -751,8 +753,16 @@ int main(int argc, char **argv)
 	}
=20
 	if (inetd_mode) {
+		struct sockaddr_storage ss;
+		struct sockaddr *peer =3D (struct sockaddr *)&ss;
+		socklen_t slen =3D sizeof(ss);
+
 		fclose(stderr); //FIXME: workaround
-		return execute();
+
+		if (getpeername(0, peer, &slen))
+			peer =3D NULL;
+
+		return execute(peer);
 	}
=20
 	return serve(port);


--=20
dwmw2
