From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v5 08/16] daemon: use run-command api for async serving
Date: Fri, 22 Oct 2010 02:35:19 +0200
Message-ID: <1287707727-5780-9-git-send-email-kusmabite@gmail.com>
References: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: msysgit@googlegroups.com,
	j6t@kdbg.org,
	avarab@gmail.com,
	sunshine@sunshineco.com,
	jrnieder@gmail.com,
	schwab@linux-m68k.org,
	patthoyts@gmail.com
To: git@vger.kernel.org
X-From: msysgit+bncCOPdven-DxCSuYPmBBoERap_LQ@googlegroups.com Fri Oct 22 02:36:58 2010
Return-path: <msysgit+bncCOPdven-DxCSuYPmBBoERap_LQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCSuYPmBBoERap_LQ@googlegroups.com>)
	id 1P95cw-0002V4-LZ
	for gcvm-msysgit@m.gmane.org; Fri, 22 Oct 2010 02:36:58 +0200
Received: by mail-wy0-f186.google.com with SMTP id 11sf139996wyi.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 21 Oct 2010 17:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=g/GGWpqbHMT3N3FHskOJ+Z5nw+U02Tqovcac8gAlL/o=;
        b=TYmdUh2CekZ3mzFujKWJqt/Jhs0MZY69u7YC5SUmES9LW9ds3/31iQa0M6RFx+Ybr0
         o/teQbBAGOeTkz4vIZkq7JNv5bw6HlLAGkDpZ0ExJnUsFtKO8wlebgeQ4+kSw6mpkGE8
         Z2n75PW7iXSGKXtKBob9BMU6hNAeqzSHLNJ/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        b=2y1FE1JzY9z5tH/Qv+k+Mmn2uBKT81FTPfyM4ExdFBENp5BYtTZtluWnVmsckYaqZn
         s/hxucvgNTCtFo9DVvz9MHRaTQv8wnxxZQETmcidPnslru2sp3rhY1Zc80stwYkDRcxV
         o7LH2LY+BIlP3FJQcef9oe/CJ5XXeP1nPJ6zM=
Received: by 10.216.72.142 with SMTP id t14mr235691wed.18.1287707794377;
        Thu, 21 Oct 2010 17:36:34 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.123.10 with SMTP id u10ls269732eeh.2.p; Thu, 21 Oct 2010
 17:36:33 -0700 (PDT)
Received: by 10.14.2.211 with SMTP id 59mr174381eef.28.1287707793449;
        Thu, 21 Oct 2010 17:36:33 -0700 (PDT)
Received: by 10.14.2.211 with SMTP id 59mr174379eef.28.1287707793413;
        Thu, 21 Oct 2010 17:36:33 -0700 (PDT)
Received: from mail-ew0-f54.google.com (mail-ew0-f54.google.com [209.85.215.54])
        by gmr-mx.google.com with ESMTP id q11si1454863eeh.0.2010.10.21.17.36.32;
        Thu, 21 Oct 2010 17:36:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.215.54 as permitted sender) client-ip=209.85.215.54;
Received: by ewy28 with SMTP id 28so218036ewy.27
        for <msysgit@googlegroups.com>; Thu, 21 Oct 2010 17:36:32 -0700 (PDT)
Received: by 10.213.28.205 with SMTP id n13mr8859888ebc.5.1287707792278;
        Thu, 21 Oct 2010 17:36:32 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v56sm2483302eeh.20.2010.10.21.17.36.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 17:36:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1287707727-5780-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.215.54 as permitted sender)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159619>

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
index d594375..c7b7976 100644
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
+		if ((pid = waitpid(blanket->cld.pid, &status, WNOHANG)) > 0) {
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
