From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 08/14] daemon: use run-command api for async serving
Date: Sun, 10 Oct 2010 15:20:48 +0200
Message-ID: <1286716854-5744-9-git-send-email-kusmabite@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 15:22:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vrN-00053F-Hk
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757710Ab0JJNWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 09:22:34 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54307 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab0JJNWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:22:33 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so255794ewy.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=oBFUXYvQtqQUUUMfeO0N+6mwkZ8D+acxV4dpv8jgQC4=;
        b=dgFfuddwvCk4YFBiMLsvfwhtsDDaqbTZBWhJmCxzeBEkQm3X44AtKrtuDgfgx4JGzT
         u0VD2hCFgQu3D92L+88M+P+DkZytQ3gEw1omvaBQ0ZiogtQet9rgyqdYDHw8a6g7QF/m
         S3PD+QaBXJFuDV41hTOvm2AVta+1NC92V5kgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oKdy9QNYTauwIFtTMxGbhhvfYIWPWmYo7nekJOCBYthXJxBE/s+khmf0r1ag99GMOP
         joo/va3khAaRRst7LoYxHqiuy571env+iTvc5AIIdYTZNVeM6mA7jrAVjpkrJLiSPdjk
         fGCywRhUh8/YHRGmb55uN5CFrjVGRiJJBoGoo=
Received: by 10.213.108.70 with SMTP id e6mr1213530ebp.38.1286716952834;
        Sun, 10 Oct 2010 06:22:32 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q54sm5196567eeh.18.2010.10.10.06.22.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:22:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158666>

fork() is only available on POSIX, so to support git-daemon
on Windows we have to use something else.

Instead we invent the flag --serve, which is a stripped down
version of --inetd-mode. We use start_command() to call
git-daemon with this flag appended to serve clients.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   86 +++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/daemon.c b/daemon.c
index d594375..ee29c9f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -614,17 +614,17 @@ static unsigned int live_children;
 
 static struct child {
 	struct child *next;
-	pid_t pid;
+	struct child_process cld;
 	struct sockaddr_storage address;
 } *firstborn;
 
-static void add_child(pid_t pid, struct sockaddr *addr, int addrlen)
+static void add_child(struct child_process *cld, struct sockaddr *addr, int addrlen)
 {
 	struct child *newborn, **cradle;
 
 	newborn = xcalloc(1, sizeof(*newborn));
 	live_children++;
-	newborn->pid = pid;
+	memcpy(&newborn->cld, cld, sizeof(*cld));
 	memcpy(&newborn->address, addr, addrlen);
 	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
 		if (!addrcmp(&(*cradle)->address, &newborn->address))
@@ -633,19 +633,6 @@ static void add_child(pid_t pid, struct sockaddr *addr, int addrlen)
 	*cradle = newborn;
 }
 
-static void remove_child(pid_t pid)
-{
-	struct child **cradle, *blanket;
-
-	for (cradle = &firstborn; (blanket = *cradle); cradle = &blanket->next)
-		if (blanket->pid == pid) {
-			*cradle = blanket->next;
-			live_children--;
-			free(blanket);
-			break;
-		}
-}
-
 /*
  * This gets called if the number of connections grows
  * past "max_connections".
@@ -654,14 +641,14 @@ static void remove_child(pid_t pid)
  */
 static void kill_some_child(void)
 {
-	const struct child *blanket, *next;
+	struct child *blanket, *next;
 
 	if (!(blanket = firstborn))
 		return;
 
 	for (; (next = blanket->next); blanket = next)
 		if (!addrcmp(&blanket->address, &next->address)) {
-			kill(blanket->pid, SIGTERM);
+			kill(blanket->cld.pid, SIGTERM);
 			break;
 		}
 }
@@ -671,18 +658,26 @@ static void check_dead_children(void)
 	int status;
 	pid_t pid;
 
-	while ((pid = waitpid(-1, &status, WNOHANG)) > 0) {
-		const char *dead = "";
-		remove_child(pid);
-		if (!WIFEXITED(status) || (WEXITSTATUS(status) > 0))
-			dead = " (with error)";
-		loginfo("[%"PRIuMAX"] Disconnected%s", (uintmax_t)pid, dead);
-	}
+	struct child **cradle, *blanket;
+	for (cradle = &firstborn; (blanket = *cradle);)
+		if ((pid = waitpid(blanket->cld.pid, &status, WNOHANG)) > 1) {
+			const char *dead = "";
+			if (status)
+				dead = " (with error)";
+			loginfo("[%"PRIuMAX"] Disconnected%s", (uintmax_t)pid, dead);
+
+			/* remove the child */
+			*cradle = blanket->next;
+			live_children--;
+			free(blanket);
+		} else
+			cradle = &blanket->next;
 }
 
+char **cld_argv;
 static void handle(int incoming, struct sockaddr *addr, int addrlen)
 {
-	pid_t pid;
+	struct child_process cld = { 0 };
 
 	if (max_connections && live_children >= max_connections) {
 		kill_some_child();
@@ -695,22 +690,15 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
 		}
 	}
 
-	if ((pid = fork())) {
-		close(incoming);
-		if (pid < 0) {
-			logerror("Couldn't fork %s", strerror(errno));
-			return;
-		}
-
-		add_child(pid, addr, addrlen);
-		return;
-	}
+	cld.argv = (const char **)cld_argv;
+	cld.in = incoming;
+	cld.out = dup(incoming);
 
-	dup2(incoming, 0);
-	dup2(incoming, 1);
+	if (start_command(&cld))
+		logerror("unable to fork");
+	else
+		add_child(&cld, addr, addrlen);
 	close(incoming);
-
-	exit(execute(addr));
 }
 
 static void child_handler(int signo)
@@ -991,7 +979,7 @@ int main(int argc, char **argv)
 {
 	int listen_port = 0;
 	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
-	int inetd_mode = 0;
+	int serve_mode = 0, inetd_mode = 0;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
 	struct passwd *pass = NULL;
@@ -1017,7 +1005,12 @@ int main(int argc, char **argv)
 				continue;
 			}
 		}
+		if (!strcmp(arg, "--serve")) {
+			serve_mode = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--inetd")) {
+			serve_mode = 1;
 			inetd_mode = 1;
 			log_syslog = 1;
 			continue;
@@ -1161,12 +1154,12 @@ int main(int argc, char **argv)
 		die("base-path '%s' does not exist or is not a directory",
 		    base_path);
 
-	if (inetd_mode) {
+	if (serve_mode) {
 		struct sockaddr_storage ss;
 		struct sockaddr *peer = (struct sockaddr *)&ss;
 		socklen_t slen = sizeof(ss);
 
-		if (!freopen("/dev/null", "w", stderr))
+		if (inetd_mode && !freopen("/dev/null", "w", stderr))
 			die_errno("failed to redirect stderr to /dev/null");
 
 		if (getpeername(0, peer, &slen))
@@ -1185,5 +1178,12 @@ int main(int argc, char **argv)
 	if (pid_file)
 		store_pid(pid_file);
 
+	/* prepare argv for serving-processes */
+	cld_argv = xmalloc(sizeof (char *) * (argc + 2));
+	for (i = 0; i < argc; ++i)
+		cld_argv[i] = argv[i];
+	cld_argv[argc] = "--serve";
+	cld_argv[argc+1] = NULL;
+
 	return serve(&listen_addr, listen_port, pass, gid);
 }
-- 
1.7.3.1.51.ge462f.dirty
