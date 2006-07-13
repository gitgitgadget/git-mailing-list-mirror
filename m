From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 5/5] daemon: new option --detach to run git-daemon in background
Date: Thu, 13 Jul 2006 12:32:31 +0200
Message-ID: <E1G0znB-0002If-8A@moooo.ath.cx>
References: <E1G0zj7-0001c1-8q@moooo.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jul 13 13:55:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0znI-0007Iu-Ha
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 13:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWGMLzp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 07:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWGMLzo
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 07:55:44 -0400
Received: from moooo.ath.cx ([85.116.203.178]:15321 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932507AbWGMLzm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 07:55:42 -0400
To: git@vger.kernel.org
In-Reply-To: <E1G0zj7-0001c1-8q@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23829>

Signed-off-by: Matthias Lederhofer <matled@gmx.net>
---
 daemon.c |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4b85930..9f4bc20 100644
--- a/daemon.c
+++ b/daemon.c
@@ -662,6 +662,27 @@ static int service_loop(int socknum, int
 	}
 }
 
+static void daemonize(void)
+{
+	int devnull = -1;
+	switch (fork()) {
+		case 0:
+			break;
+		case -1:
+			die("fork failed: %s", strerror(errno));
+		default:
+			exit(0);
+	}
+	if (setsid() == -1)
+		die("setsid failed: %s", strerror(errno));
+	if ((devnull = open("/dev/null", O_RDWR, 0)) == -1)
+		die("open /dev/null failed: %s", strerror(errno));
+	if (dup2(devnull, 0) != 0 ||
+		dup2(devnull, 1) != 1 ||
+		dup2(devnull, 2) != 2)
+		die("dup2 failed: %s", strerror(errno));
+}
+
 /* if any standard file descriptor is missing open it to /dev/null */
 static void sanitize_stdfds(void)
 {
@@ -705,6 +726,7 @@ int main(int argc, char **argv)
 	int port = DEFAULT_GIT_PORT;
 	int inetd_mode = 0;
 	const char *pid_file = NULL;
+	int detach = 0;
 	int i;
 
 	/* Without this we cannot rely on waitpid() to tell
@@ -773,6 +795,11 @@ int main(int argc, char **argv)
 			pid_file = arg + 11;
 			continue;
 		}
+		if (!strcmp(arg, "--detach")) {
+			detach = 1;
+			log_syslog = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--")) {
 			ok_paths = &argv[i+1];
 			break;
@@ -805,7 +832,10 @@ int main(int argc, char **argv)
 		return execute(peer);
 	}
 
-	sanitize_stdfds();
+	if (detach)
+		daemonize();
+	else
+		sanitize_stdfds();
 
 	if (pid_file)
 		store_pid(pid_file);
-- 
1.4.1.gb16f
