From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git-daemon: Avoid leaking the listening sockets into child processes.
Date: Wed, 14 Feb 2007 18:10:26 +0100
Message-ID: <87d54c8y2l.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 18:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNef-0004kO-Bd
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 18:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbXBNRKc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 12:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbXBNRKc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 12:10:32 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:55107 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbXBNRKb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 12:10:31 -0500
Received: from adsl-62-167-48-140.adslplus.ch ([62.167.48.140] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HHNeH-0007w5-GK
	for git@vger.kernel.org; Wed, 14 Feb 2007 11:10:29 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id E90104FB65; Wed, 14 Feb 2007 18:10:26 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39689>

This makes it possible to restart git-daemon even if some children are
still running.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 daemon.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index 2a20ca5..66f8d6f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -773,6 +773,7 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 	char pbuf[NI_MAXSERV];
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
+	long flags;
 
 	sprintf(pbuf, "%d", listen_port);
 	memset(&hints, 0, sizeof(hints));
@@ -820,6 +821,10 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 			continue;	/* not fatal */
 		}
 
+		flags = fcntl(sockfd, F_GETFD, 0);
+		if (flags >= 0)
+			fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
+
 		socklist = xrealloc(socklist, sizeof(int) * (socknum + 1));
 		socklist[socknum++] = sockfd;
 
@@ -839,6 +844,7 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 {
 	struct sockaddr_in sin;
 	int sockfd;
+	long flags;
 
 	memset(&sin, 0, sizeof sin);
 	sin.sin_family = AF_INET;
@@ -871,6 +877,10 @@ static int socksetup(char *listen_addr, int listen_port, int **socklist_p)
 		return 0;
 	}
 
+	flags = fcntl(sockfd, F_GETFD, 0);
+	if (flags >= 0)
+		fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
+
 	*socklist_p = xmalloc(sizeof(int));
 	**socklist_p = sockfd;
 	return 1;
-- 
1.5.0.7.g2fa71

-- 
Alexandre Julliard
julliard@winehq.org
