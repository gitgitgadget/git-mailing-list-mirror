From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 1/5] http-backend: add GIT_PROJECT_ROOT environment var
Date: Sun, 25 Oct 2009 14:05:31 -0400
Message-ID: <1256493935-8680-2-git-send-email-lodatom@gmail.com>
References: <1256493935-8680-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 19:04:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N27SU-0006tm-08
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 19:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbZJYSEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 14:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbZJYSEg
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 14:04:36 -0400
Received: from mail-qy0-f174.google.com ([209.85.221.174]:65052 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbZJYSEf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 14:04:35 -0400
Received: by qyk4 with SMTP id 4so7380254qyk.33
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=G4F/75XzXAVQVOqhdkIsSRcYZyL6rFrctz1F1xWVap8=;
        b=LK9zNReYflUPvWA1AxoE7w+Yfbhc+Kz/m+iA404skfV0zaGAhQk9MtF0al+Y8LiQly
         g4/JdRNUSazmQi6kZV4OTiRtUeKKHXSH7nKo2pPyemw13/m/Au3ByyJ3pjfBsrSJsjoJ
         kHdiqWUZ1QKd8RUXE2vFwL5FSYyIUB3EwZrag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XgAcPABR5Yg1wdxAKBygbp42QC2CgsEi0j8dtrpLOucO0K4wNyUFOju8S+XvLAJOn+
         JRi737U20+u0FArqMxfBQYZ3zwDUhJfn42pKsZPltAMmhhN+PzajWbuVhwoRDQwpOMgo
         BQnB+GvdfZ7Y2bYEH9PpCNkg23yq42Rw/uE40=
Received: by 10.224.90.129 with SMTP id i1mr6758855qam.201.1256493879728;
        Sun, 25 Oct 2009 11:04:39 -0700 (PDT)
Received: from localhost.localdomain (c-68-33-182-150.hsd1.dc.comcast.net [68.33.182.150])
        by mx.google.com with ESMTPS id 7sm13930120qwf.46.2009.10.25.11.04.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 11:04:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1
In-Reply-To: <1256493935-8680-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131229>

Add a new environment variable, GIT_PROJECT_ROOT, to override the
method of using PATH_TRANSLATED to find the git repository on disk.
This makes it much easier to configure the web server, especially when
the web server's DocumentRoot does not contain the git repositories,
which is the usual case.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
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
1.6.5.1
