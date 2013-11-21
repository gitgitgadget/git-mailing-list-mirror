From: Torsten =?iso-8859-1?q?B=F6gershausen?= <tboegi@web.de>
Subject: [PATCH v6 09/10] connect.c: Refactor url parsing
Date: Thu, 21 Nov 2013 21:41:56 +0100
Message-ID: <201311212141.57411.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 21:42:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjb4j-0001Cb-Fu
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 21:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277Ab3KUUmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 15:42:06 -0500
Received: from mout.web.de ([212.227.15.3]:64849 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020Ab3KUUmE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 15:42:04 -0500
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MHp8z-1VgaOq1ZMr-003gag for <git@vger.kernel.org>; Thu,
 21 Nov 2013 21:42:02 +0100
X-Provags-ID: V03:K0:qCF1qRTO/lyHPPZWbVXaSL03FtYAapiP7WgRVjH5klYI1RCjTu5
 Lhp4Y+upM3Em9Fvr1LOoQeWwB6z4IE0YqS4ONengYXY5k8hjl8scXBMZAMi9WPXNWK/F0Eo
 NNb9IUpszFFZZa+tnH9330pZx0huLT8IFYoi1KaaYomv0oTcUqvNVM9xjDgAol3SArWbj9l
 mS60rx6RCyNwxrkKSaXrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238151>

Make the function is_local() from tramsport.c public and use it
in both transport.c and connect.c
Use a protocol "local" for URLs for the local file system.
---
 connect.c        | 58 ++++++++++++++++++++++++++++++--------------------------
 connect.h        |  1 +
 t/t5601-clone.sh | 10 +---------
 transport.c      |  8 --------
 4 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/connect.c b/connect.c
index 3d174c8..95568ac 100644
--- a/connect.c
+++ b/connect.c
@@ -232,13 +232,23 @@ int server_supports(const char *feature)
 
 enum protocol {
 	PROTO_LOCAL = 1,
+	PROTO_FILE,
 	PROTO_SSH,
 	PROTO_GIT
 };
 
+int is_local(const char *url)
+{
+	const char *colon = strchr(url, ':');
+	const char *slash = strchr(url, '/');
+	return !colon || (slash && slash < colon) ||
+		has_dos_drive_prefix(url);
+}
+
 static const char *prot_name(enum protocol protocol) {
 	switch (protocol) {
 		case PROTO_LOCAL:
+		case PROTO_FILE:
 			return "file";
 		case PROTO_SSH:
 			return "ssh";
@@ -260,7 +270,7 @@ static enum protocol get_protocol(const char *name)
 	if (!strcmp(name, "ssh+git"))
 		return PROTO_SSH;
 	if (!strcmp(name, "file"))
-		return PROTO_LOCAL;
+		return PROTO_FILE;
 	die("I don't handle protocol '%s'", name);
 }
 
@@ -563,9 +573,8 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	char *url;
 	char *host, *path;
 	char *end;
-	int separator;
+	int separator = '/';
 	enum protocol protocol = PROTO_LOCAL;
-	int free_path = 0;
 
 	if (is_url(url_orig))
 		url = url_decode(url_orig);
@@ -577,10 +586,12 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 		*host = '\0';
 		protocol = get_protocol(url);
 		host += 3;
-		separator = '/';
 	} else {
 		host = url;
-		separator = ':';
+		if (!is_local(url)) {
+			protocol = PROTO_SSH;
+			separator = ':';
+		}
 	}
 
 	/*
@@ -596,17 +607,12 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	} else
 		end = host;
 
-	path = strchr(end, separator);
-	if (path && !has_dos_drive_prefix(end)) {
-		if (separator == ':') {
-			if (host != url || path < strchrnul(host, '/')) {
-				protocol = PROTO_SSH;
-				*path++ = '\0';
-			} else /* '/' in the host part, assume local path */
-				path = end;
-		}
-	} else
+	if (protocol == PROTO_LOCAL)
+		path = end;
+	else if (protocol == PROTO_FILE && has_dos_drive_prefix(end))
 		path = end;
+	else
+		path = strchr(end, separator);
 
 	if (!path || !*path)
 		die("No path specified. See 'man git-pull' for valid url syntax");
@@ -615,23 +621,21 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	 * null-terminate hostname and point path to ~ for URL's like this:
 	 *    ssh://host.xz/~user/repo
 	 */
-	if (protocol != PROTO_LOCAL && separator == '/') {
-		char *ptr = path;
+
+	end = path; /* Need to \0 terminate host here */
+	if (separator == ':')
+		path++; /* path starts after ':' */
+	if ((protocol == PROTO_GIT) ||
+			(protocol == PROTO_SSH && separator == '/')) {
 		if (path[1] == '~')
 			path++;
-		else {
-			path = xstrdup(ptr);
-			free_path = 1;
-		}
-
-		*ptr = '\0';
 	}
 
+	path = xstrdup(path);
+	*end = '\0';
+
 	*ret_host = xstrdup(host);
-	if (free_path)
-		*ret_path = path;
-	else
-		*ret_path = xstrdup(path);
+	*ret_path = path;
 	free(url);
 	return protocol;
 }
diff --git a/connect.h b/connect.h
index 527d58a..ce657b3 100644
--- a/connect.h
+++ b/connect.h
@@ -9,5 +9,6 @@ extern int git_connection_is_socket(struct child_process *conn);
 extern int server_supports(const char *feature);
 extern int parse_feature_request(const char *features, const char *feature);
 extern const char *server_feature_value(const char *feature, int *len_ret);
+int is_local(const char *url);
 
 #endif
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 57234c0..bd1bfd3 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -364,15 +364,7 @@ do
 done
 
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
diff --git a/transport.c b/transport.c
index 7202b77..a09ba95 100644
--- a/transport.c
+++ b/transport.c
@@ -885,14 +885,6 @@ void transport_take_over(struct transport *transport,
 	transport->cannot_reuse = 1;
 }
 
-static int is_local(const char *url)
-{
-	const char *colon = strchr(url, ':');
-	const char *slash = strchr(url, '/');
-	return !colon || (slash && slash < colon) ||
-		has_dos_drive_prefix(url);
-}
-
 static int is_file(const char *url)
 {
 	struct stat buf;
-- 
1.8.4.457.g424cb08
