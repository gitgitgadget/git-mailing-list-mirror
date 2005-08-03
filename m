From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] daemon.c: squelch error message from EINTR
Date: Tue, 02 Aug 2005 23:20:01 -0700
Message-ID: <7voe8fk0dq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 03 08:25:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0CgF-0002A7-Hc
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 08:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVHCGYX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 02:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVHCGVh
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 02:21:37 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:39347 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262081AbVHCGUD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 02:20:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803062001.UXVD8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 02:20:01 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a "call for help" patch.  The kernel.org folks are
talking about installing git daemon, and while the problem I am
trying to address should not matter when the daemon is spawned
from inetd, I would like to get this resolved.  Help greatly
apprciated.

-jc

------------
It appears that every time after servicing the connection,
select() first fails with EINTR and ends up waiting for one
second before serving the next client.  The sleep() was placed
by the original author per suggestion from the list to avoid
spinning on failing select, but at least this EINTR situation
should not result in "at most one client per second" service
limit.

I am not sure if this is the right fix, and I have not received
an answer from the original author of the patch.  I would
appreciate help from the folks on the list who are familiar with
the networking.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 daemon.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

34be43e7af874923cfa1c8baeaf19fa17bae4d30
diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -294,8 +294,11 @@ static int serve(int port)
 		fds = fds_init;
 		
 		if (select(maxfd + 1, &fds, NULL, NULL, NULL) < 0) {
-			error("select failed, resuming: %s", strerror(errno));
-			sleep(1);
+			if (errno != EINTR) {
+				error("select failed, resuming: %s",
+				      strerror(errno));
+				sleep(1);
+			}
 			continue;
 		}
 
