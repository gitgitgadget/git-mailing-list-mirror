From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Fix errno usage in connect.c
Date: Sat, 1 Jul 2006 23:56:26 +0200
Message-ID: <20060701215626.GB29115@pasky.or.cz>
References: <118833cc0606280956s4081029ci5b3cd1fdf4b10c97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 01 23:56:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwnSD-0006Dl-RE
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 23:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWGAV4a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 17:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWGAV43
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 17:56:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52364 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750734AbWGAV42 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 17:56:28 -0400
Received: (qmail 24532 invoked by uid 2001); 1 Jul 2006 23:56:26 +0200
To: Morten Welinder <mwelinder@gmail.com>
Content-Disposition: inline
In-Reply-To: <118833cc0606280956s4081029ci5b3cd1fdf4b10c97@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23065>

Dear diary, on Wed, Jun 28, 2006 at 06:56:12PM CEST, I got a letter
where Morten Welinder <mwelinder@gmail.com> said that...
> It looks like connect.c waits too long before it uses errno in both copies
> of git_tcp_connect_sock.  Both close and freeaddrinfo can poke any
> non-zero value in there.

Nice catch.

->8-

errno was used after it could've been modified by a subsequent library call.
Spotted by Morten Welinder.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 connect.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index cb4656d..9a87bd9 100644
--- a/connect.c
+++ b/connect.c
@@ -328,7 +328,7 @@ #ifndef NO_IPV6
  */
 static int git_tcp_connect_sock(char *host)
 {
-	int sockfd = -1;
+	int sockfd = -1, saved_errno = 0;
 	char *colon, *end;
 	const char *port = STR(DEFAULT_GIT_PORT);
 	struct addrinfo hints, *ai0, *ai;
@@ -362,9 +362,12 @@ static int git_tcp_connect_sock(char *ho
 	for (ai0 = ai; ai; ai = ai->ai_next) {
 		sockfd = socket(ai->ai_family,
 				ai->ai_socktype, ai->ai_protocol);
-		if (sockfd < 0)
+		if (sockfd < 0) {
+			saved_errno = errno;
 			continue;
+		}
 		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
+			saved_errno = errno;
 			close(sockfd);
 			sockfd = -1;
 			continue;
@@ -375,7 +378,7 @@ static int git_tcp_connect_sock(char *ho
 	freeaddrinfo(ai0);
 
 	if (sockfd < 0)
-		die("unable to connect a socket (%s)", strerror(errno));
+		die("unable to connect a socket (%s)", strerror(saved_errno));
 
 	return sockfd;
 }
@@ -387,7 +390,7 @@ #else /* NO_IPV6 */
  */
 static int git_tcp_connect_sock(char *host)
 {
-	int sockfd = -1;
+	int sockfd = -1, saved_errno = 0;
 	char *colon, *end;
 	char *port = STR(DEFAULT_GIT_PORT), *ep;
 	struct hostent *he;
@@ -426,8 +429,10 @@ static int git_tcp_connect_sock(char *ho
 
 	for (ap = he->h_addr_list; *ap; ap++) {
 		sockfd = socket(he->h_addrtype, SOCK_STREAM, 0);
-		if (sockfd < 0)
+		if (sockfd < 0) {
+			saved_errno = errno;
 			continue;
+		}
 
 		memset(&sa, 0, sizeof sa);
 		sa.sin_family = he->h_addrtype;
@@ -435,6 +440,7 @@ static int git_tcp_connect_sock(char *ho
 		memcpy(&sa.sin_addr, *ap, he->h_length);
 
 		if (connect(sockfd, (struct sockaddr *)&sa, sizeof sa) < 0) {
+			saved_errno = errno;
 			close(sockfd);
 			sockfd = -1;
 			continue;
@@ -443,7 +449,7 @@ static int git_tcp_connect_sock(char *ho
 	}
 
 	if (sockfd < 0)
-		die("unable to connect a socket (%s)", strerror(errno));
+		die("unable to connect a socket (%s)", strerror(saved_errno));
 
 	return sockfd;
 }

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
