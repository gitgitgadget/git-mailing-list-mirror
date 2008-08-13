From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [PATCH] git-daemon: Simplify child management and associated logging
	by
Date: Wed, 13 Aug 2008 02:03:12 +0200
Message-ID: <20080813000312.12323.65448.stgit@aristoteles.cuci.nl>
References: <20080812235247.8353.95609.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 02:06:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT3sc-0006Zi-3c
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 02:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbYHMAEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 20:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754671AbYHMAEy
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 20:04:54 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:60517 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbYHMAEx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 20:04:53 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 64E895465; Wed, 13 Aug 2008 02:04:52 +0200 (CEST)
In-Reply-To: <20080812235247.8353.95609.stgit@aristoteles.cuci.nl>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92156>

making the signal handler almost a no-op.
Fix the killing code to actually be smart instead of the
pseudo-random mess.
Get rid of the silly fixed array of children and make
max-connections dynamic and configurable in the process.
Make git-daemon a proper syslogging citizen with PID-info.
Simplify the overzealous double buffering in the logroutine,
remove the artificial maximum logline length in the process.
Changed two calls to error() into logerror().

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

Cleaned up a bit further.

 Documentation/git-daemon.txt |    8 +
 daemon.c                     |  280 ++++++++++++++++--------------------------
 2 files changed, 110 insertions(+), 178 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 4ba4b75..48bcc25 100644
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
@@ -99,6 +100,9 @@ OPTIONS
 	it takes for the server to process the sub-request and time spent
 	waiting for next client's request.
 
+--max-connections::
+	Maximum number of concurrent clients, defaults to 32.
+
 --syslog::
 	Log to syslog instead of stderr. Note that this option does not imply
 	--verbose, thus by default only error conditions will be logged.
diff --git a/daemon.c b/daemon.c
index 1c00305..0de92a8 100644
--- a/daemon.c
+++ b/daemon.c
@@ -16,12 +16,11 @@
 static int log_syslog;
 static int verbose;
 static int reuseaddr;
-static int child_handler_pipe[2];
 
 static const char daemon_usage[] =
 "git daemon [--verbose] [--syslog] [--export-all]\n"
-"           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
-"           [--base-path=path] [--base-path-relaxed]\n"
+"           [--timeout=n] [--init-timeout=n] [--max-connections=n]\n"
+"           [--strict-paths] [--base-path=path] [--base-path-relaxed]\n"
 "           [--user-path | --user-path=path]\n"
 "           [--interpolated-path=path]\n"
 "           [--reuseaddr] [--detach] [--pid-file=file]\n"
@@ -78,38 +77,19 @@ static struct interp interp_table[] = {
 
 static void logreport(int priority, const char *err, va_list params)
 {
-	/* We should do a single write so that it is atomic and output
-	 * of several processes do not get intermingled. */
-	char buf[1024];
-	int buflen;
-	int maxlen, msglen;
-
-	/* sizeof(buf) should be big enough for "[pid] \n" */
-	buflen = snprintf(buf, sizeof(buf), "[%ld] ", (long) getpid());
-
-	maxlen = sizeof(buf) - buflen - 1; /* -1 for our own LF */
-	msglen = vsnprintf(buf + buflen, maxlen, err, params);
-
 	if (log_syslog) {
+		char buf[1024];
+		vsnprintf(buf, sizeof(buf), err, params);
 		syslog(priority, "%s", buf);
-		return;
 	}
-
-	/* maxlen counted our own LF but also counts space given to
-	 * vsnprintf for the terminating NUL.  We want to make sure that
-	 * we have space for our own LF and NUL after the "meat" of the
-	 * message, so truncate it at maxlen - 1.
-	 */
-	if (msglen > maxlen - 1)
-		msglen = maxlen - 1;
-	else if (msglen < 0)
-		msglen = 0; /* Protect against weird return values. */
-	buflen += msglen;
-
-	buf[buflen++] = '\n';
-	buf[buflen] = '\0';
-
-	write_in_full(2, buf, buflen);
+	else {
+		/* Since stderr is set to linebuffered mode, the
+		 * logging of different processes will not overlap
+		 */
+		fprintf(stderr, "[%d] ", (int)getpid());
+		vfprintf(stderr, err, params);
+		fputc('\n', stderr);
+	}
 }
 
 static void logerror(const char *err, ...)
@@ -604,40 +584,37 @@ static int execute(struct sockaddr *addr)
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
@@ -646,107 +623,72 @@ static void add_child(int idx, pid_t pid, struct sockaddr *addr, int addrlen)
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
+ * We kill the newest connection from a duplicate IP first.
+ * If there are no duplicates, then the newest connection is killed,
+ * in order to allow long running clones to actually complete.
  */
-static void kill_some_children(int signo, unsigned start, unsigned stop)
+static void kill_some_child(int signo)
 {
-	start %= MAX_CHILDREN;
-	stop %= MAX_CHILDREN;
-	while (start != stop) {
-		if (!(start & 3))
-			kill(live_child[start].pid, signo);
-		start = (start + 1) % MAX_CHILDREN;
+	const struct child *blanket;
+
+	if ((blanket = firstborn)) {
+		const struct child *next;
+
+		for (; (next = blanket->next); blanket = next)
+			if (!memcmp(&blanket->address, &next->address,
+				   sizeof next->address))
+				break;
+
+		kill(blanket->pid, signo);
 	}
 }
 
 static void check_dead_children(void)
 {
-	unsigned spawned, reaped, deleted;
-
-	spawned = children_spawned;
-	reaped = children_reaped;
-	deleted = children_deleted;
-
-	while (deleted < reaped) {
-		pid_t pid = dead_child[deleted % MAX_CHILDREN];
-		const char *dead = pid < 0 ? " (with error)" : "";
-
-		if (pid < 0)
-			pid = -pid;
+	int status;
+	pid_t pid;
 
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
+	while ((pid = waitpid(-1, &status, WNOHANG))>0) {
+		const char *dead = "";
+		remove_child(pid);
+		if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
+			dead = " (with error)";
+		loginfo("[%d] Disconnected%s", (int)pid, dead);
 	}
-	children_deleted = deleted;
 }
 
 static void check_max_connections(void)
 {
 	for (;;) {
-		int active;
-		unsigned spawned, deleted;
-
 		check_dead_children();
-
-		spawned = children_spawned;
-		deleted = children_deleted;
-
-		active = spawned - deleted;
-		if (active <= max_connections)
+		if (live_children <= max_connections)
 			break;
 
 		/* Kill some unstarted connections with SIGTERM */
-		kill_some_children(SIGTERM, deleted, spawned);
-		if (active <= max_connections << 1)
+		kill_some_child(SIGTERM);
+		check_dead_children();
+		if (live_children <= max_connections << 1)
 			break;
 
 		/* If the SIGTERM thing isn't helping use SIGKILL */
-		kill_some_children(SIGKILL, deleted, spawned);
+		kill_some_child(SIGKILL);
 		sleep(1);
 	}
 }
@@ -756,16 +698,13 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
 	pid_t pid = fork();
 
 	if (pid) {
-		unsigned idx;
-
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
+		add_child(pid, addr, addrlen);
 		check_max_connections();
 		return;
 	}
@@ -779,21 +718,10 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
 
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
 
@@ -836,7 +764,7 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 		if (sockfd < 0)
 			continue;
 		if (sockfd >= FD_SETSIZE) {
-			error("too large socket descriptor.");
+			logerror("too large socket descriptor.");
 			close(sockfd);
 			continue;
 		}
@@ -936,35 +864,30 @@ static int service_loop(int socknum, int *socklist)
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
+
+		i = poll(pfd, socknum, -1);
+		olderrno = errno;
 
-		if (poll(pfd, socknum + 1, -1) < 0) {
-			if (errno != EINTR) {
-				error("poll failed, resuming: %s",
-				      strerror(errno));
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
@@ -1055,10 +978,7 @@ int main(int argc, char **argv)
 	gid_t gid = 0;
 	int i;
 
-	/* Without this we cannot rely on waitpid() to tell
-	 * what happened to our children.
-	 */
-	signal(SIGCHLD, SIG_DFL);
+	child_handler(0);
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
@@ -1105,6 +1025,10 @@ int main(int argc, char **argv)
 			init_timeout = atoi(arg+15);
 			continue;
 		}
+		if (!prefixcmp(arg, "--max-connections=")) {
+			max_connections = atoi(arg+18);
+			continue;
+		}
 		if (!strcmp(arg, "--strict-paths")) {
 			strict_paths = 1;
 			continue;
@@ -1178,9 +1102,11 @@ int main(int argc, char **argv)
 	}
 
 	if (log_syslog) {
-		openlog("git-daemon", 0, LOG_DAEMON);
+		openlog("git-daemon", LOG_PID, LOG_DAEMON);
 		set_die_routine(daemon_die);
 	}
+	else			    /* so that logging into a file is atomic */
+		setlinebuf(stderr);
 
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
@@ -1233,8 +1159,10 @@ int main(int argc, char **argv)
 		return execute(peer);
 	}
 
-	if (detach)
+	if (detach) {
 		daemonize();
+		loginfo("Ready to rumble");
+	}
 	else
 		sanitize_stdfds();
 
