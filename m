From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 08/11] daemon: use explicit file descriptor
Date: Thu, 26 Nov 2009 00:44:17 +0000
Message-ID: <1259196260-3064-9-git-send-email-kusmabite@gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-4-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-5-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-6-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-7-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-8-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:45:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSTl-0001E4-Tt
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbZKZAov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbZKZAou
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:44:50 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:40313 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965085AbZKZAos (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:44:48 -0500
Received: by ey-out-2122.google.com with SMTP id 4so88193eyf.19
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jRVU8Iy65vmnHfFL9lRZeN37bmO8TwL0o/+zmFqSB60=;
        b=wN8olsKDLh840R6y0Mrlgg8dD3bAzeNZgLY9uEpgL9nmxSqYtbVipSc7/MLXPtYF9X
         9J7b3GIW1KkYTB12Uiori75lBczkFLHGVPBnlSlridKpCEX5ngwizPlCwfu6rWFBW1NV
         sOpudV8F0CgUqIiIOpGrMpAW0k/ua1U6ObYOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pOIR08CtXp1SpNCaNLnzktJmo05jkzKm4wUnx2Ia8parDeGvZk7sD8qOJLl38uScix
         VUkzfGRA2l7PhTbdod0pKufOl/gIHzF1Kx4RwwvVbVVYqhfTe2EQBVNKO0ve6+kdKSFy
         RVIWXQkdQcL44eotP971EDTn/ihsSkRc5GqPE=
Received: by 10.213.102.129 with SMTP id g1mr1618048ebo.41.1259196294763;
        Wed, 25 Nov 2009 16:44:54 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 28sm393876eyg.4.2009.11.25.16.44.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:44:54 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259196260-3064-8-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133739>

This patch adds support to specify an explicit file
descriotor for communication with the client, instead
of using stdin/stdout.

This will be useful for the Windows port, because it
will use threads instead of fork() to serve multiple
clients, making it impossible to reuse stdin/stdout.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/daemon.c b/daemon.c
index 07d7356..a0aead5 100644
--- a/daemon.c
+++ b/daemon.c
@@ -263,7 +263,7 @@ static char *path_ok(char *directory)
 	return NULL;		/* Fallthrough. Deny by default */
 }
 
-typedef int (*daemon_service_fn)(void);
+typedef int (*daemon_service_fn)(int);
 struct daemon_service {
 	const char *name;
 	const char *config_name;
@@ -287,7 +287,7 @@ static int git_daemon_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-static int run_service(char *dir, struct daemon_service *service)
+static int run_service(int fd, char *dir, struct daemon_service *service)
 {
 	const char *path;
 	int enabled = service->enabled;
@@ -340,7 +340,7 @@ static int run_service(char *dir, struct daemon_service *service)
 	 */
 	signal(SIGTERM, SIG_IGN);
 
-	return service->fn();
+	return service->fn(fd);
 }
 
 static void copy_to_log(int fd)
@@ -364,7 +364,7 @@ static void copy_to_log(int fd)
 	fclose(fp);
 }
 
-static int run_service_command(const char **argv)
+static int run_service_command(int fd, const char **argv)
 {
 	struct child_process cld;
 
@@ -372,37 +372,35 @@ static int run_service_command(const char **argv)
 	cld.argv = argv;
 	cld.git_cmd = 1;
 	cld.err = -1;
+	cld.in = cld.out = fd;
 	if (start_command(&cld))
 		return -1;
 
-	close(0);
-	close(1);
-
 	copy_to_log(cld.err);
 
 	return finish_command(&cld);
 }
 
-static int upload_pack(void)
+static int upload_pack(int fd)
 {
 	/* Timeout as string */
 	char timeout_buf[64];
 	const char *argv[] = { "upload-pack", "--strict", timeout_buf, ".", NULL };
 
 	snprintf(timeout_buf, sizeof timeout_buf, "--timeout=%u", timeout);
-	return run_service_command(argv);
+	return run_service_command(fd, argv);
 }
 
-static int upload_archive(void)
+static int upload_archive(int fd)
 {
 	static const char *argv[] = { "upload-archive", ".", NULL };
-	return run_service_command(argv);
+	return run_service_command(fd, argv);
 }
 
-static int receive_pack(void)
+static int receive_pack(int fd)
 {
 	static const char *argv[] = { "receive-pack", ".", NULL };
-	return run_service_command(argv);
+	return run_service_command(fd, argv);
 }
 
 static struct daemon_service daemon_service[] = {
@@ -532,7 +530,7 @@ static void parse_host_arg(char *extra_args, int buflen)
 }
 
 
-static int execute(struct sockaddr *addr)
+static int execute(int fd, struct sockaddr *addr)
 {
 	static char line[1000];
 	int pktlen, len, i;
@@ -565,7 +563,7 @@ static int execute(struct sockaddr *addr)
 	}
 
 	alarm(init_timeout ? init_timeout : timeout);
-	pktlen = packet_read_line(0, line, sizeof(line));
+	pktlen = packet_read_line(fd, line, sizeof(line));
 	alarm(0);
 
 	len = strlen(line);
@@ -597,7 +595,7 @@ static int execute(struct sockaddr *addr)
 			 * Note: The directory here is probably context sensitive,
 			 * and might depend on the actual service being performed.
 			 */
-			return run_service(line + namelen + 5, s);
+			return run_service(fd, line + namelen + 5, s);
 		}
 	}
 
@@ -713,7 +711,7 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
 	dup2(incoming, 1);
 	close(incoming);
 
-	exit(execute(addr));
+	exit(execute(0, addr));
 }
 
 static void child_handler(int signo)
@@ -1150,7 +1148,7 @@ int main(int argc, char **argv)
 		if (getpeername(0, peer, &slen))
 			peer = NULL;
 
-		return execute(peer);
+		return execute(0, peer);
 	}
 
 	if (detach) {
-- 
1.6.5.rc2.7.g4f8d3
