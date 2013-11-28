From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v7 10/10] git_connect(): Use common return point
Date: Thu, 28 Nov 2013 20:50:15 +0100
Message-ID: <201311282050.16371.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 20:50:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm7bW-0003Up-Iu
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 20:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759467Ab3K1TuW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 14:50:22 -0500
Received: from mout.web.de ([212.227.15.4]:61375 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759433Ab3K1TuV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 14:50:21 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MaJvw-1W5ypo1XS4-00JrQW for <git@vger.kernel.org>; Thu,
 28 Nov 2013 20:50:20 +0100
X-Provags-ID: V03:K0:P8Zl4cEnu/hDfarESbGHxTcqR7VohrvJxlWhRIAdY/xXVevNUXq
 WnDKxulSD32B19caQDF8Zr2/vKLI+GtCo1hJ7hfVkRkvSu3lxOog9nJ2Vkp/L2r68c4HZR1
 2lk1pS+ktQ7VGUD+helVIom1bmVZlHLBsL9PjjkgVyrt5Hr5+G1j7NB3yDK0WrDoq+xpJ6Z
 icJdYfKtjMeJlvWRdDAsg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238512>

Use only one return point from git_connect(), doing the
free():
return conn;
only at one place in the code.

There may be a little confusion what the variable "host" is for.
At some places it is only the host part, at other places it may include=
 the
port number, so change host into hostandport here.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 connect.c | 108 +++++++++++++++++++++++++++++-------------------------=
--------
 1 file changed, 50 insertions(+), 58 deletions(-)

diff --git a/connect.c b/connect.c
index 04093c4..8a013a7 100644
--- a/connect.c
+++ b/connect.c
@@ -656,7 +656,7 @@ static struct child_process no_fork;
 struct child_process *git_connect(int fd[2], const char *url,
 				  const char *prog, int flags)
 {
-	char *host, *path;
+	char *hostandport, *path;
 	struct child_process *conn =3D &no_fork;
 	enum protocol protocol;
 	const char **arg;
@@ -667,26 +667,22 @@ struct child_process *git_connect(int fd[2], cons=
t char *url,
 	 */
 	signal(SIGCHLD, SIG_DFL);
=20
-	protocol =3D parse_connect_url(url, &host, &path);
+	protocol =3D parse_connect_url(url, &hostandport, &path);
 	if (flags & CONNECT_DIAG_URL) {
 		printf("Diag: url=3D%s\n", url ? url : "NULL");
 		printf("Diag: protocol=3D%s\n", prot_name(protocol));
-		printf("Diag: hostandport=3D%s\n", host ? host : "NULL");
+		printf("Diag: hostandport=3D%s\n", hostandport ? hostandport : "NULL=
");
 		printf("Diag: path=3D%s\n", path ? path : "NULL");
-		free(host);
-		free(path);
-		return NULL;
-	}
-
-	if (protocol =3D=3D PROTO_GIT) {
+		conn =3D NULL;
+	} else if (protocol =3D=3D PROTO_GIT) {
 		/* These underlying connection commands die() if they
 		 * cannot connect.
 		 */
-		char *target_host =3D xstrdup(host);
-		if (git_use_proxy(host))
-			conn =3D git_proxy_connect(fd, host);
+		char *target_host =3D xstrdup(hostandport);
+		if (git_use_proxy(hostandport))
+			conn =3D git_proxy_connect(fd, hostandport);
 		else
-			git_tcp_connect(fd, host, flags);
+			git_tcp_connect(fd, hostandport, flags);
 		/*
 		 * Separate original protocol components prog and path
 		 * from extended host header with a NUL byte.
@@ -699,54 +695,50 @@ struct child_process *git_connect(int fd[2], cons=
t char *url,
 			     prog, path, 0,
 			     target_host, 0);
 		free(target_host);
-		free(host);
-		free(path);
-		return conn;
-	}
-
-	conn =3D xcalloc(1, sizeof(*conn));
-
-	strbuf_addstr(&cmd, prog);
-	strbuf_addch(&cmd, ' ');
-	sq_quote_buf(&cmd, path);
-
-	conn->in =3D conn->out =3D -1;
-	conn->argv =3D arg =3D xcalloc(7, sizeof(*arg));
-	if (protocol =3D=3D PROTO_SSH) {
-		const char *ssh =3D getenv("GIT_SSH");
-		int putty =3D ssh && strcasestr(ssh, "plink");
-		char *ssh_host =3D host; /* keep host for the free() below */
-		const char *port =3D NULL;
-		get_host_and_port(&ssh_host, &port);
-		port =3D get_port_numeric(port);
-
-		if (!ssh) ssh =3D "ssh";
-
-		*arg++ =3D ssh;
-		if (putty && !strcasestr(ssh, "tortoiseplink"))
-			*arg++ =3D "-batch";
-		if (port) {
-			/* P is for PuTTY, p is for OpenSSH */
-			*arg++ =3D putty ? "-P" : "-p";
-			*arg++ =3D port;
+	} else {
+		conn =3D xcalloc(1, sizeof(*conn));
+
+		strbuf_addstr(&cmd, prog);
+		strbuf_addch(&cmd, ' ');
+		sq_quote_buf(&cmd, path);
+
+		conn->in =3D conn->out =3D -1;
+		conn->argv =3D arg =3D xcalloc(7, sizeof(*arg));
+		if (protocol =3D=3D PROTO_SSH) {
+			const char *ssh =3D getenv("GIT_SSH");
+			int putty =3D ssh && strcasestr(ssh, "plink");
+			char *ssh_host =3D hostandport;
+			const char *port =3D NULL;
+			get_host_and_port(&ssh_host, &port);
+			port =3D get_port_numeric(port);
+
+			if (!ssh) ssh =3D "ssh";
+
+			*arg++ =3D ssh;
+			if (putty && !strcasestr(ssh, "tortoiseplink"))
+				*arg++ =3D "-batch";
+			if (port) {
+				/* P is for PuTTY, p is for OpenSSH */
+				*arg++ =3D putty ? "-P" : "-p";
+				*arg++ =3D port;
+			}
+			*arg++ =3D ssh_host;
+		}	else {
+			/* remove repo-local variables from the environment */
+			conn->env =3D local_repo_env;
+			conn->use_shell =3D 1;
 		}
-		*arg++ =3D ssh_host;
-	}
-	else {
-		/* remove repo-local variables from the environment */
-		conn->env =3D local_repo_env;
-		conn->use_shell =3D 1;
-	}
-	*arg++ =3D cmd.buf;
-	*arg =3D NULL;
+		*arg++ =3D cmd.buf;
+		*arg =3D NULL;
=20
-	if (start_command(conn))
-		die("unable to fork");
+		if (start_command(conn))
+			die("unable to fork");
=20
-	fd[0] =3D conn->out; /* read from child's stdout */
-	fd[1] =3D conn->in;  /* write to child's stdin */
-	strbuf_release(&cmd);
-	free(host);
+		fd[0] =3D conn->out; /* read from child's stdout */
+		fd[1] =3D conn->in;  /* write to child's stdin */
+		strbuf_release(&cmd);
+	}
+	free(hostandport);
 	free(path);
 	return conn;
 }
--=20
1.8.5.rc0.23.gaa27064
