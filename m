From: Torsten =?iso-8859-1?q?B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH v6 08/10] git_connect(): Refactor the port handling
Date: Thu, 21 Nov 2013 21:41:47 +0100
Message-ID: <201311212141.48067.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 21:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjb4Y-00016A-H4
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 21:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209Ab3KUUlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 15:41:55 -0500
Received: from mout.web.de ([212.227.17.12]:61066 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020Ab3KUUly (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 15:41:54 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0Lu4uA-1VZBnd4006-011ShB for <git@vger.kernel.org>; Thu,
 21 Nov 2013 21:41:53 +0100
X-Provags-ID: V03:K0:Xv/0cp/LOoD+NmSRpSx3m4A1RCNQ/EL/2UIecS7lLJCx2h147M3
 G8wKsLVP3QnKJKwLarqWUw+NDLDsBDfacewK0TEdyir3r/qHC7eQYj+PH2qh2hVlJEaKPxN
 Utx21sBS/7OmV9Dn8lhx/wiD8wym0/BQSZ7EEtkImHj2HEmmm4kUjiL93lh1Ln0mcFWrXZ9
 kmuoAm9QIlJMZl1zMlakQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238150>

Use get_host_and_port() even for ssh.
Remove the variable port git_connect(), and simplify parse_connect_url()
Use only one return point in git_connect(), doing the free() and return conn.

t5601 had 2 corner test cases which now pass.
---
 connect.c             | 47 +++++++++++++----------------------------------
 t/t5500-fetch-pack.sh |  9 +++------
 2 files changed, 16 insertions(+), 40 deletions(-)

diff --git a/connect.c b/connect.c
index 0cb88b8..3d174c8 100644
--- a/connect.c
+++ b/connect.c
@@ -540,16 +540,13 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 	return proxy;
 }
 
-static char *get_port(char *host)
+static const char *get_port_numeric(const char *p)
 {
 	char *end;
-	char *p = strchr(host, ':');
-
 	if (p) {
 		long port = strtol(p + 1, &end, 10);
 		if (end != p + 1 && *end == '\0' && 0 <= port && port < 65536) {
-			*p = '\0';
-			return p+1;
+			return p;
 		}
 	}
 
@@ -561,7 +558,7 @@ static char *get_port(char *host)
  * The caller must free() the returned strings.
  */
 static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
-				       char **ret_port, char **ret_path)
+				       char **ret_path)
 {
 	char *url;
 	char *host, *path;
@@ -569,7 +566,6 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	int separator;
 	enum protocol protocol = PROTO_LOCAL;
 	int free_path = 0;
-	char *port = NULL;
 
 	if (is_url(url_orig))
 		url = url_decode(url_orig);
@@ -588,16 +584,12 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	}
 
 	/*
-	 * Don't do destructive transforms with git:// as that
-	 * protocol code does '[]' unwrapping of its own.
+	 * Don't do destructive transforms as protocol code does
+	 * '[]' unwrapping in get_host_and_port()
 	 */
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
 		if (end) {
-			if (protocol != PROTO_GIT) {
-				*end = 0;
-				host++;
-			}
 			end++;
 		} else
 			end = host;
@@ -635,17 +627,7 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 		*ptr = '\0';
 	}
 
-	/*
-	 * Add support for ssh port: ssh://host.xy:<port>/...
-	 */
-	if (protocol == PROTO_SSH && separator == '/')
-		port = get_port(end);
-
 	*ret_host = xstrdup(host);
-	if (port)
-		*ret_port = xstrdup(port);
-	else
-		*ret_port = NULL;
 	if (free_path)
 		*ret_path = path;
 	else
@@ -673,7 +655,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 	char *host, *path;
 	struct child_process *conn = &no_fork;
 	enum protocol protocol;
-	char *port;
 	const char **arg;
 	struct strbuf cmd = STRBUF_INIT;
 
@@ -682,18 +663,13 @@ struct child_process *git_connect(int fd[2], const char *url,
 	 */
 	signal(SIGCHLD, SIG_DFL);
 
-	protocol = parse_connect_url(url, &host, &port, &path);
+	protocol = parse_connect_url(url, &host, &path);
 	if (flags & CONNECT_DIAG_URL) {
 		fprintf(stderr, "Diag: url=%s\n", url ? url : "NULL");
 		fprintf(stderr, "Diag: protocol=%s\n", prot_name(protocol));
-		fprintf(stderr, "Diag: host=%s", host ? host : "NULL");
-		if (port)
-			fprintf(stderr, ":%s\n", port);
-		else
-			fprintf(stderr, "\n");
+		fprintf(stderr, "Diag: host=%s\n", host ? host : "NULL");
 		fprintf(stderr, "Diag: path=%s\n", path ? path : "NULL");
 		free(host);
-		free(port);
 		free(path);
 		return NULL;
 	}
@@ -720,7 +696,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 			     target_host, 0);
 		free(target_host);
 		free(host);
-		free(port);
 		free(path);
 		return conn;
 	}
@@ -736,6 +711,11 @@ struct child_process *git_connect(int fd[2], const char *url,
 	if (protocol == PROTO_SSH) {
 		const char *ssh = getenv("GIT_SSH");
 		int putty = ssh && strcasestr(ssh, "plink");
+		char *ssh_host = host; /* keep host for the free() below */
+		const char *port = NULL;
+		get_host_and_port(&ssh_host, &port);
+		port = get_port_numeric(port);
+
 		if (!ssh) ssh = "ssh";
 
 		*arg++ = ssh;
@@ -746,7 +726,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 			*arg++ = putty ? "-P" : "-p";
 			*arg++ = port;
 		}
-		*arg++ = host;
+		*arg++ = ssh_host;
 	}
 	else {
 		/* remove repo-local variables from the environment */
@@ -763,7 +743,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 	fd[1] = conn->in;  /* write to child's stdin */
 	strbuf_release(&cmd);
 	free(host);
-	free(port);
 	free(path);
 	return conn;
 }
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index ac5b08b..69a2110 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -558,18 +558,16 @@ do
 		for h in host host:12 [::1] [::1]:23
 		do
 			if $(echo $p | grep ssh >/dev/null 2>/dev/null); then
-				hh=$(echo $h | tr -d "[]")
 				pp=ssh
 			else
-				hh=$h
 				pp=$p
 			fi
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
@@ -600,13 +598,12 @@ do
 	p=ssh
 	for h in host [::1]
 	do
-		hh=$(echo $h | tr -d "[]")
 		test_expect_success "fetch-pack --diag-url $h:$r" '
 			check_prot_path $h:$r $p "$r"
 		'
 		# No "/~" -> "~" conversion
 		test_expect_success "fetch-pack --diag-url $h:/~$r" '
-			check_prot_host_path $h:/~$r $p "$hh" "/~$r"
+			check_prot_host_path $h:/~$r $p "$h" "/~$r"
 		'
 	done
 done
-- 
1.8.4.457.g424cb08
