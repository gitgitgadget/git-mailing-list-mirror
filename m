From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/6] connect: uniformize and group CONNECT_DIAG_URL handling code
Date: Sun,  1 May 2016 15:02:49 +0900
Message-ID: <1462082573-17992-3-git-send-email-mh@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 08:03:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awkTN-0007yr-Un
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 08:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbcEAGDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 02:03:07 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:33626 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750892AbcEAGDA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 02:03:00 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1awkSz-0004h2-UC; Sun, 01 May 2016 15:02:53 +0900
X-Mailer: git-send-email 2.8.1.16.g58dac65.dirty
In-Reply-To: <1462082573-17992-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293142>

The CONNECT_DIAG_URL code for PROTO_GIT and PROTO_SSH were different in
subtle ways. Those differences are not significant enough to justify the
duplication of code, while this change also avoids starting to
initialize a connection at all when handling CONNECT_DIAG_URL.

This also moves the get_host_and_port() call earlier than it was
happening, while preserving hostandport intact (get_host_and_port()
possibly altering the string it's passed), because all or hostandport,
host and port may be used.

Further changes are going to remove several uses of hostandport where
get_host_and_port() is used further down the line.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c             | 28 +++++++++-------------------
 t/t5500-fetch-pack.sh | 25 +++++++++++++++----------
 2 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/connect.c b/connect.c
index 45308ef..98449bc 100644
--- a/connect.c
+++ b/connect.c
@@ -656,7 +656,8 @@ static struct child_process no_fork = CHILD_PROCESS_INIT;
 struct child_process *git_connect(int fd[2], const char *url,
 				  const char *prog, int flags)
 {
-	char *hostandport, *path;
+	char *hostandport, *path, *host;
+	const char *port = NULL;
 	struct child_process *conn = &no_fork;
 	enum protocol protocol;
 	struct strbuf cmd = STRBUF_INIT;
@@ -667,10 +668,14 @@ struct child_process *git_connect(int fd[2], const char *url,
 	signal(SIGCHLD, SIG_DFL);
 
 	protocol = parse_connect_url(url, &hostandport, &path);
-	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
+	host = xstrdup(hostandport);
+	get_host_and_port(&host, &port);
+	if (flags & CONNECT_DIAG_URL) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
 		printf("Diag: protocol=%s\n", prot_name(protocol));
 		printf("Diag: hostandport=%s\n", hostandport ? hostandport : "NULL");
+		printf("Diag: userandhost=%s\n", host ? host : "NULL");
+		printf("Diag: port=%s\n", port ? port : "NONE");
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
 	} else if (protocol == PROTO_GIT) {
@@ -721,23 +726,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		if (protocol == PROTO_SSH) {
 			const char *ssh;
 			int putty = 0, tortoiseplink = 0;
-			char *ssh_host = hostandport;
-			const char *port = NULL;
 			transport_check_allowed("ssh");
-			get_host_and_port(&ssh_host, &port);
-
-			if (flags & CONNECT_DIAG_URL) {
-				printf("Diag: url=%s\n", url ? url : "NULL");
-				printf("Diag: protocol=%s\n", prot_name(protocol));
-				printf("Diag: userandhost=%s\n", ssh_host ? ssh_host : "NULL");
-				printf("Diag: port=%s\n", port ? port : "NONE");
-				printf("Diag: path=%s\n", path ? path : "NULL");
-
-				free(hostandport);
-				free(path);
-				free(conn);
-				return NULL;
-			}
 
 			ssh = getenv("GIT_SSH_COMMAND");
 			if (!ssh) {
@@ -779,7 +768,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 				argv_array_push(&conn->args, putty ? "-P" : "-p");
 				argv_array_push(&conn->args, port);
 			}
-			argv_array_push(&conn->args, ssh_host);
+			argv_array_push(&conn->args, host);
 		} else {
 			transport_check_allowed("file");
 		}
@@ -793,6 +782,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		strbuf_release(&cmd);
 	}
 	free(hostandport);
+	free(host);
 	free(path);
 	return conn;
 }
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index e5f83bf..360c59d 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -537,7 +537,7 @@ check_prot_path () {
 	Diag: protocol=$2
 	Diag: path=$3
 	EOF
-	git fetch-pack --diag-url "$1" | grep -v hostandport= >actual &&
+	git fetch-pack --diag-url "$1" | grep -v host= | grep -v port= >actual &&
 	test_cmp expected actual
 }
 
@@ -546,22 +546,27 @@ check_prot_host_port_path () {
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
+	case "$4" in
+		NONE)
+		hostandport=$3
+		;;
+		*)
+		hostandport=$3:$4
+		;;
+	esac
+	ehost=$(echo $3 | tr -d "[]")
+	diagport="Diag: port=$4"
 	cat >exp <<-EOF &&
 	Diag: url=$1
 	Diag: protocol=$pp
-	Diag: $uah=$ehost
-	$diagport
+	Diag: hostandport=$hostandport
+	Diag: userandhost=$ehost
+	Diag: port=$4
 	Diag: path=$5
 	EOF
 	grep -v "^$" exp >expected
-- 
2.8.1.16.g58dac65.dirty
