From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: fatal: unexpected EOF
Date: Thu, 2 Mar 2006 23:23:28 +0100
Message-ID: <20060302222328.GF6183@steel.home>
References: <440449D7.3010508@didntduck.org> <Pine.LNX.4.64.0602280731210.22647@g5.osdl.org> <44046F94.3070806@didntduck.org> <12c511ca0602280759t2e584a4bkd7b6f4d97ade92f7@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gerst <bgerst@didntduck.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 02 23:24:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEwDt-0002FH-IL
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 23:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWCBWYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 17:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWCBWYH
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 17:24:07 -0500
Received: from devrace.com ([198.63.210.113]:30990 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1750842AbWCBWYF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 17:24:05 -0500
Received: from tigra.home (p54A05596.dip.t-dialin.net [84.160.85.150])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k22MNWK4018024;
	Thu, 2 Mar 2006 16:23:33 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FEwCm-0005x3-00; Thu, 02 Mar 2006 23:23:28 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FEwCm-0002RA-FE; Thu, 02 Mar 2006 23:23:28 +0100
To: Tony Luck <tony.luck@gmail.com>
Content-Disposition: inline
In-Reply-To: <12c511ca0602280759t2e584a4bkd7b6f4d97ade92f7@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17114>

Tony Luck, Tue, Feb 28, 2006 16:59:09 +0100:
> > I doubt it is a problem with mirroring, since it affects all repos
> > (kernel, git, cogito, etc.) at the same time.
> 
> Ditto.  Jes has been grumbling overnight that he can't get a reliable pull
> from my kernel repo ... and that hasn't been updated in 10 days, so the
> mirror code shouldn't be touching it.  His error was:
> 
>   fatal: read error (Connection reset by peer)
>   Fetch failure: git://git.kernel.org/pub/...
> 
> He also reported that after a few retries it worked.

I had the problems too and even made the patch (below) to see what it
was. I saw to A-records for zeus-pub.kernel.org (git.kernel.org is an
alias of it) where one of them (I believe it was 204.152.191.37)
sometimes didn't answer or dropped connection.

---

 connect.c |   41 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 2 deletions(-)

b5ceb5f3f1c6ff62a3ccb13f360a34b07b9c8482
diff --git a/connect.c b/connect.c
index 3f2d65c..e911fde 100644
--- a/connect.c
+++ b/connect.c
@@ -322,6 +322,23 @@ static enum protocol get_protocol(const 
 
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
 static int git_tcp_connect(int fd[2], const char *prog, char *host, char *path)
 {
 	int sockfd = -1;
@@ -329,6 +346,7 @@ static int git_tcp_connect(int fd[2], co
 	char *port = STR(DEFAULT_GIT_PORT);
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
+	int cnt = 0;
 
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
@@ -355,15 +373,23 @@ static int git_tcp_connect(int fd[2], co
 	if (gai)
 		die("Unable to look up %s (%s)", host, gai_strerror(gai));
 
-	for (ai0 = ai; ai; ai = ai->ai_next) {
+	for (ai0 = ai; ai; ++cnt, ai = ai->ai_next) {
 		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
 		if (sockfd < 0)
 			continue;
 		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
+			fprintf(stderr, "%s: %s[%d: %s]: net=%s, errno=%s\n",
+				argv0,
+				host,
+				cnt,
+				ai_name(ai),
+				hstrerror(h_errno),
+				strerror(errno));
 			close(sockfd);
 			sockfd = -1;
 			continue;
 		}
+		fprintf(stderr, "using %s[%s]\n", host, ai_name(ai));
 		break;
 	}
 
@@ -389,6 +415,7 @@ static int git_tcp_connect(int fd[2], co
 	struct sockaddr_in sa;
 	char **ap;
 	unsigned int nport;
+	int cnt;
 
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
@@ -420,7 +447,7 @@ static int git_tcp_connect(int fd[2], co
 		nport = se->s_port;
 	}
 
-	for (ap = he->h_addr_list; *ap; ap++) {
+	for (cnt = 0, ap = he->h_addr_list; *ap; ap++, cnt++) {
 		sockfd = socket(he->h_addrtype, SOCK_STREAM, 0);
 		if (sockfd < 0)
 			continue;
@@ -431,10 +458,20 @@ static int git_tcp_connect(int fd[2], co
 		memcpy(&sa.sin_addr, *ap, he->h_length);
 
 		if (connect(sockfd, (struct sockaddr *)&sa, sizeof sa) < 0) {
+			fprintf(stderr, "%s: %s[%d: %s]: net=%s, errno=%s\n",
+				argv0,
+				host,
+				cnt,
+				inet_ntoa(*(struct in_addr *)&sa.sin_addr),
+				hstrerror(h_errno),
+				strerror(errno));
 			close(sockfd);
 			sockfd = -1;
 			continue;
 		}
+		fprintf(stderr, "using %s[%s]\n",
+			host,
+			inet_ntoa(*(struct in_addr *)&sa.sin_addr));
 		break;
 	}
 
-- 
1.2.3.g3987
