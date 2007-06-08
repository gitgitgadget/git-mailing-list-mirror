From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC][PATCH 08/10] Sparse: fix an "incorrect type in argument n"
 warning
Date: Fri, 08 Jun 2007 23:24:20 +0100
Message-ID: <4669D714.5050805@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 01:39:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwo3L-0007D2-Bc
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 01:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbXFHXjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 19:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414AbXFHXjc
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 19:39:32 -0400
Received: from anchor-fallback-96.mail.demon.net ([194.217.242.83]:41022 "EHLO
	anchor-fallback-96.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754532AbXFHXja (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 19:39:30 -0400
X-Greylist: delayed 4179 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Jun 2007 19:39:29 EDT
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1550 "EHLO
	anchor-post-30.mail.demon.net") by anchor-fallback-96.mail.demon.net
	with ESMTP id S479271AbXFHWck (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 22:32:40 +0000
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1Hwmy8-0005p3-13; Fri, 08 Jun 2007 22:30:08 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49522>


In particular, the warning referred to argument 3 in a call to
accept() and alluded to the type of the actual and formal arguments
being of a different signedness. The type of the formal parameter
of accept is (socklen_t *), rather than (unsigned int *) as used
here, so make the necessary changes to use socklen_t in the
appropriate places.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 daemon.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/daemon.c b/daemon.c
index 64f1f34..9daa850 100644
--- a/daemon.c
+++ b/daemon.c
@@ -604,11 +604,11 @@ static unsigned int children_deleted;
 
 static struct child {
 	pid_t pid;
-	int addrlen;
+	socklen_t addrlen;
 	struct sockaddr_storage address;
 } live_child[MAX_CHILDREN];
 
-static void add_child(int idx, pid_t pid, struct sockaddr *addr, int addrlen)
+static void add_child(int idx, pid_t pid, struct sockaddr *addr, socklen_t addrlen)
 {
 	live_child[idx].pid = pid;
 	live_child[idx].addrlen = addrlen;
@@ -702,7 +702,7 @@ static void check_max_connections(void)
 	}
 }
 
-static void handle(int incoming, struct sockaddr *addr, int addrlen)
+static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 {
 	pid_t pid = fork();
 
@@ -917,7 +917,7 @@ static int service_loop(int socknum, int *socklist)
 		for (i = 0; i < socknum; i++) {
 			if (pfd[i].revents & POLLIN) {
 				struct sockaddr_storage ss;
-				unsigned int sslen = sizeof(ss);
+				socklen_t sslen = sizeof(ss);
 				int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
 				if (incoming < 0) {
 					switch (errno) {
-- 
1.5.2
