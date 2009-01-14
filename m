From: Jan Engelhardt <jengelh@medozas.de>
Subject: [PATCH 2/3] git-daemon: use getnameinfo to resolve hostname
Date: Wed, 14 Jan 2009 11:48:38 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0901141148130.16109@fbirervta.pbzchgretzou.qr>
References: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 11:50:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN3Jz-0001yP-Jq
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 11:50:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758719AbZANKsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 05:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758641AbZANKsk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 05:48:40 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:59906 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758585AbZANKsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 05:48:39 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 2A54A1812F9E3; Wed, 14 Jan 2009 11:48:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 297651CBDECE0
	for <git@vger.kernel.org>; Wed, 14 Jan 2009 11:48:38 +0100 (CET)
In-Reply-To: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105614>


parent v1.6.1

git-daemon: use getnameinfo to resolve hostname

This is much shorter than inet_ntop'ing, and also translated
unresolvable addresses into a string.

Signed-off-by: Jan Engelhardt <jengelh@medozas.de>

---
 daemon.c |   26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

Index: git-1.6.1/daemon.c
===================================================================
--- git-1.6.1.orig/daemon.c
+++ git-1.6.1/daemon.c
@@ -512,25 +512,13 @@ static int execute(struct sockaddr *addr
 	int pktlen, len, i;
 
 	if (addr) {
-		int port = -1;
-
-		if (addr->sa_family == AF_INET) {
-			struct sockaddr_in *sin_addr = (void *) addr;
-			inet_ntop(addr->sa_family, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
-			port = ntohs(sin_addr->sin_port);
-#ifndef NO_IPV6
-		} else if (addr && addr->sa_family == AF_INET6) {
-			struct sockaddr_in6 *sin6_addr = (void *) addr;
-
-			char *buf = addrbuf;
-			*buf++ = '['; *buf = '\0'; /* stpcpy() is cool */
-			inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(addrbuf) - 1);
-			strcat(buf, "]");
-
-			port = ntohs(sin6_addr->sin6_port);
-#endif
-		}
-		setenv("REMOTE_ADDR", addrbuf, 1);
+		i = getnameinfo(addr, (addr->sa_family == AF_INET6) ?
+		    sizeof(struct sockaddr_in6) : sizeof(struct sockaddr_in),
+		    addrbuf, sizeof(addrbuf), NULL, 0, 0);
+		if (i == 0)
+			setenv("REMOTE_ADDR", addrbuf, 1);
+		else
+			unsetenv("REMOTE_ADDR");
 	}
 	else {
 		unsetenv("REMOTE_ADDR");
