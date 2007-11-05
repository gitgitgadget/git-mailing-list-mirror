From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-daemon: fix remote port number in log entry
Date: Mon, 5 Nov 2007 09:16:22 +0000
Message-ID: <20071105091622.20256.qmail@ae827ecd1d1952.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 10:18:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioy6b-0000jy-G7
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 10:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbXKEJQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 04:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbXKEJQF
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 04:16:05 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:58722 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751267AbXKEJQE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 04:16:04 -0500
Received: (qmail 20257 invoked by uid 1000); 5 Nov 2007 09:16:22 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63491>

The port number in struct sockaddr_in needs to be converted from network
byte order to host byte order (on some architectures).

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 daemon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/daemon.c b/daemon.c
index 660e155..b8df980 100644
--- a/daemon.c
+++ b/daemon.c
@@ -540,7 +540,7 @@ static int execute(struct sockaddr *addr)
 		if (addr->sa_family == AF_INET) {
 			struct sockaddr_in *sin_addr = (void *) addr;
 			inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
-			port = sin_addr->sin_port;
+			port = ntohs(sin_addr->sin_port);
 #ifndef NO_IPV6
 		} else if (addr && addr->sa_family == AF_INET6) {
 			struct sockaddr_in6 *sin6_addr = (void *) addr;
@@ -550,7 +550,7 @@ static int execute(struct sockaddr *addr)
 			inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(addrbuf) - 1);
 			strcat(buf, "]");
 
-			port = sin6_addr->sin6_port;
+			port = ntohs(sin6_addr->sin6_port);
 #endif
 		}
 		loginfo("Connection from %s:%d", addrbuf, port);
-- 
1.5.3.5
