From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Verbose git-daemon logging
Date: Wed, 21 Sep 2005 23:39:33 +0200
Message-ID: <20050921213933.GB10575@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 21 23:40:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EICJZ-0007Yg-Bp
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 23:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVIUVji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 17:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVIUVji
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 17:39:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:37098 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965008AbVIUVjh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 17:39:37 -0400
Received: (qmail 29349 invoked by uid 2001); 21 Sep 2005 23:39:34 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9080>

This patch makes git-daemon --verbose log some useful things on stderr -
in particular connects, disconnects and upload requests, and in such a
way to be able to trace a particular session. Some more errors are now
also logged (even when --verbose is not passed). It is still not perfect
since messages produced by the non-daemon-specific code are obviously
not formatted properly.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
commit 419408cb9545495cd542d18219598c318f91007d
tree da6735878367946edae024c76e6f8165f82cfe07
parent ff0b3368b45a07ac080574eb721a607892413b99
author Petr Baudis <pasky@suse.cz> Wed, 21 Sep 2005 23:36:20 +0200
committer Petr Baudis <xpasky@machine.(none)> Wed, 21 Sep 2005 23:36:20 +0200

 daemon.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -6,13 +6,54 @@
 #include <sys/time.h>
 #include <netdb.h>
 #include <netinet/in.h>
+#include <arpa/inet.h>
+
+static int verbose;
+
+static const char daemon_usage[] = "git-daemon [--verbose] [--inetd | --port=n]";
+
+
+static void logreport(const char *err, va_list params)
+{
+	/* We should do a single write so that it is atomic and output
+	 * of several threads does not get intermangled. */
+	char buf[1024];
+	int buflen;
+
+	buflen = snprintf(buf, 1024, "[%d] ", getpid());
+	buflen += vsnprintf(buf + buflen, 1024 - buflen, err, params);
+	buf[buflen++] = '\n';
+	buf[buflen] = '\0';
+
+	fputs(buf, stderr);
+}
+
+void logerror(const char *err, ...)
+{
+	va_list params;
+	va_start(params, err);
+	logreport(err, params);
+	va_end(params);
+}
+
+void lognotice(const char *err, ...)
+{
+	va_list params;
+	if (!verbose)
+		return;
+	va_start(params, err);
+	logreport(err, params);
+	va_end(params);
+}
 
-static const char daemon_usage[] = "git-daemon [--inetd | --port=n]";
 
 static int upload(char *dir, int dirlen)
 {
-	if (chdir(dir) < 0)
+	lognotice("Request for '%s'", dir);
+	if (chdir(dir) < 0) {
+		logerror("Cannot chdir('%s'): %s", dir, strerror(errno));
 		return -1;
+	}
 	chdir(".git");
 
 	/*
@@ -24,8 +65,10 @@ static int upload(char *dir, int dirlen)
 	 */
 	if (access("git-daemon-export-ok", F_OK) ||
 	    access("objects/00", X_OK) ||
-	    access("HEAD", R_OK))
+	    access("HEAD", R_OK)) {
+		logerror("Not a valid gitd-enabled repository: '%s'", dir);
 		return -1;
+	}
 
 	/*
 	 * We'll ignore SIGTERM from now on, we have a
@@ -51,7 +94,7 @@ static int execute(void)
 	if (!strncmp("git-upload-pack /", line, 17))
 		return upload(line + 16, len - 16);
 
-	fprintf(stderr, "got bad connection '%s'\n", line);
+	logerror("Protocol error: '%s'", line);
 	return -1;
 }
 
@@ -181,6 +224,8 @@ static void check_max_connections(void)
 static void handle(int incoming, struct sockaddr *addr, int addrlen)
 {
 	pid_t pid = fork();
+	char addrbuf[256] = "";
+	int port = -1;
 
 	if (pid) {
 		unsigned idx;
@@ -200,6 +245,24 @@ static void handle(int incoming, struct 
 	dup2(incoming, 0);
 	dup2(incoming, 1);
 	close(incoming);
+
+	if (addr->sa_family == AF_INET) {
+		struct sockaddr_in *sin_addr = (void *) addr;
+		inet_ntop(AF_INET, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
+		port = sin_addr->sin_port;
+
+	} else if (addr->sa_family == AF_INET6) {
+		struct sockaddr_in6 *sin6_addr = (void *) addr;
+
+		char *buf = addrbuf;
+		*buf++ = '['; *buf = '\0'; /* stpcpy() is cool */
+		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(addrbuf) - 1);
+		strcat(buf, "]");
+
+		port = sin6_addr->sin6_port;
+	}
+	lognotice("Connection from %s:%d", addrbuf, port);
+
 	exit(execute());
 }
 
@@ -212,6 +275,9 @@ static void child_handler(int signo)
 			unsigned reaped = children_reaped;
 			dead_child[reaped % MAX_CHILDREN] = pid;
 			children_reaped = reaped + 1;
+			/* XXX: Custom logging, since we don't wanna getpid() */
+			if (verbose)
+				fprintf(stderr, "[%d] Disconnected\n", pid);
 			continue;
 		}
 		break;
@@ -349,6 +415,10 @@ int main(int argc, char **argv)
 			inetd_mode = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--verbose")) {
+			verbose = 1;
+			continue;
+		}
 
 		usage(daemon_usage);
 	}


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
