From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git daemon: avoid waking up too often
Date: Tue, 22 Jul 2008 22:52:13 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807222251570.8986@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 22 23:53:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPnG-0004on-7L
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbYGVVwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbYGVVwO
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:52:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:49291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753173AbYGVVwN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:52:13 -0400
Received: (qmail invoked by alias); 22 Jul 2008 21:52:12 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp006) with SMTP; 22 Jul 2008 23:52:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/qd5492yjq1xcAIsU5t5FrAlwxFGOCvOe2YguN5f
	jQS/HRTcuJmhSn
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89549>


To avoid waking up unnecessarily, a pipe is set up that is only ever
written to by child_handler(), when a child disconnects, as suggested
per Junio.

This avoids waking up the main process every second to see if a child
was disconnected.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I have this in production ever since I posted it the first time,
	without problems.

	Oh, and it removes more lines than it introduces ;-)

 daemon.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/daemon.c b/daemon.c
index 7df41a6..850f6f9 100644
--- a/daemon.c
+++ b/daemon.c
@@ -16,6 +16,7 @@
 static int log_syslog;
 static int verbose;
 static int reuseaddr;
+static int child_handler_pipe[2];
 
 static const char daemon_usage[] =
 "git daemon [--verbose] [--syslog] [--export-all]\n"
@@ -788,6 +789,7 @@ static void child_handler(int signo)
 				pid = -pid;
 			dead_child[reaped % MAX_CHILDREN] = pid;
 			children_reaped = reaped + 1;
+			write(child_handler_pipe[1], &status, 1);
 			continue;
 		}
 		break;
@@ -933,12 +935,17 @@ static int service_loop(int socknum, int *socklist)
 	struct pollfd *pfd;
 	int i;
 
-	pfd = xcalloc(socknum, sizeof(struct pollfd));
+	if (pipe(child_handler_pipe) < 0)
+		die ("Could not set up pipe for child handler");
+
+	pfd = xcalloc(socknum + 1, sizeof(struct pollfd));
 
 	for (i = 0; i < socknum; i++) {
 		pfd[i].fd = socklist[i];
 		pfd[i].events = POLLIN;
 	}
+	pfd[socknum].fd = child_handler_pipe[0];
+	pfd[socknum].events = POLLIN;
 
 	signal(SIGCHLD, child_handler);
 
@@ -946,16 +953,7 @@ static int service_loop(int socknum, int *socklist)
 		int i;
 		int timeout;
 
-		/*
-		 * This 1-sec timeout could lead to idly looping but it is
-		 * here so that children culled in child_handler() are reported
-		 * without too much delay.  We could probably set up a pipe
-		 * to ourselves that we poll, and write to the fd from child_handler()
-		 * to wake us up (and consume it when the poll() returns...
-		 */
-		timeout = (children_spawned != children_deleted) ? 1000 : -1;
-		i = poll(pfd, socknum, timeout);
-		if (i < 0) {
+		if (poll(pfd, socknum + 1, -1) < 0) {
 			if (errno != EINTR) {
 				error("poll failed, resuming: %s",
 				      strerror(errno));
@@ -963,9 +961,9 @@ static int service_loop(int socknum, int *socklist)
 			}
 			continue;
 		}
-		if (i == 0) {
+		if (pfd[socknum].revents & POLLIN) {
+			read(child_handler_pipe[0], &i, 1);
 			check_dead_children();
-			continue;
 		}
 
 		for (i = 0; i < socknum; i++) {
-- 
1.6.0.rc0.22.gf2096d.dirty
