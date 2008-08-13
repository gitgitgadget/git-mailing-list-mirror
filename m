From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [PATCH 2/3] git-daemon: make the signal handler almost a no-op
Date: Wed, 13 Aug 2008 10:43:31 +0200
Message-ID: <20080813084331.30845.74788.stgit@aristoteles.cuci.nl>
References: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 10:46:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTBzC-0000gm-Ln
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 10:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752512AbYHMInh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 04:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756092AbYHMInf
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 04:43:35 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:49204 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756233AbYHMInc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 04:43:32 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 380F85464; Wed, 13 Aug 2008 10:43:31 +0200 (CEST)
In-Reply-To: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92196>

by exploiting the fact that systemcalls get interrupted by signals;
and even they aren't, all zombies will be collected before the next
accept().
Fix another error() -> logerror() call.

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

 daemon.c |   67 +++++++++++++++++++++++++++++---------------------------------
 1 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/daemon.c b/daemon.c
index 774b2ce..19d620c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -16,7 +16,6 @@
 static int log_syslog;
 static int verbose;
 static int reuseaddr;
-static int child_handler_pipe[2];
 
 static const char daemon_usage[] =
 "git daemon [--verbose] [--syslog] [--export-all]\n"
@@ -680,6 +679,21 @@ static void check_dead_children(void)
 {
 	unsigned spawned, reaped, deleted;
 
+	for (;;) {
+	    int status;
+	    pid_t pid = waitpid(-1, &status, WNOHANG);
+	
+	    if (pid > 0) {
+	        unsigned reaped = children_reaped;
+	        if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
+	            pid = -pid;
+	        dead_child[reaped % MAX_CHILDREN] = pid;
+	        children_reaped = reaped + 1;
+	        continue;
+	    }
+	    break;
+	}
+
 	spawned = children_spawned;
 	reaped = children_reaped;
 	deleted = children_deleted;
@@ -760,21 +774,10 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
 
 static void child_handler(int signo)
 {
-	for (;;) {
-		int status;
-		pid_t pid = waitpid(-1, &status, WNOHANG);
-
-		if (pid > 0) {
-			unsigned reaped = children_reaped;
-			if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
-				pid = -pid;
-			dead_child[reaped % MAX_CHILDREN] = pid;
-			children_reaped = reaped + 1;
-			write(child_handler_pipe[1], &status, 1);
-			continue;
-		}
-		break;
-	}
+	/* Otherwise empty handler because systemcalls will get interrupted
+	 * upon signal receipt
+	 * SysV needs the handler to be reinstated
+	 */
 	signal(SIGCHLD, child_handler);
 }
 
@@ -917,35 +920,30 @@ static int service_loop(int socknum, int *socklist)
 	struct pollfd *pfd;
 	int i;
 
-	if (pipe(child_handler_pipe) < 0)
-		die ("Could not set up pipe for child handler");
-
-	pfd = xcalloc(socknum + 1, sizeof(struct pollfd));
+	pfd = xcalloc(socknum, sizeof(struct pollfd));
 
 	for (i = 0; i < socknum; i++) {
 		pfd[i].fd = socklist[i];
 		pfd[i].events = POLLIN;
 	}
-	pfd[socknum].fd = child_handler_pipe[0];
-	pfd[socknum].events = POLLIN;
-
-	child_handler(0);
 
 	for (;;) {
 		int i;
+		int olderrno;
 
-		if (poll(pfd, socknum + 1, -1) < 0) {
-			if (errno != EINTR) {
-				error("poll failed, resuming: %s",
-				      strerror(errno));
+		i = poll(pfd, socknum, -1);
+		olderrno = errno;
+
+		check_dead_children();
+
+		if (i < 0) {
+			if (olderrno != EINTR) {
+				logerror("poll failed, resuming: %s",
+				      strerror(olderrno));
 				sleep(1);
 			}
 			continue;
 		}
-		if (pfd[socknum].revents & POLLIN) {
-			read(child_handler_pipe[0], &i, 1);
-			check_dead_children();
-		}
 
 		for (i = 0; i < socknum; i++) {
 			if (pfd[i].revents & POLLIN) {
@@ -1036,10 +1034,7 @@ int main(int argc, char **argv)
 	gid_t gid = 0;
 	int i;
 
-	/* Without this we cannot rely on waitpid() to tell
-	 * what happened to our children.
-	 */
-	signal(SIGCHLD, SIG_DFL);
+	child_handler(0);
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
