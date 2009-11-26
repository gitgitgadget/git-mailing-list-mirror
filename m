From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 09/11] daemon: use run-command api for async serving
Date: Thu, 26 Nov 2009 00:39:16 +0000
Message-ID: <1259195958-2372-10-git-send-email-kusmabite@gmail.com>
References: <1259195958-2372-1-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-2-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-3-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-4-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-5-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-6-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-7-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-8-git-send-email-kusmabite@gmail.com>
 <1259195958-2372-9-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlecode.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:40:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSP9-00080M-7b
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbZKZAkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbZKZAkA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:40:00 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41835 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965031AbZKZAj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:39:59 -0500
Received: by mail-ew0-f219.google.com with SMTP id 19so295613ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=n9gO4kbd2inIZ4YwUOFvcFefIOZ73LP66GaKgDo9y6o=;
        b=Hh75TxgT7vPteTZda+kjYJ95NW9zjpL6WnXLPqLLGxfMa2zRhcmzXrMKq1IfRqSn8P
         2oG6s5HjjNV7RdfSdWVZzvvKQPZWb20Bl1vq8eyD8PZ4lnI4zICcN8Udkhhnsu67V2/U
         /QZI7gvioNIulAS5AkuhdBUt51ZFFa5CW/BHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bZbt5JzckZqWlvWGl/yJnMdxOAG4qw/ZVAV1+vR2PMqJJfc7jF/HXDUPW4Mnp+ymHA
         ZF2Bu4BNio1WmvobBDSk3pfcEkh/BSEN5qkEL+egrbzV2zyiQoYW3ItvGq0Gdi74Ruqr
         1p7xXEWCHz+gGBOaaPdCFXmdjmFD2hn/tUCgs=
Received: by 10.213.24.1 with SMTP id t1mr3167758ebb.64.1259196005480;
        Wed, 25 Nov 2009 16:40:05 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 23sm388179eya.11.2009.11.25.16.40.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:40:04 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259195958-2372-9-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133727>

fork() is only available on POSIX, so to support git-daemon
on Windows we have to use something else. Conveniently
enough, we have an API for async operation already.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 daemon.c |   79 ++++++++++++++++++++++++++++---------------------------------
 1 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/daemon.c b/daemon.c
index a0aead5..1b0e290 100644
--- a/daemon.c
+++ b/daemon.c
@@ -372,7 +372,8 @@ static int run_service_command(int fd, const char **argv)
 	cld.argv = argv;
 	cld.git_cmd = 1;
 	cld.err = -1;
-	cld.in = cld.out = fd;
+	cld.in = dup(fd);
+	cld.out = fd;
 	if (start_command(&cld))
 		return -1;
 
@@ -609,11 +610,11 @@ static unsigned int live_children;
 
 static struct child {
 	struct child *next;
-	pid_t pid;
+	struct async async;
 	struct sockaddr_storage address;
 } *firstborn;
 
-static void add_child(pid_t pid, struct sockaddr *addr, int addrlen)
+static void add_child(struct async *async, struct sockaddr *addr, int addrlen)
 {
 	struct child *newborn, **cradle;
 
@@ -623,7 +624,7 @@ static void add_child(pid_t pid, struct sockaddr *addr, int addrlen)
 	 */
 	newborn = xcalloc(1, sizeof(*newborn));
 	live_children++;
-	newborn->pid = pid;
+	memcpy(&newborn->async, async, sizeof(struct async));
 	memcpy(&newborn->address, addr, addrlen);
 	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
 		if (!memcmp(&(*cradle)->address, &newborn->address,
@@ -633,19 +634,6 @@ static void add_child(pid_t pid, struct sockaddr *addr, int addrlen)
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
@@ -654,7 +642,7 @@ static void remove_child(pid_t pid)
  */
 static void kill_some_child(void)
 {
-	const struct child *blanket, *next;
+	struct child *blanket, *next;
 
 	if (!(blanket = firstborn))
 		return;
@@ -662,28 +650,37 @@ static void kill_some_child(void)
 	for (; (next = blanket->next); blanket = next)
 		if (!memcmp(&blanket->address, &next->address,
 			    sizeof(next->address))) {
-			kill(blanket->pid, SIGTERM);
+			kill_async(&blanket->async);
 			break;
 		}
 }
 
 static void check_dead_children(void)
 {
-	int status;
-	pid_t pid;
-
-	while ((pid = waitpid(-1, &status, WNOHANG)) > 0) {
-		const char *dead = "";
-		remove_child(pid);
-		if (!WIFEXITED(status) || (WEXITSTATUS(status) > 0))
-			dead = " (with error)";
-		loginfo("[%"PRIuMAX"] Disconnected%s", (uintmax_t)pid, dead);
-	}
+	struct child **cradle, *blanket;
+	for (cradle = &firstborn; (blanket = *cradle);)
+		if (!is_async_alive(&blanket->async)) {
+			*cradle = blanket->next;
+			loginfo("Disconnected\n");
+			live_children--;
+			close(blanket->async.out);
+			free(blanket);
+		} else
+			cradle = &blanket->next;
+}
+
+int async_execute(int fd, void *data)
+{
+	int ret = execute(fd, data);
+	close(fd);
+	free(data);
+	return ret;
 }
 
 static void handle(int incoming, struct sockaddr *addr, int addrlen)
 {
-	pid_t pid;
+	struct sockaddr_storage *ss;
+	struct async async = { 0 };
 
 	if (max_connections && live_children >= max_connections) {
 		kill_some_child();
@@ -696,22 +693,18 @@ static void handle(int incoming, struct sockaddr *addr, int addrlen)
 		}
 	}
 
-	if ((pid = fork())) {
-		close(incoming);
-		if (pid < 0) {
-			logerror("Couldn't fork %s", strerror(errno));
-			return;
-		}
+	ss = xmalloc(sizeof(*ss));
+	memcpy(ss, addr, addrlen);
 
-		add_child(pid, addr, addrlen);
-		return;
-	}
+	async.proc = async_execute;
+	async.data = ss;
+	async.out = incoming;
 
-	dup2(incoming, 0);
-	dup2(incoming, 1);
+	if (start_async(&async))
+		logerror("unable to fork");
+	else
+		add_child(&async, addr, addrlen);
 	close(incoming);
-
-	exit(execute(0, addr));
 }
 
 static void child_handler(int signo)
-- 
1.6.5.rc2.7.g4f8d3
