From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] enable SO_KEEPALIVE for connected TCP sockets
Date: Tue, 6 Dec 2011 04:39:36 +0000
Message-ID: <20111206043936.GA31920@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 05:39:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXmow-0002tK-Jw
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 05:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188Ab1LFEjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 23:39:37 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:43688 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721Ab1LFEjh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 23:39:37 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59E201F4E9;
	Tue,  6 Dec 2011 04:39:36 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186310>

Sockets may never receive notification of some link errors,
causing "git fetch" or similar processes to hang forever.
Enabling keepalive messages allows hung processes to error out
after a few minutes/hours depending on the keepalive settings of
the system.

This is a problem noticed when running non-interactive
cronjobs to mirror repositories using "git fetch".

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 connect.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/connect.c b/connect.c
index 51990fa..d0f59ef 100644
--- a/connect.c
+++ b/connect.c
@@ -175,6 +175,15 @@ static void get_host_and_port(char **host, const char **port)
 	}
 }
 
+static void enable_keepalive(int sockfd)
+{
+	int ka = 1;
+
+	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0)
+		fprintf(stderr, "unable to set SO_KEEPALIVE on socket: %s\n",
+			strerror(errno));
+}
+
 #ifndef NO_IPV6
 
 static const char *ai_name(const struct addrinfo *ai)
@@ -239,6 +248,8 @@ static int git_tcp_connect_sock(char *host, int flags)
 	if (sockfd < 0)
 		die("unable to connect to %s:\n%s", host, error_message.buf);
 
+	enable_keepalive(sockfd);
+
 	if (flags & CONNECT_VERBOSE)
 		fprintf(stderr, "done.\n");
 
@@ -312,6 +323,8 @@ static int git_tcp_connect_sock(char *host, int flags)
 	if (sockfd < 0)
 		die("unable to connect to %s:\n%s", host, error_message.buf);
 
+	enable_keepalive(sockfd);
+
 	if (flags & CONNECT_VERBOSE)
 		fprintf(stderr, "done.\n");
 
-- 
Eric Wong
