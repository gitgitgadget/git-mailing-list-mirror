From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 09/14] daemon: use run-command api for async serving
Date: Fri, 15 Jan 2010 22:30:28 +0100
Message-ID: <1263591033-4992-10-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, j6t@kdbg.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Jan 15 22:32:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtly-0005uF-Ab
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 22:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758401Ab0AOVbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 16:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758399Ab0AOVbw
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 16:31:52 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:42825 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758397Ab0AOVbv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 16:31:51 -0500
Received: by mail-ew0-f209.google.com with SMTP id 1so568991ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 13:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Nhyzndz3bHbSrVmARPUbr+dtOHIYlj/EkLCewfSUkW0=;
        b=O28dj62dOUfCalkLdMdrKpiid+rZIS4nqTg4DdS7hRhhcym27tYL95L6cYeNZYW+0w
         pocCwJgX4/Sdo9rviuAKrIxwfXKRfbGKhPCKyMeuFqn79Zx+p6fyRlWDi/xvksJ9zUb1
         zUtbmtzlF0M6iIlLhkK1pgs0mWAr6UbEpyvHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i4jQQ0r+q/iMcyADPRKr57TFn3ppjge9Ss+Fb2Y7YXdZezuXz5JWPgjdUNzTQr5hdR
         UHA7bpG5i/kMTukvOo3iaxs48fGUBwkqWPvHs55i0wa8xfy71yvF56UNsAMoN8bZmjFh
         v8WDmwfzT/Fky6FTzAmdqZcYVrIVIL7yVxQu4=
Received: by 10.213.37.199 with SMTP id y7mr2954397ebd.18.1263591102598;
        Fri, 15 Jan 2010 13:31:42 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 14sm693163ewy.3.2010.01.15.13.31.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:31:42 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137128>

fork() is only available on POSIX, so to support git-daemon
on Windows we have to use something else. Conveniently
enough, we have an API for async operation already.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   87 +++++++++++++++++++++++++++++++------------------------------
 1 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/daemon.c b/daemon.c
index b42792f..2d63cbc 100644
--- a/daemon.c
+++ b/daemon.c
@@ -583,17 +583,17 @@ static unsigned int live_children;
 
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
@@ -602,19 +602,6 @@ static void add_child(pid_t pid, struct sockaddr *addr, int addrlen)
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
@@ -623,14 +610,14 @@ static void remove_child(pid_t pid)
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
@@ -640,19 +627,26 @@ static void check_dead_children(void)
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
-	int fd[2];
-	pid_t pid;
+	struct child_process cld = { 0 };
 
 	if (max_connections && live_children >= max_connections) {
 		kill_some_child();
@@ -665,20 +659,15 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
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
 
-	fd[0] = incoming;
-	fd[1] = dup(incoming);
-	exit(execute(fd, addr));
+	if (start_command(&cld))
+		logerror("unable to fork");
+	else
+		add_child(&cld, addr, addrlen);
+	close(incoming);
 }
 
 static void child_handler(int signo)
@@ -934,7 +923,7 @@ int main(int argc, char **argv)
 {
 	int listen_port = 0;
 	char *listen_addr = NULL;
-	int inetd_mode = 0;
+	int serve_mode = 0, inetd_mode = 0;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
 	struct passwd *pass = NULL;
@@ -960,7 +949,12 @@ int main(int argc, char **argv)
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
@@ -1104,13 +1098,13 @@ int main(int argc, char **argv)
 		die("base-path '%s' does not exist or is not a directory",
 		    base_path);
 
-	if (inetd_mode) {
+	if (serve_mode) {
 		int fd[2] = { 0, 1 };
 		struct sockaddr_storage ss;
 		struct sockaddr *peer = (struct sockaddr *)&ss;
 		socklen_t slen = sizeof(ss);
 
-		if (!freopen("/dev/null", "w", stderr))
+		if (inetd_mode && !freopen("/dev/null", "w", stderr))
 			die_errno("failed to redirect stderr to /dev/null");
 
 		if (getpeername(0, peer, &slen))
@@ -1129,5 +1123,12 @@ int main(int argc, char **argv)
 	if (pid_file)
 		store_pid(pid_file);
 
+	/* prepare argv for serving-processes */
+	cld_argv = xmalloc(sizeof (char *) * (argc + 2));
+	for (i = 0; i < argc; ++i)
+		cld_argv[i] = argv[i];
+	cld_argv[argc] = "--serve";
+	cld_argv[argc+1] = NULL;
+
 	return serve(listen_addr, listen_port, pass, gid);
 }
-- 
1.6.6.211.g26720
