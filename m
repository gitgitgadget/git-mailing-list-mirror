From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] connect: display connection progress
Date: Mon, 7 May 2007 00:21:23 +0200
Message-ID: <20070506222123.GB2439@steel.home>
References: <20070506195230.GA30339@mellanox.co.il>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon May 07 00:21:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkp6i-0001do-4t
	for gcvg-git@gmane.org; Mon, 07 May 2007 00:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbXEFWV3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 18:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbXEFWV3
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 18:21:29 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:28456 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbXEFWV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 18:21:28 -0400
Received: from tigra.home (195.4.200.47)
	by post.webmailer.de (klopstock mo36) (RZmta 5.9)
	with ESMTP id F04293j46K6mP7 ; Mon, 7 May 2007 00:21:26 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A8989277BD;
	Mon,  7 May 2007 00:21:23 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 7E7A8D171; Mon,  7 May 2007 00:21:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070506195230.GA30339@mellanox.co.il>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWopCbQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46383>

Michael S. Tsirkin, Sun, May 06, 2007 21:52:30 +0200:
> Make git notify the user about host resolution/connection attempts.  This
> is useful both as a progress indicator on slow links, and helps reassure the
> user there are no DNS/firewall problems.

If there DNS problems, it is usually useful to show which address was
used. And what errors were, exactly (not just errno, but h_errno too).
And which one of many, BTW. Maybe this below could be of help:

diff --git a/connect.c b/connect.c
index da89c9c..34c26bb 100644
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
@@ -401,6 +418,7 @@ static int git_tcp_connect_sock(char *host)
 	const char *port = STR(DEFAULT_GIT_PORT);
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
+	int cnt = 0;
 
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
@@ -438,10 +456,17 @@ static int git_tcp_connect_sock(char *host)
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
+		fprintf(stderr, "using %s[%s]\n", host, ai_name(ai));
 		break;
 	}
 
@@ -467,6 +492,7 @@ static int git_tcp_connect_sock(char *host)
 	struct sockaddr_in sa;
 	char **ap;
 	unsigned int nport;
+	int cnt;
 
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
@@ -497,7 +523,7 @@ static int git_tcp_connect_sock(char *host)
 		nport = se->s_port;
 	}
 
-	for (ap = he->h_addr_list; *ap; ap++) {
+	for (cnt = 0, ap = he->h_addr_list; *ap; ap++, cnt++) {
 		sockfd = socket(he->h_addrtype, SOCK_STREAM, 0);
 		if (sockfd < 0) {
 			saved_errno = errno;
@@ -511,10 +537,19 @@ static int git_tcp_connect_sock(char *host)
 
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
+		fprintf(stderr, "using %s[%s]\n",
+			host,
+			inet_ntoa(*(struct in_addr *)&sa.sin_addr));
 		break;
 	}
 
