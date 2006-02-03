From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 3/3] daemon: Support a --user-path option.
Date: Fri, 03 Feb 2006 20:27:06 +0000
Message-ID: <20060203202706.1895.70864.stgit@metalzone.distorted.org.uk>
References: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Fri Feb 03 21:27:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F57WT-0005RV-Ng
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 21:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWBCU1K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 15:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWBCU1J
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 15:27:09 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:9012 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751461AbWBCU1I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 15:27:08 -0500
Received: (qmail 2134 invoked from network); 3 Feb 2006 20:27:06 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?C4lJU2oZ89Kbh/DtknUYy6PP+8cYlKTU?@127.0.0.1)
  by localhost with SMTP; 3 Feb 2006 20:27:06 -0000
To: git@vger.kernel.org
In-Reply-To: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15547>

From: Mark Wooding <mwooding@ponder.ncipher.com>

If we're invoked with --user-path=FOO option, then a URL of the form
git://~USER/PATH/... resolves to the path HOME/FOO/PATH/..., where HOME
is USER's home directory.  This is done instead of any transformation
due to --base-path, so you can use both at the same time.  This lets
users set up their own git repositories to be served by a central
daemon, without them all having to be in the same place, and without the
git-daemon being allowed to roam the entire filesystem freely, or
exposing details of filesystem layout on URLs.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 Documentation/git-daemon.txt |   11 +++++++++--
 daemon.c                     |   36 +++++++++++++++++++++++++++++++++---
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index a20e053..2e48a10 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git-daemon' [--verbose] [--syslog] [--inetd | --port=n] [--export-all]
              [--timeout=n] [--init-timeout=n] [--strict-paths]
-             [--base-path=path] [directory...]
+             [--base-path=path] [--user-path=path] [directory...]
 
 DESCRIPTION
 -----------
@@ -43,7 +43,7 @@ OPTIONS
 	'--base-path=/srv/git' on example.com, then if you later try to pull
 	'git://example.com/hello.git', `git-daemon` will interpret the path
 	as '/srv/git/hello.git'. Home directories (the '~login' notation)
-	access is disabled.
+	access is disabled unless '--user-path' is also given.
 
 --export-all::
 	Allow pulling from all directories that look like GIT repositories
@@ -70,6 +70,13 @@ OPTIONS
 	Log to syslog instead of stderr. Note that this option does not imply
 	--verbose, thus by default only error conditions will be logged.
 
+--user-path::
+	Rewrite a request for "~user/something" to
+	"home/user-path/something".  Useful in conjunction with
+	'--base-path', if you want to restrict the daemon from roaming
+	the entire filesystem without preventing users from publishing
+	their own repositories.
+
 --verbose::
 	Log details about the incoming connections and requested files.
 
diff --git a/daemon.c b/daemon.c
index 6b88c0c..95b9c7e 100644
--- a/daemon.c
+++ b/daemon.c
@@ -6,6 +6,7 @@
 #include <netdb.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <pwd.h>
 #include <syslog.h>
 #include "pkt-line.h"
 #include "cache.h"
@@ -17,7 +18,7 @@ static int verbose;
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
-"           [--base-path=path] [directory...]";
+"           [--base-path=path] [--user-path=path] [directory...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths = NULL;
@@ -28,6 +29,7 @@ static int export_all_trees = 0;
 
 /* Take all paths relative to this one if non-NULL */
 static char *base_path = NULL;
+static char *user_path = NULL;
 
 /* Timeout, and initial timeout */
 static unsigned int timeout = 0;
@@ -137,14 +139,34 @@ static int avoid_alias(char *p)
 static char *path_ok(char *dir)
 {
 	char *path;
+	static char rpath[PATH_MAX];
 
 	if (avoid_alias(dir)) {
 		logerror("'%s': aliased", dir);
 		return NULL;
 	}
 
-	if (base_path) {
-		static char rpath[PATH_MAX];
+	if (user_path && *dir == '~') {
+		struct passwd *pw;
+		char *u, *p;
+
+		u = dir + 1;
+		p = strchr(u, '/');
+		if (!p) {
+			logerror("'%s': Missing / after user name", dir);
+			return NULL;
+		}
+		*p = 0;
+		pw = getpwnam(u);
+		*p++ = '/';
+		if (!pw) {
+			logerror("'%s': User not found", u);
+			return NULL;
+		}
+		snprintf(rpath, PATH_MAX, "%s/%s/%s",
+			 pw->pw_dir, user_path, p);
+		dir = rpath;
+	} else if (base_path) {
 		if (*dir != '/') {
 			/* Forbid possible base-path evasion using ~paths. */
 			logerror("'%s': Non-absolute path denied (base-path active)", dir);
@@ -491,6 +513,10 @@ static int socksetup(int port, int **soc
 			/* Note: error is not fatal */
 		}
 #endif
+		if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes))) {
+			close(sockfd);
+			continue;	/* not fatal */
+		}
 
 		if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR,
 			       &yes, sizeof(yes))) {
@@ -673,6 +699,10 @@ int main(int argc, char **argv)
 			base_path = arg+12;
 			continue;
 		}
+		if (!strncmp(arg, "--user-path=", 12)) {
+			user_path = arg+12;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
