From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v7 4/9] connect: make parse_connect_url() return separated host and port
Date: Sun, 22 May 2016 08:17:27 +0900
Message-ID: <20160521231732.4888-5-mh@glandium.org>
References: <20160521231732.4888-1-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 01:18:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4G9l-0005ls-3C
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 01:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbcEUXRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 19:17:47 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:55518 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbcEUXRk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 19:17:40 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b4G9E-0001Hn-VY; Sun, 22 May 2016 08:17:32 +0900
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160521231732.4888-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295250>

Now that nothing besides CONNECT_DIAG_URL is using hostandport, we can
have parse_connect_url() itself do the host and port splitting.

This still leaves "user@" part of the host, if there is one, which will
be addressed in a subsequent change. This however does add /some/
handling of the "user@" part of the host, in order to pick the port
properly.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c             | 43 +++++++++++++++++++++++++------------------
 t/t5500-fetch-pack.sh | 32 +++++++++++++++++++++-----------
 2 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/connect.c b/connect.c
index 7cdaed1..edbf0e2 100644
--- a/connect.c
+++ b/connect.c
@@ -589,10 +589,11 @@ static char *get_port(char *host)
  * The caller must free() the returned strings.
  */
 static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
-				       char **ret_path)
+				       char **ret_port, char **ret_path)
 {
 	char *url;
 	char *host, *path;
+	const char *port = NULL;
 	char *end;
 	int separator = '/';
 	enum protocol protocol = PROTO_LOCAL;
@@ -647,7 +648,24 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	path = xstrdup(path);
 	*end = '\0';
 
+	get_host_and_port(&host, &port);
+
+	if (*host && !port) {
+		/* get_host_and_port may not return a port even when there is
+		 * one: In the [host:port]:path case, get_host_and_port is
+		 * called with "[host:port]" and returns "host:port" and NULL.
+		 * In that specific case, we still need to split the port.
+		 * "host:port" may also look like "user@host:port". As the
+		 * `user` portion tends to be less strict than `host:port`,
+		 * we first put it out of the equation: since a hostname
+		 * cannot contain a '@', we start from the last '@' in the
+		 * string. */
+		char *end_user = strrchr(host, '@');
+		port = get_port(end_user ? end_user : host);
+	}
+
 	*ret_host = xstrdup(host);
+	*ret_port = port ? xstrdup(port) : NULL;
 	*ret_path = path;
 	free(url);
 	return protocol;
@@ -669,8 +687,7 @@ static struct child_process no_fork = CHILD_PROCESS_INIT;
 struct child_process *git_connect(int fd[2], const char *url,
 				  const char *prog, int flags)
 {
-	char *hostandport, *path, *host;
-	const char *port = NULL;
+	char *host, *port, *path;
 	struct child_process *conn = &no_fork;
 	enum protocol protocol;
 	struct strbuf cmd = STRBUF_INIT;
@@ -680,13 +697,12 @@ struct child_process *git_connect(int fd[2], const char *url,
 	 */
 	signal(SIGCHLD, SIG_DFL);
 
-	protocol = parse_connect_url(url, &hostandport, &path);
-	host = xstrdup(hostandport);
-	get_host_and_port(&host, &port);
+	protocol = parse_connect_url(url, &host, &port, &path);
 	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
 		printf("Diag: protocol=%s\n", prot_name(protocol));
-		printf("Diag: hostandport=%s\n", hostandport ? hostandport : "NULL");
+		printf("Diag: userandhost=%s\n", host ? host : "NULL");
+		printf("Diag: port=%s\n", port ? port : "NONE");
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
@@ -754,15 +770,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 			int putty = 0, tortoiseplink = 0;
 			transport_check_allowed("ssh");
 
-			/* get_host_and_port may not return a port even when
-			 * there is one: In the [host:port]:path case,
-			 * get_host_and_port is called with "[host:port]" and
-			 * returns "host:port" and NULL.
-			 * In that specific case, we still need to split the
-			 * port. */
-			if (!port)
-				port = get_port(host);
-
 			if (flags & CONNECT_DIAG_URL) {
 				printf("Diag: url=%s\n", url ? url : "NULL");
 				printf("Diag: protocol=%s\n", prot_name(protocol));
@@ -770,8 +777,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 				printf("Diag: port=%s\n", port ? port : "NONE");
 				printf("Diag: path=%s\n", path ? path : "NULL");
 
-				free(hostandport);
 				free(host);
+				free(port);
 				free(path);
 				free(conn);
 				return NULL;
@@ -830,8 +837,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 		fd[1] = conn->in;  /* write to child's stdin */
 		strbuf_release(&cmd);
 	}
-	free(hostandport);
 	free(host);
+	free(port);
 	free(path);
 	return conn;
 }
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 91a69fc..739c6b1 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -553,7 +553,7 @@ check_prot_path () {
 	Diag: protocol=$2
 	Diag: path=$3
 	EOF
-	git fetch-pack --diag-url "$1" | grep -v hostandport= >actual &&
+	git fetch-pack --diag-url "$1" | egrep -v '(host|port)=' >actual &&
 	test_cmp expected actual
 }
 
@@ -562,22 +562,17 @@ check_prot_host_port_path () {
 	case "$2" in
 		*ssh*)
 		pp=ssh
-		uah=userandhost
-		ehost=$(echo $3 | tr -d "[]")
-		diagport="Diag: port=$4"
 		;;
 		*)
-		pp=$p
-		uah=hostandport
-		ehost=$(echo $3$4 | sed -e "s/22$/:22/" -e "s/NONE//")
-		diagport=""
+		pp=$2
 		;;
 	esac
+	ehost=$(echo $3 | tr -d "[]")
 	cat >exp <<-EOF &&
 	Diag: url=$1
 	Diag: protocol=$pp
-	Diag: $uah=$ehost
-	$diagport
+	Diag: userandhost=$ehost
+	Diag: port=$4
 	Diag: path=$5
 	EOF
 	grep -v "^$" exp >expected
@@ -585,7 +580,7 @@ check_prot_host_port_path () {
 	test_cmp expected actual
 }
 
-for r in repo re:po re/po
+for r in repo re:po re/po re@po
 do
 	# git or ssh with scheme
 	for p in "ssh+git" "git+ssh" git ssh
@@ -608,6 +603,9 @@ do
 			test_expect_success "fetch-pack --diag-url $p://$h:22/$r" '
 				check_prot_host_port_path $p://$h:22/$r $p "$h" 22 "/$r"
 			'
+			test_expect_success "fetch-pack --diag-url $p://$h:22/$r" '
+				check_prot_host_port_path $p://$h:22/$r $p "$h" 22 "/$r"
+			'
 		done
 	done
 	# file with scheme
@@ -644,6 +642,18 @@ do
 			check_prot_host_port_path $h:/~$r $p "$h" NONE "~$r"
 		'
 	done
+	#ssh without scheme with port
+	p=ssh
+	for h in host user@host
+	do
+		test_expect_success "fetch-pack --diag-url [$h:22]:$r" '
+			check_prot_host_port_path [$h:22]:$r $p $h 22 "$r"
+		'
+		# Do "/~" -> "~" conversion
+		test_expect_success "fetch-pack --diag-url [$h:22]:/~$r" '
+			check_prot_host_port_path [$h:22]:/~$r $p $h 22 "~$r"
+		'
+	done
 done
 
 test_expect_success MINGW 'fetch-pack --diag-url file://c:/repo' '
-- 
2.8.3.401.ga81c606.dirty
