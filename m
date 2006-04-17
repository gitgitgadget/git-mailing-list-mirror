From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: [PATCH 1/7] cleanups: Fix resource leak and buffer overrun in daemon.c
Date: Mon, 17 Apr 2006 10:14:47 -0500 (CDT)
Message-ID: <20060417151447.D4FE619B90E@sergelap.hallyn.com>
References: <20060417145148.2F3CB19C90D@sergelap.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 17 17:15:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVVRM-0006b0-LI
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 17:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWDQPOz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 11:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWDQPOz
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 11:14:55 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:28383 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751094AbWDQPOv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 11:14:51 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3HFEnMC026346
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:49 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3HFBC72258116
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 09:11:12 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3HFEmbF019182
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 09:14:48 -0600
Received: from sergelap.hallyn.com ([9.49.218.134])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k3HFEmNe019150
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 09:14:48 -0600
Received: by sergelap.hallyn.com (Postfix, from userid 1000)
	id D4FE619B90E; Mon, 17 Apr 2006 10:14:47 -0500 (CDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Mutt-Fcc: =SENT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18823>

Address two reports from an automatic code analyzer:

1. In logreport, it is possible to write \0 one
character past the end of buf[].

2. In socksetup, socklist can be leaked when returning
if set_reuse_addr().  Note: dunno why this case returns...

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 daemon.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

5b3e0254d34da582b7593084356c88a923f42a49
diff --git a/daemon.c b/daemon.c
index a1ccda3..7ac1bc7 100644
--- a/daemon.c
+++ b/daemon.c
@@ -65,8 +65,8 @@ static void logreport(int priority, cons
 	 * we have space for our own LF and NUL after the "meat" of the
 	 * message, so truncate it at maxlen - 1.
 	 */
-	if (msglen > maxlen - 1)
-		msglen = maxlen - 1;
+	if (msglen > maxlen - 2)
+		msglen = maxlen - 2;
 	else if (msglen < 0)
 		msglen = 0; /* Protect against weird return values. */
 	buflen += msglen;
@@ -535,6 +535,7 @@ static int socksetup(int port, int **soc
 
 		if (set_reuse_addr(sockfd)) {
 			close(sockfd);
+			free(socklist);
 			return 0;	/* not fatal */
 		}
 
-- 
1.2.5
