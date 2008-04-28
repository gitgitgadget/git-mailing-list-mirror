From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 15:24:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 28 16:25:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqUID-0001Wl-Sm
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 16:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934698AbYD1OX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 10:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933677AbYD1OX7
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 10:23:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:47542 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934825AbYD1OX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 10:23:58 -0400
Received: (qmail invoked by alias); 28 Apr 2008 14:23:56 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp044) with SMTP; 28 Apr 2008 16:23:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+LVad9CyuLEXDQHFm6VXL3dC4UDyoWhnWe1pjUif
	V1iP5dlh1Qb3ad
X-X-Sender: user@eeepc-johanness
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80539>


With rotating logs, there is a problem when the syslog is opened only once 
(in the beginning).  So open the log everytime we write something, and 
close it directly after writing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 daemon.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index 2b4a6f1..a887c72 100644
--- a/daemon.c
+++ b/daemon.c
@@ -90,7 +90,9 @@ static void logreport(int priority, const char *err, va_list params)
 	msglen = vsnprintf(buf + buflen, maxlen, err, params);
 
 	if (log_syslog) {
+		openlog("git-daemon", 0, LOG_DAEMON);
 		syslog(priority, "%s", buf);
+		closelog();
 		return;
 	}
 
@@ -767,8 +769,11 @@ static void child_handler(int signo)
 				const char *dead = "";
 				if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
 					dead = " (with error)";
-				if (log_syslog)
+				if (log_syslog) {
+					openlog("git-daemon", 0, LOG_DAEMON);
 					syslog(LOG_INFO, "[%d] Disconnected%s", pid, dead);
+					closelog();
+				}
 				else
 					fprintf(stderr, "[%d] Disconnected%s\n", pid, dead);
 			}
@@ -1149,10 +1154,8 @@ int main(int argc, char **argv)
 		usage(daemon_usage);
 	}
 
-	if (log_syslog) {
-		openlog("git-daemon", 0, LOG_DAEMON);
+	if (log_syslog)
 		set_die_routine(daemon_die);
-	}
 
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
-- 
1.5.4.4.GIT
