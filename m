From: Dave Zarzycki <zarzycki@apple.com>
Subject: [PATCH] Do not log unless all connect() attempts fail
Date: Tue, 12 Jul 2011 09:28:34 -0700
Message-ID: <1EC2718A-A993-443C-8D7C-DEBD7C424EB9@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 18:29:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgfpf-0004Ze-Jc
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 18:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072Ab1GLQ3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 12:29:06 -0400
Received: from mail-out.apple.com ([17.151.62.50]:38650 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab1GLQ3F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 12:29:05 -0400
Received: from relay11.apple.com ([17.128.113.48])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPS id <0LO800EQVB2WSIZ0@mail-out.apple.com> for git@vger.kernel.org;
 Tue, 12 Jul 2011 09:28:36 -0700 (PDT)
X-AuditID: 11807130-b7c45ae000001381-b4-4e1c7605fcc1
Received: from jimbu (jimbu.apple.com [17.151.62.37])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay11.apple.com (Apple SCV relay)
 with SMTP id 70.A6.04993.5067C1E4; Tue, 12 Jul 2011 09:27:49 -0700 (PDT)
Received: from davez.apple.com (davez.apple.com [17.226.34.35])
 by cardamom.apple.com
 (Oracle Communications Messaging Exchange Server 7u4-20.01 64bit (built Nov 21
 2010)) with ESMTPSA id <0LO800D4XB3N1Q10@cardamom.apple.com> for
 git@vger.kernel.org; Tue, 12 Jul 2011 09:28:35 -0700 (PDT)
X-Mailer: Apple Mail (2.1244.3)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJMWRmVeSWpSXmKPExsUiON1OVZe1TMbP4MMdVYuuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGWcXlhYcJen4mjLAdYGxglcXYycHBICJhIP7vewQ9hiEhfurWfr
	YuTiEBJoZZI4sG0SE0iCV0BQ4sfkeyxdjBwczALyEgfPy4KEmQW0JL4/amWBqF/BJHHz0XOw
	ejYBDYlPp+4yg9jCAnYSC9aeZwSxWQRUJZ5uXgY100bizL35bCC2iIC4xNvjM6GOkJdY3PKZ
	cQIj7ywkq2chrJ6FZPUCRuZVjIJFqTmJlYaGeokFBTmpesn5uZsYQcHSUGiwg3HtT/5DjAIc
	jEo8vIWJMn5CrIllxZW5hxglOJiVRHhtjIFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZ/ZSvsJ
	CaQnlqRmp6YWpBbBZJk4OKUaGCeL98ox6+VOcOdm7F+1o+8Dcz3r089ZW1/NZo93X6BQW+XZ
	P/fZ0z/XHUwPN36ulEhwikpatp//5fIlPBFSxoFnKyoefHr7127StvhflUeK7fuVNS5O6fMq
	2RoT7xU6ufDyeZs9d//Zi/w+u+9gqEiP55tjaoKbAlaKTKvJeN9hrdLTKbEnVImlOCPRUIu5
	qDgRAIbXHEkSAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176946>

IPv6 hosts are often unreachable on the primarily IPv4 Internet and
therefore we shouldn't print an error if there are still other hosts we
can try to connect() to. This helps "git fetch --quiet" stay quiet.

Signed-off-by: Dave Zarzycki <zarzycki@apple.com>
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
1.7.6.135.g8cdba
