From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 07/15] daemon: use run-command api for async serving
Date: Fri, 22 Oct 2010 02:05:36 +0200
Message-ID: <1287705944-5668-7-git-send-email-kusmabite@gmail.com>
References: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCUq4PmBBoE5i_m8A@googlegroups.com Fri Oct 22 02:07:12 2010
Return-path: <msysgit+bncCOPdven-DxCUq4PmBBoE5i_m8A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCUq4PmBBoE5i_m8A@googlegroups.com>)
	id 1P95A4-0004SK-GE
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:07:08 +0200
Received: by mail-wy0-f186.google.com with SMTP id 11sf128526wyi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=Z5yDCAnbJpbMEwMJxMzAuDWS+s0V5y/6eSL6ZoVKB6Y=;
        b=0B/YJp9+T6ZhJSr3jAScUtM6SDMRsZaSpNkH3c1+wYmsELD3fppHbP1dVL0Qi5Izcw
         vovHVjCSN9oIB5bfoX5RKxiOYhwa/FARlxG68ILkaKlEe8r86YDSv2WeMrznWiBFUsb4
         Dx8w7vFTpo8VeqmanujmvToQGB2wXzzvjIYP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=Wsy4E6+vnPolAEakLUHHMnBDso2QlwAO7psC20kULHmTrkn+viWu2+E+e2etvxeEKu
         BbShmSIJe4bM6PgX1P2AraoBpYukBSN061WMYGxOv+hrhirUAqF1BluR8CovL5krmcaB
         RWyeKC0oUJ8G3X9BoLYGVw8KVEy+3R4lQVu0Q=
Received: by 10.216.162.6 with SMTP id x6mr15690wek.0.1287706004507;
        Thu, 21 Oct 2010 17:06:44 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.24.73 with SMTP id w49ls268189eew.4.p; Thu, 21 Oct 2010
 17:06:43 -0700 (PDT)
Received: by 10.14.120.200 with SMTP id p48mr172663eeh.13.1287706003644;
        Thu, 21 Oct 2010 17:06:43 -0700 (PDT)
Received: by 10.14.120.200 with SMTP id p48mr172662eeh.13.1287706003593;
        Thu, 21 Oct 2010 17:06:43 -0700 (PDT)
Received: from mail-ey0-f175.google.com (mail-ey0-f175.google.com [209.85.215.175])
        by gmr-mx.google.com with ESMTP id t3si505662eeh.3.2010.10.21.17.06.42;
        Thu, 21 Oct 2010 17:06:42 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.175 as permitted sender) client-ip=209.85.215.175;
Received: by eya28 with SMTP id 28so155774eya.34
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:06:42 -0700 (PDT)
Received: by 10.213.12.199 with SMTP id y7mr2499853eby.74.1287706002434;
        Thu, 21 Oct 2010 17:06:42 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id x54sm2455602eeh.11.2010.10.21.17.06.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:06:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287705944-5668-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.175 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159599>

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
index d594375..11a5e06 100644
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
1.7.3.1.199.g72340
