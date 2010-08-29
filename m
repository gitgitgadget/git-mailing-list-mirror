From: Alexander Sulfrian <alexander@sulfrian.net>
Subject: [PATCHv3 1/2] daemon: add helper function named_sock_setup
Date: Sun, 29 Aug 2010 17:13:15 +0200
Message-ID: <1283094796-27984-2-git-send-email-alexander@sulfrian.net>
References: <1283094462-5184-1-git-send-email-alexander@sulfrian.net>
Cc: Alexander Sulfrian <alexander@sulfrian.net>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 29 17:13:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpjZc-00026X-O0
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 17:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620Ab0H2PNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 11:13:30 -0400
Received: from animux.de ([78.46.93.45]:41381 "EHLO mail.sulfrian.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab0H2PN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 11:13:29 -0400
Received: by mail.sulfrian.net (Postfix, from userid 65534)
	id 674B380DFFAC; Sun, 29 Aug 2010 17:13:41 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr2 (2008-06-10) on mail.intern
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=7.0 tests=ALL_TRUSTED,AWL,
	DNS_FROM_OPENWHOIS autolearn=no version=3.2.5-gr2
Received: from laptop (unknown [93.214.39.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.sulfrian.net (Postfix) with ESMTPSA id 9D01380D7590;
	Sun, 29 Aug 2010 15:13:39 +0000 (UTC)
Received: by laptop (sSMTP sendmail emulation); Sun, 29 Aug 2010 17:13:26 +0200
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1283094462-5184-1-git-send-email-alexander@sulfrian.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154691>

Add named_sock_setup as helper function for socksetup to make it
easier to create more than one listen sockets. named_sock_setup could
be called more than one time and add the new sockets to the supplied
socklist_p.

Signed-off-by: Alexander Sulfrian <alexander@sulfrian.net>
---
 daemon.c |   35 ++++++++++++++++++++++++-----------
 1 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/daemon.c b/daemon.c
index e22a2b7..deda4cf 100644
--- a/daemon.c
+++ b/daemon.c
@@ -736,9 +736,9 @@ static int set_reuse_addr(int sockfd)
 
 #ifndef NO_IPV6
 
-static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
+static int setup_named_sock(char *listen_addr, int listen_port, int **socklist_p, int socknum)
 {
-	int socknum = 0, *socklist = NULL;
+	int *socklist = *socklist_p;
 	int maxfd = -1;
 	char pbuf[NI_MAXSERV];
 	struct addrinfo hints, *ai0, *ai;
@@ -810,8 +810,9 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 
 #else /* NO_IPV6 */
 
-static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
+static int setup_named_sock(char *listen_addr, int listen_port, int **socklist_p, int socknum)
 {
+	int *socklist = *socklist_p;
 	struct sockaddr_in sin;
 	int sockfd;
 	long flags;
@@ -823,41 +824,53 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 	if (listen_addr) {
 		/* Well, host better be an IP address here. */
 		if (inet_pton(AF_INET, listen_addr, &sin.sin_addr.s_addr) <= 0)
-			return 0;
+			return socknum;
 	} else {
 		sin.sin_addr.s_addr = htonl(INADDR_ANY);
 	}
 
 	sockfd = socket(AF_INET, SOCK_STREAM, 0);
 	if (sockfd < 0)
-		return 0;
+		return socknum;
 
 	if (set_reuse_addr(sockfd)) {
 		close(sockfd);
-		return 0;
+		return socknum;
 	}
 
 	if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
 		close(sockfd);
-		return 0;
+		return socknum;
 	}
 
 	if (listen(sockfd, 5) < 0) {
 		close(sockfd);
-		return 0;
+		return socknum;
 	}
 
 	flags = fcntl(sockfd, F_GETFD, 0);
 	if (flags >= 0)
 		fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
 
-	*socklist_p = xmalloc(sizeof(int));
-	**socklist_p = sockfd;
-	return 1;
+	socklist = xrealloc(socklist, sizeof(int) * (socknum + 1));
+	socklist[socknum++] = sockfd;
+
+	*socklist_p = socklist;
+	return socknum;
 }
 
 #endif
 
+static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
+{
+	int socknum = 0, *socklist = NULL;
+
+	socknum = setup_named_sock(listen_addr, listen_port, &socklist, socknum);
+
+	*socklist_p = socklist;
+	return socknum;
+}
+
 static int service_loop(int socknum, int *socklist)
 {
 	struct pollfd *pfd;
-- 
1.7.1
