From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] git-daemon --base-path
Date: Fri, 23 Dec 2005 02:27:40 +0100
Message-ID: <20051223012739.29168.55858.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 23 02:27:21 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpbiF-0002RT-R5
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 02:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVLWB1I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 20:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVLWB1I
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 20:27:08 -0500
Received: from w241.dkm.cz ([62.24.88.241]:17379 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751234AbVLWB1H (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Dec 2005 20:27:07 -0500
Received: (qmail 29190 invoked from network); 23 Dec 2005 02:27:41 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 23 Dec 2005 02:27:41 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13981>

Tommi Virtanen expressed a wish on #git to be able to use short and elegant
git URLs by making git-daemon 'root' in a given directory. This patch
implements this, causing git-daemon to interpret all paths relative to
the given base path if any is given.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-daemon.txt |   11 ++++++++++-
 daemon.c                     |   21 ++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 2a8f371..ac67ac2 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -8,7 +8,8 @@ git-daemon - A really simple server for 
 SYNOPSIS
 --------
 'git-daemon' [--verbose] [--syslog] [--inetd | --port=n] [--export-all]
-             [--timeout=n] [--init-timeout=n] [--strict-paths] [directory...]
+             [--timeout=n] [--init-timeout=n] [--strict-paths]
+             [--base-path=path] [directory...]
 
 DESCRIPTION
 -----------
@@ -35,6 +36,14 @@ OPTIONS
 	git-daemon will refuse to start when this option is enabled and no
 	whitelist is specified.
 
+--base-path::
+	Remap all the path requests as relative to the given path.
+	This is sort of "GIT root" - if you run git-daemon with
+	'--base-path=/srv/git' on example.com, then if you later try to pull
+	'git://example.com/hello.git', `git-daemon` will interpret the path
+	as '/srv/git/hello.git'. Home directories (the '~login' notation)
+	access is disabled.
+
 --export-all::
 	Allow pulling from all directories that look like GIT repositories
 	(have the 'objects' and 'refs' subdirectories), even if they
diff --git a/daemon.c b/daemon.c
index 539f6e8..3bd1426 100644
--- a/daemon.c
+++ b/daemon.c
@@ -15,7 +15,8 @@ static int verbose;
 
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
-"           [--timeout=n] [--init-timeout=n] [--strict-paths] [directory...]";
+"           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
+"           [--base-path=path] [directory...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths = NULL;
@@ -24,6 +25,9 @@ static int strict_paths = 0;
 /* If this is set, git-daemon-export-ok is not required */
 static int export_all_trees = 0;
 
+/* Take all paths relative to this one if non-NULL */
+static char *base_path = NULL;
+
 /* Timeout, and initial timeout */
 static unsigned int timeout = 0;
 static unsigned int init_timeout = 0;
@@ -138,6 +142,17 @@ static char *path_ok(char *dir)
 		return NULL;
 	}
 
+	if (base_path) {
+		static char rpath[PATH_MAX];
+		if (*dir != '/') {
+			/* Forbid possible base-path evasion using ~paths. */
+			logerror("'%s': Non-absolute path denied (base-path active)");
+			return NULL;
+		}
+		snprintf(rpath, PATH_MAX, "%s%s", base_path, dir);
+		dir = rpath;
+	}
+
 	path = enter_repo(dir, strict_paths);
 
 	if (!path) {
@@ -639,6 +654,10 @@ int main(int argc, char **argv)
 			strict_paths = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--base-path=", 12)) {
+			base_path = arg+12;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
