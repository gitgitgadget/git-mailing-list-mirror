From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v7 08/10] git_connect(): Refactor the port handling for ssh
Date: Thu, 28 Nov 2013 20:49:54 +0100
Message-ID: <201311282049.55160.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 28 20:50:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm7bD-0003FJ-3H
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 20:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759430Ab3K1TuB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 14:50:01 -0500
Received: from mout.web.de ([212.227.17.11]:55262 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759458Ab3K1TuA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 14:50:00 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MLPNm-1VlZMj2jxK-000f16 for <git@vger.kernel.org>; Thu,
 28 Nov 2013 20:49:59 +0100
X-Provags-ID: V03:K0:5dnoNPc5Z0SJbR2mbRJ0eOZexAyS5acJq0w4zUJlHttL0AIdGNR
 Lle1ju8aDL8cyM8xIZXojPp+OtQmSFumg650uaiUlZb3TrOz1I4qe5ViCYHeCzqveLWFwbO
 bHL9UgfnOwObFrmzlb7Fh4ToKU39dMmuE358Cxdu6+t4DFR3gp8sJ7J+lZ/SXC3pXjqWhvp
 j5xlLm3EC4v5NI/LyxxIg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238510>

Use get_host_and_port() even for ssh.
Remove the variable port git_connect(), and simplify parse_connect_url(=
)
Use only one return point in git_connect(), doing the free() and return=
 conn.

t5601 had 2 corner test cases which now pass.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 connect.c             | 47 +++++++++++++------------------------------=
----
 t/t5500-fetch-pack.sh |  9 +++------
 t/t5601-clone.sh      | 10 +---------
 3 files changed, 17 insertions(+), 49 deletions(-)

diff --git a/connect.c b/connect.c
index 7e5f608..7874530 100644
--- a/connect.c
+++ b/connect.c
@@ -541,16 +541,13 @@ static struct child_process *git_proxy_connect(in=
t fd[2], char *host)
 	return proxy;
 }
=20
-static char *get_port(char *host)
+static const char *get_port_numeric(const char *p)
 {
 	char *end;
-	char *p =3D strchr(host, ':');
-
 	if (p) {
 		long port =3D strtol(p + 1, &end, 10);
 		if (end !=3D p + 1 && *end =3D=3D '\0' && 0 <=3D port && port < 6553=
6) {
-			*p =3D '\0';
-			return p+1;
+			return p;
 		}
 	}
=20
@@ -562,7 +559,7 @@ static char *get_port(char *host)
  * The caller must free() the returned strings.
  */
 static enum protocol parse_connect_url(const char *url_orig, char **re=
t_host,
-				       char **ret_port, char **ret_path)
+				       char **ret_path)
 {
 	char *url;
 	char *host, *path;
@@ -570,7 +567,6 @@ static enum protocol parse_connect_url(const char *=
url_orig, char **ret_host,
 	int separator;
 	enum protocol protocol =3D PROTO_LOCAL;
 	int free_path =3D 0;
-	char *port =3D NULL;
=20
 	if (is_url(url_orig))
 		url =3D url_decode(url_orig);
@@ -589,16 +585,12 @@ static enum protocol parse_connect_url(const char=
 *url_orig, char **ret_host,
 	}
=20
 	/*
-	 * Don't do destructive transforms with git:// as that
-	 * protocol code does '[]' unwrapping of its own.
+	 * Don't do destructive transforms as protocol code does
+	 * '[]' unwrapping in get_host_and_port()
 	 */
 	if (host[0] =3D=3D '[') {
 		end =3D strchr(host + 1, ']');
 		if (end) {
-			if (protocol !=3D PROTO_GIT) {
-				*end =3D 0;
-				host++;
-			}
 			end++;
 		} else
 			end =3D host;
@@ -636,17 +628,7 @@ static enum protocol parse_connect_url(const char =
*url_orig, char **ret_host,
 		*ptr =3D '\0';
 	}
=20
-	/*
-	 * Add support for ssh port: ssh://host.xy:<port>/...
-	 */
-	if (protocol =3D=3D PROTO_SSH && separator =3D=3D '/')
-		port =3D get_port(end);
-
 	*ret_host =3D xstrdup(host);
-	if (port)
-		*ret_port =3D xstrdup(port);
-	else
-		*ret_port =3D NULL;
 	if (free_path)
 		*ret_path =3D path;
 	else
@@ -674,7 +656,6 @@ struct child_process *git_connect(int fd[2], const =
char *url,
 	char *host, *path;
 	struct child_process *conn =3D &no_fork;
 	enum protocol protocol;
-	char *port;
 	const char **arg;
 	struct strbuf cmd =3D STRBUF_INIT;
=20
@@ -683,18 +664,13 @@ struct child_process *git_connect(int fd[2], cons=
t char *url,
 	 */
 	signal(SIGCHLD, SIG_DFL);
=20
-	protocol =3D parse_connect_url(url, &host, &port, &path);
+	protocol =3D parse_connect_url(url, &host, &path);
 	if (flags & CONNECT_DIAG_URL) {
 		printf("Diag: url=3D%s\n", url ? url : "NULL");
 		printf("Diag: protocol=3D%s\n", prot_name(protocol));
-		printf("Diag: hostandport=3D%s", host ? host : "NULL");
-		if (port)
-			printf(":%s\n", port);
-		else
-			printf("\n");
+		printf("Diag: hostandport=3D%s\n", host ? host : "NULL");
 		printf("Diag: path=3D%s\n", path ? path : "NULL");
 		free(host);
-		free(port);
 		free(path);
 		return NULL;
 	}
@@ -721,7 +697,6 @@ struct child_process *git_connect(int fd[2], const =
char *url,
 			     target_host, 0);
 		free(target_host);
 		free(host);
-		free(port);
 		free(path);
 		return conn;
 	}
@@ -737,6 +712,11 @@ struct child_process *git_connect(int fd[2], const=
 char *url,
 	if (protocol =3D=3D PROTO_SSH) {
 		const char *ssh =3D getenv("GIT_SSH");
 		int putty =3D ssh && strcasestr(ssh, "plink");
+		char *ssh_host =3D host; /* keep host for the free() below */
+		const char *port =3D NULL;
+		get_host_and_port(&ssh_host, &port);
+		port =3D get_port_numeric(port);
+
 		if (!ssh) ssh =3D "ssh";
=20
 		*arg++ =3D ssh;
@@ -747,7 +727,7 @@ struct child_process *git_connect(int fd[2], const =
char *url,
 			*arg++ =3D putty ? "-P" : "-p";
 			*arg++ =3D port;
 		}
-		*arg++ =3D host;
+		*arg++ =3D ssh_host;
 	}
 	else {
 		/* remove repo-local variables from the environment */
@@ -764,7 +744,6 @@ struct child_process *git_connect(int fd[2], const =
char *url,
 	fd[1] =3D conn->in;  /* write to child's stdin */
 	strbuf_release(&cmd);
 	free(host);
-	free(port);
 	free(path);
 	return conn;
 }
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 2d3cdaa..f4a2a38 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -561,20 +561,18 @@ do
 		do
 			case "$p" in
 			*ssh*)
-				hh=3D$(echo $h | tr -d "[]")
 				pp=3Dssh
 				;;
 			*)
-				hh=3D$h
 				pp=3D$p
 			;;
 			esac
 			test_expect_success "fetch-pack --diag-url $p://$h/$r" '
-				check_prot_host_path $p://$h/$r $pp "$hh" "/$r"
+				check_prot_host_path $p://$h/$r $pp "$h" "/$r"
 			'
 			# "/~" -> "~" conversion
 			test_expect_success "fetch-pack --diag-url $p://$h/~$r" '
-				check_prot_host_path $p://$h/~$r $pp "$hh" "~$r"
+				check_prot_host_path $p://$h/~$r $pp "$h" "~$r"
 			'
 		done
 	done
@@ -604,13 +602,12 @@ do
 	p=3Dssh
 	for h in host [::1]
 	do
-		hh=3D$(echo $h | tr -d "[]")
 		test_expect_success "fetch-pack --diag-url $h:$r" '
 			check_prot_path $h:$r $p "$r"
 		'
 		# Do "/~" -> "~" conversion
 		test_expect_success "fetch-pack --diag-url $h:/~$r" '
-			check_prot_host_path $h:/~$r $p "$hh" "~$r"
+			check_prot_host_path $h:/~$r $p "$h" "~$r"
 		'
 	done
 done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 4db0c0b..53a1de9 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -364,15 +364,7 @@ do
 done
=20
 # Corner cases
-# failing
-for url in [foo]bar/baz:qux [foo/bar]:baz
-do
-	test_expect_failure "clone $url is not ssh" '
-		test_clone_url $url none
-	'
-done
-
-for url in foo/bar:baz
+for url in foo/bar:baz [foo]bar/baz:qux [foo/bar]:baz
 do
 	test_expect_success "clone $url is not ssh" '
 		test_clone_url $url none
--=20
1.8.5.rc0.23.gaa27064
