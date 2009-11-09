From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] http-backend: Protect GIT_PROJECT_ROOT from /../ requests
Date: Mon, 9 Nov 2009 11:26:43 -0800
Message-ID: <20091109192643.GA29299@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 20:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Zt5-0004Cs-6U
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 20:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbZKIT0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 14:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbZKIT0i
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 14:26:38 -0500
Received: from george.spearce.org ([209.20.77.23]:45524 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbZKIT0h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 14:26:37 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 56482381FC; Mon,  9 Nov 2009 19:26:43 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132509>

Eons ago HPA taught git-daemon how to protect itself from /../
attacks, which Junio brought back into service in d79374c7b58d
("daemon.c and path.enter_repo(): revamp path validation").

I did not carry this into git-http-backend as originally we relied
only upon PATH_TRANSLATED, and assumed the HTTP server had done
its access control checks to validate the resolved path was within
a directory permitting access from the remote client.  This would
usually be sufficient to protect a server from requests for its
/etc/passwd file by http://host/smart/../etc/passwd sorts of URLs.

However in 917adc036086 Mark Lodato added GIT_PROJECT_ROOT as an
additional method of configuring the CGI.  When this environment
variable is used the web server does not generate the final access
path and therefore may blindly pass through "/../etc/passwd"
in PATH_INFO under the assumption that "/../" might have special
meaning to the invoked CGI.

Instead of permitting these sorts of malformed path requests, we
now reject them back at the client, with an error message for the
server log.  This matches git-daemon behavior.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h                 |    1 +
 daemon.c                |   49 +----------------------------------------------
 http-backend.c          |    6 +++++
 path.c                  |   47 +++++++++++++++++++++++++++++++++++++++++++++
 t/t5560-http-backend.sh |   31 +++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 48 deletions(-)

diff --git a/cache.h b/cache.h
index 4e283be..ecbd88a 100644
--- a/cache.h
+++ b/cache.h
@@ -656,6 +656,7 @@ const char *make_relative_path(const char *abs, const char *base);
 int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, const char *prefix_list);
 char *strip_path_suffix(const char *path, const char *suffix);
+int daemon_avoid_alias(const char *path);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/daemon.c b/daemon.c
index 1b5ada6..ce48006 100644
--- a/daemon.c
+++ b/daemon.c
@@ -101,53 +101,6 @@ static void NORETURN daemon_die(const char *err, va_list params)
 	exit(1);
 }
 
-static int avoid_alias(char *p)
-{
-	int sl, ndot;
-
-	/*
-	 * This resurrects the belts and suspenders paranoia check by HPA
-	 * done in <435560F7.4080006@zytor.com> thread, now enter_repo()
-	 * does not do getcwd() based path canonicalizations.
-	 *
-	 * sl becomes true immediately after seeing '/' and continues to
-	 * be true as long as dots continue after that without intervening
-	 * non-dot character.
-	 */
-	if (!p || (*p != '/' && *p != '~'))
-		return -1;
-	sl = 1; ndot = 0;
-	p++;
-
-	while (1) {
-		char ch = *p++;
-		if (sl) {
-			if (ch == '.')
-				ndot++;
-			else if (ch == '/') {
-				if (ndot < 3)
-					/* reject //, /./ and /../ */
-					return -1;
-				ndot = 0;
-			}
-			else if (ch == 0) {
-				if (0 < ndot && ndot < 3)
-					/* reject /.$ and /..$ */
-					return -1;
-				return 0;
-			}
-			else
-				sl = ndot = 0;
-		}
-		else if (ch == 0)
-			return 0;
-		else if (ch == '/') {
-			sl = 1;
-			ndot = 0;
-		}
-	}
-}
-
 static char *path_ok(char *directory)
 {
 	static char rpath[PATH_MAX];
@@ -157,7 +110,7 @@ static char *path_ok(char *directory)
 
 	dir = directory;
 
-	if (avoid_alias(dir)) {
+	if (daemon_avoid_alias(dir)) {
 		logerror("'%s': aliased", dir);
 		return NULL;
 	}
diff --git a/http-backend.c b/http-backend.c
index 646e910..f8ea9d7 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -559,7 +559,13 @@ static char* getdir(void)
 	if (root && *root) {
 		if (!pathinfo || !*pathinfo)
 			die("GIT_PROJECT_ROOT is set but PATH_INFO is not");
+		if (daemon_avoid_alias(pathinfo))
+			die("'%s': aliased", pathinfo);
 		strbuf_addstr(&buf, root);
+		if (buf.buf[buf.len - 1] != '/')
+			strbuf_addch(&buf, '/');
+		if (pathinfo[0] == '/')
+			pathinfo++;
 		strbuf_addstr(&buf, pathinfo);
 		return strbuf_detach(&buf, NULL);
 	} else if (path && *path) {
diff --git a/path.c b/path.c
index 047fdb0..c7679be 100644
--- a/path.c
+++ b/path.c
@@ -564,3 +564,50 @@ char *strip_path_suffix(const char *path, const char *suffix)
 		return NULL;
 	return xstrndup(path, chomp_trailing_dir_sep(path, path_len));
 }
+
+int daemon_avoid_alias(const char *p)
+{
+	int sl, ndot;
+
+	/*
+	 * This resurrects the belts and suspenders paranoia check by HPA
+	 * done in <435560F7.4080006@zytor.com> thread, now enter_repo()
+	 * does not do getcwd() based path canonicalizations.
+	 *
+	 * sl becomes true immediately after seeing '/' and continues to
+	 * be true as long as dots continue after that without intervening
+	 * non-dot character.
+	 */
+	if (!p || (*p != '/' && *p != '~'))
+		return -1;
+	sl = 1; ndot = 0;
+	p++;
+
+	while (1) {
+		char ch = *p++;
+		if (sl) {
+			if (ch == '.')
+				ndot++;
+			else if (ch == '/') {
+				if (ndot < 3)
+					/* reject //, /./ and /../ */
+					return -1;
+				ndot = 0;
+			}
+			else if (ch == 0) {
+				if (0 < ndot && ndot < 3)
+					/* reject /.$ and /..$ */
+					return -1;
+				return 0;
+			}
+			else
+				sl = ndot = 0;
+		}
+		else if (ch == 0)
+			return 0;
+		else if (ch == '/') {
+			sl = 1;
+			ndot = 0;
+		}
+	}
+}
diff --git a/t/t5560-http-backend.sh b/t/t5560-http-backend.sh
index 908ba07..ed034bc 100755
--- a/t/t5560-http-backend.sh
+++ b/t/t5560-http-backend.sh
@@ -146,6 +146,37 @@ test_expect_success 'http.receivepack false' '
 	POST git-receive-pack 0000 "403 Forbidden"
 '
 
+run_backend() {
+	REQUEST_METHOD=GET \
+	GIT_PROJECT_ROOT="$HTTPD_DOCUMENT_ROOT_PATH" \
+	PATH_INFO="$2" \
+	git http-backend >act.out 2>act.err
+}
+
+path_info() {
+	if test $1 = 0; then
+		run_backend "$2"
+	else
+		test_must_fail run_backend "$2" &&
+		echo "fatal: '$2': aliased" >exp.err &&
+		test_cmp exp.err act.err
+	fi
+}
+
+test_expect_success 'http-backend blocks bad PATH_INFO' '
+	config http.getanyfile true &&
+
+	run_backend 0 /repo.git/HEAD &&
+
+	run_backend 1 /repo.git/../HEAD &&
+	run_backend 1 /../etc/passwd &&
+	run_backend 1 ../etc/passwd &&
+	run_backend 1 /etc//passwd &&
+	run_backend 1 /etc/./passwd &&
+	run_backend 1 /etc/.../passwd &&
+	run_backend 1 //domain/data.txt
+'
+
 cat >exp <<EOF
 
 ###  refs/heads/master
-- 
1.6.5.2.351.g09432
