From: Dave Zarzycki <zarzycki@apple.com>
Subject: [PATCH] Do not log unless all connect() attempts fail
Date: Thu, 09 Jun 2011 10:52:13 -0700
Message-ID: <FB214E8F-7C84-4EE1-9E7C-FC8499B688C1@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 19:52:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUjP2-0000U3-Pc
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 19:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab1FIRwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 13:52:15 -0400
Received: from mail-out.apple.com ([17.151.62.50]:55845 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248Ab1FIRwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 13:52:15 -0400
Received: from relay15.apple.com ([17.128.113.54])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTP id <0LMJ00IHDAWDSN41@mail-out.apple.com> for git@vger.kernel.org;
 Thu, 09 Jun 2011 10:52:14 -0700 (PDT)
X-AuditID: 11807136-b7c6bae000004a34-16-4df1084e6de8
Received: from koseret (koseret.apple.com [17.151.62.39])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay15.apple.com (Apple SCV relay)
 with SMTP id 2C.E8.18996.E4801FD4; Thu, 09 Jun 2011 10:52:14 -0700 (PDT)
Received: from event-10-1-6-203.venue.apple.com (unknown [192.42.249.6])
 by koseret.apple.com
 (Oracle Communications Messaging Exchange Server 7u4-20.01 64bit (built Nov 21
 2010)) with ESMTPSA id <0LMJ009U2AZ2UO00@koseret.apple.com> for
 git@vger.kernel.org; Thu, 09 Jun 2011 10:52:14 -0700 (PDT)
X-Mailer: Apple Mail (2.1237.1)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175562>

IPv6 hosts are often unreachable on the primarily IPv4 Internet and
therefore we shouldn't print an error if there are still other hosts we
can try to connect() to. This helps "git fetch --quiet" stay quiet.
---
 connect.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index 2119c3f..8eb9f44 100644
--- a/connect.c
+++ b/connect.c
@@ -192,6 +192,7 @@ static const char *ai_name(const struct addrinfo *ai)
  */
 static int git_tcp_connect_sock(char *host, int flags)
 {
+	struct strbuf error_message = STRBUF_INIT;
 	int sockfd = -1, saved_errno = 0;
 	const char *port = STR(DEFAULT_GIT_PORT);
 	struct addrinfo hints, *ai0, *ai;
@@ -225,11 +226,8 @@ static int git_tcp_connect_sock(char *host, int flags)
 		}
 		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
 			saved_errno = errno;
-			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
-				host,
-				cnt,
-				ai_name(ai),
-				strerror(saved_errno));
+			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
+				host, cnt, ai_name(ai), strerror(saved_errno));
 			close(sockfd);
 			sockfd = -1;
 			continue;
@@ -242,11 +240,13 @@ static int git_tcp_connect_sock(char *host, int flags)
 	freeaddrinfo(ai0);
 
 	if (sockfd < 0)
-		die("unable to connect a socket (%s)", strerror(saved_errno));
+		die("unable to connect to %s:\n%s", host, error_message.buf);
 
 	if (flags & CONNECT_VERBOSE)
 		fprintf(stderr, "done.\n");
 
+	strbuf_release(&error_message);
+
 	return sockfd;
 }
 
-- 
1.7.6.rc1.1.g2e27
