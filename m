From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Fri, 15 Jan 2010 22:30:32 +0100
Message-ID: <1263591033-4992-14-git-send-email-kusmabite@gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Cc: git@vger.kernel.org,
	j6t@kdbg.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: 32t5QSwkOB1U7HF9xy5G13BB3819x58.zB99FLF35G3BB3813EBHCF.zB9@listserv.bounces.google.com Fri Jan 15 22:32:32 2010
Return-path: <32t5QSwkOB1U7HF9xy5G13BB3819x58.zB99FLF35G3BB3813EBHCF.zB9@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f137.google.com ([209.85.210.137])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtmN-00061S-Lj
	for gcvm-msysgit@m.gmane.org; Fri, 15 Jan 2010 22:32:27 +0100
Received: by mail-yx0-f137.google.com with SMTP id 1sf1972493yxe.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 15 Jan 2010 13:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:mime-version:x-beenthere:received
         :received:received:received:received-spf:received:received:received
         :from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        bh=UQnrmYX9DlLHM2LzJ9/px5PLgrWpkpoplfK6wrCQ8K8=;
        b=64lJeTwCEUt9YbeRsRhpl1P3Io9TA4jLMiDP4ozKxeVc2gwpzTjauluPL1hs2vudBh
         ru801sFf6cuEIjkjGzL+XecxCtlVC392EyUxGtI9J5mjIH6AZbevzIXag7IfaVoBHVl4
         9enKAzqa99AjZ3YUPbTmFWXeFcuADKQ9fk16E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=mime-version:x-beenthere:received-spf:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe;
        b=eDQ9Wn+sb5LGbIRhtvG25sdQb4Dh6rJwobd9Se/iXjPtaaORbO96nhVp0Jc5kgz7ON
         16rBc9yIkw+sXCTN/K/XeEifGFMUDHbcTXG1/jY9ESs+rnPmA28amT2wIPDpWOnuBiDX
         +9yX5UdNh5f5HInzgn3znCGAnFsXgUuhF6hw4=
Received: by 10.101.88.7 with SMTP id q7mr49598anl.36.1263591130929;
        Fri, 15 Jan 2010 13:32:10 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.62.209 with SMTP id y17ls59231ebh.1.p; Fri, 15 Jan 2010 
	13:32:09 -0800 (PST)
Received: by 10.213.44.1 with SMTP id y1mr362993ebe.18.1263591128966;
        Fri, 15 Jan 2010 13:32:08 -0800 (PST)
Received: by 10.213.44.1 with SMTP id y1mr362992ebe.18.1263591128937;
        Fri, 15 Jan 2010 13:32:08 -0800 (PST)
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com [209.85.219.215])
        by gmr-mx.google.com with ESMTP id 11si173538ewy.13.2010.01.15.13.32.07;
        Fri, 15 Jan 2010 13:32:07 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.215 as permitted sender) client-ip=209.85.219.215;
Received: by mail-ew0-f215.google.com with SMTP id 7so1359243ewy.10
        for <msysgit@googlegroups.com>; Fri, 15 Jan 2010 13:32:07 -0800 (PST)
Received: by 10.213.107.131 with SMTP id b3mr180386ebp.91.1263591127648;
        Fri, 15 Jan 2010 13:32:07 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 14sm695141ewy.15.2010.01.15.13.32.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:32:06 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
In-Reply-To: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.219.215 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: kusmabite@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/43ea563cecdc45de
X-Message-Url: http://groups.google.com/group/msysgit/msg/6e34a76085e5697e
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137132>

Windows doesn't have poll(), and the poll-emulation in
compat/mingw.c doesn't support checking multiple sockets.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 compat/mingw.h |    7 +++++++
 daemon.c       |   27 ++++++++++++---------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 173bec5..e515726 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -269,6 +269,13 @@ int mingw_accept(int sockfd, struct sockaddr *sa, socklen_t *sz);
 int mingw_rename(const char*, const char*);
 #define rename mingw_rename
 
+#undef FD_SET
+#define FD_SET(fd, set) do { \
+	((fd_set*)(set))->fd_array[((fd_set *)(set))->fd_count++] = _get_osfhandle(fd); \
+	} while(0)
+#undef FD_ISSET
+#define FD_ISSET(fd, set) __WSAFDIsSet(_get_osfhandle(fd), (fd_set *)(set))
+
 #if defined(USE_WIN32_MMAP) || defined(_MSC_VER)
 int mingw_getpagesize(void);
 #define getpagesize mingw_getpagesize
diff --git a/daemon.c b/daemon.c
index cdf5c72..95cf299 100644
--- a/daemon.c
+++ b/daemon.c
@@ -818,26 +818,23 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 
 static int service_loop(int socknum, int *socklist)
 {
-	struct pollfd *pfd;
-	int i;
-
-	pfd = xcalloc(socknum, sizeof(struct pollfd));
-
-	for (i = 0; i < socknum; i++) {
-		pfd[i].fd = socklist[i];
-		pfd[i].events = POLLIN;
-	}
-
 	signal(SIGCHLD, child_handler);
 
 	for (;;) {
-		int i;
+		int i, maxfd = 0;
+		fd_set fds;
 
 		check_dead_children();
 
-		if (poll(pfd, socknum, -1) < 0) {
+		FD_ZERO(&fds);
+		for (i = 0; i < socknum; i++) {
+			FD_SET(socklist[i], &fds);
+			maxfd = socklist[i] > maxfd ? socklist[i] : maxfd;
+		}
+
+		if (select(maxfd + 1, &fds, NULL, NULL, NULL) < 0) {
 			if (errno != EINTR) {
-				logerror("Poll failed, resuming: %s",
+				logerror("select() failed, resuming: %s",
 				      strerror(errno));
 				sleep(1);
 			}
@@ -845,10 +842,10 @@ static int service_loop(int socknum, int *socklist)
 		}
 
 		for (i = 0; i < socknum; i++) {
-			if (pfd[i].revents & POLLIN) {
+			if (FD_ISSET(socklist[i], &fds)) {
 				struct sockaddr_storage ss;
 				socklen_t sslen = sizeof(ss);
-				int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
+				int incoming = accept(socklist[i], (struct sockaddr *)&ss, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
 					case EAGAIN:
-- 
1.6.6.211.g26720
