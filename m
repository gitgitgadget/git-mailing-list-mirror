From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: [PATCHv4 1/2] daemon: add helper function named_sock_setup
Date: Mon, 30 Aug 2010 13:30:50 +0200
Message-ID: <1283167851-18331-2-git-send-email-alexander@sulfrian.net>
References: <7vwrr8ftjj.fsf@alter.siamese.dyndns.org>
Cc: Alexander Sulfrian <alexander@sulfrian.net>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 30 13:31:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq2a6-0001XO-V9
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 13:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317Ab0H3LbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 07:31:00 -0400
Received: from animux.de ([78.46.93.45]:55762 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754676Ab0H3La6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 07:30:58 -0400
Received: by mail.sulfrian.net (Postfix, from userid 65534)
	id C411380CC3A9; Mon, 30 Aug 2010 13:31:11 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr2 (2008-06-10) on mail.intern
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=7.0 tests=ALL_TRUSTED,AWL,
	DNS_FROM_OPENWHOIS autolearn=no version=3.2.5-gr2
Received: from laptop (unknown [87.77.143.183])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id 6269380CC38F;
	Mon, 30 Aug 2010 11:31:10 +0000 (UTC)
Received: by laptop (sSMTP sendmail emulation); Mon, 30 Aug 2010 13:30:55 +0200
X-Mailer: git-send-email 1.7.1
In-Reply-To: <7vwrr8ftjj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154789>

Add named_sock_setup as helper function for socksetup to make it
easier to create more than one listen sockets. named_sock_setup could
be called more than one time and add the new sockets to the supplied
socklist_p.

Signed-off-by: Alexander Sulfrian <alexander@sulfrian.net>
---
 daemon.c |   53 +++++++++++++++++++++++++++++++++--------------------
 1 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/daemon.c b/daemon.c
index e22a2b7..c666ced 100644
--- a/daemon.c
+++ b/daemon.c
@@ -734,11 +734,17 @@ static int set_reuse_addr(int sockfd)
 			  &on, sizeof(on));
 }
 
+struct socketlist {
+	int *list;
+	size_t nr;
+	size_t alloc;
+};
+
 #ifndef NO_IPV6
 
-static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
+static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
 {
-	int socknum = 0, *socklist = NULL;
+	int socknum = 0;
 	int maxfd = -1;
 	char pbuf[NI_MAXSERV];
 	struct addrinfo hints, *ai0, *ai;
@@ -753,8 +759,10 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 	hints.ai_flags = AI_PASSIVE;
 
 	gai = getaddrinfo(listen_addr, pbuf, &hints, &ai0);
-	if (gai)
-		die("getaddrinfo() failed: %s", gai_strerror(gai));
+	if (gai) {
+		logerror("getaddrinfo() for %s failed: %s", listen_addr, gai_strerror(gai));
+		return 0;
+	}
 
 	for (ai = ai0; ai; ai = ai->ai_next) {
 		int sockfd;
@@ -795,8 +803,9 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 		if (flags >= 0)
 			fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
 
-		socklist = xrealloc(socklist, sizeof(int) * (socknum + 1));
-		socklist[socknum++] = sockfd;
+		ALLOC_GROW(socklist->list, socklist->nr + 1, socklist->alloc);
+		socklist->list[socklist->nr++] = sockfd;
+		socknum++;
 
 		if (maxfd < sockfd)
 			maxfd = sockfd;
@@ -804,13 +813,12 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 
 	freeaddrinfo(ai0);
 
-	*socklist_p = socklist;
 	return socknum;
 }
 
 #else /* NO_IPV6 */
 
-static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
+static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
 {
 	struct sockaddr_in sin;
 	int sockfd;
@@ -851,22 +859,27 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 	if (flags >= 0)
 		fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
 
-	*socklist_p = xmalloc(sizeof(int));
-	**socklist_p = sockfd;
+	ALLOC_GROW(socklist->list, socklist->nr + 1, socklist->alloc);
+	socklist->list[socklist->nr++] = sockfd;
 	return 1;
 }
 
 #endif
 
-static int service_loop(int socknum, int *socklist)
+static void socksetup(char *listen_addr, int listen_port, struct socketlist *socklist)
+{
+	setup_named_sock(listen_addr, listen_port, socklist);
+}
+
+static int service_loop(struct socketlist *socklist)
 {
 	struct pollfd *pfd;
 	int i;
 
-	pfd = xcalloc(socknum, sizeof(struct pollfd));
+	pfd = xcalloc(socklist->nr, sizeof(struct pollfd));
 
-	for (i = 0; i < socknum; i++) {
-		pfd[i].fd = socklist[i];
+	for (i = 0; i < socklist->nr; i++) {
+		pfd[i].fd = socklist->list[i];
 		pfd[i].events = POLLIN;
 	}
 
@@ -877,7 +890,7 @@ static int service_loop(int socknum, int *socklist)
 
 		check_dead_children();
 
-		if (poll(pfd, socknum, -1) < 0) {
+		if (poll(pfd, socklist->nr, -1) < 0) {
 			if (errno != EINTR) {
 				logerror("Poll failed, resuming: %s",
 				      strerror(errno));
@@ -886,7 +899,7 @@ static int service_loop(int socknum, int *socklist)
 			continue;
 		}
 
-		for (i = 0; i < socknum; i++) {
+		for (i = 0; i < socklist->nr; i++) {
 			if (pfd[i].revents & POLLIN) {
 				struct sockaddr_storage ss;
 				unsigned int sslen = sizeof(ss);
@@ -948,10 +961,10 @@ static void store_pid(const char *path)
 
 static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t gid)
 {
-	int socknum, *socklist;
+	struct socketlist socklist = { NULL, 0, 0 };
 
-	socknum = socksetup(listen_addr, listen_port, &socklist);
-	if (socknum == 0)
+	socksetup(listen_addr, listen_port, &socklist);
+	if (socklist.nr == 0)
 		die("unable to allocate any listen sockets on host %s port %u",
 		    listen_addr, listen_port);
 
@@ -960,7 +973,7 @@ static int serve(char *listen_addr, int listen_port, struct passwd *pass, gid_t
 	     setuid(pass->pw_uid)))
 		die("cannot drop privileges");
 
-	return service_loop(socknum, socklist);
+	return service_loop(&socklist);
 }
 
 int main(int argc, char **argv)
-- 
1.7.1
