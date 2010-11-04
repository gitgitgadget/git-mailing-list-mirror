From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v7 08/16] daemon: use run-command api for async serving
Date: Thu,  4 Nov 2010 02:35:16 +0100
Message-ID: <1288834524-2400-9-git-send-email-kusmabite@gmail.com>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 02:35:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDok3-00013V-80
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab0KDBfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 21:35:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40076 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab0KDBfo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:35:44 -0400
Received: by mail-ey0-f174.google.com with SMTP id 27so722320eye.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=z/wiNZ0jqxtau1HxlM/mAV0OF2cxh5Q1CGQbCWYKX8I=;
        b=hxlqlN4Ra+qw5QglPLW94cGe8NUK/T8Alx+lG/Psk7yRNNeIoriTdGOJJu0owPNJDT
         nvKrkBPLNeajQhdLFjyxUPRLaOH+qmONrKuvWGZPzZkqjDuAFBSaIkzMr34PD9NYSQtS
         ngTBIdvmYePbBH/zegxRu3WyFYK30VFNI8N5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TGfwHOzyGCXJ3h4aAWuT0oir1Lbls29KP81jAuRlPMSxGQ20KPGSupx9rYoBHspwPg
         XL4hNwHxqgzA08C8lUuzI3WL9iM0Y1zAQM4j75MJ2wyQopxu5mtm+IfdUsWDZK1iujiy
         H5ZWHSuUZP0OBaAue1UlQbt6hZ2cZgDdyKnw0=
Received: by 10.14.124.201 with SMTP id x49mr49639eeh.7.1288834543524;
        Wed, 03 Nov 2010 18:35:43 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id q58sm7188016eeh.9.2010.11.03.18.35.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 18:35:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160669>

fork() is only available on POSIX, so to support git-daemon
on Windows we have to use something else.

Instead we invent the flag --serve, which is a stripped down
version of --inetd-mode. We use start_command() to call
git-daemon with this flag appended to serve clients.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   93 +++++++++++++++++++++++++++++++------------------------------
 1 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/daemon.c b/daemon.c
index 535ae88..4059593 100644
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
@@ -1162,17 +1154,19 @@ int main(int argc, char **argv)
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
-			peer = NULL;
-
-		return execute(peer);
+			return execute(NULL);
+		else
+			return execute(peer);
 	}
 
 	if (detach) {
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
1.7.3.2.162.g09d37
