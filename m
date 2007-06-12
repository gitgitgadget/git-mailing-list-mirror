From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Do not use h_errno after connect(2): the function does not set it
Date: Tue, 12 Jun 2007 22:52:10 +0200
Message-ID: <20070612205210.GC2459@steel.home>
References: <86ejkh40cr.fsf@blue.stonehenge.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 22:52:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyDLe-0001Xx-HS
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 22:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbXFLUwO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 16:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbXFLUwO
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 16:52:14 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:45997 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbXFLUwO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 16:52:14 -0400
Received: from tigra.home (Fcad5.f.strato-dslnet.de [195.4.202.213])
	by post.webmailer.de (mrclete mo6) (RZmta 7.2)
	with ESMTP id Q01515j5CK8uGH ; Tue, 12 Jun 2007 22:52:12 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1F1FF277BD;
	Tue, 12 Jun 2007 22:52:12 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 167E9D261; Tue, 12 Jun 2007 22:52:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86ejkh40cr.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTj8OeQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49997>

Randal L. Schwartz noticed compilation problems on SunOS, which made
me look at the code again. The thing is, h_errno is not used by
connect(2), it is only for functions from netdb.h, like gethostbyname.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

This must fix your link problems (unless you want to use NO_IPV6=1,
where another fix will be posted in a minute).

 connect.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/connect.c b/connect.c
index 7fab9c0..a5afd2a 100644
--- a/connect.c
+++ b/connect.c
@@ -224,11 +224,10 @@ static int git_tcp_connect_sock(char *host, int flags)
 		}
 		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
 			saved_errno = errno;
-			fprintf(stderr, "%s[%d: %s]: net=%s, errno=%s\n",
+			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
 				host,
 				cnt,
 				ai_name(ai),
-				hstrerror(h_errno),
 				strerror(saved_errno));
 			close(sockfd);
 			sockfd = -1;
@@ -315,11 +314,10 @@ static int git_tcp_connect_sock(char *host, int flags)
 
 		if (connect(sockfd, (struct sockaddr *)&sa, sizeof sa) < 0) {
 			saved_errno = errno;
-			fprintf(stderr, "%s[%d: %s]: net=%s, errno=%s\n",
+			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
 				host,
 				cnt,
 				inet_ntoa(*(struct in_addr *)&sa.sin_addr),
-				hstrerror(h_errno),
 				strerror(saved_errno));
 			close(sockfd);
 			sockfd = -1;
-- 
1.5.2.1.191.gc01a
