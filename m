From: Dave Zarzycki <zarzycki@apple.com>
Subject: With errno fix: [PATCH] Do not log unless all connect() attempts fail
Date: Wed, 13 Jul 2011 09:28:18 -0700
Message-ID: <7276ACEE-EF52-49DF-83EA-642DE504B3EA@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 18:28:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh2IU-00016a-K5
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 18:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108Ab1GMQ2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 12:28:21 -0400
Received: from bramley.apple.com ([17.151.62.49]:63099 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755811Ab1GMQ2V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 12:28:21 -0400
Received: from relay14.apple.com ([17.128.113.52])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPS id <0LOA00K3K5QW56Y0@mail-out.apple.com> for git@vger.kernel.org;
 Wed, 13 Jul 2011 09:28:16 -0700 (PDT)
X-AuditID: 11807134-b7c71ae0000014d0-b0-4e1dc6fd680f
Received: from kencur (kencur.apple.com [17.151.62.38])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay14.apple.com (Apple SCV relay)
 with SMTP id 6F.01.05328.EF6CD1E4; Wed, 13 Jul 2011 09:25:34 -0700 (PDT)
Received: from [17.153.28.46] (unknown [17.153.28.46])
 by kencur.apple.com (Oracle Communications Messaging Exchange Server 7u4-20.01
 64bit (built Nov 21 2010)) with ESMTPSA id <0LOA00MCU5R3CS50@kencur.apple.com>
 for git@vger.kernel.org; Wed, 13 Jul 2011 09:28:16 -0700 (PDT)
X-Mailer: Apple Mail (2.1244.3)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJMWRmVeSWpSXmKPExsUiON1OTfffMVk/gzNPOSy6rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJXx6swrpoJd/BUntk5jb2Ccw9PFyMEhIWAice2HWhcjJ5ApJnHh
	3nq2LkYuDiGBdiaJ7ld7mEASvAKCEj8m32MBqWcWkJc4eF4WJMwsoCXx/VErC0T9TCaJ21P/
	gtWzCWhIfDp1lxnEFhbwk7jRf5YNxGYRUJVYP302K8RMG4mZjdPZQWwRAXGJt8dnskMcIS+x
	uOUz4wRG3llIVs9CWD0LyeoFjMyrGAWLUnMSKw1N9BILCnJS9ZLzczcxgoKlodBkB+PBn/yH
	GAU4GJV4eIsSZfyEWBPLiitzDzFKcDArifDWN8j6CfGmJFZWpRblxxeV5qQWH2KU5mBREued
	eQCoWiA9sSQ1OzW1ILUIJsvEwSnVwKj1+9vy2HKhCzIcJ+8sF5GeeVWLaYuqYaKq378Vpvpt
	F5Y2bv359+TtCZHXaz7+Sv7SmGBlmqurs/LQKZG2CSqcLl8SXqfoaMySFmn6HmCy2G7xr8v5
	G3v2cbBd4ltypP2/wNGCHdN6vOI3m5amsk0uji9M1l7snPCko+cY4y2jCZtuT/aeoqXEUpyR
	aKjFXFScCAAiiBJbEgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177055>

IPv6 hosts are often unreachable on the primarily IPv4 Internet and
therefore we shouldn't print an error if there are still other hosts we
can try to connect() to. This helps "git fetch --quiet" stay quiet.

Signed-off-by: Dave Zarzycki <zarzycki@apple.com>
---
 connect.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index 2119c3f..87b2e3f 100644
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
@@ -217,6 +218,11 @@ static int git_tcp_connect_sock(char *host, int flags)
 		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
 
 	for (ai0 = ai; ai; ai = ai->ai_next) {
+		if (saved_errno) {
+			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
+				host, cnt, ai_name(ai), strerror(saved_errno));
+			saved_errno = 0;
+		}
 		sockfd = socket(ai->ai_family,
 				ai->ai_socktype, ai->ai_protocol);
 		if (sockfd < 0) {
@@ -225,11 +231,6 @@ static int git_tcp_connect_sock(char *host, int flags)
 		}
 		if (connect(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
 			saved_errno = errno;
-			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
-				host,
-				cnt,
-				ai_name(ai),
-				strerror(saved_errno));
 			close(sockfd);
 			sockfd = -1;
 			continue;
@@ -242,11 +243,13 @@ static int git_tcp_connect_sock(char *host, int flags)
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
1.7.6.135.g8cdba
