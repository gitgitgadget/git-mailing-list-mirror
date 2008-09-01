From: Eric Wong <normalperson@yhbt.net>
Subject: [cgit PATCH] use Host: header to generate cgit_hosturl
Date: Sun, 31 Aug 2008 23:30:33 -0700
Message-ID: <20080901063033.GA21848@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 08:31:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka2wu-0007gm-U7
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 08:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbYIAGaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 02:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbYIAGaf
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 02:30:35 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35180 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbYIAGae (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 02:30:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id D597F2DC01B;
	Sun, 31 Aug 2008 23:30:33 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94535>

I run an instance of lighttpd for cgit behind nginx (nginx
doesn't execute CGI).  So the port (SERVER_PORT=33333) that
lighttpd runs on sends to cgit is different from the standard
port 80 that public clients connect to (via nginx).

This was causing the Atom feed URL to show the private port
number that lighttpd was running on.

Since the HTTP/1.1 "Host" header includes the port number if
running on a non-standard port, it allows non-client-facing HTTP
servers to transparently generate public URLs that clients can
see.

So use the "Host" header if it is available and fall back to
SERVER_NAME/SERVER_PORT for some clients that don't set
HTTP_HOST.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 ui-shared.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/ui-shared.c b/ui-shared.c
index 37c60b2..5a848c1 100644
--- a/ui-shared.c
+++ b/ui-shared.c
@@ -38,14 +38,19 @@ char *cgit_hosturl()
 {
 	char *host, *port;
 
-	host = getenv("SERVER_NAME");
-	if (!host)
-		return NULL;
-	port = getenv("SERVER_PORT");
-	if (port && atoi(port) != 80)
-		host = xstrdup(fmt("%s:%d", host, atoi(port)));
-	else
+	host = getenv("HTTP_HOST");
+	if (host) {
 		host = xstrdup(host);
+	} else {
+		host = getenv("SERVER_NAME");
+		if (!host)
+			return NULL;
+		port = getenv("SERVER_PORT");
+		if (port && atoi(port) != 80)
+			host = xstrdup(fmt("%s:%d", host, atoi(port)));
+		else
+			host = xstrdup(host);
+	}
 	return host;
 }
 
-- 
Eric Wong
