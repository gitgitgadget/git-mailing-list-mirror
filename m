From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v6 08/16] daemon: use run-command api for async serving
Date: Wed,  3 Nov 2010 17:31:26 +0100
Message-ID: <1288801894-1168-9-git-send-email-kusmabite@gmail.com>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 03 17:32:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDgGT-0002aC-DB
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 17:32:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab0KCQcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 12:32:06 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37501 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895Ab0KCQcE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 12:32:04 -0400
Received: by mail-ew0-f46.google.com with SMTP id 7so391724ewy.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 09:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4seIQibZHXWeSKuG3TYXt5M7Eh/K/g4yGMw3YfC5xVs=;
        b=FFvotSUZ6m3s11BnvuHU+pHLOlcLgP6ptMwLdib2oji8EC1Un+FiSR6OSGspfwp7FY
         uAgMooA5szhf3FCPm/aOjdRWeSdKZalvNcaRLjc4+hF7vJRWNboRQ2VpPqwQxcjrPZMf
         Uh1kk83ajwGDHu/bn/uFjSzn4BarGSwGrVgvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WJMSqCdnQkIKaLZ5m4wTJhvKdyI+w1ozudWNeD2QU16f2ZZKzmsLnWem+2EQMb7Tx7
         UF/GjD4R3nawDbfeTEXIuuK8rgFVnFuuG5MeRrlylX2zepyklnHht2z/8mZtx8uySzH3
         Nq1g4aZ46E+oi3xgR/HISXz/p5yuMUvShVO2Y=
Received: by 10.213.112.202 with SMTP id x10mr4658153ebp.81.1288801923747;
        Wed, 03 Nov 2010 09:32:03 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id x54sm6720152eeh.23.2010.11.03.09.32.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 09:32:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.msysgit.0.2.g22c0a
In-Reply-To: <1288801894-1168-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160621>

fork() is only available on POSIX, so to support git-daemon
on Windows we have to use something else.

Instead we invent the flag --serve, which is a stripped down
version of --inetd-mode. We use start_command() to call
git-daemon with this flag appended to serve clients.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   87 +++++++++++++++++++++++++++++++------------------------------
 1 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/daemon.c b/daemon.c
index 535ae88..6eee570 100644
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
@@ -661,7 +648,7 @@ static void kill_some_child(void)
 
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
 
+static char **cld_argv;
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
@@ -1017,6 +1005,10 @@ int main(int argc, char **argv)
 				continue;
 			}
 		}
+		if (!strcmp(arg, "--serve")) {
+			serve_mode = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--inetd")) {
 			inetd_mode = 1;
 			log_syslog = 1;
@@ -1162,13 +1154,15 @@ int main(int argc, char **argv)
 		    base_path);
 
 	if (inetd_mode) {
+		if (!freopen("/dev/null", "w", stderr))
+			die_errno("failed to redirect stderr to /dev/null");
+	}
+
+	if (inetd_mode || serve_mode) {
 		struct sockaddr_storage ss;
 		struct sockaddr *peer = (struct sockaddr *)&ss;
 		socklen_t slen = sizeof(ss);
 
-		if (!freopen("/dev/null", "w", stderr))
-			die_errno("failed to redirect stderr to /dev/null");
-
 		if (getpeername(0, peer, &slen))
 			peer = NULL;
 
@@ -1185,5 +1179,12 @@ int main(int argc, char **argv)
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
1.7.3.2.161.gd6e00
