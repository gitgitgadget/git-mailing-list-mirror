From: Eric Wong <e@80x24.org>
Subject: [PATCH] daemon: enable SO_KEEPALIVE for all sockets
Date: Wed, 25 May 2016 03:15:05 +0000
Message-ID: <20160525031505.5720-1-e@80x24.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 25 05:15:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5PI4-0000KL-3G
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 05:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752439AbcEYDPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 23:15:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36978 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751781AbcEYDPH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 23:15:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4ACE1FCC4;
	Wed, 25 May 2016 03:15:05 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295553>

While --init-timeout and --timeout options exist and I've never
run git-daemon without them, some users may forget to set them
and encounter hung daemon processes when connections fail.
Enable socket-level timeouts so the kernel can send keepalive
probes as necessary to detect failed connections.

Signed-off-by: Eric Wong <e@80x24.org>
---
 daemon.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/daemon.c b/daemon.c
index 8d45c33..46dddac 100644
--- a/daemon.c
+++ b/daemon.c
@@ -669,6 +669,15 @@ static void hostinfo_clear(struct hostinfo *hi)
 	strbuf_release(&hi->tcp_port);
 }
 
+static void set_keep_alive(int sockfd)
+{
+	int ka = 1;
+
+	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0)
+		logerror("unable to set SO_KEEPALIVE on socket: %s",
+			strerror(errno));
+}
+
 static int execute(void)
 {
 	char *line = packet_buffer;
@@ -681,6 +690,7 @@ static int execute(void)
 	if (addr)
 		loginfo("Connection from %s:%s", addr, port);
 
+	set_keep_alive(0);
 	alarm(init_timeout ? init_timeout : timeout);
 	pktlen = packet_read(0, NULL, NULL, packet_buffer, sizeof(packet_buffer), 0);
 	alarm(0);
@@ -951,6 +961,8 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 			continue;
 		}
 
+		set_keep_alive(sockfd);
+
 		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
 			logerror("Could not bind to %s: %s",
 				 ip2str(ai->ai_family, ai->ai_addr, ai->ai_addrlen),
@@ -1010,6 +1022,8 @@ static int setup_named_sock(char *listen_addr, int listen_port, struct socketlis
 		return 0;
 	}
 
+	set_keep_alive(sockfd);
+
 	if ( bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0 ) {
 		logerror("Could not bind to %s: %s",
 			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
