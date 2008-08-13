From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [PATCH 3/3] git-daemon: rewrite kindergarden
Date: Wed, 13 Aug 2008 10:43:31 +0200
Message-ID: <20080813084331.30845.21129.stgit@aristoteles.cuci.nl>
References: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 10:46:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTBzD-0000gm-Al
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 10:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051AbYHMInk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 04:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755554AbYHMInj
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 04:43:39 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:49203 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818AbYHMInc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 04:43:32 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 3E3825466; Wed, 13 Aug 2008 10:43:31 +0200 (CEST)
In-Reply-To: <20080813084330.30845.89753.stgit@aristoteles.cuci.nl>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92194>

Get rid of the silly fixed array of children and make
max-connections dynamic and configurable in the process.
Fix the killing code to actually be smart instead of the
pseudo-random mess.
Avoid forking if too busy already.

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

 Documentation/git-daemon.txt |    9 +-
 daemon.c                     |  215 +++++++++++++++---------------------------
 2 files changed, 84 insertions(+), 140 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 4ba4b75..b08a08c 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -9,8 +9,9 @@ SYNOPSIS
 --------
 [verse]
 'git daemon' [--verbose] [--syslog] [--export-all]
-	     [--timeout=n] [--init-timeout=n] [--strict-paths]
-	     [--base-path=path] [--user-path | --user-path=path]
+	     [--timeout=n] [--init-timeout=n] [--max-connections=n]
+	     [--strict-paths] [--base-path=path] [--base-path-relaxed]
+	     [--user-path | --user-path=path]
 	     [--interpolated-path=pathtemplate]
 	     [--reuseaddr] [--detach] [--pid-file=file]
 	     [--enable=service] [--disable=service]
@@ -99,6 +100,10 @@ OPTIONS
 	it takes for the server to process the sub-request and time spent
 	waiting for next client's request.
 
+--max-connections::
+	Maximum number of concurrent clients, defaults to 32.  Set it to
+	zero for no limit.
+
 --syslog::
 	Log to syslog instead of stderr. Note that this option does not imply
 	--verbose, thus by default only error conditions will be logged.
diff --git a/daemon.c b/daemon.c
index 19d620c..a7a735c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -19,8 +19,8 @@ static int reuseaddr;
 
 static const char daemon_usage[] =
 "git daemon [--verbose] [--syslog] [--export-all]\n"
-"           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
-"           [--base-path=path] [--base-path-relaxed]\n"
+"           [--timeout=n] [--init-timeout=n] [--max-connections=n]\n"
+"           [--strict-paths] [--base-path=path] [--base-path-relaxed]\n"
 "           [--user-path | --user-path=path]\n"
 "           [--interpolated-path=path]\n"
 "           [--reuseaddr] [--detach] [--pid-file=file]\n"
@@ -584,40 +584,37 @@ static int execute(struct sockaddr *addr)
 	return -1;
 }
 
+static int max_connections = 32;
 
-/*
- * We count spawned/reaped separately, just to avoid any
- * races when updating them from signals. The SIGCHLD handler
- * will only update children_reaped, and the fork logic will
- * only update children_spawned.
- *
- * MAX_CHILDREN should be a power-of-two to make the modulus
- * operation cheap. It should also be at least twice
- * the maximum number of connections we will ever allow.
- */
-#define MAX_CHILDREN 128
-
-static int max_connections = 25;
-
-/* These are updated by the signal handler */
-static volatile unsigned int children_reaped;
-static pid_t dead_child[MAX_CHILDREN];
-
-/* These are updated by the main loop */
-static unsigned int children_spawned;
-static unsigned int children_deleted;
+static unsigned int live_children;
 
 static struct child {
+	struct child*next;
 	pid_t pid;
-	int addrlen;
 	struct sockaddr_storage address;
-} live_child[MAX_CHILDREN];
+} *firstborn;
 
-static void add_child(int idx, pid_t pid, struct sockaddr *addr, int addrlen)
+static void add_child(pid_t pid, struct sockaddr *addr, int addrlen)
 {
-	live_child[idx].pid = pid;
-	live_child[idx].addrlen = addrlen;
-	memcpy(&live_child[idx].address, addr, addrlen);
+	struct child*newborn;
+	newborn = xcalloc(1, sizeof *newborn);
+	if (newborn) {
+		struct child **cradle, *blanket;
+
+		live_children++;
+		newborn->pid = pid;
+		memcpy(&newborn->address, addr, addrlen);
+		for (cradle = &firstborn;
+		     (blanket = *cradle);
+		     cradle = &blanket->next)
+			if (!memcmp(&blanket->address, &newborn->address,
+				   sizeof newborn->address))
+				break;
+		newborn->next = blanket;
+		*cradle = newborn;
+	}
+	else
+		logerror("Out of memory spawning new child");
 }
 
 /*
@@ -626,142 +623,78 @@ static void add_child(int idx, pid_t pid, struct sockaddr *addr, int addrlen)
  * We move everything up by one, since the new "deleted" will
  * be one higher.
  */
-static void remove_child(pid_t pid, unsigned deleted, unsigned spawned)
+static void remove_child(pid_t pid)
 {
-	struct child n;
+	struct child **cradle, *blanket;
 
-	deleted %= MAX_CHILDREN;
-	spawned %= MAX_CHILDREN;
-	if (live_child[deleted].pid == pid) {
-		live_child[deleted].pid = -1;
-		return;
-	}
-	n = live_child[deleted];
-	for (;;) {
-		struct child m;
-		deleted = (deleted + 1) % MAX_CHILDREN;
-		if (deleted == spawned)
-			die("could not find dead child %d\n", pid);
-		m = live_child[deleted];
-		live_child[deleted] = n;
-		if (m.pid == pid)
-			return;
-		n = m;
-	}
+	for (cradle = &firstborn; (blanket = *cradle); cradle = &blanket->next)
+		if (blanket->pid == pid) {
+			*cradle = blanket->next;
+			live_children--;
+			free(blanket);
+			break;
+		}
 }
 
 /*
  * This gets called if the number of connections grows
  * past "max_connections".
  *
- * We _should_ start off by searching for connections
- * from the same IP, and if there is some address wth
- * multiple connections, we should kill that first.
- *
- * As it is, we just "randomly" kill 25% of the connections,
- * and our pseudo-random generator sucks too. I have no
- * shame.
- *
- * Really, this is just a place-holder for a _real_ algorithm.
+ * We kill the newest connection from a duplicate IP.
  */
-static void kill_some_children(int signo, unsigned start, unsigned stop)
+static void kill_some_child()
 {
-	start %= MAX_CHILDREN;
-	stop %= MAX_CHILDREN;
-	while (start != stop) {
-		if (!(start & 3))
-			kill(live_child[start].pid, signo);
-		start = (start + 1) % MAX_CHILDREN;
-	}
-}
-
-static void check_dead_children(void)
-{
-	unsigned spawned, reaped, deleted;
-
-	for (;;) {
-	    int status;
-	    pid_t pid = waitpid(-1, &status, WNOHANG);
-	
-	    if (pid > 0) {
-	        unsigned reaped = children_reaped;
-	        if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
-	            pid = -pid;
-	        dead_child[reaped % MAX_CHILDREN] = pid;
-	        children_reaped = reaped + 1;
-	        continue;
-	    }
-	    break;
-	}
+	const struct child *blanket;
 
-	spawned = children_spawned;
-	reaped = children_reaped;
-	deleted = children_deleted;
+	if ((blanket = firstborn)) {
+		const struct child *next;
 
-	while (deleted < reaped) {
-		pid_t pid = dead_child[deleted % MAX_CHILDREN];
-		const char *dead = pid < 0 ? " (with error)" : "";
-
-		if (pid < 0)
-			pid = -pid;
-
-		/* XXX: Custom logging, since we don't wanna getpid() */
-		if (verbose) {
-			if (log_syslog)
-				syslog(LOG_INFO, "[%d] Disconnected%s",
-						pid, dead);
-			else
-				fprintf(stderr, "[%d] Disconnected%s\n",
-						pid, dead);
-		}
-		remove_child(pid, deleted, spawned);
-		deleted++;
+		for (; (next = blanket->next); blanket = next)
+			if (!memcmp(&blanket->address, &next->address,
+				   sizeof next->address)) {
+				kill(blanket->pid, SIGTERM);
+				break;
+			}
 	}
-	children_deleted = deleted;
 }
 
-static void check_max_connections(void)
+static void check_dead_children(void)
 {
-	for (;;) {
-		int active;
-		unsigned spawned, deleted;
-
-		check_dead_children();
-
-		spawned = children_spawned;
-		deleted = children_deleted;
-
-		active = spawned - deleted;
-		if (active <= max_connections)
-			break;
-
-		/* Kill some unstarted connections with SIGTERM */
-		kill_some_children(SIGTERM, deleted, spawned);
-		if (active <= max_connections << 1)
-			break;
+	int status;
+	pid_t pid;
 
-		/* If the SIGTERM thing isn't helping use SIGKILL */
-		kill_some_children(SIGKILL, deleted, spawned);
-		sleep(1);
+	while ((pid = waitpid(-1, &status, WNOHANG))>0) {
+		const char *dead = "";
+		remove_child(pid);
+		if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
+			dead = " (with error)";
+		loginfo("[%d] Disconnected%s", (int)pid, dead);
 	}
 }
 
 static void handle(int incoming, struct sockaddr *addr, int addrlen)
 {
-	pid_t pid = fork();
+	pid_t pid;
 
-	if (pid) {
-		unsigned idx;
+	if (max_connections && live_children >= max_connections) {
+		kill_some_child();
+		sleep(1);			 /* give it some time to die */
+		check_dead_children();
+		if (live_children >= max_connections) {
+			close(incoming);
+			logerror("Too many children, dropping connection");
+			return;
+		}
+	}
 
+	if ((pid = fork())) {
 		close(incoming);
-		if (pid < 0)
+		if (pid < 0) {
+			logerror("Couldn't fork %s", strerror(errno));
 			return;
+		}
 
-		idx = children_spawned % MAX_CHILDREN;
-		children_spawned++;
-		add_child(idx, pid, addr, addrlen);
-
-		check_max_connections();
+		add_child(pid, addr, addrlen);
 		return;
 	}
 
@@ -1081,6 +1014,12 @@ int main(int argc, char **argv)
 			init_timeout = atoi(arg+15);
 			continue;
 		}
+		if (!prefixcmp(arg, "--max-connections=")) {
+			max_connections = atoi(arg+18);
+			if (max_connections<=0)
+				max_connections=0;	        /* unlimited */
+			continue;
+		}
 		if (!strcmp(arg, "--strict-paths")) {
 			strict_paths = 1;
 			continue;
