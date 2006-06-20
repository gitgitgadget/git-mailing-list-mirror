From: Michal Ludvig <michal@logix.cz>
Subject: Re: 2.6.17-rc6-mm2
Date: Tue, 20 Jun 2006 15:01:26 +1200
Message-ID: <44976506.8040205@logix.cz>
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com>  <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com>  <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org> <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com> <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050501040206000406000902"
Cc: Goo GGooo <googgooo@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jun 20 05:01:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsWUl-0008Ga-0r
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 05:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWFTDBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 23:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbWFTDBf
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 23:01:35 -0400
Received: from maxipes.logix.cz ([217.11.251.249]:34254 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S965069AbWFTDBe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jun 2006 23:01:34 -0400
Received: from [192.168.159.18] (unknown [192.168.159.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by maxipes.logix.cz (Postfix) with ESMTP id 14440BCC2F;
	Tue, 20 Jun 2006 05:01:30 +0200 (CEST)
User-Agent: Thunderbird 1.5 (X11/20060317)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22159>

This is a multi-part message in MIME format.
--------------050501040206000406000902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Fri, 16 Jun 2006, Goo GGooo wrote:
> 
>> I suggest adding SO_KEEPALIVE option on the git socket.
> 
> Actually, the really irritating thing is that we actually generate all 
> these nice status updates, which just makes pulling and cloning a lot more 
> comfortable, because you actually see what is going on, and what to 
> expect. 
> 
> Except they only work over ssh, where we have a separate channel (for 
> stderr), and with the native git protocol all that nice status work just 
> gets flushed to /dev/null :(

OpenBSD has CVS access to their repos over SSH even for anonymous users.
Could something similar be set up on git.kernel.org as well?

> And in your case, the usability downside actually turned into a real 
> accessibility bug.

Same issue here. Thanks for the hint. Attached is a patch against git
1.4.0 that solves it perfectly in my case.

Sysctl settings (for keepalive every 10 sec):
net.ipv4.tcp_keepalive_intvl=10
net.ipv4.tcp_keepalive_time=10

Michal

--------------050501040206000406000902
Content-Type: text/x-patch;
 name="keepalive.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="keepalive.diff"

Set SO_KEEPALIVE option on native git:// sockets.

Signed-off-by: Michal Ludvig <michal@logix.cz>

Index: git-1.4.0/connect.c
===================================================================
--- git-1.4.0.orig/connect.c
+++ git-1.4.0/connect.c
@@ -331,7 +331,7 @@ static int git_tcp_connect_sock(char *ho
 	char *colon, *end;
 	char *port = STR(DEFAULT_GIT_PORT);
 	struct addrinfo hints, *ai0, *ai;
-	int gai;
+	int gai, option;
 
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
@@ -363,6 +363,10 @@ static int git_tcp_connect_sock(char *ho
 				ai->ai_socktype, ai->ai_protocol);
 		if (sockfd < 0)
 			continue;
+
+		option = 1;
+		setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &option, sizeof(option));
+
 		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
 			close(sockfd);
 			sockfd = -1;
@@ -392,7 +396,7 @@ static int git_tcp_connect_sock(char *ho
 	struct hostent *he;
 	struct sockaddr_in sa;
 	char **ap;
-	unsigned int nport;
+	unsigned int nport, option;
 
 	if (host[0] == '[') {
 		end = strchr(host + 1, ']');
@@ -433,6 +437,9 @@ static int git_tcp_connect_sock(char *ho
 		sa.sin_port = htons(nport);
 		memcpy(&sa.sin_addr, *ap, he->h_length);
 
+		option = 1;
+		setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &option, sizeof(option));
+
 		if (connect(sockfd, (struct sockaddr *)&sa, sizeof sa) < 0) {
 			close(sockfd);
 			sockfd = -1;

--------------050501040206000406000902--
