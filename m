From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 3/4] git-daemon --syslog to log through syslog
Date: Sat, 24 Sep 2005 16:13:01 +0200
Message-ID: <20050924141300.8423.36900.stgit@machine.or.cz>
References: <20050924141254.8423.80265.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 16:14:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJAmE-0002Hw-Uw
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 16:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVIXONE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 10:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVIXONE
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 10:13:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4804 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932175AbVIXONC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2005 10:13:02 -0400
Received: (qmail 8502 invoked from network); 24 Sep 2005 16:13:01 +0200
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 24 Sep 2005 16:13:01 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050924141254.8423.80265.stgit@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9234>

Well, this makes it even more clear that we need the packet reader and
friends to use the daemon logging code. :/  Therefore, we at least indicate
in the "Disconnect" log message if the child process exitted with an error
code or not.

Idea by Linus.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-daemon.txt |    6 +++++-
 daemon.c                     |   34 +++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -7,7 +7,7 @@ git-daemon - A really simple server for 
 
 SYNOPSIS
 --------
-'git-daemon' [--verbose] [--inetd | --port=n]
+'git-daemon' [--verbose] [--syslog] [--inetd | --port=n]
 
 DESCRIPTION
 -----------
@@ -32,6 +32,10 @@ OPTIONS
 --port::
 	Listen on an alternative port.
 
+--syslog::
+	Log to syslog instead of stderr. Note that this option does not imply
+	--verbose, thus by default only error conditions will be logged.
+
 --verbose::
 	Log details about the incoming connections and requested files.
 
diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -7,13 +7,15 @@
 #include <netdb.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <syslog.h>
 
+static int log_syslog;
 static int verbose;
 
-static const char daemon_usage[] = "git-daemon [--verbose] [--inetd | --port=n]";
+static const char daemon_usage[] = "git-daemon [--verbose] [--syslog] [--inetd | --port=n]";
 
 
-static void logreport(const char *err, va_list params)
+static void logreport(int priority, const char *err, va_list params)
 {
 	/* We should do a single write so that it is atomic and output
 	 * of several processes do not get intermingled. */
@@ -27,6 +29,11 @@ static void logreport(const char *err, v
 	maxlen = sizeof(buf) - buflen - 1; /* -1 for our own LF */
 	msglen = vsnprintf(buf + buflen, maxlen, err, params);
 
+	if (log_syslog) {
+		syslog(priority, "%s", buf);
+		return;
+	}
+
 	/* maxlen counted our own LF but also counts space given to
 	 * vsnprintf for the terminating NUL.  We want to make sure that
 	 * we have space for our own LF and NUL after the "meat" of the
@@ -48,7 +55,7 @@ void logerror(const char *err, ...)
 {
 	va_list params;
 	va_start(params, err);
-	logreport(err, params);
+	logreport(LOG_ERR, err, params);
 	va_end(params);
 }
 
@@ -58,7 +65,7 @@ void lognotice(const char *err, ...)
 	if (!verbose)
 		return;
 	va_start(params, err);
-	logreport(err, params);
+	logreport(LOG_INFO, err, params);
 	va_end(params);
 }
 
@@ -285,15 +292,23 @@ static void handle(int incoming, struct 
 static void child_handler(int signo)
 {
 	for (;;) {
-		pid_t pid = waitpid(-1, NULL, WNOHANG);
+		int status;
+		pid_t pid = waitpid(-1, &status, WNOHANG);
 
 		if (pid > 0) {
 			unsigned reaped = children_reaped;
 			dead_child[reaped % MAX_CHILDREN] = pid;
 			children_reaped = reaped + 1;
 			/* XXX: Custom logging, since we don't wanna getpid() */
-			if (verbose)
-				fprintf(stderr, "[%d] Disconnected\n", pid);
+			if (verbose) {
+				char *dead = "";
+				if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
+					dead = " (with error)";
+				if (log_syslog)
+					syslog(LOG_INFO, "[%d] Disconnected%s", pid, dead);
+				else
+					fprintf(stderr, "[%d] Disconnected%s\n", pid, dead);
+			}
 			continue;
 		}
 		break;
@@ -435,6 +450,11 @@ int main(int argc, char **argv)
 			verbose = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--syslog")) {
+			log_syslog = 1;
+			openlog("git-daemon", 0, LOG_DAEMON);
+			continue;
+		}
 
 		usage(daemon_usage);
 	}
