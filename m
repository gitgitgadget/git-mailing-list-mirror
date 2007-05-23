From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Verbose connect messages to show the IP addresses used
Date: Wed, 23 May 2007 23:34:27 +0200
Message-ID: <20070523213427.GG2554@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 23:34:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqyTY-0000xs-Vs
	for gcvg-git@gmane.org; Wed, 23 May 2007 23:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291AbXEWVea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 17:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756067AbXEWVea
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 17:34:30 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:42811 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291AbXEWVe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 17:34:29 -0400
Received: from tigra.home (Fa87d.f.strato-dslnet.de [195.4.168.125])
	by post.webmailer.de (fruni mo22) (RZmta 6.7)
	with ESMTP id A002e9j4NJf1mz ; Wed, 23 May 2007 23:34:28 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E0D05277BD;
	Wed, 23 May 2007 23:34:27 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BDBE5D195; Wed, 23 May 2007 23:34:27 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTSkVo8=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48178>

Also, the patch makes the error messages more verbose. Helps when
diagnosing connect problems on weird systems.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 connect.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/connect.c b/connect.c
index 2a26fdb..3757392 100644
--- a/connect.c
+++ b/connect.c
@@ -391,6 +391,23 @@ static enum protocol get_protocol(const char *name)
 
 #ifndef NO_IPV6
 
+static const char *ai_name(const struct addrinfo *ai)
+{
+	static char addr[INET_ADDRSTRLEN];
+	if ( AF_INET == ai->ai_family ) {
+		struct sockaddr_in *in;
+		in = (struct sockaddr_in *)ai->ai_addr;
+		inet_ntop(ai->ai_family, &in->sin_addr, addr, sizeof(addr));
+	} else if ( AF_INET6 == ai->ai_family ) {
+		struct sockaddr_in6 *in;
+		in = (struct sockaddr_in6 *)ai->ai_addr;
+		inet_ntop(ai->ai_family, &in->sin6_addr, addr, sizeof(addr));
+	} else {
+		strcpy(addr, "(unknown)");
+	}
+	return addr;
+}
+
 /*
  * Returns a connected socket() fd, or else die()s.
  */
@@ -401,6 +418,7 @@ static int git_tcp_connect_sock(char *host, int flags)
 	const char *port = STR(DEFAULT_GIT_PORT);
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
+	int cnt = 0;
 
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
@@ -444,10 +462,18 @@ static int git_tcp_connect_sock(char *host, int flags)
 		}
 		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
 			saved_errno = errno;
+			fprintf(stderr, "%s[%d: %s]: net=%s, errno=%s\n",
+				host,
+				cnt,
+				ai_name(ai),
+				hstrerror(h_errno),
+				strerror(saved_errno));
 			close(sockfd);
 			sockfd = -1;
 			continue;
 		}
+		if (flags & CONNECT_VERBOSE)
+			fprintf(stderr, "%s ", ai_name(ai));
 		break;
 	}
 
@@ -476,6 +502,7 @@ static int git_tcp_connect_sock(char *host, int flags)
 	struct sockaddr_in sa;
 	char **ap;
 	unsigned int nport;
+	int cnt;
 
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
@@ -512,7 +539,7 @@ static int git_tcp_connect_sock(char *host, int flags)
 	if (flags & CONNECT_VERBOSE)
 		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
 
-	for (ap = he->h_addr_list; *ap; ap++) {
+	for (cnt = 0, ap = he->h_addr_list; *ap; ap++, cnt++) {
 		sockfd = socket(he->h_addrtype, SOCK_STREAM, 0);
 		if (sockfd < 0) {
 			saved_errno = errno;
@@ -526,10 +553,19 @@ static int git_tcp_connect_sock(char *host, int flags)
 
 		if (connect(sockfd, (struct sockaddr *)&sa, sizeof sa) < 0) {
 			saved_errno = errno;
+			fprintf(stderr, "%s[%d: %s]: net=%s, errno=%s\n",
+				host,
+				cnt,
+				inet_ntoa(*(struct in_addr *)&sa.sin_addr),
+				hstrerror(h_errno),
+				strerror(saved_errno));
 			close(sockfd);
 			sockfd = -1;
 			continue;
 		}
+		if (flags & CONNECT_VERBOSE)
+			fprintf(stderr, "%s ",
+				inet_ntoa(*(struct in_addr *)&sa.sin_addr));
 		break;
 	}
 
-- 
1.5.2.58.g7a94-dirty
