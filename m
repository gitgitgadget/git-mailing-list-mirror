From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 2/2] connect: only log if all attempts failed (ipv4)
Date: Mon,  1 Aug 2011 13:16:10 +0200
Message-ID: <1312197370-5112-2-git-send-email-kusmabite@gmail.com>
References: <1312197370-5112-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 13:16:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnqUE-0007Wh-NF
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 13:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab1HALQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 07:16:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47249 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab1HALQh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 07:16:37 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so4463078fxh.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 04:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zJxxSUwp0s+b3IcpaLks21wQzYHqFr31szRZ7xkzD2M=;
        b=qjUXeHfxE8j/xNkWbktTbo7NbpLg89cN4YywmsDo3UtSZjXZ4Ep+74ssNJgtDkfHaP
         sSTaRnZF9ncgHhX6kggoxqsoDLt2v9yqS2hTzCqenaoZqG9SlxkcaecyJLcSVtSJG/iq
         DOs6E6hvBk81j+g6m86MLUT9gzoy2LjPy2YjI=
Received: by 10.204.42.137 with SMTP id s9mr1127892bke.292.1312197396841;
        Mon, 01 Aug 2011 04:16:36 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id n11sm1284778bkd.47.2011.08.01.04.16.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 04:16:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g4db0d
In-Reply-To: <1312197370-5112-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178330>

In 63a995b (Do not log unless all connect() attempts fail), a
mechanism to only log connection errors if all attempts failed
was introduced for the IPv6 code-path, but not for the IPv4 one.

Introduce a matching mechanism so IPv4-users also benefit from
this noise-reduction.

Move the call to socket after filling in sa, to make it more
apparent that errno can't change in between.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 connect.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/connect.c b/connect.c
index d2ce57f..ee1d4b4 100644
--- a/connect.c
+++ b/connect.c
@@ -254,7 +254,8 @@ static int git_tcp_connect_sock(char *host, int flags)
  */
 static int git_tcp_connect_sock(char *host, int flags)
 {
-	int sockfd = -1, saved_errno = 0;
+	struct strbuf error_message = STRBUF_INIT;
+	int sockfd = -1;
 	const char *port = STR(DEFAULT_GIT_PORT);
 	char *ep;
 	struct hostent *he;
@@ -284,25 +285,21 @@ static int git_tcp_connect_sock(char *host, int flags)
 		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
 
 	for (cnt = 0, ap = he->h_addr_list; *ap; ap++, cnt++) {
-		sockfd = socket(he->h_addrtype, SOCK_STREAM, 0);
-		if (sockfd < 0) {
-			saved_errno = errno;
-			continue;
-		}
-
 		memset(&sa, 0, sizeof sa);
 		sa.sin_family = he->h_addrtype;
 		sa.sin_port = htons(nport);
 		memcpy(&sa.sin_addr, *ap, he->h_length);
 
-		if (connect(sockfd, (struct sockaddr *)&sa, sizeof sa) < 0) {
-			saved_errno = errno;
-			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
+		sockfd = socket(he->h_addrtype, SOCK_STREAM, 0);
+		if ((sockfd < 0) ||
+		    connect(sockfd, (struct sockaddr *)&sa, sizeof sa) < 0) {
+			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
 				host,
 				cnt,
 				inet_ntoa(*(struct in_addr *)&sa.sin_addr),
-				strerror(saved_errno));
-			close(sockfd);
+				strerror(errno));
+			if (0 <= sockfd)
+				close(sockfd);
 			sockfd = -1;
 			continue;
 		}
@@ -313,7 +310,7 @@ static int git_tcp_connect_sock(char *host, int flags)
 	}
 
 	if (sockfd < 0)
-		die("unable to connect a socket (%s)", strerror(saved_errno));
+		die("unable to connect to %s:\n%s", host, error_message.buf);
 
 	if (flags & CONNECT_VERBOSE)
 		fprintf(stderr, "done.\n");
-- 
1.7.6.347.g4db0d
