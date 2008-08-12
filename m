From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [PATCH] git-daemon: SysV needs the signal handler reinstated.
Date: Tue, 12 Aug 2008 21:36:13 +0200
Message-ID: <20080812193613.32388.92145.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 21:37:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSzgY-0004BF-U6
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 21:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbYHLTgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 15:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbYHLTgQ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 15:36:16 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:47062 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbYHLTgP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 15:36:15 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id BDE2D546D; Tue, 12 Aug 2008 21:36:13 +0200 (CEST)
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92132>

Fixes the bug on (amongst others) Solaris that only the first
child ever is reaped.

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

 daemon.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/daemon.c b/daemon.c
index 4540e8d..1c00305 100644
--- a/daemon.c
+++ b/daemon.c
@@ -794,6 +794,7 @@ static void child_handler(int signo)
 		}
 		break;
 	}
+	signal(SIGCHLD, child_handler);
 }
 
 static int set_reuse_addr(int sockfd)
@@ -947,7 +948,7 @@ static int service_loop(int socknum, int *socklist)
 	pfd[socknum].fd = child_handler_pipe[0];
 	pfd[socknum].events = POLLIN;
 
-	signal(SIGCHLD, child_handler);
+	child_handler(0);
 
 	for (;;) {
 		int i;
