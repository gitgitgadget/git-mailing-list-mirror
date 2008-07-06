From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] git daemon: avoid calling syslog() from a signal
 handler
Date: Sun, 6 Jul 2008 14:23:20 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807061414320.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <200807031400.36315.brian.foster@innova-card.com> <alpine.DEB.1.00.0807031343440.9925@racer> <200807031552.26615.brian.foster@innova-card.com> <alpine.DEB.1.00.0807031531320.9925@racer> <alpine.DEB.1.00.0807031624020.9925@racer>
 <7vej68u6mr.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807051201320.3334@eeepc-johanness> <7vabgwtf6m.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807060337480.3557@eeepc-johanness> <7vmykvo87w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Foster <brian.foster@innova-card.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 06 14:24:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFTHz-0004KY-BN
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 14:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbYGFMXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 08:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753750AbYGFMXY
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 08:23:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:46158 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753245AbYGFMXX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 08:23:23 -0400
Received: (qmail invoked by alias); 06 Jul 2008 12:23:21 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp043) with SMTP; 06 Jul 2008 14:23:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RW0Y4LPmRl9iuqxziQuMFqcBIFt2htlAeMD16Lb
	mykjzdXLGZTVZX
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmykvo87w.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87521>


Signal handlers should never call syslog(), as that can raise signals
of its own.

Instead, call the syslog() from the master process.

To avoid waking up unnecessarily, a pipe is set up that is only ever
written to by child_handler(), when a child disconnects, as suggested
per Junio.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sat, 5 Jul 2008, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > Junio wrote:
	> >> Another way would be to set up a pipe to ourself that is 
	> >> included in the poll() and write a byte to the pipe from the signal 
	> >> handler.
	> >
	> > It still would need to break out of the poll(), in which case 
	> > the effect would be _exactly_ the same,...
	> 
	> I do not think so.

	Okay.

	Note that we still have to check for dead children in 
	check_max_connections(), and since child_handler() knows nothing 
	about that, it still will write to the pipe, waking up the loop 
	unnecessarily.

	But that will be rare.

	This is no longer as trivial as I wanted it to be, so I'd 
	appreciate a few eyeballs on this patch.

 daemon.c |   69 +++++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/daemon.c b/daemon.c
index 63cd12c..620a288 100644
--- a/daemon.c
+++ b/daemon.c
@@ -16,6 +16,7 @@
 static int log_syslog;
 static int verbose;
 static int reuseaddr;
+static int child_handler_pipe[2];
 
 static const char daemon_usage[] =
 "git-daemon [--verbose] [--syslog] [--export-all]\n"
@@ -694,23 +695,47 @@ static void kill_some_children(int signo, unsigned start, unsigned stop)
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
@@ -760,18 +785,11 @@ static void child_handler(int signo)
 
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
+			write(child_handler_pipe[1], &status, 1);
 			continue;
 		}
 		break;
@@ -917,19 +935,24 @@ static int service_loop(int socknum, int *socklist)
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
 
 	for (;;) {
 		int i;
 
-		if (poll(pfd, socknum, -1) < 0) {
+		if (poll(pfd, socknum + 1, -1) < 0) {
 			if (errno != EINTR) {
 				error("poll failed, resuming: %s",
 				      strerror(errno));
@@ -937,6 +960,10 @@ static int service_loop(int socknum, int *socklist)
 			}
 			continue;
 		}
+		if (pfd[socknum].revents & POLLIN) {
+			read(child_handler_pipe[0], &i, 1);
+			check_dead_children();
+		}
 
 		for (i = 0; i < socknum; i++) {
 			if (pfd[i].revents & POLLIN) {
-- 
1.5.6.1.300.gca3f
