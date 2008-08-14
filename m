From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [PATCH 3/4] git-daemon: move almost all code out of the
	child_handler()
Date: Thu, 14 Aug 2008 20:02:20 +0200
Message-ID: <20080814180220.15729.5512.stgit@aristoteles.cuci.nl>
References: <20080814180220.15729.34048.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 20:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KThAo-0005Fp-W8
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 20:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759585AbYHNSC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 14:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759548AbYHNSCZ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 14:02:25 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:47463 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759510AbYHNSCV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 14:02:21 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 6D7525466; Thu, 14 Aug 2008 20:02:20 +0200 (CEST)
In-Reply-To: <20080814180220.15729.34048.stgit@aristoteles.cuci.nl>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92382>

into check_dead_children().
The fact that systemcalls get interrupted by signals allows us to
make the SIGCHLD signal handler almost a no-op by simply running
check_dead_children() right before waiting on poll().

For those concerned with portability to "awkward" systems:
In case some systems do not interrupt systemcalls upon signal receipt,
all zombies will eventually be collected before the next poll() cycle.

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

 daemon.c |   55 +++++++++++++++++++++++--------------------------------
 1 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/daemon.c b/daemon.c
index 2f86671..77bd8e1 100644
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
+	 * SysV needs the handler to be rearmed
+	 */
 	signal(SIGCHLD, child_handler);
 }
 
@@ -917,24 +920,21 @@ static int service_loop(int socknum, int *socklist)
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
 
 	signal(SIGCHLD, child_handler);
 
 	for (;;) {
 		int i;
 
-		if (poll(pfd, socknum + 1, -1) < 0) {
+		check_dead_children();
+
+		if (poll(pfd, socknum, -1) < 0) {
 			if (errno != EINTR) {
 				logerror("Poll failed, resuming: %s",
 				      strerror(errno));
@@ -942,10 +942,6 @@ static int service_loop(int socknum, int *socklist)
 			}
 			continue;
 		}
-		if (pfd[socknum].revents & POLLIN) {
-			read(child_handler_pipe[0], &i, 1);
-			check_dead_children();
-		}
 
 		for (i = 0; i < socknum; i++) {
 			if (pfd[i].revents & POLLIN) {
@@ -1036,11 +1032,6 @@ int main(int argc, char **argv)
 	gid_t gid = 0;
 	int i;
 
-	/* Without this we cannot rely on waitpid() to tell
-	 * what happened to our children.
-	 */
-	signal(SIGCHLD, SIG_DFL);
-
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
