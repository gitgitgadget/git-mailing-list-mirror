From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH 2/3] daemon: Set SO_REUSEADDR on listening sockets.
Date: Fri, 03 Feb 2006 20:27:04 +0000
Message-ID: <20060203202704.1895.18383.stgit@metalzone.distorted.org.uk>
References: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Fri Feb 03 21:27:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F57WV-0005RV-GT
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 21:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWBCU1I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 15:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWBCU1H
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 15:27:07 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:8756 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751397AbWBCU1F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 15:27:05 -0500
Received: (qmail 2113 invoked from network); 3 Feb 2006 20:27:04 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (?+A3ymssPW3ytjJ+cRC1mbBbhbFHSdnZb?@127.0.0.1)
  by localhost with SMTP; 3 Feb 2006 20:27:04 -0000
To: git@vger.kernel.org
In-Reply-To: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15546>

From: Mark Wooding <mdw@distorted.org.uk>

Without this, you can silently lose the ability to receive IPv4
connections if you stop and restart the daemon.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 daemon.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index 532bb0c..6b88c0c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -454,6 +454,7 @@ static int socksetup(int port, int **soc
 	int socknum = 0, *socklist = NULL;
 	int maxfd = -1;
 	char pbuf[NI_MAXSERV];
+	int yes = 1;
 
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
@@ -491,6 +492,12 @@ static int socksetup(int port, int **soc
 		}
 #endif
 
+		if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR,
+			       &yes, sizeof(yes))) {
+			close(sockfd);
+			return 0;	/* not fatal */
+		}
+
 		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
 			close(sockfd);
 			continue;	/* not fatal */
@@ -523,6 +530,7 @@ static int socksetup(int port, int **soc
 {
 	struct sockaddr_in sin;
 	int sockfd;
+	int yes = 1;
 
 	sockfd = socket(AF_INET, SOCK_STREAM, 0);
 	if (sockfd < 0)
@@ -533,6 +541,12 @@ static int socksetup(int port, int **soc
 	sin.sin_addr.s_addr = htonl(INADDR_ANY);
 	sin.sin_port = htons(port);
 
+	if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR,
+		       &yes, sizeof(yes))) {
+		close(sockfd);
+		return 0;
+	}
+
 	if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
 		close(sockfd);
 		return 0;
