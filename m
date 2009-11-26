From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 09/11] daemon: use run-command api for async 
	serving
Date: Thu, 26 Nov 2009 00:44:18 +0000
Message-ID: <1259196260-3064-10-git-send-email-kusmabite@gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-4-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-5-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-6-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-7-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-8-git-send-email-kusmabite@gmail.com>
 <1259196260-3064-9-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: git@vger.kernel.org, dotzenlabs@gmail.com, Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: 3js8NSwkOB7YgqoiWXepackkchaiWeh.Ykiiouocepckkchacnkqlo.Yki@listserv.bounces.google.com Thu Nov 26 01:45:22 2009
Return-path: <3js8NSwkOB7YgqoiWXepackkchaiWeh.Ykiiouocepckkchacnkqlo.Yki@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f141.google.com ([209.85.210.141])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSU5-0001My-JP
	for gcvm-msysgit@m.gmane.org; Thu, 26 Nov 2009 01:45:21 +0100
Received: by yxe5 with SMTP id 5sf443468yxe.24
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Nov 2009 16:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:x-thread-url:x-message-url
         :list-unsubscribe:list-subscribe;
        bh=n9gO4kbd2inIZ4YwUOFvcFefIOZ73LP66GaKgDo9y6o=;
        b=Im8Ahw5d3u1u4EUw/zyKcPmVTuD+J0lLIHGHzMLpGs52tOE75OnnNtLg5aS1lcuW7U
         KSu3kUlViBA1bgbH8XGrXI3AP6oaZEignWjDrITkaSl+kbCleMiMg7AH0vIGP7PIes1g
         y90UDcpE3QbsxEVuZA3bFZuHpP6WjKX7ciEdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:x-thread-url:x-message-url
         :list-unsubscribe:list-subscribe;
        b=k8SZOsWZrstx6r+dEbHUC6mJgEc0GwVnVWgOzDKpdsOSKnQrVbI2hYkmaLfsUMwx0/
         /KtMyNhbDz3+Ydn7AphELI45rXVexwqwen3NlJzHSgNe+LLOXi5xXLhiuJLcf5REea8W
         IYIjxU5CC2ZO41Mn/fj/G/L8JsyO3p5rWZpsk=
Received: by 10.91.164.38 with SMTP id r38mr589458ago.5.1259196302778;
        Wed, 25 Nov 2009 16:45:02 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.104.96 with SMTP id n32ls60266ebo.1.p; Wed, 25 Nov 2009 
	16:45:01 -0800 (PST)
Received: by 10.213.24.20 with SMTP id t20mr1188566ebb.18.1259196301098;
        Wed, 25 Nov 2009 16:45:01 -0800 (PST)
Received: by 10.213.24.20 with SMTP id t20mr1188565ebb.18.1259196301073;
        Wed, 25 Nov 2009 16:45:01 -0800 (PST)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com [209.85.219.215])
        by gmr-mx.google.com with ESMTP id 12si19175ewy.2.2009.11.25.16.45.00;
        Wed, 25 Nov 2009 16:45:00 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.215 as permitted sender) client-ip=209.85.219.215;
Received: by mail-ew0-f215.google.com with SMTP id 7so308594ewy.28
        for <msysgit@googlegroups.com>; Wed, 25 Nov 2009 16:45:00 -0800 (PST)
Received: by 10.216.93.68 with SMTP id k46mr217792wef.161.1259196299955;
        Wed, 25 Nov 2009 16:44:59 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 28sm3853043eye.9.2009.11.25.16.44.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:44:59 -0800 (PST)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1259196260-3064-9-git-send-email-kusmabite@gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.219.215 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/15f3dd983aa85143
X-Message-Url: http://groups.google.com/group/msysgit/msg/e5790dd619dd6c60
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133740>

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
