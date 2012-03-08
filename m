From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/5] daemon: move locate_host() to tcp lib
Date: Thu, 8 Mar 2012 07:06:29 -0600
Message-ID: <20120308130629.GC9426@burratino>
References: <20120308124857.GA7666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Wong <normalperson@yhbt.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 14:06:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5d3H-0003gC-Pt
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 14:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756939Ab2CHNGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 08:06:35 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44413 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab2CHNGe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 08:06:34 -0500
Received: by ghrr11 with SMTP id r11so150254ghr.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 05:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VE7UldIoEsoEE7C51BCnjJr4CJ3utBFpHPZ7B05hUHg=;
        b=hix7rPF2OtXoe0a93pBg27Eul+7msIrVTnPF9YBplgfyFbGmVNHKcoue4Jd+OAxyPo
         Eb8S7Qo5ZjtiU1ZfZQHM8FNxUC0XqW/1wjchg3L8lZrtXEXmjYwdLmPCZ2DGQjpmKPos
         XzBnSQTA+SvShY3XoS3TFw7UlMk/I8LwjBVerND8lPs4BW3n8otFN29jL+mX3QYnbFfv
         z4tA7D4g6M37tDOOwyzBmCNOtxI9LcUmbR8UPDXebwE7lC13D8H+Ribl748eIijKLGdf
         e/sgnbP/GWFcxa6heVajk0+CyWXYveI0iCWj5DGYHXZ/3i/hHETGjlw21ntVFMZQWiFD
         qi4w==
Received: by 10.60.29.72 with SMTP id i8mr2460591oeh.1.1331211993856;
        Thu, 08 Mar 2012 05:06:33 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id x5sm2511600obn.5.2012.03.08.05.06.32
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 05:06:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308124857.GA7666@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192592>

Date: Mon, 6 Jun 2011 04:39:29 -0500

Keep the different name resolution functions close together so they
can learn from each other and perhaps share code in the future.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
From http://thread.gmane.org/gmane.comp.version-control.git/175106/focus=175108

The original forgot to move HOST_NAME_MAX, causing build failures on systems
that lack it.

 Makefile |    2 +-
 daemon.c |   66 ++------------------------------------------------------------
 tcp.c    |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tcp.h    |    3 +++
 4 files changed, 63 insertions(+), 65 deletions(-)

diff --git a/Makefile b/Makefile
index 0d0ac31d..927a079a 100644
--- a/Makefile
+++ b/Makefile
@@ -2149,7 +2149,7 @@ builtin/prune.o builtin/reflog.o reachable.o: reachable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o url.o http-backend.o: url.h
-connect.o tcp.o: tcp.h
+connect.o daemon.o tcp.o: tcp.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h url.h
 
diff --git a/daemon.c b/daemon.c
index 2a9dfea0..3736fe53 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,14 +1,11 @@
 #include "cache.h"
 #include "pkt-line.h"
+#include "tcp.h"
 #include "exec_cmd.h"
 #include "run-command.h"
 #include "strbuf.h"
 #include "string-list.h"
 
-#ifndef HOST_NAME_MAX
-#define HOST_NAME_MAX 256
-#endif
-
 #ifndef NI_MAXSERV
 #define NI_MAXSERV 32
 #endif
@@ -441,65 +438,6 @@ static void parse_host_and_port(char *hostport, char **host,
 	}
 }
 
-#ifndef NO_IPV6
-
-static void locate_host(const char *hostname, char **ip_address,
-						char **canon_hostname)
-{
-	struct addrinfo hints;
-	struct addrinfo *ai;
-	int gai;
-	static char addrbuf[HOST_NAME_MAX + 1];
-	struct sockaddr_in *sin_addr;
-
-	memset(&hints, 0, sizeof(hints));
-	hints.ai_flags = AI_CANONNAME;
-
-	gai = getaddrinfo(hostname, NULL, &hints, &ai);
-	if (gai)
-		return;
-
-	sin_addr = (void *)ai->ai_addr;
-	inet_ntop(AF_INET, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
-	free(*ip_address);
-	*ip_address = xstrdup(addrbuf);
-
-	free(*canon_hostname);
-	*canon_hostname = xstrdup(ai->ai_canonname ?
-				  ai->ai_canonname : *ip_address);
-
-	freeaddrinfo(ai);
-}
-
-#else
-
-static void locate_host(const char *hostname, char **ip_address,
-						char **canon_hostname)
-{
-	struct hostent *hent;
-	struct sockaddr_in sa;
-	char **ap;
-	static char addrbuf[HOST_NAME_MAX + 1];
-
-	hent = gethostbyname(hostname);
-
-	ap = hent->h_addr_list;
-	memset(&sa, 0, sizeof sa);
-	sa.sin_family = hent->h_addrtype;
-	sa.sin_port = htons(0);
-	memcpy(&sa.sin_addr, *ap, hent->h_length);
-
-	inet_ntop(hent->h_addrtype, &sa.sin_addr,
-		  addrbuf, sizeof(addrbuf));
-
-	free(*canon_hostname);
-	*canon_hostname = xstrdup(hent->h_name);
-	free(*ip_address);
-	*ip_address = xstrdup(addrbuf);
-}
-
-#endif
-
 /*
  * Read the host as supplied by the client connection.
  */
@@ -539,7 +477,7 @@ static void parse_host_arg(char *extra_args, int buflen)
 	 * if possible.
 	 */
 	if (hostname)
-		locate_host(hostname, &ip_address, &canon_hostname);
+		git_locate_host(hostname, &ip_address, &canon_hostname);
 }
 
 
diff --git a/tcp.c b/tcp.c
index f5e1ab37..9263e0d2 100644
--- a/tcp.c
+++ b/tcp.c
@@ -1,6 +1,10 @@
 #include "cache.h"
 #include "run-command.h"
 
+#ifndef HOST_NAME_MAX
+#define HOST_NAME_MAX 256
+#endif
+
 #define STR_(s)	# s
 #define STR(s)	STR_(s)
 
@@ -47,6 +51,34 @@ static const char *ai_name(const struct addrinfo *ai)
 	return addr;
 }
 
+void git_locate_host(const char *hostname, char **ip_address,
+					char **canon_hostname)
+{
+	struct addrinfo hints;
+	struct addrinfo *ai;
+	int gai;
+	static char addrbuf[HOST_NAME_MAX + 1];
+	struct sockaddr_in *sin_addr;
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_flags = AI_CANONNAME;
+
+	gai = getaddrinfo(hostname, NULL, &hints, &ai);
+	if (gai)
+		return;
+
+	sin_addr = (void *)ai->ai_addr;
+	inet_ntop(AF_INET, &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
+	free(*ip_address);
+	*ip_address = xstrdup(addrbuf);
+
+	free(*canon_hostname);
+	*canon_hostname = xstrdup(ai->ai_canonname ?
+				  ai->ai_canonname : *ip_address);
+
+	freeaddrinfo(ai);
+}
+
 /*
  * Returns a connected socket() fd, or else die()s.
  */
@@ -111,6 +143,31 @@ static int git_tcp_connect_sock(char *host, int flags)
 
 #else /* NO_IPV6 */
 
+void git_locate_host(const char *hostname, char **ip_address,
+					char **canon_hostname)
+{
+	struct hostent *hent;
+	struct sockaddr_in sa;
+	char **ap;
+	static char addrbuf[HOST_NAME_MAX + 1];
+
+	hent = gethostbyname(hostname);
+
+	ap = hent->h_addr_list;
+	memset(&sa, 0, sizeof sa);
+	sa.sin_family = hent->h_addrtype;
+	sa.sin_port = htons(0);
+	memcpy(&sa.sin_addr, *ap, hent->h_length);
+
+	inet_ntop(hent->h_addrtype, &sa.sin_addr,
+		  addrbuf, sizeof(addrbuf));
+
+	free(*canon_hostname);
+	*canon_hostname = xstrdup(hent->h_name);
+	free(*ip_address);
+	*ip_address = xstrdup(addrbuf);
+}
+
 /*
  * Returns a connected socket() fd, or else die()s.
  */
diff --git a/tcp.h b/tcp.h
index 4de5f712..bed3cdca 100644
--- a/tcp.h
+++ b/tcp.h
@@ -1,6 +1,9 @@
 #ifndef TCP_H
 #define TCP_H
 
+extern void git_locate_host(const char *hostname,
+			char **ip_address, char **canon_hostname);
+
 extern int git_use_proxy(const char *host);
 extern void git_tcp_connect(int fd[2], char *host, int flags);
 extern struct child_process *git_proxy_connect(int fd[2], char *host);
-- 
1.7.9.2
