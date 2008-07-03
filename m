From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git daemon: avoid calling syslog() from a signal handler
Date: Thu, 3 Jul 2008 16:27:24 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807031624020.9925@racer>
References: <200807031400.36315.brian.foster@innova-card.com> <alpine.DEB.1.00.0807031343440.9925@racer> <200807031552.26615.brian.foster@innova-card.com> <alpine.DEB.1.00.0807031531320.9925@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 17:30:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEQlF-0003Qm-3O
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 17:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbYGCP3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 11:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbYGCP3T
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 11:29:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:34438 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751926AbYGCP3S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 11:29:18 -0400
Received: (qmail invoked by alias); 03 Jul 2008 15:29:16 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp066) with SMTP; 03 Jul 2008 17:29:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dwRRmm92dMWM7g4as0ahXKYbVWbMTiFuUcaWu3h
	luC911Rs446oHw
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0807031531320.9925@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87293>


Signal handlers should never call syslog(), as that can raise signals
of its own.

Instead, call the syslog() from the master process.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 3 Jul 2008, Johannes Schindelin wrote:

	> It may raise awareness so much that somebody gets a clever idea 
	> how to cope with it.

	Okay, it might not be clever, but I think this is pretty 
	straight-forward.

	However, this part of the code is tricky, as it can (and will) be 
	interrupted by signal handlers, so I would appreciate several 
	careful reviews (but maybe it is not necessary to ask for it, 
	since I am no longer trusted).

 daemon.c |   61 +++++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/daemon.c b/daemon.c
index 63cd12c..35fd439 100644
--- a/daemon.c
+++ b/daemon.c
@@ -694,23 +694,47 @@ static void kill_some_children(int signo, unsigned start, unsigned stop)
 	}
 }
 
+static void check_dead_children(void)
+{
+	unsigned spawned, reaped, deleted;
+
+	spawned = children_spawned;
+	reaped = children_reaped;
+	deleted = children_deleted;
+
+	while (deleted < reaped) {
+		pid_t pid = dead_child[deleted % MAX_CHILDREN];
+		const char *dead = pid < 0 ? " (with error)" : "";
+
+		if (pid < 0)
+			pid = -pid;
+
+		/* XXX: Custom logging, since we don't wanna getpid() */
+		if (verbose) {
+			if (log_syslog)
+				syslog(LOG_INFO, "[%d] Disconnected%s",
+						pid, dead);
+			else
+				fprintf(stderr, "[%d] Disconnected%s\n",
+						pid, dead);
+		}
+		remove_child(pid, deleted, spawned);
+		deleted++;
+	}
+	children_deleted = deleted;
+}
+
 static void check_max_connections(void)
 {
 	for (;;) {
 		int active;
-		unsigned spawned, reaped, deleted;
+		unsigned spawned, deleted;
+
+		check_dead_children();
 
 		spawned = children_spawned;
-		reaped = children_reaped;
 		deleted = children_deleted;
 
-		while (deleted < reaped) {
-			pid_t pid = dead_child[deleted % MAX_CHILDREN];
-			remove_child(pid, deleted, spawned);
-			deleted++;
-		}
-		children_deleted = deleted;
-
 		active = spawned - deleted;
 		if (active <= max_connections)
 			break;
@@ -760,18 +784,10 @@ static void child_handler(int signo)
 
 		if (pid > 0) {
 			unsigned reaped = children_reaped;
+			if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
+				pid = -pid;
 			dead_child[reaped % MAX_CHILDREN] = pid;
 			children_reaped = reaped + 1;
-			/* XXX: Custom logging, since we don't wanna getpid() */
-			if (verbose) {
-				const char *dead = "";
-				if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
-					dead = " (with error)";
-				if (log_syslog)
-					syslog(LOG_INFO, "[%d] Disconnected%s", pid, dead);
-				else
-					fprintf(stderr, "[%d] Disconnected%s\n", pid, dead);
-			}
 			continue;
 		}
 		break;
@@ -929,7 +945,8 @@ static int service_loop(int socknum, int *socklist)
 	for (;;) {
 		int i;
 
-		if (poll(pfd, socknum, -1) < 0) {
+		i = poll(pfd, socknum, 1);
+		if (i < 0) {
 			if (errno != EINTR) {
 				error("poll failed, resuming: %s",
 				      strerror(errno));
@@ -937,6 +954,10 @@ static int service_loop(int socknum, int *socklist)
 			}
 			continue;
 		}
+		if (i == 0) {
+			check_dead_children();
+			continue;
+		}
 
 		for (i = 0; i < socknum; i++) {
 			if (pfd[i].revents & POLLIN) {
-- 
1.5.6.1.376.g6b0fd
