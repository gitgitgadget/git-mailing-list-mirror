From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 08/14] daemon: use explicit file descriptor
Date: Fri, 15 Jan 2010 22:30:27 +0100
Message-ID: <1263591033-4992-9-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, j6t@kdbg.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Jan 15 22:31:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtlk-0005nP-61
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 22:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758396Ab0AOVbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 16:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757752Ab0AOVbi
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 16:31:38 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:26410 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab0AOVbh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 16:31:37 -0500
Received: by ey-out-2122.google.com with SMTP id d26so192529eyd.19
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 13:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=gKkDqv3bXAgqO5K+fWCPHzqpzxjX6X8gbvCdZ2Rvusk=;
        b=QKBb8PjnOdzy0s/kEGdgIm+GnaEvFqqleHEVSvD9jg0CpAUgXh2cZ4LAIr770aSyGh
         KExKpO440farj5pUvl7VCkLFYKjAKrZ4zdoykIXyPv85v2Zl+h4cj5RZh3TMhszz5SOe
         xLijKKbm4mKMaz2gKwybJUSUOw8vmErxDW0hY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BsiCwDTPb2phhzPEGj14sfFjjeqjRdG1E5OswYB/uS+AKvpk4GiXttfXioowtOFDMk
         nha5fIi94pozhPxJW1ixmpoF86wsOvdvFRQRpzF332HEG9R2B0UxHGX6T+2MNlrbc5nr
         vU77ZZkjeQ323mu+u60E/A0tH0D79r7gtmoqk=
Received: by 10.213.25.83 with SMTP id y19mr405514ebb.78.1263591096149;
        Fri, 15 Jan 2010 13:31:36 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 16sm1810980ewy.2.2010.01.15.13.31.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:31:35 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137127>

This patch adds support to specify an explicit file
descriotor for communication with the client, instead
of using stdin/stdout.

This will be useful for the Windows port, because it
will use threads instead of fork() to serve multiple
clients, making it impossible to reuse stdin/stdout.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   43 +++++++++++++++++++++----------------------
 1 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/daemon.c b/daemon.c
index 79ba1aa..b42792f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -218,7 +218,7 @@ static char *path_ok(char *directory)
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
-typedef int (*daemon_service_fn)(void);
+typedef int (*daemon_service_fn)(int [2]);
 struct daemon_service {
 	const char *name;
 	const char *config_name;
@@ -242,7 +242,7 @@ static int git_daemon_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static int run_service(char *dir, struct daemon_service *service)
+static int run_service(int fd[2], char *dir, struct daemon_service *service)
 {
 	const char *path;
 	int enabled = service->enabled;
@@ -295,7 +295,7 @@ static int run_service(char *dir, struct daemon_service *service)
 	 */
 	signal(SIGTERM, SIG_IGN);
 
-	return service->fn();
+	return service->fn(fd);
 }
 
 static void copy_to_log(int fd)
@@ -319,7 +319,7 @@ static void copy_to_log(int fd)
 	fclose(fp);
 }
 
-static int run_service_command(const char **argv)
+static int run_service_command(int fd[2], const char **argv)
 {
 	struct child_process cld;
 
@@ -327,37 +327,36 @@ static int run_service_command(const char **argv)
 	cld.argv = argv;
 	cld.git_cmd = 1;
 	cld.err = -1;
+	cld.in = fd[0];
+	cld.out = fd[1];
 	if (start_command(&cld))
 		return -1;
 
-	close(0);
-	close(1);
-
 	copy_to_log(cld.err);
 
 	return finish_command(&cld);
 }
 
-static int upload_pack(void)
+static int upload_pack(int fd[2])
 {
 	/* Timeout as string */
 	char timeout_buf[64];
 	const char *argv[] = { "upload-pack", "--strict", timeout_buf, ".", NULL };
 
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
-	return run_service_command(argv);
+	return run_service_command(fd, argv);
 }
 
-static int upload_archive(void)
+static int upload_archive(int fd[2])
 {
 	static const char *argv[] = { "upload-archive", ".", NULL };
-	return run_service_command(argv);
+	return run_service_command(fd, argv);
 }
 
-static int receive_pack(void)
+static int receive_pack(int fd[2])
 {
 	static const char *argv[] = { "receive-pack", ".", NULL };
-	return run_service_command(argv);
+	return run_service_command(fd, argv);
 }
 
 static struct daemon_service daemon_service[] = {
@@ -487,7 +486,7 @@ static void parse_host_arg(char *extra_args, int buflen)
 }
 
 
-static int execute(struct sockaddr *addr)
+static int execute(int fd[2], struct sockaddr *addr)
 {
 	static char line[1000];
 	int pktlen, len, i;
@@ -520,7 +519,7 @@ static int execute(struct sockaddr *addr)
 	}
 
 	alarm(init_timeout ? init_timeout : timeout);
-	pktlen = packet_read_line(0, line, sizeof(line));
+	pktlen = packet_read_line(fd[0], line, sizeof(line));
 	alarm(0);
 
 	len = strlen(line);
@@ -552,7 +551,7 @@ static int execute(struct sockaddr *addr)
 			 * Note: The directory here is probably context sensitive,
 			 * and might depend on the actual service being performed.
 			 */
-			return run_service(line + namelen + 5, s);
+			return run_service(fd, line + namelen + 5, s);
 		}
 	}
 
@@ -652,6 +651,7 @@ static void check_dead_children(void)
 
 static void handle(int incoming, struct sockaddr *addr, int addrlen)
 {
+	int fd[2];
 	pid_t pid;
 
 	if (max_connections && live_children >= max_connections) {
@@ -676,11 +676,9 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
 		return;
 	}
 
-	dup2(incoming, 0);
-	dup2(incoming, 1);
-	close(incoming);
-
-	exit(execute(addr));
+	fd[0] = incoming;
+	fd[1] = dup(incoming);
+	exit(execute(fd, addr));
 }
 
 static void child_handler(int signo)
@@ -1107,6 +1105,7 @@ int main(int argc, char **argv)
 		    base_path);
 
 	if (inetd_mode) {
+		int fd[2] = { 0, 1 };
 		struct sockaddr_storage ss;
 		struct sockaddr *peer = (struct sockaddr *)&ss;
 		socklen_t slen = sizeof(ss);
@@ -1117,7 +1116,7 @@ int main(int argc, char **argv)
 		if (getpeername(0, peer, &slen))
 			peer = NULL;
 
-		return execute(peer);
+		return execute(fd, peer);
 	}
 
 	if (detach) {
-- 
1.6.6.211.g26720
