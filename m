From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v7 04/10] git_connect: factor out discovery of the protocol and its parts
Date: Thu, 28 Nov 2013 20:49:01 +0100
Message-ID: <201311282049.02492.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 20:49:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm7ah-0002uH-Sm
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 20:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759406Ab3K1TtL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 14:49:11 -0500
Received: from mout.web.de ([212.227.15.3]:51950 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759267Ab3K1TtJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 14:49:09 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0M8iH2-1Vw2fY11kC-00C7kt for <git@vger.kernel.org>; Thu,
 28 Nov 2013 20:49:08 +0100
X-Provags-ID: V03:K0:Mc6DoGO8ZRmO7wmU5/xgptaGNPT1liLSm8I6jtoasMXYqe4xkBP
 YDxHqZdQmS3v7db4+tpImphWI0KUVDhn6h4MTetmROGKWbH2WVo0BYUCz6kMldHFDEI1HNK
 VtANmdPHb9r3ZhBoj4uA3SaZv7syAw4MgL3WC2A58B5nhqsoFUW4zFaEvCFRRER5I5RoOqS
 kZJNeR7OMDvbKuEL1QBtw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238507>

git_connect has grown large due to the many different protocols syntaxe=
s
that are supported. Move the part of the function that parses the URL t=
o
connect to into a separate function for readability.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 connect.c | 80 ++++++++++++++++++++++++++++++++++++++++++-------------=
--------
 1 file changed, 53 insertions(+), 27 deletions(-)

diff --git a/connect.c b/connect.c
index 6cc1f8d..a6cf345 100644
--- a/connect.c
+++ b/connect.c
@@ -543,37 +543,20 @@ static char *get_port(char *host)
 	return NULL;
 }
=20
-static struct child_process no_fork;
-
 /*
- * This returns a dummy child_process if the transport protocol does n=
ot
- * need fork(2), or a struct child_process object if it does.  Once do=
ne,
- * finish the connection with finish_connect() with the value returned=
 from
- * this function (it is safe to call finish_connect() with NULL to sup=
port
- * the former case).
- *
- * If it returns, the connect is successful; it just dies on errors (t=
his
- * will hopefully be changed in a libification effort, to return NULL =
when
- * the connection failed).
+ * Extract protocol and relevant parts from the specified connection U=
RL.
+ * The caller must free() the returned strings.
  */
-struct child_process *git_connect(int fd[2], const char *url_orig,
-				  const char *prog, int flags)
+static enum protocol parse_connect_url(const char *url_orig, char **re=
t_host,
+				       char **ret_port, char **ret_path)
 {
 	char *url;
 	char *host, *path;
 	char *end;
 	int c;
-	struct child_process *conn =3D &no_fork;
 	enum protocol protocol =3D PROTO_LOCAL;
 	int free_path =3D 0;
 	char *port =3D NULL;
-	const char **arg;
-	struct strbuf cmd =3D STRBUF_INIT;
-
-	/* Without this we cannot rely on waitpid() to tell
-	 * what happened to our children.
-	 */
-	signal(SIGCHLD, SIG_DFL);
=20
 	if (is_url(url_orig))
 		url =3D url_decode(url_orig);
@@ -645,6 +628,49 @@ struct child_process *git_connect(int fd[2], const=
 char *url_orig,
 	if (protocol =3D=3D PROTO_SSH && host !=3D url)
 		port =3D get_port(end);
=20
+	*ret_host =3D xstrdup(host);
+	if (port)
+		*ret_port =3D xstrdup(port);
+	else
+		*ret_port =3D NULL;
+	if (free_path)
+		*ret_path =3D path;
+	else
+		*ret_path =3D xstrdup(path);
+	free(url);
+	return protocol;
+}
+
+static struct child_process no_fork;
+
+/*
+ * This returns a dummy child_process if the transport protocol does n=
ot
+ * need fork(2), or a struct child_process object if it does.  Once do=
ne,
+ * finish the connection with finish_connect() with the value returned=
 from
+ * this function (it is safe to call finish_connect() with NULL to sup=
port
+ * the former case).
+ *
+ * If it returns, the connect is successful; it just dies on errors (t=
his
+ * will hopefully be changed in a libification effort, to return NULL =
when
+ * the connection failed).
+ */
+struct child_process *git_connect(int fd[2], const char *url,
+				  const char *prog, int flags)
+{
+	char *host, *path;
+	struct child_process *conn =3D &no_fork;
+	enum protocol protocol;
+	char *port;
+	const char **arg;
+	struct strbuf cmd =3D STRBUF_INIT;
+
+	/* Without this we cannot rely on waitpid() to tell
+	 * what happened to our children.
+	 */
+	signal(SIGCHLD, SIG_DFL);
+
+	protocol =3D parse_connect_url(url, &host, &port, &path);
+
 	if (protocol =3D=3D PROTO_GIT) {
 		/* These underlying connection commands die() if they
 		 * cannot connect.
@@ -666,9 +692,9 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 			     prog, path, 0,
 			     target_host, 0);
 		free(target_host);
-		free(url);
-		if (free_path)
-			free(path);
+		free(host);
+		free(port);
+		free(path);
 		return conn;
 	}
=20
@@ -709,9 +735,9 @@ struct child_process *git_connect(int fd[2], const =
char *url_orig,
 	fd[0] =3D conn->out; /* read from child's stdout */
 	fd[1] =3D conn->in;  /* write to child's stdin */
 	strbuf_release(&cmd);
-	free(url);
-	if (free_path)
-		free(path);
+	free(host);
+	free(port);
+	free(path);
 	return conn;
 }
=20
--=20
1.8.5.rc0.23.gaa27064
