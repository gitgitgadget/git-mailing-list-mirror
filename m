From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 16/28] http-backend: add GIT_PROJECT_ROOT environment var
Date: Fri, 30 Oct 2009 17:47:35 -0700
Message-ID: <1256950067-27938-18-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:49:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N429o-0001yQ-O4
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933154AbZJaAsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933148AbZJaAsW
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:48:22 -0400
Received: from george.spearce.org ([209.20.77.23]:36941 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757591AbZJaArz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:47:55 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id A5BCB38222; Sat, 31 Oct 2009 00:48:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E816038239;
	Sat, 31 Oct 2009 00:47:53 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131798>

From: Mark Lodato <lodatom@gmail.com>

Add a new environment variable, GIT_PROJECT_ROOT, to override the
method of using PATH_TRANSLATED to find the git repository on disk.
This makes it much easier to configure the web server, especially when
the web server's DocumentRoot does not contain the git repositories,
which is the usual case.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-http-backend.txt |   39 +++++++++++++++--------------------
 http-backend.c                     |   25 ++++++++++++++++++++--
 2 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 022a243..99dbbfb 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -41,29 +41,24 @@ http.receivepack::
 
 URL TRANSLATION
 ---------------
-'git-http-backend' relies on the invoking web server to perform
-URL to path translation, and store the repository path into the
-PATH_TRANSLATED environment variable.  Most web servers will do
-this translation automatically, resolving the suffix after the
-CGI name relative to the server's document root.
+To determine the location of the repository on disk, 'git-http-backend'
+concatenates the environment variables PATH_INFO, which is set
+automatically by the web server, and GIT_PROJECT_ROOT, which must be set
+manually in the web server configuration.  If GIT_PROJECT_ROOT is not
+set, 'git-http-backend' reads PATH_TRANSLATED, which is also set
+automatically by the web server.
 
 EXAMPLES
 --------
 
 Apache 2.x::
-	To serve all Git repositories contained within the '/git/'
-	subdirectory of the DocumentRoot, ensure mod_cgi and
-	mod_alias are enabled, and create a ScriptAlias to the CGI:
+	Ensure mod_cgi, mod_alias, and mod_env are enabled, set
+	GIT_PROJECT_ROOT (or DocumentRoot) appropriately, and
+	create a ScriptAlias to the CGI:
 +
 ----------------------------------------------------------------
-ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/git/
-
-<Directory /usr/libexec/git-core>
-	Options None
-</Directory>
-<Files /usr/libexec/git-core/git-http-backend>
-	Options ExecCGI
-</Files>
+SetEnv GIT_PROJECT_ROOT /var/www/git
+ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
 ----------------------------------------------------------------
 +
 To enable anonymous read access but authenticated write access,
@@ -78,16 +73,16 @@ require authorization with a LocationMatch directive:
 </LocationMatch>
 ----------------------------------------------------------------
 +
-To require authentication for both reads and writes, use a Directory
+To require authentication for both reads and writes, use a Location
 directive around the repository, or one of its parent directories:
 +
 ----------------------------------------------------------------
-<Directory /var/www/git/private>
+<Location /git/private>
 	AuthType Basic
 	AuthName "Private Git Access"
 	Require group committers
 	...
-</Directory>
+</Location>
 ----------------------------------------------------------------
 
 Accelerated static Apache 2.x::
@@ -97,9 +92,9 @@ Accelerated static Apache 2.x::
 	file contents from the file system directly to the network:
 +
 ----------------------------------------------------------------
-DocumentRoot /var/www
+SetEnv GIT_PROJECT_ROOT /var/www/git
 
-ScriptAlias /git/        /usr/libexec/git-core/git-http-backend/git/
+ScriptAlias /git/        /usr/libexec/git-core/git-http-backend/
 Alias       /git_static/ /var/www/git/
 
 RewriteEngine on
@@ -114,7 +109,7 @@ ENVIRONMENT
 'git-http-backend' relies upon the CGI environment variables set
 by the invoking web server, including:
 
-* PATH_TRANSLATED
+* PATH_INFO (if GIT_PROJECT_ROOT is set, otherwise PATH_TRANSLATED)
 * REMOTE_USER
 * REMOTE_ADDR
 * CONTENT_TYPE
diff --git a/http-backend.c b/http-backend.c
index 67030b5..8e5c0a2 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -528,6 +528,26 @@ static NORETURN void die_webcgi(const char *err, va_list params)
 	exit(0);
 }
 
+static char* getdir(void)
+{
+	struct strbuf buf = STRBUF_INIT;
+	char *pathinfo = getenv("PATH_INFO");
+	char *root = getenv("GIT_PROJECT_ROOT");
+	char *path = getenv("PATH_TRANSLATED");
+
+	if (root && *root) {
+		if (!pathinfo || !*pathinfo)
+			die("GIT_PROJECT_ROOT is set but PATH_INFO is not");
+		strbuf_addstr(&buf, root);
+		strbuf_addstr(&buf, pathinfo);
+		return strbuf_detach(&buf, NULL);
+	} else if (path && *path) {
+		return xstrdup(path);
+	} else
+		die("No GIT_PROJECT_ROOT or PATH_TRANSLATED from server");
+	return NULL;
+}
+
 static struct service_cmd {
 	const char *method;
 	const char *pattern;
@@ -550,7 +570,7 @@ static struct service_cmd {
 int main(int argc, char **argv)
 {
 	char *method = getenv("REQUEST_METHOD");
-	char *dir = getenv("PATH_TRANSLATED");
+	char *dir;
 	struct service_cmd *cmd = NULL;
 	char *cmd_arg = NULL;
 	int i;
@@ -562,8 +582,7 @@ int main(int argc, char **argv)
 		die("No REQUEST_METHOD from server");
 	if (!strcmp(method, "HEAD"))
 		method = "GET";
-	if (!dir)
-		die("No PATH_TRANSLATED from server");
+	dir = getdir();
 
 	for (i = 0; i < ARRAY_SIZE(services); i++) {
 		struct service_cmd *c = &services[i];
-- 
1.6.5.2.181.gd6f41
